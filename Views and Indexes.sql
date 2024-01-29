-- Представления  Views --
select * 
from employees;

-- Создание представления --
create view employee_attendance as
select first_name, last_name
from employees;

select *
from employee_attendance
order by last_name asc;

-- Удаление представления --
drop view employee_attendancel;

-- Добавление нового столбца --
alter table customers
add column email VARCHAR(50);

update customers
set email = 'PPuff@gmail.com'
where customer_id = 4;

select *
from customers;

-- Создание представления --
create view customer_emails as
select email
from customers;

-- Добавляем нового покупателя --
insert into customers
values(5, 'Pearl', 'Krabs', 'OKrabs@gmail.com');

-- После добавления нового пользователя представление актуально --
select *
from customer_emails;


-- Индексы  INDEX --
select *
from customers;

-- Отобразить имеющиеся индексы --
-- Индекс значительно ускоряет поиск --
show indexes from customers;

create index last_name_idx
on customers(last_name);

select * 
from customers
where last_name = 'Puff';

-- Многоколоночный индекс --
create index last_name_first_name_idx
on customers(last_name, first_name);

show indexes from customers;

-- Удаление индекса --
alter table customers
drop index last_name_idx;

show indexes from customers;

select * 
from customers
where last_name = 'Puff' and first_name = 'Poppy';