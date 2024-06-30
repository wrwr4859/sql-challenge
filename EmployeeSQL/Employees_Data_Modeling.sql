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