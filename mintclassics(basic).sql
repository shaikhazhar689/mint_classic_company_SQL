SELECT firstName, lastName 
FROM employees;
  
SELECT DISTINCT country 
FROM customers;

SELECT DISTINCT city,state 
FROM customers
WHERE country = 'USA';

SELECT orderNumber, productCode, quantityOrdered * priceEach AS value
FROM orderdetails;

SELECT DISTINCT state, city 
FROM customers
WHERE country = 'USA'
ORDER BY state DESC, city;

SELECT customerName, creditLimit 
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;

SELECT lastName, firstName, jobTitle
FROM employees
WHERE jobTitle = 'Sales Rep';

SELECT lastName, firstName, jobTitle
FROM employees
WHERE jobTitle != 'Sales Rep';

SELECT customername, state, creditlimit 
FROM customers 
WHERE state = 'CA' AND creditlimit > 100000;

SELECT customerName, country
FROM customers
WHERE country = 'USA' OR country =  'FRANCE';

SELECT customerName, country, creditLimit
FROM customers
WHERE country = 'USA' OR country =  'FRANCE' AND creditLimit > 100000;

SELECT customerName, country
FROM customers
WHERE country IN ('France', 'USA', 'Australia');

SELECT customerName, country
FROM customers
WHERE country NOT IN ('France','USA', 'Australia');

SELECT productName
FROM products
WHERE productName REGEXP 'Ford';