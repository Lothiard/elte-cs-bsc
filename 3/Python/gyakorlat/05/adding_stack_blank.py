from stack import Stack

class AddingStack(Stack):
    def __init__(self):
        pass

    def get_sum(self):
        pass

    def push(self,item):
        pass

    def pop(self):
        pass

addingStack = AddingStack()

for i in range(5):
    addingStack.push(i)
print(addingStack.get_sum())

for i in range(5):
    print(addingStack.pop())