package vehicle;

public class Car {
    private final String licensePlate;
    private final Size spotOccupation;
    private int preferredFloor;
    private String ticketId;

    public Car(String licensePlate, Size spotOccupation, int preferredFloor) {
        this.licensePlate = licensePlate;
        this.spotOccupation = spotOccupation;
        this.preferredFloor = preferredFloor;
    }

    public String getLicensePlate() {
        return this.licensePlate;
    }

    public Size getSpotOccupation() {
        return this.spotOccupation;
    }

    public int getPreferredFloor() {
        return this.preferredFloor;
    }

    public String getTicketId() {
        return this.ticketId;
    }

    public void setPreferredFloor(int preferredFloor) {
        this.preferredFloor = preferredFloor;
    }

    public void setTicketId(String ticketId) {
        this.ticketId = ticketId;
    }
}
