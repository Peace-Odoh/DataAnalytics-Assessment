-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Objective: Estimate the customer lifetime value using transaction frequency and value over customer tenure.

-- Step 1: Aggregate total transactions and transaction value per customer
WITH customer_transactions AS (
    SELECT
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_transaction_value
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),

-- Step 2: Calculate how long each customer has been active (in months)
customer_tenure AS (
    SELECT
        id AS customer_id,
        COALESCE(name, CONCAT(first_name, ' ', last_name)) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
)

-- Step 3: Estimate CLV using frequency × value × lifespan model
SELECT
    c.customer_id,
    c.name,
    c.tenure_months,
    COALESCE(t.total_transactions, 0) AS total_transactions,

    -- CLV formula:
    -- Monthly transaction frequency × 12 months × Avg transaction value (in major currency)
    CASE
        WHEN c.tenure_months > 0 AND COALESCE(t.total_transactions, 0) > 0 THEN
            (t.total_transactions / c.tenure_months) * 12 * ((t.total_transaction_value * 0.001) / t.total_transactions)
        ELSE 0
    END AS estimated_clv

FROM customer_tenure c
LEFT JOIN customer_transactions t ON c.customer_id = t.owner_id
ORDER BY estimated_clv DESC;
