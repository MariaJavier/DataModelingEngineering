-- QUERY TOOL HISTORY USED IN POSTGRESQL:

-- THESE CREATE THE 6 TABLES. NOTE: Unable to designate the PRIMARY KEYS in advance as the imports would fail for the dept_emp and dept_manager. The PRIMARY KEY columns are not unique data although they should be. 

CREATE TABLE departments (
 dept_no VARCHAR(10),
 dept_name VARCHAR(200)
);

CREATE TABLE dept_emp (
	emp_no VARCHAR(8),
	dept_no VARCHAR(10),
	from_date DATE,
	to_date DATE
);

CREATE TABLE dept_manager (
	dept_no VARCHAR (10),
	emp_no VARCHAR(8),
	from_date DATE,
	to_date DATE
);

CREATE TABLE employees (
	emp_no VARCHAR(10),
	birth_date DATE,
	first_name VARCHAR (100),
	last_name VARCHAR (100),
	gender VARCHAR (2),
	hire_date DATE
);

CREATE TABLE salaries (
	emp_no VARCHAR(8),
	salary NUMERIC,
	from_date DATE,
	to_date DATE
); 

CREATE TABLE titles (
	emp_no VARCHAR(8),
	title VARCHAR(100),
	from_date DATE,
	to_date DATE
);


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
 b.dept_name, 
 d.emp_no, 
 e.last_name,
 e.first_name,
 d.from_date,
 d.to_date
FROM employees e, dept_manager d, departments b;

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

SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
(
 SELECT emp_no
 FROM dept_emp
 WHERE dept_no IN
(
   SELECT dept_no
   FROM departments 
   WHERE dept_name = 'Sales'
)
);

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp_no, last_name, first_name, d.dept_name
FROM employees e, departments d
WHERE emp_no IN
( 
  SELECT emp_no
  FROM dept_emp
  WHERE dept_no IN
  (
    SELECT dept_no
    FROM departments 
    WHERE dept_name = 'Sales'
    OR dept_name = 'Development'
)
);

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT 
	last_name,
	count(last_name)
FROM employees
GROUP BY
	last_name
ORDER BY last_name DESC;
