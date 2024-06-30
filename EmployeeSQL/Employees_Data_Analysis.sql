-- Data Engineering
-- Create title Table
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
    title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    PRIMARY KEY (title_id)
);


-- Create department table
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL,
    dept_name VARCHAR NOT NULL,
    PRIMARY KEY (dept_no)
);


-- Create employee table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_no INTEGER NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
    hire_date VARCHAR NOT NULL,
    PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);


-- Create salaries table
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL,
    PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


-- Create department employee table
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);


-- Create department manager table
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


-- Check each database
SELECT * FROM titles;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager




-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT ep.emp_no, 
	ep.last_name, 
	ep.first_name, 
	ep.sex, 
	sa.salary
FROM employees AS ep
JOIN salaries AS sa
ON ep.emp_no=sa.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT ep.emp_no, 
	ep.first_name, 
	ep.last_name, 
	ep.hire_date
FROM employees AS ep
WHERE EXTRACT(YEAR FROM TO_DATE(ep.hire_date, 'MM/DD/YY')) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT mg.emp_no, 
	mg.dept_no, 
	dp.dept_name, 
	ep.last_name, 
	ep.first_name
FROM dept_manager AS mg
JOIN departments AS dp
ON mg.dept_no=dp.dept_no
JOIN employees AS ep
ON mg.emp_no = ep.emp_no;

-- 4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dpep.dept_no,
	ep.emp_no, 
	ep.last_name, 
	ep.first_name, 
	dp.dept_name
FROM employees AS ep
JOIN dept_emp AS dpep
ON ep.emp_no=dpep.emp_no
JOIN departments AS dp
ON dpep.dept_no=dp.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT ep.first_name, 
	ep.last_name, 
	ep.sex 
FROM employees AS ep
WHERE ep.first_name = 'Hercules'
AND ep.last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT ep.emp_no,
	ep.last_name,
	ep.first_name
FROM employees AS ep
JOIN dept_emp AS dpep
ON ep.emp_no=dpep.emp_no
JOIN departments AS dp
ON dpep.dept_no=dp.dept_no
WHERE dp.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT ep.emp_no,
	ep.last_name,
	ep.first_name,
	dp.dept_name
FROM employees AS ep
JOIN dept_emp AS dpep
ON ep.emp_no=dpep.emp_no
JOIN departments AS dp
ON dpep.dept_no=dp.dept_no
WHERE dp.dept_name IN ('Sales','Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT COUNT(ep.last_name) AS last_name_count,
	ep.last_name
FROM employees AS ep
GROUP BY ep.last_name;

