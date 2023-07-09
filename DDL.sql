CREATE TABLE cities (
	city_id PRIMARY KEY,
	city_name VARCHAR(12) NOT NULL UNIQUE,
	latitude NUMERIC(9,6) NOT NULL UNIQUE,
	longitude NUMERIC(9,6) NOT NULL UNIQUE
);

CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(20) NOT NULL UNIQUE,
	city_id INT NOT NULL REFERENCES cities(city_id),
	role VARCHAR(6) NOT NULL CHECK (role in ('Seller', 'Buyer'))  
);

CREATE TABLE cars (
	car_id SERIAL PRIMARY KEY,
	brand VARCHAR(10) NOT NULL,
	model VARCHAR(25) NOT NULL,
	body_type VARCHAR(15) NOT NULL,
	price INT NOT NULL CHECK (price > 0),
	year INT NOT NULL
);

CREATE TABLE ads (
	ad_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES users(user_id),
	car_id INT NOT NULL REFERENCES cars(car_id),
	title VARCHAR(50) NOT NULL,
	description TEXT NOT NULL,
	color VARCHAR(15) NOT NULL,
	transmission VARCHAR(15) NOT NULL CHECK (transmission in ('Automatic', 'Manual')),
	mileage INT NOT NULL,
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

--create trigger function for ensuring that user_id in ads table is "Seller"
CREATE FUNCTION validate_seller_role()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE user_id = NEW.user_id AND role = 'Seller'
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'User must have role "Seller"';
    END IF;
END;
$$ LANGUAGE plpgsql;

--create trigger object for validate_seller_role()
CREATE TRIGGER ads_seller_role_trigger
BEFORE INSERT OR UPDATE ON ads
FOR EACH ROW
EXECUTE FUNCTION validate_seller_role();

--create trigger function for ensuring that user_id in bids table is "Buyer"
CREATE FUNCTION validate_buyer_role()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM users
        WHERE user_id = NEW.user_id AND role = 'Buyer'
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'User must have role "Buyer"';
    END IF;
END;
$$ LANGUAGE plpgsql;

--create trigger object for validate_buyer_role()
CREATE TRIGGER bids_buyer_role_trigger
BEFORE INSERT OR UPDATE ON bids
FOR EACH ROW
EXECUTE FUNCTION validate_buyer_role();

--create trigger function for ensuring that ad_id in bids table has value "true" in ads.negotiable field
CREATE FUNCTION validate_negotiable_ad()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM ads
        WHERE ad_id = NEW.ad_id AND negotiable = true
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Car price must be negotiable';
    END IF;
END;
$$ LANGUAGE plpgsql;

--create trigger object for validate_negotiable_ad()
CREATE TRIGGER bids_negotiable_ad_trigger
BEFORE INSERT OR UPDATE ON bids
FOR EACH ROW
EXECUTE FUNCTION validate_negotiable_ad();