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


# Question 2: Transaction Frequency Analysis

# Approach:
The goal was to categorize customers into High, Medium, or Low Frequency transaction tiers based on their average monthly transaction volume.

- First, I counted the number of transactions each customer made per month.
- Then, I calculated the average monthly transaction count per user.
- Finally, I used a `CASE` statement to bucket customers into frequency categories:
  - **High Frequency**: ≥ 10 transactions/month
  - **Medium Frequency**: 3–9 transactions/month
  - **Low Frequency**: < 3 transactions/month

# Challenges:
- Ensuring correct monthly grouping using `DATE_FORMAT()` was key to accurate averages.
- Rounding the average transactions helped make the final output more interpretable.

