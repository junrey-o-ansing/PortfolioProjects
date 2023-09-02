SELECT Age, Gender, COUNT(Name)
FROM customer_demographics
GROUP BY Age, Gender
ORDER BY Age

SELECT DISTINCT(Gender)
FROM customer_demographics

SELECT *
FROM customer_demographics
WHERE GENDER IN ('Andy', 'Unknown')

SELECT Location, COUNT(Name)
FROM customer_demographics
GROUP BY Location

SELECT *
FROM product_details

SELECT *
FROM sales_transactions
ORDER BY 7 DESC, 5 DESC


SELECT *
FROM customer_demographics as cd
INNER JOIN sales_transactions as st
ON cd.CustomerID = st.CustomerID
ORDER BY st.TotalSalesAmount DESC, st.QuantitySold DESC

SELECT *
FROM product_details as pd
INNER JOIN sales_transactions as st
ON pd.ProductID = st.ProductID
ORDER BY pd.ProductID, st.TotalSalesAmount DESC, st.QuantitySold DESC

