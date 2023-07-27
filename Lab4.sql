/*1.Display (Using Union Function)
a.The name and the gender of the dependence that's gender is Female and depending on 
Female Employee.
b. And the male dependence that depends on Male Employee.*/
select fname , lname from Employee,Dependent 
where Employee.Sex ='F' and Dependent.Sex = 'F'
Union
select fname , lname from Employee, Dependent
where Employee.Sex ='M' and Dependent.Sex = 'M'

/*2.For each project, list the project name and the total hours per week 
 (for all employees) spent on that project.*/
select distinct pname , sum(hours) from Project , Works_for 
where Project.Pnumber=Works_for.Pno
group by Pname

/* 3.Display the data of the department which has the smallest 
employee ID over all employees' ID.*/
select * from Departments 
where Departments.MGRSSN=(select Min(Departments.MGRSSN) from Departments)

/*4.For each department, retrieve the department name and the maximum,
minimum and average salary of its employees. */
select dname , max(salary) 'max' ,min(salary) 'min', avg(salary) 'avg'
from Departments,Employee
where Departments.Dnum = Employee.Dno
group by Dname

/*5.List the full name of all managers who have no dependents.*/
select fname + ' ' + lname 'Full_name' from Employee
except
select fname + ' ' + lname 'Full_name' from Employee,Departments,Dependent
where Employee.SSN = Departments.MGRSSN and Dependent.ESSN=Employee.SSN


/*6.For each department-- if its average salary is less than the average 
salary of all employees-- display its number, name and number of its employees.*/ 
select distinct Fname,Salary,ssn,Dno,Dname
from  Employee,Departments 
where Employee.Dno = Departments.Dnum and Salary<(select avg(Salary) from Employee)
group by Dname,Fname,Salary,ssn,Dno
-----------------------------------------------------------------------------------
select Fname,Lname,dno,Salary from Employee 
where Salary <(select avg(Salary) from Employee) 
group by Fname,Lname,dno,Salary
-----------------------------------------------------------------------------------
/*7.Retrieve a list of employees names and the projects names they are working on
ordered by department number and within each department, ordered alphabetically by
last name, first name.*/
select distinct fname,Lname,pname,Dno from Project,Employee 
where Project.Dnum=Employee.Dno and Fname is not null
order by Fname,Lname,Dno 

/*8.Try to get the max 2 salaries using subquery  */
select max (salary) from Employee where Salary <> (select max (salary) from Employee)
union
select max(salary) from Employee 

/*9.Get the full name of employees that is similar to any dependent name*/
select fname + ' '+lname from Employee where
fname+lname in (select fname+lname from Dependent )

/*10.Display the employee number and name if at least one of them have dependents 
(use exists keyword) */
Select fname,Lname,ssn from employee where EXISTS 
(select * from Dependent where
Dependent.ESSN =Employee.SSN AND
Dependent.Dependent_name = Fname + ' ' + Lname)

------------------------------------------------------------------------------------

/*11.In the department table insert new department called "DEPT IT" , with id 100,
employee with SSN = 112233 as a manager for this department. 
The start date for this manager is '1-11-2006'*/
insert into Employee(SSN)  values(112233)
INSERT INTO Departments(Dname,MGRSSN,Dnum,[MGRStart Date])
values('DEPT IT',112233,100,1-11-2006) 

/*12. a.	First try to update her record in the department table
b.	Update your record to be department 20 manager.
c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
*/
update Departments 
set Dnum=100, MGRSSN=968574 where MGRSSN =112233

Update Departments
set Dnum=20 , MGRSSN = 102672 where Dnum = 20

update Employee
set Superssn = 102672 where SSN = 102660

/*(Check if Mr. Kamel has dependents, works as a department manager, 
supervises any employees or works in any projects and handle these cases).*/
select * from Employee where SSN = 223344
update Employee set Superssn = null where SSN = 223344
update Employee set Superssn = null where Superssn = 223344
-------------------
select * from Departments where MGRSSN = 223344
update Departments set MGRSSN = null where Dnum=10
update Employee set Dno = null where SSN = 223344
-------------------
select * from Dependent where ESSN = 223344
delete from Dependent where ESSN = 223344
-------------------
select * from Project where Dnum = 10
update Project set Dnum = null where Dnum = 10
-------------------
select * from Works_for where ESSn = 223344
delete from Works_for where ESSn = 223344
-------------------
delete from Employee where SSN = 223344

/*14.Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30% */
update Employee set Salary = Salary*1.3 where SSN in
(select Works_for.ESSn from Works_for,Project where Project.Pnumber = Works_for.Pno and
Project.Pname = 'Al Rabwah')
 -- No employee works on Al Rabwah because it's already fired "Mr. Kamel Mohamed "



