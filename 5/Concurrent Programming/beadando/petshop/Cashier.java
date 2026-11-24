package petshop;

public class Cashier implements Runnable {
    private PetShop petShop;

    public Cashier(PetShop petShop) {
        this.petShop = petShop;
    }

    @Override
    public void run() {
        // 1. ismételjük a műveleteket, amíg meg nem szakítják a szálat
        while (!Thread.currentThread().isInterrupted()) {
            try {
                // 2. vegyük ki a következő fizetési kérelmet a boltból (blokkoló művelet)
                CheckoutRequest request = petShop.getNextCheckout();

                // 3. dolgozzuk fel a petShop.processCheckout() segítségével
                petShop.processCheckout(request);
            } catch (InterruptedException e) {
                // 4. InterruptedException esetén álljunk le (állítsuk vissza a megszakításjelzőt)
                Thread.currentThread().interrupt();
                break;
            }
        }

    }
}
