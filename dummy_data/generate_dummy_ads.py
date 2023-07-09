from faker import Faker
import random
from datetime import datetime, timedelta
from csv_helper import *

fake = Faker('id_ID')

#open user.csv to get user id data
with open('csv/users.csv', mode='r') as file:
    csv_reader = csv.DictReader(file)

    user_ids = [row["user_id"] for row in csv_reader if row["role"] == "Seller"]

#open car_product.csv to get car data
with open('csv/car_product.csv', mode='r') as file:
    csv_reader = csv.DictReader(file)

    cars_data = []
    for row in csv_reader:
        cars_data.append({
            "product_id": row["product_id"],
            "brand" : row["brand"],
            "model" : row["model"],
            "body_type" : row["body_type"],
            "year" : row["year"],
            "price" : row["price"]
        })


def generate_dummy_ads(n, cars_data, users_data):
    """
    A function for generating advertisment data.
    
    Args
    n (int) : desired number of ads to be generated
    users_data (list) : list of user id
    cars_data (list) : list of cars data

    Return
    ads_data (list)
    """
    ads_data = []
    for i in range(1, n+1):
        ad_id = i
        user_id = random.choice(users_data)
        index_car_data = random.randint(0, (len(cars_data)-1))
        car_id = cars_data[index_car_data]["product_id"]
        title = f'{cars_data[index_car_data]["year"]} {cars_data[index_car_data]["model"]} {cars_data[index_car_data]["body_type"]}'
        color = random.choice(["Merah", "Hitam", "Silver", "Putih", "Biru", "Abu-abu", "Hijau", "Oranye", "Coklat", "Kuning"])
        mileage = random.randint(10000, 80000)
        transmission = random.choice(["Automatic", "Manual"])
        negotiable = random.choice([True, False])
        desc = f'Warna: {color} Jarak tempuh: {mileage} Tipe mobil: {transmission} Harga: {cars_data[index_car_data]["price"]} Bisa nego: {"Iya" if negotiable else "Tidak"}'
        post_date = fake.date_time_between_dates(datetime_start =datetime(2022, 1, 1, 0, 0, 0), datetime_end =datetime(2023, 1, 1, 23, 59, 59)).strftime("%Y-%m-%d %H:%M:%S")
        ads_data.append({
            "ad_id" : ad_id,
            "user_id" : user_id,
            "car_id" : car_id,
            "title" : title,
            "description" : desc,
            "color": color,
            "transmission" : transmission,
            "mileage" : mileage,
            "negotiable" : negotiable,
            "post_date" : post_date,
        })

    return ads_data

#define columns for ads table
ad_cols = ["ad_id", "user_id", "car_id", "title", "description", "color", "transmission", "mileage", "negotiable",  "post_date"]
#generate rows for ads table
ad_rows = generate_dummy_ads(200, cars_data, user_ids)
#save to ads.csv
save_to_csv("csv/ads.csv", ad_cols, ad_rows)