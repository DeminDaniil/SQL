-- create database myDB --

-- Только для чтения alter database myDB read only = 1; --

-- Создание таблицы -- 
create table employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5,2),
    hire_date DATE
);

select *
from employees
;

-- Переименовать таблицу Rename table employees to workers --
-- Удалить таблицу Drop employees --

-- Добавить в таблицу --
alter table employees
add phone_number VARCHAR(15);

-- Переименовать столбец -- 
alter table employees
rename column phone_number to email
;

-- Изменить тип или размер колонки --
alter table employees
modify column email VARCHAR(100)
;

-- Удалить колонку -- 
alter table employees
drop column email;

select * 
from employees