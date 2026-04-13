-- Overall churn rate
SELECT
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full;

-- Churn by gender
SELECT
  gender,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY gender
ORDER BY churn_rate_pct DESC;

-- Churn by subscription type
SELECT
  subscription_type,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY subscription_type
ORDER BY churn_rate_pct DESC;

-- Churn by contract length
SELECT
  contract_length,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY contract_length
ORDER BY churn_rate_pct DESC;

-- Churn by support call bucket
SELECT
  CASE
    WHEN support_calls = 0 THEN '0'
    WHEN support_calls BETWEEN 1 AND 2 THEN '1-2'
    WHEN support_calls BETWEEN 3 AND 5 THEN '3-5'
    ELSE '6+'
  END AS support_call_bucket,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY support_call_bucket
ORDER BY support_call_bucket;

-- Churn by payment delay bucket
SELECT
  CASE
    WHEN payment_delay = 0 THEN '0'
    WHEN payment_delay BETWEEN 1 AND 5 THEN '1-5'
    WHEN payment_delay BETWEEN 6 AND 10 THEN '6-10'
    ELSE '11+'
  END AS payment_delay_bucket,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY payment_delay_bucket
ORDER BY payment_delay_bucket;

-- Churn by tenure bucket
SELECT
  CASE
    WHEN tenure < 6 THEN '<6'
    WHEN tenure < 12 THEN '6-11'
    WHEN tenure < 24 THEN '12-23'
    ELSE '24+'
  END AS tenure_bucket,
  COUNT(*) AS customers,
  ROUND(AVG(churn) * 100, 2) AS churn_rate_pct
FROM workspace.default.customer_churn_full
GROUP BY tenure_bucket
ORDER BY tenure_bucket;

-- Risk band counts
SELECT
  risk_band,
  COUNT(*) AS customers
FROM workspace.default.customer_churn_predictions
GROUP BY risk_band
ORDER BY customers DESC;

-- Top 20 high-risk customers
SELECT
  customerid,
  age,
  gender,
  tenure,
  usage_frequency,
  support_calls,
  payment_delay,
  subscription_type,
  contract_length,
  total_spend,
  last_interaction,
  churn,
  predicted_churn,
  predicted_probability
FROM workspace.default.customer_churn_predictions
ORDER BY predicted_probability DESC
LIMIT 20;
