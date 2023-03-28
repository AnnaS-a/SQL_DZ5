-- Удаление БД с именем dz5, если она существует
DROP DATABASE IF EXISTS dz5;  
-- Создаем БД dz5, если она не существует
CREATE DATABASE IF NOT EXISTS dz5; 
-- Подключиться к БД 
USE dz5;

/*
1. на сайте https://www.mockaroo.com/  заполнили названия полей: id, name, cost; их типы, % заполняемости (из 1000 строк)
2. выбрать формат файла CSV -> Сгенерировать -> "Скачать данные"
3. в БД -> Tables -> пр.кн.м. Table Data Import -> Выбрать скаченный файл
*/

SELECT * FROM cars;

-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE OR REPLACE VIEW cost_less AS   -- Создаю или заменяю (REPLACE) уже существующее представление
SELECT name, cost
FROM cars
WHERE cost < 25000; 

SELECT * FROM cost_less;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 70 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW cost_less AS
SELECT
	name, cost
FROM cars
WHERE cost < 70000;

SELECT * FROM cost_less;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Форд” и “Ауди”
CREATE OR REPLACE VIEW mark AS   -- Создаю или заменяю (REPLACE) уже существующее представление
SELECT *
FROM cars
WHERE name = "Ford" OR name = "Audi"; 

SELECT * FROM mark;


/*Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
*/
CREATE TABLE schedule
(
	train_id INT,
    station VARCHAR(90),
    station_time TIME
);

INSERT schedule
VALUES
	(110, "San Francisco", "10:00:00"),
    (110, "Redwood City", "10:54:00"),
    (110, "Palo Alto", "11:02:00"),
    (110, "San Jose", "12:35:00"),
    (120, "San Francisco ", "11:00:00"),
    (120, "Palo Alto", "12:49:00"),
    (120, "San Jose", "13:30:00");

SELECT * FROM schedule;

SELECT *,
	TIMEDIFF (LEAD(station_time) OVER (PARTITION BY train_id), station_time) AS "time_to_next_station"
FROM schedule;





-- Вариант с готовой таблицей
CREATE TABLE cars1
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars1
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars1;

-- 1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
CREATE OR REPLACE VIEW cost_less1 AS   -- Создаю или заменяю (REPLACE) уже существующее представление
SELECT name, cost
FROM cars1
WHERE cost < 25000; 

SELECT * FROM cost_less1;

-- 2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
ALTER VIEW cost_less1 AS
SELECT
	name, cost
FROM cars1
WHERE cost < 30000;

SELECT * FROM cost_less1;

-- 3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW mark1 AS   -- Создаю или заменяю (REPLACE) уже существующее представление
SELECT *
FROM cars1
WHERE name = "Skoda" OR name = "Audi"; 

SELECT * FROM mark1;