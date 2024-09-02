show databases;
use chinook;

-- 1. Calculate Monthly-Wise invoice Sales and sort them in descending order. (12 rows)

show tables;
select * from customer;
select * from invoice;

-- 1st method

select monthname(invoicedate) as 'month-wise',
sum(total) as sales 
from invoice 
group by 1 order by 2 desc;

-- 2 method

select monthname(invoicedate) as 'month-wise',
sum(total) as sales 
from invoice 
group by monthname(invoicedate)
order by sales desc;

-- 2. Write an SQL query to fetch the names of all employees and their managers. (7 rows)

select concat_ws(' ', t1.firstname, t1.lastname) as managers,
concat_ws(' ', t2.firstname, t2.lastname) as employees
from employee as t1
inner join
employee as t2
on t1.employeeId = t2.reportsTo;

-- 3. Find the names of customers who have made a purchase in the USA? (13 rows)
show tables;

select distinct firstname, lastname, email
from customer c
inner join invoice i
on
c.customerid = i.customerid
where billingcountry = 'USA';

-- 4. Show the name of each genre and the total number of tracks in that genre. (25 rows)

select * from genre;
select * from album;

select g.name as gnere_name, count(t.trackid) as track_count
from genre g
join track t 
on g.genreid = t.genreid
group by g.genreid;

-- 5. Show the name of each customer and the total amount they have spent on purchases. (59 rows)
show tables;
select * from invoice;

select c.customerid, c.firstname, c.lastname, sum(i.total) as total_spent
from customer c
join invoice i
on c.customerid = i.customerid
group by c.customerid, c.firstname, c.lastname;

-- 6. Find the name of the album with the highest unit price. (1 row)

select * from album;
select * from track;

select title, unitprice
from track t
inner join album a
on a.albumid = t.albumid
order by unitprice desc limit 1;

-- 7. Display the percentage of missing values for “billingstate” and “billingpostalcode” columns respectively for the invoice table. (1 row)

select concat(round(billingstate is null) / count(*) * 100), "%") as billingstate,
concat(round(sum(billingpostalcode is null) / count(*) * 100), "%") as billingpastalcode
from invoice;

-- 8. Show the name of each track and the total number of times it has been purchased. (100 rows)

select t.name, count(il.invoicelineid) as purchase_count
from track t
left join invoiceline as il
on t.trackid = il.trackid
group by t.trackid;

-- 9. Find the name of the customer who has made the largest purchase in terms of total cost. (1 row)

select concat(c.firstname,' ', c.lastname) as customername,
sum(i.total) as totalpurchases
from customer c
join invoice i
on c.customerid = i.customerid
group by c.customerid
order by sum(i.total) desc limit 1;

-- 10. Display the total amount spent by each customer and the number of invoices they have. (59 rows)
-- Note: calculate the total amount spent and the number of invoices for each customer.

select c.firstname, c.lastname, count(i.invoiceid) as totalinvoices,
sum(i.total) as totalspent
from customer c
join invoice i 
on c.customerid = i.customerid
group by c.customerId;

-- 11. Find the name of the artist who has the most tracks in the chinook database. (1 row)

select name from artist as t1
inner join (select artistid, count(*) as track_count
from album a
join track t
on a.albumid = t.albumid
group by artistid
order by track_count desc limit 1) as t2
on t1.artistid = t2.artistid;

-- 12. Find the names and email addresses of customers who have spent more than the average amount on invoices. (59 rows)

select firstname, lastname, email
from customer c
inner join invoice i
on c.customerid = i.customerid
group by i.customerid
having sum(i.total) > avg(total);

-- 13. List the names of all the artists that have tracks in the 'Rock' genre. (51 rows)

select distinct ar.name
from artist ar
inner join album al on ar.artistid = al.artistid
inner join track t on al.albumid = t.albumid
inner join genre g on t.genreid = g.genreid
where g.name = 'Rock';


