DROP TABLE [Jelp.Stop]
DROP TABLE [Jelp.Pass];
DROP TABLE [Jelp.StopLocation];
DROP TABLE [Jelp.Shuttle];
DROP TABLE [Jelp.Review];
DROP TABLE [Jelp.User];
DROP TABLE [Jelp.Restaurant];
DROP TABLE [Jelp.City];

CREATE TABLE [Jelp.City] (
 ctyId CHAR(5) NOT NULL,
 ctyName VARCHAR(15),
 ctyPopulation INTEGER,
 ctyRace VARCHAR(20),
 ctyIncome INTEGER,
 ctyAge NUMERIC(3,1),
 CONSTRAINT pk_City_ctyId PRIMARY KEY (ctyId) );
CREATE TABLE [Jelp.Restaurant] (
 rstId CHAR (5) NOT NULL,
 rstName VARCHAR(50),
 rstPrice NUMERIC(2,1),
 rstStreet VARCHAR(40),
 rstZipcode CHAR(5),
 rstCity VARCHAR(15),
 rstState CHAR(2),
 rstPhoneNo CHAR(10),
 rstRating NUMERIC(2,1),
 rstCategory VARCHAR(20),
 rstReviewCount SMALLINT,
 rstLatitude DECIMAL(10,5),
 rstLongitude DECIMAL(10,5),
 ctyId CHAR(5),
 CONSTRAINT pk_Restaurant_rstId PRIMARY KEY (rstId) ,
 CONSTRAINT fk_Restaurant_ctyId FOREIGN KEY (ctyId)
   	  	REFERENCES [Jelp.City] (ctyId)
   	  	ON DELETE NO ACTION ON UPDATE NO ACTION );
CREATE TABLE[Jelp.User] (
 usrId CHAR (5) NOT NULL,
 usrName VARCHAR(40),
 CONSTRAINT pk_User_usrId PRIMARY KEY (usrId) );
CREATE TABLE [Jelp.Review] (
 rvwId CHAR (5) NOT NULL,
 rvwStar NUMERIC(2,1),
 rvwComment VARCHAR(200),
 rstId CHAR (5),
 usrId CHAR (5),
 CONSTRAINT pk_Review_rvwId PRIMARY KEY (rvwId) ,
 CONSTRAINT fk_Review_rstId FOREIGN KEY (rstId)
   	  	REFERENCES [Jelp.Restaurant] (rstId)
   	  	ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_Review_usrId FOREIGN KEY (usrId)
   	  	REFERENCES [Jelp.User] (usrId)
   	  	ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE[Jelp.Shuttle] (
 shtId CHAR (5) NOT NULL,
 shtFrom VARCHAR(50),
 shtTo VARCHAR(50),
 shtWeekend VARCHAR(3),
 shtInterval TINYINT,
 CONSTRAINT pk_Shuttle_shtId PRIMARY KEY (shtId) );
CREATE TABLE[Jelp.StopLocation] (
 stpId CHAR (5) NOT NULL,
 stpName VARCHAR(100),
 stpLatitude DECIMAL(10,6),
 stpLongitude DECIMAL(10,6),
 CONSTRAINT pk_StopLocation_stpId PRIMARY KEY (stpId) );
CREATE TABLE[Jelp.Pass] (
 rstId CHAR (5) NOT NULL,
 shtId CHAR(5) NOT NULL,
 CONSTRAINT pk_Pass_rstId_shtId PRIMARY KEY (rstId, shtId),
 CONSTRAINT fk_Pass_rstId FOREIGN KEY (rstId)
   		REFERENCES [Jelp.Restaurant] (rstId)
   		ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT fk_Pass_shtId FOREIGN KEY (shtId)
   		REFERENCES [Jelp.Shuttle] (shtId)
   	  	ON DELETE CASCADE ON UPDATE CASCADE );
CREATE TABLE[Jelp.Stop] (
 stpId CHAR (5) NOT NULL,
 shtId CHAR(5) NOT NULL,
 CONSTRAINT pk_Stop_stpId_shtId PRIMARY KEY (stpId, shtId),
 CONSTRAINT fk_Stop_stpId FOREIGN KEY (stpId)
   		REFERENCES [Jelp.StopLocation] (stpId)
   		ON DELETE NO ACTION ON UPDATE CASCADE,
 CONSTRAINT fk_Stop_shtId FOREIGN KEY (shtId)
   		REFERENCES [Jelp.Shuttle] (shtId)
   	  	ON DELETE NO ACTION ON UPDATE CASCADE );


INSERT INTO [Jelp.City] VALUES 
('C0001','Beltsville',17890,'Hispanic',78144,36),
('C0002','College Park',32186,'White',64107,21.8),
('C0003','Greenbelt',23289,'African American',72846,33.7),
('C0004','Hyattsville',18225,'Hispanic',73627,34.2),
('C0005','Silver Spring',79483,'White',76608,34.6),
('C0006','Washington DC',693972,'Black',82372,34.0),
('C0007','Langley Park',19561,'Hispanic',60742,30.5),
('C0008','Riverdale Park',7248,'Hispanic',70036,32.0),
('C0009','Takoma Park',17643,'White',87115,38.4),
('C0010','Mount Rainier',8097,'Black',50707,33.7),
('C0011','Berwyn Heights',3250,'White',100938,38.6),
('C0012','Arlington',229534,'White',112138,34.4);

INSERT INTO [Jelp.Restaurant] VALUES 
('R0001','1789 Restaurant',4,'1226 36th St NW','20007','Washington','DC','2029651789',4,'tradamerican',714,38.90608,-77.07045,'C0006'),
('R0002','2 Amys Neapolitan Pizzeria',2,'3715 Macomb St NW','20016','Washington','DC','2028855700',4,'pizza',1611,38.93368,-77.07310,'C0006'),
('R0003','Abol',2,'8626 Colesville Rd','20910','Silver Spring','MD','3016500061',4,'ethiopian',189,38.99674,-77.02771,'C0005'),
('R0004','All Set Restaurant & Bar',2,'8630 Fenton St','20910','Silver Spring','MD','3014958800',4,'newamerican',723,38.99789,-77.02835,'C0005'),
('R0005','Ambar',2,'2901 Wilson Blvd','22201','Arlington','VA','7038759663',4.5,'modern_european',1156,38.88874,-77.09345,'C0012'),
('R0006','Amina Thai - Silver Spring',2,'8624 Colesville Rd','20910','Silver Spring','MD','3015883588',4,'thai',194,38.99672,-77.02772,'C0005'),
('R0007','Arepa Zone',1,'1309 5th St NE','20002','Washington','DC','2025444742',4,'venezuelan',211,38.90861,-76.99738,'C0006'),
('R0008','Arepas Pues',2,'8555 Fenton St','20910','Silver Spring','MD','2406708020',4,'venezuelan',165,38.99739,-77.02644,'C0005'),
('R0009','Aroy Thai Restaurant',2,'4511 College Ave','20740','College Park','MD','3018645550',4,'thai',245,38.98188,-76.93709,'C0002'),
('R0010','Azteca Restaurant-Cantina',2,'9505 Baltimore Ave','20740','College Park','MD','3014748226',3,'tex-mex',262,39.00917,-76.92871,'C0002'),
('R0011','Baba',2,'2901 Wilson Blvd','22201','Arlington','VA','7033127978',4.5,'modern_european',269,38.88874,-77.09345,'C0012'),
('R0012','Bagel Place of College Park',1,'7423 Baltimore Ave','20740','College Park','MD','3017793900',4,'bagels',260,38.98193,-76.93754,'C0002'),
('R0013','Baked & Wired',2,'1052 Thomas Jefferson St NW','20007','Washington','DC','2023332500',4.5,'bakeries',4344,38.90391,-77.06025,'C0006'),
('R0014','Bakeshop',1,'1025 N Fillmore St','22201','Arlington','VA','5719706460',4.5,'desserts',806,38.88546,-77.09264,'C0012'),
('R0015','Banana Blossom Bistro',2,'6202 Rhode Island Ave','20737','Riverdale Park','MD','3012778500',5,'vietnamese',65,38.96291,-76.93572,'C0008'),
('R0016','Bandoola Bowl',2,'1069 Wisconsin Ave NW','20007','Washington','DC','2027583184',5,'salad',191,38.90460,-77.06254,'C0006'),
('R0017','Barley Mac',2,'1600 Wilson Blvd','22209','Arlington','VA','5718003070',4,'bars',629,38.89410,-77.07713,'C0012'),
('R0018','BeClaws',2,'6450 America Blvd','20782','Hyattsville','MD','3014039000',3.5,'seafood',189,38.96769,-76.95238,'C0004'),
('R0019','Bete Ethiopian Cuisine & Cafe',2,'811 Roeder Rd','20910','Silver Spring','MD','3015882225',4,'ethiopian',157,38.99771,-77.02591,'C0005'),
('R0020','Beteseb Restaurant',2,'8201 Georgia Ave','20910','Silver Spring','MD','3014481625',4.5,'ethiopian',128,38.99172,-77.02631,'C0005'),
('R0021','BIBIBOP Asian Grill - Silver Spring',1,'935 Ellsworth Dr','20910','Silver Spring','MD','3013379422',4,'hotdogs',87,38.99556,-77.02658,'C0005'),
('R0022','Bistro Aracosia',3,'5100 MacArthur Blvd','20016','Washington','DC','2023630400',5,'afghani',173,38.92493,-77.10172,'C0006'),
('R0023','BlackSalt',3,'4883 MacArthur Blvd NW','20007','Washington','DC','2023429101',4,'seafood',913,38.91777,-77.09668,'C0006'),
('R0024','Blaze Fast-Fired Pizza',1,'7419 Baltimore Ave','20740','College Park','MD','3013922324',4,'pizza',217,38.98182,-76.93753,'C0002'),
('R0025','Blue Duck Tavern',3,'1201 24th St NW','20037','Washington','DC','2024196755',4,'newamerican',2333,38.90559,-77.05119,'C0006'),
('R0026','Bonchon - Hyattsville',2,'6507 America Blvd','20782','Hyattsville','MD','3012091888',3.5,'korean',204,38.96887,-76.95213,'C0004'),
('R0027','Brooklands Finest',2,'3126 12th St NE','20017','Washington','DC','2026360050',4,'newamerican',534,38.92942,-76.99103,'C0006'),
('R0028','Buena Vida',2,'8407 Ramsey Ave','20910','Silver Spring','MD','3017556132',4.5,'mexican',329,38.99395,-77.02900,'C0005'),
('R0029','Buffalo Wild Wings',2,'10240 Baltimore Ave','20740','College Park','MD','3014860333',2.5,'chicken_wings',317,39.02212,-76.92526,'C0002'),
('R0030','Bump n Grind',1,'1200 East West Hwy','20910','Silver Spring','MD','3015888000',4,'coffee',211,38.99025,-77.02952,'C0005'),
('R0031','BurgerFi',2,'8504 Fenton Ave','20910','Silver Spring','MD','3015652100',4,'burgers',453,38.99560,-77.02473,'C0005'),
('R0032','Burtons Grill & Bar of Riverdale',2,'4440 Van Buren St','20782','Riverdale Park','MD','2408253988',4,'newamerican',352,38.96984,-76.93773,'C0008'),
('R0033','Busboys and Poets - Hyattsville',2,'5331 Baltimore Ave','20781','Hyattsville','MD','3017792787',4,'breakfast_brunch',1171,38.95515,-76.94002,'C0004'),
('R0034','Cafe Azul - Caracas de Ayer',1,'4423 Longfellow St','20781','Hyattsville','MD','3012090049',4,'cuban',94,38.95704,-76.94026,'C0004'),
('R0035','Captain Cookie and the Milk Man Food Truck',1,'','20036','Washington','DC','2025563396',4.5,'desserts',338,38.90762,-77.04192,'C0006'),
('R0036','Carolina Kitchen Bar & Grill',2,'6501 America Blvd','20782','Hyattsville','MD','3019272929',3.5,'soulfood',563,38.96863,-76.95130,'C0004'),
('R0037','CAVA',2,'8515 Fenton St','20910','Silver Spring','MD','3012008666',4,'mediterranean',129,38.99663,-77.02480,'C0005'),
('R0038','Cava Mezze',2,'2940 Clarendon Blvd','22201','Arlington','VA','7032769090',4,'greek',1106,38.88734,-77.09359,'C0012'),
('R0039','Chaia Tacos',2,'3207 Grace St NW','20007','Washington','DC','2023335222',4.5,'vegetarian',643,38.90408,-77.06326,'C0006'),
('R0040','Champion Grill',1,'10484 Baltimore Ave','20705','Beltsville','MD','3019375577',3.5,'breakfast_brunch',26,39.02801,-76.91756,'C0001'),
('R0041','Charm Thai',2,'8408 Georgia Ave','20910','Silver Spring','MD','3014956308',4,'thai',416,38.99375,-77.02719,'C0005'),
('R0042','Chez Dior',2,'5124 Baltimore Ave','20781','Hyattsville','MD','2406965907',4.5,'senegalese',129,38.95222,-76.94076,'C0004'),
('R0043','ching ching CHA',2,'1063 Wisconsin Ave NW','20007','Washington','DC','2023338288',4.5,'tea',304,38.90440,-77.06246,'C0006'),
('R0044','Chipotle Mexican Grill',1,'5506 Cherrywood Ln','20770','Greenbelt','MD','3019826722',3.5,'mexican',73,38.99862,-76.91216,'C0003'),
('R0045','Clydes of Georgetown',2,'3236 M St NW','20007','Washington','DC','2023339180',4,'tradamerican',1123,38.90491,-77.06403,'C0006'),
('R0046','College Park Aviation Museum',NULL,'1985 Corporal Frank Scott Dr','20740','College Park','MD','3018646029',5,'museums',33,38.97894,-76.92252,'C0002'),
('R0047','College Park Diner',1,'9206 Baltimore Ave','20740','College Park','MD','3014418888',4,'diners',315,39.00635,-76.93024,'C0002'),
('R0048','College Park Grill',2,'8321 Baltimore Ave','20740','College Park','MD','3014744745',3.5,'jazzandblues',85,38.99322,-76.93254,'C0002'),
('R0049','Copper Canyon Grill',2,'928 Ellsworth Dr','20910','Silver Spring','MD','3015891330',4,'tradamerican',696,38.99620,-77.02588,'C0005'),
('R0050','Crisfield Seafood',2,'8012 Georgia Ave','20910','Silver Spring','MD','3015891306',3.5,'seafood',274,38.98832,-77.02682,'C0005'),
('R0051','Crumbs & Whiskers | A Cat Cafe Experience.',2,'3211 O St NW','20007','Washington','DC','2026217114',4.5,'petadoption',420,38.90799,-77.06410,'C0006'),
('R0052','Cubanos Restaurant',2,'1201 Fidler Ln','20910','Silver Spring','MD','3015634020',4,'cuban',476,38.99613,-77.03013,'C0005'),
('R0053','D.P. Dough',1,'8145 Baltimore Ave','20740','College Park','MD','3016149663',3.5,'pizza',125,38.99091,-76.93276,'C0002'),
('R0054','Da Rae Won Restaurant',2,'5013 Garrett Ave','20705','Beltsville','MD','3019317878',4,'korean',375,39.04134,-76.90640,'C0001'),
('R0055','DCG - District Chicken & Gyro',2,'3147 Dumbarton St NW','20007','Washington','DC','2026292090',5,'halal',315,38.90777,-77.06298,'C0006'),
('R0056','Dog Tag Bakery',1,'3206 Grace St NW','20007','Washington','DC','2024079609',4.5,'bakeries',278,38.90383,-77.06317,'C0006'),
('R0057','Dukes Counter',2,'3000 Connecticut Ave NW','20008','Washington','DC','2027334808',4.5,'burgers',407,38.93003,-77.05563,'C0006'),
('R0058','Dumms Pizza & Subs',1,'4704 Riverdale Rd','20737','Riverdale','MD','3012772208',4,'pizza',78,38.96200,-76.93482,'C0008'),
('R0059','Dumplings & Beyond',2,'2400 Wisconsin Ave NW','20007','Washington','DC','2023383815',4,'chinese',380,38.92119,-77.07238,'C0006'),
('R0060','Eggspectation',2,'923 Ellsworth Dr','20910','Silver Spring','MD','3015851700',3.5,'breakfast_brunch',790,38.99614,-77.02672,'C0005'),
('R0061','El Quetzal Restaurant',2,'11121 Baltimore Ave','20705','Beltsville','MD','3015953511',4.5,'latin',30,39.03527,-76.90613,'C0001'),
('R0062','El Taco Rico',1,'6000 Greenbelt Rd','20770','Greenbelt','MD','3014418652',4,'mexican',42,38.99900,-76.90739,'C0003'),
('R0063','Elevation Burger',2,'5501 Baltimore Ave','20781','Hyattsville','MD','3019856869',3.5,'burgers',166,38.95555,-76.93988,'C0004'),
('R0064','Escape Room Live DC - Georgetown',2,'3345 M St NW','20007','Washington','DC','8006164880',4.5,'escapegames',357,38.90510,-77.06764,'C0006'),
('R0065','Et Voila',3,'5120 MacArthur Blvd NW','20016','Washington','DC','2022372300',4,'french',228,38.92544,-77.10232,'C0006'),
('R0066','Ethio Express Grill',2,'952 Sligo Ave','20910','Silver Spring','MD','3018445149',4,'ethiopian',263,38.99017,-77.02574,'C0005'),
('R0067','Falafel Inc',1,'1210 Potomac St NW','20007','Washington','DC','2023334265',5,'falafel',506,38.90546,-77.06536,'C0006'),
('R0068','Farmers Fishers Bakers',2,'3000 K St NW','20007','Washington','DC','2022988783',4,'newamerican',3560,38.90169,-77.05975,'C0006'),
('R0069','Fenton Cafe',1,'8311 Fenton St','20910','Silver Spring','MD','3013261841',4,'creperies',272,38.99370,-77.02394,'C0005'),
('R0070','Filomena Ristorante',3,'1063 Wisconsin Ave NW','20007','Washington','DC','2023388800',4,'italian',2457,38.90443,-77.06255,'C0006'),
('R0071','Fiola Mare',4,'3050 K St NW','20007','Washington','DC','2025251402',4,'seafood',1061,38.90163,-77.06096,'C0006'),
('R0072','Food Factory',1,'8145 Baltimore Ave','20740','College Park','MD','3013458888',3.5,'afghani',111,38.99143,-76.93364,'C0002'),
('R0073','Franklins',2,'5121 Baltimore Ave','20781','Hyattsville','MD','3019272740',4,'breweries',644,38.95264,-76.94045,'C0004'),
('R0074','Gah Rham Restaurant',2,'5027 Garrett Ave','20705','Beltsville','MD','3015954122',3.5,'korean',213,39.04104,-76.90559,'C0001'),
('R0075','Galaxy Hut',2,'2711 Wilson Blvd','22201','Arlington','VA','7035258646',4,'bars',506,38.88962,-77.09100,'C0012'),
('R0076','Georgetown Cupcake',2,'3301 M St NW','20007','Washington','DC','2023338448',3.5,'bakeries',3639,38.90525,-77.06619,'C0006'),
('R0077','Ghar- E- Kabab',2,'944 Wayne Ave','20910','Silver Spring','MD','3015874427',3.5,'indpak',295,38.99442,-77.02563,'C0005'),
('R0078','Good Stuff Eatery',2,'3291 M St NW','20007','Washington','DC','2023374663',4,'tradamerican',642,38.90519,-77.06584,'C0006'),
('R0079','Guss World Famous Fried Chicken',2,'5810 Greenbelt Rd','20770','Greenbelt','MD','2409655821',4,'chickenshop',406,38.99831,-76.91394,'C0003'),
('R0080','Gusto Farm To Street',2,'8512 Fenton St','20910','Silver Spring','MD','3015652800',4,'gluten_free',202,38.99628,-77.02505,'C0005'),
('R0081','Hanami',2,'8145 Baltimore Ave','20740','College Park','MD','3019829899',3.5,'japanese',216,38.99072,-76.93287,'C0002'),
('R0082','Hard Times Cafe',2,'4738 Cherry Hill Rd','20740','College Park','MD','3014748880',3.5,'tradamerican',182,39.01635,-76.93079,'C0002'),
('R0083','Hook & Reel',2,'6002 Greenbelt Rd','20770','Greenbelt','MD','2402414825',4,'cajun',141,38.99849,-76.91071,'C0003'),
('R0084','Hook & Reel',2,'6002 Greenbelt Rd','20770','Greenbelt','MD','2402414825',4,'cajun',141,38.99849,-76.91071,'C0003'),
('R0085','Hot N Juicy Crawfish',2,'2651 Connecticut Ave NW','20008','Washington','DC','2022999448',4,'seafood',1724,38.92503,-77.05200,'C0006'),
('R0086','IKEA Restaurant & Cafe',1,'10100 Baltimore Ave','20740','College Park','MD','3013456552',3,'scandinavian',98,39.02104,-76.92859,'C0002'),
('R0087','Ikko Sushi',2,'1215 E West Hwy','20910','Silver Spring','MD','3015629400',4,'sushi',498,38.99128,-77.02912,'C0005'),
('R0088','il Canale',2,'1065 31st St NW','20007','Washington','DC','2023374444',4.5,'italian',2899,38.90449,-77.06097,'C0006'),
('R0089','Ivy City SmokeHouse',2,'1356 Okie St NE','20002','Washington','DC','2025293300',4,'seafood',499,38.91445,-76.98550,'C0006'),
('R0090','Jasons Deli',1,'7356 Baltimore Ave','20740','College Park','MD','3017793924',4,'sandwiches',114,38.98035,-76.93811,'C0002'),
('R0091','Jersey Mikes Subs',1,'6000 Greenbelt Rd','20770','Greenbelt','MD','3014860080',3.5,'sandwiches',55,38.99892,-76.91027,'C0003'),
('R0092','Jewel of India',2,'10151 New Hampshire Ave','20903','Silver Spring','MD','3014082200',4,'indpak',475,39.02177,-76.97690,'C0005'),
('R0093','Jodeem African Cuisine',2,'6000 Greenbelt Rd','20770','Greenbelt','MD','3013452674',4.5,'african',77,38.99844,-76.91072,'C0003'),
('R0094','JODYS GOOD MOOD CAFE',2,'10606 Baltimore Ave','20705','Beltsville','MD','2407908978',4.5,'seafood',93,39.02933,-76.91601,'C0001'),
('R0095','Kafe Leopold',2,'3315 Cadys Ally NW','20007','Washington','DC','2029656005',3.5,'newamerican',1247,38.90483,-77.06667,'C0006'),
('R0096','Kaldis Social House',2,'918 Silver Spring Ave','20910','Silver Spring','MD','3015579990',4,'coffee',546,38.99151,-77.02575,'C0005'),
('R0097','Kangnam BBQ Sports Bar & Grill',2,'8503 Baltimore Ave','20740','College Park','MD','3012201635',3.5,'korean',306,38.99481,-76.93183,'C0002'),
('R0098','Kao Thai Restaurant',2,'8650 Colesville Rd','20910','Silver Spring','MD','3014951234',3.5,'thai',275,38.99722,-77.02749,'C0005'),
('R0099','Kefa Cafe',1,'963 Bonifant St','20910','Silver Spring','MD','2406418023',4.5,'coffee',158,38.99367,-77.02587,'C0005'),
('R0100','Kenilworth Park and Aquatic Gardens',NULL,'1550 Anacostia Ave NE','20019','Washington','DC','2024266905',4.5,'gardens',104,38.91265,-76.94189,'C0006'),
('R0101','Khyber Kitchen',NULL,'904 Bonifant St','20910','Silver Spring','MD','3013287931',4.5,'kebab',51,38.99404,-77.02462,'C0005'),
('R0102','Kotobuki',2,'4822 MacArthur Blvd NW','20007','Washington','DC','2026259080',4,'sushi',515,38.91680,-77.09635,'C0006'),
('R0103','Krazi Kebob',1,'4427 Lehigh Rd','20740','College Park','MD','3018645150',4,'indpak',224,38.98148,-76.93889,'C0002'),
('R0104','Kung Fu Tea',1,'7313 Baltimore Ave','20740','College Park','MD','2407143156',4,'coffee',110,38.98013,-76.93761,'C0002'),
('R0105','La Casita Pupuseria & Market',1,'8214 Piney Branch','20910','Silver Spring','MD','3015886656',4,'salvadoran',299,38.99332,-77.00959,'C0005'),
('R0106','La Fondita',1,'4901 Decatur St','20788','Hyattsville','MD','3016990785',4,'mexican',70,38.94967,-76.93626,'C0004'),
('R0107','La Malinche',2,'8622 Colesville Rd','20910','Silver Spring','MD','3015628622',4,'tapas',484,38.99702,-77.02765,'C0005'),
('R0108','Lake Artemesia Natural Area',NULL,'Berwyn Rd And 55th Ave','20740','Berwyn Heights','MD','3016277755',4.5,'lakes',40,38.99268,-76.91657,'C0011'),
('R0109','Ledo Restaurant',2,'4509 Knox Rd','20740','College Park','MD','3014228122',3,'pizza',222,38.98048,-76.93709,'C0002'),
('R0110','Looneys Pub',2,'8150 Baltimore Ave','20740','College Park','MD','2405424510',3.5,'tradamerican',264,38.99084,-76.93439,'C0002'),
('R0111','Lotus Cafe',2,'8077 Georgia Ave','20910','Silver Spring','MD','3015888888',4,'vietnamese',289,38.98996,-77.02618,'C0005'),
('R0112','Lukes Lobster Georgetown',2,'1211 Potomac St NW','20007','Washington','DC','2023334863',4,'seafood',638,38.90553,-77.06502,'C0006'),
('R0113','Mamma Lucia Pizza & Pasta',2,'4734 Cherry Hill Rd','20740','College Park','MD','3015130605',3,'pizza',178,39.01637,-76.93083,'C0002'),
('R0114','Mandalay Restaurant & Cafe',2,'930 Bonifant St','20910','Silver Spring','MD','3015850500',4,'burmese',580,38.99368,-77.02514,'C0005'),
('R0115','Mandarin Delight',1,'10613 Montgomery Rd','20705','Beltsville','MD','3019378989',4,'chinese',103,39.02962,-76.91669,'C0001'),
('R0116','Manila Mart',2,'5023 Garrett Ave','20705','Beltsville','MD','3019310086',4.5,'filipino',121,39.04117,-76.90572,'C0001'),
('R0117','Marathon Deli',2,'4429 Lehigh Rd','20740','College Park','MD','3019276717',4.5,'delis',327,38.98166,-76.93861,'C0002'),
('R0118','Marco & Polo',2,'6504 America Blvd','20782','Hyattsville','MD','3018641670',4.5,'turkish',102,38.96879,-76.95247,'C0004'),
('R0119','Masa Hibachi Steakhouse & Sushi',2,'921 Ellsworth Dr','20910','Silver Spring','MD','3016088989',3.5,'japanese',446,38.99622,-77.02643,'C0005'),
('R0120','Masala Story',2,'3301 12th St NE','20017','Washington','DC','2028859810',4.5,'indpak',167,38.93079,-76.99066,'C0006'),
('R0121','Matchbox - Silver Spring',2,'919 Ellsworth Dr','20910','Silver Spring','MD','2402478969',4,'newamerican',151,38.99623,-77.02656,'C0005'),
('R0122','McGintys Public House',2,'911 Ellsworth Dr','20910','Silver Spring','MD','3015871270',3.5,'irish',435,38.99651,-77.02624,'C0005'),
('R0123','Medium Rare',2,'3500 Connecticut Ave NW','20008','Washington','DC','2022371432',4,'steak',907,38.93577,-77.05893,'C0006'),
('R0124','Mejana',2,'2300 Wilson Blvd','22201','Arlington','VA','7034654440',4,'mediterranean',668,38.89033,-77.08735,'C0012'),
('R0125','Menomale Pizza Napoletana',2,'2711 12th St NE','20018','Washington','DC','2022483946',4.5,'bars',498,38.92486,-76.99015,'C0006'),
('R0126','Mi Rancho',2,'8701 Ramsey Ave','20910','Silver Spring','MD','3015884744',3.5,'tex-mex',434,38.99632,-77.02994,'C0005'),
('R0127','Mike and Barrys Deli',1,'12510 Prosperity Dr','20904','Silver Spring','MD','3016800033',4.5,'delis',66,39.06129,-76.96256,'C0005'),
('R0128','Milk & Honey Cafe',2,'10280 Baltimore Ave','20740','College Park','MD','3014772195',4,'breakfast_brunch',1910,39.02330,-76.92425,'C0002'),
('R0129','Mission BBQ',2,'5506 Cherrywood Ln','20770','Greenbelt','MD','2405429200',4,'bbq',238,38.99832,-76.91214,'C0003'),
('R0130','MOD Pizza',2,'909 Ellsworth Dr','20910','Silver Spring','MD','2404851570',4,'pizza',193,38.99654,-77.02614,'C0005'),
('R0131','Momo Yakitori',3,'2214 Rhode Island Ave NE','20018','Washington','DC','',4.5,'cocktailbars',93,38.93066,-76.97357,'C0006'),
('R0132','Momos Cafe',2,'4828 MacArthur Blvd NW','20007','Washington','DC','2023333675',4.5,'coffee',98,38.91684,-77.09650,'C0006'),
('R0133','Myong Dong',2,'11114 Baltimore Ave','20705','Beltsville','MD','3015954173',4,'korean',135,39.03518,-76.90701,'C0001'),
('R0134','Nandos Peri-Peri',2,'924 Ellsworth Dr','20910','Silver Spring','MD','3015887280',3.5,'portuguese',382,38.99562,-77.02660,'C0005'),
('R0135','Nellys Cafe',1,'9917 Rhode Island Ave','20740','College Park','MD','3012201433',4,'mexican',52,39.01654,-76.92004,'C0002'),
('R0136','New Century Carry Out & Resturant',1,'5400 Queens Chapel Rd','20782','Hyattsville','MD','3015595301',4.5,'chinese',54,38.95610,-76.96225,'C0004'),
('R0137','Nicecream',2,'2831 Clarendon Blvd','22201','Arlington','VA','7039080225',4,'icecream',475,38.88832,-77.09226,'C0012'),
('R0138','Northside Social Coffee & Wine',2,'3211 Wilson Blvd','22201','Arlington','VA','7034650145',4,'tradamerican',1192,38.88539,-77.09788,'C0012'),
('R0139','Northwest Chinese Food',2,'7313 E Baltimore Ave','20740','College Park','MD','2407144473',4,'chinese',153,38.97989,-76.93763,'C0002'),
('R0140','Not Your Average Joes',2,'8661 Colesville Rd','20910','Silver Spring','MD','2408393400',3.5,'salad',388,38.99740,-77.02680,'C0005'),
('R0141','NuVegan Cafe - College Park',2,'8150 Baltimore Ave','20740','College Park','MD','2405537567',4,'vegan',399,38.99115,-76.93404,'C0002'),
('R0142','Olazzo',2,'8235 Georgia Ave','20910','Silver Spring','MD','3015882540',4,'italian',468,38.99268,-77.02617,'C0005'),
('R0143','Old Europe',2,'2434 Wisconsin Ave NW','20007','Washington','DC','2023337600',4.5,'german',280,38.92180,-77.07283,'C0006'),
('R0144','Old Line Fine Wine, Spirits & Bistro',2,'11011 Baltimore Ave','20705','Beltsville','MD','3019375999',4,'beer_and_wine',240,39.03339,-76.90681,'C0001'),
('R0145','Old Line Fine Wine, Spirits & Bistro',2,'11011 Baltimore Ave','20705','Beltsville','MD','3019375999',4,'beer_and_wine',240,39.03339,-76.90681,'C0001'),
('R0146','Old Maryland Grill',3,'7777 Baltimore Ave','20740','College Park','MD','3019553413',3.5,'newamerican',146,38.98712,-76.93545,'C0002'),
('R0147','Panda Gourmet',2,'2700 New York Ave NE','20002','Washington','DC','2026363588',3.5,'szechuan',435,38.91784,-76.97077,'C0006'),
('R0148','Panera Bread',2,'10914 Baltimore Ave','20705','Beltsville','MD','3019316707',3.5,'sandwiches',58,39.03332,-76.91158,'C0001'),
('R0149','Parkway Deli & Restaurant',2,'8317 Grubb Rd','20910','Silver Spring','MD','3015871427',4,'delis',623,38.99233,-77.04913,'C0005'),
('R0150','Phils Sports Bar & Grill',2,'10624 Baltimore Ave','20705','Beltsville','MD','3019374805',4,'sportsbars',20,39.02966,-76.91555,'C0001'),
('R0151','Pho 168',NULL,'6062 Greenbelt Rd','20770','Greenbelt','MD','2405537623',4,'vietnamese',43,38.99762,-76.90920,'C0003'),
('R0152','Pho 75',1,'1721 Wilson Blvd','22209','Arlington','VA','7035257355',4,'vietnamese',1658,38.89420,-77.07885,'C0012'),
('R0153','Pho 88 Vietnamese Restaurant',1,'10478 Baltimore Ave','20705','Beltsville','MD','3019318128',3.5,'vietnamese',240,39.02851,-76.91781,'C0001'),
('R0154','Pho DLite',1,'8147 Baltimore Ave','20740','College Park','MD','3019825599',3.5,'asianfusion',492,38.99125,-76.93275,'C0002'),
('R0155','Pho Tan Vinh',2,'8705 Colesville Rd','20910','Silver Spring','MD','3015888188',4,'vietnamese',237,38.99787,-77.02668,'C0005'),
('R0156','Pho Thom',2,'7313 Baltimore Ave','20740','College Park','MD','2405827530',3.5,'thai',197,38.97991,-76.93761,'C0002'),
('R0157','Pho VN One',1,'11000 Baltimore Ave','20705','Beltsville','MD','3019316999',4,'vietnamese',265,39.03439,-76.90945,'C0001'),
('R0158','PhoWheels',1,'','20007','Washington','DC','',4.5,'vietnamese',293,38.90828,-77.06291,'C0006'),
('R0159','Pizza Roma',1,'9805 Rhode Island Ave','20740','College Park','MD','3019822551',4,'pizza',100,39.01351,-76.92132,'C0002'),
('R0160','Pizzeria Paradiso',2,'4800 Rhode Island Ave','20781','Hyattsville','MD','2404673210',4,'pizza',77,38.94855,-76.94384,'C0004'),
('R0161','Poh-Yo Charcoal Chicken',1,'8147 Baltimore Ave','20740','College Park','MD','2405537221',4.5,'spanish',64,38.99148,-76.93305,'C0002'),
('R0162','Puddin',1,'1309 5th St NE','20002','Washington','DC','2027251030',4,'cajun',293,38.90861,-76.99738,'C0006'),
('R0163','Pupuseria Olocuilta',1,'10401 Ewing Rd','20705','Beltsville','MD','2405424652',4.5,'salvadoran',15,39.02714,-76.91173,'C0001'),
('R0164','Qu Japan',2,'7406 Baltimore Ave','20740','College Park','MD','2404673332',4.5,'ramen',107,38.98110,-76.93808,'C0002'),
('R0165','Quarry House Tavern',2,'8401 Georgia Ave','20910','Silver Spring','MD','3018445504',4,'divebars',663,38.99356,-77.02642,'C0005'),
('R0166','Raulins Bakery',1,'10476 Baltimore Ave','20705','Beltsville','MD','3019379595',4,'bakeries',75,39.02794,-76.91767,'C0001'),
('R0167','Red Chillies',2,'1341 University E','20912','Takoma Park','MD','3014349200',4,'indpak',274,38.98698,-76.98553,'C0009'),
('R0168','Remingtons Restaurant',2,'11500 Baltimore Ave','20705','Beltsville','MD','3019376809',3.5,'newamerican',89,39.04227,-76.90407,'C0001'),
('R0169','Republic Restoratives Distillery',2,'1369 New York Ave NE','20002','Washington','DC','2027333996',4.5,'distilleries',89,38.91540,-76.98528,'C0006'),
('R0170','Ritas Italian Ice',1,'8900 Baltimore Ave','20740','College Park','MD','3013455445',4,'icecream',39,38.99875,-76.93185,'C0002'),
('R0171','Riviera Tapas Bar',2,'6108 Rhode Island Ave','20737','Riverdale','MD','2408253868',4.5,'tapas',46,38.96254,-76.93576,'C0008'),
('R0172','Roaming Rooster - Restaurant',NULL,'3176 Bladensburg Rd NE','20018','Washington','DC','2025078734',4.5,'chickenshop',177,38.92947,-76.96056,'C0006'),
('R0173','Saburo Ramen',2,'8503 Baltimore Ave','20740','College Park','MD','3012201635',3.5,'ramen',62,38.99491,-76.93178,'C0002'),
('R0174','Salt & Pepper',2,'5125 Macarthur Blvd','20016','Washington','DC','2023645125',4,'southern',122,38.92567,-77.10166,'C0006'),
('R0175','Sardis Pollo A La Brasa',2,'10433 Baltimore Ave','20705','Beltsville','MD','3015953222',4.5,'latin',811,39.02729,-76.91786,'C0001'),
('R0176','Seoul Food DC',2,'7302 Carroll Ave','20912','Takoma Park','MD','5712364750',4.5,'korean',433,38.97824,-77.00615,'C0009'),
('R0177','Seoulia',2,'10820 Rhode Island Ave','20705','Beltsville','MD','3015953340',3.5,'korean',123,39.03417,-76.91370,'C0001'),
('R0178','Sergio Ristorante Italiano',2,'8727 Colesville Rd','20910','Silver Spring','MD','3015851040',4,'italian',203,38.99836,-77.02635,'C0005'),
('R0179','Shagga Coffee & Restaurant',2,'6040 Baltimore Ave','20781','Hyattsville','MD','2402963030',4.5,'ethiopian',307,38.96133,-76.93983,'C0004'),
('R0180','Shanghai Tokyo Cafe',2,'8300 Baltimore Ave','20740','College Park','MD','3012201998',3,'sushi',136,38.99254,-76.93366,'C0002'),
('R0181','Shortcake Bakery',1,'4700 Rhode Island Ave','20781','Hyattsville','MD','3017792836',4.5,'bakeries',113,38.94664,-76.94561,'C0004'),
('R0182','Sierras Grill & Taqueria',2,'11619 Beltsville Dr','20705','Beltsville','MD','3015727830',4,'mexican',233,39.04848,-76.93831,'C0001'),
('R0183','Silver Diner',2,'6040 Greenbelt Rd','20770','Greenbelt','MD','3012200028',3.5,'diners',371,38.99813,-76.91002,'C0003'),
('R0184','Simply Banh Mi',1,'1624 Wisconsin Ave NW','20007','Washington','DC','2023335726',4.5,'vietnamese',554,38.91147,-77.06571,'C0006'),
('R0185','Spice 6 Modern Indian',2,'5501 Baltimore Ave','20781','Hyattsville','MD','3012090080',4,'indpak',480,38.95566,-76.93991,'C0004'),
('R0186','Stachowskis Market',2,'1425 28th St NW','20007','Washington','DC','2025063125',4.5,'butcher',453,38.90924,-77.05691,'C0006'),
('R0187','Subbs by Carl',1,'2208 Rhode Island Ave NE','20018','Washington','DC','2025296225',4.5,'sandwiches',101,38.93059,-76.97376,'C0006'),
('R0188','Sugar Vault Desserts',2,'5606 Baltimore Ave','20781','Hyattsville','MD','2404876440',4,'cupcakes',112,38.95655,-76.94033,'C0004'),
('R0189','Sushi Jin',2,'8555-A Fenton St','20910','Silver Spring','MD','3016080990',4,'japanese',567,38.99744,-77.02628,'C0005'),
('R0190','Sushi Rock',2,'1900 Clarendon Blvd','22201','Arlington','VA','5713128027',3.5,'sushi',1112,38.89161,-77.08122,'C0012'),
('R0191','Sushinado & Teriyaki',2,'6450 America Blvd','20782','Hyattsville','MD','3012771970',4,'japanese',128,38.96782,-76.95236,'C0004'),
('R0192','Swahili Village Bar & Grill',2,'10800 Rhode Island Ave','20705','Beltsville','MD','2409657651',4,'african',260,39.03332,-76.91413,'C0001'),
('R0193','Sweet & Natural',2,'4009 34th St','20712','Mount Rainier','MD','3012779338',4.5,'vegan',179,38.93855,-76.96060,'C0010'),
('R0194','sweetgreen',2,'8300 Baltimore Ave','20740','College Park','MD','2407704443',4,'vegetarian',99,38.99228,-76.93355,'C0002'),
('R0195','Tacos 5 De Mayo Restaurant',1,'7201 Annapolis Rd','20784','Hyattsville','MD','3013062074',4.5,'mexican',190,38.94693,-76.89143,'C0004'),
('R0196','Tacos El Chilango Food Truck',1,'1723 14th St N','22209','Arlington','VA','7035276342',4.5,'foodtrucks',556,38.89067,-77.07782,'C0012'),
('R0197','Tacos Tortas & Tequila',2,'8407 Ramsey Ave','20910','Silver Spring','MD','3017556132',4,'mexican',255,38.99395,-77.02900,'C0005'),
('R0198','Taqueria Habanero',NULL,'8145 Baltimore Ave','20740','College Park','MD','2402414486',4.5,'tacos',120,38.99123,-76.93244,'C0002'),
('R0199','Taqueria La Placita',1,'5020 Edmonston Rd','20781','Hyattsville','MD','3012774477',4,'mexican',244,38.95045,-76.92615,'C0004'),
('R0200','Tara Thai',2,'5501 Baltimore Ave','20781','Hyattsville','MD','3012777888',3,'thai',178,38.95555,-76.93988,'C0004'),
('R0201','Ten Rens Tea Time',1,'7418 Baltimore Ave','20740','College Park','MD','3018648920',3.5,'tea',330,38.98161,-76.93807,'C0002'),
('R0202','Thai At Silver Spring',2,'921 E Ellsworth Dr','20910','Silver Spring','MD','3016500666',3.5,'thai',312,38.99627,-77.02683,'C0005'),
('R0203','The Big Greek Cafe',1,'8223 Georgia Ave','20910','Silver Spring','MD','3015874733',4.5,'greek',644,38.99238,-77.02635,'C0005'),
('R0204','The Board and Brew',2,'8150 Baltimore Ave','20740','College Park','MD','2405424613',4,'coffee',260,38.99173,-76.93426,'C0002'),
('R0205','The Italian Store',1,'3123 Lee Hwy','22201','Arlington','VA','7035286266',4,'delis',944,38.89663,-77.09635,'C0012'),
('R0206','The Jerk Pit',2,'9078 Baltimore Ave','20740','College Park','MD','3019825375',3,'caribbean',404,39.00274,-76.93127,'C0002'),
('R0207','The Society Lounge',2,'8229 Georgia Ave','20910','Silver Spring','MD','3015658864',3.5,'caribbean',482,38.99255,-77.02617,'C0005'),
('R0208','The Waterhole',1,'4004 34th St','20712','Mount Rainier','MD','3016990030',4.5,'coffee',66,38.93840,-76.96084,'C0010'),
('R0209','Three Brothers Italian Restaurant',1,'6160 Greenbelt Rd','20770','Greenbelt','MD','3014745330',3.5,'pizza',58,38.99942,-76.90834,'C0003'),
('R0210','Town Hall Liquors',1,'8135 Baltimore Ave','20740','College Park','MD','3014743322',4,'beer_and_wine',40,38.99096,-76.93369,'C0002'),
('R0211','Trinity Grill & Bar',2,'3010 Hamilton St','20782','Hyattsville','MD','2407706611',4,'bars',143,38.95626,-76.96453,'C0004'),
('R0212','Tupelo Honey',2,'1616 N Troy St','22201','Arlington','VA','7032538140',3.5,'southern',1664,38.89203,-77.08223,'C0012'),
('R0213','Tutti Frutti Frozen Yogurt',1,'12058 Cherry Hill Rd','20904','Silver Spring','MD','3015722632',4.5,'juicebars',46,39.05561,-76.95402,'C0005'),
('R0214','Urban Butcher',3,'8226 Georgia Ave','20910','Silver Spring','MD','3015855800',3.5,'bars',719,38.99239,-77.02709,'C0005'),
('R0215','Vigilante Coffee',2,'8200 Baltimore Ave','20740','College Park','MD','3012201016',4.5,'coffee',89,38.99208,-76.93387,'C0002'),
('R0216','Washington National Cathedral',NULL,'3101 Wisconsin Ave NW','20016','Washington','DC','2025376200',4.5,'churches',268,38.93060,-77.07079,'C0006'),
('R0217','Wawa',1,'10515 Baltimore Avenue','20705','Beltsville','MD','3015952013',3.5,'sandwiches',74,39.02747,-76.91764,'C0001'),
('R0218','Woodlands Indian Restaurant',2,'8046 New Hampshire Ave','20783','Langley Park','MD','3014344202',4,'indpak',363,38.99107,-76.98765,'C0007'),
('R0219','Yia Yias Kitchen',2,'10413 Baltimore Ave','20705','Beltsville','MD','3015951855',4,'greek',417,39.02670,-76.91873,'C0001'),
('R0220','Yogi Castle',1,'5501 Baltimore Ave','20781','Hyattsville','MD','3014548138',4,'icecream',42,38.95555,-76.93988,'C0004'),
('R0221','Zeds Cafe',1,'8225 Georgia Ave','20910','Silver Spring','MD','3014955614',4.5,'coffee',242,38.99246,-77.02635,'C0005');

INSERT INTO [Jelp.User] VALUES
('U0001','Nathan L.'),('U0215','George E.'),('U0429','Sharon L.'),
('U0002','Max S.'),('U0216','Shivani G.'),('U0430','Karina M.'),
('U0003','Hiral D.'),('U0217','Carrie N.'),('U0431','Dan A.'),
('U0004','Sakinah T.'),('U0218','Monica K.'),('U0432','Mark C.'),
('U0005','Coco C.'),('U0219','Jiro W.'),('U0433','Christine S.'),
('U0006','Kristi D.'),('U0220','Rizma W.'),('U0434','Kimberly G.'),
('U0007','Brian C.'),('U0221','Marietta C.'),('U0435','Sebastian M.'),
('U0008','Sabrina D.'),('U0222','Mia S.'),('U0436','Hiral D.'),
('U0009','Elizabeth H.'),('U0223','Tasha S.'),('U0437','Kia J.'),
('U0010','K B.'),('U0224','Teri S.'),('U0438','Amy A.'),
('U0011','Jade V.'),('U0225','Kate W.'),('U0439','Rafa R.'),
('U0012','Emily C.'),('U0226','Jacqueline K.'),('U0440','Danny A.'),
('U0013','Shivani G.'),('U0227','Naomi H.'),('U0441','Seth F.'),
('U0014','Alfonze D.'),('U0228','Ravi C.'),('U0442','Mat G.'),
('U0015','Chuq Y.'),('U0229','Elizabeth L.'),('U0443','Christina H.'),
('U0016','Lexy S.'),('U0230','Jiro W.'),('U0444','Christine J.'),
('U0017','Tyron H.'),('U0231','Larry  M.'),('U0445','Bobby Y.'),
('U0018','Kimmi H.'),('U0232','Liz K.'),('U0446','Shahnam Y.'),
('U0019','Dave F.'),('U0233','Sarah A.'),('U0447','Nathalie K.'),
('U0020','Alex A.'),('U0234','Libby F.'),('U0448','Lydia A.'),
('U0021','Anas E.'),('U0235','Cindy L.'),('U0449','Kristine M.'),
('U0022','Tara O.'),('U0236','Jen A.'),('U0450','C C.'),
('U0023','K B.'),('U0237','Annie S.'),('U0451','Vincy F.'),
('U0024','Rachel Y.'),('U0238','Joseph L.'),('U0452','Danielle H.'),
('U0025','DON C.'),('U0239','Kyla G.'),('U0453','Janet D.'),
('U0026','Emi M.'),('U0240','Lynn O.'),('U0454','Patricia H.'),
('U0027','Ifeoma I.'),('U0241','Sabrina P.'),('U0455','Erin A.'),
('U0028','Ky W.'),('U0242','Kim M.'),('U0456','Dan T.'),
('U0029','Iulia G.'),('U0243','Juliet A.'),('U0457','Claude G.'),
('U0030','Mark G.'),('U0244','Damian R.'),('U0458','Ruth C.'),
('U0031','Marc S.'),('U0245','TaNeisha J.'),('U0459','Eileen A.'),
('U0032','Dan A.'),('U0246','Tracey T.'),('U0460','Markus R.'),
('U0033','Suarez Findlay F.'),('U0247','Sarah V.'),('U0461','Mariano S.'),
('U0034','Shirley C.'),('U0248','Jennifer V.'),('U0462','Seth F.'),
('U0035','Charles M.'),('U0249','Missy P.'),('U0463','Stephanie G.'),
('U0036','Jo B.'),('U0250','Stephanie H.'),('U0464','Mary D.'),
('U0037','Denise T.'),('U0251','Jess N.'),('U0465','Lyba K.'),
('U0038','Gloria R.'),('U0252','Patti S.'),('U0466','Karen R.'),
('U0039','Tracy V.'),('U0253','Jeremy A.'),('U0467','Karene S.'),
('U0040','Ivy J.'),('U0254','M W S.'),('U0468','Doug B.'),
('U0041','Sam R.'),('U0255','Will C.'),('U0469','Jessica W.'),
('U0042','Tommy C.'),('U0256','Hangda Z.'),('U0470','Jonathan T.'),
('U0043','Jessie G.'),('U0257','Oneisha P.'),('U0471','Celeta T.'),
('U0044','Kat L.'),('U0258','Se C.'),('U0472','Fae P.'),
('U0045','Michael H.'),('U0259','Zev K.'),('U0473','Lauren C.'),
('U0046','Pieter B.'),('U0260','Van Anh N.'),('U0474','Yofriend H.'),
('U0047','Ursula D.'),('U0261','Lisa S.'),('U0475','Paul H.'),
('U0048','Yoshani R.'),('U0262','Tiffany L.'),('U0476','Shelly J.'),
('U0049','Ant B.'),('U0263','Darioush B.'),('U0477','Calvin J.'),
('U0050','Whitney L.'),('U0264','Sarah C.'),('U0478','Lauren E.'),
('U0051','Athena A.'),('U0265','Lily S.'),('U0479','Jane F.'),
('U0052','Shelly J.'),('U0266','Priya M.'),('U0480','Z C.'),
('U0053','Heather A.'),('U0267','Andrew P.'),('U0481','Sabrina P.'),
('U0054','Emily M.'),('U0268','Andy A.'),('U0482','Islam M.'),
('U0055','Abhinav A.'),('U0269','Mandy P.'),('U0483','Juliet A.'),
('U0056','Anne A.'),('U0270','Caitlin O.'),('U0484','Ariel G.'),
('U0057','Bryan F.'),('U0271','Libby F.'),('U0485','David N.'),
('U0058','Anela S.'),('U0272','Ria K.'),('U0486','Michael Z.'),
('U0059','Sam C.'),('U0273','Marty W.'),('U0487','Kristi D.'),
('U0060','Michelle O.'),('U0274','Gary H.'),('U0488','Julee W.'),
('U0061','Ana A.'),('U0275','Mike Q.'),('U0489','Cristina R.'),
('U0062','Ahmed I.'),('U0276','Maria P.'),('U0490','Nessa R.'),
('U0063','Cici C.'),('U0277','Haley M.'),('U0491','Dave H.'),
('U0064','Ray R.'),('U0278','Bernie P.'),('U0492','Sean L.'),
('U0065','Imad S.'),('U0279','Nick P.'),('U0493','Elaine N.'),
('U0066','Ryan C.'),('U0280','Claire M.'),('U0494','Sarah A.'),
('U0067','Ashlee S.'),('U0281','Kent S.'),('U0495','Jovete E.'),
('U0068','Alex B.'),('U0282','Eleanor A.'),('U0496','Kiara C.'),
('U0069','Neha B.'),('U0283','Shine W.'),('U0497','Dan M.'),
('U0070','Jennifer W.'),('U0284','Alaya M.'),('U0498','Steve R.'),
('U0071','Jack W.'),('U0285','Natalie T.'),('U0499','Zakia J.'),
('U0072','MaryBeth W.'),('U0286','Seanniece B.'),('U0500','Leah Y.'),
('U0073','Sara L.'),('U0287','Jerry S.'),('U0501','Tiffany L.'),
('U0074','James R.'),('U0288','Christian L.'),('U0502','Triple L.'),
('U0075','Cristina R.'),('U0289','Kelly V.'),('U0503','Hilary K.'),
('U0076','Krissia M.'),('U0290','Dechen S.'),('U0504','H T.'),
('U0077','Diana C.'),('U0291','Abha A.'),('U0505','Justin S.'),
('U0078','Nancy L.'),('U0292','James W.'),('U0506','Jo L.'),
('U0079','Blythe C.'),('U0293','Evelyn T.'),('U0507','Mark C.'),
('U0080','Bianca H.'),('U0294','Shelly J.'),('U0508','HP D.'),
('U0081','Carmen M.'),('U0295','Gary H.'),('U0509','TJ F.'),
('U0082','K F.'),('U0296','Tiffany L.'),('U0510','Chin D.'),
('U0083','K F.'),('U0297','Tiffany L.'),('U0511','Chin D.'),
('U0084','Kianna K.'),('U0298','Lyn J.'),('U0512','Gina H.'),
('U0085','Chris D.'),('U0299','Shelly J.'),('U0513','Dan A.'),
('U0086','Blythe C.'),('U0300','Ivy J.'),('U0514','Hiral D.'),
('U0087','Destinie S.'),('U0301','Shannon F.'),('U0515','Kat W.'),
('U0088','Carey B.'),('U0302','Lucy M.'),('U0516','Ann T.'),
('U0089','Paul H.'),('U0303','Colleen M.'),('U0517','Liz B.'),
('U0090','Mao V.'),('U0304','Allison C.'),('U0518','Giselle Z.'),
('U0091','Jennifer J.'),('U0305','Phi L.'),('U0519','Shawna M.'),
('U0092','Jake L.'),('U0306','Ifeoma I.'),('U0520','Shani L.'),
('U0093','Celeta T.'),('U0307','Alexis D.'),('U0521','Brooklyn C.'),
('U0094','Katrina V.'),('U0308','Amanda K.'),('U0522','Shivani G.'),
('U0095','Billy V.'),('U0309','Ivy J.'),('U0523','Linh P.'),
('U0096','Andrew P.'),('U0310','India F.'),('U0524','Jennifer J.'),
('U0097','Liz C.'),('U0311','Zach W.'),('U0525','Glenn G.'),
('U0098','Charles H.'),('U0312','Karina E.'),('U0526','Hannah B.'),
('U0099','Rob A.'),('U0313','Pras C.'),('U0527','Rich K.'),
('U0100','Tom T.'),('U0314','Joanna W.'),('U0528','Zo W.'),
('U0101','Geoff M.'),('U0315','Muhamed A.'),('U0529','Christina H.'),
('U0102','Will C.'),('U0316','Janine T.'),('U0530','Will M.'),
('U0103','Luliaa A.'),('U0317','Sivilay T.'),('U0531','Sarah B.'),
('U0104','Kristi D.'),('U0318','Joyce N.'),('U0532','Edward M.'),
('U0105','Tom H.'),('U0319','Nessa R.'),('U0533','Juan V.'),
('U0106','Jose V.'),('U0320','Jasmine N.'),('U0534','Margy C.'),
('U0107','Aisha P.'),('U0321','Rumit P.'),('U0535','Brent L.'),
('U0108','Lynne S.'),('U0322','Jeni S.'),('U0536','Marilyn K.'),
('U0109','Jordan H.'),('U0323','Kevin Y.'),('U0537','Charles M.'),
('U0110','Jennifer J.'),('U0324','Brenda T.'),('U0538','M. A.'),
('U0111','Ashley S.'),('U0325','april w.'),('U0539','Heather C.'),
('U0112','Tom G.'),('U0326','Mozelle B.'),('U0540','Porsche T.'),
('U0113','Shelly J.'),('U0327','Hamza B.'),('U0541','Cynthia M.'),
('U0114','Florence J.'),('U0328','Laurine T.'),('U0542','Michael K.'),
('U0115','Gen S.'),('U0329','Byron T.'),('U0543','Jian C.'),
('U0116','Vin D.'),('U0330','Exotic L.'),('U0544','Ayush M.'),
('U0117','Garvin C.'),('U0331','Hui C.'),('U0545','Amy L.'),
('U0118','Sindy T.'),('U0332','Ben R.'),('U0546','Dominique S.'),
('U0119','Seanniece B.'),('U0333','Donyiel C.'),('U0547','Lydia R.'),
('U0120','Rhonda C.'),('U0334','Leo U.'),('U0548','Kelli B.'),
('U0121','John K.'),('U0335','Charlay J.'),('U0549','Una D.'),
('U0122','Madison O.'),('U0336','Evan G.'),('U0550','Joe W.'),
('U0123','Will F.'),('U0337','Arianna P.'),('U0551','Michelle M.'),
('U0124','Jorge P.'),('U0338','Sharon L.'),('U0552','Jordan C.'),
('U0125','V E.'),('U0339','Lisa L.'),('U0553','Manuel L.'),
('U0126','Tiffany H.'),('U0340','Aundrea G.'),('U0554','Abegail A.'),
('U0127','Just Us 2.'),('U0341','Melissa B.'),('U0555','Toshonie W.'),
('U0128','Raymond M.'),('U0342','Robert G.'),('U0556','Nichelle D.'),
('U0129','Dave C.'),('U0343','Nessa R.'),('U0557','Janelle C.'),
('U0130','Tommy C.'),('U0344','Vincent C.'),('U0558','Hwal L.'),
('U0131','Vern R.'),('U0345','Carol K.'),('U0559','Bobby Y.'),
('U0132','Jovany J.'),('U0346','George S.'),('U0560','Maya G.'),
('U0133','Michael I.'),('U0347','Daniel B.'),('U0561','Jalonda W.'),
('U0134','Jane P.'),('U0348','VyVy V.'),('U0562','Danarae S.'),
('U0135','J B.'),('U0349','Shane C.'),('U0563','Michael A.'),
('U0136','Johnnie P.'),('U0350','Bruce K.'),('U0564','Nacho O.'),
('U0137','Liza G.'),('U0351','Shaheen T.'),('U0565','Jody M.'),
('U0138','Liza G.'),('U0352','Shaheen T.'),('U0566','Jody M.'),
('U0139','Donyiel C.'),('U0353','Mike R.'),('U0567','Nessa R.'),
('U0140','Gina C.'),('U0354','Bin R.'),('U0568','Sandy O.'),
('U0141','Matthew S.'),('U0355','Samantha C.'),('U0569','Karla V.'),
('U0142','Christine K.'),('U0356','Mary D.'),('U0570','Christine L.'),
('U0143','Sean B.'),('U0357','Marlin H.'),('U0571','Jas G.'),
('U0144','Christine Y.'),('U0358','Ifeoma I.'),('U0572','Lydia W.'),
('U0145','Pasha M.'),('U0359','Danny C.'),('U0573','Abigail L.'),
('U0146','Lisa L.'),('U0360','Mo L.'),('U0574','Sandy B.'),
('U0147','Joy F.'),('U0361','Alex W.'),('U0575','Nkanyezi P.'),
('U0148','Debra B.'),('U0362','Sharon Y.'),('U0576','Charlie J.'),
('U0149','Mike Q.'),('U0363','Ashanti H.'),('U0577','Donyiel C.'),
('U0150','Demilicious J.'),('U0364','Jason L.'),('U0578','Toni D.'),
('U0151','Katie H.'),('U0365','Kimie V.'),('U0579','Genie F.'),
('U0152','Barry S.'),('U0366','Sarah H.'),('U0580','Patrick M.'),
('U0153','Monique M.'),('U0367','Karema P.'),('U0581','Maria O.'),
('U0154','Joan N.'),('U0368','Krishna Bhavithavya K.'),('U0582','Christina L.'),
('U0155','Mr. Gary S M.'),('U0369','Chris B.'),('U0583','Steve R.'),
('U0156','Jerry S.'),('U0370','J B.'),('U0584','Kell M.'),
('U0157','Athena A.'),('U0371','Donna Y.'),('U0585','Eric C.'),
('U0158','Mary D.'),('U0372','Andy B.'),('U0586','Rebecca L.'),
('U0159','Mike H.'),('U0373','Bub D.'),('U0587','Hina A.'),
('U0160','Shelly J.'),('U0374','Alex A.'),('U0588','Dan A.'),
('U0161','Melinda S.'),('U0375','Kell M.'),('U0589','Jay S.'),
('U0162','Linora C.'),('U0376','Samantha L.'),('U0590','Casey V.'),
('U0163','Scott A.'),('U0377','Kim P.'),('U0591','Nilsu G.'),
('U0164','Vincent G.'),('U0378','Howard M.'),('U0592','Paul B.'),
('U0165','Jas W.'),('U0379','Subha S.'),('U0593','Max S.'),
('U0166','Crystal H.'),('U0380','Wilma O.'),('U0594','Shelly J.'),
('U0167','Matthew F.'),('U0381','Jennifer C.'),('U0595','Nan P.'),
('U0168','Casper C.'),('U0382','Jessie G.'),('U0596','Kylessia R.'),
('U0169','Khoi N.'),('U0383','Juliet A.'),('U0597','Mina L.'),
('U0170','Vanessa N.'),('U0384','Danielle O.'),('U0598','Sarah Z.'),
('U0171','Justine K.'),('U0385','Sally H.'),('U0599','Rich S.'),
('U0172','Tava W.'),('U0386','John B.'),('U0600','Amy F.'),
('U0173','Allie N.'),('U0387','Matthew S.'),('U0601','Hyuna L.'),
('U0174','Shannon W.'),('U0388','Linda O.'),('U0602','Nessa R.'),
('U0175','Rakesh R.'),('U0389','Stephanie A.'),('U0603','Callie T.'),
('U0176','Nille P.'),('U0390','Randolph Z.'),('U0604','Thad A.'),
('U0177','Lexie G.'),('U0391','Priscilla T.'),('U0605','Cathy Z.'),
('U0178','Michele W.'),('U0392','Sophia H.'),('U0606','Meghan P.'),
('U0179','Max S.'),('U0393','Evan S.'),('U0607','Dan A.'),
('U0180','Evan P.'),('U0394','Austin G.'),('U0608','Latisha W.'),
('U0181','Tony H.'),('U0395','C M.'),('U0609','C. C.'),
('U0182','Michael N.'),('U0396','Kaity K.'),('U0610','Erin T.'),
('U0183','Dwight G.'),('U0397','Mayura I.'),('U0611','Annika K.'),
('U0184','Krishna Bhavithavya K.'),('U0398','A. B.'),('U0612','Helena O.'),
('U0185','Whitney L.'),('U0399','Katty M.'),('U0613','Vivian J.'),
('U0186','Rebekah S.'),('U0400','Kubasa C.'),('U0614','Carrie N.'),
('U0187','Jessie G.'),('U0401','Van Anh N.'),('U0615','Anonymous U.'),
('U0188','Will C.'),('U0402','Matt A.'),('U0616','Khashiffa R.'),
('U0189','Sarah D.'),('U0403','Alisa L.'),('U0617','Spencer D.'),
('U0190','Robert R.'),('U0404','Natalie M.'),('U0618','Gary C.'),
('U0191','Chuq Y.'),('U0405','Alisa L.'),('U0619','NinaDivaStar P.'),
('U0192','Melissa L.'),('U0406','Mike R.'),('U0620','Mike Q.'),
('U0193','Nashra Z.'),('U0407','Jody K.'),('U0621','Jenny N.'),
('U0194','Jeck F.'),('U0408','Jennifer J.'),('U0622','Yi-Hung C.'),
('U0195','Blythe C.'),('U0409','Roland G.'),('U0623','D B.'),
('U0196','Julee W.'),('U0410','Rebecca F.'),('U0624','Kyle D.'),
('U0197','Allie N.'),('U0411','Mo L.'),('U0625','Danny M.'),
('U0198','Arianna P.'),('U0412','David C.'),('U0626','Amanda K.'),
('U0199','Coco T.'),('U0413','Monique C.'),('U0627','Katrina L.'),
('U0200','Mike W.'),('U0414','Troy K.'),('U0628','Michelle H.'),
('U0201','Shannon W.'),('U0415','Seanniece B.'),('U0629','Felicia W.'),
('U0202','James G.'),('U0416','Melanie B.'),('U0630','Joe B.'),
('U0203','Sam H.'),('U0417','Brent L.'),('U0631','Kristie J.'),
('U0204','Pousy M.'),('U0418','Toy S.'),('U0632','Bernice M.'),
('U0205','Kirsten L.'),('U0419','Jiro W.'),('U0633','Charnika P.'),
('U0206','Whitney L.'),('U0420','Sidney H.'),('U0634','Brittany H.'),
('U0207','Katelyn K.'),('U0421','Brit M.'),('U0635','Navi B.'),
('U0208','Maria T.'),('U0422','Angel L.'),('U0636','Elich O.'),
('U0209','Jenny P.'),('U0423','Amanda J.'),('U0637','Jason V.'),
('U0210','Shelly J.'),('U0424','Jennifer J.'),('U0638','Gisell G.'),
('U0211','Bernadette C.'),('U0425','Our Food V.'),('U0639','Ramya R.'),
('U0212','Carolina R.'),('U0426','Casper C.'),('U0640','Kimi K.'),
('U0213','Deepika Y.'),('U0427','Nessa R.'),('U0641','Sofia B.'),
('U0214','Tasneem A.'),('U0428','Sophia H.'),('U0642','Avid T.');



INSERT INTO [Jelp.Review] VALUES('V0001',5,'5/5 did not disappoint. I came to 1789 for a dinner this past week and left very happy with my restaurant experience. For an appetizer we ordered crab cakes...','R0001','U0001'),('V0215',5,'I recommend 1789 for anyone looking for a fine dining, four dollar sign experience. The website says jacket required and I wore one, but many of the others...','R0001','U0215'),('V0429',3,'My boyfriend and I came here on Saturday to try out their summer menu which is basically the restaurant week menu except it is $49 instead of $35 :( .



The...','R0001','U0429'),
('V0002',5,'Plain and simple: This pizza is delicious. 



The crust is unreal. Crunchy outside with that soft inside.



I honestly cant believe its taken me this long...','R0002','U0002'),('V0216',4,'I came here on a Tuesday night with a friend and this place was PACKED. We had to wait 30 minutes for a table for two, which I was not expecting for a...','R0002','U0216'),('V0430',5,'Before the plethora of Neapolitan pizza places started popping up all over the DMV, there was 2 Amys.  It isnt just the excellent pizza that makes this...','R0002','U0430'),
('V0003',4,'Very tasty Ethiopian food and nice people running the restaurant. 



Its a bit pricier than other Ethiopian restaurants Ive been to in the area, but I...','R0003','U0003'),('V0217',4,'With so many Ethiopian options in Downtown Silver Spring, its often hard to choose - but Abol has become by go-to. The food is consistently top notch....','R0003','U0217'),('V0431',5,'This is My first time time ordering from this place and i really like it. 



I have always love to try different type of food from diffirent countries and...','R0003','U0431'),
('V0004',5,'I could not be more happy with the fine service, food and overall ambiance of All Set Restaurant. Everyone commented on how friendly the staff of servers...','R0004','U0004'),('V0218',3,'My party and I were looking for a bar in the area with a variety of food options. I discovered All Set on yelp and saw they had seafood options. Many people...','R0004','U0218'),('V0432',4,'Tons of metered parking in the area. Located in downtown silver spring. Accepts both cash and credit card. Came here for lunch and let me say that it was...','R0004','U0432'),
('V0005',5,'Love the light and airy interior. Unique brunch menu with a mixed of classic egg brunch dishes and Balkan options. I wanted to try something new and ordered...','R0005','U0005'),('V0219',4,'I am not entirely sure why this place is listed as "Eastern European" as the menu just seems like pan-European with a few Eastern European influenced dishes...','R0005','U0219'),('V0433',5,'I came here with some friends for their bottomless brunch. I appreciated the variety of drinks and the variety and quality of the food. I especially enjoyed...','R0005','U0433'),
('V0006',4,'Nothing negative to say but it wasnt life changing, but it was good. I am conflicted. Anyway, I ordered soup!



I ordered the Tom Kha soup, it had tofu (but...','R0006','U0006'),('V0220',3,'3.5 stars



Decent pad thai. Great spring rolls.



Pro Tip: the pad Thai tastes much better after spending the night in the fridge.



While the portion sizes...','R0006','U0220'),('V0434',3,'Amina Thai was a not a bad spot in Silver Spring for dinner. Walked in to a very spacious and clean restaurant. Service was friendly and quick to take our...','R0006','U0434'),
('V0007',5,'Get the pabellon arepa and a genie will appear and grant you three wishes - its JUST. THAT. MAGICAL. 



fresh and packed with flavor, these are the best...','R0007','U0007'),('V0221',4,'Arepas, teque“os, cachapas, patacones? Im all in!



Came to the Union Market and with soooo many food options to choose from my eyes and heart went straight...','R0007','U0221'),('V0435',5,'This place is too good. I have to stop by whenever Im in Union Market, theres no need to eat anywhere else. My favorite is (any toping) inside a cachapa....','R0007','U0435'),
('V0008',5,'I was walking around trying to kill some time before check-in at my hotel and stumbled upon this place. Not a lot of seating inside but it was 3pm so it...','R0008','U0008'),('V0222',4,'A hole in the wall Colombian spot located in Downtown Silver Spring. Solid Colombian dishes, I was very excited to see what the madness was about. I ordered...','R0008','U0222'),('V0436',4,'Best side of rice and black beans Ive had. They add cilantro and spices and its delicious on its own. Also get the empanadas with the dipping sauce. Id...','R0008','U0436'),
('V0009',5,'My go-to place if Im craving thai food when Im on campus! 



My favorite dishes at Aroy are the panang curry with tofu and drunken noodles with tofu. The...','R0009','U0009'),('V0223',5,'Service/Cleanliness:



You walk in and can just smell the Thai yumminess being Chefd up! I came in for lunch with a friend to enjoy their lunch special...','R0009','U0223'),('V0437',5,'Im rarely in this area of Maryland, but my sister prepared an outing for us. We wanted Thai and found this place the night before. We were first to arrive...','R0009','U0437'),
('V0010',5,'I am surprised by the rating. I went here a while ago as an account exec for the local news station. The food was great then. Im almost 8 years since it...','R0010','U0010'),('V0224',2,'The frozen margarita - was $10, and i couldnt detect any tequila in it.  Definitely not calorie or dollar worthy.  The chips - bland.  Store brand tortilla...','R0010','U0224'),('V0438',4,'Im updating my review. They have finally improve their wine selection! They now have Bartenura Moscato! They had Moscato before but it was one of the lower...','R0010','U0438'),
('V0011',5,'YUM YUM YUM



What a solid place in Clarendon.  Tucked next to Ambar, this restaurant hosts a chic yet relaxing experience. The drink menu is unique with...','R0011','U0011'),('V0225',4,'Mediocre and limited cocktail menu, also very expensive. Im talking 15 dollars for their take on an old fashioned. However I keep going back because the...','R0011','U0225'),('V0439',3,'The food and the brunch deal were amazing. The drinks that you can get on the deal for brunch are phenomenal!



I would highly recommend the one with coffee...','R0011','U0439'),
('V0012',5,'Bagel place tastes like home. So many great sandwiches to choose from - I love the Spinach Cheese Melt and the Power Bagel.','R0012','U0012'),('V0226',2,'After this visit, I want to say that this place is not good for families or women. I literally heard women referred to as "bitches" by three different...','R0012','U0226'),('V0440',5,'The Bagel Place of College Park is the BEST spot for delicious BAGELS!!! Im a proud UMD alum, but for some odd reason, I only ate here once as a student....','R0012','U0440'),
('V0013',5,'An absolute Georgetown stable, and better than Georgetown Cupcake any day. Whether you are a DC/Georgetown native or visitor you HAVE to come to Baked and...','R0013','U0013'),('V0227',4,'I saw reviews of this place everywhere, even though Im not a big fan on sweets I needed to stop by.

There were so many options of different cookies and...','R0013','U0227'),('V0441',4,'Ive been to Baked & Wired several times. Each visit, I come with two key objectives: (1) baking and (2) wiring. 



This review is largely based off of the...','R0013','U0441'),
('V0014',5,'One of the best Vietnamese restaurants in the area. They have all the classic Vietnamese dishes: Pho, Banh Mi, Rolls, Vietnamese Coffee, etc. They have a...','R0015','U0014'),('V0228',5,'First time coming here since moving from Orange County, California and all I have to say is WOW. Coming from somewhere that has one of the highest...','R0015','U0228'),('V0442',5,'Meal Quality:  They offer a most excellent Vietnamese pork sandwich and a Beef Pho dish!  Everything is made fresh and with fine care.



Aesthestic Appeal &...','R0015','U0442'),
('V0015',5,'I walked by Bandoola Bowl one day when looking for lunch near my office. It looked pretty dead from the outside, but I guess without a lot of seating, a lot...','R0016','U0015'),('V0229',4,'Bandoola bowl is fresh, light, & very quick. Im assuming this is a relatively new business. The staff were extremely friendly and polite. They had lots of...','R0016','U0229'),('V0443',5,'I was surprised to come across this listing on Yelp - very rarely do you see a place rated 5 starts with over a hundred reviews! But after having gone here,...','R0016','U0443'),
('V0016',5,'This place was fantastic. Many things caught my eye on the menu but I would up choosing cocoli which were donuts in truffle honey with prosciutto and...','R0017','U0016'),('V0230',2,'Typical east coast generic food. Overall, I will admit the quality is very good. I had the steak (although I cant remember the details and it was only last...','R0017','U0230'),('V0444',2,'Had a pretty disappointing meal here. Im going to start with the dessert which was the worst part of the meal. We got the smores dessert and it tasted...','R0017','U0444'),
('V0017',4,'Hook N Reel used to be my favorite seafood spot in PG county but theyre annoyingly inconsistent. Thankfully, BeClaws demonstrated a better way of doing...','R0018','U0017'),('V0231',2,'So Im a little bummed to be writing this review after loving this companys other location so much. 

The food is still Awesome, BUT......

The service here...','R0018','U0231'),('V0445',5,'Very impressed (finally) with my most recent (and 7th?) visit to this continuously improving restaurant! Considering there is new competition nearby in...','R0018','U0445'),
('V0018',5,'Super friendly service and the vegan Veggie Combination Plate was delish!



Weather was perfect on the outdoor patio and my pup was comfortable as we enjoyed...','R0019','U0018'),('V0232',5,'This is my favorite Ethiopian restaurant. It is small, family owned and operated restaurant in a converted home, and the food is always so fresh and...','R0019','U0232'),('V0446',5,'Amazing food, great service, cozy homey atmosphere. Ill definitely be back! I ordered the meat combo and I loved everything on it. I thought the table...','R0019','U0446'),
('V0019',5,'Really nice Ethiopian food here. Had an interesting almost rare-cooked meat along with the veggie combo. Was easily enough for two people.



Waitress was...','R0020','U0019'),('V0233',4,'We were in Silver Spring for the day and took the opportunity to get Ethiopian food. This place was highly rated, and I can understand why! We ordered the...','R0020','U0233'),('V0447',4,'Silver Spring is Ethiopian cuisine central and Beteseb is a cornerstone of what actual Ethiopian food might be. Full disclosure: My dining partner wasnt as...','R0020','U0447'),
('V0020',5,'I was skeptical about This place , gave it a chance and let me tell you I was worth it ! Flavors all over !! And the choices for me where enough ! Im glad...','R0021','U0020'),('V0234',4,'I love getting to make my own choices, but I can be so indecisive. I love purple rice. Does it taste different than white?  I cant really say because of...','R0021','U0234'),('V0448',4,'BIbibop Asian grill in Silver Spring is healthy,easy, convenient, the service is decent for fast food, and Im always pleasantly satisfied with my order. I...','R0021','U0448'),
('V0021',5,'Honestly I dont know where to start from we went to bistro Aracosia Monday night for dinner and I was totally amazed, from the minute when walked it until...','R0022','U0021'),('V0235',5,'Came here for my birthday dinner with my boyfriend and we were both blown away by the food and the service! 



It was our first time trying Afghan food, and...','R0022','U0235'),('V0449',3,'Theyre just... okay. I ached the entire time, thinking about my prior experience at Afghan Bistro in Springfield (which, in a few words, exceeds my...','R0022','U0449'),
('V0022',5,'After the first time going here you cannot dream of a better oyster. Yes, its pricey but no, you havent had better seafood before this.



Private seating...','R0023','U0022'),('V0236',4,'food was delicious and ambiance was pretty great. we sat in the far back end of the restaurant which was key (it is a fish market so it gets really stinky...','R0023','U0236'),('V0450',4,'2 staff were chatting and standing by the reception area and neither greeted us right away. Thats how I usually judge the service of a restaurant so first...','R0023','U0450'),
('V0023',5,'Best. Pizza. 

Ask them to cook well done and extra crunchy. 

Get extra oregano too and put garlic sauce on outside crust before getting your sauce. 

Enjoy!','R0024','U0023'),('V0237',4,'Good pizza with the option to build your own. Thin crust and wood fired. There is ample seating and staff is friendly! More importantly, they are open late.','R0024','U0237'),('V0451',5,'Blaze is always a great choice when you are on the run, but Mr. Kent made it the best experience when I was living on the College Park campus for the...','R0024','U0451'),
('V0024',5,'The brother wanted to try this place given that it would be his last lunch in DC for 2 months so I came back & had a wonderful time. 



FOOD:

- Soup of the...','R0025','U0024'),('V0238',3,'The Blue Duck Tavern is an upscale chic, continental restaurant located in the heart of West End. Upon entering BDT, you automatically feel the level of...','R0025','U0238'),('V0452',2,'I took my boyfriend here for dinner on his birthday this past September. I was looking forward to the "Happy Birthday _____" menu but they spelled my...','R0025','U0452'),
('V0025',4,'Chicken Waaangs....with a "wholelotta" Swag and Flavah!!



As loud as I can say it...."BONCHON....is the ______!" .....To keep it...','R0026','U0025'),('V0239',3,'I like Bonchon for the most part. I love the crunch of their chicken and the flavors. I HATE how dry their rice is and that you cant get sauce for it (i...','R0026','U0239'),('V0453',4,'Tucked next to the movie theatre, a great l place to grab a bite before or after catching a film. I had the potstickers - 1/2 spicy 1/2 garlic and soy....','R0026','U0453'),
('V0026',5,'This is easily my favorite neighborhood eatery -- and with good reason. Not only is the food outstanding, but the beer and cocktails are good, and the...','R0027','U0026'),('V0240',4,'Brooklands Finest is located in NE, so its a bit off the beaten path for me. However, the atmosphere is pleasant and the menu is interesting. 



We went...','R0027','U0240'),('V0454',4,'I now know why its called Brooklands Finest! 



HITS:

Veggie Sandwich  delicious (my friend completely raved about it - particularly the patties used!)...','R0027','U0454'),
('V0027',5,'Buena vida was a memorable experience! We started off contemplating on what to get, and ended up going for the $49 unlimited small plates and drinks. 



I...','R0028','U0027'),('V0241',4,'My group made a reservation to come here on a Saturday morning for brunch and we were seated immediately. You can have the all-you-can-eat meal option for...','R0028','U0241'),('V0455',5,'Ill admit, I really wanted to go to Buena Vida because the pictures looked so cute, and Im from California so tacos always will be life. I finally went...','R0028','U0455'),
('V0028',3,'Fair disclaimer: this is gonna be a shorter review than I normally put out. I tend to stick to non-chain restaurant reviews...

Atmosphere: 3/5, what you...','R0029','U0028'),('V0242',5,'I had a amazing time today at BWW. My husband and I went today knowing that we might not get a seat. A friend of ours was there and let us sit with them....','R0029','U0242'),('V0456',1,'This Buffalo Wild Wings location was clean. Thats about all the good I can say about it. 



We ordered and it took about 15/20 minutes to get drinks. Then,...','R0029','U0456'),
('V0029',4,'I was in Silver Spring to pick up some tickets I had won from a radio station and of course I cant be in a new area without trying out a new coffee shop....','R0030','U0029'),('V0243',3,'Mixed feelings here. This is a really chill place and I love the vibe - music and coffee and community with a diverse group of patrons (although the common...','R0030','U0243'),('V0457',5,'Excellent coffeeshop. I stopped by here to catch up on work when visiting the DMV. Ive tried the other coffeeshops in the area which are also good (Zeds,...','R0030','U0457'),
('V0030',5,'They make great food, and I can tell that BurgerFi employs great emphasis on customer satisfaction.



I discovered this as a reprieve from a badly designed...','R0031','U0030'),('V0244',1,'Sadly Ive come here more times than Id like to admit. Each time thinking they might get their stuff together. They have decent burgers but every time Ive...','R0031','U0244'),('V0458',3,'Their mobile app sucks, Ive had problems with it before and on-site customer service hasnt really been helpful, so now we plan on not going unless we get...','R0031','U0458'),
('V0031',5,'High quality beverages and exceptional grub you have to check this fine establishment out!!

Out of towners in for a sports visit were directed here by our...','R0032','U0031'),('V0245',4,'So glad I decided to try Burtons. Food was great, service was even better, and the atmosphere was awesome.



Food: We tried the Philly Rolls, Signature...','R0032','U0245'),('V0459',5,'Ive been here several times. The service was very good and the food/drinks were wonderful. They have an interesting  cocktail list that has never...','R0032','U0459'),
('V0032',4,'Visited on a Sunday for brunch and arrived around noon.  Looked really busy but the wait was only 20 minutes.



We got our coffee quickly but a hot chocolate...','R0033','U0032'),('V0246',5,'Very trendy and cool place!

We stopped in for breakfast and I have to say the Sweet Potato Pancakes are The Best!!! OMG 



I love restaurants with outdoor...','R0033','U0246'),('V0460',3,'This location is perched in the center of Prince Georges Countys Gateway Arts District. Upon entering you may ask I s it a bookstore, a coffee shop, a...','R0033','U0460'),
('V0033',5,'I am a life-long connaiseur of Spanish Caribbean food both in and out of the U.S. This is one of the best I have tasted for Venezuelan food--and in DC, the...','R0034','U0033'),('V0247',4,'My parents and I tried the hallacas and they are legit! So good! My parents said they are very authentic. We are Venezuelan and they loved there for...','R0034','U0247'),('V0461',3,'Lets start with the male employee there, he treated me and offered me a sample of a rice milk drink. Its good. I tried the Cuban sandwich which is pork &...','R0034','U0461'),
('V0034',5,'Freshly baked cookies and quality ice cream! A little pricy, but I consider that normal for a food truck. I always get a "deconstructed" ice cream sandwich...','R0035','U0034'),('V0248',3,'Reposting this review which was removed by Yelp! because I apparently originally posted to the bricks and mortar location and not the food trucks page....','R0035','U0248'),('V0462',5,'Captain Cookie rolled through beautiful Tysons Corner, VA, where I just so happened to find myself on a vibrant spring morning. While my impetus for getting...','R0035','U0462'),
('V0035',5,'I got takeout from here and the food was delicious. Lets get this strait the sides were amazing. The fish needed a little old bay. I keep old bay in stock...','R0036','U0035'),('V0249',1,'Had a TERRIBLE TIME here yesterday 9/20/19. Carolina Kitchen is my FAVORITE eatery HOWEVER this location did not meet the courtesy mark last night . First...','R0036','U0249'),('V0463',3,'So Ive finally tried the famous Carolina Kitchen & I must say....the experience was underwhelming consider the boosting ppl have done about this place....','R0036','U0463'),
('V0036',5,'This Silver Spring Cava has become my very favorite lunch spot.  Ive been coming here since it replaced the old Baja Fresh at this location a couple years...','R0037','U0036'),('V0250',1,'One of the most disappointing meals Ive had in a LONG time- plus possible public health threat.   



I ordered: white rice, falafel, red pepper hummus,...','R0037','U0250'),('V0464',4,'This location is always on point.



Theyre fast, never skimp on a portion, and always listen keenly no matter the noise level. 



Silver Spring is busy and...','R0037','U0464'),
('V0037',5,'Ive been to Cava Mezze at least 5 times over the past few years. Their menu has changed but the food is always good and I always have a great time. I love...','R0038','U0037'),('V0251',5,'Best place in Clarendon for brunch and dinner IMO. Their bottomless brunch is worth every penny! Everything is delicious! You really cant go wrong here....','R0038','U0251'),('V0465',4,'I have been super Uber super intrigued to try Cava Mezze and I finally convinced my friends to come with me to try it out. I was really pleasantly surprised...','R0038','U0465'),
('V0038',5,'So yummy. All of the tacos are worth a try but my group agreed the potato and kale is the best one. Would recommend ordering a side or two to share with...','R0039','U0038'),('V0252',4,'Finally got to try Chaia Tacos after all my non-vegan friends had been raving about it all year. My bff and I went after a long day of wedding dress...','R0039','U0252'),('V0466',4,'This place is awesome. They have four tacos and three of them can be made vegan. On top of that, they even have vegan cheese options. Its so rare to find...','R0039','U0466'),
('V0039',4,'This little strip mall diner hit the spot for a quick breakfast while running errands. I had a sausage egg and cheese breakfast sandwich on an English...','R0040','U0039'),('V0253',4,'Great food and service. Would have given it a 5. But paper plates and plastic ware keep it from earning a 5.','R0040','U0253'),('V0467',2,'My first time here and Im totally disappointed with the service I received. The man at the register acted as if he couldnt be bothered to answer my...','R0040','U0467'),
('V0040',4,'I ordered the Nua Ka Ting and the green curry. The green curry was delish and I would definitely order again, the Nua Ka Ting was not that good to me. It...','R0041','U0040'),('V0254',3,'I like the food, when Im dining in, but the table arrangement is much to be desired.  Its like a cheap diner, squeezing a narrow area barely enough room...','R0041','U0254'),('V0468',5,'Charm Thai has great food and a great environment for both friends and lovers. While I did not come here with any of my lovers, I did have the yellow curry,...','R0041','U0468'),
('V0041',5,'This place is great -Üauthentic flavors that you cant get anywhere else in the DC area. I split an entree and appetizer with my pops and was FULL. The...','R0042','U0041'),('V0255',3,'Like many reviewers here, Ive had no experience eating Senegalese (or even West African) cuisine, so as such Im on weaker footing than I would be usually....','R0042','U0255'),('V0469',3,'I happened to be in the area so I looked up nearby restaurants that I should try. Chez Dior came up as a Senegalese restaurant. I have never had Senegalese...','R0042','U0469'),
('V0042',5,'Ching Ching Cha is an amazing tea house you dont see too often in the US, especially in DC proper. This is a great place to relax, drink tea, and fill your...','R0043','U0042'),('V0256',5,'Tea is the best and basically you can sit there and drink the one order of tea for the whole day. 



Mongolian dumplings, tea egg, sweets, curry chicken are...','R0043','U0256'),('V0470',3,'When I first walked by Ching Ching Cha, I thought to myself, "Damn, what a racist *ss name." But then I looked on Yelp, saw the high average, read a few...','R0043','U0470'),
('V0043',5,'Ive always had great service and great food from this Chipotle!  It was always fun to go dressed as a burrito on Halloween in college!','R0044','U0043'),('V0257',1,'This place was EXTREMELY unprofessional!! 

The workers just rush you out to talk with their friends. Its evident they dont give a shit.','R0044','U0257'),('V0471',4,'Cool location quick lines and plenty of parking nearby. I do believe they have never ran out of anything so thats a plus. They staff was friendly and there...','R0044','U0471'),
('V0044',5,'Amazing food, great staff, cozy atmosphere!

Definitely a must try place!

Cioppino was very good and fresh. The drinks were unique! Very busy so make sure...','R0045','U0044'),('V0258',4,'Restaurant week at Geogetown. I came here after work on a Friday with a reservation. Work ended a little early so I decided to sit down at the bar and enjoy...','R0045','U0258'),('V0472',2,'Unhappy with this Saturday brunch. We made a reservation and were sat quickly, but the rest of the meal went downhill. One member of our four-person group...','R0045','U0472'),
('V0045',5,'Well worth the admission price of  only $5 to learn about the Wright Brothers and the importance of Americas first military flight school.','R0046','U0045'),('V0259',5,'If there was a way to give six stars I would do it. This place was an excellent attraction for a two children on a rainy cold day. So much to learn and see...','R0046','U0259'),('V0473',5,'We absolutely love this museum! 



This hidden gem is tucked away in College Park minutes away from 95 and the College Park metro.  It also has a private...','R0046','U0473'),
('V0046',4,'Service was GREAT and it was only 06:05 in the morning. I was greeted with a smile and the server was very friendly, felt like i was having breakfast at...','R0047','U0046'),('V0260',4,'Good food. 24/7. Good service 



Ive come here a couple of times now with friends really late at night. Ihop is my go to for some late night after drinking...','R0047','U0260'),('V0474',5,'Amazing customer service, everyone here will treat you like family, I tried it and i been a regular for a few years now.

The food  portions are pretty big...','R0047','U0474'),
('V0047',5,'Amazing restaurant.  I went here for Happy Hour.  The prices are great for HH and the food was amazing.  Since it is kind of new, the bar was not over run...','R0048','U0047'),('V0261',3,'Diner food with an upscale feel due to locality...at best! The food was subpar.. Drinks better.. But for the bland food and quick service I would liken this...','R0048','U0261'),('V0475',4,'Visited on Friday 5/24/19 for early dinner after attending University of Maryland graduation and hearing Mike Bloomberg as the commencement speaker....','R0048','U0475'),
('V0048',5,'Now the last time I went to Copper Canyon Grill a couple of years ago I wasnt so impressed, but this time I notice they changed their menu and I must say I...','R0049','U0048'),('V0262',3,'So came with some friends for a drink and happy hour , two of the members in our group declined to come in because the facility wasnt ADA compliant . ADA...','R0049','U0262'),('V0476',5,'What is there not to like about this place?!! All i know is that any location I go to, its always good food and good service. 



They have great HH deals....','R0049','U0476'),
('V0049',4,'I go here every blue moon when I am in the area. This is a spot that has been here since my childhood and close to Silver Spring Metro.



I get one thing and...','R0050','U0049'),('V0263',1,'All I can say is that this place once had great seafood & service.  Had not been in over 10 years and decided to take a trip down memory lane with my family...','R0050','U0263'),('V0477',4,'Definitely a hidden secret in the DMV. Seafood Bisque is the best in town. Good crab cakes. And please please please save room for rum cake for dessert.','R0050','U0477'),
('V0050',5,'Small cafe lounge you would have probably missed walking down O street in Washington DC! Its a two-story building that houses close to 30 adoptable cats....','R0051','U0050'),('V0264',5,'I got the 70 min experience and it was amazing! Fair priced and it gave enough time to really relax around the different cats and let them get used to you....','R0051','U0264'),('V0478',1,'I thought this was a great idea and wanted to support the cause. It originally started off great I got to interact with a few of the cats and my friend and...','R0051','U0478'),
('V0051',5,'We came here for dinner; enjoyed the food and service. Parking can be found along the street and in a nearby parking garage. There is outdoor seating and a...','R0052','U0051'),('V0265',3,'Overall good experience. Im not a Cuban cuisine connoisseur, so Im probably not the best judge here but i enjoyed the beef dish I got as well as the rice...','R0052','U0265'),('V0479',2,'We picked this spot because of the overall Yelp reviews & rating, but were disappointed. Service staff was friendly, great music & decor. Our party of three...','R0052','U0479'),
('V0052',4,'Lol I dont know why my friends laugh at the name of the store but this is my late night spot when Im NOT on my keto wagon.



Taylor is the best employee!! So...','R0053','U0052'),('V0266',1,'After seeing the great reviews my husband and I decided to try this place out.  The wait was for like 30-45 minutes.  We kept saying the calzones better be...','R0053','U0266'),('V0480',5,'What could possibly be the justification for giving D.P. Dough 5 stars? Let me tell you. 1. Its open till 3am. Respect. People work hard to make that...','R0053','U0480'),
('V0053',5,'Oh boy where do I start? I grew up on this restaurants food from when they were located in White Oak to Wheaton to now, Beltsville. My dad used to feed me...','R0054','U0053'),('V0267',5,'I came here once with a group a while back, and I dont know why I didnt write about it then!  The parking lot is a little tight, and quite frankly unless...','R0054','U0267'),('V0481',5,'This place has the best Korean food Ive tried thus far! Im not Korean but my Korean friends do tell me this is also the best! Its definitely worth the 30...','R0054','U0481'),
('V0054',5,'Whoever owns this place is going to heaven. 



I will openly admit that I have a halal addiction, so I take it very seriously. DCG is incredible.



I always...','R0055','U0054'),('V0268',5,'Short Story: Exactly what I look for in a chicken and rice joint.



Long Story: Ive been here a few times for the sole purpose of something quick, tasty,...','R0055','U0268'),('V0482',5,'Have to try if u are in town. Just amazing and great value.



Staff is friendly and clean. Pretty crowded but I knew why after I had the meal ;)','R0055','U0482'),
('V0055',5,'Dog Tag bakery is a beautifully decorated small coffee shop in Georgetown. The coffee options are plentiful and both the Cortado and espresso we had were...','R0056','U0055'),('V0269',4,'Love that this business is owned by a veteran and that part of proceeds go to charity.



Orange chocolate scone - didnt love the orange bits but the outside...','R0056','U0269'),('V0483',4,'Five stars for the mission.

Three stars for the sandwiches. 

Five stars for the cookies. 

Three stars for menu consistency. 



Dog Tag Bakery is a place you...','R0056','U0483'),
('V0056',5,'This place exceeded expectations!! I figured it would be another overhyped DC spot with small portions/high prices/meh quality, but my sister and I were...','R0057','U0056'),('V0270',5,'We stopped here for a cocktail and an appetizer.



The Moscow mule and Pimms drinks were unique, with a mix of real ginger at the bottom. The poutine was...','R0057','U0270'),('V0484',3,'I was really excited to try this cafe, having been to Dukes Grocery in Dupont. We came on the later side for lunch (around 3 pm), and I was less than...','R0057','U0484'),
('V0057',5,'I am from CT where pizza is a BIG DEAL. I gotta say this places pizza is right up there with the best world class places Ive eaten in CT (Pepes) . The...','R0058','U0057'),('V0271',4,'Ive only had delivery (three times) and every time they are very prompt. 



Ive had their pizza which is quite good; the crust is billowy, and I usually...','R0058','U0271'),('V0485',4,'Great little corner stop. Stopped in for a cheese steak sitter a Yelp search. Fairly robust pickup traffic always a good sign. Cheese steak was a win....','R0058','U0485'),
('V0058',5,'What a hidden gem that we intend to keep coming back to! I had been craving for good Chinese food and dumplings for a while and Dumplings & Beyond exceeded...','R0059','U0058'),('V0272',4,'Go-to Chinese near GWs campus- its not only value, but also super delicious, and they do everything on their menu (that Ive had so far) fairly well- no...','R0059','U0272'),('V0486',5,'This place makes buying dumplings at a restaurant restaurant. I personally have never seen them wrapped in this fashion, the fin is quite flamboyant, but...','R0059','U0486'),
('V0059',4,'I can always count on Eggspectation to feed me some delicious breakfast/brunch food at any hour of the day. This is my second time coming to this place and...','R0060','U0059'),('V0273',3,'Nice atmosphere, tasty food, good service, and good drinks..... but a stinky bathroom!



I would give Eggspectation four stars for executing the concept so...','R0060','U0273'),('V0487',5,'Eggspectation is the tried and true breakfast/brunch staple in town. I mean when you cant decide what to eat but you know you want to go out, Eggspectation...','R0060','U0487'),
('V0060',5,'El Quetzal is small restaurant with wonderful Guatemalan food. My husband loves their soups. (They sell out fast though - especially on the weekend) ... All...','R0061','U0060'),('V0274',3,'Pros: 

Friendly staff.

Clean restaurant.



Cons:

Small menu with limited Menu choices.





The establishment is a good size and clean. They are a bit pricey...','R0061','U0274'),('V0488',4,'We had the Garnachas & the Pork Rib as suggested by the guy that worked there.

The Garnachas were delicious but a little burnt on the bottom  

I would order...','R0061','U0488'),
('V0061',5,'Let me tell you about this place , this May look like a hole in the wall but this place is absolute FIRE . I take my family here all the time . Absolutely...','R0062','U0061'),('V0275',4,'Taste was good. I got 3, an al pastor, carne Assad and lengua. Al pastor did not have the sweetness to like I would have imagined. The tongue was great! I...','R0062','U0275'),('V0489',5,'I love coming here and eating the Quesadilla De Pollo (chicken quesadilla). Its always delicious, fresh and filling.','R0062','U0489'),
('V0062',5,'Had a single cheeseburger with fries. Classic toppings of lettuce, tomato, pickles, ketchup and mustard. Meat is fresh, flavorful and juicy. Actually...','R0063','U0062'),('V0276',1,'My stomach hurt sooooooo much after eating here. I thought it was just me, but my friend experienced the same thing. Twice. Cramping, nausea, and general...','R0063','U0276'),('V0490',5,'Get your belt out!!!! Whaaaaaaaaaat! Wait a minute here.



I cant believe Ive passed this up so many times! 



The burger was to die for. Flavorful and...','R0063','U0490'),
('V0063',5,'Escape Room Live is ESCAPETHEROOMers first ever Washington DC location escape room that we are visiting back in July 2019. They also have another branch in...','R0064','U0063'),('V0277',5,'We were wandering around the neighborhood and found many of the shops to be closed while we waited for our dinner reservation and stumbled upon the escape...','R0064','U0277'),('V0491',4,'I wanted to surprise my wife for her birthday with something different, and boy did this work.  Neither of us had any experience with escape rooms and were...','R0064','U0491'),
('V0064',5,'My friend and I were looking for a decent dinner and just stumbled into Et Voila.  We were very pleased with our dinner.  Wound up sitting at the bar as we...','R0065','U0064'),('V0278',2,'Granted, it has been a couple of years since weve dined here.  The renovations look nice.



I used to have been very fond of the food here and used to find...','R0065','U0278'),('V0492',4,'Lobster Burger & Floating Island are must have & to die for delicious! Another gem & treasure in this neighborhood, like it & would recommend it!','R0065','U0492'),
('V0065',5,'Delicious!! Big portions, freshly made, nice people. I ordered the tofu and got green beans and 3 kinds of lentils as sides.','R0066','U0065'),('V0279',4,'Nice place for a quick bite!



The staff here were super nice and very helpful, the food was good quality and the portions were good for the price!



Its...','R0066','U0279'),('V0493',3,'$12.95 for a build your own bowl with spicy beef as my protein. (There are cheaper ones that have chicken as protein)



Price varies depending on protein and...','R0066','U0493'),
('V0066',5,'Been here dozens of times but never actually reviewed. 



The food here is consistently great and at such a good price. They donate part of the sales to help...','R0067','U0066'),('V0280',5,'This is the best price food Ill ever get in Georgetown, followed with an amazing mission and message: $4 for a falafel and hummus pita sandwich, with each...','R0067','U0280'),('V0494',4,'When Im craving a good, light vegetarian meal, this place does it for me. Usually one or two (when Im super hungry) will hit the spot, along with a side...','R0067','U0494'),
('V0067',5,'Expect to dine immensely!



The food and the drinks are delicious and well curated. The brunch buffet is perfect for someone who wants breakfast and lunch...','R0068','U0067'),('V0281',2,'After giving this place 5 stars last time,  I have to drop Farmers down to 2 stars. Service was terrible and food quality has dropped considerably.  I...','R0068','U0281'),('V0495',2,'Aside from the beautiful location right on the banks of the Potomac River in Georgetowns Washington Harbor area, it was a total disappointment. Farmers...','R0068','U0495'),
('V0068',5,'We just ran in here for a quick bite before hopping on the bus, it was a quaint little spot. The crepes were A1, really soft, food came out hot. I wish I...','R0069','U0068'),('V0282',1,'When other people say this place is unfriendly or that they feel as though they are disrupting the work flow, you might think---hmmmm, could that be the...','R0069','U0282'),('V0496',1,'I think the staff could be a tiny bit more friendly. I stopped in for a latte.  Im new to the area so just exploring. Once the employee came to the counter...','R0069','U0496'),
('V0069',5,'Reservation necessary*** 



This restaurant is pretty booked most of the time but well worth the wait. It is pricy but very delicious Italian food. Their...','R0070','U0069'),('V0283',4,'It is a classic or traditional italian restaurant complete with fresh made pasta and sauces, large portions, and savory flavor profiles. 



You cannot be...','R0070','U0283'),('V0497',5,'Its an old school joint with super kitschy decor, but they live up to the hype. First things first, you need a reservation. They are a large space, but...','R0070','U0497'),
('V0070',5,'Went back and Carlos was our server ! Everything was amazing ! Definitely a nice place to be ! 





Amazing location, amazing service, beautiful restaurant,...','R0071','U0070'),('V0284',4,'Came here for a birthday dinner, and overall, I loved it. 

Drinks: 5 stars

I got the DC Bramble, which was delicious and just strong enough. 

Food: 4...','R0071','U0284'),('V0498',5,'As soon as you step in you are met with the wonderful aromas of grilled seafood  Food was fresh and amazingly prepared  Great options to choose from

Service...','R0071','U0498'),
('V0071',5,'Ive been meaning to write an update, its about time. I didnt have a great experience with their buffets. However, their menu items, especially the Kababs...','R0072','U0071'),('V0285',5,'FIRST TIME!!!!

And it was simply a great experience I will be back again & again the food was so delicious fresh and hot in temperature with great favor. I...','R0072','U0285'),('V0499',3,'I was able to eat here but didnt necessarily enjoy the food. Not that many great halal options around so its Okay if youre hungry.','R0072','U0499'),
('V0072',5,'We are here in town for a college sporting event. Since its our anniversary we decide to stay over. We love brew pubs and chose this one after figuring out...','R0073','U0072'),('V0286',3,'They have a gluten free menu. A little limited but dome good options. They brought out regular crackers with my soup, however. 



Other folks got the pizza,...','R0073','U0286'),('V0500',3,'BLUF: The okay-est dining experience ever so I give it an A-OK three stars!



I have no complaints about this place but also no raves. The best part of this...','R0073','U0500'),
('V0073',5,'As of mid October 2019-



Ignore the 2 star reviews now. The new owner started last week and thank goodness. This place had inedible food before, but its...','R0074','U0073'),('V0287',3,'Under new management. I suppose that was inevitable given the age of the couple previously running it.

More staff, and they speak better English. Not sure...','R0074','U0287'),('V0501',2,'Came here two weeks ago with my grandmother and my 11 mo son. We came for the buffet because I wanted something quick and easy. If anyone who has a child...','R0074','U0501'),
('V0074',5,'Excellent tater tots, customer service and beer!



I especially liked the decor. The use of VHS tapes was quite unique.','R0075','U0074'),('V0288',4,'Small ramshackle with a knack for under-appreciated brews, healthy bites and vegan/vegetarian grub. No stars for food from me. But neat ambience, in that...','R0075','U0288'),('V0502',5,'Across from Whole Foods.  Tiny little dive with a great vibe.  Most 30s its okay cuz thats me in my mental state!  maybe more so! Check it out after...','R0075','U0502'),
('V0075',4,'In no way did I research this place while visiting Georgetown but I am so happy to have stumbled across it while walking around this cute little town! Im...','R0076','U0075'),('V0289',4,'I am not ashamed to admit I visited two locations during my trip! So worth it!



My first was at the Georgetown location. The shop is cute and bright. It...','R0076','U0289'),('V0503',4,'Wellll hello there Georgetown cupcakes !!! I went here a fiew times when I visited Washington Dc and could not pass up coming here for some cupcakes. Of...','R0076','U0503'),
('V0076',4,'Their naan here is incredible! I havent had a chance to try a lot of things on their menu but from what I have tried, everything has been delicious....','R0077','U0076'),('V0290',5,'Very satisfied, and happy with the food here, closest to home food. We ordered the Aloo Tamma, with rice and the soup momo (Nepalese dumpling) - loved it....','R0077','U0290'),('V0504',2,'Ordered some delivery they said 45 minutes, its been over 1:25 minutes thats almost double the time. No answer on the phone and cant even tell if its...','R0077','U0504'),
('V0077',5,'This place serves great burgers and fries. Its very filling, very decent portion sizes, and quality of the food is great. I had the good stuff melt burger...','R0078','U0077'),('V0291',5,'Oh my god....The splurge was worth every bite! I got that Prez Obama burger and was in heaven. It is a little sweeter bc of the grilled onion but oh so...','R0078','U0291'),('V0505',4,'After a couple years of telling myself "I should try that burger place on M street", I finally visited good stuff eatery. Some very adventurous burgers and...','R0078','U0505'),
('V0078',5,'My absolute favorite fried chicken place! So much so that I am willing to drive 50 minutes minimum to get some. I cant resist the flavorful crispy skin and...','R0079','U0078'),('V0292',5,'The food was good, fresh, flavorful, and filling. Great customer service and a great clean bathroom.



The wings and Mac and cheese were pretty good too!...','R0079','U0292'),('V0506',4,'Chicken was crunchy and not too greasy

Fries were crispy but VERY salty



Mac and cheese were hot and good

Potato salad was good','R0079','U0506'),
('V0079',5,'Theyve done it. Gusto has made cauliflower pizza crust that didnt taste like cardboard, or was an unappetizing mush, or unpalatable chip of thin crust...','R0080','U0079'),('V0293',4,'On first glance, the price looks pretty reasonable, BUT dont be fooled, all salads do not come with protein (e.g. chicken), and its an additional...','R0080','U0293'),('V0507',4,'Tons of parking (via garage) in downtown silver spring. Takes both cash and credit card.



Ive walked past this restaurant several times, but never had the...','R0080','U0507'),
('V0080',4,'The specialty sushi roll selection here is limited, but I did get to try the dancing eel and the UMD roll. No complaints. I would definitely order either...','R0081','U0080'),('V0294',3,'Came here with a friend because we wanted something besides pizza. My friend was running late, so I got us a table.  In the beginning our hostess was nice...','R0081','U0294'),('V0508',3,'Small cozy place. Old decor. Ordered spring rolls as appetizers, College Park speacial rolls, veggie udon.



Spring Rolls: 4/5 typical veggie rolls. Fried...','R0081','U0508'),
('V0081',5,'This is the place for chili and great pub fare. They offer a taste test chili sampler. Really smart to have that preview. My mom and fianc» are big meat...','R0082','U0081'),('V0295',5,'Pros:

Friendly Staff

Fresh very good food

Great parking





Cons:

None





Our first time here, my wife and I were looking for somewhere different to go so we...','R0082','U0295'),('V0509',5,'Found this place by accident.  It was a great surprise.  The staff was great!  Very attentive and friendly.   I was traveling for work and staying at the...','R0082','U0509'),
('V0082',4,'We came here on a Saturday night around 7ish and it was a 30-40 minute wait. We hit "shoppers world" to check that out in the mean time and Target. We were...','R0083','U0082'),('V0296',3,'Upon entering the restaurant you usually get greeted and seated. We entered and practically had to get someone to greet us. Im not even sure who the actual...','R0083','U0296'),('V0510',5,'My 1st time at Hook & Reel and I loved it! This use to be the old Joes Crack Shack but so happy this place took over. 



I was connecting with a good...','R0083','U0510'),
('V0083',4,'We came here on a Saturday night around 7ish and it was a 30-40 minute wait. We hit "shoppers world" to check that out in the mean time and Target. We were...','R0084','U0083'),('V0297',3,'Upon entering the restaurant you usually get greeted and seated. We entered and practically had to get someone to greet us. Im not even sure who the actual...','R0084','U0297'),('V0511',5,'My 1st time at Hook & Reel and I loved it! This use to be the old Joes Crack Shack but so happy this place took over. 



I was connecting with a good...','R0084','U0511'),
('V0084',5,'Bomb.com

I eat here at-least once a month! 

I recommend "The Drool" medium, house sauce 

WHEW','R0085','U0084'),('V0298',2,'First time coming here and will likely be my last. I did enjoy the "seasoning" and "spice level" choices but the price of crab legs was high HIGH WAY...','R0085','U0298'),('V0512',5,'The only downfall about this place is the parking but other than that.... really enjoyed it. I had the hot n juicy baby spice seasoning - its a more...','R0085','U0512'),
('V0085',5,'Back in my college days, I took a girl to Ikea for a date and now Im married to her, and this year will be our 10 year anniversary. What Im saying is set...','R0086','U0085'),('V0299',3,'Their meatballs are my favorite. That gravy goes well with my fries. Though, you have to request for fresh fries otherwise they are mushy and not edible....','R0086','U0299'),('V0513',5,'The place is very clean and pretty up-to-date style, service is quick and staff are friendly.



The food itself is alright defintly not bad but I wouldnt...','R0086','U0513'),
('V0086',5,'Ikko Sushi is a pleasant sit-down with a sushi bar and tables strewn closely within the restaurant. In addition to sushi, teriyaki, udon, ramen, and poke...','R0087','U0086'),('V0300',3,'The server was extremely pleasant and the lunch prices were good. 4.5 on that! 



The miso soup was tasty, however, the sushi was very basic in flavor....','R0087','U0300'),('V0514',4,'If youre lucky, youll get Amber as your waitress; we were fortunate to have her when she was volunteering to help out at Ikko. 



Amber was attentive and...','R0087','U0514'),
('V0087',5,'il Canale is a taste of Italy in beautiful Georgetown. I always just an Italian place by their Margherita pizza, and il Canale gets 5 stars from me. 



When...','R0088','U0087'),('V0301',4,'I visit DC on occasion for work, and this place is always on my must-eat list. I love the area of town, and service has always been great one visits. 



You...','R0088','U0301'),('V0515',4,'Nice authentic Italian restaurant. The food is not amazing but good, wine is good and service is good. We went there for dinner and place was packed, but...','R0088','U0515'),
('V0088',4,'Finally got to try this place and I wasnt disappointed!



Pros: seafood is very fresh and seasoned well! Portions are sized great and will be enough for you...','R0089','U0088'),('V0302',3,'Finally made it here for lunch on Saturday.



To cut to the chase, I dont see the hype of this restaurant. It was okay and honestly, my opinion may not mean...','R0089','U0302'),('V0516',2,'This was some of the worst food Ive had in DC. The bacon was floppy, thick, & almost all fat. The brisket was tasteless, dry, & grey. The hamburger was...','R0089','U0516'),
('V0089',4,'I visited Friday afternoon (4pm-ish) after attending University of Maryland campus-wide graduation (Yeah!!!) in which former New York City Mayor and...','R0090','U0089'),('V0303',5,'Jasons feels like a more modern, but not overly hip, deli. Theyve got many options for whatever youre in the mood for. I really enjoy their salmon...','R0090','U0303'),('V0517',4,'I order from here a lot for lunch. Ordering online is a snap and never had issues with wrong food.  Plus the food is tasty.','R0090','U0517'),
('V0090',5,'Ive come here multiple times during my lunch hour and I always encounter a young lady who is is always taking orders, shes GREAT! Its hard to find good...','R0091','U0090'),('V0304',1,'Just go to Subway- the staff here was soooo slow, there was nobody in front of or behind me and it still took at least 10 minutes for them to make it. A...','R0091','U0304'),('V0518',2,'Horrible service!!!! I placed an order online and tried to fix something by calling, after they ignored my call the first 2 times they finally answered to...','R0091','U0518'),
('V0091',5,'You can tell whoever owns/runs this restaurant, quality of food and service are top priority.



Husband and I came in to check out their lunch buffet ($13.95...','R0092','U0091'),('V0305',5,'I ordered to go and the food was food is great. 



I got the lamb curry. Highly recommended it. 

My fianc» for the chicken curry and it was good.','R0092','U0305'),('V0519',4,'Ive been here several times, but recently for the lunch Buffet. A few items I really enjoyed were the carrot pudding, samosa chat, chicken makahni, and the...','R0092','U0519'),
('V0092',5,'Visited because of the #1 Yelp rating in the area and was very impressed. Definitely deserving of the top slot. I got the #8 (chicken in a sauce, rice, and...','R0093','U0092'),('V0306',4,'Jodeem is located inside the beltway plaza mall/greenbelt mall. There is shared parking for the restaurant and other patrons of the shops at the mall, but I...','R0093','U0306'),('V0520',4,'Jodeem is located in Beltway Plaza Mall (destined for the same fate as, The Landmark Mall in Alexandria), before Bethesda-based Quantum Companies, might...','R0093','U0520'),
('V0093',5,'I am so glad I found this spot! I had put it on my list of places to try and stopped in for some lunch which was the perfect time honestly there wasnt a...','R0094','U0093'),('V0307',5,'The food is great!!!! The crab soup is a must try! I was told its JODYS grandmothers recipe and I must say its damn good...the best I ever had in fact...','R0094','U0307'),('V0521',5,'Im giving this spot 5 because the owner actually sat and talked to me about the review I was going g to write.  I really appreciated that and it showed...','R0094','U0521'),
('V0094',5,'Delicious European breakfast in a cute neighborhood to visit and shop through!



The outdoor seating is a beautiful setting. 



Their compote is supple,...','R0095','U0094'),('V0308',3,'Bottom line: A hidden gem in Georgetown with European ambience and cute desserts. Food is just okay but Id go here over and over just because the...','R0095','U0308'),('V0522',3,'Kafe Leopold is a quintessential Georgetown brunch spot. Ask anyone in the area for a good brunch place nearby and they are bound to recommend this eatery....','R0095','U0522'),
('V0095',5,'The coffee and tea here is not only good, but their food is also amazing. The mango black tea I got was delicious. The cake wasnt too sweet that it hurts...','R0096','U0095'),('V0309',4,'Love the ambiance and the food here and the prices. I came here yesterday for the first time and Im already back. I got the avocado sandwich with 2 eggs...','R0096','U0309'),('V0523',4,'Ive been recommended to come here by a friend of mine, and I regret that it took me so long to actually come here. I came in the morning for a caramel...','R0096','U0523'),
('V0096',4,'Ah, homecoming weekend.  My original plan after the on-campus festivities was to go to the new hot pot place in the area, but with a one-hour wait, that was...','R0097','U0096'),('V0310',1,'I never want to give a place one star but I was absolutely appalled by the way my boyfriend and I were treated at this restaurant. 



I normally make the...','R0097','U0310'),('V0524',4,'Craving Korean street food so I ordered a few items via Uber Eats. 



Ordered the topokki, mandu and beef gim bap. Large portion of the topokki and packed...','R0097','U0524'),
('V0097',5,'***Delicious Thai food, Lots of options, Authentic***



Yum! This place is a must try. We ordered the food ahead of time to pick it up. The portions are very...','R0098','U0097'),('V0311',3,'Casual, accommodating, and fast. Kao Thai is a solid Thai restaurant with a large range of options. The portions are finishable and the taste was fine,...','R0098','U0311'),('V0525',3,'decent, reliable Thai in downtown Silver Spring. Decor is nice and service friendly. The food is good, particularly Pad Thai. Compared to a few other Thai...','R0098','U0525'),
('V0098',5,'This is a quaint and pleasant little cafe with very good food.  My entire party had scrambled egg, cheese and bacon on croissant sandwiches, and they were...','R0099','U0098'),('V0312',3,'Super cute cafe with a home-y feel. The woman behind the counter was nice and clearly smiled at her job as she was multi-tasking effortlessly between a few...','R0099','U0312'),('V0526',5,'Stopped in here for breakfast one Saturday morning. Its such a delightful cafe! 



The server was super friendly as she took our order. She seemed to be the...','R0099','U0526'),
('V0099',5,'Excellent park and protected wetland.  Well worth the visit.  If you decide to make the trek, your favorite map app will be your friend in finding the...','R0100','U0099'),('V0313',5,'Free entry. Beautiful year-round but come in July to see the large Asian lotus in bloom or in Aug or Sept to see the giant lily pads. In winter we have seen...','R0100','U0313'),('V0527',5,'A hidden gem in Eastern DC and an oasis of beautiful flowers in the midst of a concrete jungle. Kenilworth Aquatic Gardens is an incredible, family friendly...','R0100','U0527'),
('V0100',5,'Alright, so Ive now eaten here a bunch of times and there are several reasons Im upping my score.



The first is consistency.



Every time I come here the...','R0101','U0100'),('V0314',5,'My boyfriend and I went to this spot for lunch earlier this week on a whim, and boy were we happy with the choice!



The Chicken Tikka was delicious. I also...','R0101','U0314'),('V0528',4,'I had the combo salad with chicken and gyro.  Red and white sauce. I plan on eating here again. I ordered a little before noon. 



Ordered take out for the...','R0101','U0528'),
('V0101',5,'Fantastic and authentic Japanese Sushi house. Best in DC!



My family of 6 has dinner there, and the service and food were amazing.



Prices were fair for the...','R0102','U0101'),('V0315',2,'Came here for lunch for the Sashimi. I just felt the fish was not that fresh. Also tried some other rolls. I was really disappointed as I been craving sushi...','R0102','U0315'),('V0529',3,'Would rate 3.5 if I could do half stars. Overall very neutral experience for me. I think my expectations were a little on the high side, considering the...','R0102','U0529'),
('V0102',5,'I love kati rolls and parathas.  



Krazi Kebob makes some really good ones.  Got a chicken tikka and a beef boti kati rolls to go and found them to be...','R0103','U0102'),('V0316',4,'Wish I found this place while I was still nearby! I was pretty impressed with the quality of the food. Its a build your own/chipotle-style place. Seating...','R0103','U0316'),('V0530',4,'Krazi Kebob gets an hold star for the absolutely delicious wraps, quesadillas, chips and salsa they serve up. The place has a chipotle style service where...','R0103','U0530'),
('V0103',5,'I went on a Sunday afternoon literally as soon as they opened empty the employees were polite,helpful, and quick! I purchased the cocoa cream wow with milk...','R0104','U0103'),('V0317',4,'Review #240 - 2019



After our quick stop at the Peace Cross, I was in the mood for some KFT to sweeten my day!



We showed up around 12:45 PM on Sunday,...','R0104','U0317'),('V0531',1,'Im seriously not trying to give them a lower rating but I swear on my grave my Cocoa Cream Wow straight up tastes like milk...



When we asked the employees...','R0104','U0531'),
('V0104',5,'La Casita Pupuseria & Market has become one of our favorite breakfast spots. We typically order with Uber Eats but it is very close to downtown Silver...','R0105','U0104'),('V0318',4,'A delicious, casual spot for Salvadoran food! The set up reminds me a bit of a food court. You order your food at a counter, grab a seat, and your number...','R0105','U0318'),('V0532',5,'This is my go-to for pupusas! 



Horchata isnt too sweet. It has just the right amount of spice and creaminess. 



They have their own curtido bar, so if you...','R0105','U0532'),
('V0105',5,'Listen up pricks, this establishment was here before Hyattsville went all pretentious.



La Fondita is hidden in a neighborhood so you will never find this...','R0106','U0105'),('V0319',1,'Oh geez. I hate that I have to review so low. 



First, I always see this as Im driving. Usually hole in the wall places are yummy.



Not here. 



The menu is...','R0106','U0319'),('V0533',1,'Im sorry, I really dont like talking bad about a place but this place was not good at all and there service was poor I would not recommend to anyone','R0106','U0533'),
('V0106',5,'Best tapas ever! $20 unlimited tapas at lunch is an amazing deal, and the service is unbeatable. I cant really say anything wrong about this place. I...','R0107','U0106'),('V0320',5,'I came here last Friday with my parents who were visiting and we had a wonderful evening. One of the owners sat us and was super pleasant.  I believe his...','R0107','U0320'),('V0534',5,'We are moderately priced people. We go for places that have $ or $$ signs. LOL. This is not a moderately priced place. BUT we thoroughly enjoyed the food...','R0107','U0534'),
('V0107',5,'I love coming here! As soon as the temps begin to rise in the early Spring, we make our way to Lake Artemesia or as we call it, "the lake," or "the trail."...','R0108','U0107'),('V0321',4,'Well worth the visit on a Saturday. There is a wide walking path comfortable for both walkers and bicyclists (and there are plenty of those). The signage in...','R0108','U0321'),('V0535',4,'This is a nice, clean park right in the middle of the hustle and bustle of College Park.  Its not hiking per se, but it is a fun place to walk and take in...','R0108','U0535'),
('V0108',4,'Old faithful! This original location (moved from university blvd) has been here for about 8-9 years. The good news?! The pizza still tastes the same!...','R0109','U0108'),('V0322',3,'Very disappointing experience here - in both good and service. 



I am one of those born and raised in the 1950s-80s era with the original Ledos on...','R0109','U0322'),('V0536',1,'Unfriendly waitress and subpar pizza. 



I got the veggie pizza which came out a watery mess. There was a pool of liquid sitting on the top, which make the...','R0109','U0536'),
('V0109',4,'If youre looking for a place that has great food & drinks for a decent price, this is the place for you! 



Its definitely a college hang out-ish kind of...','R0110','U0109'),('V0323',5,'I have to say, after finding this place down from the Hampton up the street, It was a door on the side of a building with signs around it- wasnt sure what...','R0110','U0323'),('V0537',5,'The whole in the wall with some of the best seafood in town. Thats what I would write if I was a food editor for the Washingtonian. 



The place was packed...','R0110','U0537'),
('V0110',4,'3.5 stars for me. Dined in with a friend last Friday. The pho is good, but considering I ordered the large size, felt more like extra soup with regular...','R0111','U0110'),('V0324',2,'Dont try to call in an order. It was a construction site I guess. Im actually screaming into the phone. Can they not take calls in a more quite place???...','R0111','U0324'),('V0538',4,'I love this place so much !

In my youth, I worked at a Vietnamese restaurant so I learned about authentic Vietnamese food and this place is it. Everything...','R0111','U0538'),
('V0111',5,'BEST. Lobster roll. Ever. Seriously I can never go anywhere else again. I tried the winter special, white truffle oil  roll with a side of lobster bisque....','R0112','U0111'),('V0325',5,'THE BEST LOBSTER ROLL EVER!!!!! omg it was SO GOOD!!!!! And you get so much lobster!!! It was UNREAL!! MUST TRY if youre in the DC area!!!! The lobster is...','R0112','U0325'),('V0539',3,'This is a gluten free review:

Yes, they have gf rolls. Theoretically. But theyre out of them. So I ate my lobster on a bed of greens with balsamic...','R0112','U0539'),
('V0112',5,'Mamma Lucia Pizza & Pasta is a great place to bring friends and family for Italian. 

Allison was our beautiful waitress, who served us like a pro, and they...','R0113','U0112'),('V0326',1,'The Greasiest Pizza delivery Ever:



Im a New Yorker so I may be bias - First I got the wrong order I ordered the overpriced 14" pepperoni for 18.00,...','R0113','U0326'),('V0540',4,'I was on my way to the shoppers to pick up dinner and cook. Then I remembered, I dont cook on Fridays! lol I saw this pizza spot that Ive never noticed...','R0113','U0540'),
('V0113',4,'Never judge a restaurant front by its outside. Outside it looks dated.



My friends and I had a get together and I was very eager to try Burmese cuisine. I...','R0114','U0113'),('V0327',5,'First of all: This place is an absolute /haven/ for vegans. Their range of vegan options alone could suffice as a complete and independent menu! But vegan...','R0114','U0327'),('V0541',5,'Delicious!!! Ive never had Burmese food in this area but was so pleasantly surprised by all there is to offer here. I tried their Let Phet Thoke (Green...','R0114','U0541'),
('V0114',5,'This place is AMAZING. If I could give them more than 5 stars I would. I just ordered crab rangoons and the szechuan beef and its the best Ive had in a...','R0115','U0114'),('V0328',5,'5 stars for value, cleanliness and customer service

I live in DC but was visiting friends in Beltsville and went to the Mandarin based on Yelp...','R0115','U0328'),('V0542',5,'New to the are and wanting good Chines food. Mandarin Delight did not disappoint. Order take away and the arrived well with the stated timeframe. The food...','R0115','U0542'),
('V0115',5,'As I had sisig running through my mind, I knew Manila Mart was the place to be. Kitchen staff is always friendly & helpful. Ensuring certainty for the...','R0116','U0115'),('V0329',1,'Service is REALLY SLOW. Customer service is none existent. I understand this is a low-level business but after all it is still a business. Came in a couple...','R0116','U0329'),('V0543',5,'Flavorful and affordable Filipino food. Friendly staff. Relaxing environment! 



The lady was very nice, upon knowing my friend and I were first time eater,...','R0116','U0543'),
('V0116',5,'Yea so Ive been in the college park area for awhile but for some reason have not eaten here before. Friend took me and it is a game changer.

Atmosphere:...','R0117','U0116'),('V0330',5,'Omg can i just live here ! I can move in yesterday

I love the new owner george you can just tell he loves to cook he loves his employees i feel like im at...','R0117','U0330'),('V0544',2,'This used to be my go to gyro place when I lived in the area. The food was delicious, inexpensive, and service was great.



The food is still delicious and...','R0117','U0544'),
('V0117',5,'I very much enjoyed eating here. Im a little surprised when we went there were only a few families eating there because the food is quite good. This is...','R0118','U0117'),('V0331',5,'Definitely one of my favorite local restaurants and highly recommend it to everyone.



For small groups, I would recommend lamb skewer and big plate chicken...','R0118','U0331'),('V0545',4,'This is one of very few Uyghur (pronounced wee-gur) restaurants in the DMV area, and for that reason alone, its worth visiting. 



Overall, food was tasty...','R0118','U0545'),
('V0118',4,'I have come here over a dozen times and am never dissatisfied! I faithfully get the filet mignon hibachi and am never disappointed! A must try! 



Sometimes...','R0119','U0118'),('V0332',2,'Unfortunately, I am going to have to lower my rating for masa hibachi. I enjoy their food and am a big fan of hibachi cooking but the service and management...','R0119','U0332'),('V0546',5,'The food and service at Masa was so good. I really enjoyed myself. The food was great. You get a lot more good here then most hibachi restaurants for a much...','R0119','U0546'),
('V0119',5,'OMG. My new favorite place. 



I got the tandori chicken with rice and chickpeas and the thai styled iced tea. 



Atmopshere - it was family styled. Small and...','R0120','U0119'),('V0333',3,'Had a craving for Indian food so another Yelp friend and I decided to check this place out. Neither of us had been here before. Around 6 p.m. it wasnt...','R0120','U0333'),('V0547',4,'This place is ok! The prices are pretty high, but the food is relatively good. The spices are on point and there are a few different chutneys available near...','R0120','U0547'),
('V0120',4,'Stopped in for a quick bite with one of my good friends and we werent disappointed. The restaurant is centrally located if youre in downtown silver spring...','R0121','U0120'),('V0334',1,'Went there tonight so very disappointed.  Food  was dropped off at our table with 5 items coming out wrong and 1 missing item.  As we waited for a fix the...','R0121','U0334'),('V0548',1,'This place was terrible. Ive been to a few match boxes in DC, but this one was the most disappointing one Ive been to. 



The most egregious of offenses?...','R0121','U0548'),
('V0121',4,'Im a Ruben guy. Love them way too much. I always spend way too much time considering ordering the sandwich at Irish Bars worried that Ill be disappointed...','R0122','U0121'),('V0335',5,'I came for lunch (after craving a salmon Caesar  salad all day!) and the craving was perfectly satisfied. I was greeted as soon as I walked In by Terry. He...','R0122','U0335'),('V0549',3,'i came here for a meal after the AFI movie thing. 



food

i did a sampler which came small bowls of the following



shepherds pie- the best thing i had here,...','R0122','U0549'),
('V0122',5,'A must go every time I visit DC! This set menu is delicious and budget friendly for a nice and lively date night. 



The meal starts with a house salad and...','R0123','U0122'),('V0336',5,'This is probably my most visited neighborhood spot with my wife, both to eat in and for pickup/delivery.  If you want a full steak frites dinner with salad,...','R0123','U0336'),('V0550',4,'Very good steak and fries. Basic menu since their thing is, do one thing and do it well.



The steak is always cooked perfectly and their gravy is quite...','R0123','U0550'),
('V0123',4,'Walked in about 430 pm...folks were getting ready for dinner crowd.  Nice wine selection of wines including some local Virginia wines.  Met a nice older...','R0124','U0123'),('V0337',3,'Walked in an hr till close on a Sunday, so i was expecting it to be kinda quiet. It was busy as heck! Both sides of the restaurant were filled. The servers...','R0124','U0337'),('V0551',5,'Ate on the patio on a weekday night, service was good but not in an overbearing sort of way.



Food was AMAZING.  Very classic Lebanese dishes that Id been...','R0124','U0551'),
('V0124',5,'So I heard this is the best pizza in town and I fancy myself a pizza guy so I would know if true.

Well I was not disappointed at all. 

Ordered the Diavola...','R0125','U0124'),('V0338',4,'We came here after a friend moved into the neighborhood. Its definitely a gem in a part of DC that isnt as known for its food scene.



We ordered the...','R0125','U0338'),('V0552',4,'My wife and I have become true pizza snobs. Im not sure when this happened, but there is no going back now. We have tried almost all of the rated pizza...','R0125','U0552'),
('V0125',5,'Solid substitute for my Mexican fix. Cheese enchiladas and retried beans are solid. 



Tacos are fantastic and chimis are excellent!!','R0126','U0125'),('V0339',3,'Our office came here for lunch on 11/19/19.  It was crowded for a Tuesday, but we were able to obtain a table for 7 without reservations.  The waiter wanted...','R0126','U0339'),('V0553',1,'I eat there on Sunday and the food was not fresh, I took my family their and we all got sick, food was off and several of us got sick , diarrhea and stomach...','R0126','U0553'),
('V0126',5,'Just tried this place for the first time. I had a cheeseburger, its absolutely delicious! Ill be back!  This place is great!','R0127','U0126'),('V0340',4,'Very good breakfast spot! Pretty cheap prices and a nice selection. Its tucked off in a corporate business park so it can be easy to miss but definitely a...','R0127','U0340'),('V0554',4,'Located in an office building across the street from DARCARS, Mike and Barrys Deli is a hidden find. Was looking for a place to grab a sandwich while I was...','R0127','U0554'),
('V0127',4,'My Partner In Munch & I entered here for breakfast and were impressed. The space is not that big and they only seat you if your entire party is there. We...','R0128','U0127'),('V0341',4,'Decided to stop by milk & honey for brunch on a Saturday without a reservation and was told the wait was an hour. However, what they dont tell you is that...','R0128','U0341'),('V0555',5,'I visited this wonderful cafe by a word of mouth by my Beaus family, and it was a great choice.  



The decor had a southern feel which I always enjoy....','R0128','U0555'),
('V0128',5,'Ive been coming here for the Mini MOD on a weekly basis.  I would have given them 4 Stars if they still had anchovys on the menu.  A pizza place without...','R0129','U0128'),('V0342',5,',  Mod  pizza  is brilliant. Its actually a great  chain where you order or create your own pizza . Theres also side dishes and treats including salads...','R0129','U0342'),('V0556',4,'The options are limitless!!! It is A little hard for me to summarize the experience since all of my energy is currently going into digesting my meal....','R0129','U0556'),
('V0129',5,'Charming place, amazing food, good drinks, very good service.

The place is spare and intimate.  Attentive and friendly staff make it feel very welcoming....','R0131','U0129'),('V0343',4,'Cute little place right off of Rhode Island Ave. Such a posh little spot for the area. The area, its sketchy at best but if more businesses like this one...','R0131','U0343'),('V0557',5,'I absolutely loved my experience here- we had a blast from start to finish and the food was absolutely delicious. 



We started with drinks- we tried a few...','R0131','U0557'),
('V0130',5,'One of the few places to get Taiwanese cafe food and Taiwanese food in general in DC!  Momos is tucked away in a very residential area of on the west part...','R0132','U0130'),('V0344',4,'Momos Cafe is an incredibly unique restaurant that serves fantastic food. First, this is a Taiwanese restaurant, and there arent that many Taiwanese...','R0132','U0344'),('V0558',5,'What a gem!! Their boba tea and popcorn chicken set were so good that we came back the next day for braised pork on rice. 



- Yes, were boba connoisseurs,...','R0132','U0558'),
('V0131',5,'Most review the food, but since there are a lot of food reviews, I am reviewing the place itself, but from an accessibility stand point. 

I am in a wheel...','R0133','U0131'),('V0345',1,'This is not authentic Korean food. 



Im Korean and this is by far the worst Korean food Ive ever had. The jjajangmyun is flavorless, the tangsooyook sauce...','R0133','U0345'),('V0559',5,'Their signature Soon Dubu is on lunch special from 12:00p-2:30p Mon-Fri ($11) and jumps up to $13 for dinner and on weekends. Theyve achieved great flavor...','R0133','U0559'),
('V0132',5,'I stopped by today to get some pupusas. Me being Salvadorian I have high standards when it comes to pupusas and the ones at this location did not...','R0134','U0132'),('V0346',1,'Didnt even bother trying the food. Service was that bad. Waitress was eating, and was like here is the menu come pick it up. I dont know if the food...','R0134','U0346'),('V0560',2,'I have several issues with this place, although the food itself was tasty.



1. There was a huge language barrier. None of the staff speak English so getting...','R0134','U0560'),
('V0133',5,'This place has the best food that I have tasted across the board since I have moved to the DC area. Although they are basically a carry-out, the quality of...','R0135','U0133'),('V0347',4,'My co-worker and I came to New Century Carryout for lunch based on the Yelp reviews. We were not disappointed by the food at all! The restaurant itself...','R0135','U0347'),('V0561',4,'Food was fresh, hot and fast. Its your typical carry out, but it was clean and the service was great.','R0135','U0561'),
('V0134',5,'This place has become my new favorite ice cream shop! I crave it on a weekly basis, so much so that I usually have a pint or two in my freezer. Ive even...','R0137','U0134'),('V0348',4,'I think Nicecream is a worth a visit for the experience if youve never had nitrogen ice cream before! The ice cream tastes a lot smoother and creamier in...','R0137','U0348'),('V0562',5,'I must first explain that I am not an ice cream person. I know, Im strange, I just cant do that much dairy. But on the occasion I decide to have a little...','R0137','U0562'),
('V0135',5,'This is a really strong restaurant with a great, intimate decor, and cordial service. You might miss it walking by - but definitely consider stopping in....','R0138','U0135'),('V0349',4,'Bottom line, Olazzo gets it right, every time.



We put off going to Olazzo for a long while after moving to Silver Spring, but after our first visit, we...','R0138','U0349'),('V0563',5,'Wow definitely chose this place randomly. New to the area and lucked out. 

Great food, great service, great vibe. 

Server Joella greeted us and served. Talk...','R0138','U0563'),
('V0136',5,'I sit here with a souvenier beer stein, a bag of doritos and a package of wet ones wipes. HOW DID I GET HERE?!?!

Let me tell you...



A small slice of...','R0139','U0136'),('V0350',5,'Old Europe was absolutely great. I mean, its hard to find good German food, and when my boss told me that I should try this place I got really excited. So...','R0139','U0350'),('V0564',5,'Birthday party, my father is a celiac and they have a separe gluten free menu , great service very patience.

Food was excellent, another nice thing was a...','R0139','U0564'),
('V0137',5,'This is my favorite place to relax, have a vodka tonic, enjoy the food and relax. Staff is great and attend to us professionally and fast. 



The brunch on...','R0140','U0137'),('V0351',4,'Interesting selection of beers from all around.

I mainly went for the food: Had very nice Crab cake sandwich. Good taste and quantity. The old Bay seasoning...','R0140','U0351'),('V0565',5,'This is a hidden gem if Ive ever seen one. 



Built into an old Circuit city building in Beltsville that is now a liquor store, hides a bistro that is...','R0140','U0565'),
('V0138',5,'This is my favorite place to relax, have a vodka tonic, enjoy the food and relax. Staff is great and attend to us professionally and fast. 



The brunch on...','R0141','U0138'),('V0352',4,'Interesting selection of beers from all around.

I mainly went for the food: Had very nice Crab cake sandwich. Good taste and quantity. The old Bay seasoning...','R0141','U0352'),('V0566',5,'This is a hidden gem if Ive ever seen one. 



Built into an old Circuit city building in Beltsville that is now a liquor store, hides a bistro that is...','R0141','U0566'),
('V0139',5,'*Disclaimer - this is a bar review only*



So after trying to get drinks at the Lobby Bar in the hotel, someone suggested coming over here for better...','R0146','U0139'),('V0353',4,'4 stars.



Nice location. The restaurant sits immediately beyond the lobby entrance. Large revolving doors and rustic/welcoming entryway.



Parking garage and...','R0146','U0353'),('V0567',3,'Yikes! Okay so this place is located near the University of Maryland. Its located inside a hotel. Saw this place when I came to the Red Door. 



Okay lets...','R0146','U0567'),
('V0140',4,'Last night, I finally made it to Panda Gourmet, the restaurant that has been called "the best Chinese restaurant in DC" and has hosted the spectrum of...','R0147','U0140'),('V0354',5,'As a guy who grew up in Xian, I didnt want to review this place at all. However, thats not because I hate it, but because I hate the fact I had to leave...','R0147','U0354'),('V0568',1,'This was my spot for authentic Chinese food. Today I walk in and without me uttering a word, the woman behind the counter stereotyped me as a person coming...','R0147','U0568'),
('V0141',5,'Its your typical Panera. I usually stop in while doing my laundry at a facility nearby on Sunday mornings. Rarely have to the wait in line, fast service...','R0148','U0141'),('V0355',5,'Love this Panera! This is one of my go to places for breakfast and lunch! Normally I use the rapid pick up. I rarely eat in. The rapid pickup is quick and...','R0148','U0355'),('V0569',2,'I have been at other Panera Bread locations. Visited this location to meet someone for a business transaction. When arrived there was a long line to order...','R0148','U0569'),
('V0142',5,'My mom use to go here back in the 70s and when I was considering buying a place here she was so excited and told me about all the memories she had here....','R0149','U0142'),('V0356',5,'This undoubtedly is one of my top ten restaurants in Maryland.



Being a NY transplant, finding food that reminds me of home is a daunting task. Here, I feel...','R0149','U0356'),('V0570',5,'Downtown Silver Spring isnt really all that great for brunch, which is a bummer because I LOVE brunch. I admit, I passed over this restaurant due to its...','R0149','U0570'),
('V0143',5,'I love this dive sports bar. The food is amazing!!!!! The staff is cool and the drinks are cheap! What more could you want?','R0150','U0143'),('V0357',1,'Terrible bartender.  Does not even say hello or thank you.  She is very ungrateful and unprofessional.','R0150','U0357'),('V0571',5,'Visiting from ATL and decided to stop by at a local bar and Phils was awesome! Great Food and superb customer service! Had a great time here and would...','R0150','U0571'),
('V0144',4,'This restaurant would be 3-star if it wasnt for the pho. I would definitely come back here for pho, but not the side dishes.



They definitely focus on...','R0151','U0144'),('V0358',3,'Its located at the greenbelt mall and the area is full of ample parking. The place is also very clean and generally well managed. 



I mostly come here for...','R0151','U0358'),('V0572',5,'I love this Pho spot. The Pho was delicious and hot. The staff were great and did not rush us to order at all. They offered us water while we waited for our...','R0151','U0572'),
('V0145',5,'This is the best place for pho in the DC area. Ive tried a lot of them, and most of them are just meh. 



Pho 5/5

Vietnamese coffee 5/5

Ambiance 3/5

Service...','R0152','U0145'),('V0359',5,'1. Whos the Id10t that gave this restaurant leas than five stars? If so, you dont know PHO!



2. Been eating pho for 30 years all over the US. I can...','R0152','U0359'),('V0573',5,'One of the best pho places in the DMV area! Only downside is that it is cash only but the price point is extremely worth! Definitely worth the wait but...','R0152','U0573'),
('V0146',4,'This restaurant is located in a strip shopping center for more than 10 years.  We had dinner here on a Friday night on 10/4/19.  It was crowded with only...','R0153','U0146'),('V0360',4,'The Vietnamese egg roll comes with 2pcs and Im presuming the guy who brings out the food also cooks the food which isnt good because his disposition is...','R0153','U0360'),('V0574',2,'Pho is OK.  Service bad.  We asked for a knife and never got it.  At the end, we couldnt  find the server to get our bill, and walked up to the counter to...','R0153','U0574'),
('V0147',4,'My favorite broth even compared to other pho restaurants in MoCo. That being said, the service is generally lackluster here. 



Make sure to come in from 3...','R0154','U0147'),('V0361',2,'Hmm.

I wanted to try this location out because Ive been to the Bowie location a few times and left satisfied with the service and the food. Although its...','R0154','U0361'),('V0575',1,'Horrible customer service!! 

*No one spoke when we walked in the door or when we left.

*I had to ask for a menus and napkins. 

*No one spoke when we left...','R0154','U0575'),
('V0148',5,'Cant believe Ive never written a review of Pho Tan Vinh before! Easily one of my familys favorite restaurants in DTSS. Its a value-for-the-money thing....','R0155','U0148'),('V0362',3,'I decided to check out this Vietnamese restaurant because I had a cold and they had vegetarian options for soup. The Pho Chay was just OK, but its possible...','R0155','U0362'),('V0576',5,'Wide menu appetizers, noodle dishes and entrees.  I usually go with my housemate who is Asian and  we BOTH love it.

 Today Sunday my son joined us.  Crispy...','R0155','U0576'),
('V0149',4,'Its called Pho Thom (translated to Aromatic Pho), so you have to try the Pho right? I got the Combination (Dac Biet), and they give you a lot of meat! You...','R0156','U0149'),('V0363',5,'Today I had one of the best meals of my life!!! The Yum Beef was amazingly delicious!!The spice level was on 10 and the taste of this Spicy Thai Salad was...','R0156','U0363'),('V0577',2,'This updated review is based on my most recent takeout experience. I ordered a small pho (#4) - extra spicy. I specified that I wanted extra jalapenos and...','R0156','U0577'),
('V0150',5,'Hands down the best pho restaurant in the area! My husband and I have been coming to VN One for over a year now, and we come pretty often!! 



I like...','R0157','U0150'),('V0364',4,'Just ate here with my wife.  It is located in a small strip mall across from Costco in Beltsville, MD.



We started with the summer rolls.  Good flavor but...','R0157','U0364'),('V0578',5,'Ive been coming to Pho VN One for 9 years now, and they have always had amazing pho. Every time I bring friends or family here for the first time, they...','R0157','U0578'),
('V0151',5,'Easily the best pho Ive had in a long time. Food trucks often come by the buildings near my apartment for dinner. Honestly, I never go down to buy but on...','R0158','U0151'),('V0365',5,'I was recently married and wanted to surprise my guests with a late-night meal (after a long night of drinking & dancing).  While brainstorming for...','R0158','U0365'),('V0579',5,'I am so happy that I was finally able to catch this truck 2 months ago! Feeling under the weather during the summer time is the absolute worst, but what...','R0158','U0579'),
('V0152',5,'You might miss this place if you dont know where to look, but do yourself a favor and check it out. 



I had the chance to venture over to Pizza Roma for...','R0159','U0152'),('V0366',5,'Delicious ! I love that I get buy two large slices for under 3 dollars. Ive tried the steak and cheese which is a everyday special for 5 dollar and some...','R0159','U0366'),('V0580',5,'We have about 20 places for Pizza in College Park.  This in my go-to favorite.  The crust is the best in town.  All the subs are great too.','R0159','U0580'),
('V0153',4,'Picked up some pizza to nom on while enjoying company at Streetcar 82 Brewing Co.



I ordered the 9 inch whole wheat Bosco with vegan mozzarella.



The pizza...','R0160','U0153'),('V0367',3,'You know that frustrating feeling when you set out to have a cheat meal and then it completely misses the mark. Ugh. Sadly that happened. I ordered the...','R0160','U0367'),('V0581',4,'The only reason why Im writing this review is because I received a burnt pizza today. Whoever made this pizza, please be aware of your oven. I love going...','R0160','U0581'),
('V0154',5,'We ordered the whole chicken with the sides yellow rice and beans and fried plantains, and also the chicken burger. The chicken was very tender and meat...','R0161','U0154'),('V0368',5,'This is small place with limited seating. The lady on the front greeted me very politely and the customer service was excellent. I got the half chicken with...','R0161','U0368'),('V0582',4,'Great deal at this place! The chicken is tasty and delicious and it isnt dry at all. The sweet plantains were also fantastic. The chicken meals are a great...','R0161','U0582'),
('V0155',5,'My addiction is their mouth watering Shrimp n Grits.  Webster himself would have trouble finding words that would describe the impact on my taste buds. lol.','R0162','U0155'),('V0369',3,'This is my first experience with Cajun/Creole cousine in Washington, District of Columbia. There were five (5) people in line ahead of me and it was about a...','R0162','U0369'),('V0583',3,'Came here at Union market on a Saturday. 

Place was bustling with hipsters. I stopped at Puddin, where I ordered etouffee and bread pudding.  Food was...','R0162','U0583'),
('V0156',5,'So Yelp has this new feature on the home page of the app, curated collections. I found this papusa joint with 4.5 stars under " cheap eats" 2 miles from...','R0163','U0156'),('V0370',5,'The service is fantastic, Carla is sooo sweet! The food is awesome! IT IS OPEN SUNDAYS! Yummy in my tummy

After trying all the pupuserias around, this place...','R0163','U0370'),('V0584',4,'I went back after a long hiatus and Im glad I did! The service way much better now. It was a man working the place instead now, he was so kind, the food...','R0163','U0584'),
('V0157',5,'Since my favorite ramen spot in Annapolis closed down, Im always on the hunt for a ramen spot that is equivalent. This place is legit. 



ORDER

Tonkatsu...','R0164','U0157'),('V0371',4,'Hmmm hello!!! 

I ordered tonkatsu and was pleasantly surprised! The broth was plenty flavorful and nods nicely cooked. 

Ill be bank for more!','R0164','U0371'),('V0585',3,'Typical college town quick ramen spot. Not much seating during peak times so expect to carry out if you come during lunch time or to wait a bit.



Ordered...','R0164','U0585'),
('V0158',4,'This place is a Silver Spring classic. Not even a fire couldve kept this place away.



Delectable burgers, sandwiches, and my favorite-wings! You cant...','R0165','U0158'),('V0372',5,'Yet another great night out at Quarry House!  Yes, its your classic dive bar, but this ones got something special going on. Its the kind of place where...','R0165','U0372'),('V0586',3,'This place is really, truly, honestly a dive bar. Its great for a group but there is no phone signal once downstairs. The menu is a tad limited and the...','R0165','U0586'),
('V0159',5,'The most delectable, fresh, mouthwatering, and most appetizing bakery goods I or my family have ever had! We will be back! 



The bread is also amazingly...','R0166','U0159'),('V0373',5,'This is by far the best place to have a cake made for your kids birthday party. We have had all our sons cakes made here for the past 6 years. Despite...','R0166','U0373'),('V0587',5,'Listen..I had no idea that Raulins Bakery had donuts until I did a yelp search of "donuts" and they came up. I cant believe I have missed out on knowing...','R0166','U0587'),
('V0160',4,'I must admit,  Indian cuisine is not at the top of my list. When my friend craved Indian, I groaned. However, being the good friend I am, I went along. I...','R0167','U0160'),('V0374',5,'What an awesome experience. Amazing customer service and friendly atmosphere. The crew was extremely nice and caring.



The orders came fast and then some....','R0167','U0374'),('V0588',5,'All of my friends and my family have been to this place except me so today i thought i should try it..



This is one of the clean well ventilated restaurent...','R0167','U0588'),
('V0161',5,'I love this place. They have the best cocktails even this apple moonshine drink thats soooo good! They even have alcoholic root beer floats!  But whats my...','R0168','U0161'),('V0375',1,'This is just bad quality bad food.



My job orders from here. The service isnt friendly. Tastes like food you can make a home--just with extra...','R0168','U0375'),('V0589',3,'I was extremely excited to visit this location as I have heard and read great things. I visited this location two days in a row, <U+200B>and I was disappointed on...','R0168','U0589'),
('V0162',5,'As a budding brown liquor drinker, I started to explore local distilleries in the area and Republic Restoratives Distillery was highly recommended.  A woman...','R0169','U0162'),('V0376',4,'Republic Restoratives Distillery is a small batch, women-owned craft cocktail bar that specializes in Civic Vodka, Borough Bourbon, Rodham Rye, and...','R0169','U0376'),('V0590',4,'Republic Restorives has a super cool vibe, is very open air with big windows and has a hip bar. The area is relatively small with seats at the bar and a...','R0169','U0590'),
('V0163',5,'Great service, great ice cream - would definitely recommend you get by here. Parking a bit challenging, but would not stop me from

Coming back.','R0170','U0163'),('V0377',4,'Coming from NJ, summer isnt summer without a healthy helping of Italian ice. While there are a few places in the area to get Italian ice, this Ritas is...','R0170','U0377'),('V0591',4,'Ritas means summer, hence happiness. There is almost always a line, and no drive thru. But it is part of a nice summer night stroll and the anticipation....','R0170','U0591'),
('V0164',5,'Dont go here! I want it all to myself. 



Is 10 a rating? This place earned it. Over the top? Yeah, deal. Its that good. This is how tapas was meant to be....','R0171','U0164'),('V0378',4,'Excellent Food and Service 

The Lamb Chops were the best

Loses a star just for ambiance 

We drove up and were concerned we made a bad choice but once the...','R0171','U0378'),('V0592',5,'Wow! This place was amazing! 



The wait staff was friendly and attentive, noticed that right off the bat. The ambience was great, small but intimate and...','R0171','U0592'),
('V0165',5,'Short and sweet: If youre looking for a different take on a FRESH chicken sandwich this is the spot. I havent had the opportunity to check it out in...','R0172','U0165'),('V0379',5,'Wow, this place is solid. I came on a Saturday night, line double backed to the front of the store, but within 20mins I reached the cashier. Parking is a...','R0172','U0379'),('V0593',5,'tldr: UNREAL Chicken sandwich



You walk into this place and think, how is this place so popular? It looks as if someone just threw a few tables in an empty...','R0172','U0593'),
('V0166',4,'I had been longing to try Ramen!  In my neighborhood, it is not available, so to Yelp.com I go!  I chose Saburo Ramen because it was the closest to home...','R0173','U0166'),('V0380',1,'Im so confused by this place - the decor and atmosphere was great and reminiscent of ramen places in Asia but the food was laughably bad! The ramen...','R0173','U0380'),('V0594',2,'If im yelping the next day about a place its either super duper awesome place or a God awful place thats needs to be avoided. 



My friend was sick and...','R0173','U0594'),
('V0167',2,'We came here after the 4th of July parade to grab some lunch. We came in and there was only 4 other tables and they already had their food or was just...','R0174','U0167'),('V0381',4,'What a great little neighborhood restaurant in the Palisades area of Washington, DC.  We were there for Happy Hour, not a full dinner, but it still showed...','R0174','U0381'),('V0595',3,'Food is delicious. Excellent steak salad. Excellent salmon salad. Charming southern decor and atmosphere. The service is novice- inexperienced, slow,...','R0174','U0595'),
('V0168',5,'Ive been going to Sardis for my Peruvian Chicken fix since college. The fast casual eatery is located on Route 1 Baltimore Ave next to a gas station with...','R0175','U0168'),('V0382',4,'I cannot get over how amazing this Peruvian chicken tastes.  Every time someone at work decides to order it, everyone wants in.  I love the yucca and...','R0175','U0382'),('V0596',4,'Im a regular at Sardis, but on Sunday 07/14/2019 I had a not so good experience! I decided to step it up and try the Sardis Salmon. Ive heard nothing...','R0175','U0596'),
('V0169',5,'Ive been a fan of this restaurant since the old days back at the Wheaton Exxon station. So glad theyve moved to a larger space with plenty of authentic...','R0176','U0169'),('V0383',2,'Oooof. This was such a miss. My husband - who looooooves Korean food - picked up dinner for us from here the other day after reading all the stellar...','R0176','U0383'),('V0597',4,'A very cute space and the food comes out fast! The atmosphere is very relaxed. When you first come in, you order at the register/pay before sitting down....','R0176','U0597'),
('V0170',4,'This is a tiny, hidden gem in Beltsville! Its located in a pretty empty shopping center and the restaurant itself is a bit dim and run down looking but I...','R0177','U0170'),('V0384',4,'I come here pretty often since I live right down the street, and I would definitely recommend this place for simple, quality Korean food.



Food:

Okay, hands...','R0177','U0384'),('V0598',4,'My friend and I went to this restaurant to eat For dinner. We got the F3. Its good. We got the hotpot. It was so good that we have to finish. I like the...','R0177','U0598'),
('V0171',5,'I have been coming to this restaurant since I was shorter than the tables and now am 31, a total of 27 years. My family know Sergio and Luigi and every time...','R0178','U0171'),('V0385',4,'A friend recommended Sergios and I have to admit, i was suspicious when he added "its in the Doubletree Hotel." My experience with hotel dining has been...','R0178','U0385'),('V0599',5,'We love Sergio Ristorante and love being treated like family by Pappa Sergio and Son Luigi.  It feels like home.  And the food is always wonderful.  I like...','R0178','U0599'),
('V0172',5,'My my my! Wont he do it!! When I am in need of my Asa Tibsb fix i definitely come here!! Always a treat!! I also get the veggie platter as well as an order...','R0179','U0172'),('V0386',5,'I wish Id been wise to Ethiopian food when I was at school here. I wouldnt come to this place just south of UMDs campus for the ambiance; the windows...','R0179','U0386'),('V0600',5,'My son goes to University Of Maryland so were always looking for new places in the area to eat. We stopped in here last night for dinner and we werent...','R0179','U0600'),
('V0173',4,'I stopped by Shanghai Tokyo Cafe when visiting College Park and was pleasantly surprised at how tasty it was for an off campus retailer. 



There is an...','R0180','U0173'),('V0387',3,'This place is located under the University View 2, which makes for a convenient spot to get some comfort chinese food. During my last year @ UMD I stayed...','R0180','U0387'),('V0601',1,'YIKES. I ordered some dinner here recently and when I opened the container, the first thing I noticed was a staple in the food! How on earth does that even...','R0180','U0601'),
('V0174',5,'Awesome is all I can say! I Finally was able to stop in and meet the owner Cheryl and get some amazing food ! I thought it was just sweets but she sells...','R0181','U0174'),('V0388',5,'I needed some cupcakes for the birthday of a special person. Id forgotten to note the date on my calendar. Panic set in. No time or ingredients to bake...','R0181','U0388'),('V0602',4,'Im extremely saddened by my experience at this bakery. First, I happened to stop by chance. 



I went in and I noticed it looked like items were in the...','R0181','U0602'),
('V0175',4,'I think the food here is quite good. First, I love their chips and salsa. Salsa tastes homemade - very very good. Chips are warm and crisp. 



I always order...','R0182','U0175'),('V0389',5,'Well that was delicious.  2 of us came here around 8pm on a Sunday evening and it was buzzing but not completely packed. It is a smaller restaurant but they...','R0182','U0389'),('V0603',3,'It was late and we just picked up our daughters fiance from the airport and needed dinner that was close to the hotel we were staying.



We walked in here...','R0182','U0603'),
('V0176',4,'This was my first visit here.  We waited about 20 minutes before being seated.



I ordered the lumberjack breakfast, which consisted of silver dollar...','R0183','U0176'),('V0390',5,'Ok time to pull a 180 and update my review. Since last review Ive been here probably 5 more times, and it deserves a better rating. Maybe 4 stars but Ill...','R0183','U0390'),('V0604',5,'This place was just Great! We are visiting the area and our hotel staff recommended this 60s diner. You can play music at the table on a juke box 25 cents...','R0183','U0604'),
('V0177',5,'Simply Banh Mi is a FANTASTIC family owned Vietnamese restaurant with consistently great food and service. 



I usually go for pho with brisket. Their broth...','R0184','U0177'),('V0391',4,'Adorable small family shop!! Not busy at all on a Saturday afternoon. There was only one employee working, so not the quickest service, but he was super...','R0184','U0391'),('V0605',5,'Simply Banh Mi is an adorable spot for fresh, fast Vietnamese food in Georgetown! To order banh mi, you pick a protein and a sauce. The lemongrass tofu banh...','R0184','U0605'),
('V0178',5,'I got two orders of the samosa. One for me and the other for my husband. Its so delicious  I didnt want to share I also got the Naan pizza with chicken,...','R0185','U0178'),('V0392',4,'Great chicken kabob dish with Tikka masala curry. I often find kabob chicken to be dry, but here at this place, it was excellent, very tasty and succulent,...','R0185','U0392'),('V0606',4,'This food is Amazing. I had the Chinatown one.  I got the rice bowl it was slot of food that I could not finish. but it was so good. I would recommend that...','R0185','U0606'),
('V0179',5,'Tldr: best pastrami in the dc area. 



Stachowskis is your local neighborhood meat market for the elite of Georgetown. Prices are on the higher end, but...','R0186','U0179'),('V0393',4,'Ive eaten here twice now and gotten the pastrami sandwich and pickles each time. First off, the sandwich is huge, like NYC Jewish deli huge. For the $16.50...','R0186','U0393'),('V0607',4,'I was in the area & searched "best Pastrami" & Stachowskis came up.  They have fresh and frozen items available.  Also noticed they had Salmon, various...','R0186','U0607'),
('V0180',5,'While Im not one to snap photos of my food and post to yelp (sorry yelpers) this sandwich truly was a work of art. Subbs by Carl is a small, neighborhood...','R0187','U0180'),('V0394',5,'Subbs by Carl is an unassuming top-rated sandwich shop in Woodridge NE near shops like Zekes Coffee and Momo Yakitori. Philly native, Carl, went off to...','R0187','U0394'),('V0608',4,'This is just a quick sub shop. Cash only. The subs remind me of philly hoagies with the fresh thick cuts off meat. The food comes out quick. I love coming...','R0187','U0608'),
('V0181',5,'Had Sugar Vaults cupcakes for a friends birthday dinner. Know nothing about the  business all I know is that the pecan pie and chicken and waffle cupcakes...','R0188','U0181'),('V0395',4,'Lets start with the customer service: I was greeted with a greeting, smile and explanation of what the offerings. They encourage questions and inquiries....','R0188','U0395'),('V0609',3,'I really want to like Sugar Vault Desserts. I tried a chocolate chip cookie in addition to the red velvet cupcake. I went on a Saturday about a month ago....','R0188','U0609'),
('V0182',4,'We ate here tonight for my girlfriends sisters birthday. A must have appetizer is the fire mussels! We ordered a few sushi rolls that was pretty good. The...','R0189','U0182'),('V0396',1,'Good food if you can tolerate the awful attitude you get at the front desk. The first time I went there I was told to wait 15 minutes. Then after 20...','R0189','U0396'),('V0610',4,'Ive been to Sushi Jin a few times now and each time Ive had a good experience. The place is small and feels like you could be in a sushi joint in NYC or...','R0189','U0610'),
('V0183',4,'Came for sushi brunch one Sunday.  Very impressed by the quality and freshness of the sushi but it was hard for the kitchen to keep up with demand as there...','R0190','U0183'),('V0397',3,'The Good:

A great happy hour deal and a great selection of rolls, ($5 classic rolls during happy hour) with even some vegetarian options. I absolutely loved...','R0190','U0397'),('V0611',5,'Happy hour prices are too good to be true! i went for a quick bite to eat after work with a coworker and we had a blast! Drinks were so cheap, sushi rolls...','R0190','U0611'),
('V0184',5,'This is place has good Chinese food and sushi. I tried couple of dishes and the chicken was tender and crispy at the same time. My wife tried sushi and she...','R0191','U0184'),('V0398',3,'This was my first time here and I received a very friendly greeting upon walking in and a thorough explanation of the menu.  I had never had a "sushi...','R0191','U0398'),('V0612',4,'This review is for pick up service only! I had a craving for sushi and decided this place had a nice sounding menu and the reviews were generally good. This...','R0191','U0612'),
('V0185',5,'Attended a birthday dinner last week on a Friday for a large party of about 25 people total. Definitely an amazing experience and would highly recommend...','R0192','U0185'),('V0399',5,'I am so glad that Swahili Village has made such a comeback after the tragic fire that happened not too long ago which shut it down. With it being back, I...','R0192','U0399'),('V0613',3,'This was a good experience having African food. My friend is a huge fan and invited me to join her. I had the Tilapia with collards and rice with a Marsala...','R0192','U0613'),
('V0186',5,'Great vegan fare in an unsuspecting area. I was so happy to find a gem like this! I sat inside at a small table in a window around 3pm on a Sunday, and it...','R0193','U0186'),('V0400',4,'I eat here often and enjoy the Mac and cheese, chicken tenders, greens, and cakes. Recently they changed the Mac and cheese to an entree instead of a side...','R0193','U0400'),('V0614',5,'I had the pleasure of stopping by again recently after my first visit several years ago. (In fact, I stopped by on July 4th and was pleasantly surprised to...','R0193','U0614'),
('V0187',5,'This place is so good that it was an EVENT when my coworker would go pick up an order (not sure if they deliver at all, but at the very least they didnt to...','R0194','U0187'),('V0401',3,'Finally got to try fancy salad LOL. Jk.. Sweetgreen has made salad/bowl recipes but you can also choose your own ingredients and make your own. The...','R0194','U0401'),('V0615',5,'I found this place during my business trip. I am a vegetarian and picky eater. The veggies at Sweetgreen were fresh and the salad tasted very good. I will...','R0194','U0615'),
('V0188',5,'Terrific Tacos with Excellent Meats



Ive been hankering for some pork and tacos recently, so thought 5 De Mayo would hit the spot as I havent visited it...','R0195','U0188'),('V0402',5,'Stumbled into this unassuming spot and now hope to get back here again soon.  The building and interior screams hole in the wall and there is very little...','R0195','U0402'),('V0616',4,'I love a good Latin meal. I dont discriminate; Ill chow down on some Chipotle or Chevys, but, nothing beats an authentically prepared meal with juices...','R0195','U0616'),
('V0189',5,'Real Mexican tacos!!! Really hard to find in the area, I only know of two place where they make genuine Mexican tacos.

The tacos here are amazing and the...','R0196','U0189'),('V0403',4,'How much do I like this place you ask?  Enough to stand outside long enough to be bitten by mosquitos twice.



Tacos are $2.50 each, which is great...','R0196','U0403'),('V0617',5,'Have been here 10+ times in the past year, highly recommend. If you live in Arlington, dont waste your time  and money going to Don Tito, Buena Vida, or...','R0196','U0617'),
('V0190',5,'Went saturday and had a amazing experiance our server Ted was the best. I left satisfied and I cannot wait to come back!','R0197','U0190'),('V0404',3,'I stopped by TTT around 1:30pm on Sunday for a quick meal before heading to an appointment nearby. The place was nearly empty -- just three people at the...','R0197','U0404'),('V0618',4,'A second trip to this establishment yielded a much improved experience that is definitely in the ground floor of the authentic restaurant experience. 

Dont...','R0197','U0618'),
('V0191',5,'Ive been here a few times now, and I feel like it gets better and better. Ive only ever had tacos here because, well, for one, they are a taqueria, and...','R0198','U0191'),('V0405',5,'I dont claim to be a taco expert, but I have eaten quite a few tacos in my life.  This place has amazing tacos, some of the best I had in the area.  Get...','R0198','U0405'),('V0619',3,'This UM College Park spot probably serves as a staple for the campus kids, but it was only my first time discovering it. 

Flavor-wise things were pretty...','R0198','U0619'),
('V0192',5,'After recently moving here from LA, Ive been on a quest. And so far, these are the best tacos Ive found in the DMV, and totally worth the drive. Order at...','R0199','U0192'),('V0406',3,'3.25 stars.

Very authentic tasting. No question.

Front door borders the point of sale - where you order immediately and seat yourself. The server then calls...','R0199','U0406'),('V0620',4,'Tacos are great! Ive been here multiple times and have tried a wide variety of their availabilities (and they have everything from the staples to tongue to...','R0199','U0620'),
('V0193',5,'update: stepanies boyfriend jumped the assitant manager, and they still served us!!! 



10/10','R0200','U0193'),('V0407',5,'My colleague and I came to this place after small business assignments we have.  I ordered drunken noodle chicken from the lunch special.  It turned out to...','R0200','U0407'),('V0621',4,'Im not sure why this place had such low reviews, but it was delicious. Absolutely delicious. 



Everything from our seafood fried rice, to eggplants, to pad...','R0200','U0621'),
('V0194',4,'$10 bento box lunch deal comes with a small bubble tea and a spring roll 

Yum!! 

Slow service during busy hours','R0201','U0194'),('V0408',3,'We ordered takeout yesterday - udon noodle soup, beef noodle soup and two bubble teas.



The noodle soups and bubble teas were really good, however they need...','R0201','U0408'),('V0622',5,'I never have their meals here, but I still come here frequently for their bubble milk tea. 



I can say that their bubble milk tea is just like the original...','R0201','U0622'),
('V0195',4,'Me and my dad came here for lunch and ordered the lunch combo (includes an app from a selection of choices, a soda or iced tea, and a meal from a selection...','R0202','U0195'),('V0409',2,'Ordered the Chicken Thai Noodle Soup.  Struggled to find bean sprouts in it. When I asked for extra, was told that it would be $3 more. I found that...','R0202','U0409'),('V0623',3,'Tasty dinner option in downtown Silver Spring.  It is top floor overlooking a main square (w elevator access).  The inside decor adds to the experience....','R0202','U0623'),
('V0196',5,'I ordered the Falafel Salad and wished instead I had got the Chicken Salad & added a falafel for $1. But it was good, I ate it all. I liked that it came...','R0203','U0196'),('V0410',3,'Second Uber Eats Delivery (3 stars) I ordered the same Falafel Sandwich as before. The Falafel Pita sandwich was not as nicely put together as last time I...','R0203','U0410'),('V0624',5,'I visited here during the lunch hour with a total of 4 people. We ordered at the window and chose a seat closer to the window. The food came out in 6-9...','R0203','U0624'),
('V0197',5,'Super cute place right off of the UMD campus! I only wish I tried more of their menu, but the Old Bay friends were a treat I knew I had to try while in...','R0204','U0197'),('V0411',4,'Was looking for a different place to have breakfast/brunch and decided to hop on my trusty Yelper and found Board and Brew in College Park, MD. We got there...','R0204','U0411'),('V0625',4,'INote:::::::

Was just contacted by Brian and I went up a star because for what it was it was still enjoyable and to have some one reach out like this was...','R0204','U0625'),
('V0198',5,'Just 30 minutes before close & still packed with people! Located in a busy town center, the Italian Store is a nice dose of italianos. Authentic snacks,...','R0205','U0198'),('V0412',4,'Updated review, to reflect the cold sandwiches only.  

5 star sandwiches, with top notch ingredients. 

We ordered the Muffuletta, the Capri, the Napoli, and...','R0205','U0412'),('V0626',4,'Bottom line: An Italian market that serves delicious pizza and what looks like amazing subs and side dishes. The store is stocked with wines, pastas,...','R0205','U0626'),
('V0199',4,'Since Sweet Mangos on Georgia Avenue shutdown, Ive been looking for a good Caribbean spot. Listen!! I found it in Jerk Pit.  I was working in the area and...','R0206','U0199'),('V0413',3,'Tips

-The service is super slow, its best to call ahead

-Some of the best ox tails Ive had to date

-Jerk authentically prepared on the grill but the sauce...','R0206','U0413'),('V0627',4,'Food lowkey deserves five stars, but the parking situation here (unpaved/gravelly mess) and long wait time knocks it down to four. 



If you can endure the...','R0206','U0627'),
('V0200',4,'Came for drinks with coworkers only a few minutes late, but my coworkers had already scarfed a round of wings and sliders. As they gobbled them in only 15...','R0207','U0200'),('V0414',1,'We tried to make reservations on an early Saturday evening. My girlfriend called 5 times and the person who answered the phone placed her on hold every time...','R0207','U0414'),('V0628',1,'So about the place, I would not recommend anyone or go back ever again. From service to food nothing was good

It was a birthday party, had almost 15 of us....','R0207','U0628'),
('V0201',5,'Awesome Find!! The place is inviting and clean and I love the selections and that you can create your own, all of the food is fresh and theyre Vegan, and...','R0208','U0201'),('V0415',4,'I had the 3 kings juice. It couldve benefited from some mango or a more tart apple but overall it was good. Id get another type of juice, however. The...','R0208','U0415'),('V0629',4,'A lil pricey but the juice was good. Nothing monumental. I had hemp seeds added to one of my juices and when they add seeds they dont grind it. Its just...','R0208','U0629'),
('V0202',4,'Probably my favorite local place to grab a slice and the closest thing I have found to a regular corner NYC joint. The dough can be hit or miss. Sometimes...','R0209','U0202'),('V0416',4,'I have been coming here for years and its one of my favorite places to grabs quick bite. The decor is a little dated, but the service is friendly and the...','R0209','U0416'),('V0630',2,'Ive been a semi regular customer for decades. Every couple weeks Ill order an Italian Combo sandwich for carryout. Generally its a really good sandwich,...','R0209','U0630'),
('V0203',5,'Finally I feel at home!

Dont waste your time across the street!



The beers are priced at a reasonable price and there is a good selection of microbrews and...','R0210','U0203'),('V0417',4,'Im gonna break this one down really quick yall.  Its a dive bar attached to a liquor store.  Yes, you can get your buzz going in one room, then stumble...','R0210','U0417'),('V0631',4,'I know nothing about alcohol so when I came in here looking for whiskey to make a holiday dessert, I needed some help.  The guy working here was so nice and...','R0210','U0631'),
('V0204',5,'Trinity Bar and Grill is a great local spot to grab happy hour drinks if you are in the Hyattsville area. I ventured in here for the first time this past...','R0211','U0204'),('V0418',5,'This place makes me PROUD! 



A family run establishment, I absolutely love everything about this business. The customer service is stellar<U+200B>. The bathroom...','R0211','U0418'),('V0632',3,'When we first got there it started out okay but when more of our party got there it started to go down hill the manager dont know how to talk to people the...','R0211','U0632'),
('V0205',4,'Yum! Ill start with the best--the sweet potato pancakes were so moist and delicious. The goat cheese grits were also very flavorful. Loved them both. 



My...','R0212','U0205'),('V0419',2,'There is nothing fresh about the food I had. Its pan-Southern fare that isnt that great.  I was excited about trying it, but there was nothing special at...','R0212','U0419'),('V0633',2,'Came here with a coworker for a informal business dinner. I was looking forward to coming because I had heard a lot about brunch. I assume dinner would be...','R0212','U0633'),
('V0206',5,'Ive been craving an acai bowl for a LONG time now, but there werent any locations that stayed opened past 7 PM around the Montgomery County area besides...','R0213','U0206'),('V0420',5,'Here to set the record straight that yes, this location has excellent froyo and a ton of great toppings-- but everybody needs to go out and try their a¡aÃ...','R0213','U0420'),('V0634',4,'Tutti Frutti is a serve yourself frozen yogurt joint. This particular location is in a shopping center. The parking is a bit sparse due to all of the other...','R0213','U0634'),
('V0207',4,'Every so often I like to spoil my husband with an elaborate dinner out. Urban butcher had been on my list for a while so when our dinner plans in downtown...','R0214','U0207'),('V0421',5,'Its been awhile since Ive been here but this is still a Silver Spring favorite. They recently changed their decor and I preferred the previous design. But...','R0214','U0421'),('V0635',4,'I went for the first time today:



Parking: there are limited spots behind the restaurant. Most are $5 unlimited and the other 3-4 spots are free.



Ambiance:...','R0214','U0635'),
('V0208',5,'I love this cafe. This probably is my favorite around the area. Everything from the atmosphere, to the ambiance, drinks, and WiFi is amazing. 



Seating:...','R0215','U0208'),('V0422',4,'Ive been meaning to try this coffee shop for awhile and finally got to go last week! 

I had time before my class and I decided to walk here. It took about...','R0215','U0422'),('V0636',5,'Ive tried vigilante coffee twice and I loved it. They have everything you need from a good coffee shop; Good coffee, nice treats, strong WiFi, ample...','R0215','U0636'),
('V0209',5,'It feels weird reviewing a cathedral, but this review is limited to the gargoyle tour. 



This has been on my bucket list for the past 6 years, and I am so...','R0216','U0209'),('V0423',4,'I have wanted to tour Washington National Cathedral for some time, but I ultimately kept putting it off. However, the Combination Tower Climb Tour ($75),...','R0216','U0423'),('V0637',5,'Another place in DC worth the visit, even though this one is a bit out of the way. Like its not near the National Mall or stuff like that. The cathedral is...','R0216','U0637'),
('V0210',5,'Wawa and I have a special bond. My happy  UMD days was partly to Wawa.....





NOTE::  Cheap and competitive gas prices!!



Best coffee! Better than...','R0217','U0210'),('V0424',4,'Discovered the amazingness of Wawa subs (thanks to my husband)! Delicious steak and cheese and today we finally tried the gobbler! Would choose Wawa subs...','R0217','U0424'),('V0638',5,'Wawa is a true gas station delight. Now when I tell yall their food is shmackkkkkinnn you just gotta take my word for it. I recommend the turkey club...','R0217','U0638'),
('V0211',5,'Im sorry for what I said when I was hangry! ~Love Mister Food Visas* 

.

All better now, that Woodlandrestaruant has feed him 

.

MASALA DOSAI - Delicious...','R0218','U0211'),('V0425',4,'I had been here couple times, good spot for vegetarian food, they serve good South Indian food.  I like their masala dosa and medu vada.



This time I...','R0218','U0425'),('V0639',3,'We were here for a weekday buffet.

My husband was a regular here during his college days (few years back)and couldnt stop saying all the good things about...','R0218','U0639'),
('V0212',5,'Delicious! 



The chicken is delicious, tender, well seasoned. 

The pork is delicious and well seasoned.

The pita is soft and fresh. 

The house salad was...','R0219','U0212'),('V0426',4,'When I heard there was another Greek place coming to town, I had to try it. Back then, Marathon Deli ruled the College Park area as the only easily...','R0219','U0426'),('V0640',4,'Ive driven past this place multiple times so finally decided to give it a try. Its been a while since Ive had Greek food so I was really excited. We...','R0219','U0640'),
('V0213',5,'The best Frozen Yogurt I have had in college park!!

Many options are available and the staff is friendly too.','R0220','U0213'),('V0427',3,'Typical Yogurt chain! The store is ran by a one man show. The kid working there doesnt say hello to customers but does finally speak to you at the counter....','R0220','U0427'),('V0641',3,'Got frozen yogurt from here and the cashier was very helpful in helping me choose what Id like. My problem is that when I sampled different flavors they...','R0220','U0641'),
('V0214',5,'Zeds Cafe is one of the coolest spots in the DMV. Seriously. The food? Delicious, fresh, and prepared with love. Trying their waffles and veggie omelettes...','R0221','U0214'),('V0428',4,'Came here with a friend after a long bike ride, and we split the smoked salmon salad, since we had to bike back and didnt want to eat too much. The salad...','R0221','U0428'),('V0642',5,'Awesome little cafe! Quiet space, with soft blues/jazz playing. Couch, love seats and tables to curl up and read a book or do some writing. Lots of green...','R0221','U0642');



INSERT INTO [Jelp.Shuttle] VALUES
( 'B0143','Regents Drive Garage','Varsity Team House','NO','95'),
( 'B0113','Regents Drive Garage','Varsity Team House','NO','50'),
( 'B0142','Regents Drive Garage','Broken Land Park & Ride East Lot','NO','85'),
( 'B0111','Stamp Student Union  Lot HH','Regents Drive Garage','NO','15'),
( 'B0104','Regents Drive Garage','Glenn L. Martin Wind Tunnel','NO','10'),
( 'B0128','Stamp Student Union - Lot HH','The Enclave','NO','25');

 
INSERT INTO [Jelp.StopLocation] VALUES
('S0001','42nd Avenue and Jefferson Street',38.955396,-76.945753),
('S0002','42nd Avenue and Madison Street',38.958007,-76.946762),
('S0003','42nd Avenue and Oglethorpe Street',38.959684,-76.946579),
('S0004','42nd Avenue and Queensbury Road',38.963572,-76.946322),
('S0005','Adelphi Road and Campus Drive',38.984637,-76.955270),
('S0006','Adelphi Road and Toledo Road',38.970634,-76.948984),
('S0007','Adelphi Road and Van Buren Street',38.975309,-76.951698),
('S0008','Adelphi Road and Wells Boulevard',38.979529,-76.954656),
('S0009','Adelphi Road and Wells Parkway',38.979237,-76.954271),
('S0010','Adelphi Road at Graduate Hills Apartments',38.984659,-76.955561),
('S0011','Adelphi Road at Northwestern High School',38.975467,-76.952178),
('S0012','Art/Sociology Building',38.985277,-76.946780),
('S0013','Bagel Place of College Park',38.981930,-76.937540),
('S0014','Baltimore Avenue and Berwyn Road (Inbound)',38.996410,-76.931860),
('S0015','Baltimore Avenue and Gallatin Street',38.953070,-76.940432),
('S0016','Baltimore Avenue and Hamilton Street',38.954272,-76.940271),
('S0017','Baltimore Avenue and Longfellow Street',38.956716,-76.940005),
('S0018','Baltimore Avenue and Oglethorpe Street',38.959375,-76.939706),
('S0019','Baltimore Avenue and Quebec Street (Inbound)',38.994584,-76.932166),
('S0020','Baltimore Avenue at The Varsity',38.990805,-76.933954),
('S0021','Belcrest Road and Queens Chapel Road',38.964431,-76.952652),
('S0022','Blaze Fast-Fired Pizza',38.981820,-76.937530),
('S0023','Broken Land Park & Ride East Lot',39.174235,-76.849472),
('S0024','Busboys and Poets - Hyattsville',38.955150,-76.940020),
('S0025','Campus Drive and Diamondback Drive',38.987977,-76.934040),
('S0026','Campus Drive and Rhode Island Avenue (Inbound)',38.983601,-76.930949),
('S0027','Campus Drive and Rhode Island Avenue (Outbound)',38.983553,-76.931345),
('S0028','Campus Drive at Lot 3',38.984711,-76.951547),
('S0029','Campus Drive at Math Slip',38.987854,-76.938599),
('S0030','Campus Drive at M-Circle',38.987735,-76.939524),
('S0031','Carroll Avenue and Anne Street',38.987606,-76.994559),
('S0032','Carroll Avenue and Chester Street',38.989928,-76.993593),
('S0033','Carroll Avenue and Garland Avenue (Inbound)',38.986213,-76.996152),
('S0034','Carroll Avenue and Garland Avenue (Outbound)',38.986221,-76.996323),
('S0035','Carroll Avenue and Glenside Drive',38.987981,-76.994419),
('S0036','Carroll Avenue and Wildwood Drive',38.989715,-76.993454),
('S0037','College Park - UMD Metro Station',38.975540,-76.927999),
('S0038','College Park Diner',39.006350,-76.930240),
('S0039','Denton Hall',38.991938,-76.950089),
('S0040','Farragut Street and 42nd Place',38.951708,-76.944361),
('S0041','Farragut Street and Rhode Island Avenue',38.951598,-76.941215),
('S0042','Flower Avenue and Carroll Avenue (Inbound)',38.985209,-76.998900),
('S0043','Flower Avenue and Carroll Avenue (Outbound)',38.985312,-76.998845),
('S0044','Flower Avenue and Domer Avenue (Inbound)',38.996274,-77.003136),
('S0045','Flower Avenue and Domer Avenue (Outbound)',38.996682,-77.003142),
('S0046','Flower Avenue and Hudson Avenue (Inbound)',38.992563,-77.002289),
('S0047','Flower Avenue and Hudson Avenue (Outbound)',38.992455,-77.002149),
('S0048','Flower Avenue and Kennebec Avenue (Inbound)',38.989720,-77.001548),
('S0049','Flower Avenue and Kennebec Avenue (Outbound)',38.989586,-77.001350),
('S0050','Flower Avenue and Plymouth Street (Inbound)',39.001560,-77.004697),
('S0051','Flower Avenue and Plymouth Street (Outbound)',39.001604,-77.004506),
('S0052','Flower Avenue at Washington Adventist University (Inbound)',38.987005,-77.000341),
('S0053','Flower Avenue at Washington Adventist University (Outbound)',38.986738,-76.999923),
('S0054','Glenn L. Martin Wind Tunnel',38.989959,-76.937247),
('S0055','Guss World Famous Fried Chicken',38.998310,-76.913940),
('S0056','Marathon Deli',38.981660,-76.938610),
('S0057','Merrimac Drive and Lockney Avenue',38.992442,-76.992139),
('S0058','Merrimac Drive and University Boulevard',38.992492,-76.991726),
('S0059','Milk & Honey Cafe',39.023300,-76.924250),
('S0060','Mission BBQ',38.998320,-76.912140),
('S0061','NuVegan Cafe - College Park',38.991150,-76.934040),
('S0062','Pho DLite',38.991250,-76.932750),
('S0063','Prince Georges Community College',38.968151,-76.953907),
('S0064','Prince Georges Plaza Metro Station (Inbound)',38.965433,-76.953731),
('S0065','Prince Georges Plaza Metro Station (Outbound)',38.965846,-76.954218),
('S0066','Queensbury Road and 39th Place',38.963914,-76.950366),
('S0067','Queensbury Road and 42nd Place',38.963830,-76.945045),
('S0068','Queensbury Road and 44th Place',38.963330,-76.940442),
('S0069','Regents Drive Garage',38.989522,-76.940772),
('S0070','Sardis Pollo A La Brasa',39.027290,-76.917860),
('S0071','Silver Diner',38.998130,-76.910020),
('S0072','Silver Spring Metro Station',38.993672,-77.029740),
('S0073','Stadium Drive and University Boulevard',38.991756,-76.950237),
('S0074','Stadium Drive Garage',38.991746,-76.947544),
('S0075','Stamp Student Union - Lot HH',38.987431,-76.943882),
('S0076','Stamp Student Union - Slip',38.987610,-76.943945),
('S0077','Takoma-Langley Crossroads Transit Center (Inbound)',38.990050,-76.988170),
('S0078','Takoma-Langley Crossroads Transit Center (Outbound)',38.989900,-76.988530),
('S0079','Taqueria Habanero',38.991230,-76.932440),
('S0080','The Board and Brew',38.991730,-76.934260),
('S0081','The Enclave',38.997806,-76.931768),
('S0082','The Mall at Prince Georges',38.968211,-76.954226),
('S0083','Toledo Road and Adelphi Road',38.970097,-76.949795),
('S0084','Toledo Road and Belcrest Road (Inbound)',38.968211,-76.954226),
('S0085','Toledo Road and Belcrest Road (Outbound)',38.970003,-76.953280),
('S0086','Union Drive at Lot 1b',38.987244,-76.948162),
('S0087','University Boulevard and 14th Avenue',38.987238,-76.985287),
('S0088','University Boulevard and 25th Avenue',38.984409,-76.967412),
('S0089','University Boulevard and Guilford Road',38.983541,-76.976215),
('S0090','University Boulevard and New Hampshire Avenue',38.988042,-76.986207),
('S0091','University Boulevard and Riggs Road (Inbound)',38.984734,-76.981031),
('S0092','University Boulevard and Riggs Road (Outbound)',38.984595,-76.980300),
('S0093','University Boulevard and Tulane Drive',38.985458,-76.958818),
('S0094','University Boulevard at Adelphi Plaza',38.984676,-76.967111),
('S0095','University Boulevard at Campus Gardens',38.984079,-76.973068),
('S0096','University Boulevard at Graduate Hills',38.985337,-76.957866),
('S0097','Valley Drive at Stadium Drive Garage',38.990237,-76.949358),
('S0098','Varsity Team House',38.990587,-76.945410),
('S0099','Wayne Avenue and Dale Drive (Inbound)',38.999191,-77.017740),
('S0100','Wayne Avenue and Dale Drive (Outbound)',38.999414,-77.017287),
('S0101','Wayne Avenue and Fenton Street (Inbound)',38.995196,-77.024565),
('S0102','Wayne Avenue and Fenton Street (Outbound)',38.995998,-77.023563),
('S0103','Wayne Avenue and Sligo Creek Parkway (Inbound)',38.999573,-77.010012),
('B0104','Wayne Avenue and Sligo Creek Parkway (Outbound)',38.999675,-77.010414),
('S0105','Yia Yias Kitchen',39.026700,-76.918730);
 
INSERT INTO [Jelp.Pass] VALUES
('R0012','B0143'),
('R0044','B0143'),
('R0062','B0143'),
('R0079','B0143'),
('R0083','B0143'),
('R0084','B0143'),
('R0091','B0143'),
('R0093','B0143'),
('R0129','B0143'),
('R0151','B0143'),
('R0183','B0143'),
('R0209','B0143'),
('R0040','B0142'),
('R0054','B0142'),
('R0061','B0142'),
('R0074','B0142'),
('R0094','B0142'),
('R0115','B0142'),
('R0116','B0142'),
('R0133','B0142'),
('R0144','B0142'),
('R0145','B0142'),
('R0148','B0142'),
('R0150','B0142'),
('R0153','B0142'),
('R0157','B0142'),
('R0163','B0142'),
('R0166','B0142'),
('R0168','B0142'),
('R0175','B0142'),
('R0177','B0142'),
('R0182','B0142'),
('R0192','B0142'),
('R0217','B0142'),
('R0219','B0142'),
('R0018','B0113'),
('R0026','B0113'),
('R0033','B0113'),
('R0034','B0113'),
('R0036','B0113'),
('R0042','B0113'),
('R0063','B0113'),
('R0073','B0113'),
('R0106','B0113'),
('R0118','B0113'),
('R0136','B0113'),
('R0160','B0113'),
('R0179','B0113'),
('R0181','B0113'),
('R0185','B0113'),
('R0188','B0113'),
('R0191','B0113'),
('R0195','B0113'),
('R0199','B0113'),
('R0200','B0113'),
('R0211','B0113'),
('R0220','B0113'),
('R0003','B0111'),
('R0004','B0111'),
('R0006','B0111'),
('R0008','B0111'),
('R0019','B0111'),
('R0020','B0111'),
('R0021','B0111'),
('R0028','B0111'),
('R0030','B0111'),
('R0031','B0111'),
('R0037','B0111'),
('R0041','B0111'),
('R0049','B0111'),
('R0050','B0111'),
('R0052','B0111'),
('R0060','B0111'),
('R0066','B0111'),
('R0069','B0111'),
('R0077','B0111'),
('R0080','B0111'),
('R0087','B0111'),
('R0092','B0111'),
('R0096','B0111'),
('R0098','B0111'),
('R0099','B0111'),
('R0101','B0111'),
('R0105','B0111'),
('R0107','B0111'),
('R0111','B0111'),
('R0114','B0111'),
('R0119','B0111'),
('R0121','B0111'),
('R0122','B0111'),
('R0126','B0111'),
('R0127','B0111'),
('R0130','B0111'),
('R0134','B0111'),
('R0140','B0111'),
('R0142','B0111'),
('R0149','B0111'),
('R0155','B0111'),
('R0165','B0111'),
('R0178','B0111'),
('R0189','B0111'),
('R0197','B0111'),
('R0202','B0111'),
('R0203','B0111'),
('R0207','B0111'),
('R0213','B0111'),
('R0214','B0111'),
('R0221','B0111'),
('R0009','B0104'),
('R0010','B0104'),
('R0012','B0104'),
('R0024','B0104'),
('R0029','B0104'),
('R0046','B0104'),
('R0047','B0104'),
('R0048','B0104'),
('R0053','B0104'),
('R0072','B0104'),
('R0081','B0104'),
('R0082','B0104'),
('R0086','B0104'),
('R0090','B0104'),
('R0097','B0104'),
('R0103','B0104'),
('R0104','B0104'),
('R0109','B0104'),
('R0110','B0104'),
('R0113','B0104'),
('R0117','B0104'),
('R0128','B0104'),
('R0135','B0104'),
('R0139','B0104'),
('R0141','B0104'),
('R0146','B0104'),
('R0154','B0104'),
('R0156','B0104'),
('R0159','B0104'),
('R0161','B0104'),
('R0164','B0104'),
('R0170','B0104'),
('R0173','B0104'),
('R0180','B0104'),
('R0194','B0104'),
('R0198','B0104'),
('R0201','B0104'),
('R0204','B0104'),
('R0206','B0104'),
('R0210','B0104'),
('R0215','B0104');


INSERT INTO [Jelp.Stop] VALUES
('S0001','B0113'),
('S0002','B0113'),
('S0003','B0113'),
('S0004','B0113'),
('S0005','B0113'),
('S0006','B0113'),
('S0007','B0113'),
('S0008','B0113'),
('S0009','B0113'),
('S0010','B0113'),
('S0011','B0113'),
('S0012','B0111'),
('S0013','B0143'),
('S0014','B0128'),
('S0015','B0113'),
('S0016','B0113'),
('S0017','B0113'),
('S0018','B0113'),
('S0019','B0128'),
('S0020','B0128'),
('S0021','B0113'),
('S0022','B0143'),
('S0023','B0142'),
('S0024','B0143'),
('S0025','B0104'),
('S0026','B0104'),
('S0027','B0104'),
('S0028','B0111'),
('S0029','B0104'),
('S0030','B0128'),
('S0031','B0111'),
('S0032','B0111'),
('S0033','B0111'),
('S0034','B0111'),
('S0035','B0111'),
('S0036','B0111'),
('S0037','B0104'),
('S0038','B0143'),
('S0039','B0128'),
('S0040','B0113'),
('S0041','B0113'),
('S0042','B0111'),
('S0043','B0111'),
('S0044','B0111'),
('S0045','B0111'),
('S0046','B0111'),
('S0047','B0111'),
('S0048','B0111'),
('S0049','B0111'),
('S0050','B0111'),
('S0051','B0111'),
('S0052','B0111'),
('S0053','B0111'),
('S0054','B0104'),
('S0055','B0143'),
('S0056','B0143'),
('S0057','B0111'),
('S0058','B0111'),
('S0059','B0143'),
('S0060','B0143'),
('S0061','B0143'),
('S0062','B0143'),
('S0063','B0113'),
('S0064','B0113'),
('S0065','B0113'),
('S0066','B0113'),
('S0067','B0113'),
('S0068','B0113'),
('S0069','B0111'),
('S0070','B0143'),
('S0071','B0143'),
('S0072','B0111'),
('S0073','B0111'),
('S0074','B0111'),
('S0075','B0111'),
('S0076','B0113'),
('S0077','B0111'),
('S0078','B0111'),
('S0079','B0143'),
('S0080','B0143'),
('S0081','B0128'),
('S0082','B0113'),
('S0083','B0113'),
('S0084','B0113'),
('S0085','B0113'),
('S0086','B0128'),
('S0087','B0111'),
('S0088','B0111'),
('S0089','B0111'),
('S0090','B0111'),
('S0091','B0111'),
('S0092','B0111'),
('S0093','B0111'),
('S0094','B0111'),
('S0095','B0111'),
('S0096','B0111'),
('S0097','B0128'),
('S0098','B0111'),
('S0099','B0111'),
('S0100','B0111'),
('S0101','B0111'),
('S0102','B0111'),
('S0103','B0111'),
('B0104','B0111'),
('S0105','B0143'),
('S0012','B0113'),
('S0069','B0104'),
('S0098','B0113'),
('S0073','B0113'),
('S0074','B0113'),
('S0075','B0128'),
('S0076','B0128'),
('S0069','B0113'),
('S0069','B0142');

 

 SELECT COUNT(*)
  FROM [Jelp.City]
 SELECT COUNT(*)
  FROM [Jelp.Restaurant]
 SELECT COUNT(*)
  FROM [Jelp.User]
 SELECT COUNT(*)
  FROM [Jelp.Review]
 SELECT COUNT(*)
  FROM [Jelp.Shuttle]
 SELECT COUNT(*)
  FROM [Jelp.StopLocation]
 SELECT COUNT(*)
  FROM [Jelp.Pass]
 SELECT COUNT(*)
  FROM [Jelp.Stop]
 