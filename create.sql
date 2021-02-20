



CREATE TABLE Lekarze(Id_lekarza VARCHAR(12) PRIMARY KEY,
CONSTRAINT poprawne_id_lek CHECK(Id_lekarza LIKE '[L][_]%'),
Imie VARCHAR(40) NOT NULL,
CONSTRAINT poprawne_imie_lek CHECK(Imie NOT LIKE '%[0-9]%'),
Nazwisko VARCHAR(40) NOT NULL,
CONSTRAINT poprawne_nazwisko_lek CHECK( Nazwisko NOT LIKE '%[0-9]%'),
Staz_pracy_ogolnie VARCHAR(5) NOT NULL,
CONSTRAINT poprawny_staz_o CHECK(Staz_pracy_ogolnie LIKE '[0-9][0-9]-[01][0-9]'),
Staz_pracy_w_lecznicy VARCHAR(5) NOT NULL,
CONSTRAINT poprawny_staz CHECK(Staz_pracy_w_lecznicy LIKE '[0-9][0-9]-[01][0-9]')
);




CREATE TABLE Choroby(Nazwa VARCHAR(100) PRIMARY KEY,
Mozliwosc_leczenia VARCHAR(3) NOT NULL,
CONSTRAINT poprawna_m_l CHECK(Mozliwosc_leczenia = 'Tak' or Mozliwosc_leczenia = 'Nie'));

CREATE TABLE Rasy(Rasa VARCHAR (100) PRIMARY KEY,
Nazwa_gatunku VARCHAR(100) NOT NULL);

CREATE TABLE Zwierzeta(Id_zwierzecia VARCHAR(12) PRIMARY KEY,
CONSTRAINT poprawne_id_z CHECK (Id_zwierzecia LIKE '[Z][_]%'),
Imie VARCHAR(40) NOT NULL,
CONSTRAINT poprawne_imie_z CHECK(Imie NOT LIKE '%[0-9]%'),
Data_urodzenia DATE NOT NULL,
CONSTRAINT poprawna_data_u CHECK (Data_urodzenia LIKE '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]'),
Plec VARCHAR(1) NOT NULL,
CONSTRAINT poprawna_plec CHECK(Plec = 'K' or Plec = 'M'),
Data_zgonu DATE,
CONSTRAINT poprawna_data_z CHECK (Data_zgonu LIKE '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]' and (Data_zgonu = NULL or Data_zgonu > Data_urodzenia)),
Rasa VARCHAR(100) NOT NULL REFERENCES Rasy  ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Wizyty(Id_wizyty VARCHAR(12) PRIMARY KEY,
CONSTRAINT poprawne_id_w CHECK (Id_wizyty LIKE '[W][_]%'),
Data_wizyty DATE NOT NULL,
CONSTRAINT poprawna_data_w CHECK (Data_wizyty LIKE '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]'),
Powod_wizyty VARCHAR(150) NOT NULL, 
Czas_trwania VARCHAR(5) NOT NULL,
CONSTRAINT poprawny_czas_w CHECK(Czas_trwania LIKE '[0-9][0-9]:[0-9][0-9]'),
Rodzaj_badania VARCHAR(15) NOT NULL,
CONSTRAINT poprawny_rodzaj_badania CHECK (Rodzaj_badania = 'podstawowe' or Rodzaj_badania = 'specjalistyczne'),
Lekarz_prowadzacy VARCHAR(12) NOT NULL REFERENCES Lekarze,
Id_pacjenta VARCHAR(12) NOT NULL REFERENCES Zwierzeta  ON UPDATE CASCADE ON DELETE CASCADE);


CREATE TABLE Zabiegi(Nazwa VARCHAR(100) , 
Id_wizyty VARCHAR(12)  REFERENCES Wizyty  ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY(Nazwa,Id_wizyty),
Czas_trwania VARCHAR(5) NOT NULL,
CONSTRAINT poprawny_czas_z CHECK(Czas_trwania LIKE '[0-9][0-9]:[0-9][0-9]'),
Czy_sukces VARCHAR (3) NOT NULL,
CONSTRAINT poprawny_sukces CHECK(Czy_sukces = 'Tak' or Czy_sukces = 'Nie'),
Lekarz_prowadzacy VARCHAR(12) NOT NULL REFERENCES Lekarze,

);
CREATE TABLE Wykrycia_chorob(Nazwa_choroby VARCHAR(100) REFERENCES Choroby ON UPDATE CASCADE,
Id_wizyty VARCHAR(12) REFERENCES Wizyty  ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY(Nazwa_choroby, Id_wizyty));

CREATE TABLE Recepty(Nr_recepty DECIMAL(22,0) PRIMARY KEY,
Data_wystawienia DATE NOT NULL,
CONSTRAINT poprawna_data_wystawienia CHECK (Data_wystawienia LIKE '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]'),
Data_waznosci DATE NOT NULL,
CONSTRAINT poprawna_data_waznosci CHECK (Data_waznosci LIKE '[12][0-9][0-9][0-9]-[01][0-9]-[0-3][0-9]' and  (Data_waznosci > Data_wystawienia)),
Rodzaj_recepty VARCHAR(13) NOT NULL,
CONSTRAINT poprawny_rodzaj CHECK(Rodzaj_recepty = 'elektroniczna' or Rodzaj_recepty = 'papierowa'),
Id_wizyty VARCHAR(12) NOT NULL REFERENCES Wizyty  ON UPDATE CASCADE ON DELETE CASCADE);

CREATE TABLE Medykamenty
(
Nazwa VARCHAR(100) ,
Forma_stosowania VARCHAR(100)
PRIMARY KEY(Nazwa, Forma_stosowania)
);

CREATE TABLE Pozycje_na_recepcie
(Nr_recepty DECIMAL(22,0) REFERENCES Recepty  ON UPDATE CASCADE ON DELETE CASCADE,
Lp INT,
CONSTRAINT poprawna_lp CHECK(Lp>0 AND Lp <= 5),
PRIMARY KEY(Nr_recepty, Lp),
Ilosc INT NOT NULL,
CONSTRAINT poprawna_ilosc CHECK(Ilosc > 0 AND Ilosc <= 50),
Dawkowanie VARCHAR(40) NOT NULL,
Nazwa_medykamentu VARCHAR(100) NOT NULL,
Forma_stosowania_medykamentu VARCHAR(100) NOT NULL, 
CONSTRAINT Medykament FOREIGN KEY(Nazwa_medykamentu,Forma_stosowania_medykamentu) REFERENCES Medykamenty(Nazwa, Forma_stosowania) ON UPDATE CASCADE ON DELETE CASCADE

);
CREATE TABLE Wlasciciele
(
Pesel BIGINT PRIMARY KEY,
CONSTRAINT poprawny_pesel CHECK(LEN(Pesel)=11),
Imie VARCHAR(40) NOT NULL,
CONSTRAINT poprawne_imie_w  CHECK(Imie NOT LIKE '%[0-9]%'),
Nazwisko VARCHAR(40) NOT NULL,
CONSTRAINT poprawne_nazwisko_w CHECK(Nazwisko NOT LIKE '%[0-9]%'),
Nr_kontaktowy INT NOT NULL UNIQUE,
CONSTRAINT poprawny_nr CHECK(LEN(Nr_kontaktowy)=9),
Adres_email VARCHAR(255) UNIQUE
CONSTRAINT poprawny_mail CHECK(Adres_email LIKE '%@%.%' )
);

CREATE TABLE Przynaleznosci_ZW
(
Pesel_wlasciciela BIGINT REFERENCES Wlasciciele ON DELETE CASCADE,
Id_zwierzecia VARCHAR(12) REFERENCES Zwierzeta ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY(Pesel_wlasciciela, Id_zwierzecia)
);

GO 
CREATE TRIGGER UsuwanieLek
ON Lekarze
Instead of DELETE
AS BEGIN
SET NOCOUNT ON
DELETE FROM Zabiegi  Where Lekarz_prowadzacy IN (SELECT Id_lekarza FROM deleted)
DELETE FROM Wizyty Where Lekarz_prowadzacy IN (SELECT  Id_lekarza FROM deleted)
DELETE FROM Lekarze Where Id_lekarza IN (SELECT Id_lekarza FROM deleted)
END

GO 
CREATE TRIGGER ZmianaLek
ON Lekarze
Instead of UPDATE
AS BEGIN
SET NOCOUNT ON
DECLARE @ID VARCHAR(12)
SET @ID =(SELECT Id_lekarza FROM inserted)
DECLARE @Imie VARCHAR(40)
SET @Imie = (SELECT Imie FROM Lekarze WHERE Id_lekarza in (Select Id_lekarza FROM deleted))
DECLARE @Nazwisko VARCHAR(40)
SET @Nazwisko = (SELECT Nazwisko FROM Lekarze WHERE Id_lekarza in (Select Id_lekarza FROM deleted))
DECLARE @Staz_o VARCHAR(5)
SET @Staz_o = (SELECT Staz_pracy_ogolnie FROM Lekarze WHERE Id_lekarza in (Select Id_lekarza FROM deleted))
DECLARE @Staz_l VARCHAR(5)
SET @Staz_l = (SELECT Staz_pracy_w_lecznicy FROM Lekarze WHERE Id_lekarza in (Select Id_lekarza FROM deleted))
INSERT INTO Lekarze Values(@ID, @Imie, @Nazwisko, @Staz_o, @Staz_l )
UPDATE Wizyty SET Lekarz_prowadzacy = (SELECT Id_lekarza FROM inserted) Where Lekarz_prowadzacy IN (SELECT Id_lekarza FROM deleted) 
UPDATE Zabiegi SET Lekarz_prowadzacy = (SELECT Id_lekarza FROM inserted) Where Lekarz_prowadzacy IN (SELECT Id_lekarza FROM deleted) 
Delete Lekarze WHERE Id_lekarza = (SELECT Id_lekarza FROM deleted)
END

GO
CREATE TRIGGER NaduzaL
ON Lekarze
AFTER INSERT, UPDATE 
AS 
BEGIN
    UPDATE Lekarze
    SET Imie = UPPER(SUBSTRING(Imie, 1, 1)) + LOWER(SUBSTRING(Imie, 2, LEN(Imie)-1)),
	   Nazwisko = UPPER(SUBSTRING(Nazwisko, 1, 1)) + LOWER(SUBSTRING(Nazwisko, 2, LEN(Nazwisko)-1)),     
	   Id_lekarza =  UPPER(SUBSTRING(Id_lekarza, 1, 1)) + (SUBSTRING(Id_lekarza, 2, LEN(Id_lekarza)-1))
END

GO
CREATE TRIGGER NaduzaZ
ON Zwierzeta
AFTER INSERT, UPDATE
AS 
BEGIN
    UPDATE Zwierzeta
    SET Imie = UPPER(SUBSTRING(Imie, 1, 1)) + LOWER(SUBSTRING(Imie, 2, LEN(Imie)-1)),
        Id_zwierzecia =  UPPER(SUBSTRING(Id_zwierzecia, 1, 1)) + (SUBSTRING(Id_zwierzecia, 2, LEN(Id_zwierzecia)-1))
    
END
GO
CREATE TRIGGER NaduzaWizyty
ON Wizyty
AFTER INSERT, UPDATE
AS 
BEGIN
    UPDATE Wizyty
    SET Id_wizyty =  UPPER(SUBSTRING(Id_wizyty, 1, 1)) + (SUBSTRING(Id_wizyty, 2, LEN(Id_wizyty)-1))
    
END
GO
CREATE TRIGGER NaduzaW
ON Wlasciciele
AFTER INSERT, UPDATE 
AS 
BEGIN
    UPDATE Wlasciciele
    SET Imie = UPPER(SUBSTRING(Imie, 1, 1)) + LOWER(SUBSTRING(Imie, 2, LEN(Imie)-1)),
        Nazwisko = UPPER(SUBSTRING(Nazwisko, 1, 1)) + LOWER(SUBSTRING(Nazwisko, 2, LEN(Nazwisko)-1))
    
    
END
