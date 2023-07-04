CREATE TABLE cities (
	city_id PRIMARY KEY,
	city_name VARCHAR(12) NOT NULL UNIQUE,
	latitude NUMERIC(9,6) NOT NULL UNIQUE,
	longitude NUMERIC(9,6) NOT NULL UNIQUE
);

CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(15) NOT NULL UNIQUE,
	city_id INT NOT NULL REFERENCES cities(city_id)  
);

CREATE TABLE cars (
	car_id SERIAL PRIMARY KEY,
	brand VARCHAR(10) NOT NULL,
	model VARCHAR(25) NOT NULL,
	body_type VARCHAR(15) NOT NULL,
	price INT NOT NULL CHECK (price_idr > 0),
	year INT NOT NULL
);

CREATE TABLE ads (
	ad_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES users(user_id),
	car_id INT NOT NULL REFERENCES cars(car_id),
	description TEXT NOT NULL,
	title VARCHAR(50) NOT NULL,
	negotiable BOOLEAN NOT NULL,
	post_date TIMESTAMP(0) NOT NULL	
);

CREATE TABLE bids (
	bid_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES users(user_id),
	ad_id INT NOT NULL REFERENCES ads(ad_id),
	bid_price INT NOT NULL CHECK (bid_price > 0),
	bid_date TIMESTAMP(0) NOT NULL
);