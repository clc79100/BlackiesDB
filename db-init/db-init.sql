CREATE USER 'api-user'@'%' IDENTIFIED WITH mysql_native_password BY 'Password1';
GRANT ALL PRIVILEGES ON *.* TO 'api-user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'test-user'@'%' IDENTIFIED BY 'Password1';
GRANT ALL PRIVILEGES ON *.* TO 'api-user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE blackies;
USE blackies;
CREATE TABLE Level(
    LevelID INT NOT NULL AUTO_INCREMENT,
    Number INT NOT NULL,
    Image VARCHAR(150) NOT NULL,
    PRIMARY KEY(LevelID)
);

CREATE TABLE Autor(
    AutorID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(150) NOT NULL,
    PRIMARY KEY(AutorID)
);

CREATE TABLE Momo(
    MomoID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(150) NOT NULL,
    Image VARCHAR(200) NOT NULL,
    AutorID INT NOT NULL,
    LevelID INT NOT NULL,
    PRIMARY KEY(MomoID),
    CONSTRAINT fk_AutorID FOREIGN KEY(AutorID) REFERENCES Autor(AutorID),
    CONSTRAINT fk_LevelID FOREIGN KEY(LevelID) REFERENCES Level(LevelID)
);

INSERT INTO Level(Number, Image) 
VALUES
(1,'/assets/levels/1'),
(2,'/assets/levels/2'),
(3,'/assets/levels/3'),
(4,'/assets/levels/4'),
(5,'/assets/levels/5'),
(6,'/assets/levels/6');

INSERT INTO Autor(Name, Description)
VALUES
('Autor 1','Descripcion 1'),
('Autor 2','Descripcion 2'),
('Autor 3','Descripcion 3');

INSERT INTO Momo(Name, Description, Image, AutorID, LevelID)
VALUES
('momo1', 'Descripcion1', '/assets/momos1/', 1, 1),
('momo2', 'Descripcion2', '/assets/momos2/', 1, 1),
('momo3', 'Descripcion3', '/assets/momos3/', 1, 1),
('momo4', 'Descripcion4', '/assets/momos4/', 2, 2),
('momo5', 'Descripcion5', '/assets/momos5/', 2, 2),
('momo6', 'Descripcion6', '/assets/momos6/', 2, 2),
('momo7', 'Descripcion7', '/assets/momos7/', 3, 3),
('momo8', 'Descripcion8', '/assets/momos8/', 3, 3),
('momo9', 'Descripcion9', '/assets/momos9/', 3, 3);


CREATE VIEW vw_Momo AS 
    SELECT 
        M.MomoID,
        M.Name,
        M.Description,
        M.Image,
        A.Name AS Autor,
        A.Description AS Autor_Description,
        L.Number AS Level,
        L.Image AS Level_Image
    FROM Momo AS M
    INNER JOIN Autor AS A
        ON M.AutorID = A.AutorID
    INNER JOIN Level AS L
        ON M.LevelID = L.LevelID;

DELIMITER $$
CREATE PROCEDURE sp_FilterByLevel(IN LevelToSearch INT)
BEGIN
    SELECT 
        M.Name,
        M.Description,
        M.Image 
    FROM Momo AS M
    INNER JOIN Level AS L
        ON M.LevelID = L.LevelID
    WHERE L.Number = LevelToSearch;
END
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_FilterByAutor(IN AutorToSearch VARCHAR(50))
BEGIN
    SELECT 
        M.Name,
        M.Description,
        M.Image 
    FROM Momo AS M
    INNER JOIN Autor AS A
        ON M.AutorID = A.AutorID
    WHERE A.Name = AutorToSearch;
END
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_GetMomo(IN IDToSearch INT)
BEGIN
    SELECT * FROM vw_Momo WHERE vw_Momo.MomoID = IDToSearch;
END
DELIMITER ;