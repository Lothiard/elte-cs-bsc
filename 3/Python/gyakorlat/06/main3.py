from fastapi import FastAPI
from routes.routes import routers as routes_router

app = FastAPI()
app.include_router(routes_router)

@app.get('/')
def index():
    return {"Welcome to" : "My To-Do list"}