import json
from typing import Dict, List, Any

JSON_FILE_PATH = "D:\\Egyetem\\2025-26-1\\Python gyak\\gyak06\\todo\\data\\data.json"

def load_json() -> Dict[str, Any]:
    with open(JSON_FILE_PATH, "r", encoding="utf-8") as file:
        data = json.load(file)
        return data

def get_all_users() -> List[Dict[str,Any]]:
    return load_json()["users"]

def get_user_by_id(user_id : int) -> Dict[str,Any]:
    data = load_json()
    for user in data["users"]:
        if user["user_id"] == user_id:
            return user
    raise ValueError(f"User not found with given id. ID: {user_id}")

def get_all_todos() -> List[Dict[str,Any]]:
    return load_json()["todo_list"]

def get_todos_by_user(user_id : int) -> List[Dict[str,Any]]:
    data = load_json()
    for todos in data["todo_list"]:
        if todos["user_id"] == user_id:
            return todos["todos"]
    raise ValueError(f"No todos found with given user id. User ID: {user_id}")

