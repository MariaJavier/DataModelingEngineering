# Employee Database: A Mystery in Two Parts

![sql.png](sql.png)

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

1. Data Modeling

2. Data Engineering

3. Data Analysis

## Instructions

#### Data Modeling

Inspect the CSVs and sketch out an ERD of the tables. Feel free to use a tool like [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

#### Data Engineering

* Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

* Import each CSV file into the corresponding SQL table.

#### Data Analysis

Once you have a complete database, do the following:

1. List the following details of each employee: employee number, last name, first name, gender, and salary.

CREATE VIEW emp_info
 AS SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
 FROM employees as e, salaries as s;

2. List employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(year FROM "hire_date") = 1986


3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

SELECT 
 d.dept_no, 
 b.dept_name, 
 d.emp_no, 
 e.last_name,
 e.first_name,
 d.from_date,
 d.to_date
FROM employees e, dept_manager d, departments b;

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT 
 e.emp_no,
 e.last_name,
 e.first_name,
 d.dept_name
FROM employees e, departments d;

5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT last_name, first_name
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

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


7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.


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


8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT 
	last_name,
	count(last_name)
FROM employees
GROUP BY
	last_name
ORDER BY last_name DESC;


## SAVE THE PGADMIN DATA AND QUERY HISTORY
in pgAdmin 4, there is an option to Save As in upper left corner of Query Tool.  There should also be a Query History tab that you can switch to for prior activity, copy it to Query Tool, and save it.
You could probably also just copy and paste out of Query History and into a text file, then save/rename with .sql extension.

## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://martin-thoma.com/configuration-files-in-python/](https://martin-thoma.com/configuration-files-in-python/) for more information.

2. Create a bar chart of average salary by title.

3. You may also include a technical report in markdown format, in which you outline the data engineering steps taken in the homework assignment.

## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* (Optional) Create a Jupyter Notebook of the bonus analysis.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.


departments
--
dept_no PK VARCHAR(10)
dept_name VARCHAR(200)

dept_emp
--
emp_no PK INT
dept_no VARCHAR(10) FK
from_date DATE
to_date DATE

dept_manager
--
dept_no  VARCHAR(10) FK - departments.dept_no
emp_no PK INT
from_date DATE
to_date DATE

employees
--
emp_no PK INT
birth_date DATE
first_name VARCHAR(100)
last_name VARCHAR(100)
gender VARCHAR(2)
hire_date DATE

salaries
--
emp_no PK INT
salary NUMERIC
from_date DATE
to_date DATE

titles
--
emp_no INT FK - employees.emp_no
title VARCHAR(100)
from_date DATE
to_date DATE