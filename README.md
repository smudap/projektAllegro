# projekt Allegro - klasteryzacja ofert

## Instrukcja obsługi Allegro Web API

1. Aby móc korzystać z API trzeba założyć klucz API w ustawieniach konta na Allegro.
2. Łączenie z API w Pythonie odbywa się przez klasę AllegroWebAPI, w której trzeba podać login, hasło i klucz API. Do logowania używa się metody `sign_in_enc()`, która podczas logowania hashuje hasło, aby logowanie było "bezpieczne".
3. Po zalogowaniu do pobrania danych o książkach z kategorii `Fantasy` (id kategorii 79156) trzeba użyć metody `get_books_until_done()`, która przyjmuje za argumenty kwotę minimalną, kwotę maksymalną oraz ilość zwracanych elementów w jednym zapytaniu, które jest powtarzane aż do pobrania wszystkich ofert z danego zakresu cenowego. Wyniki zapisywane są w słowniku z kluczem odpowiadającym id książki oraz wartością, która jest słownikiem z tytułem oferty (`title`).
Przy pomocy metody `transform_dict_to_DataFrame()` można słownik z wynikami zapisać w postaci `pandas.DataFrame`.

## Pobrane dane

Dane zawierają  ofert książek z kategorii `Fantasy`. Pliki:

- titles_books.csv - zwykły plik `*.csv` z tytułami ofert
- titles_books_DataFrame.pickle - plik `*.pickle` zawierający tytuły ofert w postaci pandas.DataFrame
- titles_books_dict.pickle - plik `*.pickle` zawierający tytuły ofert w postaci słownika

## Uwaga

Podczas zapisu do pliku `*.csv` należy w metodzie `pandas.DataFrame.to_csv()` ustawić parametr `encoding='utf-8'`.