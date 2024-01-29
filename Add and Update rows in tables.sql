-- Добавление строк в таблицу --
insert into employees
values  (2, 'Squidward', 'Tentacles', 15.00, '2023-01-03'),
		(3, 'Spongebob', 'Squarepants', 12.50, '2023-01-04'),
        (4, 'Patrick', 'Star', 12.50, '2023-01-05'),
        (5, 'Sandy', 'Cheeks', 17.25, '2023-01-06')
        ;

select *
from employees;

-- Добавить неполную строку --
insert into employees(employee_id, first_name, last_name)
values (6, 'Sheldon', 'Plankton');

select * 
from employees
;

-- установить значение --
UPDATE employees
SET hourly_pay = 10.50,
	hire_date = '2023-01-07'
WHERE employee_id = 6
;

select * 
from employees;
