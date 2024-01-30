-- Хранимая процедура Stored procedure --
-- Можно сохранить часто вызываемый запрос, чтобы не писать его каждый раз --

select distinct first_name, last_name
from transactions
inner join customers
on transactions.customer_id = customers.customer_id;

Call get_customers();

-- Временное изменение разделителя --
Delimiter $$
-- Создание процедуры --
create procedure get_customers()
begin
select *
	from customers;
end $$
Delimiter ;

call get_customers();

drop procedure get_customers;

Delimiter $$
create procedure find_customer(in id INT)
begin
	select *
    from customers
    where customer_id = id;
end $$
Delimiter ;

call find_customer(3);

drop procedure find_customer;

Delimiter $$
create procedure find_customer( in f_name VARCHAR(50),
								in l_name VARCHAR(50))
begin
	select *
    from customers
    where first_name = f_name and last_name = l_name;
end $$
Delimiter ;

call find_customer('Larry', 'Lobster');

-- Триггеры Trigger --

select * from employees;

alter table employees
add column salary decimal(10,2) after hourly_pay;
select * from employees;

SET SQL_SAFE_UPDATES = 0;

update employees
set salary = hourly_pay * 2080;
select * 
from employees;

-- Создание триггера ПРИ ОБНОВЛЕНИИ ДАННЫХ для подсчета зарплаты, рассчитываемой от почасовой зарплаты --
create trigger before_hourly_pay_update
before update on employees
for each row
set new.salary = (new.hourly_pay * 2080);

show triggers;
-- Изменим для сотрудника почасовую оплату и тем самым триггер посчитает новую зарплату --
update employees
set hourly_pay = 50
where employee_id = 1;
select *
from employees;

-- Увеличим всем сотрудникам почасовую оплату на 1 доллар --
update employees
set hourly_pay = hourly_pay + 1;
select *
from employees;

delete from employees
where employee_id = 6;
select * from employees;

-- Создание триггера ПРИ ДОБАВЛЕНИИ нового сотрудника пересчитать зарплату --
create trigger before_hourly_pay_insert
before insert on employees
for each row
set new.salary = (new.hourly_pay * 2080);

insert into employees
values(6, 'Sheldon', 'Plankton', 10, NULL, 'janitor', '2023-01-07');

select * from employees;

-- Создадим таблицу расходов по зарплатам, поставкам и налогом, но считать будем только зп--
create table expenses(
	expense_id int primary key,
    expense_name varchar(50),
    expense_total decimal(10, 2)
);
select * from expenses;

insert into expenses
values  (1, 'salaries', 0),
		(2, 'supllies', 0),
        (3, 'taxes',  0);
select * from expenses;

-- Установим в строку расходы по зарплатам сумму всех зарплат из таблицы employees/сотрудники
update expenses
set expense_total = (select sum(salary) from employees)
where expense_name = 'salaries';
select * from expenses;

-- Создание триггера ПОСЛЕ УДАЛЕНИЯ сотрудника из расходов вычитается зарплата уволенного
create trigger after_salary_delete
after delete on employees
for each row
update expenses
set expense_total = expense_total - old.salary
where expense_name = 'salaries';

delete from employees
where employee_id = 6;

select * from expenses;

-- Создание триггера ПОСЛЕ ДОБАВЛЕНИЯ нового сотрудника к расхдоам добавляется его зарплата
create trigger after_salary_insert
after insert on employees
for each row
update expenses
set expense_total = expense_total + new.salary
where expense_name = 'salaries';

insert into employees
values(6, 'Sheldon', 'Plankton', 10, Null, 'janitor', '2023-01-07');
select * from expenses;

-- Создание триггера ПОСЛЕ ОБНОВЛЕНИЯ зарплаты сотрудника высчитываем разницу и добавляем к имеющимся расходам
create trigger after_salary_update
after update on employees
for each row
update expenses
set expense_total = expense_total + (new.salary - old.salary)
where expense_name = 'salaries';

select * from expenses;

update employees
set hourly_pay = 100
where employee_id = 1;
