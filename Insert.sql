INSERT INTO Lekarze VALUES 
('L_555','robert','burneiKa','13-04','10-03'),
('L_545','Adam','Ma³ysz','10-02','10-02'),
('L_xyz','Jan','Pawe³','06-09','05-08'),
('L_www','Jan','Gawe³','03-09','02-08'),
('L_21','Hubert','Wawel','16-09','15-08'),
('L_x67y','Jacek','Knapp','26-11','12-07'),
('L_21x374','Jaros³aw','Mandala','02-01','01-08'),
('L_21375','Julia','Pawlicka','01-09','01-09'),
('L_2137112','Janina','Borsuk','12-09','05-11'),
('L_21x5','Katarzyna','Mazur','11-09','11-09'),
('L_2137','Kornelia','Walec','00-09','00-09'),
('L_001', 'Stanis³aw', 'Rak', '10-10', '08-10'),
('L_2000', 'Julian','Starzec', '25-10', '25-10')

INSERT INTO Choroby VALUES ('Nosówka', 'Tak'),
('Wœcieklizna', 'Tak'),
('W¹glik', 'Tak'),
('Albinizm', 'Nie'),
('Tê¿ec', 'Tak'),
('Przewlek³y nie¿yt oskrzeli', 'Tak'),
('Gruda', 'Nie'),
('Podbicie', 'Nie'),
('Niewydolnoœæ nerek', 'Tak'),
('Biegunka', 'Tak'),
('Prêgi' , 'Tak'),
('Odwodnienie', 'Tak'),
('Kamienie nerkowe', 'Tak'),
('Guzy', 'Nie'),
('Paso¿yty', 'Tak')



INSERT INTO Rasy Values('Chomik syryjski', 'Chomik domowy'),
('Roborowskiego', 'Chomik domowy'),
('Chomik d¿ungarski', 'Chomik domowy'),
('Koñ Albino', 'Koñ'),
('K³usak Amerykañski', 'Koñ'),
('Kot perski', 'Kot'),
('Kot syjamski', 'Kot'),
('Radgoll', 'Kot'),
('Kot brytyjski', 'Kot'),
('Pudel', 'Pies'),
('Golden Retriever', 'Pies'),
('Chihuaha', 'Pies'),
('Beagle', 'Pies'),
('Owczarek Niemiecki', 'Pies'),
('Labrador', 'Pies'),
('Angora', 'Królik'),
('Reks', 'Królik'),
('Baran Francuski', 'Królik')



INSERT INTO Zwierzeta Values 
('Z_1', 'Baks', '2010-05-09', 'M','2015-09-12', 'Angora'),
('Z_66', 'Lusia', '2008-05-09', 'K','2015-03-12', 'Baran Francuski'),
('Z_412', 'Garfield', '2002-09-28', 'M', '2015-12-11', 'Radgoll'),
('Z_000', 'Maks', '2002-08-31', 'M', '2015-09-02', 'Owczarek Niemiecki'),
('Z_www', 'Lulu', '2020-03-12', 'K', NULL, 'Chihuaha'),
('Z_uuu', 'Mufi', '2020-03-12', 'M', NULL, 'Chihuaha'),
('Z_qwerty', 'Czarna', '2015-09-17', 'K', NULL, 'Koñ Albino'),
('Z_009', 'Feliks', '2010-12-12', 'M', NULL, 'Kot perski'),
('Z_888', 'Haps', '2018-09-22', 'M', NULL, 'Golden Retriever'),
('Z_889', 'Hapsa', '2018-09-22', 'K', NULL, 'Golden Retriever'),
('Z_8', 'Myszka', '2014-09-12', 'K', NULL, 'Roborowskiego'),
('Z_12', 'Angu', '2012-07-31', 'M', NULL, 'K³usak Amerykañski')



INSERT INTO Wizyty Values
('W_u111', '2019-08-19','Szczepienie', '00:15', 'podstawowe', 'L_21x374', 'Z_889'),
('W_1', '2014-12-07','Ci¹g³e drapanie', '00:48', 'specjalistyczne', 'L_2000', 'Z_000'),
('W_0', '2012-12-07','Piszczenie przy oddawaniu moczu', '00:58', 'specjalistyczne', 'L_2000', 'Z_000'),
('W_00', '2020-08-19', 'Niegoj¹ca siê rana','00:55', 'specjalistyczne', 'L_2137', 'Z_www'),
('W_11', '2020-10-19', 'Umówienie na zastrzyk','00:45', 'specjalistyczne', 'L_21375', 'Z_www'),
('W_0000', '2020-08-19','Szczepienie', '00:15', 'podstawowe', 'L_21x374', 'Z_uuu'),
('W_1111', '2020-10-19','Bardzo czêste oddawanie moczu', '00:58', 'specjalistyczne', 'L_www', 'Z_uuu'),
('W_xxxx', '2015-10-20', 'Wizyta kontrolna','00:22', 'podstawowe', 'L_x67y', 'Z_qwerty' ),
('W_zzzz', '2020-10-19','Dusznoœci', '01:35', 'specjalistyczne', 'L_001', 'Z_qwerty'),
('W_x000', '2018-07-12','Agresywne zachowania', '02:00', 'specjalistyczne', 'L_555', 'Z_009'),
('W_z000', '2019-12-09','Ci¹g³e drapanie', '01:12', 'specjalistyczne','L_2137112', 'Z_888') ,
('W_u000', '2019-09-18', 'Biegunka','01:01', 'specjalistyczne', 'L_21x5', 'Z_889'),
('W_x00', '2015-01-12','Gryzienie krat', '00:41', 'podstawowe', 'L_21', 'Z_8'),
('W_y00', '2017-01-18', 'Wizyta kontrolna','00:17', 'podstawowe', 'L_x67y','Z_12'),
('W_222', '2015-07-12','Dziwne zachowanie zwierzêcia','00:50', 'specjalistyczne', 'L_xyz', 'Z_412'),
('W_1000', '2012-06-12', 'Wizyta kontrolna','00:15', 'podstawowe', 'L_545', 'Z_1'),
('W_000', '2010-12-30', 'Wizyta kontrolna','00:20', 'podstawowe', 'L_2000' ,'Z_412'),
('W_xxx', '2015-03-10','Problemy z wypró¿nianiem', '01:25', 'specjalistyczne', 'L_545', 'Z_66'),
('W_111', '2011-08-12','Wyczuwalne guzki','00:50', 'specjalistyczne', 'L_21', 'Z_412')


INSERT INTO Zabiegi Values
('USG uk³adu moczowego', 'W_0', '00:45','Tak' ,'L_2000'),
('Zastrzyki przeciwtê¿cowe', 'W_00', '00:45', 'Tak', 'L_21'),
('Zastrzyki przeciwtê¿cowe','W_11', '00:15', 'Tak','L_545'),
('USG uk³adu moczowego', 'W_1111', '00:40', 'Nie', 'L_21x374'),
('Na³o¿enie substancji przeciw pch³om','W_1', '00:35', 'Tak', 'L_21x5'),
('Pe³ne badanie kliniczne górnych dróg oddechowych','W_zzzz', '01:20', 'Tak', 'L_555'),
('Zastrzyki przeciw wœciekliŸnie','W_x000', '01:00', 'Tak', 'L_555'),
('Na³o¿enie substancji przeciw pch³om', 'W_z000', '00:55', 'Tak','L_21'),
('Szczepienie','W_0000', '00:10', 'Tak', 'L_www'),
('Szczepienie', 'W_u111', '00:10', 'Tak' , 'L_www' ),
('USG uk³adu pokarmowego','W_xxx' , '00:50', 'Tak', 'L_2000'),
('USG uk³adu pokarmowego', 'W_u000', '00:50', 'Tak', 'L_2000')


INSERT INTO Wykrycia_chorob Values 
('Kamienie nerkowe','W_1111' ),
('Kamienie nerkowe','W_0' ),
('Tê¿ec', 'W_00'),
('Prêgi', 'W_x00' ),
('Przewlek³y nie¿yt oskrzeli', 'W_zzzz' ),
( 'Biegunka', 'W_u000'),
 ('Odwodnienie ', 'W_u000'),
( 'Wœcieklizna', 'W_x000'),
( 'Albinizm','W_xxxx'),
('Guzy','W_111'),
( 'Paso¿yty','W_1'),
('Paso¿yty','W_z000'),
('Guzy', 'W_xxx'),
('Odwodnienie','W_1000')

INSERT INTO Recepty Values
('9988776655443322110099',  '2019-08-19',  '2019-09-19', 'papierowa','W_u111' ),
('1100229933884488118822','2012-12-07' ,  '2012-12-31', 'papierowa' ,'W_0' ),
('1111111111111111111111', '2020-10-19', '2021-10-19', 'elektroniczna', 'W_1111'),
('2222222222222222222222', '2020-08-19', '2021-08-19', 'elektroniczna', 'W_0000'),
('2222222222222222222221', '2019-12-09' , '2019-12-31', 'papierowa', 'W_z000'),
('1122334455667788990011', '2019-09-18' , '2019-10-18' , 'papierowa','W_u000' ),
('9999999999999999999999' , '2012-06-12' , '2012-07-12', 'papierowa', 'W_1000'),
('8888888888888888888888', '2020-08-19', '2021-08-19', 'elektroniczna', 'W_00'),
('9900990099009900990099','2015-01-12', '2015-02-12', 'papierowa' ,'W_x00'),
('2233445566778899112233', '2014-12-07', '2014-12-31', 'papierowa', 'W_1')


INSERT INTO Medykamenty VALUES
('Stool Firm', 'Tabletki'), /*biegunka*/
('Aptobalance', 'Proszek'), /*elektrolity*/
('Cestal', 'Tabletki'), /*odrobaczanie*/
('Prevanol Protect', 'Tabletki'), /*na stawy dla psów*/
('L-METHIOCID', 'Tabletki') , /*na kamienie*/
('UrinaryMet', 'Tabletki'), 
('Beaphar Fiprotec Spot-On', 'Krople'), /*na pchly*/
('Pana Veyxal','Maœæ'), /*na rany*/
('Sulphur Ointment', 'Maœæ'), /*prêgi u chomika*/
('MICROMED VET SILVER' , 'Krem') /*na rany*/

INSERT INTO  Pozycje_na_recepcie Values 
('8888888888888888888888', 3, 2, '10g dosypaæ do jedzenia raz dziennie', 'Aptobalance', 'Proszek'),
('1100229933884488118822', 1, 5,'3 x dziennie jedna tabletka' ,'L-METHIOCID', 'Tabletki'),
('1100229933884488118822', 2, 2, '1 x dziennie dwie tabletki', 'UrinaryMet', 'Tabletki'),
('1111111111111111111111' , 1, 5, '2 x dziennie dwie tabletki', 'UrinaryMet', 'Tabletki'),
('2222222222222222222222', 1, 3, 'Jedna tabletka co miesi¹c', 'Cestal', 'Tabletki'),
('2222222222222222222222', 2, 3, '5g dosypaæ do jedzenia raz dziennie', 'Aptobalance', 'Proszek'),
('2222222222222222222222', 3, 5, '1 x dziennie jedna tabletka', 'Prevanol Protect', 'Tabletki'),
('1122334455667788990011', 1, 5, '5g dosypaæ do jedzenia raz dziennie',  'Aptobalance', 'Proszek'),
('1122334455667788990011', 2, 3 , '3x dziennie jedna tabletka', 'Stool Firm', 'Tabletki'),
('9999999999999999999999',  1, 3, '5g dosypaæ do jedzenia raz dziennie',  'Aptobalance', 'Proszek'),
('9999999999999999999999',  2, 5, '1 x dziennie jedna tabletka', 'Prevanol Protect', 'Tabletki'),
('8888888888888888888888', 1, 3,  '3x dziennie smarowaæ ranê', 'Pana Veyxal','Maœæ'),
('8888888888888888888888', 2, 1,  '1x dziennie smarowaæ ranê','MICROMED VET SILVER' , 'Krem'),
('9900990099009900990099', 1, 1, '1x dziennie smarowaæ ranê', 'Sulphur Ointment', 'Maœæ'),
('2222222222222222222221' , 1, 2, '2x dziennie rozprowadziæ na skórê', 'Beaphar Fiprotec Spot-On', 'Krople'),
('2233445566778899112233' , 1, 2, '2x dziennie rozprowadziæ na skórê', 'Beaphar Fiprotec Spot-On', 'Krople'),
('9988776655443322110099', 1, 2, 'Jedna tabletka co miesi¹c', 'Cestal', 'Tabletki')

INSERT INTO Wlasciciele Values
(62121578281, 'Julia', 'Jaworska', 503421842, 'julka@op.pl'),
(52121578281, 'Julia', 'Kowalska', 888222888, 'jula@op.pl'),
(47052291727, 'ALicja', 'Nowak', 909909909, 'ala@op.pl'),
(67022044825, 'Janina', 'Olek', 888888888, 'jan@wp.pl'),
(90052181341, 'Aleksanda', 'Nakita',809555666, 'al@wp.pl'),
(94032596886, 'Juliana', 'Pawila', 999777222, 'juls@onet.pl'),
(69061325523, 'Wiktoria', 'Czajka', 777666222, 'wika@op.pl'),
(93110144191, 'Julian', 'Mrówka', 999888777, 'mro@op.pl'),
(64022593816, 'Jan', 'Krówka', 888777111, 'kro@op.pl'),
(90012296533, 'Jacek', 'Placek', 555555555, 'placek@onet.pl'),
(70040221299, 'Kamil', 'Bochenek', 666666666, 'bochen@gmail.com'),
(95112363833, 'Jerzy', 'Œwie¿y', 888111222, 'œwie¿ak@gmail.com'),
(60062985475, 'Kacper', 'Lotnik', 555222333, 'lot@op.pl')




INSERT INTO  Przynaleznosci_ZW Values
(62121578281, 'Z_uuu'),
(94032596886, 'Z_uuu'),
(52121578281, 'Z_1'),
(52121578281, 'Z_66'),
(47052291727, 'Z_412'),
(60062985475,'Z_412'),
(90052181341, 'Z_000'),
(94032596886,'Z_www'),
(95112363833,'Z_www'),
(95112363833, 'Z_uuu'),
(69061325523, 'Z_qwerty'),
(93110144191,'Z_009'),
(64022593816, 'Z_888'),
(64022593816, 'Z_889'),
(90012296533,'Z_8'),
(70040221299,'Z_12')

