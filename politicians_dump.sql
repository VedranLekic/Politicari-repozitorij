BEGIN TRANSACTION;
CREATE TABLE politicians (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    birth_year INTEGER NOT NULL,
    country TEXT NOT NULL,
    current_office TEXT,
    is_active INTEGER DEFAULT 1,
    education_level TEXT,
    official_website TEXT,
    party_name TEXT,
    ideology TEXT
);
INSERT INTO "politicians" VALUES(1,'Dragos','Tudorache',1972,'Romania','Member of the European Parliament',1,'Master of Laws','https://dragostudorache.ro','Renew Europe','Pro-Europeanism / Tech Regulation');
INSERT INTO "politicians" VALUES(2,'Brando','Benifei',1986,'Italy','Member of the European Parliament',1,'Degree in Political Science','https://brandobenifei.it','Democratic Party','Social Democracy / AI Act Co-Author');
INSERT INTO "politicians" VALUES(3,'Josh','Hawley',1979,'United States','US Senator',1,'Juris Doctor (Law)','https://hawley.senate.gov','Republican Party','Conservatism / Anti-AI Liability');
INSERT INTO "politicians" VALUES(4,'Alexandra','Geese',1966,'Germany','Member of the European Parliament',1,'Master of Arts','https://alexandra-geese.de','Alliance 90/The Greens','Green Politics / Big Tech Oversight');
INSERT INTO "politicians" VALUES(5,'Chris','Murphy',1973,'United States','US Senator',1,'Juris Doctor (Law)','https://murphy.senate.gov','Democratic Party','Liberalism / AI Labor Protections');
INSERT INTO "politicians" VALUES(6,'Chloe','Swarbrick',1994,'New Zealand','Member of Parliament',1,'Bachelor of Arts & Laws','https://chloeswarbrick.co.nz','Green Party','Progressivism / Automation Policy');
INSERT INTO "politicians" VALUES(7,'Yannick','Jadot',1967,'France','Senator',1,'Master in Economics','https://yannickjadot.fr','The Ecologists','Green Politics / Copyright Enforcement');
INSERT INTO "politicians" VALUES(8,'Anna','Cavazzini',1982,'Germany','Member of the European Parliament',1,'Master of Political Science','https://annacavazzini.eu','Alliance 90/The Greens','European Federalism / Consumer Rights');
INSERT INTO "politicians" VALUES(9,'Marsha','Blackburn',1952,'United States','US Senator',1,'Bachelor of Science','https://blackburn.senate.gov','Republican Party','Conservatism / NO FAKES Act');
INSERT INTO "politicians" VALUES(10,'Paul','Tang',1962,'Netherlands','Former Member of the European Parliament',0,'Master of Economics','https://paultang.nl','Labour Party','Social Democracy / Digital Tax & Ethics');
CREATE TABLE terms_in_office (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    politician_id INTEGER NOT NULL,
    role TEXT NOT NULL,
    start_year INTEGER NOT NULL,
    end_year INTEGER,
    FOREIGN KEY (politician_id) REFERENCES politicians(id) ON DELETE CASCADE
);
INSERT INTO "terms_in_office" VALUES(1,1,'Member of the Romanian Parliament',2016,2019);
INSERT INTO "terms_in_office" VALUES(2,1,'Member of the European Parliament',2019,NULL);
INSERT INTO "terms_in_office" VALUES(3,2,'Member of the European Parliament',2014,NULL);
INSERT INTO "terms_in_office" VALUES(4,3,'Attorney General of Missouri',2017,2019);
INSERT INTO "terms_in_office" VALUES(5,3,'US Senator',2019,NULL);
INSERT INTO "terms_in_office" VALUES(6,4,'Member of the European Parliament',2019,NULL);
INSERT INTO "terms_in_office" VALUES(7,5,'US House Representative',2007,2013);
INSERT INTO "terms_in_office" VALUES(8,5,'US Senator',2013,NULL);
INSERT INTO "terms_in_office" VALUES(9,6,'Auckland City Councillor',2016,2020);
INSERT INTO "terms_in_office" VALUES(10,6,'Member of Parliament',2017,NULL);
INSERT INTO "terms_in_office" VALUES(11,7,'Member of the European Parliament',2019,2023);
INSERT INTO "terms_in_office" VALUES(12,7,'French Senator',2023,NULL);
INSERT INTO "terms_in_office" VALUES(13,8,'Member of the European Parliament',2019,NULL);
INSERT INTO "terms_in_office" VALUES(14,9,'Tennessee State Senate',1999,2003);
INSERT INTO "terms_in_office" VALUES(15,9,'US House Representative',2003,2019);
INSERT INTO "terms_in_office" VALUES(16,9,'US Senator',2019,NULL);
INSERT INTO "terms_in_office" VALUES(17,10,'Member of Dutch Parliament',2010,2019);
INSERT INTO "terms_in_office" VALUES(18,10,'Member of the European Parliament',2019,2024);
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('politicians',10);
INSERT INTO "sqlite_sequence" VALUES('terms_in_office',18);
COMMIT;
