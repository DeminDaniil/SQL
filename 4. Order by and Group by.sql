select gender
from employee_demographics
group by gender
;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender
;


-- Order by --
select *
from employee_demographics
order by gender, age
;