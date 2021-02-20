



--w celach statystycznych ile wizyt danej rasy odby�o si� w danym roku, ile wizyt odby�o si� w danym roku wszystkich ras,
--dodatkowo ile by�o wizyt poszczeg�lnych ras  lecznicy ��cznie oraz ile by�o ��cznie wszystkich wizyt w lecznicy
SELECT YEAR(Data_wizyty) AS Rok, Rasa, Count(*) AS Ilosc_wizyt
FROM (Wizyty W JOIN Zwierzeta Z ON W.Id_pacjenta = Z.Id_zwierzecia)
GROUP BY CUBE (YEAR(Data_wizyty), Rasa)
ORDER BY YEAR(Data_wizyty) DESC,  Rasa DESC ;

--wyswietlamy nazwisko, id wizyty wlasciciela, imie zwierzecia oraz nazw� choroby, dla zwierzat,
--u kt�rych wykryto chorob� pomi�dzy rokiem 2010 a 2013, kt�rej nie mo�na wyleczy� w klinice 
SELECT Wi.Id_wizyty,W.Nazwisko, Z.Imie, Ch.Nazwa
FROM (((((Wlasciciele W
       Join Przynaleznosci_ZW P on W.Pesel =P.Pesel_wlasciciela)
	    Join Zwierzeta Z on P.Id_zwierzecia = Z.Id_zwierzecia)
		Join Wizyty Wi on Wi.Id_pacjenta = P.Id_zwierzecia)
		Join Wykrycia_chorob Wch on Wch.Id_wizyty = Wi.Id_wizyty)
		Join Choroby Ch on Wch.Nazwa_choroby = Ch.Nazwa)
		WHERE Ch.Mozliwosc_leczenia='Nie' AND  YEAR(Data_wizyty) BETWEEN 2010 AND 2013;


--wyswietlamy id oraz nazwisko lekarza  i ilosc zabiegow ktore zakonczyly si� sukcesem wykonywanych 
--na koniach lub psach (chcemy wiedziec kt�rzy z lekarzy s� skuteczni w wykonywaniu zabieg�w na tych gatunkach ) 
SELECT Id_lekarza, Nazwisko, Count(*) Ilosc_udanych_zabiegow
FROM ((((Lekarze L 
	Join Zabiegi Zb on Zb.Lekarz_prowadzacy=L.Id_lekarza)
	Join Wizyty Wi on Wi.Id_wizyty=Zb.Id_wizyty)
	Join Zwierzeta Z on Z.Id_zwierzecia = Wi.Id_pacjenta)
	Join Rasy R on R.Rasa=Z.Rasa)
	Where R.Nazwa_gatunku IN('Pies', 'Ko�') AND Zb.Czy_sukces='Tak'
	GROUP BY Id_lekarza, Nazwisko
	Order by Ilosc_udanych_zabiegow DESC ;

-- wsywietlamy nazwe medykamentow oraz dawkowanie medykament�w przepisanych na kamienie nerkowe zwierzakom kt�re nie sko�czy�y jeszcze 4 lat 
--(jaki medykament i dawkowanie przepisywane s� m�odym zwierzakom na kamienie nerkowe)
SELECT Distinct Nazwa_medykamentu, Dawkowanie
FROM ((((Pozycje_na_recepcie Poz 
	Join Recepty R on R.Nr_recepty=Poz.Nr_recepty)
	Join Wizyty Wi on Wi.Id_wizyty=R.Id_wizyty)
	Join Wykrycia_chorob Wch on Wch.Id_wizyty=Wi.Id_wizyty)
	Join Zwierzeta Z on Wi.Id_pacjenta = Z.Id_zwierzecia)
	Where Wch.Nazwa_choroby='Kamienie nerkowe'  AND DATEDIFF(Year, Z.Data_urodzenia, Wi.Data_wizyty) < 4;





	--chcemy dowiedzie� si� kt�ry lekarz przeprowadzi� najwi�cej wizyt w ci�gu ostatnich 5 lat
	With IleWizyt (Id_lekarza, Ile_wizyt) AS
	(SELECT Id_lekarza, Count(*) FROM Lekarze  Join Wizyty Wi on Id_lekarza = Wi.Lekarz_prowadzacy
	 	 Where DATEDIFF(Year, Data_wizyty, Getdate()) <=5 
	GROUP BY Id_lekarza)
	
	SELECT Id_lekarza, Imie, Nazwisko
	FROM Lekarze 
	Where Id_lekarza IN
	(
	SELECT Id_lekarza
	FROM IleWizyt WHERE Ile_wizyt = (SELECT  MAX(Ile_wizyt)  FROM IleWizyt)
	);







-- wyswietl kontakt do wszystkich w�a�cicieli zwierz�t, kt�rym przepisano lek Aptobalance na receptach, kt�rych data wa�no�ci nie min�a, 
--chcemy poinformowa� tych w�a�cicieli o wprowdzonym na rynek ta�szym zamienniku leku, dodatkowo wyswietl id zwierzecia (jedno zwierze moze miec wielu wlascicieli, 
--wi�c, �eby nie dzwonic do roznych wlascicieli tego samego zwierzecia)
	SELECT Nr_kontaktowy,  Id_zwierzecia
	FROM (Wlasciciele Join Przynaleznosci_ZW on Przynaleznosci_ZW.Pesel_wlasciciela = Wlasciciele.Pesel)
	Where Pesel In
	(SELECT Pesel FROM (((((Wlasciciele W Join Przynaleznosci_ZW P on W.Pesel = P.Pesel_wlasciciela)
	Join Zwierzeta Z on Z.Id_zwierzecia = P.Id_zwierzecia)
	Join Wizyty Wi on Wi.Id_pacjenta = Z.Id_zwierzecia)
	Join Recepty R on R.Id_wizyty = Wi.Id_wizyty)
	Join Pozycje_na_recepcie Poz on Poz.Nr_recepty = R.Nr_recepty)
	Where Poz.Nazwa_medykamentu = 'Aptobalance' AND R.Data_waznosci>Getdate())
	Order by Id_zwierzecia;

	

	--- wyswietlamy imiona i nazwiska wlascicieli(nie chcemy pokazywac peseli) i imiona i rasy zwierzat(nie chcemy pokazywa� id zwierzecia) oraz informacje czy zwierz� jeszcze zyje
	--- tworzymy widok ktory da nam informacje ktory wlasciciel posiada jakie zwierze

	CREATE VIEW Przynaleznosci
	(Imie_wlasciciela, Nazwisko_Wlasciciela, Imie_zwierzecia, Rasa_zwierzecia, Czy_zwierze_zyje)
	As Select W.Imie, W.Nazwisko, Z.Imie, Z.Rasa, Case  When Z.Data_zgonu is NULL Then 'Tak'  else 'Nie' END 
	FROM ((Wlasciciele W Join Przynaleznosci_ZW P  on W.Pesel = P.Pesel_wlasciciela)
	Join Zwierzeta Z on Z.Id_zwierzecia = P.Id_zwierzecia);

	--- pokazmy przynaleznosci zyjacych zwierzat do wlascicieli 
	Select Imie_wlasciciela, Nazwisko_Wlasciciela, Imie_zwierzecia, Rasa_zwierzecia From Przynaleznosci Where Czy_zwierze_zyje = 'Tak';

	DROP VIEW Przynaleznosci;

	--chcemy dowiedziec si�, ktora z chorob, ktorej nie ma mozliwosci leczenia w klinice byla wykrywana najczesciej,
	--�eby zatrudni� nowego lekarza i dokupi� sprz�t, tak, by mo�na by�o j� leczy�


	With Ile (Nazwa, Ile_wykryc) AS
	(SELECT Nazwa, Count (*) AS Ile_wykryc FROM Choroby Ch join Wykrycia_chorob Wch on Ch.Nazwa = Wch.Nazwa_choroby
	WHERE Ch.Mozliwosc_leczenia='Nie' GROUP BY Nazwa)
	
	SELECT Ile.Nazwa FROM Ile
	Where Ile_wykryc = (Select Max(Ile_wykryc) from Ile);




	-- chcemy wyswietlic zestawienie wszystkich lekarzy pokazuj�ce ile zabieg�w oni wykonali, ile z nich bylo udanych, ile nieudanych, uwzgl�dniaj�c lekarzy, 
	--kt�rzy nie wykonali �adnych zabieg�w, lekarze, kt�rzy nie wykonali �adnych zabieg�w powinni wykona� kolejne zabiegi pod nadzorem os�b bardziej do�wiadczonych
	
	CREATE VIEW IleUdanych
	(Id_lekarza,Imie, Nazwisko, Ile_udanych)
	AS SELECT L.Id_lekarza, L.Nazwisko, L.Imie, COUNT (*) 
	FROM (Lekarze L Join Zabiegi Z on L.Id_lekarza = Z.Lekarz_prowadzacy)
	Where Z.Czy_sukces='Tak'
	GROUP BY L.Id_lekarza, L.Imie, L.Nazwisko
	UNION
	SELECT L.Id_lekarza, L.Nazwisko, L.Imie, 0 
	FROM Lekarze L Where  NOT EXISTS 
	(SELECT * FROM Zabiegi Z WHERE L.Id_lekarza = Z.Lekarz_prowadzacy)
	UNION SELECT L.Id_lekarza, L.Nazwisko, L.Imie, 0 
	FROM (Lekarze L Join Zabiegi Z on L.Id_lekarza = Z.Lekarz_prowadzacy)
	Where Z.Czy_sukces='Nie' AND NOT EXISTS ( SELECT * FROM Zabiegi Z WHERE L.Id_lekarza = Z.Lekarz_prowadzacy AND Z.Czy_sukces='Tak') ;
    
	Select * FROM  IleUdanych ORDER BY Ile_udanych DESC;
	
	CREATE VIEW IleNieudanych
	(Id_lekarza,Imie, Nazwisko, Ile_nieudanych)
		AS SELECT L.Id_lekarza, L.Nazwisko, L.Imie, COUNT (*) 
	FROM (Lekarze L Join Zabiegi Z on L.Id_lekarza = Z.Lekarz_prowadzacy)
	Where Z.Czy_sukces='Nie'
	GROUP BY L.Id_lekarza, L.Imie, L.Nazwisko
	UNION
	SELECT L.Id_lekarza, L.Nazwisko, L.Imie, 0 
	FROM Lekarze L Where  NOT EXISTS 
	(SELECT * FROM Zabiegi Z WHERE L.Id_lekarza = Z.Lekarz_prowadzacy)
	UNION SELECT L.Id_lekarza, L.Nazwisko, L.Imie, 0 
	FROM (Lekarze L Join Zabiegi Z on L.Id_lekarza = Z.Lekarz_prowadzacy)
	Where Z.Czy_sukces='Tak' AND NOT EXISTS ( SELECT * FROM Zabiegi Z WHERE L.Id_lekarza = Z.Lekarz_prowadzacy AND Z.Czy_sukces='Nie') ;
    
		Select * FROM  IleNieudanych ORDER BY Ile_nieudanych DESC;


		-- koncowy efekt
		SELECT N.Id_lekarza, N.Imie, N.Nazwisko, Ile_udanych, Ile_nieudanych, Ile_udanych + Ile_nieudanych AS Ile_��cznie
		FROM (IleNieudanych N Join IleUdanych U on U.Id_lekarza = N.Id_lekarza)
		ORDER BY Ile_��cznie DESC, Ile_udanych DESC, Ile_nieudanych DESC;

	DROP VIEW IleNieudanych;
	DROP VIEW IleUdanych;
