#Feladat: Írjuk meg a saját sor adatszerkezetünket.
#Emlékezető: A Queue FIFO (First-In First-Out) típusú
#            put(item) - hozzáad egy elemet a sor végére
#            get() - kiveszi az első elemet a sorból
#Segítség:
#-használj itt is listát az elemek tárolására
#-a put() a lista elejére teszi az elemet
#-a get() pedig a végéről veszi ki

class QueueError(Exception):
    pass

class Queue:
    def __init__(self):
        pass

    def put(self,item):
        pass

    def get(self):
        pass

que = Queue()
que.put(1)
que.put("dog")
que.put(False)
try:
    for i in range(4):
        print(que.get())
except:
    print("Queue error!")