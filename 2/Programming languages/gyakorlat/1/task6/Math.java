class Math {
    public static void main(String[] args) {
        int a = Integer.parseInt(args[0]);
        int b = Integer.parseInt(args[1]);

        System.out.println("Osszeg:");
        System.out.println(a + b);
        System.out.println("Kulonbseg:");
        System.out.println(a - b);
        System.out.println("Szorzat:");
        System.out.println(a * b);
        System.out.println("Hanyados:");
        if(b == 0) {
            System.err.println("Nullaval nem osztunk");
        } else {
            System.out.println(a / b);
            System.out.println("Osztasi maradek:");
            System.out.println(a % b);
        }
    }    
}
