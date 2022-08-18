-- Deliverable 1

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
-- Display result
SELECT * FROM retirement_titles;


DROP TABLE unique_titles;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
    rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;
-- Display result
SELECT * FROM unique_titles;


DROP TABLE retiring_titles;
-- Use Dictinct with Orderby to remove duplicate rows
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;
-- Display result
SELECT * FROM retiring_titles;


-- Deliverable 2

DROP TABLE mentorship_eligibility;
-- Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table
SELECT DISTINCT ON (e.emp_no)
    e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
-- Retrieve the from_date and to_date columns from the Department Employee table.
    de.from_date,
    de.to_date,
-- Retrieve the title column from the Titles table.
    t.title
-- Create a new table using the INTO clause.
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (de.to_date = '9999-01-01') AND (e.birth_date >= '1965-01-01') AND (e.birth_date <= '1965-12-31')
ORDER BY e.emp_no;
-- Display result
SELECT * FROM mentorship_eligibility