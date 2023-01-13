-- 20/03/2022
-- to show list of databases
show databases;
-- to create a database
create database dummy;
-- always select the database/ schema to work on it 
use dummy;
-- to show the list of tables
show tables;

-- 26/03/2022
-- to create a table
CREATE TABLE student (
    id_student INT NOT NULL,
    full_name VARCHAR(50),
    mobile VARCHAR(10) NULL
);
-- by default it is null 
describe student;

-- to drop the table 
drop table student;
 
CREATE TABLE student (
    id_student INT NOT NULL,
    full_name VARCHAR(50),
    mobile VARCHAR(10) NULL,
    address VARCHAR(255)
);
describe student;

-- alter a table
-- add column
alter table student add course varchar(50);
-- modify table
alter table student modify	course varchar(100);

alter table student add course1 varchar(50);
-- drop a table
alter table student drop course1;
-- rename table 
alter table student rename students;
describe students;

-- DML command
-- insert values in table
insert into students values
(
103,"Megha Agarwal","894560356","Pune","Data Science"
);
SELECT 
    *
FROM
    students;
 insert into students (id_student,full_name) values (101,"Priya Sharma");
 -- insert multiple values
insert into students values
(104,"Rita","6841255","Pune"," Science"),
(105,"sita","1248931","Delhi","Data Analytics")
;
 
 -- update the values in table
UPDATE students 
SET 
    address = 'US'
WHERE
    id_student = 100;
UPDATE students 
SET 
    address = 'London';-- this will update for the whole column
UPDATE students 
SET 
    course = 'Commerce'
WHERE
    address IS NULL;-- can use is blank -> ""
 
DELETE FROM students 
WHERE
    id_student = 105 AND full_name = 'Sita';
 
 -- DQL command
SELECT 
    *
FROM
    students;
SELECT 
    full_name, course
FROM
    students;
SELECT 
    full_name, course
FROM
    students
WHERE
    course = 'Data';
SELECT 
    *
FROM
    students
WHERE
    address = 'London';
SELECT 
    *
FROM
    students
WHERE
    id_student < 102;
SELECT 
    *
FROM
    students
LIMIT 3;
SELECT 
    *
FROM
    students
LIMIT 1 , 2;
 -- unique values 
SELECT DISTINCT
    address, course
FROM
    students;
 -- not equal to -> != and <>
SELECT 
    *
FROM
    students
WHERE
    id_student BETWEEN 101 AND 104;
SELECT 
    *
FROM
    students
WHERE
    id_student >= 101 AND id_student <= 104;
-- not between
SELECT 
    *
FROM
    students
WHERE
    id_student NOT BETWEEN 101 AND 104;
-- multiple values
SELECT 
    *
FROM
    students
WHERE
    id_student IN (101 , 104);
 -- wildcard %
SELECT 
    *
FROM
    students
WHERE
    full_name LIKE 'P%';
 -- starts with _% , ends with %_, contains %_%

-- 27/03/2022
use dummy;
SELECT 
    *
FROM
    students;

CREATE TABLE `marks` (
    `idmarks` INT NOT NULL,
    `subject` VARCHAR(45) NOT NULL,
    `mark` INT NOT NULL,
    `id_student` INT NOT NULL,
    PRIMARY KEY (`idmarks`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

-- insert marks
insert into marks values 
(11,"java",55,102),
(12,"c++",40,102),
(13,"mysql",98,102),
(14,"html",71,102),
(15,"python",83,102);
 
SELECT 
    *
FROM
    marks;
SELECT 
    *
FROM
    marks
WHERE
    subject = 'c++';
 -- min,max operator
SELECT 
    MIN(mark)
FROM
    marks
WHERE
    subject = 'java';
 -- group by
SELECT 
    MIN(mark), MAX(mark), subject
FROM
    marks
GROUP BY subject;
-- average group by
SELECT 
    AVG(mark), subject
FROM
    marks
GROUP BY subject;
-- sum group by
SELECT 
    SUM(mark), id_student
FROM
    marks;-- this will give grand total so we need to group by it
SELECT 
    SUM(mark), id_student
FROM
    marks
GROUP BY id_student
ORDER BY mark;-- from marks table id wise groupby distinct id and then sum up

SELECT 
    *
FROM
    marks
ORDER BY subject ASC , mark DESC;

-- order of the query should be 
-- select * from table name condition(if/where clause) group by order by; 
/* for commenting */

CREATE TABLE `practice` (
    `id_student` INT NOT NULL UNIQUE,
    `full_name` VARCHAR(50) DEFAULT NULL,
    `mobile` VARCHAR(10) UNIQUE,
    `address` VARCHAR(255) DEFAULT 'mumbai'
);

describe practice;
insert into practice values
(104,"Rita","6841255","Pune");
insert into practice (id_student,full_name) values (101,"Priya Sharma");
SELECT 
    *
FROM
    practice;

-- Check Constraint
alter table practice add age int not null default 18 check(age>=18);
insert into practice (id_student,full_name,age) values (105,"Priya Sharma",10);
insert into practice (id_student,full_name,age) values (107,"Priya",26);

drop table practice;

-- Auto Increment
-- Primary Key / Parent Key
-- it will not accept null and duplicate value means it will be not null and unique
CREATE TABLE `practice` (
    `id_student` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(50) DEFAULT NULL,
    `mobile` VARCHAR(10) UNIQUE,
    `address` VARCHAR(255) DEFAULT 'mumbai',
    `age` INT NOT NULL DEFAULT 18 CHECK (age >= 18)
);

describe practice;
insert into practice (full_name,age) values ("Priya",26);
insert into practice (full_name,age) values ("riya",26);
insert into practice (id_student,full_name,age) values (4,"siya",26);
SELECT 
    *
FROM
    practice;

-- Foreign Key 
-- to built relationship between two tables
CREATE TABLE `pmark` (
    `idmarks` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `subject` VARCHAR(45) NOT NULL,
    `mark` INT NOT NULL CHECK (mark <= 100),
    `student_id` INT NOT NULL,
    FOREIGN KEY (student_id)
        REFERENCES practice (id_student)
);-- own column ,relation table,relation column

SELECT 
    *
FROM
    pmark;
insert into pmark (subject,mark,student_id)  values 
("java",45,2),
("c++",60,2),
("mysql",78,2),
("html",76,2),
("python",93,2);

-- replace
replace into pmark (subject,mark,student_id) values ("html",10,2);

-- alter constraint
alter table practice add constraint unq_student_mobile unique (mobile); -- table name,unique name for constraint,constraint column
describe practice;
-- drop constraint
alter table practice drop constraint unq_student_mobile; 
describe practice;
SELECT 
    *
FROM
    practice;
insert into practice values
(5,"Megha Agarwal","894560356","Pune",20);

-- drop table pmark;

-- Sequences / Auto_Increment
-- to set auto increment initial value
alter table pmark auto_increment=100;-- this start new and will not replace the existing
SELECT 
    *
FROM
    pmark;

-- joining the Table
-- LEFT JOIN,RIGHT JOIN,CROSS JOIN,INNER JOIN
-- select ,columns to display with aliases from table1 __ join table2 on table1.c1=table2.c1 -- c1 is the common column -- common column from which table should be mention to display
SELECT 
    *
FROM
    students;-- id_student,full_name,mobile,address,course(100...105)--6
SELECT 
    *
FROM
    marks;-- idmarks,subject,mark,id_student(100...102)--15
-- A cross join matches all rows in one table to all rows in another table. An inner join matches on a field or fields.

SELECT 
    *
FROM
    marks AS m
        INNER JOIN
    students AS s ON m.id_student = s.id_student;-- this will merge the whole table with common records
select s.id_student as id ,full_name, subject,mark,course from marks as m inner join students as s on m.id_student = s.id_student; -- to display specific columns
select s.*,sum(mark)from students as s inner join marks as m on m.id_student=s.id_student group by m.id_student; -- based on students sum of mark from marks

-- Cross Join  (())   / Cartesian Join
-- it is similar to inner join i.e A U B -- it will try all permutation & combination of output
select * from marks as m cross join students as s  on m.id_student = s.id_student;
select s.id_student as id ,full_name, subject,mark,course from marks as m cross join students as s on m.id_student = s.id_student; 
SELECT 
    s.*, SUM(mark)
FROM
    students AS s
        CROSS JOIN
    marks AS m ON m.id_student = s.id_student
GROUP BY m.id_student;

-- Full Join
-- to merge two tables -- will give null to unfilled data 
SELECT 
    *
FROM
    marks AS m
        LEFT JOIN
    students AS s ON m.id_student = s.id_student 
UNION ALL SELECT 
    *
FROM
    marks AS m
        RIGHT JOIN
    students AS s ON m.id_student = s.id_student;

-- Left Join  (()
-- whole left column and the common column
SELECT 
    *
FROM
    marks AS m
        LEFT JOIN
    students AS s ON m.id_student = s.id_student;
select * from students as s left join marks as m  on m.id_student = s.id_student;
select s.id_student as id ,full_name, subject,mark,course from marks as m left join students as s on m.id_student = s.id_student; 
SELECT 
    s.id_student AS id, full_name, subject, mark, course
FROM
    students AS s
        LEFT JOIN
    marks AS m ON m.id_student = s.id_student;
SELECT 
    s.*, SUM(mark)
FROM
    students AS s
        LEFT JOIN
    marks AS m ON m.id_student = s.id_student
GROUP BY m.id_student;-- based on students sum of mark from marks
select m.*,sum(mark)from marks as m left join students as s  on m.id_student=s.id_student group by m.id_student; -- based on marks sum of mark from marks

-- Right Join   ())
-- opposite of Inner Join
select * from marks as m right join students as s  on m.id_student = s.id_student;
select * from students as s right join marks as m  on m.id_student = s.id_student;
select s.id_student as id ,full_name, subject,mark,course from marks as m right join students as s on m.id_student = s.id_student; 
SELECT 
    s.id_student AS id, full_name, subject, mark, course
FROM
    students AS s
        RIGHT JOIN
    marks AS m ON m.id_student = s.id_student;
SELECT 
    s.*, SUM(mark)
FROM
    students AS s
        RIGHT JOIN
    marks AS m ON m.id_student = s.id_student
GROUP BY m.id_student;-- based on students sum of mark from marks
select m.*,sum(mark)from marks as m right join students as s  on m.id_student=s.id_student group by m.id_student; -- based on marks sum of mark from marks

-- TCL Command
-- start transaction,rollback,commit
select*from students;
start transaction; -- auto commit is off
update students set id_student = 106 where id_student= 104;
rollback;
start transaction;
insert into students values
(5,"Megha Agarwal","894561356","Pune",20);
savepoint std;
insert into students values
(6,"Sumit Patel","894660376","mumbai",20);
rollback to std;
commit;

-- 3/4/2022
-- Indexes by default b-tree(based on binary algorithm)

CREATE TABLE `sample` (
    `subject` VARCHAR(45) NOT NULL,
    `mark` INT NOT NULL,
    `student_id` INT NOT NULL,
    INDEX in_id USING BTREE (student_id),
    KEY `student_id` (`student_id`),
    CONSTRAINT `pmark_ibfk_1` FOREIGN KEY (`student_id`)
        REFERENCES `practice` (`id_student`),
    CONSTRAINT `pmark_chk_1` CHECK ((`mark` <= 100))
);

-- special indexes 
-- with check option
-- view -- virtual table for DQL commannds saved by a name
CREATE VIEW vw_subject AS
    SELECT 
        full_name
    FROM
        students WITH CHECK OPTION;
select*from vw_subject;
select*from marks;
drop view vw_subject;
create view vw_sum_marks as select  marks.id_student,full_name,sum(mark) as Total from marks inner join  students on marks.id_student=students.id_student  
group by marks.id_student order by sum(mark) ;
select*from vw_sum_marks;

CREATE VIEW vw_minmax AS
    SELECT 
        subject, MIN(mark), MAX(mark)
    FROM
        marks
    GROUP BY subject;
select id_student,full_name,max(Total) from  vw_sum_marks;
select*from vw_minmax;

-- stored procedure
-- 9/4/22
















