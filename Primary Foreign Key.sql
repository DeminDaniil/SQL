-- Создание таблицы с первичным ключом --
create table transactions(
transaction_id INT PRIMARY KEY,
amount DECIMAL(5,2)
);

insert into transactions
values (1003, 4.99);

select *
from transactions
;

-- Удаление таблицы --
drop table transactions;

-- Создание таблицы с автоматическим увеличением инкремента и внешнего ключа --

create table transactions (
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
	amount DECIMAL(5,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
    );

-- Автоинкремент начинается с 1000 --
alter table transactions
AUTO_INCREMENT = 1000;

-- Удаление внешнего ключа --
alter table transactions
drop FOREIGN KEY transactions_ibfk_1;

-- Установка внешнего ключа с другим именем в созданную таблицу --
alter table transactions
add CONSTRAINT fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

select *
from transactions;

insert into transactions(amount, customer_id)
values  (4.99, 3),
		(2.89, 2),
        (3.38, 3),
        (4.99, 1);

select *  
from transactions;

-- Создание таблицы клиенты --
create table customers(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
    );

select *
from customers;

insert into customers (first_name, last_name)
values  ('Fred', 'Fish'),
		('Larry', 'Lobster'),
        ('Buble', 'Bass');
        
select * 
from customers;

