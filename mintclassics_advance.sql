-- Say we want to list the name of every employee from the employees table who has one or more 
-- customers recorded in the customers table.

SELECT employees.employeeNumber, employees.lastName, employees.firstName, customers.customerName
FROM employees INNER JOIN customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
ORDER BY lastName, customerName;

-- Say that we wanted to list every customer from the customers table who has one or more orders in the orders table.

SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers AS c INNER JOIN orders AS o
USING (customerNumber)
ORDER BY customerName;

 -- We wanted to see names of all customers and their order information, even if they don’t have any orders?
 
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM  customers AS c LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber
ORDER BY customerName;

-- Say we want to list the name of every employee from the employees table, and every customer from the customers table.
-- Where possible, we want to match the name of each employee to his/her customers. However we also want to return 
-- the names of all employees without customers, and the names of all customers without an associated employee.
-- This is an example of a full join.

SELECT e.lastName, e.firstName, c.customerName 
FROM employees AS e LEFT JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber
UNION
SELECT e.lastName, e.firstName, c.customerName 
FROM employees AS e RIGHT JOIN customers AS c 
ON e.employeeNumber = c.salesRepEmployeeNumber;

SELECT orderNumber, SUM(quantityOrdered * priceEach) AS value
FROM orderdetails
GROUP BY orderNumber;

-- Say we wanted to find the total value of orders in each year, where the order has been shipped.

SELECT YEAR(orderDate) AS year, SUM(quantityOrdered * priceEach) AS value
FROM orders INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'Shipped'
GROUP BY YEAR(orderDate);

-- Say we want to show all order numbers in which more than 650 individual items were ordered.
-- This requires us to group by order number (orderNumber) from the orderdetails table, and to filter the result
-- based on the total quantity of products in each order.

SELECT orderNumber, sum(quantityOrdered) as quantity
FROM orderdetails
GROUP BY orderNumber
HAVING sum(quantityOrdered) > 650
ORDER BY quantity DESC;


-- Assume we want to find customers with an average order value over $3,800, for orders that have been shipped.

SELECT a.customerName, b.status, avg(c.quantityOrdered * c.priceEach) as avg_value
FROM customers a 
INNER JOIN orders b 
USING (customerNumber)
INNER JOIN orderdetails c 
USING (orderNumber)
GROUP BY customerName, status
HAVING avg_value > 3800 AND status = 'Shipped'
ORDER BY avg_value DESC;

-- We use a subquery find customers whose payments are greater than the average payment.

SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > 
 (SELECT AVG(amount)
  FROM payments);

 -- We use a subquery to create the derived table called ‘itemcount’. This counts the number of items 
 -- in each order (‘items’).
 
 SELECT max(items), min(items), floor(avg(items))
FROM ( 
  SELECT 
    orderNumber, count(orderNumber) as items
  FROM orderdetails
  GROUP BY orderNumber) as itemcount;
  
-- Say we want to select products with a buy price that is greater than the average buy price for its product line.

SELECT productname, buyprice
FROM products as p1
WHERE buyprice >
  (SELECT avg(buyprice)
  FROM products
  WHERE productLine = p1.productLine);
  
  -- This time we create the temporary table called ‘itemcount’ using the WITH clause. 
  -- We then select the relevant information from this CTE
  
  WITH itemcount AS (
   SELECT orderNumber, count(orderNumber) as items
   FROM orderdetails
   GROUP BY orderNumber)
SELECT max(items), min(items), floor(avg(items))
FROM itemcount;

-- Product quantity in stock available with different warehouses

SELECT warehouses.warehouseName, Sum(products.quantityInStock)
FROM warehouses INNER JOIN products ON warehouses.warehouseCode = products.warehouseCode
Group By warehouses.warehouseName;