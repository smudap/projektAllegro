# projekt Allegro - klasteryzacja ofert

## Instrukcja obsługi Allegro Web API

1. Aby móc korzystać z API trzeba założyć klucz API w ustawieniach konta na Allegro.
2. Łączenie z API w Pythonie odbywa się przez klasę AllegroWebAPI, w której trzeba podać login, hasło i klucz API. Do logowania używa się metody `sign_in_enc()`, która podczas logowania hashuje hasło, aby logowanie było "bezpieczne".
3. Po zalogowaniu do pobrania danych o książkach z kategorii `Książki obcojęzyczne` (id kategorii 91459) trzeba użyć metody `get_books_until_done()`, która przyjmuje za argumenty kwotę minimalną, kwotę maksymalną oraz ilość zwracanych elementów z przedziału cenowego co 25 groszy. Wyniki zapisywane są w słowniku z kluczem odpowiadającym id książki oraz wartością, która jest słownikiem z nazwą (`name`) oraz opisem aukcji w postaci kodu html (`description`).

## Pobrane dane

Dane zawierają 19851 książek z przedziału cenowego od 25zł do 55zł. Plik jest zapisany w formacie `*.pickle` i waży 245 MB.
[Link do danych na dropboxie](https://www.dropbox.com/s/sg01t535istxskk/list_dict.pickle?dl=0)

## UWAGA!

W tych danych mogą być niepolskie opisy, więc nie wiem jak algorytm zadziała. Możemy spróbować pobrać nowe dane dla kategorii `Literatura piękna, popularna i faktu` (id kategorii 79153). 