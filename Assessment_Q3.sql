-- Question 3: Account Inactivity Alert
-- Objective: Identify savings and investment plans with no recent activity for at least one year.

SELECT
    p.id AS plan_id,
    p.owner_id,
    
    -- Determine the type of plan
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,

    -- Get the date of the most recent confirmed transaction
    MAX(sa.transaction_date) AS last_transaction_date,

    -- Calculate days since last transaction
    DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS inactivity_days

FROM plans_plan p

-- Join with transaction data only if there are confirmed amounts
LEFT JOIN savings_savingsaccount sa
    ON p.id = sa.plan_id AND sa.confirmed_amount > 0

-- Focus only on savings and investment plans
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1

GROUP BY p.id, p.owner_id, type

-- Flag plans with no activity in the last 365 days
HAVING last_transaction_date IS NULL
    OR last_transaction_date <= DATE_SUB(CURDATE(), INTERVAL 365 DAY);
