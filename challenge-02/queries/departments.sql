-- Number of departments
SELECT COUNT(*) FROM public.departments;

-- Number of employees per departments
SELECT dep.name, COUNT(emp.id) as num_employees
FROM public.departments as dep
JOIN public.employees as emp
	ON dep.id = emp.department_id
GROUP BY dep.id
ORDER BY COUNT(emp.id) DESC;

-- Average salary per department with GROUP BY
SELECT dep.name, ROUND(AVG(emp.salary), 2) as avg_salary
FROM public.departments as dep
JOIN public.employees as emp
	ON dep.id = emp.department_id
GROUP BY dep.id
ORDER BY AVG(emp.salary) DESC;

-- Average salary per department with window function
SELECT
	DISTINCT dep.name,
	ROUND(AVG(emp.salary) OVER (PARTITION BY dep.id), 2) as avg_salary
FROM public.departments as dep
JOIN public.employees as emp
	ON dep.id = emp.department_ID
ORDER BY avg_salary DESC;

-- Salary breakdown per department
SELECT dep.name,
	min(emp.salary) as min_salary,
	max(emp.salary) as max_salary,
	avg(emp.salary) as avg_salary,
	stddev_samp(emp.salary) as std_salary
FROM public.departments as dep
JOIN public.employees as emp
	ON dep.id = emp.department_id
GROUP BY dep.id
ORDER BY avg(emp.salary) DESC;

-- Salary breakdown per department with window function
SELECT
	DISTINCT dep.name,
	min(emp.salary) OVER(PARTITION BY dep.id) as min_salary,
	max(emp.salary) OVER(PARTITION BY dep.id) as max_salary,
	avg(emp.salary) OVER(PARTITION BY dep.id) as avg_salary,
	stddev_samp(emp.salary) OVER(PARTITION BY dep.id) as std_salary
FROM public.departments as dep
JOIN public.employees as emp
	ON dep.id = emp.department_id
ORDER BY max_salary DESC, min_salary DESC;

-- Salary breakdown per department per hiring year
SELECT
	dep.name,
  	extract(year from emp.hire_date) as hire_year,
  	COUNT(*) as num_hires,
  	SUM(emp.salary) as total_salary
FROM public.employees as emp
JOIN public.departments as dep
	ON emp.department_id = dep.id
GROUP BY hire_year, emp.department_id, dep.name
ORDER BY emp.department_id, hire_year, total_salary DESC;