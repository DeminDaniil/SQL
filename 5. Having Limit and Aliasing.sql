-- Having vs Where

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING avg(age) > 40
;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000
;

-- Limit & Aliasing --
select * 
from employee_demographics
order by age desc
limit 2, 1
;

-- Aliasing --
select gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40
;

