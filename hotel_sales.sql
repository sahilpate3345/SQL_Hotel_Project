-- Show all payments done using UPI
SELECT * FROM payments WHERE paymentmethod='UPI';

-- Show all customers
SELECT * FROM customers;

-- Show all tables
SHOW TABLES;

-- Display unique first names of customers (max 1000)
SELECT DISTINCT firstname FROM customers LIMIT 1000;

-- Delete all rooms with capacity = 1
SET SQL_SAFE_UPDATES = 0;
DELETE FROM rooms WHERE capacity = 1;
SET SQL_SAFE_UPDATES = 1;

-- Display customers' contact details (name + phone)
SELECT CONCAT(firstname,' ',lastname,' ',phone) AS contactphone FROM customers;

-- Show all bookings
SELECT * FROM bookings;

-- Show bookings where RoomID = 10
SELECT * FROM bookings WHERE RoomID=10;

-- Show rooms with capacity greater than average capacity
SELECT * FROM rooms WHERE capacity > (SELECT AVG(capacity) FROM rooms);

-- Show staff details
SELECT * FROM staff;

-- Create a view to show staff contact details
CREATE VIEW staffcontact AS
SELECT firstname, lastname, role, phone FROM staff;

-- Show suites priced less than 7000
SELECT * FROM rooms WHERE roomtype='suite' AND pricepernight < 7000;

-- Show customers' emails ordered by last name
SELECT email FROM customers ORDER BY lastname;

-- Show customers' full name (firstname + lastname)
SELECT CONCAT(firstname,' ',lastname) AS fullname FROM customers;

-- Show all payments
SELECT * FROM payments;

-- Combine payment details in a single field
SELECT CONCAT_WS('', paymentid, bookingid, paymentdate, paymentmethod, amount) AS total_payment FROM payments;

-- Show top 2 most expensive rooms
SELECT * FROM rooms ORDER BY pricepernight DESC LIMIT 2;

-- Show booking ID and stay period
SELECT bookingid, CONCAT_WS(' ', CheckInDate, CheckOutDate) AS stay_per FROM bookings;

-- Show average payment amount per payment method
SELECT paymentmethod, AVG(amount) AS avg_amount FROM payments GROUP BY paymentmethod;

-- Show cities with more than 50 customers
SELECT city FROM customers GROUP BY city HAVING COUNT(customerid) > 50;

-- Show customers who booked more than 5 times
SELECT customerid, COUNT(*) AS bookingcount FROM bookings GROUP BY customerid HAVING COUNT(*) > 5;

-- Show customers in the same city (self join)
SELECT c1.customerid, c2.customerid, c1.city  
FROM customers c1 
JOIN customers c2 
  ON c1.city=c2.city 
 AND c1.customerid < c2.customerid;

-- Show total revenue handled by each staff
SELECT staffid, SUM(totalamount) AS totalrevenue FROM bookings GROUP BY staffid;

-- Show customers from Mumbai
SELECT * FROM customers WHERE city='mumbai';

-- Show 3 lowest booking amounts
SELECT totalamount FROM bookings ORDER BY totalamount ASC LIMIT 3;

-- Insert 5 new rooms
INSERT INTO Rooms (RoomID, RoomType, PricePerNight, Capacity) VALUES 
(201, 'Suite', 6500, 3),
(202, 'Deluxe', 4500, 2),
(203, 'Family', 7000, 4),
(204, 'Standard', 2500, 2),
(205, 'Suite', 9000, 4);

-- Show all unique customer IDs from bookings
SELECT DISTINCT customerid FROM bookings;

-- Update customer name where customerid=30
UPDATE customers SET firstname='rahul' WHERE customerid=30;

-- Show bookings ordered by check-in date
SELECT * FROM bookings ORDER BY checkindate;

-- Show rooms where capacity > 2
SELECT * FROM rooms WHERE capacity > 2;

-- Show staff email and role ordered by role
SELECT email, role FROM staff ORDER BY role;

-- Show first 4 customers with full name + city
SELECT CONCAT_WS('', firstname, lastname, city) AS fullname FROM customers LIMIT 4;

-- Show staff full name with role
SELECT Role, CONCAT(FirstName, ' ', LastName) AS FullName FROM Staff;

-- Show average staff ID by role
SELECT role, AVG(staffid) AS avg_staffid FROM staff GROUP BY role;

-- Show staff with ID = 2 (from bookings)
SELECT staffid FROM bookings GROUP BY staffid HAVING staffid=2;

-- Show first 4 staff ordered by firstname
SELECT firstname FROM staff ORDER BY firstname ASC LIMIT 4;

-- Show customers named 'amit' from Nagpur
SELECT * FROM customers WHERE firstname='amit' AND city='nagpur';

-- Show distinct payment methods in descending order
SELECT DISTINCT paymentmethod FROM payments ORDER BY paymentmethod DESC;

-- Insert 5 new staff records
INSERT INTO Staff (StaffID, FirstName, LastName, Role, Phone, Email) VALUES 
(301, 'Suresh', 'Kumar', 'Manager', '9876543210', 'suresh@hotel.com'),
(302, 'Priya', 'Patel', 'Chef', '9765432109', 'priya@hotel.com'),
(303, 'Ravi', 'Sharma', 'Waiter', '9898989898', 'ravi@hotel.com'),
(304, 'Anita', 'Mehra', 'Receptionist', '9123456789', 'anita@hotel.com'),
(305, 'Rahul', 'Singh', 'Manager', '9988776655', 'rahul@hotel.com');

-- Show distinct room types
SELECT DISTINCT roomtype FROM rooms;

-- Show customers with total spending < 50000
SELECT c.customerid, c.firstname, c.lastname, SUM(b.totalamount) AS total_spent
FROM customers c
JOIN bookings b ON c.customerid=b.customerid
GROUP BY c.customerid, c.firstname, c.lastname 
HAVING SUM(totalamount) < 50000;

-- Delete customers from TestCity
DELETE FROM Customers WHERE City = 'TestCity';

-- Find rooms with the same price (self join)
SELECT r1.roomid, r1.pricepernight, r2.roomid 
FROM rooms r1
JOIN rooms r2 
  ON r1.pricepernight = r2.pricepernight
 AND r1.roomid < r2.roomid;

-- Show staff with email domain '@tcs.in'
SELECT * FROM Staff WHERE Email LIKE '%@tcs.in';

-- Show city with maximum customer ID > 100
SELECT city, MAX(customerid) AS max_custid
FROM customers 
GROUP BY city 
HAVING MAX(customerid) > 100;
--- Show the first 4 payments only
select * from payments limit 4;
show tables;
--- The hotel manager wants to review rooms where PricePerNight is between ₹2000 and ₹4000 to offer discounts. 
select * from rooms where pricepernight between 2000 and  4000 order by pricepernight asc;
---- List all bookings ordered by CheckInDate.
select * from bookings  order by checkindate asc;
select distinct customerid from bookings;
---- The hotel manager wants to add new customer details. Insert 5 records with full details into the Customers table.
select *  from customers;
---  Show the last 2 staff hired. 
SELECT * 
FROM Staff 
ORDER BY staffid DESC 
LIMIT 2;

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, City)
VALUES 
(201, 'Rahul', 'Sharma', 'rahul.sharma@example.com', '9876543210', 'Mumbai'),
(202, 'Anita', 'Patel', 'anita.patel@example.com', '9123456780', 'Pune'),
(203, 'Vikas', 'Kumar', 'vikas.kumar@example.com', '9988776655', 'Nagpur'),
(204, 'Sneha', 'Deshmukh', 'sneha.deshmukh@example.com', '9012345678', 'Nashik'),
(205, 'Kapil', 'Singh', 'kapil.singh@example.com', '9876501234', 'Aurangabad');
--  Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)
select * from rooms where pricepernight>(select max(pricepernight) from rooms where capacity=2);
-- -- Show staff whose Role is not 'Chef'
select * from staff where role!='chef';
--- 59] Show all unique cities from Customers in descending order
select distinct city from customers order by city desc;
-- Display the phone number of the Waiter only
select phone from staff where role='waiter';
--   Display the last 2 bookings in the table. 
select * from bookings  order by  bookingid desc limit 2;
--- Question - 62] The marketing team wants to see customers living in Delhi or Chennai for target promotion
select * from customers where city='delhi' or city='chennai';
--- 63] Show all rooms where RoomType != 'Family' to plan renovations.
select * from rooms where roomtype <> 'family';
--- List staff emails ordered by their roles
select email,role from staff order by role;
-- Display all unique payment methods
select distinct paymentmethod from payments;
-- ist of customers whose Phone starts with '98'
select * from customers where phone like '98';
-- Show the 3 cheapest rooms availabl
select * from rooms order by pricepernight asc limit 3;
-- display the last 2 payments
select * from payments order by paymentid desc limit 2;
--  Management wants to know which unique cities customers come from
select distinct city from customers;
--- List all bookings where TotalAmount > 5000
select * from bookings where totalamount>5000;
---  Display each staff’s Role with their Email in one column
select concat(role,'',email) as email
from staff;
--- Show the first 4 staff full names
select concat(firstname,'',lastname) as fullname
from staff limit 4;
-- Find bookings where TotalAmount is greater than all bookings made by CustomerID = 10
select * from bookings where totalamount>all(select totalamount from bookings where customerid=10);
-- List rooms with capacity >= 3 for family bookings
select * from rooms where capacity>=3;
--- Display the RoomType and Price of only Suite rooms
select roomtype,pricepernight from rooms where roomtype='suite';
-- Payments with Amount between ₹2000 and ₹7000
SELECT *
FROM Payments
WHERE Amount BETWEEN 2000 AND 7000;
-- 7] Insert 5 booking records into the Bookings table
 
-- 78 Display the 3 lowest payments made by customers
select * from payments order by amount asc limit 4;
-- Show each booking’s BookingID with TotalAmount using CONCAT
SELECT CONCAT('BookingID: ', BookingID, ' - Amount: ₹', TotalAmount) AS BookingDetails
FROM Bookings;
-- Show all unique RoomIDs in descending order
select distinct roomid from rooms order by roomid  desc;
-- ] Display each room’s RoomType and Price using CONCAT
SELECT CONCAT(RoomType, ' - ₹', PricePerNight) AS RoomInfo
FROM Rooms;
-- The admin wants to delete all bookings handled by StaffID = 3.
DELETE p from payments p join  bookings b on p.bookingid=b.bookingid
where b.staffid=3;
delete from bookings where staffid=3;

select * from bookings;
-- how customers whose FirstName length > 5
select * from customers where length(firstname)>5;
-- how all unique roles in the hotel
select distinct role from staff;
-- List all rooms with capacity > 2
select * from rooms where capacity>2;
-- Display each payment’s ID with Amount using CONCAT
select concat('paymentid',paymentid,'amount',amount) as paymentinfo from payments;
--- List all Card payments
select * from payments where paymentmethod='card';
-- Delete customers whose Email ends with '@test.com
delete from customers where email like '@test.com';
-- Bookings with CheckOutDate before '2023-12-31'
select * from bookings where checkoutdate<'2023-12-31';
-- Rooms with capacity = 2 (for couples)
select * from rooms where capacity=2;
-- Show all unique capacities in descending order
select distinct capacity from rooms  order by capacity desc;
-- Minimum TotalAmount in bookings
SELECT MIN(TotalAmount) AS MinBookingAmount
FROM Bookings;
---  Display all rooms by capacity ascending
select * from rooms order by capacity asc;
--- BookingID with TotalAmount using CONCAT
SELECT CONCAT('BookingID: ', BookingID, ', TotalAmount: ', TotalAmount) AS BookingInfo
FROM Bookings;
-- Rooms with Capacity = 4 AND PricePerNight > 6000
select * from rooms where capacity=4 and pricepernight>6000;
-- Staff full names combined
select concat(firstname,'',lastname) as fullname  from staff;
-- Bookings with TotalAmount > 10000
select * from bookings where totalamount>10000;
-- nique payment methods in descending order
select distinct paymentmethod from payments order by paymentmethod desc;
-- staff members who share the same Role (Self Join)
select s1.firstname,s1.role from staff s1
join staff s2 on s1.role=s2.role and s1.staffid<>s2.staffid order by s1.role;
-- Customer first name, last name, and TotalAmount of their bookings (JOIN)
select c1.firstname,c1.lastname,b.totalamount from customers c1 join bookings b 
on c1.customerid=b.customerid;
--  Display the first 4 bookings only
select * from bookings limit 4;
-- Question - 102] Show all unique staff first names. 
select distinct firstname from staff;

--- Question - 104] Display each customer’s full name and city using CONCAT_WS. 
SELECT CONCAT_WS(' ', firstname, lastname, city) AS full_info
FROM customers;
---  105] Show all unique cities in descending order from the Customers table.
select * from customers;
select distinct city from customers order by city desc limit 4;
-- The analytics team wants to list all cities where maximum CustomerID is more han 100.
select city from customers where customerid>100;
-- 107] The HR team wants to see staff whose FirstName is 'Priya' for employee recognition. 
show tables;
select  * from staff where firstname='priya';
-- Last 2 staff members
SELECT * 
FROM Staff 
ORDER BY StaffID DESC 
LIMIT 2;
-- Create VIEW BookingSummary
CREATE VIEW BookingSummary AS
SELECT BookingID, CustomerID, RoomID, TotalAmount
FROM Bookings;
-- All unique RoomIDs in descending order
select distinct roomid from rooms  order by roomid desc;
-- Each staff’s role with full name
select role,concat(firstname,'',lastname) as fullname  from staff;
-- 112] Suite rooms under ₹7000 for business travelers

select * from rooms;
select * from rooms where roomtype='suite' and pricepernight<7000;
--- first 3 staff alphabetically by first name
select firstname from staff order by firstname asc limit 3;
select * from staff;
-- All bookings ordered by CheckInDate
select * from bookings order by checkindate asc;
-- 116] Display the first 4 customers’ full names only.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers
LIMIT 4;
select * from staff;
-- 117] All unique room types offered by the hotel
select distinct roomtype from rooms;
-- Phone number of the Waiter only
select phone from staff where role='waiter';
-- All bookings where TotalAmount > 5000
select * from bookings where totalamount>5000;
-- update Role = 'Senior Manager' where StaffID = 12
update staff set role='senior manager'where staffid=12;
-- List all staff working as Managers
select  * from staff where role like  '%manager%';
-- 122] Last 2 registered customers for follow-up
SELECT * 
FROM Customers
ORDER BY CustomerID DESC
LIMIT 2;
SELECT CONCAT('BookingID: ', BookingID, ', TotalAmount: ', TotalAmount) AS BookingInfo
FROM Bookings;
SELECT RoomType, Pricepernight
FROM Rooms
WHERE RoomType = 'Suite';
-- Delete all payments linked to BookingID = 15 
delete from payments where bookingid=15;
-- Display all unique capacities in descending order
select distinct capacity from rooms order by  capacity desc;
SELECT *
FROM Rooms
ORDER BY RoomType ASC
LIMIT 4;
-- ] Payments where Amount < ₹1500 (small transactions
select * from payments where amount<1500;
-- Each booking’s BookingID with TotalAmount using CONCAT
select concat('bookingid: ',bookingid,',totalamount: ',totalamount) as bookingtotal from bookings;
-- Last 2 added rooms from the Rooms table
SELECT *
FROM Rooms
ORDER BY RoomID DESC
LIMIT 2;
-- 132] Customers whose FirstName = 'Amit' AND City = 'Nagpur
SELECT *
FROM Customers
WHERE FirstName = 'Amit' AND City = 'Nagpur';
-- All room details separated by commas using CONCAT_WS
SELECT CONCAT_WS(', ', RoomID, RoomType, Pricepernight, Capacity) AS RoomDetails
FROM Rooms;
-- Display each customer’s name and phone number together using CONCAT
SELECT CONCAT(FirstName, ' ', LastName, ' - ', Phone) AS CustomerInfo
FROM Customers;

-- 137] Display all payment details in one line using CONCAT_WS
SELECT CONCAT_WS(', ', PaymentID, BookingID, PaymentMethod, Amount, PaymentDate) AS PaymentDetails
FROM Payments;

-- 138] Show the last 2 bookings in the table
SELECT *
FROM Bookings
ORDER BY BookingID DESC
LIMIT 2;

-- 139] List all payments ordered by PaymentDate
SELECT *
FROM Payments
ORDER BY PaymentDate ASC;

--- 140] Show the 2 highest payments received
SELECT *
FROM Payments
ORDER BY Amount DESC
LIMIT 2;

-- 141] Customers whose FirstName is 'Rahul'
SELECT *
FROM Customers
WHERE FirstName = 'Rahul';

--- 142] Display each PaymentID with its method using CONCAT
SELECT CONCAT('PaymentID: ', PaymentID, ', Method: ', PaymentMethod) AS PaymentInfo
FROM Payments;

-- 143] List all PaymentMethods used more than 5 times
SELECT PaymentMethod, COUNT(*) AS UsageCount
FROM Payments
GROUP BY PaymentMethod
HAVING COUNT(*) > 5;

-- 144] Show the 2 most expensive rooms for VIP guests
SELECT *
FROM Rooms
ORDER BY Price DESC
LIMIT 2;
-- Display each customer’s name and phone number together using CONCAT
select concat(firstname,'',lastname,'-',phone) as customerinfo  from customers;
-- Display all payment details in one line using CONCAT_WS
select concat_ws(',',paymentid,bookingid,paymentmethod,amount,paymentdate) from payments;
-- Show the last 2 bookings in the table
SELECT *
FROM Bookings
ORDER BY BookingID DESC
LIMIT 2;
select * from payments order by amount desc limit 2;
-- ist all PaymentMethods used more than 5 times
select paymentmethod,count(*) as total from payments group by paymentmethod having count(*)>5;
-- ] Show the 2 most expensive rooms for VIP guests
select * from rooms order by pricepernight desc limit 2;
-- Show all unique first names of customers for a duplicate check
SELECT DISTINCT FirstName
FROM Customers;
-- 148] Find the city where average CustomerID is greater than 50
select city from customers group by city having avg(customerid)>50;
--- Show all unique roles in descending order.
select distinct role from staff order by role desc;
select * from customers;
-- Identify rooms whose Capacity is greater than the average Capacity of all rooms.
select capacity from rooms where Capacity > (select avg(capacity) from rooms);
select * from rooms;
-- Display all rooms by capacity in ascending order.
select capacity from rooms order by capacity asc;
-- Display the first 4 payments only.
select * from payments limit 4;
-- Show each payment’s ID, Method, Amount in one line.
select concat('id: ',paymentid,',method:',paymentmethod,',amount: ',amount) as paymentinfo from payments;
-- List all bookings where TotalAmount > 5000. (Customers subquery)
select * from bookings  where totalamount>5000;
-- 157] Find all customers whose CustomerID is greater than the average CustomerID.
select * from customers where customerid > (select avg(customerid) from customers);
select * from customers;
-- The HR manager wants to see staff whose Role is not 'Chef'.
select * from staff where role <>'chef';
-- The accounts team wants to check bookings where TotalAmount is greater than ₹10,000.
select * from bookings where totalamount>10000;
-- Display each staff’s role with their full name.
select concat(firstname,'',lastname) as fullname,role from staff;
--- 161] List staff members who share the same Role. (Staff self join)

select* from staff;
select s1.firstname,s1.lastname,s2.firstname,s2.lastname,s1.role from staff s1
join staff s2  on s1.role=s2.role where s1.staffid<>s2.staffid;
-- Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments.
select *from customers;
select * from bookings;
select * from payments;
select c1.firstname,c1.lastname,p.amount from customers c1
join bookings b on c1.customerid=b.customerid
join payments p on b.bookingid=p.bookingid;
--- Display all bookings where TotalAmount > 5000.
SELECT *
FROM Bookings
WHERE TotalAmount > 5000;
--- The front desk wants to see customers whose Phone starts with '98'.
select * from customers where phone like '98%';
--- 165] Identify customers who live in the same city. (Customers self join)
select * from customers;
select c1.firstname,c1.lastname,c2.firstname,c2.lastname from customers c1
join customers c2 on c1.city=c2.city and c1.customerid<>c2.customerid;
-- 166] The operations manager wants to check bookings with CheckOutDate before '2023-12-31'.
select * from bookings where checkoutdate<'2023-12-31';
--- 167] Display all unique StaffIDs from the bookings.
select distinct staffid from bookings;
-- Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'.
create view onlinepayments as select * from payments where paymentmethod='online';
-- isplay all unique payment methods in descending order.
SELECT DISTINCT PaymentMethod
FROM Payments
ORDER BY PaymentMethod DESC;
-- Display each payment’s ID with Amount using CONCAT.
SELECT CONCAT('PaymentID: ', PaymentID, ', Amount: ', Amount) AS PaymentDetails
FROM Payments;
-- 171] Show all unique RoomIDs in descending order
select distinct roomid from rooms order by roomid desc;
--- The analytics team wants to list all cities where maximum CustomerID is more than 100.
select city from customers group by city having max(customerid)>100;
--- 173] List staff emails ordered by their roles.
select email,role from staff order by role asc;
--- Find bookings where TotalAmount exceeds the average TotalAmount.
select * from bookings where totalamount>(select avg(totalamount) from bookings);
-- Show all rooms where PricePerNight > ₹5000 for premium customer recommendations.
select * from rooms where pricepernight>5000;
--- Show all unique capacities in descending order.
select distinct capacity from rooms
order by capacity desc;
-- isplay the first 4 rooms sorted alphabetically by RoomType.
SELECT *
FROM Rooms
ORDER BY RoomType ASC
LIMIT 4;
-- ] Show all unique staff first names.
SELECT DISTINCT FirstName
FROM Staff;
-- Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2
select * from rooms where pricepernight>(select max(pricepernight) from rooms where capacity=2);
-- how all unique cities in descending order from the Customers table.
SELECT DISTINCT City
FROM Customers
ORDER BY City DESC;
-- 182] Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
select * from bookings;
select * from customers;
select * from payments;
select c.firstname as customername,p.paymentid,b.bookingid 
from payments p 
join bookings b on p.bookingid=b.bookingid
join customers c on b.customerid=c.customerid
where p.paymentmethod='card';
--- 183] Display each booking’s BookingID with TotalAmount using CONCAT
SELECT CONCAT('Booking ID: ', BookingID, ' - Total Amount: ', TotalAmount) AS BookingDetails
FROM Bookings;
-- Show all bookings handled by StaffID = 2.
select * from bookings  where staffid=2;
-- 185] Display the last 2 added rooms from the Rooms table.
select * from rooms order by roomid desc limit 2;
-- List all rooms where capacity is greater than 2.
select * from rooms where capacity>2;
--- Display the last 2 staff members from the Staff table.
select * from staff order by staffid desc limit 2;
--- Show bookings where CustomerID IN (2, 4, 6, 8).
select * from bookings where customerid in (2,4,6,8);
--- 195] List customers who made more than 5 bookings.
select * from bookings;
select * from customers;
select customerid,count(*) as totalbookings 
from bookings 
group by customerid having count(*)>5;
-- Display all rooms by capacity in ascending order.
select * from rooms order by capacity asc;
--- Show each booking’s BookingID with TotalAmount using CONCAT.

sELECT CONCAT('Booking ID: ', BookingID, ' - Total Amount: ', TotalAmount) AS BookingInfo
FROM Bookings;
-- List all staff working as Managers.
SELECT *
FROM Staff
WHERE Role = 'Manager';
-- 199] Show customers whose FirstName length > 5 characters.
select * from customers where length(firstname)>5;
-- Display all unique capacities in descending order.
select distinct capacity from rooms order by capacity desc;
-- 201] List staff members who share the same Role (Self Join).
select s1.staffid as staff1_id,s1.firstname as staff1_name,
 s2.staffid as staff2_id,s2.firstname as staff2_name,s1.role
 from staff s1
join staff s2 on s1.role=s2.role and s1.staffid<>s2.staffid
order by s1.role;
select * from staff;
-- how PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
select * from payments;
select * from customers;
select * from bookings;
select c.firstname as customername,b.bookingid,p.paymentid from payments p
join bookings b on p.bookingid=b.bookingid
join customers c on b.customerid=c.customerid
where paymentmethod='creditcard';
-- 206] -- 1. Select your database (replace with your DB name)
USE hotelsalesdb;

-- 2. Create Bookings table
CREATE TABLE IF NOT EXISTS Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalAmount DECIMAL(10,2) DEFAULT 0
);

-- 3. Create Payment table
CREATE TABLE IF NOT EXISTS Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- 4. Create trigger: delete payment when booking is deleted
DELIMITER $$

CREATE TRIGGER trg_delete_payment_after_booking
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    DELETE FROM Payment
    WHERE BookingID = OLD.BookingID;
END$$

DELIMITER ;
-- 207
DELIMITER $$
create trigger trg_prevent_invalid_booking
before insert on bookings
for each row
begin
   if new.checkoutdate<checkindate then
   signal sqlstate  '45000'
    SET MESSAGE_TEXT = 'CheckOutDate cannot be earlier than CheckInDate';
   end if; 
end$$
DELIMITER ;
-- 208 
Delimiter $$
create trigger trg_update_total_amount
after insert on payment
for each row
begin
    update bookings
    SET totalamount=totalamount+new.amount
    where bookingid=new.bookingid;
END$$
DELIMITER ;

    







   
   
   
   






