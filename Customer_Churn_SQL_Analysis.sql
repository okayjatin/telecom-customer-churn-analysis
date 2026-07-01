-- ============================================
-- CUSTOMER CHURN ANALYSIS USING MYSQL
-- Dataset : Telecom Customer Churn
-- Author  : Jatin Asrani
-- ============================================
USE churn_analysis;
-- ======================================================
-- QUERY 1: TOTAL CUSTOMERS
-- Purpose: Count the total number of customers
-- ======================================================
SELECT
    COUNT(*) AS Total_Customers
FROM telco_churn;
-- ======================================================
-- QUERY 2: OVERALL CHURN DISTRIBUTION
-- Purpose: Compare churned and retained customers
-- ======================================================
SELECT
    `Churn Label`,
    COUNT(*) AS Customers
FROM telco_churn
GROUP BY `Churn Label`;
-- ======================================================
-- QUERY 3: CONTRACT TYPE ANALYSIS
-- Purpose: Compare total and churned customers by contract
-- ======================================================
SELECT
    Contract,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY Contract;
-- ======================================================
-- QUERY 4: INTERNET SERVICE ANALYSIS
-- Purpose: Compare total and churned customers by internet service
-- ======================================================
SELECT
    `Internet Service`,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY `Internet Service`;
-- ======================================================
-- QUERY 5: PAYMENT METHOD ANALYSIS
-- Purpose: Compare churn across payment methods
-- ======================================================
SELECT
    `Payment Method`,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY `Payment Method`;
-- ======================================================
-- QUERY 6: SENIOR CITIZEN ANALYSIS
-- Purpose: Compare churn between senior and non-senior customers
-- ======================================================
SELECT
    `Senior Citizen`,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY `Senior Citizen`;
-- ======================================================
-- QUERY 7: ONLINE SECURITY ANALYSIS
-- Purpose: Analyse the relationship between online security and churn
-- ======================================================
SELECT
    `Online Security`,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY `Online Security`;
-- ======================================================
-- QUERY 8: TECH SUPPORT ANALYSIS
-- Purpose: Analyse the relationship between technical support and churn
-- ======================================================
SELECT
    `Tech Support`,
    COUNT(*) AS Total_Customers,
    SUM(
        CASE
            WHEN `Churn Label`='Yes' THEN 1
            ELSE 0
        END
    ) AS Churned_Customers
FROM telco_churn
GROUP BY `Tech Support`;
-- ======================================================
-- QUERY 9: AVERAGE MONTHLY CHARGES
-- Purpose: Compare average monthly charges by churn status
-- ======================================================
SELECT
    `Churn Label`,
    ROUND(AVG(`Monthly Charges`),2) AS Avg_Monthly_Charges
FROM telco_churn
GROUP BY `Churn Label`;
-- ======================================================
-- QUERY 10: AVERAGE CUSTOMER LIFETIME VALUE
-- Purpose: Compare average CLTV by churn status
-- ======================================================
SELECT
    `Churn Label`,
    ROUND(AVG(CLTV),0) AS Average_CLTV
FROM telco_churn
GROUP BY `Churn Label`;
-- ======================================================
-- QUERY 11: TENURE GROUP ANALYSIS
-- Purpose: Analyse churn across customer tenure groups
-- ======================================================
SELECT

CASE

WHEN `Tenure Months` BETWEEN 0 AND 12 THEN '0-12 Months'
WHEN `Tenure Months` BETWEEN 13 AND 24 THEN '13-24 Months'
WHEN `Tenure Months` BETWEEN 25 AND 48 THEN '25-48 Months'
ELSE '49+ Months'

END AS Tenure_Group,

COUNT(*) AS Total_Customers,

SUM(

CASE

WHEN `Churn Label`='Yes' THEN 1

ELSE 0

END

) AS Churned_Customers

FROM telco_churn

GROUP BY Tenure_Group;
-- ======================================================
-- QUERY 12: TOP CHURN REASONS
-- Purpose: Identify the major reasons customers leave
-- ======================================================
SELECT

`Churn Reason`,

COUNT(*) AS Customers

FROM telco_churn

WHERE `Churn Label`='Yes'

GROUP BY `Churn Reason`

ORDER BY Customers DESC

LIMIT 7;
-- ======================================================
-- QUERY 13: OVERALL CHURN RATE
-- Purpose: Calculate the overall customer churn rate
-- ======================================================
SELECT
ROUND(
SUM(
CASE
WHEN `Churn Label`='Yes' THEN 1
ELSE 0
END
)*100/COUNT(*),2) AS Churn_Rate_Percentage
FROM telco_churn;
-- ======================================================
-- QUERY 14: MONTHLY REVENUE AT RISK
-- Purpose: Estimate monthly revenue lost due to churn
-- ======================================================
SELECT

ROUND(

SUM(

CASE

WHEN `Churn Label`='Yes'

THEN `Monthly Charges`

ELSE 0

END

),2

) AS Monthly_Revenue_At_Risk

FROM telco_churn;
-- ======================================================
-- QUERY 15: REVENUE BY CONTRACT TYPE
-- Purpose: Compare revenue contribution across contracts
-- ======================================================
SELECT

Contract,

ROUND(SUM(`Monthly Charges`),2) AS Total_Revenue

FROM telco_churn

GROUP BY Contract

ORDER BY Total_Revenue DESC;
-- ======================================================
-- QUERY 16: CHURN RATE BY PAYMENT METHOD
-- Purpose: Calculate churn percentage for each payment method
-- ======================================================
SELECT

`Payment Method`,

COUNT(*) AS Total_Customers,

SUM(

CASE

WHEN `Churn Label`='Yes'

THEN 1

ELSE 0

END

) AS Churned_Customers,

ROUND(

SUM(

CASE

WHEN `Churn Label`='Yes'

THEN 1

ELSE 0

END

)*100/COUNT(*),2

) AS Churn_Rate_Percentage

FROM telco_churn

GROUP BY `Payment Method`

ORDER BY Churn_Rate_Percentage DESC;
-- ======================================================
-- QUERY 17 : TOP 10 HIGH-RISK CUSTOMERS
-- Purpose: Identify customers with the highest churn score
-- ======================================================
SELECT
    `ï»¿CustomerID`,
    `Churn Score`,
    CLTV,
    `Monthly Charges`,
    Contract,
    `Internet Service`
FROM telco_churn
ORDER BY `Churn Score` DESC
LIMIT 10;
-- ======================================================
-- QUERY 18: CUSTOMER RANKING BY CLTV
-- Purpose: Rank customers based on Customer Lifetime Value
-- ======================================================

SELECT

`ï»¿CustomerID`,

CLTV,

RANK() OVER(ORDER BY CLTV DESC) AS CLTV_Rank

FROM telco_churn

LIMIT 20;
/*
===========================================================
KEY BUSINESS INSIGHTS

• Total Customers: 7,032
• Overall Churn Rate: 26.58%
• Month-to-month customers show the highest churn.
• Fibre optic customers have the highest churn count.
• Electronic check customers are most likely to churn.
• Customers without Online Security and Tech Support churn more frequently.
• Customers in their first year show the highest churn risk.
• Competitor offers and poor customer support are the leading churn reasons.
• Average CLTV is lower for churned customers than retained customers.

===========================================================
*/