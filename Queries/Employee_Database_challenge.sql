-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no,
    e.first_name,
    e.last_name
FROM employees AS e;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT t.title,
    t.from_date,
    t.to_date
FROM titles AS t;

-- Drop retirement_titles before creation
DROP TABLE retirement_titles;

-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT e.emp_no,
    e.first_name,
    e.last_name,
-- Retrieve the title, from_date, and to_date columns from the Titles table.
    t.title,
    t.from_date,
    t.to_date
-- Create a new table using the INTO clause.
INTO retirement_titles
FROM employees AS e
-- Join both tables on the primary key.
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- Then, order by the employee number.
ORDER BY e.emp_no;

DROP TABLE current_employees;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO current_employees
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Write another query to retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ce.emp_no), ce.title
INTO retiring_titles
FROM current_employees AS ce
GROUP BY ce.title
ORDER BY ce.count DESC;