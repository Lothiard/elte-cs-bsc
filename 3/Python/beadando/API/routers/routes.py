from schemas.schema import User, Basket, Item
from fastapi.responses import JSONResponse
from fastapi import HTTPException
from fastapi import APIRouter
from data.filereader import (
    get_user_by_id,
    get_basket_by_user_id,
    get_all_users,
    get_total_price_of_basket,
)
from data.filehandler import (
    add_user,
    add_basket,
    add_item_to_basket,
)

"""

Útmutató a fájl használatához:

- Minden route esetén adjuk meg a response_modell értékét (típus)
- Ügyeljünk a típusok megadására
- A függvények visszatérési értéke JSONResponse() legyen
- Minden függvény tartalmazzon hibakezelést, hiba esetén dobjon egy HTTPException-t
- Az adatokat a data.json fájlba kell menteni.
- A HTTP válaszok minden esetben tartalmazzák a 
  megfelelő Státus Code-ot, pl 404 - Not found, vagy 200 - OK

"""

routers = APIRouter()


@routers.post("/adduser", response_model=User)
def adduser(user: User) -> User:
    try:
        user_data = user.model_dump()
        add_user(user_data)
        return JSONResponse(content=user_data)
    except Exception as e:
        raise HTTPException(status_code=409, detail=f"{str(e)}")


@routers.post("/addshoppingbag")
def addshoppingbag(userid: int) -> str:
    try:
        basket = {"id": userid + 100, "user_id": userid, "items": []}
        add_basket(basket)
        return JSONResponse(content=f"successfully added basket {basket['id']}")
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"{str(e)}")


@routers.post("/additem", response_model=Basket)
def additem(userid: int, item: Item) -> Basket:
    try:
        get_user_by_id(userid)

        item_data = item.model_dump()
        add_item_to_basket(userid, item_data)

        basket = get_basket_by_user_id(userid)
        return JSONResponse(content=basket)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))


@routers.put("/updateitem")
def updateitem(userid: int, itemid: int, updateItem: Item) -> Basket:
    try:
        get_user_by_id(userid)

        basket = get_basket_by_user_id(userid)

        item_found = False
        for item in basket["items"]:
            if item["item_id"] == itemid:
                item_data = updateItem.model_dump()
                item["name"] = item_data["name"]
                item["brand"] = item_data["brand"]
                item["price"] = item_data["price"]
                item["quantity"] = item_data["quantity"]
                item_found = True
                break

        if not item_found:
            raise ValueError(
                f"Item with id {itemid} not found in basket for user {userid}"
            )

        from data.filehandler import load_json, save_json

        data = load_json()

        for basket_data in data["Baskets"]:
            if basket_data["user_id"] == userid:
                basket_data["items"] = basket["items"]
                break

        save_json(data)

        updated_basket = get_basket_by_user_id(userid)
        return JSONResponse(content=updated_basket)

    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))


@routers.delete("/deleteitem")
def deleteitem(userid: int, itemid: int) -> Basket:
    try:
        get_user_by_id(userid)

        basket = get_basket_by_user_id(userid)

        item_found = False
        for i, item in enumerate(basket["items"]):
            if item["item_id"] == itemid:
                basket["items"].pop(i)
                item_found = True
                break

        if not item_found:
            raise ValueError(
                f"Item with id {itemid} not found in basket for user {userid}"
            )

        from data.filehandler import load_json, save_json

        data = load_json()

        for basket_data in data["Baskets"]:
            if basket_data["user_id"] == userid:
                basket_data["items"] = basket["items"]
                break

        save_json(data)

        updated_basket = get_basket_by_user_id(userid)
        return JSONResponse(content=updated_basket)

    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))


@routers.get("/user")
def user(userid: int) -> User:
    try:
        user = get_user_by_id(userid)
        return JSONResponse(content=user)
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"{str(e)}")


@routers.get("/users")
def users() -> list[User]:
    return JSONResponse(content=get_all_users())


@routers.get("/shoppingbag")
def shoppingbag(userid: int) -> list[Item]:
    try:
        return JSONResponse(content=get_basket_by_user_id(userid)["items"])
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"{str(e)}")


@routers.get("/getusertotal")
def getusertotal(userid: int) -> float:
    try:
        return JSONResponse(content=get_total_price_of_basket(userid))
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"{str(e)}")
