
INSERT INTO adres (ulica, nr_domu, kod_pocztowy, miasto) VALUES
('Podwale Staromiejskie', '1', '00-123', 'Warszawa'),
('Langewicza', '2B', '30-654', 'Kraków'),
('Opacka', '3', '80-111', 'Gdańsk'),
('Grunwaldcka', '4D', '60-222', 'Poznań'),
('Macierzy Szkolnej', '5', '50-333', 'Wrocław'),
('Kasztelana', '9', '80-132', 'Gdańsk');

INSERT INTO klient (id_adres, imie, nazwisko, nr_telefon) VALUES
(1, 'Anna', 'Kowalska', '654321987'),
(2, 'Jan', 'Nowak', '123789456'),
(3, 'Piotr', 'Wiśniewski', '987123654'),
(4, 'Maria', 'Wójcik', '321987654'),
(5, 'Tomasz', 'Kowalczyk', '654987321');

INSERT INTO agent (id_adres, imie, nazwisko, nr_telefon) VALUES
(5, 'Krzysztof', 'Krawczyk', '111222333'),
(4, 'Marta', 'Zielińska', '222333444'),
(3, 'Łukasz', 'Nowicki', '333444555'),
(2, 'Agnieszka', 'Lewandowska', '444555666'),
(1, 'Paweł', 'Kamiński', '555666777');

INSERT INTO wykluczenia (nazwa, opis) VALUES
('Działania umyślne', 'Szkody spowodowane umyślnym działaniem ubezpieczonego lub osób trzecich działających na zlecenie ubezpieczonego.'),
('Katastrofy naturalne', 'Wszelkie szkody powstałe w wyniku trzęsień ziemi, huraganów, powodzi i innych katastrof naturalnych.'),
('Uszkodzenia mechaniczne', 'Uszkodzenia powstałe w wyniku normalnego zużycia, konserwacji lub wad produkcyjnych.'),
('Użytkowanie niezgodne z przeznaczeniem', 'Szkody powstałe w wyniku używania ubezpieczonego mienia w sposób niezgodny z jego przeznaczeniem.'),
('Działania wojenne', 'Szkody wynikające z działań wojennych, aktów terroryzmu.');

INSERT INTO zakres_pokrycia (nazwa, opis) VALUES
('Pokrycie od nieszczęśliwych wypadków', 'Pokrycie kosztów leczenia i rehabilitacji w przypadku nieszczęśliwych wypadków'),
('Podstawowe pokrycie zdrowotne', 'Pokrycie podstawowych kosztów leczenia, w tym wizyty u lekarza, badania laboratoryjne i podstawowe procedury medyczne'),
('Pokrycie komunikacyjne', 'Kompleksowe pokrycie kosztów związanych z użytkowaniem pojazdu, w tym OC, AC, NNW'),
('Pokrycie majątkowe', 'Pokrycie szkód w mieniu, domu lub innych wartościowych przedmiotów, obejmuje we wszystkich sytuacjach, oprócz wykluczeń'),
('Pokrycie podróżne', 'Pokrycie kosztów leczenia za granicą, w tym transportu medycznego, a także koszty związane z odwołaniem lub opóźnieniem podróży, zgubieniem bagażu i innymi sytuacjami awaryjnymi podczas podróży');

INSERT INTO oferta_polisy (id_agent, typ_ubezpieczenia) VALUES
(1, 'Ubezpieczenie na życie'),
(2, 'Ubezpieczenie zdrowotne'),
(3, 'Ubezpieczenie samochodowe'),
(4, 'Ubezpieczenie domu'),
(5, 'Ubezpieczenie podróżne');

INSERT INTO wykluczenia_oferty (id_oferta, id_wykluczenia) VALUES
(1, 1), 
(2, 1), 
(3, 2), 
(3, 4),
(4, 2),
(4, 3), 
(5, 5);

INSERT INTO zakres_pokrycia_oferty  (id_oferta, id_zakres_pokrycia ) VALUES
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4),
(5, 5);

INSERT INTO obiekt_ubezpieczenia (id_polisa, nazwa, opis) VALUES
(1, 'Osoba', 'Jan Kowalski, praca: student, wiek: 20 lat'),
(2, 'Osoba', 'Anna Nowak, praca: brak, wiek: 35 lat'),
(3, 'Samochód', 'Osobowy samochód marki Toyota Rav 4, rok produkcji 2020, pojemnosc silnika: 1897 dm3.'),
(4, 'Dom jednorodzinny', 'Dom jednorodzinny o powierzchni 150 m², zlokalizowany w Warszawie'),
(5, 'Podróż', 'Podróż do Włoch, 14 dni, obejmuje ubezpieczenie zdrowotne i bagażowe');


INSERT INTO warunki_dodatkowe (id_polisa, nazwa, opis) VALUES
(1, 'Ubezpieczenie od następstw nieszczęśliwych wypadków', 'Dodatkowa ochrona na wypadek urazów ciała w wyniku nieszczęśliwych wypadków.'),
(2, 'Pokrycie kosztów leczenia za granicą', 'Ubezpieczenie zdrowotne obejmuje koszty leczenia za granicą do kwoty 100,000 PLN.'),
(3, 'Assistance drogowe', 'Usługa pomocy drogowej dostępna 24/7 w całej Polsce.'),
(4, 'Ochrona przed żywiołami', 'Rozszerzenie polisy domu o ochronę przed skutkami żywioł.'),
(5, 'Ubezpieczenie bagażu', 'Ochrona bagażu podczas podróży, obejmuje kradzież i uszkodzenie.');

INSERT INTO zakup (id_agent, id_klient, data_zakupu, kwota, ilosc) VALUES
(1, 1, '2024-05-01', 1500.00, 1),
(2, 2, '2024-05-02', 1750.00, 1),
(3, 3, '2024-05-03', 2200.00, 1),
(4, 4, '2024-05-04', 1300.00, 1),
(5, 5, '2024-05-05', 2300.00, 1);

INSERT INTO polisa (id_zakup, id_oferta_polisy, data_rozpoczecia, data_zakonczenia, skladka, pokrycie) VALUES
(1, 1, '2024-05-01', '2025-05-01', 1500.00, 500000.00),
(2, 2, '2024-05-02', '2025-05-02', 1750.00, 300000.00),
(3, 3, '2024-05-03', '2025-05-03', 2200.00, 100000.00),
(4, 4, '2024-05-04', '2025-05-04', 1300.00, 700000.00),
(5, 5, '2024-05-05', '2025-05-05', 2300.00, 400000.00);