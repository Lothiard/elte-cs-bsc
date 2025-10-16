#Hasznos beépített osztálymetódusok

from stack import Stack

stc = Stack()

stc.push(1)
stc.push(2)
stc.push(3)
stc.push(4)
stc.push(5)

print(stc.__init__)
print(stc.__dict__)
print(type(stc).__name__)
print(stc.__module__)