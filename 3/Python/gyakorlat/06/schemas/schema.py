from enum import IntEnum
from pydantic import BaseModel, Field, field_validator, EmailStr
from typing import Optional, List

class Priority(IntEnum):
    LOW = 3
    MEDIUM = 2
    HIGH = 1

class User(BaseModel):
    user_name : str = Field(...,min_length=3, max_length=512, description="Name of the user")
    user_email : EmailStr = Field(...,description="Email address of the user")
        
class UserAdd(User):
    pass
        
class TodoBase(BaseModel):
    todo_name : str = Field(...,min_length=3, max_length=512, description="Name of todo")
    todo_description : str = Field(...,min_length=3, description="Description of todo")
    todo_priority : Priority = Field(default=Priority.LOW, description="Priority of todo")

class TodoAdd(TodoBase):
    pass

class Todo(TodoBase):
    todo_id : int = Field(...,description="Unique id of todo")

class TodoUpdate(BaseModel):
    todo_name : Optional[str] = Field(None,min_length=3, max_length=512, description="Name of todo")
    todo_description : Optional[str] = Field(None,min_length=3, description="Description of todo")
    todo_priority : Optional[Priority] = Field(None, description="Priority of todo")

class TodoList(BaseModel):
    id : int = Field(...,gt=0,description="Unique id of the todos'.")
    user_id : int = Field(...,gt=0, description="Unique id of the user.")
    todos : List[Todo] = Field(default_factory=list, description="List of the users' todos'.")