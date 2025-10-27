from schemas.schema import User, UserAdd, Todo, TodoAdd, TodoUpdate, TodoList
from fastapi.responses import JSONResponse, RedirectResponse
from fastapi import FastAPI, HTTPException, Request, Response, Cookie
from fastapi import APIRouter
from data.filereader import get_all_todos, get_all_users, get_todos_by_user, get_user_by_id
from data.filehandler import add_todo, add_todolist, add_user, delete_todo, update_todo

routers = APIRouter()

@routers.get('/users', response_model=User)
def users() -> list[User]:
    return JSONResponse(content=get_all_users())

@routers.get('/user', response_model=User)
def user(user_id : int) -> User:
    try:
        user = get_user_by_id(user_id)
        return JSONResponse(content=user)
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"User not found! {str(e)}")

@routers.get('/todos', response_model=TodoList)
def todos(first_n : int = None) -> list[TodoList]:
    try:
        if first_n:
            return JSONResponse(content=get_all_todos()[:first_n])
        else:
            return JSONResponse(content=get_all_todos())
    except Exception as e:
        raise HTTPException(status_code=404, detail=str(e)) 

#PATH PARAMETER
#QUERY PARAMETER

@routers.get('/todo/{user_id}', response_model=Todo)
def todos(user_id : int) -> list[Todo]:
    try:
        return JSONResponse(content=get_todos_by_user(user_id))
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"User not found! {str(e)}")
        
@routers.post('/adduser', response_model=User)
def adduser(user: UserAdd) -> User:
    try:
        user_data = user.model_dump()
        add_user(user_data)
        return JSONResponse(content=user_data)
    except Exception as e:
        raise HTTPException(status_code=409, detail=f"Couldn't add user: {str(e)}, {user}")

@routers.post('/addtodolist', response_model=str)
def addtodolist(user_id : int) -> str:
    try:
        add_todolist(user_id)
        return JSONResponse(content="Successfully added a to-do list.")
    except Exception as e:
        raise HTTPException(status_code=409, detail=f"To-do list couldn't be added. {str(e)}")

@routers.post('/addtodo', response_model=str)
def addtodo(user_id: int, todo : TodoAdd) -> str:
    try:
        todo_data = todo.model_dump()
        add_todo(user_id,todo_data)
        return JSONResponse(content="Successfully added a to-do.")
    except Exception as e:
        raise HTTPException(status_code=409, detail=f"Todo couldn't be added. {str(e)}")

@routers.put('/update_todo', response_model=str)
def updatetodo(user_id : int,todo_id : int, updated_todo : TodoUpdate) -> str:
    try:
        update = updated_todo.model_dump()
        update_todo(user_id, todo_id, update)
        return JSONResponse(content="Todo updated successfully.")
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"Error. {str(e)}")
        
@routers.delete('/delete_todo', response_model= str)
def deletetodo(user_id : int, todo_id : int) -> str:
    try:
        delete_todo(user_id, todo_id)
        return JSONResponse(content="Todo successfully deleted.")
    except Exception as e:
        raise HTTPException(status_code=404, detail=f"User not found. {str(e)}")