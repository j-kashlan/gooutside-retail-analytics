CREATE OR REPLACE TABLE `lyrical-lyceum-510107-s2.GoOutside.sarah_overview` AS
SELECT
  date,
  order_method_type,
  COUNT(*) AS total_orders,
  SUM(quantity) AS total_quantity,
  ROUND(SUM(revenue), 2) AS total_revenue,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(SAFE_DIVIDE(SUM(revenue), COUNT(*)), 2) AS avg_revenue_per_order
FROM
  `lyrical-lyceum-510107-s2.GoOutside.master_table`
GROUP BY
  date,
  order_method_type
ORDER BY
  date DESC,
  total_revenue DESC;