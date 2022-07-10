------------------------------------
--        Projekt IDS             --
--         27.4.2019              --
--     Ján Folenta (xfolen00)     -- 
--    Jozef Ondria (xondri05)     --
------------------------------------

-----------------------------
--   VYMAZANIE TABULIEK   --
-----------------------------

DROP TABLE AutoT CASCADE CONSTRAINTS;
DROP TABLE Spolujazda CASCADE CONSTRAINTS;
DROP TABLE NaTrase CASCADE CONSTRAINTS;
DROP TABLE Uzivatel CASCADE CONSTRAINTS;
DROP TABLE HodnotenieSpolujazdca CASCADE CONSTRAINTS;
DROP TABLE HodnotenieSofera CASCADE CONSTRAINTS;
DROP TABLE Vylet CASCADE CONSTRAINTS;
DROP TABLE ZucastnujeSaRel CASCADE CONSTRAINTS;
DROP TABLE NavstevneMiesta CASCADE CONSTRAINTS;
DROP TABLE ZahrnaRel CASCADE CONSTRAINTS;
DROP TABLE Prispevok CASCADE CONSTRAINTS;
DROP TABLE Clanok CASCADE CONSTRAINTS;
DROP TABLE Vlog CASCADE CONSTRAINTS;

DROP SEQUENCE ID_Uzivatel_seq;
-----------------------------
--   VYTVORENIE TABULIEK   --
-----------------------------

CREATE TABLE Uzivatel
(
    ID_Uzivatel 	    INT             NOT NULL PRIMARY KEY,
	Meno      		    VARCHAR(20)		NOT NULL,
	Priezvisko 		    VARCHAR(30)		NOT NULL,
    Email               VARCHAR(30)     NOT NULL,
    Telefon      		CHAR(13)		NOT NULL,
    Popis      		    VARCHAR(300)    NULL,
    ProfilovaFotka	    BLOB        	NULL,
    MaRadHudbu      	NUMBER(1)       NOT NULL  check (MaRadHudbu in ('0','1')),
    VadiMuFajcenie	    NUMBER(1)		NOT NULL  check (VadiMuFajcenie in ('0','1')),
    VadiaMuZvirata      NUMBER(1)		NOT NULL  check (VadiaMuZvirata in ('0','1')),
    PocetPonukSpolujazd	INT		        NOT NULL,
    CONSTRAINT	u1_uzivatel UNIQUE (Email)
);

CREATE TABLE AutoT
(	
    ID_Auto			INT				GENERATED AS IDENTITY PRIMARY KEY,
	Znacka  		VARCHAR(25)		NOT NULL,
	ModelAuta 		VARCHAR(25)		NOT NULL,
    Farba           CHAR(15)        NOT NULL,
    ID_Uzivatel     INT             NOT NULL,
    CONSTRAINT	fk1_auto	FOREIGN KEY	(ID_Uzivatel)		REFERENCES Uzivatel 	(ID_Uzivatel)
);


CREATE TABLE Spolujazda
(	
    ID_Spolujazda	    INT				GENERATED AS IDENTITY PRIMARY KEY,
	Cena      		    FLOAT		    NOT NULL,
    DatumCasOdchodu     TIMESTAMP       NOT NULL,
	Zachadzka 		    VARCHAR(30)		NULL,
    CasovaFlexibilita   VARCHAR(30)     NULL,
    PovolenVelkBatoziny VARCHAR(100)		NOT NULL,
    MaxPocetOsobVZadu   INT             NOT NULL,
    ID_Auto             INT             NOT NULL,
	ID_Uzivatel         INT             NOT NULL,
    CONSTRAINT	fk1_spolujazda	FOREIGN KEY	(ID_Auto)		REFERENCES  AutoT  	(ID_Auto),
    CONSTRAINT	fk2_spolujazda	FOREIGN KEY	(ID_Uzivatel)	REFERENCES  Uzivatel 	(ID_Uzivatel),
    CONSTRAINT	c1_spolujazda	CHECK	(MaxPocetOsobVZadu = '1' OR MaxPocetOsobVZadu = '2' 
	OR MaxPocetOsobVZadu = '3' OR MaxPocetOsobVZadu = '4')
);


CREATE TABLE NaTrase
(	
    ID_Spolujazda           INT             NOT NULL,
    ID_Uzivatel             INT             NOT NULL,
	OdMiesta      		    VARCHAR(60)		NOT NULL,
    NaMiesto 		        VARCHAR(60)		NOT NULL,
    CONSTRAINT	fk1_natrase	FOREIGN KEY	(ID_Spolujazda)	REFERENCES  Spolujazda  (ID_Spolujazda),
    CONSTRAINT	fk2_natrase	FOREIGN KEY	(ID_Uzivatel)	REFERENCES  Uzivatel 	(ID_Uzivatel)
);

CREATE TABLE HodnotenieSpolujazdca
(	
    ID_HodnotSpolujazd      INT				GENERATED AS IDENTITY PRIMARY KEY,
	PopisHodnotenia         VARCHAR(300)	NULL,
	JeDochvilny      	    NUMBER(1)		NOT NULL     check (JeDochvilny in ('0','1')),
    JePriatelsky            NUMBER(1)		NOT NULL     check (JePriatelsky in ('0','1')),
    ID_UzivatelHodnoteny    INT             NOT NULL,
    ID_UzivatelHodnotitel   INT             NOT NULL,
    CONSTRAINT	fk1_hodnoteniespolujazdca	FOREIGN KEY	(ID_UzivatelHodnoteny)	REFERENCES  Uzivatel 	(ID_Uzivatel),
    CONSTRAINT	fk2_hodnoteniespolujazdca	FOREIGN KEY	(ID_UzivatelHodnotitel)	REFERENCES  Uzivatel 	(ID_Uzivatel)
);

CREATE TABLE HodnotenieSofera
(	
    ID_HodnotSofera         INT				GENERATED AS IDENTITY PRIMARY KEY,
	PopisHodnotenia         VARCHAR(300)	NULL,
	PocetHviezdiciek   	    SMALLINT		NOT NULL check (PocetHviezdiciek in ('0','1','2','3','4','5')),
    ID_UzivatelHodnoteny    INT             NOT NULL,
    ID_UzivatelHodnotitel   INT             NOT NULL,
    CONSTRAINT	fk1_hodnoteniesofera	FOREIGN KEY	(ID_UzivatelHodnoteny)	REFERENCES  Uzivatel 	(ID_Uzivatel),
    CONSTRAINT	fk2_hodnoteniesofera	FOREIGN KEY	(ID_UzivatelHodnotitel)	REFERENCES  Uzivatel 	(ID_Uzivatel)
);

CREATE TABLE Vylet
(	
    ID_Vylet     	    INT				GENERATED AS IDENTITY PRIMARY KEY,
	PopisProgramu      	VARCHAR(1000)	NULL,
	NakladyNaCestovne 	FLOAT		    NOT NULL,
    NakladyNaOstatne    VARCHAR(300)      NOT NULL,
    NarokyNaVybavenie   VARCHAR(300)	NULL,
    ZaciatokVyletu      TIMESTAMP        NOT NULL,
    NastupneMiesto	    VARCHAR(60)   	NOT NULL,
    KoniecVyletu      	TIMESTAMP	    NOT NULL,
    VystupneMiesto	    VARCHAR(60)		NOT NULL,
    ID_Auto             INT             NOT NULL,
    ID_Uzivatel         INT             NOT NULL,
    CONSTRAINT	fk1_vylet	FOREIGN KEY	(ID_Auto)	REFERENCES  AutoT 	(ID_Auto),
    CONSTRAINT	fk2_vylet	FOREIGN KEY	(ID_Uzivatel)	REFERENCES  Uzivatel 	(ID_Uzivatel)
);

CREATE TABLE ZucastnujeSaRel
(
    ID_ZucastujeSaRel       INT     GENERATED AS IDENTITY PRIMARY KEY,
    ID_Uzivatel             INT     NOT NULL,
    ID_Vylet                INT     NOT NULL,
    CONSTRAINT	fk1_zucastujesarel	FOREIGN KEY	(ID_Uzivatel)	REFERENCES  Uzivatel 	(ID_Uzivatel),
    CONSTRAINT	fk2_zucastujesarel	FOREIGN KEY	(ID_Vylet)	REFERENCES  Vylet 	(ID_Vylet)
);

CREATE TABLE NavstevneMiesta
(	
    ID_NavstevneMiesta  INT				GENERATED AS IDENTITY PRIMARY KEY,
	Mesto               VARCHAR(60)	    NOT NULL,
	CasPrichodu   	    TIMESTAMP		NOT NULL,
    CasOdchodu          TIMESTAMP       NOT NULL,
    MoznostiUbytovania  VARCHAR(200)    NULL
);

CREATE TABLE ZahrnaRel
(
    ID_ZahrnaRel            INT     GENERATED AS IDENTITY PRIMARY KEY,
    ID_Vylet                INT     NOT NULL,
    ID_NavstevneMiesta      INT     NOT NULL,
    CONSTRAINT	fk1_zahrnarel	FOREIGN KEY	(ID_Vylet)	REFERENCES  Vylet 	(ID_Vylet),
    CONSTRAINT	fk2_zahrnarel	FOREIGN KEY	(ID_NavstevneMiesta)	REFERENCES  NavstevneMiesta 	(ID_NavstevneMiesta)
);

CREATE TABLE Prispevok
(	
    ID_Prispevok        INT				GENERATED AS IDENTITY PRIMARY KEY,
	Nazov               VARCHAR(30)	    NOT NULL,
	Popis          	    VARCHAR(200)	NULL,
    ID_Uzivatel         INT             NOT NULL,
    ID_Vylet            INT             NOT NULL,
    CONSTRAINT	fk1_prispevok	FOREIGN KEY	(ID_Uzivatel)	REFERENCES  Uzivatel 	(ID_Uzivatel),
    CONSTRAINT	fk2_prispevok	FOREIGN KEY	(ID_Vylet)	REFERENCES  Vylet 	(ID_Vylet)
);

CREATE TABLE Clanok
(
    ID_Prispevok       INT             NOT NULL,
    Clanok             VARCHAR(1000)    NOT NULL,
    CONSTRAINT	fk1_clanok	FOREIGN KEY	(ID_Prispevok)	REFERENCES  Prispevok 	(ID_Prispevok)
);

CREATE TABLE Vlog
(
    ID_Prispevok     INT          NOT NULL,
    Video            BLOB         NOT NULL,
    CONSTRAINT	fk1_vlog	FOREIGN KEY	(ID_Prispevok)	REFERENCES  Prispevok 	(ID_Prispevok)
);


-----------------------------
--        TRIGGERY         --
-----------------------------

-- Trigger pre autoinkrementaciu ID Uzivatela
CREATE SEQUENCE ID_Uzivatel_seq;

CREATE OR REPLACE TRIGGER autoincrement_trigger
    BEFORE INSERT ON Uzivatel
    FOR EACH ROW
    BEGIN
        :new.ID_Uzivatel := ID_Uzivatel_seq.nextval;
    END;
/

-- Trigger pre overenie validity emailu
CREATE OR REPLACE TRIGGER kontrola_emailovej_adresy_trigger
    BEFORE INSERT OR UPDATE OF Email ON Uzivatel
    FOR EACH ROW 
DECLARE 
    mail Uzivatel.Email%TYPE;
    meno VARCHAR(64);
    domena VARCHAR(253);
    find INTEGER;
BEGIN
    mail := :new.Email;
   
    -- V adrese sa nemoze nachadzat medzera
    IF (INSTR(mail, ' ') != 0) THEN
        Raise_Application_Error (-20001, 'Medzera v emailovej adrese');
    END IF;
    
    -- V adrese sa nemozu nachadzat nepovolene znaky
    IF (REGEXP_LIKE(mail, '(^[a-zA-Z0-9!#$%@&*+/=?^_`{|}.-]*$)')) THEN
        find := INSTR(mail, '@');
    ELSE
        Raise_Application_Error (-20002, 'Nepovolene znaky v emailovej adrese');
    END IF;
      
    -- V adrese sa musi nachadzat prave jeden zavinac
    IF (INSTR(mail, '@') = 0 OR INSTR(mail, '@') != INSTR(mail, '@', -1)) THEN
        Raise_Application_Error (-20003, 'V adrese sa nenachadza prave 1 znak @');
    END IF;
  
    -- meno ---------------------------------------  
        
    meno := SUBSTR(mail, 1, find - 1);
    
    -- Zavinac nemoze byt na zaciatku emailovej adresy
    IF (LENGTH(meno) IS NULL) THEN
        Raise_Application_Error (-20004, 'Znak @ sa nachadza na zaciatku adresy');
    END IF;
    
    -- Nemozu sa nachadzat 2 specialne znaky po sebe
    IF (REGEXP_LIKE(meno, '([!#$%&*+-/=?^_`{|}.])\1')) THEN
        Raise_Application_Error (-20005, '2 specialne znaky po sebe');
    END IF;
    
    -- Na konci alebo na zaciatku nemoze byt specialny znak
    IF (REGEXP_LIKE(meno, '(^[!#$%&*+-/=?^_`{|}.])') OR REGEXP_LIKE(meno, '([!#$%&*+-/=?^_`{|}.]$)')) THEN
        Raise_Application_Error (-20006, 'Na zaciatku alebo na konci sa nachadza specialny znak');
    END IF;
    
    -- domena -------------------------------------
    
    domena := SUBSTR(mail, find + 1);
    -- Zavinac nemoze byt na konci emailovej adresy
    IF (LENGTH(domena) IS NULL) THEN
        Raise_Application_Error (-20007, 'Znak @ sa nachadza na konci adresy');
    END IF;
    
    -- Na konci alebo na zaciatku nemoze byt specialny znak
    IF (REGEXP_LIKE(domena, '(^[!#$%&*+-/=?^_`{|}.])') OR REGEXP_LIKE(meno, '([!#$%&*+-/=?^_`{|}.]$)')) THEN
        Raise_Application_Error (-20006, 'Na zaciatku alebo na konci sa nachadza specialny znak');
    END IF;
    
    -- V domene sa nemozu nachadzat nepovolene znaky
    IF (REGEXP_LIKE(domena, '(^[a-zA-Z0-9.-]*$)')) THEN
        find := INSTR(domena, '.', -1);
    ELSE
        Raise_Application_Error (-20002, 'Nepovolene znaky v domene v emailovej adrese');
    END IF;

    IF (find = 0) THEN
        Raise_Application_Error (-20008, 'Chybajuca bodka v domene adresy');
    ELSE
        -- Osetrenie, ci ma top-level domain 2 alebo 3 pismena
        IF (LENGTH(SUBSTR(domena, find + 1)) != 2 AND LENGTH(SUBSTR(domena, find + 1)) != 3) THEN
            Raise_Application_Error (-20009, 'Nespravny top-level domain');
        END IF;
    END IF;
END;
/

-- Demonstracia triggeru kontrola_emailovej_adresy_trigger
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Jozef', 'Ondria', 'joze@f507@gmail.com', '+421950784539', 'Mladý a skúsený vodiè.', '1','1','0','1');

-----------------------------
--    NAPLNENIE TABULIEK   --
-----------------------------

INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Jozef', 'Ondria', 'jozef507@gmail.com', '+421950784539', 'Mladý a skúsený vodiè.', '1','1','0','1');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Ján', 'Folenta', 'xfolent@gmail.com', '+421950785739', 'Nový a neskúsený vodiè s dvojroènou praxou.', '1','1', '0','5');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Gregor', 'Fábry', 'xfabry@gmail.com', '+421950787779', 'Pohodovy spolucestujúci, ktorý miluje spolujazdy.', '0','0','0','0');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Marián', 'Kováè', 'kovac253@zoznam.sk', '+421906485712', '1','0','1','0');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Zuzana', 'Nováková', 'zuza555@gmail.com', '+421555498997', 'Zhovorèivá a priate¾ská mladá študentka.', '1','0','0','0');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Martin', 'Navrátil', 'm.navratil@gmail.com', '+420133624100', 'Veselej, se zmyslem pro humor.', '1','1','1','0');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Michal', 'Šastný', 'happymike@centrum.sk', '+421615438642', 'Skúsený šofér s 20-roènou praxou.', '0','0','1','17');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Marek', 'Tichý', 'marek.tichy@azet.sk', '+421999222103', 'Som tichý introvert a v aute rád èítam.', '0','1','1','0');
INSERT INTO Uzivatel (Meno, Priezvisko, Email, Telefon, Popis, MaRadHudbu, VadiMuFajcenie, VadiaMuZvirata, PocetPonukSpolujazd) 
    VALUES ('Petra', 'Malá', 'p.small@gmail.com', '+421879642183', 'Atraktívna nezadaná mladá sleèna, ktorá ale vie šoférova.', '1','1','0','3');

INSERT INTO AutoT (Znacka, ModelAuta, Farba, ID_Uzivatel) VALUES ('Škoda', 'Octavia', 'Èierna', '1');
INSERT INTO AutoT (Znacka, ModelAuta, Farba, ID_Uzivatel) VALUES ('Ford', 'Kuga', 'Modrá', '2');
INSERT INTO AutoT (Znacka, ModelAuta, Farba, ID_Uzivatel) VALUES ('Volkswagen', 'Golf', 'Sivá', '7');
INSERT INTO AutoT (Znacka, ModelAuta, Farba, ID_Uzivatel) VALUES ('BMW', 'M5', 'Biela', '9');

INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('8.00', TO_TIMESTAMP('2018-05-24 08:30', 'YYYY-MM-DD HH24:MI'), 'Žilina, Banská Bystrica', 
            'cca 1 hodina', '1 stredne ve¾ký alebo malý kufor, prípadne stredne ve¾ká alebo malá cestovná taška', 
            '3', '1', '1');   
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('6.50', TO_TIMESTAMP('2018-12-22 10:45', 'YYYY-MM-DD HH24:MI'), 'Prešov', 'Žiadna', 'Neobmedzená', '2', '2', '2');
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('8.50', TO_TIMESTAMP('2018-09-15 10:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'Je povolený iba 1 kus batožiny, jej ve¾kos je neobmedzená', 
            '2', '3', '7');
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('10.00', TO_TIMESTAMP('2018-12-22 10:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'Žiadna', 'Neobmedzená', '1', '4', '9');
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('9.00', TO_TIMESTAMP('2018-05-28 08:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'cca 1 hodina', '1 malý kufor, prípadne malá cestovná taška', 
    '2', '1', '1'); 
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('8.00', TO_TIMESTAMP('2019-08-28 10:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'cca 1 hodina', '1 malý kufor, prípadne malá cestovná taška', 
    '2', '3', '7');
INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('9.00', TO_TIMESTAMP('2019-02-08 08:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'Žiadna', 'Neobmedzená', 
    '2', '1', '1');
    

INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('1', '1', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('1', '4', 'Brno', 'Banská Bystrica');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('2', '2', 'Bratislava', 'Humenné');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('2', '3', 'Bratislava', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('3', '7', 'Košice', 'Brno');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('3', '5', 'Košice', 'Brno');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('4', '9', 'Praha', 'Bratislava');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('4', '6', 'Praha', 'Bratislava');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('5', '1', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('5', '6', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('5', '8', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('6', '7', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('6', '4', 'Brno', 'Prešov');
INSERT INTO NaTrase (ID_Spolujazda, ID_Uzivatel, OdMiesta, NaMiesto) VALUES ('7', '1', 'Prešov', 'Brno');
    
INSERT INTO HodnotenieSpolujazdca (PopisHodnotenia, JeDochvilny, JePriatelsky, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Príjemný mladý chalan, nemal som s ním žiadny problém', '1', '1', '4', '1');
INSERT INTO HodnotenieSpolujazdca (PopisHodnotenia, JeDochvilny, JePriatelsky, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Meškal približne pol hodiny a navyše bol arogantný...', '0', '0', '3', '2');
INSERT INTO HodnotenieSpolujazdca (PopisHodnotenia, JeDochvilny, JePriatelsky, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Veselý èlovek, poèas cesty sme zažili ve¾a zábavy', '1', '1', '6', '9');

INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Šofér išiel príliš rýchlo a nebezpeène a èasto nedodržoval maximálnu povolenú rýchlos.', '3', '1', '4');
INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Je vidie, že šofér nemá ve¾a odjazdených kilometrov, ale celkovo som bol spokojný.', '4', '2', '3');
INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Špièkový šofér, nemala som voèi nemu najmenšiu výhradu.', '5', '7', '5');
INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Kvalitný skúsený šofér.', '5', '1', '6');
INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Nemám žiadne výhrady.', '5', '1', '8');
INSERT INTO HodnotenieSofera (PopisHodnotenia, PocetHviezdiciek, ID_UzivatelHodnoteny, ID_UzivatelHodnotitel)
    VALUES ('Super.', '5', '7', '4');

INSERT INTO Vylet (POPISPROGRAMU, NAKLADYNACESTOVNE, NAKLADYNAOSTATNE, NAROKYNAVYBAVENIE, ZACIATOKVYLETU, NASTUPNEMIESTO, KONIECVYLETU,
    VYSTUPNEMIESTO, ID_AUTO, ID_UZIVATEL) VALUES ('Cesty Èeskoslovenskom', '25.00', 
    'Náklady na ubytovanie vo výške cca 25 eur.', 'Niesu požadované žiadne nároky na vybavenie',
    TO_TIMESTAMP('2017-07-15 06:00', 'YYYY-MM-DD HH24:MI'), 'Prešov, Plzenská 1', 
    TO_TIMESTAMP('2017-07-18 06:00', 'YYYY-MM-DD HH24:MI'), 'Prešov, Hlavná 32', '1', '1');
INSERT INTO Vylet (POPISPROGRAMU, NAKLADYNACESTOVNE, NAKLADYNAOSTATNE, NAROKYNAVYBAVENIE, ZACIATOKVYLETU, NASTUPNEMIESTO, KONIECVYLETU,
    VYSTUPNEMIESTO, ID_AUTO, ID_UZIVATEL) VALUES ('K moru autom', '50.00', 
    'Ostatné náklady vidím zatia¾ len v ubytovaní ktoré sa pod¾a narokov na byvanie budú pohybova okolo 60€.', 'Niesu požadované žiadne nároky na vybavenie',
    TO_TIMESTAMP('2018-08-05 07:30', 'YYYY-MM-DD HH24:MI'), 'Košice, Štefánikova 1', 
    TO_TIMESTAMP('2018-08-19 08:00', 'YYYY-MM-DD HH24:MI'), 'Prešov, Hlavná 10', '2', '2');

INSERT INTO ZucastnujeSaRel (ID_Uzivatel, ID_Vylet) VALUES ('1', '1');
INSERT INTO ZucastnujeSaRel (ID_Uzivatel, ID_Vylet) VALUES ('9', '1');
INSERT INTO ZucastnujeSaRel (ID_Uzivatel, ID_Vylet) VALUES ('2', '2');
INSERT INTO ZucastnujeSaRel (ID_Uzivatel, ID_Vylet) VALUES ('3', '2');
INSERT INTO ZucastnujeSaRel (ID_Uzivatel, ID_Vylet) VALUES ('6', '2');

INSERT INTO NavstevneMiesta (Mesto, CasPrichodu, CasOdchodu, MoznostiUbytovania)
    VALUES ('Bratislava', TO_TIMESTAMP('2017-07-15 14:30', 'YYYY-MM-DD HH24:MI'),  TO_TIMESTAMP('2017-07-16 06:00', 'YYYY-MM-DD HH24:MI'), 'Neobmedzené');
INSERT INTO NavstevneMiesta (Mesto, CasPrichodu, CasOdchodu, MoznostiUbytovania)
    VALUES ('Brno', TO_TIMESTAMP('2017-07-16 08:30', 'YYYY-MM-DD HH24:MI'),  TO_TIMESTAMP('2017-07-16 16:00', 'YYYY-MM-DD HH24:MI'), 'Žiadne');
INSERT INTO NavstevneMiesta (Mesto, CasPrichodu, CasOdchodu, MoznostiUbytovania)
    VALUES ('Praha', TO_TIMESTAMP('2017-07-16 19:00', 'YYYY-MM-DD HH24:MI'),  TO_TIMESTAMP('2017-07-17 22:00', 'YYYY-MM-DD HH24:MI'), 'Neobmedzené');
INSERT INTO NavstevneMiesta (Mesto, CasPrichodu, CasOdchodu, MoznostiUbytovania)
    VALUES ('Budapeš', TO_TIMESTAMP('2018-08-05 14:30', 'YYYY-MM-DD HH24:MI'),  TO_TIMESTAMP('2018-08-05 23:00', 'YYYY-MM-DD HH24:MI'), 'Žiadne');
INSERT INTO NavstevneMiesta (Mesto, CasPrichodu, CasOdchodu, MoznostiUbytovania)
    VALUES ('Dubrovnik', TO_TIMESTAMP('2018-08-06 07:30', 'YYYY-MM-DD HH24:MI'),  TO_TIMESTAMP('2018-08-18 20:30', 'YYYY-MM-DD HH24:MI'), 'Neobmedzené');
    
INSERT INTO ZahrnaRel (ID_Vylet, ID_NavstevneMiesta) VALUES ('1', '1');
INSERT INTO ZahrnaRel (ID_Vylet, ID_NavstevneMiesta) VALUES ('1', '2');
INSERT INTO ZahrnaRel (ID_Vylet, ID_NavstevneMiesta) VALUES ('1', '3');
INSERT INTO ZahrnaRel (ID_Vylet, ID_NavstevneMiesta) VALUES ('2', '4');
INSERT INTO ZahrnaRel (ID_Vylet, ID_NavstevneMiesta) VALUES ('2', '5');

INSERT INTO Prispevok (Nazov, Popis, ID_Uzivatel, ID_Vylet) VALUES ('Môj prvý výlet', 'Ako sme prešli Èesko a Slovensko.', '9', '1');
INSERT INTO Prispevok (Nazov, Popis, ID_Uzivatel, ID_Vylet) VALUES ('Víkendový oddych pri mori', 'Ako sme prežili najlepší víkend prázdnin.', '2', '2');
INSERT INTO Prispevok (Nazov, Popis, ID_Uzivatel, ID_Vylet) VALUES ('Náš výlet do Chorvátska', 'Nezabudnute¾ná cesta k moru so super ¾udmi.', '6', '2');

INSERT INTO Clanok (ID_Prispevok, Clanok) VALUES ('1', 'Vyrazili sme z Prešova v pondelok ráno. Prešli sme celé Slovensko a naša prvá dlhšia
 zastávka bola v Bratislave...');
INSERT INTO Clanok (ID_Prispevok, Clanok) VALUES ('3', 'Ešte nikdy som pri mori nebol, preto som sa na tento výlet ve¾mi tešil. A dopadol úžasne, 
spoznal som nových ¾udí...');

INSERT INTO Vlog (ID_Prispevok, Video) VALUES ('2', EMPTY_BLOB());

-----------------------------
--        SELECTY          --
-----------------------------

-- Vypise spolujazdy, ktore su vytvorene na trase Brno - Prešov
SELECT DISTINCT S.Cena, S.DatumCasOdchodu, S.Zachadzka, S.CasovaFlexibilita, S.PovolenVelkBatoziny, S.MaxPocetOsobVzadu
FROM  Spolujazda S, NaTrase N
WHERE S.ID_Spolujazda = N.ID_Spolujazda AND N.OdMiesta = 'Brno' AND N.NaMiesto = 'Prešov';

-- Vypise prispevky k vyletu s nazvom K moru autom 
SELECT P.Nazov, P.Popis
FROM Vylet V, Prispevok P
WHERE V.ID_Vylet = P.ID_Vylet AND V.PopisProgramu = 'K moru autom';

-- Vyberie spolujazdy, ktore vytvoril Jozef Ondria v roku 2018
SELECT S.Cena, S.DatumCasOdchodu, S.Zachadzka, S.CasovaFlexibilita, S.PovolenVelkBatoziny, S.MaxPocetOsobVzadu
FROM Uzivatel U, Spolujazda S, NaTrase N
WHERE U.ID_Uzivatel = N.ID_Uzivatel AND N.ID_Spolujazda = S.ID_Spolujazda AND U.Meno = 'Jozef' AND U.Priezvisko = 'Ondria' 
    AND S.DatumCasOdchodu BETWEEN TO_TIMESTAMP('2018-01-01 00:00', 'YYYY-MM-DD HH24:MI') AND TO_TIMESTAMP('2018-12-31 23:59', 'YYYY-MM-DD HH24:MI');

-- Zoradi soferov podla zarobenej sumy na spolujazdach od roku 2015
SELECT U.Meno, U.Priezvisko, SUM(S.Cena) zarobok
FROM Uzivatel U, Spolujazda S
WHERE  U.ID_Uzivatel = S.ID_Uzivatel AND S.DatumCasOdchodu > TO_TIMESTAMP('2015-01-01 00:00', 'YYYY-MM-DD HH24:MI')
GROUP BY U.Meno, U.Priezvisko
ORDER BY SUM(S.Cena) DESC;

-- Zoradi uzivatelov podla poctu spolujazd, na ktorych sa od roku 2018 zucastnili
SELECT U.Meno, U.Priezvisko, COUNT(N.ID_Uzivatel) pocet
FROM Uzivatel U, Spolujazda S, NaTrase N
WHERE  U.ID_Uzivatel = N.ID_Uzivatel AND N.ID_Spolujazda = S.ID_Spolujazda AND S.DatumCasOdchodu > TO_TIMESTAMP('2018-01-01 00:00', 'YYYY-MM-DD HH24:MI')
GROUP BY U.Meno, U.Priezvisko
ORDER BY COUNT(N.ID_Uzivatel) DESC;

-- Vyberie mena šoféreov, ktorí cestujuú z Brna do Prešova a majú iba 5-hviezdièkové hodnotenia
SELECT DISTINCT U.Meno, U.Priezvisko
FROM Uzivatel U, Spolujazda S, NaTrase N, HodnotenieSofera H
WHERE U.ID_Uzivatel = N.ID_Uzivatel AND N.ID_Spolujazda = S.ID_Spolujazda AND U.ID_Uzivatel = H.ID_UzivatelHodnoteny AND N.OdMiesta = 'Brno' AND N.NaMiesto = 'Prešov' AND H.PocetHviezdiciek = 5
    AND NOT EXISTS (SELECT *
                    FROM Spolujazda S, NaTrase N, HodnotenieSofera H 
                    WHERE U.ID_Uzivatel = N.ID_Uzivatel AND N.ID_Spolujazda = S.ID_Spolujazda AND U.ID_Uzivatel = H.ID_UzivatelHodnoteny AND N.OdMiesta = 'Brno' AND N.NaMiesto = 'Prešov' AND H.PocetHviezdiciek <> 5);
                    
-- Vyberie len spolujazdy uzivatelov, ktori v niekededy vytvorili/ponukli/uskutocnili vylet a dane spolujazdy zoradi podla datumu a casu odchodu
SELECT U.PRIEZVISKO, U.MENO, S.ID_SPOLUJAZDA, S.CENA, S.DATUMCASODCHODU, S.ZACHADZKA, S.CASOVAFLEXIBILITA, S.POVOLENVELKBATOZINY, S.MAXPOCETOSOBVZADU
FROM Spolujazda S, Uzivatel U
WHERE S.ID_Uzivatel = U.ID_Uzivatel AND S.ID_Uzivatel IN (SELECT V.ID_Uzivatel FROM Vylet V)
ORDER BY (S.DATUMCASODCHODU);


-----------------------------
--        PROCEDURY        --
-----------------------------

SET SERVEROUTPUT ON;

-- Procedura vypocita priemerne hodnotenie zadaneho sofera
CREATE OR REPLACE PROCEDURE priemerne_hodnotenie (meno IN VARCHAR, priezvisko IN VARCHAR)
    IS CURSOR hodnotenie IS SELECT * FROM Uzivatel NATURAL JOIN HodnotenieSofera WHERE ID_Uzivatel = ID_UzivatelHodnoteny;
        rating hodnotenie%ROWTYPE;
        sucet NUMBER;
        pocet NUMBER;
        pocet_1_hv NUMBER;
        pocet_2_hv NUMBER;
        pocet_3_hv NUMBER;
        pocet_4_hv NUMBER;
        pocet_5_hv NUMBER;
        priemer NUMBER;
    BEGIN
        sucet := 0;
        pocet := 0;
        pocet_1_hv := 0;
        pocet_2_hv := 0;
        pocet_3_hv := 0;
        pocet_4_hv := 0;
        pocet_5_hv := 0;
        priemer := 0;
        
        OPEN hodnotenie;
        LOOP
            FETCH hodnotenie INTO rating;
            EXIT WHEN hodnotenie%NOTFOUND;
            
            IF (rating.Meno = meno AND rating.Priezvisko = priezvisko) THEN 
                sucet := sucet + rating.PocetHviezdiciek;
                pocet := pocet + 1;
               
                IF (rating.PocetHviezdiciek = 1) THEN
                    pocet_1_hv := pocet_1_hv + 1;
                ELSIF (rating.PocetHviezdiciek = 2) THEN
                    pocet_2_hv := pocet_2_hv + 1;
                ELSIF (rating.PocetHviezdiciek = 3) THEN
                    pocet_3_hv := pocet_3_hv + 1;
                ELSIF (rating.PocetHviezdiciek = 4) THEN
                    pocet_4_hv := pocet_4_hv + 1;
                ELSIF (rating.PocetHviezdiciek = 5) THEN
                    pocet_5_hv := pocet_5_hv + 1;
                END IF;
                
            END IF;
                
        END LOOP;
        
        priemer := sucet / pocet;
        priemer := ROUND(priemer, 2);
        dbms_output.put_line(meno || ' ' || priezvisko || ' ma priemerne hodnotenie ' || priemer);
        dbms_output.put_line('1 hviezdicka   |  ' || pocet_1_hv );
        dbms_output.put_line('2 hviezdicky   |  ' || pocet_2_hv );
        dbms_output.put_line('3 hviezdicky   |  ' || pocet_3_hv );
        dbms_output.put_line('4 hviezdicky   |  ' || pocet_4_hv );
        dbms_output.put_line('5 hviezdiciek  |  ' || pocet_5_hv );
        
        CLOSE hodnotenie;
        
    EXCEPTION
        WHEN ZERO_DIVIDE THEN 
            dbms_output.put_line('Sofer/ka ' || meno || ' ' || priezvisko || ' neexistuje alebo nema ziadne hodnotenie');
        WHEN OTHERS THEN
            dbms_output.put_line('Nastala neocakvana chyba');
    END;
/

-- Procedura vyjadri precentualne zastupenie spolujazd v jednotlivych mesiacoch
CREATE OR REPLACE PROCEDURE zastupenie_spolujazd_po_mesiacoch
    IS CURSOR spolujazda_datum IS SELECT * FROM Spolujazda;
        datum spolujazda_datum%ROWTYPE;
        januar NUMBER := 0;
        februar NUMBER := 0;
        marec NUMBER := 0;
        april NUMBER := 0;
        maj NUMBER := 0;
        jun NUMBER := 0;
        jul NUMBER := 0;
        august NUMBER := 0;
        september NUMBER := 0;
        oktober NUMBER := 0;
        november NUMBER := 0;
        december NUMBER := 0;
        pocet NUMBER := 0;
    BEGIN
        OPEN spolujazda_datum;
        LOOP
            FETCH spolujazda_datum INTO datum;
            EXIT WHEN spolujazda_datum%NOTFOUND;
            
            pocet := pocet + 1;
            IF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 1) THEN 
                januar := januar + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 2) THEN 
                februar := februar + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 3) THEN 
                marec := marec + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 4) THEN 
                april := april + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 5) THEN 
                maj := maj + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 6) THEN 
                jun := jun + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 7) THEN 
                jul := jul + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 8) THEN 
                august := august + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 9) THEN 
                september := september + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 10) THEN 
                oktober := oktober + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 11) THEN 
                november := november + 1;
            ELSIF (EXTRACT (MONTH FROM datum.DatumCasOdchodu) = 12) THEN 
                december := december + 1;
            END IF;
        END LOOP;
        
        dbms_output.put_line('Januar    |  ' || ROUND((januar/pocet * 100), 2) || '%');
        dbms_output.put_line('Februar   |  ' || ROUND((februar/pocet * 100), 2) || '%' );
        dbms_output.put_line('Marec     |  ' || ROUND((marec/pocet * 100), 2) || '%' );
        dbms_output.put_line('April     |  ' || ROUND((april/pocet * 100), 2) || '%' );
        dbms_output.put_line('Maj       |  ' || ROUND((maj/pocet * 100), 2) || '%' );
        dbms_output.put_line('Jun       |  ' || ROUND((jun/pocet * 100), 2) || '%' );
        dbms_output.put_line('Jul       |  ' || ROUND((jul/pocet * 100), 2) || '%' );
        dbms_output.put_line('August    |  ' || ROUND((august/pocet * 100), 2) || '%' );
        dbms_output.put_line('September |  ' || ROUND((september/pocet * 100), 2) || '%' );
        dbms_output.put_line('Oktober   |  ' || ROUND((oktober/pocet * 100), 2) || '%' );
        dbms_output.put_line('November  |  ' || ROUND((november/pocet * 100), 2) || '%' );
        dbms_output.put_line('December  |  ' || ROUND((december/pocet * 100), 2) || '%' );
        
        CLOSE spolujazda_datum;
    END;
/

-- Demonstracia procedur
EXECUTE priemerne_hodnotenie('Jozef', 'Ondria');
EXECUTE zastupenie_spolujazd_po_mesiacoch();


-----------------------------
--       EXPLAIN PLAN      --
-----------------------------

EXPLAIN PLAN FOR
    SELECT Meno, Priezvisko, COUNT(ID_Uzivatel) pocet
    FROM Uzivatel NATURAL JOIN Spolujazda
    GROUP BY Meno, Priezvisko;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.display);

CREATE INDEX index_spolujazda ON Spolujazda(ID_Uzivatel);

EXPLAIN PLAN FOR
    SELECT Meno, Priezvisko, COUNT(ID_Uzivatel) pocet
    FROM Uzivatel NATURAL JOIN Spolujazda
    GROUP BY Meno, Priezvisko;
SELECT plan_table_output FROM TABLE(DBMS_XPLAN.display);


-----------------------------
--     PRISTUPOVE PRAVA    --
-----------------------------


GRANT ALL ON Uzivatel TO xondri05;
GRANT ALL ON AutoT TO xondri05;
GRANT ALL ON Spolujazda TO xondri05;
GRANT ALL ON NaTrase TO xondri05;
GRANT ALL ON HodnotenieSpolujazdca TO xondri05;
GRANT ALL ON HodnotenieSofera TO xondri05;
GRANT ALL ON Vylet TO xondri05;
GRANT ALL ON ZucastnujeSaRel TO xondri05;
GRANT ALL ON NavstevneMiesta TO xondri05;
GRANT ALL ON ZahrnaRel TO xondri05;
GRANT ALL ON Prispevok TO xondri05;
GRANT ALL ON Clanok TO xondri05;
GRANT ALL ON Vlog TO xondri05;

GRANT EXECUTE ON priemerne_hodnotenie TO xondri05;
GRANT EXECUTE ON zastupenie_spolujazd_po_mesiacoch TO xondri05;

-----------------------------
-- MATERIALIZOVANY POHLAD  --
-----------------------------

DROP MATERIALIZED VIEW SpolujazdaView;

CREATE MATERIALIZED VIEW LOG ON Spolujazda WITH PRIMARY KEY, ROWID(Cena) INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW SpolujazdaView
CACHE
BUILD IMMEDIATE
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS SELECT Cena, COUNT(Cena) as pocet_spolujazd
FROM Spolujazda
GROUP BY Cena;

GRANT ALL ON SpolujazdaView TO xondri05;

-- Demonstracia materializovaneho pohladu
SELECT * FROM SpolujazdaView;

INSERT INTO Spolujazda (Cena, DatumCasOdchodu, Zachadzka, CasovaFlexibilita, PovolenVelkBatoziny, MaxPocetOsobVzadu, ID_Auto, ID_Uzivatel)
    VALUES ('11.50', TO_TIMESTAMP('2019-04-20 08:45', 'YYYY-MM-DD HH24:MI'), 'Nikde', 'Žiadna', 'Neobmedzená', 
    '2', '2', '2');
    
COMMIT;

SELECT * FROM SpolujazdaView;

