--cars released after 2015
SELECT 
	car_id,
	brand, 
	model, 
	year, 
	price
FROM cars
WHERE year >= '2015'
ORDER BY year;

--insert one bid entry
INSERT INTO bids (user_id, ad_id, bid_price, bid_date, bid_status) 
VALUES (30, 10, 150000000, current_timestamp, 'Sent');

--view all cars from one user with name Ajimin Prasetya and order the result from most recent posted car                                                                                                                
SELECT 
	c.car_id, 
	c.brand, 
	c.model, 
	c.year, 
	c.price, 
	a.post_date
FROM cars c
INNER JOIN ads a
USING(car_id)
INNER JOIN users u
USING(user_id)
WHERE u.name = 'Ajimin Prasetya'
ORDER BY a.post_date DESC;

--search for cheapest car by keyword. i.e "Yaris"
SELECT 
	car_id, 
	brand, 
	model, 
	year, 
	price
FROM cars
WHERE model ILIKE '%yaris%'
ORDER BY price;

--search neareast car from a city
--create function for calculaing haversine distance
CREATE FUNCTION haversine_distance(lat1 NUMERIC, lon1 NUMERIC, lat2 NUMERIC, lon2 NUMERIC)
RETURNS FLOAT AS $$
DECLARE
	rad_lat1 float := radians(lat1);
	rad_lon1 float := radians(lon1);
	rad_lat2 float := radians(lat2);
	rad_lon2 float := radians(lon2);
	
	dlon float := rad_lon2 - rad_lon1;
	dlat float := rad_lat2 - rad_lat1;
	
	a float;
	b float;
	r float := 6371;
	distance float;
BEGIN
	a := sin(dlat/2)^2 + cos(rad_lat1) * cos(rad_lat2) * sin(dlon/2)^2;
	b := 2 * asin(sqrt(a));
	distance := r * b;
	
	RETURN distance;
END;
$$
LANGUAGE plpgsql;
	
--search nearest car from city with id 3173
SELECT ca.car_id, ca.brand, ca.model, ca.year, ca.price, haversine_distance(
	(SELECT latitude FROM cities WHERE city_id = 3173),
	(SELECT longitude FROM cities WHERE city_id = 3173),
	ci.latitude,
	ci.longitude) AS distance
FROM cities ci
INNER JOIN users u
USING (city_id)
INNER JOIN ads a
USING (user_id)
INNER JOIN cars ca
USING (car_id)
ORDER BY distance;

