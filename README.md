# DataAnalytics-Assessment
This repository contains solutions to the Cowrywise Data Analytics technical assessment. It includes answers to four questions, each implemented in separate SQL scripts for clarity and organization.
# Question 1: High-Value Customers with Multiple Products

# Approach:
The goal was to identify users who have both savings and investment plans and rank them by the total amount they’ve deposited.

- I joined the `users_customuser`, `plans_plan`, and `savings_savingsaccount` tables.
- I used `CASE WHEN` logic to count savings and investment plans separately.
- Deposits were converted from kobo to naira by dividing `confirmed_amount` by 100.
- The query filters users who have both types of products and sorts them in descending order of total deposits.

# Challenges:
- Ensuring that users were counted only if they had both savings and investment plans required careful `HAVING` clause logic.
- Handling users with null `name` fields using `COALESCE` helped display full names consistently.
