-- Create table departments
create table departments(
dept_no varchar (30),
dept_name varchar (30),
primary key(dept_no)
);

-- Create table titles
create table titles(
title_id varchar(30),
title varchar (30),
primary key (title_id)
);

-- Create table employees
create table employees(
emp_no integer not null,
emp_title_id varchar (30),
birth_date date,
first_name varchar (30),
last_name varchar (30),
sex varchar (5),
hire_date date,
primary key (emp_no),
foreign key (emp_title_id) references
	titles(title_id)
);

-- Create table dept_emp
create table dept_emp (
emp_no integer not null,
foreign key (emp_no) references 
	employees(emp_no),
dept_no varchar (30),
foreign key (dept_no) references
	departments (dept_no),
primary key (emp_no, dept_no)
);

-- Create table dept_manager
create table dept_manager(
dept_no varchar (30),
foreign key (dept_no) references
	departments (dept_no),
emp_no integer not null primary key,
foreign key (emp_no) references 
	employees(emp_no)
);

-- Create table salaries
create table salaries(
emp_no integer not null primary key,
salary integer not null,
foreign key (emp_no) references 
	employees(emp_no)
);

-- List the employee number, last name, first name, sex, and salary of each employee.
select emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary as employee_salary
from employees emp
inner join salaries sal
on emp.emp_no = sal.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where hire_date between '1986-01-01' and '1986-12-31'

-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
select dep.dept_name, man.dept_no, emp.emp_no, emp.last_name, emp.first_name
from departments dep
inner join dept_manager man
on dep.dept_no = man.dept_no
inner join employees emp
on man.emp_no = emp.emp_no
;

-- List the department number for each employee along with that 
-- employee’s employee number, last name, first name, and department name.
select demp.emp_no, emp.last_name, emp.first_name, dep.dept_no, dep.dept_name
from employees emp
inner join dept_emp demp
on demp.emp_no = emp.emp_no
inner join departments dep
on dep.dept_no = demp.dept_no
order by demp.emp_no
;

-- List first name, last name, and sex of each employee whose 
-- first name is Hercules and whose last name begins with the letter B.
select emp.first_name, emp.last_name, emp.sex
from employees emp
where first_name = 'Hercules' and last_name like 'B%'
;

-- List each employee in the Sales department, 
-- including their employee number, last name, and first name.
select emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
from employees emp
inner join dept_emp demp
on emp.emp_no = demp.emp_no
inner join departments dep
on demp.dept_no = dep.dept_no
where dept_name = 'Sales'
;

-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select emp.emp_no, emp.first_name, emp.last_name, dep.dept_name
from employees emp
inner join dept_emp demp
on emp.emp_no = demp.emp_no
inner join departments dep
on demp.dept_no = dep.dept_no
where dept_name in ('Sales', 'Development') 
;

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
select last_name, count(*) as frequency_count
from employees
group by last_name
order by frequency_count desc
;


	