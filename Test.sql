CREATE DATABASE Zbirka

CREATE TABLE Zbirka (
    medij_id INT PRIMARY KEY,
    naziv VARCHAR(255),
    tip VARCHAR(10) CHECK (tip IN ('CD', 'DVD')),
    izvodac VARCHAR(100),
    godina_izdanja INT,
    zanr VARCHAR(50)
);


INSERT INTO Zbirka (medij_id, naziv, tip, izvodac, godina_izdanja, zanr) VALUES
    (1, 'Album 1', 'CD', 'Izvoðaè 1', 2020, 'Rock'),
    (2, 'Film 1', 'DVD', NULL, 2018, 'Drama'),
    (3, 'Album 2', 'CD', 'Izvoðaè 2', 2019, 'Pop'),
    (4, 'Film 2', 'DVD', NULL, 2022, 'Action'),
    (5, 'Album 3', 'CD', NULL, 2022, 'Jazz'),
	(6, 'Film 3', 'DVD', NULL, 2022, 'Comedy');

CREATE TABLE Prijatelji (
    prijatelj_id INT PRIMARY KEY,
    ime VARCHAR(50),
    prezime VARCHAR(50)
);


INSERT INTO Prijatelji (prijatelj_id, ime, prezime) VALUES
    (1, 'Roko', 'Nakiæ'),
    (2, 'Rafael', 'Kaèinari'),
    (3, 'Mate', 'Kardum'),
    (4, 'Darian', 'Zvelf'),
    (5, 'Luka', 'Predovan'),
    (6, 'Andrija', 'Lonèar');


CREATE TABLE Posudbe (
    posudba_id INT PRIMARY KEY,
    medij_id INT,
    prijatelj_id INT,
    datum_posudbe DATE,
    datum_vracanja DATE,
    FOREIGN KEY (medij_id) REFERENCES Zbirka(medij_id),
    FOREIGN KEY (prijatelj_id) REFERENCES Prijatelji(prijatelj_id)
);

INSERT INTO Posudbe (posudba_id, medij_id, prijatelj_id, datum_posudbe, datum_vracanja) VALUES
    (1, 1, 1, '2024-02-08', NULL),
    (2, 2, 2, '2024-01-15', '2024-02-01'), 
    (3, 1, 3, '2024-02-01', '2024-02-15'), 
    (4, 2, 4, '2024-01-20', NULL), 
    (5, 1, 5, '2024-01-10', NULL), 
    (6, 2, 6, '2024-02-05', NULL); 
 

SELECT 
    Prijatelji.ime,
    Prijatelji.prezime,
    Posudbe.medij_id,
    Zbirka.naziv AS naziv_medija,
    Posudbe.datum_posudbe,
    Posudbe.datum_vracanja,
    DATEDIFF(DAY, Posudbe.datum_posudbe, GETDATE()) AS broj_dana_posudbe
FROM 
    Prijatelji
JOIN (
    SELECT 
        medij_id,
        MAX(posudba_id) AS zadnja_posudba
        FROM 
        Posudbe
        GROUP BY 
        medij_id
) AS NajnovijePosudbe ON Prijatelji.prijatelj_id = (SELECT prijatelj_id FROM Posudbe WHERE Posudbe.posudba_id = NajnovijePosudbe.zadnja_posudba)
JOIN 
    Posudbe ON NajnovijePosudbe.zadnja_posudba = Posudbe.posudba_id
JOIN 
    Zbirka ON Posudbe.medij_id = Zbirka.medij_id
WHERE 
    Posudbe.datum_vracanja IS NULL;

UPDATE Posudbe
SET datum_vracanja = GETDATE()
FROM Posudbe
JOIN Prijatelji ON Posudbe.prijatelj_id = Prijatelji.prijatelj_id
WHERE Posudbe.datum_vracanja IS NULL;



