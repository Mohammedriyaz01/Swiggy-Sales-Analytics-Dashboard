CREATE DATABASE IF NOT EXISTS swiggy_analysis;

USE swiggy_analysis;

CREATE TABLE IF NOT EXISTS orders (
    Order_Date DATE,
    City VARCHAR(50),
    State VARCHAR(50),
    Dish_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price_INR FLOAT,
    Rating FLOAT,
    Rating_Count INT,
    Restaurant_Name VARCHAR(50)
);

-- View first 5 rows
SELECT * FROM orders
LIMIT 5;

-- Total Revenue
SELECT SUM(Price_INR) AS Total_Revenue
FROM orders;

-- Total Orders
SELECT COUNT(*) AS Total_Orders
FROM orders;

-- Average Rating
SELECT AVG(Rating) AS Avg_Rating
FROM orders;

-- Top 5 Cities by Revenue
SELECT
    City,
    SUM(Price_INR) AS Revenue
FROM orders
GROUP BY City
ORDER BY Revenue DESC
LIMIT 5;

-- State-wise Revenue
SELECT
    State,
    SUM(Price_INR) AS Revenue
FROM orders
GROUP BY State
ORDER BY Revenue DESC;

-- Monthly Revenue Trend
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    SUM(Price_INR) AS Revenue
FROM orders
GROUP BY Month
ORDER BY Month;

-- Weekly Trend Analysis
SELECT
    DAYNAME(Order_Date) AS DayName,
    SUM(Price_INR) AS Revenue
FROM orders
GROUP BY DayName;

-- Top Selling Food Items
SELECT
    Dish_Name,
    SUM(Quantity) AS Total_Quantity
FROM orders
GROUP BY Dish_Name
ORDER BY Total_Quantity DESC
LIMIT 10;

-- Payment Method Analysis
SELECT
    Payment_Method,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Payment_Method;

-- Veg vs Non-Veg Analysis
SELECT
    CASE
        WHEN LOWER(Dish_Name) REGEXP 'chicken|fish|mutton|egg|prawn|biryani|kebab'
        THEN 'Non-Veg'
        ELSE 'Veg'
    END AS Food_Category,
    SUM(Price_INR) AS Revenue
FROM orders
GROUP BY Food_Category;

-- Quarterly Performance
SELECT
    CONCAT(YEAR(Order_Date), '-Q', QUARTER(Order_Date)) AS Quarter,
    SUM(Price_INR) AS Total_Sales,
    AVG(Rating) AS Avg_Rating,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Quarter
ORDER BY Quarter;

ALTER TABLE orders
ADD Payment_Method VARCHAR(30);

DESCRIBE orders;
SELECT * FROM orders
LIMIT 10;
SELECT SUM(Price_INR) AS Total_Revenue
FROM orders;
DROP TABLE orders;
SELECT * FROM orders
LIMIT 10;
SELECT SUM(`Price (INR)`) AS Total_Revenue
FROM orders;
SELECT COUNT(*) AS Total_Orders
FROM orders;
SELECT AVG(Rating) AS Avg_Rating
FROM orders;
SELECT
    City,
    SUM(`Price (INR)`) AS Revenue
FROM orders
GROUP BY City
ORDER BY Revenue DESC
LIMIT 5;
SELECT
    State,
    SUM(`Price (INR)`) AS Revenue
FROM orders
GROUP BY State
ORDER BY Revenue DESC;

-- Monthly Revenue Trend
SELECT
    `ï»¿State`,
    SUM(`Price (INR)`) AS Revenue
FROM orders
GROUP BY `ï»¿State`
ORDER BY Revenue DESC;

-- Monthly Revenue Trend
SELECT
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%d-%m-%Y'), '%Y-%m') AS Month,

    SUM(`Price (INR)`) AS Revenue

FROM orders

GROUP BY Month
ORDER BY Month;

-- Weekly Trend
SELECT
    DAYNAME(
        STR_TO_DATE(`Order Date`, '%d-%m-%Y')
    ) AS DayName,

    SUM(`Price (INR)`) AS Revenue

FROM orders

GROUP BY DayName;

-- Top Selling Foods
SELECT
    `Dish Name`,
    COUNT(*) AS Total_Orders

FROM orders

GROUP BY `Dish Name`

ORDER BY Total_Orders DESC
LIMIT 10;

-- Veg vs Non-Veg
SELECT
    CASE
        WHEN LOWER(`Dish Name`) REGEXP 'chicken|fish|mutton|egg|prawn|biryani|kebab'
        THEN 'Non-Veg'
        ELSE 'Veg'
    END AS Food_Category,

    SUM(`Price (INR)`) AS Revenue

FROM orders

GROUP BY Food_Category;
SELECT
    City,
    SUM(`Price (INR)`) AS Revenue
FROM orders
GROUP BY City;
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%d-%m-%Y'),
        '%Y-%m'
    ) AS Month,

    SUM(`Price (INR)`) AS Revenue

FROM orders

GROUP BY Month
ORDER BY Month;
SELECT
    CASE
        WHEN LOWER(`Dish Name`) REGEXP 'chicken|fish|mutton|egg|prawn|biryani|kebab'
        THEN 'Non-Veg'
        ELSE 'Veg'
    END AS Food_Category,

    SUM(`Price (INR)`) AS Revenue

FROM orders

GROUP BY Food_Category;
SELECT
    CONCAT(
        YEAR(
            STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        ),
        '-Q',
        QUARTER(
            STR_TO_DATE(`Order Date`, '%d-%m-%Y')
        )
    ) AS Quarter,

    SUM(`Price (INR)`) AS Total_Sales,

    AVG(Rating) AS Avg_Rating,

    COUNT(*) AS Total_Orders

FROM orders

GROUP BY Quarter
ORDER BY Quarter;

SELECT DISTINCT City
FROM swiggy_data;
SELECT City, COUNT(*) AS Total
FROM swiggy_data
GROUP BY City;

SELECT DISTINCT Category
FROM swiggy_data;

SELECT `Dish Name`,
       COUNT(*) AS Total_Orders,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE Category = 'Veg'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT DISTINCT Category
FROM swiggy_data;
SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE `Dish Name` NOT LIKE '%Chicken%'
AND `Dish Name` NOT LIKE '%Mutton%'
AND `Dish Name` NOT LIKE '%Fish%'
AND `Dish Name` NOT LIKE '%Egg%'
AND `Dish Name` NOT LIKE '%Prawn%'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE (
    `Dish Name` LIKE '%Chicken%'
    OR `Dish Name` LIKE '%Mutton%'
    OR `Dish Name` LIKE '%Fish%'
    OR `Dish Name` LIKE '%Egg%'
    OR `Dish Name` LIKE '%Prawn%'
)
AND `Dish Name` NOT LIKE '%Eggless%'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE `Dish Name` NOT LIKE '%Chicken%'
AND `Dish Name` NOT LIKE '%Mutton%'
AND `Dish Name` NOT LIKE '%Fish%'
AND `Dish Name` NOT LIKE '%Egg%'
AND `Dish Name` NOT LIKE '%Prawn%'
AND `Dish Name` NOT LIKE '%Eggless%'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT `Dish Name`,
       COUNT(*) AS Total_Orders,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 10;

SELECT 
DAYNAME(`Order Date`) AS Day_of_Week,
SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY Day_of_Week
ORDER BY FIELD(
    Day_of_Week,
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);
SELECT City,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT 
CASE
    WHEN (
        `Dish Name` LIKE '%Chicken%'
        OR `Dish Name` LIKE '%Mutton%'
        OR `Dish Name` LIKE '%Fish%'
        OR `Dish Name` LIKE '%Egg%'
        OR `Dish Name` LIKE '%Prawn%'
    )
    AND `Dish Name` NOT LIKE '%Eggless%'
    THEN 'Non Veg'

    WHEN (
        `Dish Name` LIKE '%Paneer%'
        OR `Dish Name` LIKE '%Veg%'
        OR `Dish Name` LIKE '%Mushroom%'
        OR `Dish Name` LIKE '%Gobi%'
        OR `Dish Name` LIKE '%Dosa%'
        OR `Dish Name` LIKE '%Idli%'
    )
    THEN 'Veg'

    ELSE 'Others'
END AS Food_Type,

COUNT(*) AS Total_Orders,
SUM(`Price (INR)`) AS Total_Revenue

FROM swiggy_data

GROUP BY Food_Type;
SELECT `Restaurant Name`,
       COUNT(*) AS Total_Orders,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY `Restaurant Name`
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT City,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT Location,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY Location
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT COUNT(DISTINCT City) AS Total_Cities
FROM swiggy_data;
SELECT City, State, Location
FROM swiggy_data
LIMIT 20;
SHOW COLUMNS FROM swiggy_data;
SELECT `ï»¿State`,
       City,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY `ï»¿State`, City
ORDER BY Total_Revenue DESC
LIMIT 10;
DROP TABLE swiggy_data;

DROP TABLE swiggy_data;
SELECT City,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 5;
DROP TABLE swiggy_data;

SELECT COUNT(*) FROM swiggy_data;
SELECT COUNT(DISTINCT City)
FROM swiggy_data;
SELECT City,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT `Restaurant Name`,
       COUNT(*) AS Total_Orders,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
GROUP BY `Restaurant Name`
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE (
    `Dish Name` LIKE '%Paneer%'
    OR `Dish Name` LIKE '%Veg%'
    OR `Dish Name` LIKE '%Mushroom%'
    OR `Dish Name` LIKE '%Gobi%'
    OR `Dish Name` LIKE '%Dosa%'
    OR `Dish Name` LIKE '%Idli%'
)
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE (
    `Dish Name` LIKE '%Chicken%'
    OR `Dish Name` LIKE '%Mutton%'
    OR `Dish Name` LIKE '%Fish%'
    OR `Dish Name` LIKE '%Egg%'
    OR `Dish Name` LIKE '%Prawn%'
)
AND `Dish Name` NOT LIKE '%Eggless%'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT `Dish Name`,
       SUM(`Price (INR)`) AS Total_Revenue
FROM swiggy_data
WHERE `Dish Name` NOT LIKE '%Chicken%'
AND `Dish Name` NOT LIKE '%Mutton%'
AND `Dish Name` NOT LIKE '%Fish%'
AND `Dish Name` NOT LIKE '%Egg%'
AND `Dish Name` NOT LIKE '%Prawn%'
AND `Dish Name` NOT LIKE '%Paneer%'
AND `Dish Name` NOT LIKE '%Veg%'
GROUP BY `Dish Name`
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT 
CASE
    WHEN (
        `Dish Name` LIKE '%Chicken%'
        OR `Dish Name` LIKE '%Mutton%'
        OR `Dish Name` LIKE '%Fish%'
        OR `Dish Name` LIKE '%Egg%'
        OR `Dish Name` LIKE '%Prawn%'
    )
    AND `Dish Name` NOT LIKE '%Eggless%'
    THEN 'Non Veg'

    WHEN (
        `Dish Name` LIKE '%Paneer%'
        OR `Dish Name` LIKE '%Veg%'
        OR `Dish Name` LIKE '%Mushroom%'
        OR `Dish Name` LIKE '%Gobi%'
        OR `Dish Name` LIKE '%Dosa%'
        OR `Dish Name` LIKE '%Idli%'
    )
    THEN 'Veg'

    ELSE 'Others'
END AS Food_Type,

COUNT(*) AS Total_Orders,
SUM(`Price (INR)`) AS Total_Revenue

FROM swiggy_data

GROUP BY Food_Type;
SELECT City,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY City
ORDER BY Total_Revenue DESC
LIMIT 10;
SELECT State,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY State
ORDER BY Total_Revenue DESC;
SELECT State,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY State
ORDER BY Total_Revenue DESC
LIMIT 5;
SELECT `Location Type`,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY `Location Type`
ORDER BY Total_Revenue DESC;
SHOW COLUMNS FROM swiggy_data;
SELECT `Location`,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY `Location`
ORDER BY Total_Revenue DESC;

SELECT 
QUARTER(`Order Date`) AS Quarter,
YEAR(`Order Date`) AS Year,
SUM(`Price (INR)`) AS Total_Revenue,
COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
SELECT 
QUARTER(Date) AS Quarter,
YEAR(Date) AS Year,
COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
SELECT 
QUARTER(`Order Date`) AS Quarter,
YEAR(`Order Date`) AS Year,
COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
SELECT 
CONCAT('Q', QUARTER(Date)) AS Quarter,
SUM(`Price (INR)`) AS Total_Revenue,
ROUND(
    (SUM(`Price (INR)`) * 100.0 / 
    (SELECT SUM(`Price (INR)`) FROM swiggy_data)), 
2) AS Revenue_Share_Percentage
FROM swiggy_data
GROUP BY Quarter
ORDER BY Quarter;
SELECT 
CONCAT('Q', QUARTER(`Order Date`)) AS Quarter,
SUM(`Price (INR)`) AS Total_Revenue,
ROUND(
    (SUM(`Price (INR)`) * 100.0 / 
    (SELECT SUM(`Price (INR)`) FROM swiggy_data)), 
2) AS Revenue_Share_Percentage
FROM swiggy_data
GROUP BY Quarter
ORDER BY Quarter;
WITH quarterly_revenue AS (
    SELECT 
        YEAR(Date) AS Year,
        QUARTER(Date) AS Quarter,
        SUM(`Price (INR)`) AS Total_Revenue
    FROM swiggy_data
    GROUP BY Year, Quarter
)

SELECT 
    Year,
    Quarter,
    Total_Revenue,

    LAG(Total_Revenue) OVER (
        ORDER BY Year, Quarter
    ) AS Previous_Quarter_Revenue,

    ROUND(
        (
            (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Year, Quarter))
            / LAG(Total_Revenue) OVER (ORDER BY Year, Quarter)
        ) * 100,
        2
    ) AS QoQ_Growth_Percentage

FROM quarterly_revenue;
WITH quarterly_revenue AS (
    SELECT 
        YEAR(`Order Date`) AS Year,
        QUARTER(`Order Date`) AS Quarter,
        SUM(`Price (INR)`) AS Total_Revenue
    FROM swiggy_data
    GROUP BY Year, Quarter
)

SELECT 
    Year,
    Quarter,
    Total_Revenue,

    LAG(Total_Revenue) OVER (
        ORDER BY Year, Quarter
    ) AS Previous_Quarter_Revenue,

    ROUND(
        (
            (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY Year, Quarter))
            / LAG(Total_Revenue) OVER (ORDER BY Year, Quarter)
        ) * 100,
        2
    ) AS QoQ_Growth_Percentage

FROM quarterly_revenue;
SELECT 
ROUND(SUM(`Price (INR)`), 2) AS Total_Veg_Revenue
FROM swiggy_data
WHERE `Dish Name` NOT LIKE '%Chicken%'
AND `Dish Name` NOT LIKE '%Mutton%'
AND `Dish Name` NOT LIKE '%Fish%'
AND `Dish Name` NOT LIKE '%Egg%'
AND `Dish Name` NOT LIKE '%Prawn%';
SELECT 
ROUND(SUM(`Price (INR)`), 2) AS Total_NonVeg_Revenue
FROM swiggy_data
WHERE (
    `Dish Name` LIKE '%Chicken%'
    OR `Dish Name` LIKE '%Mutton%'
    OR `Dish Name` LIKE '%Fish%'
    OR `Dish Name` LIKE '%Egg%'
    OR `Dish Name` LIKE '%Prawn%'
)
AND `Dish Name` NOT LIKE '%Eggless%';
SELECT 
ROUND(AVG(`Rating`), 2) AS Average_Rating
FROM swiggy_data;
SELECT `Location`,
       SUM(`Price (INR)`) AS Total_Revenue,
       COUNT(*) AS Total_Orders
FROM swiggy_data
GROUP BY `Location`
ORDER BY Total_Revenue DESC;
SELECT 
CASE
    WHEN City IN (
        'Chennai',
        'Mumbai',
        'Delhi',
        'Bengaluru',
        'Hyderabad',
        'Kolkata',
        'Pune',
        'Ahmedabad'
    )
    THEN 'Urban'

    ELSE 'Rural'
END AS Location_Type,

SUM(`Price (INR)`) AS Total_Revenue,
COUNT(*) AS Total_Orders

FROM swiggy_data

GROUP BY Location_Type;
SELECT 
SUM(`Price (INR)`) AS Urban_Revenue
FROM swiggy_data
WHERE City IN (
    'Chennai',
    'Mumbai',
    'Delhi',
    'Bengaluru',
    'Hyderabad',
    'Kolkata',
    'Pune',
    'Ahmedabad'
);
SELECT 
SUM(`Price (INR)`) AS Rural_Revenue
FROM swiggy_data
WHERE City IN (
    'Madurai',
    'Salem',
    'Trichy',
    'Coimbatore',
    'Mysore',
    'Vijayawada',
    'Lucknow',
    'Jaipur'
);
SELECT 
SUM(`Price (INR)`) AS Other_Revenue
FROM swiggy_data
WHERE City NOT IN (
    'Chennai',
    'Mumbai',
    'Delhi',
    'Bengaluru',
    'Hyderabad',
    'Kolkata',
    'Pune',
    'Ahmedabad',
    'Madurai',
    'Salem',
    'Trichy',
    'Coimbatore',
    'Mysore',
    'Vijayawada',
    'Lucknow',
    'Jaipur'
);