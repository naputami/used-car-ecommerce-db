--rank by bid
SELECT c.model AS model, COUNT(DISTINCT ad_id) AS count_product, COUNT(bid_id) AS count_bid
FROM ads a
LEFT JOIN cars c
USING (car_id)
LEFT JOIN bids b
USING (ad_id)
GROUP BY model
ORDER BY count_bid DESC;

--car price vs avg cars price by city
--select row number 1 only to avoid duplicated car data
with price_and_avg_price as (
	SELECT ci.city_name, c.brand, c.model, c.year, c.price,
	AVG(c.price) OVER(PARTITION BY ci.city_name ORDER BY c.price ASC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
		AS avg_car_city,
	ROW_NUMBER() OVER(PARTITION BY city_name, brand, model, year, price) AS rn
	FROM cars c
	INNER JOIN ads a
	USING (car_id)
	INNER JOIN users u
	USING (user_id)
	INNER JOIN cities ci
	USING (city_id)
)

SELECT city_name, brand, model, year, price, avg_car_city
FROM price_and_avg_price
WHERE rn = 1;


--next bid vs next bid by keyword. ie= Daihatsu Xenia
WITH bids_data AS (
	SELECT 
		c.model, 
		b.user_id, 
		b.bid_date, 
		b.bid_price
	FROM bids b
	INNER JOIN ads a
	USING (ad_id)
	INNER JOIN cars c
	USING (car_id)
	WHERE c.model = 'Daihatsu Xenia'
)


SELECT 
	model, 
	user_id, 
	bid_date AS previous_bid_date,
	LEAD(bid_date) OVER (PARTITION BY user_id ORDER BY bid_date) AS next_bid_date,
	bid_price AS previous_bid_price,
	LEAD(bid_price) OVER (PARTITION BY user_id ORDER BY bid_date) AS next_bid_price
FROM bids_data;

--six months average
WITH avg_price_data AS (
	SELECT 
		c.model, 
		AVG(c.price) AS avg_price, 
		AVG(b.bid_price) AS avg_bid_6_months
	FROM bids b
	INNER JOIN ads a
	USING (ad_id)
	INNER JOIN cars c
	USING (car_id)
	WHERE b.bid_date >= CURRENT_DATE - INTERVAL '6 months'
	GROUP BY c.model
)

SELECT 
	model, 
	avg_price, 
	avg_bid_6_months,
	(avg_price - avg_bid_6_months) AS difference,
	(avg_price - avg_bid_6_months)/avg_price * 100 AS percentage
FROM avg_price_data
ORDER BY avg_bid_6_months;

--avarage bid price from last one to six months
WITH avg_bid_price_data AS (
	SELECT 
		c.brand, 
		c.model, 
		b.bid_date, 
		b.bid_price,
		AVG(b.bid_price) OVER (PARTITION BY c.brand, c.model ORDER BY DATE_TRUNC('month', b.bid_date) ASC) AS avg_price,
		EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM DATE_TRUNC('month', b.bid_date)) AS month_diff
	FROM bids b
	INNER JOIN ads a
	USING (ad_id)
	INNER JOIN cars c
	USING (car_id)
	WHERE b.bid_date >= CURRENT_DATE - INTERVAL '6 months' AND c.model = 'Honda CR-V'
)

SELECT
  brand,
  model,
  MAX(CASE WHEN month_diff = 6 THEN avg_price ELSE NULL END) AS avg_bid_price_m_6,
  MAX(CASE WHEN month_diff = 5 THEN avg_price ELSE NULL END) AS avg_bid_price_m_5,
  MAX(CASE WHEN month_diff = 4 THEN avg_price ELSE NULL END) AS avg_bid_price_m_4,
  MAX(CASE WHEN month_diff = 3 THEN avg_price ELSE NULL END) AS avg_bid_price_m_3,
  MAX(CASE WHEN month_diff = 2 THEN avg_price ELSE NULL END) AS avg_bid_price_m_2,
  MAX(CASE WHEN month_diff = 1 THEN avg_price ELSE NULL END) AS avg_bid_price_m_1
FROM avg_bid_price_data
GROUP BY brand, model;