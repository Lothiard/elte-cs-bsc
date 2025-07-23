namespace Garden {
    abstract public class PlantType {
        private readonly int _ripeningTime;

        public int RipeningTime => _ripeningTime;

        public PlantType (int ripeningTime) {
            _ripeningTime = ripeningTime;
        }
    }

    // novenyfajtak
    abstract public class Vegetable : PlantType {
        public Vegetable (int i) : base(i) { }
    }

    abstract public class Flower : PlantType {
        public Flower (int i) : base(i) { }

    }

    // novenyek
    class Potato : Vegetable {
        private static Potato? _instance; // null by default
        public static Potato Instance => _instance ??= new Potato(6);
        private Potato (int i) : base(i) { }
    }

    class Pea : Vegetable {
        private static Pea? _instance; // null by default
        public static Pea Instance => _instance ??= new Pea(5);
        private Pea (int i) : base(i) { }
    }

    class Onion : Vegetable {
        private static Onion? _instance; // null by default
        public static Onion Instance => _instance ??= new Onion(4);
        private Onion (int i) : base(i) { }
    }

    class Tulip : Flower {
        private static Tulip? _instance; // null by default
        public static Tulip Instance => _instance ??= new Tulip(3);
        private Tulip (int i) : base(i) { }
    }

    class Carnation : Flower {
        private static Carnation? _instance; // null by default
        public static Carnation Instance => _instance ??= new Carnation(2);
        private Carnation (int i) : base(i) { }
    }

    class Rose : Flower {
        private static Rose? _instance; // null by default
        public static Rose Instance => _instance ??= new Rose(1);
        private Rose (int i) : base(i) { }
    }
}
