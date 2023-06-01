SELECT * FROM book_data.customers;

-- Renaming of Fist_name to First_name in Customer_Table
Alter table customers rename column fist_name to first_name ;
-- To Check if there is any duplicated value
SELECT first_name ,last_name ,cobook_categoryunt(1)
FROM book_data.customers
group by first_name ,last_name
having count(1) >1;

-- deleting the duplicate record Bcz points are of no use 

  delete 
  from book_data.customers
  where customer_id = 
    (select max(customer_id)
	from book_data.customers 
	group by first_name ,last_name
	having count(1) >1); ----- Error 1093 we cant use same table as we are using in select query 
    
-- deleting duplicate record by joins
with cte as 
	(select max(customer_id)
	from book_data.customers 
	group by first_name ,last_name
	having count(1) >1)
delete from book_data.customers
where customer_id = (select * from cte); --  

-- Option2 but not recommended
create table bckup_customers as 
select * 
from book_data.customers 
where customer_id <> (select max(customer_id)
	from book_data.customers 
	group by first_name ,last_name
	having count(1) >1);
drop table customers ;

--
Alter Table Orders Drop foreign key fk_orders_customers;
Alter Table Orders ADD Constraint fk_orders_customers Foreign Key(Customer_id) References Customers(Customer_id);-- didnt work
-- we cannot add foreign key because
-- while deleting the record for primary key we lost our record of order table also
-- we again inserted order table records


-- REST IS FINE GOOD TO GO FOR ANALYSIS

    
 
