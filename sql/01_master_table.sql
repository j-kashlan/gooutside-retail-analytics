CREATE OR REPLACE TABLE `lyrical-lyceum-510107-s2.GoOutside.master_table` AS
SELECT
  PARSE_DATE('%d/%m/%Y', s.Date) AS date,
  r.Retailer_name AS retailer_name,
  r.Type AS retailer_type,
  r.Country AS country,
  p.Product_line AS product_line,
  p.Product_type AS product_type,
  p.Product AS product_name,
  p.Product_brand AS product_brand,
  p.Unit_cost AS base_unit_cost,
  m.Order_method_type AS order_method_type,
  s.Quantity AS quantity,
  s.Unit_price AS list_price,
  s.Unit_sale_price AS unit_sale_price,
  ROUND((s.Quantity * s.Unit_sale_price), 2) AS revenue,
  ROUND((s.Quantity * (s.Unit_sale_price - p.Unit_cost)), 2) AS profit
FROM
  `lyrical-lyceum-510107-s2.GoOutside.daily_sales` s
LEFT JOIN
  `lyrical-lyceum-510107-s2.GoOutside.retailers` r ON s.Retailer_code = r.Retailer_code
LEFT JOIN
  `lyrical-lyceum-510107-s2.GoOutside.products` p ON s.Product_number = p.Product_number
LEFT JOIN
  `lyrical-lyceum-510107-s2.GoOutside.methods` m ON s.Order_method_code = m.Order_method_code;