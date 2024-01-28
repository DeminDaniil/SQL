-- Оператор Where --
select *
from employee_salary;


select *
from employee_salary
where salary >= 50000
;

select *
from employee_demographics
where birth_date > '1985-01-01'
;

-- And Or Not -- Логические операторы
select *
from employee_demographics
where birth_date > '1985-01-01'
or not gender = 'male'
;

select *
from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 55
;

-- Оператор Like --
-- % и _
select *
from employee_demographics
where first_name like 'a%'
;

select *
from employee_demographics
where birth_date like '1989%'
;
