departments
--
dept_no PK VARCHAR(10)
dept_name VARCHAR(200) FK - dept_manager.dept_no

dept_emp
--
emp_no PK VARCHAR(6) FK - employees.emp_no
dept_no PK VARCHAR(10) FK - departments.dept_no
from_date DATE
to_date DATE

dept_manager
--
dept_no PK VARCHAR(10) FK - departments.dept_no
emp_no VARCHAR(6) FK - employees.emp_no
from_date DATE
to_date DATE

employees
--
emp_no PK VARCHAR(6)
birth_date DATE
first_name VARCHAR(100)
last_name VARCHAR(100)
gender VARCHAR(2)
hire_date DATE

salaries
--
emp_no PK VARCHAR(6) FK - employees.emp_no
salary NUMERIC 
from_date DATE
to_date DATE

titles
--
emp_no VARCHAR(6) FK - employees.emp_no
title VARCHAR(100)
from_date DATE
to_date DATE
