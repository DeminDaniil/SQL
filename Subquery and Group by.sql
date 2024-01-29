-- Подзапросы subquery --
select *
from employees;

-- Выведем среднюю почасовую оплату --
select  first_name, 
		last_name,
        hourly_pay,
        (Select avg(hourly_pay) from employees as avg_pay)
from employees;

-- Вывести тех, у кого зарплата выше среднего --
select first_name, last_name, hourly_pay
from employees
where hourly_pay > (select avg(hourly_pay) from employees)
;

select *
from transactions;

-- Вывести тех, кто никогда не оформлял заказ --
SELECT first_name, last_name
from customers
where customer_id not in 
(select distinct customer_id
from transactions
where customer_id is not null);

select *
from transactions;

alter table transactions
add column order_date DATE after customer_id;

update transactions
set order_date = '2023-01-02'
where transaction_id = 4;

-- Вывести сумму, минимальное, максимальное, среднее, количество --
--  за каждый день --
select  sum(amount),
		min(amount),
        max(amount),
        avg(amount),
        count(amount),
        order_date
from transactions
group by order_date;

-- Сколько тратил каждый клиент и сумма больше 3 долларов --
select  sum(amount), 
		transactions.customer_id, 
        customers.first_name, 
        customers.last_name
from transactions
join customers 
	on transactions.customer_id=customers.customer_id
group by customer_id
having sum(amount) > 3;

select *
from customers;

select *
from transactions
