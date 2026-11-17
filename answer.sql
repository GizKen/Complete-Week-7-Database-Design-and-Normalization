
-- =====================================================
-- WEEK 7 ASSIGNMENT: DATABASE DESIGN AND NORMALIZATION
-- =====================================================


-- =====================================================
-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)
-- =====================================================

-- Step 1: Create the original ProductDetail table

CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Step 2: Insert the original records

INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 3: Create a new normalized table
-- Each row will contain only one product per order.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

-- Step 4: Insert normalized records

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Step 5: Display the normalized table

SELECT * FROM ProductDetail_1NF;


-- =====================================================
-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)
-- =====================================================

-- Step 1: Create the original OrderDetails table

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Step 2: Insert the original records

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 3: Identify the partial dependency
--
-- OrderID -> CustomerName
--
-- CustomerName depends only on OrderID
-- and not on the entire composite key
-- (OrderID, Product).
--
-- Therefore, the table violates 2NF.

-- Step 4: Create the Orders table
-- This table stores order information.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL
);

-- Step 5: Create the OrderItems table
-- This table stores products and quantities.

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 6: Insert records into the Orders table

INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 7: Insert records into the OrderItems table

INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Step 8: Display the normalized Orders table

SELECT * FROM Orders;

-- Step 9: Display the normalized OrderItems table

SELECT * FROM OrderItems;

-- Step 10: Display combined order information
-- using an INNER JOIN.

SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
INNER JOIN OrderItems
ON Orders.OrderID = OrderItems.OrderID;
