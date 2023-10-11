USE CompAccInc_DWGLENN;

-- Q1
SELECT TOP(5) e.EMPLOYEE_ID, e.FIRST_NAME, SUM(s.quantity * s.unit_price) AS TOTAL_SALES,SUM(s.UNIT_PRICE - s.STANDARD_COST) AS PROFITS, SUM(s.QUANTITY) AS 'Products Sold'
FROM EmployeeDIM e
JOIN SalesFacts s ON e.EMPLOYEE_ID = s.EMPLOYEE_ID
GROUP BY e.EMPLOYEE_ID, e.FIRST_NAME
ORDER BY 4 DESC;

-- Q2
SELECT T.YEAR 'Year', t.QUARTER 'Quarter',SUM(s.QUANTITY) 'Total Units Sold',SUM(s.QUANTITY)- LAG(SUM(s.QUANTITY), 1,0) OVER (ORDER BY T.YEAR, t.Quarter)'Difference in Total Units Sold from Previous Recorded Quarter', SUM(s.UNIT_PRICE - s.STANDARD_COST) 'Profits Generated', SUM(s.UNIT_PRICE - s.STANDARD_COST)- LAG(SUM(s.UNIT_PRICE-s.STANDARD_COST), 1,0) OVER (ORDER BY T.YEAR, t.Quarter) AS 'Difference in Profit From Previous Recorded Quarter'
FROM TimeDIM T, SalesFacts S
WHERE T.TIME_ID = S.TIME_ID 
GROUP BY T.QUARTER, T.YEAR;

-- Q3 
SELECT p.PRODUCT_ID, p.PRODUCT_NAME, STRING_AGG(o.ORDER_ID, ', ') AS 'ORDER_IDs', SUM(s.QUANTITY) 'Outstanding Quantity',SUM(s.QUANTITY * s.STANDARD_COST) 'Outstanding Cost to Fulfil Order'
FROM ProductDIM p, OrderDIM o, SalesFacts s
WHERE s.PRODUCT_ID = p.PRODUCT_ID
AND o.ORDER_ID = s.ORDER_ID
AND o.STATUS = 'Pending'
AND p.QUANTITY is Null
GROUP BY p.PRODUCT_ID, p.PRODUCT_NAME
ORDER BY 5 DESC

-- Q4
SELECT TOP(5) c.NAME, SUM(s.QUANTITY * (s.UNIT_PRICE - s.STANDARD_COST)) 'Total Profit Made from Customer', COUNT(s.ORDER_ID) 'Orders Made'
FROM CustomerDIM c, SalesFacts s
WHERE
c.CUSTOMER_ID IN (
	SELECT CUSTOMER_ID
	FROM SalesFacts
	GROUP BY CUSTOMER_ID
	HAVING SUM(QUANTITY * (UNIT_PRICE - STANDARD_COST)) > AVG(QUANTITY * (UNIT_PRICE - STANDARD_COST))) 
AND c.CUSTOMER_ID = s.CUSTOMER_ID
GROUP BY c.NAME
ORDER BY 2 DESC

-- Q5
SELECT TOP(5) p.product_name 'Product',  ISNULL(p.QUANTITY, 0) 'Stock Remaining', SUM(s.QUANTITY) 'Units Sold',  CONCAT(CONVERT(DECIMAL(12,2),MAX((s.UNIT_PRICE-s.STANDARD_COST)/s.STANDARD_COST*100)),'%') 'Profit Margin'
from ProductDIM p, SalesFacts s
where s.PRODUCT_ID = p.PRODUCT_ID AND
p.QUANTITY is not NULL 
GROUP BY p.PRODUCT_ID, p.product_name, p.QUANTITY
ORDER BY 3 ASC