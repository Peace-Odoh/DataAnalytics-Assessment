-- Question 2: Transaction Frequency Analysis
-- Objective: Categorize customers based on how frequently they perform transactions each month.

-- Step 1: Count the number of transactions each customer made per month
WITH monthly_txns AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month, -- Normalize to Year-Month
        COUNT(*) AS transactions
    FROM savings_savingsaccount
    GROUP BY owner_id, txn_month
),

-- Step 2: Calculate the average monthly transaction count per customer
avg_monthly_txns AS (
    SELECT
        owner_id,
        AVG(transactions) AS avg_txns_per_month
    FROM monthly_txns
    GROUP BY owner_id
)

-- Step 3: Categorize customers based on average monthly frequency
SELECT
    CASE
        WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,

    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM avg_monthly_txns
GROUP BY frequency_category;
