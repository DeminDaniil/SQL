-- Функции --
select count(amount) as "today's transactions",
		min(amount) as minimum,
        max(amount) as maximum,
        avg(amount) as average,
        sum(amount) as sum
from transactions;

-- Объединение --
select concat(first_name, ' ', last_name) as full_name
from employees;

-- Добавление нового столбца --
alter table employees
add column job VARCHAR(25) after hourly_pay;

update employees
set job = 'janitor'
where employee_id = 6;

select *
from employees;

-- Логические операторы AND OR NOT -- 

select * 
from employees
where hire_date < '2023-01-5' and job = 'cook';

select *
from employees
where job = 'cook' or job = 'cashier';

select *
from employees
where not job = 'manager' and not job = 'asst. manager';

-- Оператор BETWEEN -- 
select *
from employees
where hire_date between '2023-01-04' and '2023-01-07';

-- Оператор IN --
select *
from employees
where job in ('cook', 'cashier', 'janitor');

-- % _ --
select * 
from employees
where first_name like 's%';

select * 
from employees
where first_name like 'sp%';

select * 
from employees
where job like '_ook';