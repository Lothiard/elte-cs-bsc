import json
from typing import Dict, Any
from data.filereader import get_user_by_id

"""

Útmutató a fájl függvényeinek a használatához

Új felhasználó hozzáadása:

new_user = {
    "id": 4,  # Egyedi felhasználó azonosító
    "name": "Szilvás Szabolcs",
    "email": "szabolcs@plumworld.com"
}

Felhasználó hozzáadása a JSON fájlhoz:

add_user(new_user)

Hozzáadunk egy új kosarat egy meglévő felhasználóhoz:

new_basket = {
    "id": 104,  # Egyedi kosár azonosító
    "user_id": 2,  # Az a felhasználó, akihez a kosár tartozik
    "items": []  # Kezdetben üres kosár
}

add_basket(new_basket)

Új termék hozzáadása egy felhasználó kosarához:

user_id = 2
new_item = {
    "item_id": 205,
    "name": "Szilva",
    "brand": "Stanley",
    "price": 7.99,
    "quantity": 3
}

Termék hozzáadása a kosárhoz:

add_item_to_basket(user_id, new_item)

Hogyan használd a fájlt?

Importáld a függvényeket a filehandler.py modulból:

from filehandler import (
    add_user,
    add_basket,
    add_item_to_basket,
)

 - Hiba esetén ValuErrort kell dobni, lehetőség szerint ezt a 
   kliens oldalon is jelezni kell.

"""

# A JSON fájl elérési útja
JSON_FILE_PATH = "data/data.json"


def load_json() -> Dict[str, Any]:
    with open(JSON_FILE_PATH, "r", encoding="utf-8") as file:
        data = json.load(file)
        return data


def save_json(data: Dict[str, Any]) -> None:
    with open(JSON_FILE_PATH, "w") as file:
        json.dump(data, file, indent=4)


def add_user(user: Dict[str, Any]) -> None:
    data = load_json()

    for existing_user in data["Users"]:
        if existing_user["id"] == user["id"]:
            raise ValueError(f"User id already exists. ID: {user['id']}")

    data["Users"].append(user)
    save_json(data)


def add_basket(basket: Dict[str, Any]) -> None:
    data = load_json()

    get_user_by_id(basket["user_id"])

    for existing_basket in data["Baskets"]:
        if existing_basket["user_id"] == basket["user_id"]:
            raise ValueError(f"User already has a basket. User ID: {basket['user_id']}")

    data["Baskets"].append(basket)
    save_json(data)


def add_item_to_basket(user_id: int, item: Dict[str, Any]) -> None:
    data = load_json()

    basket_found = False
    for basket in data["Baskets"]:
        if basket["user_id"] == user_id:
            basket_found = True

            item_found = False
            for existing_item in basket["items"]:
                if existing_item["item_id"] == item["item_id"]:
                    existing_item["quantity"] += item.get("quantity", 1)
                    item_found = True
                    break

            if not item_found:
                basket["items"].append(item)

            break

    if not basket_found:
        raise ValueError(f"No basket found for user_id: {user_id}")

    save_json(data)

