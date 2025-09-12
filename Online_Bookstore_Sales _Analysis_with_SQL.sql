-- CREATE DATABASE onlinebookstore_db; 
use onlinebookstore_db;
SELECT * FROM onlinebookstore_db.books;
SELECT * FROM onlinebookstore_db.customers;
SELECT * FROM onlinebookstore_db.orders;

-- 1. Retrieve all books in the “Fiction” genre. 
select * from books where Genre="Fiction";

-- 2. Find books published after the year 1950. 
select * from books where Published_Year>1950;

-- 3. List all customers from Canada. 
 select * from books where Country="Canada";
 
-- 4. Show orders placed in November 2023. 
select * from orders where Order_Date>='2023-11-01' and Order_Date<= '2023-11-30';

-- 5. Retrieve the total stock of books available. 
select count(Stock) from books;

-- 6. Find the details of the most expensive book. 
SELECT * FROM books WHERE Price = (SELECT MAX(Price) FROM books);

-- 7. Show all customers who ordered more than 1 quantity of a book. 
select * from orders where Quantity>1;

-- 8. Retrieve all orders where the total amount exceeds $20. 
select * from orders where Total_Amount>20;

-- 9. List all distinct genres in the bookstore. 
select distinct(Genre) from books;

-- 10. Find the book with the lowest stock available. 
select *  from books where Stock=(select min(Stock) from books);


-- 11. Calculate the total revenue from all orders. 
select round(sum(Total_Amount)) from orders; 

-- 12. Retrieve the total number of books sold for each genre. 
select distinct(Genre),count(Genre) from books group by Genre;

-- 13. Find the average price of books in the “Fantasy” genre. 
select round(avg(price)) from books where Genre="Fantasy";

-- 14. List customers who have placed at least 2 orders. 
select distinct(Name),Quantity from customers join orders on customers.Customer_ID=orders.Customer_ID where Quantity>2;

-- 15. Find the most frequently ordered book. 
select title,count(*) as freq from books join orders on books.Book_ID=orders.Book_ID group by title order by freq desc;

-- 16. Show the top 3 most expensive books of the “Fantasy” genre. 
select title,max(Price) as freq from books  where Genre="Fantasy" group by title order by freq desc limit 1;
select max(Price) from books;

-- 17. Retrieve the total quantity of books sold by each author. 
select Author ,sum(Quantity) as total_book_sold from books b join orders on b.Book_ID=orders.Book_ID group by Author order by total_book_sold desc;

-- 18. List the cities of customers who spent over $30.
select City,sum(Total_Amount) as cust_spend from customers c join orders o on 
c.Customer_ID=o.Customer_ID group by city having sum(Total_Amount) order by cust_spend desc;  

-- 19. Find the customer who spent the most on orders. 
SELECT c.Name,SUM(o.Total_Amount) AS Total_Spent FROM customers c JOIN orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name ORDER BY Total_Spent DESC LIMIT 1;

-- 20. Calculate the stock remaining after fulfilling all orders. 
SELECT b.Title,b.Stock AS Initial_Stock,SUM(o.Quantity) AS Total_Sold,b.Stock - IFNULL(SUM(o.Quantity), 0) AS Remaining_Stock FROM books b LEFT JOIN 
orders o ON b.Book_ID = o.Book_ID GROUP BY b.Book_ID, b.Title, b.Stock;
