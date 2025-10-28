from pydantic import BaseModel, Field, EmailStr

"""

Útmutató a fájl használatához:

Az osztályokat a schema alapján ki kell dolgozni.

A schema.py az adatok küldésére és fogadására készített osztályokat tartalmazza.
Az osztályokban az adatok legyenek validálva.
 - az int adatok nem lehetnek negatívak.
 - az email mező csak e-mail formátumot fogadhat el.
 - Hiba esetén ValuErrort kell dobni, lehetőség szerint ezt a 
   kliens oldalon is jelezni kell.

"""

ShopName = "Bolt"


class User(BaseModel):
    id: int = Field(..., gt=0)
    name: str = Field(..., min_length=3, max_length=512)
    email: EmailStr = Field(...)


class Basket(BaseModel):
    id: int = Field(..., gt=0)
    user_id: int = Field(..., gt=0)


class Item(BaseModel):
    item_id: int = Field(..., gt=0)
    name: str = Field(..., min_length=3, max_length=512)
    brand: str = Field(..., min_length=3, max_length=512)
    price: float = Field(...)
    quantity: int = Field(..., gt=0)
