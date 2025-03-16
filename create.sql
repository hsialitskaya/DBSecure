CREATE TABLE adres (
  id_adres  SERIAL PRIMARY KEY,
  ulica VARCHAR(50) NOT NULL,
  nr_domu VARCHAR(8)  NOT NULL,
  kod_pocztowy CHAR(6) NOT NULL CHECK(CHAR_LENGTH(kod_pocztowy)=6),
  miasto VARCHAR(30) NOT NULL CHECK(CHAR_LENGTH(miasto)>1)
                                    
);


CREATE TABLE agent (
  id_agent  SERIAL PRIMARY KEY,
  id_adres  INT, 
  imie  VARCHAR(15) NOT NULL,
  nazwisko VARCHAR(20) NOT NULL,
  nr_telefon VARCHAR(16)
);

CREATE TABLE klient (
  id_klient  SERIAL PRIMARY KEY,
  id_adres  INT, 
  imie  VARCHAR(15) NOT NULL,
  nazwisko VARCHAR(20) NOT NULL,
  nr_telefon VARCHAR(16)

);

CREATE TABLE wykluczenia (
  id_wykluczenia SERIAL PRIMARY KEY,
  nazwa VARCHAR(100) NOT NULL,
  opis TEXT
);

CREATE TABLE zakres_pokrycia (
  id_zakres_pokrycia SERIAL PRIMARY KEY,
  nazwa VARCHAR(100) NOT NULL,
  opis TEXT
);

CREATE TABLE oferta_polisy (
  id_oferta_polisy SERIAL PRIMARY KEY,
  id_agent INT,
  typ_ubezpieczenia VARCHAR(100) NOT NULL
);

CREATE TABLE wykluczenia_oferty (
  id_wykluczenia INT,
  id_oferta INT,
  PRIMARY KEY (id_wykluczenia, id_oferta)
);

CREATE TABLE zakres_pokrycia_oferty (
  id_oferta INT,
  id_zakres_pokrycia INT,
  PRIMARY KEY (id_oferta, id_zakres_pokrycia)
);

CREATE TABLE polisa (
  id_polisa SERIAL PRIMARY KEY,
  id_zakup INT,
  id_oferta_polisy INT,
  data_rozpoczecia DATE NOT NULL DEFAULT CURRENT_DATE,
  data_zakonczenia     DATE ,
  skladka   NUMERIC,
  pokrycie NUMERIC
);

CREATE TABLE obiekt_ubezpieczenia (
  id_obiekt_ubezpieczenia  SERIAL PRIMARY KEY,
  id_polisa  INT, 
  nazwa VARCHAR(100) NOT NULL,
  opis TEXT
);


CREATE TABLE warunki_dodatkowe (
  id_warunki_dodatkowe  SERIAL PRIMARY KEY,
  id_polisa  INT, 
  nazwa VARCHAR(100) NOT NULL,
  opis TEXT
);

CREATE TABLE zakup (
  id_zakup  SERIAL PRIMARY KEY,
  id_agent  INT, 
  id_klient  INT,
  data_zakupu DATE NOT NULL DEFAULT CURRENT_DATE,
  kwota NUMERIC,
  ilosc INT
);
