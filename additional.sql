
--1a) Tworzymy 3 widoki

CREATE VIEW klienci_ktorzy_wydali_powyzej_1500 AS
SELECT k.imie, k.nazwisko, sum(z.kwota) from klient k
join zakup z on k.id_klient=z.id_klient
group by k.id_klient, k.imie, k.nazwisko
HAVING sum(z.kwota)> 1500
order by sum(z.kwota) desc;

CREATE VIEW agent_klienta AS
SELECT k.nazwisko as nazwisko_klienta,
k.imie as imie_klienta,
a.nazwisko as nazwisko_agenta,
a.imie as imie_agenta
from klient k
join zakup z on k.id_klient=z.id_klient
join agent a on z.id_agent=a.id_agent
order by nazwisko_klienta, imie_klienta;

CREATE VIEW klienci_z_gdansku AS
SELECT k.nazwisko, k.imie , a.miasto
from klient k
join adres a on k.id_adres = a.id_adres
where a.miasto = 'Gdańsk'
order by k.nazwisko, k.imie ;


--1b) Sprawdzenie, że widoki działają

SELECT * from klienci_ktorzy_wydali_powyzej_1500;

SELECT * from agent_klienta;

SELECT * from klienci_z_gdansku;

--2a) Tworzymy funkcję 1

CREATE FUNCTION nr_telefonu_klienta(INT) RETURNS INT AS
$$
BEGIN
Return nr_telefon FROM klient
WHERE id_klient=$1;
END;
$$ LANGUAGE 'plpgsql';

--2b) Sprawdzenie, że funkcja 1 działa

SELECT nr_telefonu_klienta(3) AS nr_tel;

--3a) Tworzymy funkcję 2

CREATE FUNCTION ile_zakupow(data_od date, data_do date) RETURNS INT AS
$$
BEGIN
Return (SELECT COUNT(*) FROM zakup
WHERE data_zakupu BETWEEN data_od and data_do
       );
END;
$$ LANGUAGE 'plpgsql';

--3b) Sprawdzenie, że funkcja 2 działa

SELECT ile_zakupow('2024-05-02','2024-05-03') AS ile_zak;

--4a) Tworzymy procedurę 1

CREATE or REPLACE FUNCTION dodaj_agenta(
  dodany_adres int,
  dodane_nazwisko VARCHAR(20),
  dodane_imie VARCHAR(15),
  dodany_telefon VARCHAR(16)
  )
RETURNS void AS
$$
BEGIN
	INSERT into agent(id_adres,nazwisko,imie,nr_telefon) VALUES(
      dodany_adres,
      dodane_nazwisko,
	  dodane_imie,
      dodany_telefon
      );
END;
$$ LANGUAGE 'plpgsql';  

--4b) Sprawdzenie, że procedura 1 działa

select dodaj_agenta(6, 'Kowalski', 'Andrzej' ,'543123456');
select * from agent

--5a) Tworzymy procedurę 2

CREATE FUNCTION wypisz_polisy_ze_skladka_wieksza_niz(min_skladka int)
RETURNS SETOF polisa AS
$$
BEGIN
RETURN QUERY
SELECT * FROM polisa WHERE skladka>min_skladka ;
END;
$$ LANGUAGE 'plpgsql';                             

--5b) Sprawdzenie, że procedura 2 działa

select wypisz_polisy_ze_skladka_wieksza_niz(1500);

--6a) Tworzymy wyzwalacz 1

CREATE OR REPLACE FUNCTION sprawdz_date_rozpoczecia()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_rozpoczecia > CURRENT_DATE THEN
        RAISE EXCEPTION 'Data rozpoczęcia nie może być większa niż dzisiejsza data';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER data_rozpoczecia
BEFORE UPDATE OF data_rozpoczecia ON polisa
FOR EACH ROW
EXECUTE FUNCTION sprawdz_date_rozpoczecia();

--6b) Sprawdzenie, że wyzwalacz 1 działa

UPDATE polisa set data_rozpoczecia ='2034-01-06' where id_zakup=1

--7a) Tworzymy wyzwalacz 2

CREATE OR REPLACE FUNCTION data_rozpoczecia_mniejsza_od_daty_zakonczenia()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.data_rozpoczecia > NEW.data_zakonczenia THEN
        RAISE EXCEPTION 'Data rozpoczęcia nie może być większa niz data zakończenia';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER wstawianie_daty
BEFORE INSERT ON polisa
FOR EACH ROW
EXECUTE FUNCTION data_rozpoczecia_mniejsza_od_daty_zakonczenia();

--7b) Sprawdzenie, że wyzwalacz 2 działa

INSERT into polisa(id_zakup,data_rozpoczecia,data_zakonczenia) values(4, '2024-04-20', '2024-04-19')

--8a) Tworzymy wyzwalacz 3

CREATE OR REPLACE FUNCTION zamien_usuwany_adres_na_NULL()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE agent
    SET id_adres = NULL
    WHERE id_adres = OLD.id_adres;

    UPDATE klient
    SET id_adres = NULL
    WHERE id_adres = OLD.id_adres;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER usuwanie_adresu
BEFORE DELETE ON adres
FOR EACH ROW
EXECUTE FUNCTION zamien_usuwany_adres_na_NULL();

--8b) Sprawdzenie, że wyzwalacz 3 działa

delete from adres where id_adres=1
select * from klient

--9a) Tworzymy wyzwalacz 4

CREATE OR REPLACE FUNCTION ustaw_opis_nie_podany()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.opis IS NULL OR NEW.opis = '' THEN
        NEW.opis := 'Opis nie został podany';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER zamien_pusty_opis_wykluczenia
BEFORE INSERT OR UPDATE ON wykluczenia
FOR EACH ROW
EXECUTE FUNCTION ustaw_opis_nie_podany();

--9b) Sprawdzenie, że wyzwalacz 4 działa

INSERT into wykluczenia(nazwa) values ('Samodzielne szkody');
SELECT * from wykluczenia

--10a) Tworzymy 2 kursory

CREATE OR REPLACE FUNCTION wylicz_srednia_cene_zakupu()
RETURNS TABLE (id_zakup INT, srednia_cena NUMERIC) AS
$$
DECLARE
    zakup_record RECORD;
    zakup_cursor CURSOR FOR SELECT * FROM zakup;
BEGIN
    OPEN zakup_cursor;
    LOOP
        FETCH zakup_cursor INTO zakup_record;
        EXIT WHEN NOT FOUND;

        IF zakup_record.ilosc > 0 THEN
            srednia_cena := zakup_record.kwota / zakup_record.ilosc;
            id_zakup := zakup_record.id_zakup;
            RETURN NEXT;
        END IF;
    END LOOP;

    CLOSE zakup_cursor;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION wylicz_pozostale_dni_terminu()
RETURNS TABLE (id_polisa INT,data_rozpoczecia date, pozostale_dni INT) AS
$$
DECLARE
    polisa_record RECORD;
    polisa_cursor CURSOR FOR SELECT * FROM polisa;
BEGIN
    OPEN polisa_cursor;
    LOOP
        FETCH polisa_cursor INTO polisa_record;
        EXIT WHEN NOT FOUND;

        IF polisa_record.data_zakonczenia IS NOT NULL THEN
        	data_rozpoczecia := polisa_record.data_rozpoczecia;
            pozostale_dni := polisa_record.data_zakonczenia - CURRENT_DATE;
            id_polisa := polisa_record.id_polisa;
            RETURN NEXT;
        END IF;
    END LOOP;

    CLOSE polisa_cursor;
END;
$$ LANGUAGE plpgsql;
--10b) Sprawdzenie, że kursory działają

SELECT * FROM wylicz_srednia_cene_zakupu();

SELECT * FROM wylicz_pozostale_dni_terminu();