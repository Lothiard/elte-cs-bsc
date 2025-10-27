import json
from typing import Dict, Any
from data.filereader import get_todos_by_user, get_all_todos, get_all_users, get_user_by_id

JSON_FILE_PATH = "D:\\Egyetem\\2025-26-1\\Python gyak\\gyak06\\todo\\data\\data.json"

def load_json() -> Dict[str, Any]:
    with open(JSON_FILE_PATH, "r", encoding="utf-8") as file:
        data = json.load(file)
        return data

def save_json(data : Dict[str, Any]) -> None:
    with open(JSON_FILE_PATH, "w") as file:
        json.dump(data, file, indent=4)

def add_user(user : Dict[str,Any]) -> None:
    data = load_json()
    new_id = max(user["user_id"] for user in get_all_users()) + 1
    new_user = {
        "user_id" : new_id,
        "user_name" : user["user_name"],
        "user_email" : user["user_email"]
    }
    data["users"].append(new_user)
    save_json(data)
    
def add_todolist(user_id : int) -> None:
    data = load_json()
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            raise ValueError("User already has a to-do list")
    new_id = max(todolist["id"] for todolist in data["todo_list"]) + 1
    new_todolist = {
        "id" : new_id,
        "user_id" : user_id,
        "todos" : []
    }
    data["todo_list"].append(new_todolist)
    save_json(data)
    
def add_todo(user_id : int, new_todo : Dict[str, Any]) -> None:
    data = load_json()
    user_ids = [todolist["user_id"] for todolist in data["todo_list"]]
    if user_id not in user_ids:
        raise ValueError("User not found with given ID!")
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            todos = [todo for todo in todolist["todos"]]
            if len(todos) == 0:
                new_todo_id = 1
            else:
                new_todo_id = max(todo["todo_id"] for todo in todolist["todos"]) + 1
            new_todo = {
                    "todo_id" : new_todo_id,
                    "todo_name" : new_todo["todo_name"], 
                    "todo_description" : new_todo["todo_description"], 
                    "todo_priority" : new_todo["todo_priority"]
                }
            todolist["todos"].append(new_todo)
            save_json(data)

def update_todo(user_id : int,todo_id : int,  update_todo : Dict[str,Any]) -> None:
    data = load_json()
    exisiting_todolist_user_ids = {todolist["user_id"] for todolist in data["todo_list"]}
    if user_id not in exisiting_todolist_user_ids:
        raise ValueError("User not found with given ID!")
    todo_ids = []
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            for todo in todolist["todos"]:
                todo_ids.append(todo["todo_id"])
    if todo_id not in todo_ids:
        raise ValueError("To-do with given ID was not found!")
                
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            for todo in todolist["todos"]:
                if todo["todo_id"] == todo_id:
                    if update_todo["todo_name"]:
                        todo["todo_name"] = update_todo["todo_name"]
                    if update_todo["todo_description"]:
                        todo["todo_description"] = update_todo["todo_description"]
                    if update_todo["todo_priority"]:
                        todo["todo_priority"] = update_todo["todo_priority"]
                    save_json(data)

        
def delete_todo(user_id : int, todo_id : int) -> None:
    data = load_json()
    exisiting_todolist_user_ids = {todolist["user_id"] for todolist in data["todo_list"]}
    if user_id not in exisiting_todolist_user_ids:
        raise ValueError("User not found with given ID!")
    todo_ids = []
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            for todo in todolist["todos"]:
                todo_ids.append(todo["todo_id"])
    if todo_id not in todo_ids:
        raise ValueError("To-do with given ID was not found!")
    todos = get_todos_by_user(user_id)
    for todolist in data["todo_list"]:
        if todolist["user_id"] == user_id:
            todolist["todos"] = [todo for todo in todos if todo["todo_id"] != todo_id]
            save_json(data)