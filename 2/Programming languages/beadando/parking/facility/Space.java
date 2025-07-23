package parking.facility;

import vehicle.Car;
import vehicle.Size;

public class Space {
    private final int floorNumber;
    private final int spaceNumber;
    private Car occupyingCar;

    public Space(int floorNumber, int spaceNumber) {
        this.floorNumber = floorNumber;
        this.spaceNumber = spaceNumber;
    }

    public boolean isTaken() {
        if(occupyingCar == null) {
            return false;
        }
        return true;
    }

    public void addOccupyingCar(Car c) {
        this.occupyingCar = c;
    }

    public void removeOccupyingCar() {
        this.occupyingCar = null;
    }

    public String getCarLicensePlate() {
        if(occupyingCar == null) {
            return null;
        }
        return occupyingCar.getLicensePlate();
    }

    public Size getOccupyingCarSize() {
        if(occupyingCar == null) {
            return null;
        }
        return occupyingCar.getSpotOccupation();
    }

    public int getFloorNumber() {
        return this.floorNumber;
    }

    public int getSpaceNumber() {
        return this.spaceNumber;
    }
}