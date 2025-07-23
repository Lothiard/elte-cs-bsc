namespace PointCircle {
    internal class Program {
        static void Main(string[] args) {
            // Thread.CurrentThread.CurrentCulture = new CultureInfo(hu-HU);
            
            List<Point> points = new List<Point>();
            Circle circle;

            using StreamReader sr = new("input.txt");

            string[] circleParts = sr.ReadLine()!.Split(' ');
            int circleCount = int.Parse(sr.ReadLine()!);
            circle = new Circle(
                new Point(
                    double.Parse(circleParts[0]),
                    double.Parse(circleParts[1])
                ),
                double.Parse(circleParts[2])
            );

            for(int i = 0; i < circleCount; ++i) {
                string[] pointCoords = sr.ReadLine()!.Split();
                points.Add(
                    new Point(
                        int.Parse(pointCoords[0]),
                        int.Parse(pointCoords[1])
                    )
                );
            }

            Console.WriteLine(circle);
            foreach (Point point in points) {
                Console.WriteLine(point);
            }

            Console.WriteLine($"A pontot: {points[3]} tartalmazza a kör: {circle.Contains(points[3])}");
            Console.WriteLine($"A pontot: {points[4]} tartalmazza a kör: {circle.Contains(points[4])}");

            circle.Contains(points[3]);
            circle.Contains(points[4]);
        }
    }
}
