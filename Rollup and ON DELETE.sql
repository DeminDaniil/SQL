-- ROLLUP --
-- Показывает итоговую сумму --
select *
from transactions;

select sum(amount), order_date
from transactions
group by order_date with rollup;

select count(amount), order_date
from transactions
group by order_date with rollup;

-- Количество заказов для каждого покупателя
select count(transaction_id) as '# of orders', customer_id
from transactions
group by customer_id with rollup;

-- Почасовая оплата каждого сотрудника и итоговая сумма в час --
select sum(hourly_pay) as 'hourly pay', employee_id
from employees
group by employee_id with rollup;

-- ON DELETE SET NULL = Когда значение внешнего ключа удалено заменяет на Null
-- ON DELETE CASCADE  = Когда значение внешнего ключа удалено, удаляет всю строку

alter table transactions drop FOREIGN KEY fk_customer_id;

alter table transactions
add CONSTRAINT fk_customer_id
foreign key(customer_id) references customers(customer_id)
on delete set null;

delete from customers
where customer_id = 1;

select * 
from transactions;

insert into customers
values(4, 'Poppy', 'Puff', 'PPuff@gmail.com');

alter table transactions 
drop FOREIGN KEY fK_customer_id;

alter table transactions
add CONSTRAINT fk_transaction_id
foreign key(customer_id) references customers(customer_id)
on delete cascade;

update transactions
set customer_id = 1
where transaction_id = 4;

delete from customers 
where customer_id = 1;

select * from transactions;