
# coding: utf-8

# # Allegro Web API

# In[1]:

import hashlib
import base64
import time
import numpy as np
import pandas as pd
import pickle

from suds.client import Client, WebFault



class AllegroWebAPI:
    API_URL_sandbox = 'https://webapi.allegro.pl.webapisandbox.pl/service.php?wsdl'
    API_URL = 'https://webapi.allegro.pl/service.php?wsdl'
    country_code = 1 # 1 dla Polski, 56 dla Czech, 209 dla Ukrainy
 
    def __init__(self, login, password, api_key):
        self.login = login
        self.password_enc = base64.b64encode(hashlib.sha256(password.encode('utf-8')).digest()).decode()
        self.api_key = api_key
        self.client = Client(self.API_URL)
        self.service = self.client.service
        self.version_key = self.get_version_by_country_code()
        self.item_id_list = []
        self.item_dict = {}
        self.item_offset = 0
 
    def get_version_by_country_code(self):
        systems = self.service.doQueryAllSysStatus(**{
            'countryId': self.country_code,
            'webapiKey':self.api_key
        })[0]
 
        for sys in systems:
            if sys['countryId'] == self.country_code:
                return sys['verKey']
 
    def sign_in_enc(self):
        try:
            self.session_id = self.service.doLoginEnc(
                userLogin= self.login,
                userHashPassword = self.password_enc,
                countryCode = self.country_code,
                webapiKey = self.api_key,
                localVersion = self.version_key
            )
        except WebFault as e:
            print e
            
    def get_categories_tree(self):
        self.categories_tree = self.service.doGetCatsData(self.country_code, self.version_key, self.api_key)
    
    def get_books(self, filter_value_min=30, filter_value_max=31, result_size=200):
        
        table = {'price': {'filterValueRange': [filter_value_min, filter_value_max]},
                 'category': {'filterValueId': '79156'}
                }
        filtr_query = self.client.factory.create('ArrayOfFilteroptionstype')
        for i in range(len(table)):
            filtr = self.client.factory.create('FilterOptionsType')
            filtr.filterId = table.keys()[i]
            if 'filterValueId' in table.values()[i].keys():
                filtrAOS = self.client.factory.create('ArrayOfString')
                filtrAOS.item = table.values()[i].values()[0]
                filtr.filterValueId = filtrAOS
            if 'filterValueRange' in table.values()[i].keys():
                filtrRVT = self.client.factory.create('RangeValueType')
                filtrRVT.rangeValueMin = table.values()[i].values()[0][0]
                filtrRVT.rangeValueMax = table.values()[i].values()[0][1]
                filtr.filterValueRange = filtrRVT
            filtr_query.item.append(filtr)
            
        item_list = self.service.doGetItemsList(self.api_key, self.country_code, filtr_query, resultSize = result_size)
        
        while hasattr(item_list, "itemsList"):
            
            print time.strftime("%A, %H:%M:%S"), "Offset: ", self.item_offset

            for item in item_list.itemsList.item:
                item_id = item.itemId
                item_title = item.itemTitle
                if item_id not in self.item_dict.keys():
                    self.item_id_list.append(item_id)
                    self.item_dict[str(item_id)] = {'title': item_title}
            
            self.item_offset = len(self.item_id_list)
            item_list = self.service.doGetItemsList(self.api_key, self.country_code, filtr_query, 
                                                   resultSize = result_size, resultOffset = self.item_offset)
    
    def get_books_until_done(self, filter_value_min=30, filter_value_max=31, result_size=200):
        try:
            self.get_books(filter_value_min, filter_value_max, result_size)
        except WebFault as e:
            print 'Trying again after error'
            self.sign_in_enc()
            self.get_books_until_done(api.item_last_cost, filter_value_max, result_size)
    
    def get_top_n_books_query(self, query, filter_value_min=30, filter_value_max=31, top_n=200):
        
        self.item_top_n_id_list = []
        self.item_top_n_dict = {}        
        
        table = {'price': {'filterValueRange': [filter_value_min, filter_value_max]},
                 'category': {'filterValueId': '79156'},
                 'search': {'filterValueId': query.decode("utf8")}
                }
        
        filtr_query = self.client.factory.create('ArrayOfFilteroptionstype')
        for i in range(len(table)):
            filtr = self.client.factory.create('FilterOptionsType')
            filtr.filterId = table.keys()[i]
            if 'filterValueId' in table.values()[i].keys():
                filtrAOS = self.client.factory.create('ArrayOfString')
                filtrAOS.item = table.values()[i].values()[0]
                filtr.filterValueId = filtrAOS
            if 'filterValueRange' in table.values()[i].keys():
                filtrRVT = self.client.factory.create('RangeValueType')
                filtrRVT.rangeValueMin = table.values()[i].values()[0][0]
                filtrRVT.rangeValueMax = table.values()[i].values()[0][1]
                filtr.filterValueRange = filtrRVT
            filtr_query.item.append(filtr)
            
        sort_query = self.client.factory.create('SortOptionsType')
        sort_query.sortType = 'relevance'
        sort_query.sortOrder = 'desc'
        
        item_list = self.service.doGetItemsList(self.api_key, self.country_code, filtr_query, sort_query, resultSize = top_n)
        
        if hasattr(item_list, "itemsList"):
            for item in item_list.itemsList.item:
                item_id = item.itemId
                item_title = item.itemTitle
                if item_id not in self.item_dict.keys():
                    self.item_top_n_id_list.append(item_id)
                    self.item_top_n_dict[str(item_id)] = {'title': item_title}
        else:
            print "Result of query is empty."
    
    def transform_dict_to_DataFrame(self, top_n = False):
        if top_n:
            df = pd.DataFrame(self.item_top_n_dict)
            df = df.transpose()
            self.item_top_n_DataFrame = df
        else:
            df = pd.DataFrame(self.item_dict)
            df = df.transpose()
            self.item_DataFrame = df


# In[5]:
