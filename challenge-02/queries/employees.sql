-- Average salary for all employees
SELECT AVG(salary) as avg_salary
FROM public.employees;

-- Highest paid employee per department
SELECT 
	dep.name,
	(first_name || ' ' || last_name) as employee,
	emp.salary,
	rank() OVER(PARTITION BY dep.id ORDER BY emp.salary DESC),
FROM public.employees as emp
JOIN public.departments as dep
	ON emp.department_id = dep.id;

-- Standard deviation of salary per department
SELECT 
	dep.name,
	(first_name || ' ' || last_name) as employee,
	emp.salary,
	rank() OVER(PARTITION BY dep.id ORDER BY emp.salary DESC),
	round(stddev_samp(emp.salary) OVER(PARTITION BY dep.id ORDER BY emp.salary DESC rows between unbounded preceding and unbounded following), 2) as std_salary
FROM public.employees as emp
JOIN public.departments as dep
	ON emp.department_id = dep.id;

-- Top 10 highest paid employees
SELECT 
  (first_name || ' ' || last_name) as employee,
  salary
FROM public.employees
ORDER BY salary DESC
LIMIT 10;

-- Find the longest tenured employee
SELECT *,
	age(current_date, hire_date)
FROM public.employees
ORDER BY age(current_date, hire_date) DESC;

-- Extract month and year from hire date
SELECT *,
	extract(month from hire_date) as hire_month,
	extract(year from hire_date) as hire_year
FROM public.employees;

-- Most people hired in a single month
SELECT
	extract(month from hire_date) as hire_month,
	extract(year from hire_date) as hire_year,
	COUNT(*) num_hires
FROM public.employees
GROUP BY hire_month, hire_year
ORDER BY COUNT(*) DESC;

-- Most people hired in a year
SELECT
	extract(year from hire_date) as hire_year,
	COUNT(*) num_hires
FROM public.employees
GROUP BY hire_year
ORDER BY COUNT(*) DESC;

-- What hiring year saw the largest number of salaries
SELECT
  extract(year from hire_date) as hire_year,
  COUNT(*) as num_hires,
  SUM(salary) as total_salary
FROM public.employees
GROUP BY hire_year
ORDER BY total_salary DESC;