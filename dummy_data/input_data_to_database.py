import csv
import psycopg2
from psycopg2 import Error

#connect to postgreSQL database
try:
    connection = psycopg2.connect(
        user="postgres",
        password="GaNbarou23",
        host="localhost",
        port="5432",
        database="finalproject_pacmann"
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

            insert_query = f"INSERT INTO users (name, phone_number, city_id) VALUES ('{name}', '{phone}', '{city_id}');"

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
            color = row[4]
            mileage =  row[5]
            transmisiion = row[6] 
            negotiable = row[7]
            description = row[8]
            post_date = row[9]

            insert_query = f"INSERT INTO ads (user_id, car_id, title, color, mileage_km, transmission, negotiable, description, post_date) VALUES ('{user_id}', '{car_id}', '{title}', '{color}', '{mileage}', '{transmisiion}', '{negotiable}', '{description}', '{post_date}');"

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
            bid_status = row[4]
            bid_date = row[5]

            insert_query = f"INSERT INTO bids (user_id, ad_id, bid_price, bid_status, bid_date) VALUES ('{user_id}', '{ad_id}', '{bid_price}', '{bid_status}', '{bid_date}');"

            cursor.execute(insert_query)

    connection.commit()

# insert_user_dummy("user.csv")
# insert_ads_dummy("ads.csv")

insert_bids_dummy("bids.csv")