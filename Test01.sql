CREATE TABLE CD_DVD (
    ID INT PRIMARY KEY,
    Naziv VARCHAR(100),
    Žanr VARCHAR(50)
);

CREATE TABLE Ekipa (
    ID INT PRIMARY KEY,
    Ime VARCHAR(50),
    Prezime VARCHAR(50)
);

CREATE TABLE Posudba (
    ID INT PRIMARY KEY,
    ID_CD_DVD INT,
    ID_Prijatelj INT,
    Datum_Posudbe DATE,
    Datum_Vracanja DATE,
    FOREIGN KEY (ID_CD_DVD) REFERENCES CD_DVD(ID),
    FOREIGN KEY (ID_Prijatelj) REFERENCES Ekipa(ID)
);

INSERT INTO Ekipa (ID, Ime, Prezime) VALUES
(1, 'Roko', 'Nakiæ'),
(2, 'Andrija', 'Lonèar'),
(3, 'Rafael', 'Kaèinari'),
(4, 'Mate', 'Kardum'),
(5, 'Luka', 'Predovan'),
(6, 'Mateo', 'Arula'),
(7, 'Frane', 'Dujiæ'),
(8, 'Alan', 'Baèiæ');


INSERT INTO CD_DVD (ID, Naziv, Žanr) VALUES
(1, 'Film1', 'Drama'),
(2, 'Film2', 'Akcija'),
(3, 'Film3', 'Komedija'),
(4, 'Film4', 'SF'),
(5, 'Film5', 'Horor'),
(6, 'Film6', 'Triler'),
(7, 'Film7', 'Animirani'),
(8, 'Film8', 'Romantièni'),
(9, 'CD1', 'Rock'),
(10, 'CD2', 'Jazz'),
(11, 'CD3', 'Soul'),
(12, 'CD4', 'Elektronska'),
(13, 'CD5', 'Rock'),
(14, 'CD6', 'Jazz'),
(15, 'CD7', 'Soul'),
(16, 'CD8', 'Elektronska');


INSERT INTO Posudba (ID, ID_CD_DVD, ID_Prijatelj, Datum_Posudbe, Datum_Vracanja) VALUES
(1, 1, 1, '2024-03-15', NULL),
(2, 9, 2, '2024-03-16', NULL),
(3, 2, 3, '2024-03-17', NULL);


SELECT 
    Ekipa.Ime, 
    Ekipa.Prezime, 
    Posudba.Datum_Posudbe, 
    DATEDIFF(day, Posudba.Datum_Posudbe, GETDATE()) AS 'Broj dana posudbe'
FROM 
    Ekipa
INNER JOIN 
    Posudba ON Ekipa.ID = Posudba.ID_Prijatelj
WHERE 
    Posudba.Datum_Vracanja IS NULL;


UPDATE Posudba
SET Datum_Vracanja = GETDATE()
WHERE Datum_Vracanja IS NULL;

