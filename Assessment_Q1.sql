-- Question 1: High-Value Customers with Multiple Products
-- Objective: Identify users who have both a savings and an investment plan, ranked by total confirmed deposits.

SELECT
    u.id AS owner_id,
    -- Use full name if available; otherwise, combine first and last names
    COALESCE(u.name, CONCAT(u.first_name, ' ', u.last_name)) AS name,

    -- Count distinct regular savings plans
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,

    -- Count distinct investment (fund) plans
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,

    -- Sum of confirmed deposits, converted from kobo to naira
    COALESCE(SUM(sa.confirmed_amount), 0) / 100 AS total_deposits

FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
LEFT JOIN savings_savingsaccount sa ON p.id = sa.plan_id AND sa.confirmed_amount > 0

-- Filter to include only users with at least one savings or investment plan
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1

GROUP BY u.id, name

-- Include only users who have both savings and investment plans
HAVING savings_count > 0 AND investment_count > 0

-- Sort users by total deposits in descending order
ORDER BY total_deposits DESC;
