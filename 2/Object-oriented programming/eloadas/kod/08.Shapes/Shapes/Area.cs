//Author:   Gregorics Tibor
//Date:     2021.11.12.
//Title:    Different area calculating and their interface

namespace Shapes
{
    interface IArea
    {
        double Area(double s);
    }

    class SquareArea : IArea
    {
        private SquareArea() { }
        double IArea.Area(double a) 
        {
            return a * a;
        }
        
        private static SquareArea instance;
        public static SquareArea Instance()
        {
            if (instance == null) instance = new SquareArea();
            return instance;
        }
    }

    class CircleArea : IArea
    {
        private CircleArea() { }
        double IArea.Area(double r) 
        {
            return 3.14159 * r * r;
        }

        private static CircleArea instance;
        public static CircleArea Instance()
        {
            if (instance == null) instance = new CircleArea();
            return instance;
        }
    }

    class TriangularArea : IArea
    {
        private TriangularArea() { }
        double IArea.Area(double a)
        {
            return 1.73205 * a * a / 4.0;
        }

        private static TriangularArea instance;
        public static TriangularArea Instance()
        {
            if (instance == null) instance = new TriangularArea();
            return instance;
        }
    }
}
