--1.Display the Department id, name and id and the name of its manager.
select Dnum ,Dname ,Superssn ,Fname,Lname 
from Departments,Employee
where ssn = MGRSSN

--2.Display the name of the departments and the name of the projects under its control.
select Departments.Dname , Pname  from Departments , Project
where Departments.Dnum=Project.Dnum

--3.Display the full data about all the dependence associated with the name of 
--the employee they depend on him/her.
select * 
from Dependent , Employee 
where SSN = ESSN

--4.Display the Id, name and location of the projects in Cairo or Alex city.
select Pnumber , pname , plocation
from Project 
where City = 'Cairo' or City = 'Alex' 

--5.Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project where Pname LIKE 'A%'

--6.display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select * from Employee
where Dno = 30 and Salary between 1000 and 2000

--7.Retrieve the names of all employees in department 10 who works more than or 
--equal10 hours per week on "AL Rabwah" project.
select distinct fname + ' '+ lname Full_Name
from Employee , Works_for , Project
where Employee.SSN = Works_for.ESSn  and Project.Dnum = Employee.Dno
and Works_for.Hours >= 10 and Dno = 10 and Pname = 'Al Rabwah'

-- 8.Find the names of the employees who directly supervised with Kamel Mohamed.
select distinct em1.Fname + ' '+ em1.Lname Full_Name
from Employee em1 , Employee em2
where em1.Superssn = em2.SSN and em2.Fname +' '+ em2.Lname = 'Kamel Mohamed'

--9.Retrieve the names of all employees and the names of the projects they
--are working on, sorted by the project name.
select distinct fname , lname , pname 
from Employee , Project
where Project.Dnum = Employee.Dno
order by Pname

--10.For each project located in Cairo City , find the project number,the controlling
--department name ,the department manager last name ,address and birthdate.
select Pnumber , Dname , Lname, Address,Bdate 
from Employee , Project,Departments
where Project.Dnum = Departments.Dnum and Employee.SSN = Departments.MGRSSN
and City = 'Cairo'

--11.Display All Data of the managers
select * from Employee , Departments
where Employee.SSN = Departments.MGRSSN

--12.Display All Employees data and the data of their dependents even 
-- if they have no dependents
select * from Employee left join Dependent on Dependent.ESSN = Employee.SSN 

--13.Insert your personal data to the employee table as a new employee in 
--department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee(Dno,SSN,Superssn,Salary) values (20,102672,112233,3000)

--14.Insert another employee with personal data your friend as new employee in
--department number 30,
--SSN = 102660, but don’t enter any value for salary or supervisor number to him.
insert into Employee(Dno,SSN) values (30,102660)

--15.Upgrade your salary by 20 % of its last value
update Employee set Salary = Salary*1.2 where SSN = 102672