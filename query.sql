-- QUERY TOOL HISTORY USED IN POSTGRESQL:

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

CREATE VIEW emp_info
 AS SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
 FROM employees as e, salaries as s;

-- 2. List employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(year FROM "hire_date") = 1986

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT 
 d.dept_no, 
 d.dept_no, 
 d.emp_no, 
 e.last_name,
 e.first_name,
 d.from_date,
 d.to_date
FROM employees e, dept_manager d;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT 
 e.emp_no,
 e.last_name,
 e.first_name,
 d.dept_name
FROM employees e, departments d;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT last_name, first_name
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales'


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Development'
OR dp.dept_name LIKE 'Sales';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT 
	last_name,
	count(last_name)
FROM employees
GROUP BY
	last_name
ORDER BY last_name DESC;
