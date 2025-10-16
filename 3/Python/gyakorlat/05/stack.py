#Definiáljuk a Stack adatszerkezetet
#Emlékeztető: Stack műveletek: push, pop, peek, isEmpty, size

class Stack():
    def __init__(self):
        self.stack = []

    def push(self,item):
        self.stack.append(item)

    def pop(self):
        if self.isEmpty():
            return "Empty stack!"
        val = self.stack[-1]
        del self.stack[-1]
        return val
    
    def peek(self):
        if self.isEmpty():
            return "Empty stack!"
        return self.stack[-1]
    
    def isEmpty(self):
        return len(self.stack) == 0
    
    def size(self):
        return len(self.stack)
    
myStack = Stack()

'''myStack.push(1)
myStack.push(2)
myStack.push(3)
myStack.push(4)
myStack.push(5)
myStack.push(6)
myStack.push(7)
myStack.push('A')'''

'''print("Stack: ", myStack.stack)
print("Pop: ", myStack.pop())
print("Stack after pop: ", myStack.stack)
print("Peek: ", myStack.peek())
print("isEmpty: ", myStack.isEmpty())
print("Size: ", myStack.size())'''