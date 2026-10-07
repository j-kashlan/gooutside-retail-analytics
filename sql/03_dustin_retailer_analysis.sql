CREATE OR REPLACE TABLE `lyrical-lyceum-510107-s2.GoOutside.dustin_retailer_performance` AS
WITH retailer_totals AS (
  SELECT
    country,
    retailer_name,
    retailer_type,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold,
    SUM(revenue) AS retailer_revenue,
    SUM(profit) AS retailer_profit
  FROM
    `lyrical-lyceum-510107-s2.GoOutside.master_table`
  GROUP BY
    country,
    retailer_name,
    retailer_type
),
country_totals AS (
  SELECT
    country,
    SUM(retailer_revenue) AS country_revenue,
    COUNT(DISTINCT retailer_name) AS total_retailers_in_country
  FROM
    retailer_totals
  GROUP BY
    country
)
SELECT
  rt.country,
  rt.retailer_name,
  rt.retailer_type,
  rt.total_transactions,
  rt.total_items_sold,
  ROUND(rt.retailer_revenue, 2) AS total_revenue,
  ROUND(rt.retailer_profit, 2) AS total_profit,
  ROUND((rt.retailer_revenue / ct.country_revenue) * 100, 2) AS market_share_pct,
  ct.total_retailers_in_country,
  CASE
    WHEN (SUM(rt.retailer_revenue) OVER (PARTITION BY rt.country ORDER BY rt.retailer_revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 2 FOLLOWING) / ct.country_revenue) >= 0.75
    THEN 'Dominated'
    ELSE 'Competitive'
  END AS market_classification
FROM
  retailer_totals rt
JOIN
  country_totals ct ON rt.country = ct.country
ORDER BY
  rt.country,
  rt.retailer_revenue DESC;