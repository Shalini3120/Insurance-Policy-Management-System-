# TASK 1 : 	## SQL scripts for Table creation and data insertion in the table.
## Q1. 1.Creating the schema and required tables using sql script or using MySQL workbench UI
### a schema named Insurance. 
create database insurance;

## Q1.b. b.	Create the tables mentioned above with the mentioned column names.
use insurance;
## Creating Address Table
create table address(
	address_id int primary key,
    house_no varchar(6),
    city varchar(50),
    addressline1 varchar(50),
    state varchar(50),
    pin varchar(50)
);


## Creating User Details Table
Create Table user_details(
	user_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    mobileno varchar(50),
    address_id int references address(address_id),
    dob date
);

## Creating Policy Types Table
create table ref_policy_types(
	policy_type_code varchar(10) primary key,
    policy_type_name varchar(50)
);	

## Creating Policy Sub-Types Table
create table policy_sub_types(
	policy_type_id varchar(10) primary key,
    policy_type_code varchar(10) references         
    ref_policy_types(policy_type_code),
    description varchar(50),
    yearsofpayements int,
    amount double,
	maturityperiod int,
	maturityamount double,
	validity int
);

## Creating User Policy Table
create table user_policies(
	policy_no varchar(20) primary key,
    user_id int references user_details(user_id),
    date_registered date,
    policy_type_id varchar(10) references 
    policy_sub_types(policy_type_id)         
);

## Creating User Policy Table
create table policy_payments(
	receipno int primary key,
	user_id int references user_details(user_id),
	policy_no varchar(20) references user_policies(policy_no),
	dateofpayment date,
	amount double,
	fine double
);

## 1.c. Insert the data in the newly created tables using sql script or using MySQL UI. 

# inserting values into Address Table
insert into address values 
(1, '6-21', 'hyderabad', 'kphb', 'andhra pradesh', 1254),
(2, '7-81', 'chennai', 'seruseri', 'tamilnadu', 16354),
(3, '3-71', 'lucknow', 'street', 'uttarpradesh', 86451),
(4, '4-81', 'mumbai', 'iroli', 'maharashtra', 51246),
(5, '5-81', 'bangalore', 'mgroad', 'karnataka', 125465),
(6, '6-81', 'ahamadabad', 'street2', 'gujarat', 125423),
(7, '9-21', 'chennai', 'sholinganur', 'tamilnadu', 654286);

# Inserting values into User Details Table
insert into user_details values
(1111,'raju','reddy','raju@gmail.com','9854261456',4,'1986-4-11'),
(2222,'vamsi','krishna','vamsi@gmail.com','9854261463',1,'1990-4-11'),
(3333,'naveen','reddy','naveen@gmail.com','9854261496',4,'1985-3-14'),
(4444,'raghava','rao','raghava@gmail.com','9854261412',4,'1985-9-21'),
(5555,'harsha','vardhan','harsha@gmail.com','9854261445',4,'1992-10-11');

# Inserting values into policy types Table
insert into ref_policy_types values
('58934', 'car'),
('58539', 'home'),
('58683', 'life');

# Inserting values into policy sub types Table
insert into policy_sub_types values
('6893','58934','theft',1,5000,null,200000,1),
('6894','58934','accident',1,20000,null,200000,3),
('6895','58539','fire',1,50000,null,500000,3),
('6896','58683','anandhlife',7,50000,15,1500000,null),
('6897','58683','sukhlife',10,5000,13,300000,null);

# Inserting values into user policy Table
insert into  user_policies values
('689314',1111,'1994-4-18','6896'),
('689316',1111,'2012-5-18','6895'),
('689317',1111,'2012-6-20','6894'),
('689318',2222,'2012-6-21','6894'),
('689320',3333,'2012-6-18','6894'),
('689420',4444,'2012-4-09','6896');


# Inserting values into policy_payments Table
insert into policy_payments values
(121,4444,'689420','2012-4-09',50000,null),
(345,4444,'689420','2013-4-09',50000,null),
(300,1111,'689317','2012-6-20',20000,null),
(225,1111,'689316','2012-5-18',20000,null),
(227,1111,'689314','1994-4-18',50000,null),
(100,1111,'689314','1995-4-10',50000,null),
(128,1111,'689314','1996-4-11',50000,null),
(96,1111,'689314','1997-4-18',50000,200),
(101,1111,'689314','1998-4-09',50000,null),
(105,1111,'689314','1999-4-08',50000,null),
(120,1111,'689314','2000-4-05',50000,null),
(367,2222,'689318','2012-6-21',20000,null),
(298,3333,'689320','2012-6-18',20000,null);


# TASK 2:
# SQL scripts for all the select queries

#Q2.Perform read operation on the designed table created in the above task using SQL script. 
# Q2.a) a.	Write a query to display the policytypeid,policytypename,description of all the car’s policy details.
select pst.policy_type_id, rpt.policy_type_name, pst.description
from policy_sub_types pst
join ref_policy_types rpt 
on pst.policy_type_code = rpt.policy_type_code
where rpt.policy_type_name = 'car';
    
#Q2.b) Write a query to display the policytypecode,no of polycies in each code with alias name NO_OF_POLICIES.
select policy_type_code,COUNT(*) as NO_OF_POLICIES
from policy_sub_types
group by policy_type_code;

#Q2.c.Write a query to display the userid,firstname,lastname, email,mobileno who are residing in Chennai.
select ud.user_id, ud.first_name, ud.last_name, ud.email, ud.mobileno
from user_details ud
join address a on ud.address_id = a.address_id
where a.city = 'Chennai';

#Q2.d. Write a query to display the userid, firstname lastname with alias name USER_NAME,email,mobileno who has taken the car polycies. 
select ud.user_id,CONCAT(ud.first_name, ' ', ud.last_name) as USER_NAME, ud.email, ud.mobileno
from user_details ud
join user_policies up on ud.user_id = up.user_id
join policy_sub_types pst on up.policy_type_id = pst.policy_type_id
join ref_policy_types rpt on pst.policy_type_code = rpt.policy_type_code
where rpt.policy_type_name = 'car';

#Q2.e. Write a query to display the userid, firstname,last name who has taken 
# the car policies but not home policies.
select ud.user_id, ud.first_name, ud.last_name
from user_details ud
join user_policies up on ud.user_id = up.user_id
join policy_sub_types pst on up.policy_type_id = pst.policy_type_id
join ref_policy_types rpt on pst.policy_type_code = rpt.policy_type_code
where rpt.policy_type_name = 'car'
and ud.user_id not in ( select distinct up.user_id from user_policies up
join policy_sub_types pst_home on up.policy_type_id = pst_home.policy_type_id
join ref_policy_types rpt_home on pst_home.policy_type_code = rpt_home.policy_type_code
where rpt_home.policy_type_name = 'home'
);

#Q2. f.	Write a query to display the policytypecode, policytype name which policytype has maximum no of policies.
select rpt.policy_type_code, rpt.policy_type_name
from ref_policy_types rpt
join policy_sub_types pst on rpt.policy_type_code = pst.policy_type_code
group by rpt.policy_type_code, rpt.policy_type_name
having count(pst.policy_type_id) = (select max(policy_type_count)
from (select rpt.policy_type_code, count(pst.policy_type_id) as policy_type_count
from ref_policy_types rpt
join policy_sub_types pst on rpt.policy_type_code = pst.policy_type_code
group by rpt.policy_type_code) as subquery
);

#Q2,g.Write a query to display the userid, firtsname, lastname, city state whose city is ending with ‘bad’.
select ud.user_id, ud.first_name, ud.last_name, a.city, a.state
from user_details ud
join address a on ud.address_id = a.address_id
where a.city like '%bad';

#Q2.h.Write a query to display the userid, firstname, lastname ,policyno, dateregistered who has registered before may 2012.
select ud.user_id, ud.first_name, ud.last_name, up.policy_no, up.date_registered
from user_details ud
join user_policies up on ud.user_id = up.user_id
where DATE_FORMAT(up.date_registered, '%Y-%m') < '2012-05';

#Q2.i.Write a query to display the userid, firstname, lastname who has taken more than one policies.
select ud.user_id, ud.first_name, ud.last_name
from user_details ud
join user_policies up on ud.user_id = up.user_id
group by ud.user_id, ud.first_name, ud.last_name
having count(up.policy_no) > 1;

#Q2.j.Write a query to display the policytypecode, policytypename, policytypeid, userid, policyno whose maturity will fall in the month of august 2013.
select rpt.policy_type_code, rpt.policy_type_name, pst.policy_type_id, up.user_id, up.policy_no
from ref_policy_types rpt
join policy_sub_types pst on rpt.policy_type_code = pst.policy_type_code
join user_policies up on pst.policy_type_id = up.policy_type_id
where MONTH(up.date_registered) = 8
and YEAR(up.date_registered) = 2013;