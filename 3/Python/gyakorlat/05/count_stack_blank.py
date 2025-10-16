from stack import Stack

class CountingStack(Stack):
    def __init__(self):
        pass

    def get_counter(self):
        pass

    def pop(self):
        pass

stk = CountingStack()
for i in range(100):
    stk.push(i)
    stk.pop()
print(stk.get_counter())