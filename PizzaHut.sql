CREATE DATABASE PizzaHut;

USE PizzaHut;

CREATE TABLE Customer
(
	Customer_ID VARCHAR(10) CHECK(Customer_ID LIKE 'C%') PRIMARY KEY,
	Name VARCHAR(25) NOT NULL,
	address1 VARCHAR(15),
	address2 VARCHAR(15),
	address3 VARCHAR(15)
);

CREATE TABLE Customer_Phone
(
	Customer_ID VARCHAR(10),
	Phone_number VARCHAR(15),
	PRIMARY KEY(Customer_ID, Phone_number),
	CONSTRAINT fk_CusPhoCus FOREIGN KEY(Customer_ID) REFERENCES Customer
);

CREATE TABLE Orders
(
	Order_ID VARCHAR(10) CHECK(Order_ID LIKE 'O%') PRIMARY KEY,
	Order_date VARCHAR(15) NOT NULL,
	total_amount FLOAT NOT NULL,
	status VARCHAR(10),
	Customer_ID VARCHAR(10) NOT NULL,
	Cashier_ID VARCHAR(10) NOT NULL,
	Payment_ID VARCHAR(10) NOT NULL,
	CONSTRAINT fk_OrdCus FOREIGN KEY(Customer_ID) REFERENCES Customer,
	CONSTRAINT fk_OrdCash FOREIGN KEY(Cashier_ID) REFERENCES Employee,
	CONSTRAINT fk_OrdPay FOREIGN KEY(Payment_ID) REFERENCES Payment
);

CREATE TABLE Order_Item
(
	Order_Item_ID VARCHAR(10) CHECK(Order_Item_ID LIKE 'OI%') PRIMARY KEY,
	Size VARCHAR(8),
	Crust_type VARCHAR(10),
	Spice_level VARCHAR(10),
	Quantity INTEGER NOT NULL,
	Item_ID VARCHAR(10) NOT NULL,
	Chef_ID VARCHAR(10),
	CONSTRAINT fk_OrdItMenIt FOREIGN KEY(Item_ID) REFERENCES Menu_Item,
	CONSTRAINT fk_OrdItEmp FOREIGN KEY(Chef_ID) REFERENCES Employee
);

CREATE TABLE Order_Item_Orders
(
	Order_ID VARCHAR(10),
	Order_Item_ID VARCHAR(10),
	PRIMARY KEY(Order_ID, Order_Item_ID),
	CONSTRAINT fk_OrdItOrdOrd FOREIGN KEY(Order_ID) REFERENCES Orders,
	CONSTRAINT fk_OrdItOrdOrdIt FOREIGN KEY(Order_Item_ID) REFERENCES Order_Item
);

CREATE TABLE Ingredients
(
	Ingredient_ID VARCHAR(10) CHECK(Ingredient_ID LIKE 'I%') PRIMARY KEY,
	Name VARCHAR(15) NOT NULL,
	Amount FLOAT,
	Measuring_Unit VARCHAR(8),
	Supplier_ID VARCHAR(10),
	Stock_ID VARCHAR(10),
	CONSTRAINT fk_IngSup FOREIGN KEY(Supplier_ID) REFERENCES Supplier,
	CONSTRAINT fk_IngSto FOREIGN KEY(Stock_ID) REFERENCES Stock
);

CREATE TABLE Menu_Item_Ingredient
(
	Item_ID VARCHAR(10),
	Ingredient_ID VARCHAR(10),
	PRIMARY KEY(Item_ID, Ingredient_ID),
	CONSTRAINT fk_MenItInMenIt FOREIGN KEY(Item_ID) REFERENCES Menu_Item,
	CONSTRAINT fk_MenItInIn FOREIGN KEY(Ingredient_ID) REFERENCES Ingredients
);

CREATE TABLE Supplier
(
	Supplier_ID VARCHAR(10) CHECK(Supplier_ID LIKE 'S%') PRIMARY KEY,
	Supplier_Name VARCHAR(20) NOT NULL,
	address1 VARCHAR(15),
	address2 VARCHAR(15),
	address3 VARCHAR(15)
);

CREATE TABLE Supplier_phone
(
	Supplier_ID VARCHAR(10),
	Phone_number VARCHAR(15),
	PRIMARY KEY(Supplier_ID, Phone_number),
	CONSTRAINT fk_SupPhoSup FOREIGN KEY(Supplier_ID) REFERENCES Supplier
);

CREATE TABLE Stock
(
	Stock_ID VARCHAR(10) CHECK(Stock_ID LIKE 'ST%') PRIMARY KEY,
	Stock_Name VARCHAR(15) NOT NULL,
	Quantity VARCHAR(8),
	Last_updated DATETIME
);

CREATE TABLE Discount
(
	Discount_ID VARCHAR(10) CHECK(Discount_ID LIKE 'DI%') PRIMARY KEY,
	Discount_Name VARCHAR(15),
	Discount_type VARCHAR(15),
	Discount_value VARCHAR(8),
	Start_date DATE,
	End_sate DATE
);

CREATE TABLE Order_Item_Discount
(
	Order_Item_ID VARCHAR(10),
	Discount_ID VARCHAR(10),
	PRIMARY KEY(Order_Item_ID, Discount_ID),
	CONSTRAINT fk_OrdItDisOrdIt FOREIGN KEY(Order_Item_ID) REFERENCES Order_Item,
	CONSTRAINT fk_OrdItDisDis FOREIGN KEY(Discount_ID) REFERENCES Discount
);

CREATE TABLE Menu_Item
(
	Item_ID VARCHAR(10) CHECK(Item_ID LIKE 'MI%') PRIMARY KEY,
	Name VARCHAR(15) NOT NULL,
	Category VARCHAR(10),
	Price FLOAT,
	Description VARCHAR(40),
	Availability VARCHAR(8),
);

CREATE TABLE Employee
(
	Employee_ID VARCHAR(10) CHECK(Employee_ID LIKE 'E%') PRIMARY KEY,
	Name VARCHAR(25) NOT NULL,
	address1 VARCHAR(15),
	address2 VARCHAR(15),
	address3 VARCHAR(15),
	Position VARCHAR(12) NOT NULL,
	Salary FLOAT NOT NULL,
	Contract_type VARCHAR(10),
	Joined_date DATE,
	Experience VARCHAR(15),
	Manager_ID VARCHAR(10),
	Liscence_Number VARCHAR(20),
	CONSTRAINT fk_EmpRec FOREIGN KEY(Manager_ID) REFERENCES Employee
);

CREATE TABLE Employee_Phone
(
	Employee_ID VARCHAR(10),
	Phone_number VARCHAR(15),
	PRIMARY KEY(Employee_ID, Phone_number),
	CONSTRAINT fk_EmpPhoEmp FOREIGN KEY(Employee_ID) REFERENCES Employee
);

CREATE TABLE Delivery
(
	Delivery_ID VARCHAR(10) CHECK(Delivery_ID LIKE 'DE%') PRIMARY KEY,
	Delivery_date DATE NOT NULL,
	Delivery_fee FLOAT,
	Order_ID VARCHAR(10),
	Vehicle_ID VARCHAR(10),
	Delivery_driver_ID VARCHAR(10),
	CONSTRAINT fk_DelOrd FOREIGN KEY(Order_ID) REFERENCES Orders,
	CONSTRAINT fk_DelVehi FOREIGN KEY(Vehicle_ID) REFERENCES Vehicle,
	CONSTRAINT fk_DelEmp FOREIGN KEY(Delivery_driver_ID) REFERENCES Employee
);

CREATE TABLE Vehicle
(
	Vehicle_ID VARCHAR(10) CHECK(Vehicle_ID LIKE 'V%') PRIMARY KEY,
	Number_Plate VARCHAR(15) UNIQUE NOT NULL,
	Name VARCHAR(20)
);

CREATE TABLE Payment
(
	Payment_ID VARCHAR(10) CHECK(Payment_ID LIKE 'P%') PRIMARY KEY,
	Payment_date DATE NOT NULL,
	Payment_amount FLOAT NOT NULL,
	Payment_method VARCHAR(10)
);

--Inserting ingredients to stock and update the stock date
INSERT INTO Stock VALUES
('ST001', 'Cheese Stock', '100', '2025-07-01'),
('ST002', 'Meat Stock', '70', '2025-07-01'),
('ST003', 'Vegetable Stock', '150', '2025-07-01'),
('ST004', 'Drink Stock', '200', '2025-07-01'),
('ST005', 'Dessert Stock', '80', '2025-07-01'),
('ST006', 'Sauce Stock', '90', '2025-07-01'),
('ST007', 'Spice Stock', '60', '2025-07-01'),
('ST008', 'Bread Stock', '50', '2025-07-01'),
('ST009', 'Tea Stock', '75', '2025-07-01'),
('ST010', 'Oil Stock', '40', '2025-07-01');

--Inserting suppliers to the table with details
INSERT INTO Supplier VALUES
('S001', 'DairyFresh', 'No.12', 'Main Street', 'Colombo'),
('S002', 'MeatHouse', 'No.45', 'River Rd', 'Kandy'),
('S003', 'FreshVeg', 'No.32', 'Lake Rd', 'Galle'),
('S004', 'SpiceMart', 'No.20', 'Hill Street', 'Matara'),
('S005', 'SweetLand', 'No.50', 'Ocean View', 'Negombo'),
('S006', 'BreadCo', 'No.11', 'Park Lane', 'Jaffna'),
('S007', 'SoftDrinks', 'No.77', 'Beachside', 'Kalutara'),
('S008', 'ChillBev', 'No.99', 'Sunset Blvd', 'Nuwara Eliya'),
('S009', 'FarmFresh', 'No.22', 'Garden Ave', 'Kurunegala'),
('S010', 'VegieMart', 'No.66', 'Mountain Rd', 'Badulla');

--Inserting cars to the table with details
INSERT INTO Vehicle VALUES
('V001', 'SP ABC1234', 'Bike'),
('V002', 'WP DEF5678', 'Scooter'),
('V003', 'SP GHI9012', 'Car'),
('V004', 'WP JKL3456', 'Van'),
('V005', 'SP MNO7890', 'Bike'),
('V006', 'WP PQR2345', 'Scooter'),
('V007', 'CP STU6789', 'Car'),
('V008', 'WP VWX0123', 'Bike'),
('V009', 'EP YZA4567', 'Van'),
('V010', 'NP BCD8901', 'Scooter');

--Inserting discounts with details
INSERT INTO Discount VALUES
('DI001', 'New Year', 'Percentage', '10', '2025-01-01', '2025-01-31'),
('DI002', 'Christmas', 'Percentage', '15', '2025-12-01', '2025-12-31'),
('DI003', 'Vesak', 'Flat', '200', '2025-05-01', '2025-05-10'),
('DI004', 'Avurudu', 'Flat', '150', '2025-04-13', '2025-04-15'),
('DI005', 'Summer', 'Percentage', '5', '2025-06-01', '2025-06-30'),
('DI006', 'PoyaDay', 'Flat', '100', '2025-07-06', '2025-07-06'),
('DI007', 'Independence', 'Percentage', '20', '2025-02-04', '2025-02-04'),
('DI008', 'Student', 'Flat', '50', '2025-03-01', '2025-03-31'),
('DI009', 'Loyalty', 'Percentage', '8', '2025-10-01', '2025-10-31'),
('DI010', 'Valentine', 'Flat', '250', '2025-02-14', '2025-02-14');

--Inserting employees to the table with their details
INSERT INTO Employee VALUES
('E001', 'Saman Perera', 'Colombo', 'Colombo 07', 'Western', 'Chef', 50000, 'Full-time', '2020-01-01', '5 years', NULL, NULL),
('E002', 'Thilini Fernando', 'Galle', 'Galle Fort', 'Southern', 'Cashier', 40000, 'Part-time', '2021-03-10', '3 years', 'E001', NULL),
('E003', 'Nihal Gunawardena', 'Kandy', 'Peradeniya', 'Central', 'Manager', 65000, 'Full-time', '2018-06-05', '7 years', NULL, NULL),
('E004', 'Ashen Jayasekara', 'Matara', 'Walgama', 'Southern', 'Delivery', 35000, 'Full-time', '2022-08-01', '2 years', 'E003', 'LIC789'),
('E005', 'Nimal Warnakula', 'Kurunegala', 'Kurunegala', 'North Western', 'Chef', 48000, 'Full-time', '2019-10-15', '6 years', 'E003', NULL),
('E006', 'Kusal Madushanka', 'Jaffna', 'Nallur', 'Northern', 'Cashier', 39000, 'Part-time', '2023-02-20', '1 year', 'E003', NULL),
('E007', 'Nirmali Silva', 'Negombo', 'Negombo Town', 'Western', 'Cleaner', 28000, 'Contract', '2024-04-18', '3 months', 'E003', NULL),
('E008', 'Vimukthi Senanayake', 'Galle', 'Hikkaduwa', 'Southern', 'Chef', 47000, 'Full-time', '2020-12-01', '4 years', 'E003', NULL),
('E009', 'Dulanga Jayawardena', 'Kandy', 'Katugastota', 'Central', 'Admin', 42000, 'Full-time', '2020-07-22', '4 years', 'E003', NULL),
('E010', 'Tharindu Wijesekara', 'Colombo', 'Borella', 'Western', 'Delivery', 35000, 'Full-time', '2022-10-10', '2 years', 'E003', 'LIC321');

--Inserting customers to the table with the details
INSERT INTO Customer VALUES
('C001', 'Thineth Geevinda', 'No.12', 'Kamburupitiya', 'Matara'),
('C002', 'Sachiru Bhanuka', 'No.5', 'Gandara', 'Matara'),
('C003', 'Amry Ahamed', 'No.23', 'Wellawatta', 'Colombo'),
('C004', 'Lamindu Tashan', 'No.8', 'Palatuwa', 'Matara'),
('C005', 'Gayan Silva', 'No.99', 'Ocean View', 'Negombo'),
('C006', 'Jayaneth Fernando', 'No.11', 'Park Lane', 'Jaffna'),
('C007', 'Vihanga Senadhi', 'No.55', 'Lake Road', 'Kurunegala'),
('C008', 'Hirusha Perera', 'No.42', 'Beachside', 'Galle'),
('C009', 'Irusha Madushan', 'No.14', 'Horton Plains', 'Nuwara Eliya'),
('C010', 'Chamath Jayalath', 'No.77', 'Sunset Blvd', 'Kandy');

--Insert values to the payment table with the details
INSERT INTO Payment VALUES
('P001', '2025-07-01', 3500, 'Cash'),
('P002', '2025-07-01', 1800, 'Card'),
('P003', '2025-07-02', 4200, 'Cash'),
('P004', '2025-07-02', 2600, 'Online'),
('P005', '2025-07-03', 5100, 'Card'),
('P006', '2025-07-03', 3000, 'Cash'),
('P007', '2025-07-04', 3900, 'Online'),
('P008', '2025-07-04', 2700, 'Cash'),
('P009', '2025-07-05', 6000, 'Card'),
('P010', '2025-07-05', 2100, 'Online');

--Inserting menu items to the table with the details
INSERT INTO Menu_Item VALUES
('MI001', 'Pepperoni Pizza', 'Pizza', 1500, 'Spicy pepperoni pizza', 'Yes'),
('MI002', 'Veggie Pizza', 'Pizza', 1300, 'Fresh vegetable pizza', 'Yes'),
('MI003', 'Cheese Pizza', 'Pizza', 1400, 'Extra cheese pizza', 'Yes'),
('MI004', 'Chicken Wings', 'Side', 900, 'Crispy chicken wings', 'Yes'),
('MI005', 'Garlic Bread', 'Side', 600, 'Garlic flavored bread', 'Yes'),
('MI006', 'Coke', 'Drink', 300, 'Chilled Coca-Cola', 'Yes'),
('MI007', 'Sprite', 'Drink', 300, 'Refreshing Sprite', 'Yes'),
('MI008', 'Brownie', 'Dessert', 500, 'Chocolate brownie', 'Yes'),
('MI009', 'Iced Tea', 'Drink', 350, 'Cold iced tea', 'Yes'),
('MI010', 'Tandoori Pizza', 'Pizza', 1600, 'Indian style tandoori pizza', 'Yes');

--Inserting values to stock table with ingredients
INSERT INTO Ingredients VALUES
('I001', 'Cheese', 50, 'kg', 'S001', 'ST001'),
('I002', 'Pepperoni', 30, 'kg', 'S002', 'ST002'),
('I003', 'Tomato Sauce', 40, 'ltr', 'S003', 'ST006'),
('I004', 'Onion', 20, 'kg', 'S003', 'ST003'),
('I005', 'Chicken', 25, 'kg', 'S002', 'ST002'),
('I006', 'Garlic', 10, 'kg', 'S004', 'ST007'),
('I007', 'Bread', 60, 'pcs', 'S006', 'ST008'),
('I008', 'Coke', 100, 'bottle', 'S007', 'ST004'),
('I009', 'Brownie Mix', 15, 'kg', 'S005', 'ST005'),
('I010', 'Tea Leaves', 35, 'kg', 'S009', 'ST009');

--Set menu items with their ingredients
INSERT INTO Menu_Item_Ingredient VALUES
('MI001', 'I001'),
('MI001', 'I002'),
('MI001', 'I003'),
('MI002', 'I003'),
('MI002', 'I004'),
('MI003', 'I001'),
('MI004', 'I005'),
('MI005', 'I006'),
('MI008', 'I009'),
('MI009', 'I010');

--Employee phone numbers
INSERT INTO Employee_Phone VALUES
('E001', '0711234567'),
('E002', '0722345678'),
('E003', '0733456789'),
('E004', '0744567890'),
('E005', '0755678901'),
('E006', '0766789012'),
('E007', '0777890123'),
('E008', '0788901234'),
('E009', '0799012345'),
('E010', '0700123456');

--Customer phone numbers
INSERT INTO Customer_Phone VALUES
('C001', '0771234567'),
('C001', '0711234567'),
('C002', '0772345678'),
('C003', '0773456789'),
('C003', '0702345678'),
('C004', '0774567890'),
('C005', '0775678901'),
('C006', '0776789012'),
('C007', '0777890123'),
('C007', '0717890123');

--Supplier phone numbers
INSERT INTO Supplier_phone VALUES
('S001', '0112233445'),
('S002', '0813456789'),
('S003', '0912345678'),
('S004', '0414567890'),
('S005', '0315678901'),
('S006', '0216789012'),
('S007', '0717890123'),
('S008', '0518901234'),
('S009', '0619012345'),
('S010', '0110123456');

--Orders table that handle the orders
INSERT INTO Orders VALUES
('O001', '2025-07-01', 3500, 'Paid', 'C001', 'E002', 'P001'),
('O002', '2025-07-01', 1800, 'Paid', 'C002', 'E006', 'P002'),
('O003', '2025-07-02', 4200, 'Pending', 'C003', 'E002', 'P003'),
('O004', '2025-07-02', 2600, 'Paid', 'C004', 'E003', 'P004'),
('O005', '2025-07-03', 5100, 'Paid', 'C005', 'E006', 'P005'),
('O006', '2025-07-03', 3000, 'Cancelled', 'C006', 'E004', 'P006'),
('O007', '2025-07-04', 3900, 'Paid', 'C007', 'E002', 'P007'),
('O008', '2025-07-04', 2700, 'Paid', 'C008', 'E003', 'P008'),
('O009', '2025-07-05', 6000, 'Paid', 'C009', 'E004', 'P009'),
('O010', '2025-07-05', 2100, 'Pending', 'C010', 'E006', 'P010');

--Order Item table defines how they want the order
INSERT INTO Order_Item VALUES
('OI001', 'Large', 'Thin', 'Mild', 2, 'MI001', 'E001'),
('OI002', 'Medium', 'Thick', 'Hot', 1, 'MI002', 'E005'),
('OI003', 'Regular', NULL, NULL, 3, 'MI004', 'E001'),
('OI004', 'Large', 'Thin', 'Medium', 2, 'MI003', 'E005'),
('OI005', NULL, NULL, NULL, 5, 'MI005', 'E001'),
('OI006', NULL, NULL, NULL, 2, 'MI006', NULL),
('OI007', NULL, NULL, NULL, 3, 'MI009', NULL),
('OI008', 'Large', 'Stuffed', 'Hot', 1, 'MI010', 'E005'),
('OI009', NULL, NULL, NULL, 4, 'MI008', NULL),
('OI010', NULL, NULL, NULL, 2, 'MI007', NULL);

--This table keeps track of the items in a order
INSERT INTO Order_Item_Orders VALUES
('O001', 'OI001'),
('O001', 'OI002'),
('O002', 'OI003'),
('O003', 'OI004'),
('O003', 'OI005'),
('O004', 'OI006'),
('O005', 'OI007'),
('O006', 'OI008'),
('O007', 'OI009'),
('O008', 'OI010');

--This table tracks are there discounts for the ordered items
INSERT INTO Order_Item_Discount VALUES
('OI001', 'DI001'),
('OI002', 'DI002'),
('OI003', 'DI007'),
('OI004', 'DI003'),
('OI005', 'DI001'),
('OI006', 'DI008'),
('OI007', 'DI004'),
('OI008', 'DI002'),
('OI009', 'DI005'),
('OI010', 'DI006');

--This tables the data of a delivery 
INSERT INTO Delivery VALUES
('DE001', '2025-07-01', 300, 'O001', 'V001', 'E004'),
('DE002', '2025-07-01', 250, 'O002', 'V002', 'E010'),
('DE003', '2025-07-02', 400, 'O003', 'V003', 'E004'),
('DE004', '2025-07-02', 200, 'O004', 'V001', 'E010'),
('DE005', '2025-07-03', 350, 'O005', 'V004', 'E004'),
('DE006', '2025-07-03', 300, 'O006', 'V005', 'E010'),
('DE007', '2025-07-04', 400, 'O007', 'V006', 'E004'),
('DE008', '2025-07-04', 250, 'O008', 'V007', 'E010'),
('DE009', '2025-07-05', 450, 'O009', 'V008', 'E004'),
('DE010', '2025-07-05', 200, 'O010', 'V009', 'E010');

--SELECT QUERIES----------------------------------------------------------------------------

--1.List the chefs with their salaries
SELECT Employee_ID, Name, Salary FROM Employee WHERE Position = 'Chef';

--2.List all the pizzas with their prices
SELECT Name, Price FROM Menu_Item WHERE Category = 'Pizza';

--3.Discounts for the christmas 
SELECT * FROM Discount WHERE Discount_Name = 'Christmas';

--4.Which supplliers provide the ingredients
SELECT i.Name AS Ingredient, s.Supplier_Name AS Supplier FROM Ingredients i, Supplier s WHERE i.Supplier_ID = s.Supplier_ID;

-- 5.Which orders have been paid and which employee handled them?
SELECT o.Order_ID, o.status, e.Name AS Cashier
FROM Orders o, Employee e 
WHERE o.Cashier_ID = e.Employee_ID AND o.status = 'Paid';

--ADVANCE QUERIES--------------------------------------------------------------------------------------------------
-- 1. What are the total sales per day, ordered from highest to lowest sales?
SELECT Order_date, SUM(total_amount) AS Daily_Sales
FROM Orders
GROUP BY Order_date
ORDER BY Daily_Sales DESC;

-- 2. What is the total number of deliveries done by each driver?
SELECT e.Name, COUNT(d.Delivery_ID) AS Total_Deliveries
FROM Employee e, Delivery d
WHERE d.Delivery_driver_ID = e.Employee_ID
GROUP BY e.Name;

-- 3. How many ingredients supplied by a supplier?
SELECT s.Supplier_Name, COUNT(i.Ingredient_ID) AS Ingredient_Count
FROM Supplier s, Ingredients i
WHERE s.Supplier_ID = i.Supplier_ID
GROUP BY s.Supplier_Name;

--4.Average salary of Employees by job
SELECT Position AS Job_Role, AVG(Salary) AS Average_Salary
FROM Employee
GROUP BY Position

--5. Which menu categories have the highest number of items?
SELECT Category, COUNT(Item_ID) AS Item_Count
FROM Menu_Item
GROUP BY Category
ORDER BY Item_Count DESC;

--Join_Tables---------------------------------------------------------------
--1.How much of ingredients left in the stock
SELECT i.Name, s.Quantity, i.Measuring_Unit
FROM Ingredients i
JOIN Stock s ON i.Stock_ID = s.Stock_ID;

-- 2. Show each order item with its menu item name and the chef who prepared it
SELECT oi.Order_Item_ID, mi.Name AS Menu_Item, e.Name AS Chef_Name
FROM Order_Item oi
JOIN Menu_Item mi ON oi.Item_ID = mi.Item_ID
LEFT JOIN Employee e ON oi.Chef_ID = e.Employee_ID;

-- 3. List all deliveries with the vehicle used and the driver’s name
SELECT d.Delivery_ID, v.Number_Plate AS Vehicle, e.Name AS Driver_Name, d.Delivery_fee
FROM Delivery d
JOIN Vehicle v ON d.Vehicle_ID = v.Vehicle_ID
JOIN Employee e ON d.Delivery_driver_ID = e.Employee_ID;


--Adding_Security----------------------------------------------------------------------------
-- Admin user: Full access
CREATE LOGIN E012_user WITH PASSWORD = 'Thineth@123';
CREATE USER E012_user FOR LOGIN E012_user;
ALTER ROLE db_owner ADD MEMBER E012_user;

-- Manager user: Can read and update orders, customers, and employees
CREATE LOGIN E011_user WITH PASSWORD = 'Vihanga@123';
CREATE USER E011_user FOR LOGIN E011_user;
GRANT SELECT, UPDATE ON Orders TO E011_user;
GRANT SELECT, UPDATE ON Customer TO E011_user;
GRANT SELECT, UPDATE ON Employee TO E011_user;

-- Cashier user: Can only read and insert orders, and read menu items
CREATE LOGIN E013_user WITH PASSWORD = 'Bhanuka@123';
CREATE USER E013_user FOR LOGIN E013_user;
GRANT SELECT, INSERT ON Orders TO E013_user;
GRANT SELECT ON Menu_Item TO E013_user;

-- Chef user: Can read menu items, ingredients, and order items
CREATE LOGIN E014_user WITH PASSWORD = 'Lamindu@123';
CREATE USER E014_user FOR LOGIN E014_user;
GRANT SELECT ON Menu_Item TO E014_user;
GRANT SELECT ON Ingredients TO E014_user;
GRANT SELECT ON Order_Item TO E014_user;

-- Delivery user: Can read deliveries, orders, and vehicles
CREATE LOGIN E015_user WITH PASSWORD = 'Amry@123';
CREATE USER E015_user FOR LOGIN E015_user;
GRANT SELECT ON Delivery TO E015_user;
GRANT SELECT ON Orders TO E015_user;
GRANT SELECT ON Vehicle TO E015_user;

