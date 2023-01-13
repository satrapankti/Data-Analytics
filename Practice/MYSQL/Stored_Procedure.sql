CREATE DEFINER=`root`@`localhost` PROCEDURE `myproc`(IN bid integer)
BEGIN
    declare lcl_aid integer;
    declare lcl_title varchar(255);
	
    select aid, title into lcl_aid, lcl_title from books where bookid = bid;
    
    
    if lcl_aid = 6 then
       select 'Hi' as message;
	end if;
    
    
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_if`(num integer)
BEGIN
  select "Procedure begins" as status;
  if num > 5 then
	select "num is greater than 5" as message;
  elseif num = 5 then
	select "num is equal to 5" as message;
  else
	select "num is lesser than 5" as message;
  end if;
select "Procedure ends" as status;

END


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_if2`(num integer)
BEGIN

if num = 1 then
	select "ONE" as message;
elseif num = 2 then
	select "TWO" as message;
elseif num = 3 then
	select "THREE" as message;
else
	select "Out of Range" as message;
end if;

END


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_case`(num integer)
BEGIN
case num 
when 1 then
	select "ONE" as message;
when 2 then
	select "TWO" as message;
when 3 then
	select "THREE" as message;
else
	select "Out of Range" as message;
end case;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_simpleloop`(num integer)
BEGIN
declare cnt integer default 0;

myloop:LOOP

	set cnt = cnt + 1;

	select concat("Hello ", cnt)  as Message;

	-- Check termination condition
	if cnt = num then
		leave myloop;
	end if;


END LOOP myloop;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_repeat`(num integer)
BEGIN
declare cnt integer default 0;

myloop:REPEAT

	set cnt = cnt + 1;

	select concat("Hello Repeat ", cnt)  as Message;

	-- Check termination condition
	until cnt = num
END REPEAT myloop;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_while`(num integer)
BEGIN
declare cnt integer default 0;

-- Continuation condition
myloop:WHILE cnt < num DO

	set cnt = cnt + 1;

	select concat("Hello While ", cnt)  as Message;

END WHILE myloop;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `excep_1`(num integer)
BEGIN
declare MissingElse condition for 1339;
declare continue handler for MissingElse
BEGIN
	select "You forgot Else" as message;
END;

declare continue handler for 1146
BEGIN
	select "You gave wrong table" as message;
END;

declare continue handler for sqlstate '42S22'
BEGIN
	select "Column not in table" as message;
END;
declare continue handler for sqlstate '45000'
BEGIN
	select "Caught our own exception" as message;
END;


case num 
when 1 then 
	select * from aaa;
when 2 then
	select * from authors where aaa=1;
when 3 then
    -- Raise user defined exception
	signal sqlstate '45000' set MESSAGE_TEXT = 'Hi';
end case;

select "Procedure ends" as message;
END




CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cursor1`()
BEGIN
declare lcl_title, lcl_name varchar(255);
declare lcl_aid, finished integer default 0;
declare book_cur cursor for select title, aid from books;

declare continue handler for NOT FOUND
Begin
  set finished = 1;
End;

open book_cur;

bookloop:LOOP

	fetch book_cur into lcl_title, lcl_aid;
    if finished = 1 then
		leave bookloop;
	end if;
    
    select name into lcl_name from authors where authorid = lcl_aid;
	select concat(lcl_title, ' was written by ' , lcl_name) as message;

END LOOP bookloop;

close book_cur;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `ddl_proc`()
BEGIN
  drop table mytab2;
  create table mytab2(id integer, name varchar(255));
  insert into mytab2 values(1,'Tom');
  insert into mytab2 values(2,'Jon');
  alter table mytab2 add column marks integer default 50;
  
END