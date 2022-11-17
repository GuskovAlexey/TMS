
CREATE USER 'admin'@'localhost' IDENTIFIED BY '111111'; 
SELECT User, Host FROM mysql.user;
GRANT ALL ON base_1.* TO 'admin'@'localhost';
SELECT * FROM information_schema.user_privileges;

CREATE DATABASE base_1; 
USE base_1; 

CREATE TABLE table1 (
     id INT UNSIGNED AUTO_INCREMENT,
     Username VARCHAR(32) NOT NULL,
     Pass VARCHAR(32) NOT NULL,
     email VARCHAR(64) NOT NULL,
     PRIMARY KEY (id)
);

SHOW TABLES; 

INSERT INTO table1 ( Username, Pass, email ) VALUES
    ('Dremer','123456','Dremer@tut.by'),
    ('Bizon', '111111', 'bizon@ggmail.com'),
    ('Penguin','ppp2222','fila9@mail.ru'),
    ('Lespot','h1j4k32l','Lespot@gmail.com'),
    ('Kraken','passwd','horek14@mail.ru'),
    ('Branhit','hfdkk2','namemy@tut.by');


SELECT * FROM table1;

CREATE TABLE table2 (
     id INT UNSIGNED AUTO_INCREMENT,
     Name VARCHAR(32) NOT NULL,
     Surname VARCHAR(32) NOT NULL,
     email VARCHAR(64) NOT NULL,
     Age INT(64) NOT NULL,
     PRIMARY KEY (id)
);

SHOW TABLES; 

INSERT INTO table2 ( Name, Surname, email, Age ) VALUES
    ('Dima','Ivanov','Dremer@tut.by','32'),
    ('Andrey','Marshal','bizon@ggmail.com','25'),
    ('Ivan','Dorn','fila9@mail.ru','18'),
    ('Alexey','Petrov','Lespot@gmail.com','35'),
    ('Aleksandr','Sidorov','horek14@mail.ru','48'),
    ('Roman','Operov','namemy@tut.by','37');


SELECT * FROM table1;

# Сортировка

SELECT * FROM table1 ORDER BY Username;


SELECT table1.Username, table2.Age

FROM table2

INNER JOIN table1 ON table1.email=table2.email 

ORDER BY Age;


SELECT * FROM table1, table2