import csv
import random
from datetime import datetime, timedelta
from csv_helper import *


#open user.csv to get user id data
with open('csv/users.csv', mode='r') as file:
    csv_reader = csv.DictReader(file)

    list_user_id = [row["user_id"] for row in csv_reader if row["role"] == "Buyer"]

#open ads.csv to get ads data. Only retrieve needed information for further processing
with open('csv/ads.csv', mode='r') as file:
    csv_reader = csv.DictReader(file)

    ads_data = []
    for row in csv_reader:
        ads_data.append(
            {
                "ad_id" : row["ad_id"],
                "car_id" : row["car_id"],
                "negotiable" : row["negotiable"],
                "post_date" : row["post_date"]
            }
        )

#open car_product.csv to get car data. Only retrieve needed information for further processing
with open('csv/car_product.csv', mode='r') as file:
    csv_reader = csv.DictReader(file)

    cars_data = []
    for row in csv_reader:
        cars_data.append({
            "product_id": row["product_id"],
            "price" : row["price"]
        })


def generate_price_bid(ad_id, ads, cars_data):
    """
    A function for generating bid price lower or same as car price
    
    Args
    ad_id (str)
    cars_data(list) :list of cars data
    ads(list): list of ads data

    Return
    bid price (int)
    """
    car_id = ""
    for item in ads:
        if item["ad_id"] == ad_id:
            car_id = item["car_id"]
            break

    car_price = 0
    for item in cars_data:
        if item["product_id"] == car_id:
            car_price = int(item["price"])
            return random.randint(car_price - 30_000_000, car_price)

def generate_bids_date(ads, ad_id):
    """
    A function for generating bid date after ad post date
    
    Args
    ad_id (str)
    ads(list): list of ads data

    Return
    bid date (str)
    """
    post_datetime = ""
    for item in ads:
        if item["ad_id"] == ad_id:
            post_datetime = item["post_date"]
            break
    
    base_date = datetime.strptime(post_datetime, "%Y-%m-%d %H:%M:%S")
    random_date = base_date + timedelta(days=random.randint(1,120), hours=random.randint(0,23), minutes=random.randint(0,59), seconds=random.randint(0,59))
    return random_date.strftime("%Y-%m-%d %H:%M:%S")

def generate_dummy_bids(n, users, ads):
    """
    A function for generating bids data.
    
    Args
    n (int) : desired number of bids to be generated
    users (list) : list of user id
    ads (list) : list of ads data

    Return
    bids_data (list)
    """
    negotiable_cars = [item for item in ads if item["negotiable"] == 'True']
    if len(negotiable_cars) == 0:
        print("No negotiable car available")
        return
    
    bids_data = []
    for i in range(1, n+1):
        bid_id = i
        ad_id = random.choice(negotiable_cars)["ad_id"]
        user_id = random.choice(users)
        bid_price = generate_price_bid(ad_id, negotiable_cars, cars_data)
        bid_date = generate_bids_date(negotiable_cars, ad_id)
        bids_data.append({
            "bid_id" : bid_id,
            "user_id" : user_id,
            "ad_id" : ad_id,
            "bid_price" : bid_price,
            "bid_date" : bid_date,
        })
    
    return bids_data

#define columns for bids table
bid_cols = ["bid_id", "user_id", "ad_id", "bid_price", "bid_date"]
#generate rows for bids table
bid_rows = generate_dummy_bids(400, list_user_id, ads_data)
#save to bids.csv
save_to_csv("csv/bids.csv", bid_cols, bid_rows)


