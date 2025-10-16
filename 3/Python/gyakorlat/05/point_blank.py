import math

class Point:
    def __init__(self, x=0.0, y=0.0):
        pass

    def getx(self):
        pass

    def gety(self):
        pass

    def distance_from_xy(self,x,y):
        pass

    def distance_from_point(self,point):
        pass

point1 = Point(0,0)
point2 = Point(1,1)

print(point1.distance_from_xy(2,0))
print(point1.distance_from_point(point2))