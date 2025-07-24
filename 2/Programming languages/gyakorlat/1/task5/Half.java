class Half {
    public static void main(String[] args) {
        for(double i = Integer.parseInt(args[0]) + 1; i < Integer.parseInt(args[1]); ++i) {
            System.out.println(i/2);
        }
    }
}
