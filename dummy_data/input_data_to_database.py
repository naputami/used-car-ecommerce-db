import csv
import psycopg2
from psycopg2 import Error

#connect to postgreSQL database
try:
    connection = psycopg2.connect(
        #change the value according to your pgAdmin settings
        user="user",
        password="password",
        host="host",
        port="port",
        database="database_name"
    )

    cursor = connection.cursor()

except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)


def insert_user_dummy(filename):
    """
    A function for inputing user data from csv file to posgreSQL database.

    Args:
    filename (str)

    Return:
    -
    """
    with open(f'{filename}', 'r') as file:
        csv_data = csv.reader(file)
        next(csv_data)  
        for row in csv_data:
            name = row[1]
            phone = row[2]
            city_id = row[3]
            role = row[4]

            insert_query = f"INSERT INTO users (name, phone_number, city_id, role) VALUES ('{name}', '{phone}', '{city_id}', '{role}');"

            cursor.execute(insert_query)

    connection.commit()

def insert_ads_dummy(filename):
    """
    A function for inputing ads data from csv file to posgreSQL database.

    Args:
    filename (str)

    Return:
    -
    """
    with open(f'{filename}', 'r') as file:
        csv_data = csv.reader(file)
        next(csv_data)  
        for row in csv_data:
            user_id = row[1]
            car_id = row[2]
            title = row[3]
            description = row[4]
            color = row[5]
            transmission = row[6]
            mileage = row[7]
            negotiable = row[8]
            post_date = row[9]

            insert_query = f"INSERT INTO ads (user_id, car_id, title, negotiable, description, post_date, color, transmission, mileage) VALUES ('{user_id}', '{car_id}', '{title}', '{negotiable}', '{description}', '{post_date}', '{color}', '{transmission}', {mileage});"

            cursor.execute(insert_query)

    connection.commit()

def insert_bids_dummy(filename):
    """
    A function for inputing bids data from csv file to posgreSQL database.

    Args:
    filename (str)

    Return:
    -
    """
    with open(f'{filename}', 'r') as file:
        csv_data = csv.reader(file)
        next(csv_data)  
        for row in csv_data:
            user_id = row[1]
            ad_id = row[2]
            bid_price = row[3]
            bid_date = row[4]

            insert_query = f"INSERT INTO bids (user_id, ad_id, bid_price, bid_date) VALUES ('{user_id}', '{ad_id}', '{bid_price}', '{bid_date}');"

            cursor.execute(insert_query)

    connection.commit()

insert_user_dummy("csv/users.csv")
insert_ads_dummy("csv/ads.csv")
insert_bids_dummy("csv/bids.csv")