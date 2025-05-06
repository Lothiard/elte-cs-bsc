package parking.facility;

import java.util.ArrayList;
import vehicle.Car;
import vehicle.Size;
import parking.ParkingLot;

public class Gate {
    private final ArrayList<Car> cars;
    private final ParkingLot parkingLot;
    
    public Gate(ParkingLot parkingLot) {
        this.parkingLot = parkingLot;
        this.cars = new ArrayList<>();
    }

    private Space findTakenSpaceByCar(Car c) {
        for(Space[] floor : parkingLot.getFloorPlan()) {
            for (Space space : floor) {
                if (space.getCarLicensePlate().equals(c.getLicensePlate())) {
                    return space;
                }
            }
        }
        return null;
    }

    private Space findAvailableSpaceOnFloor(int floor, Car c) {
        Space[] currentFloor = parkingLot.getFloorPlan()[floor];
        if(c.getSpotOccupation() == Size.SMALL) {
            for (Space space : currentFloor) {
                if (!space.isTaken()) {
                    return space;
                }
            }
        } else if(c.getSpotOccupation() == Size.LARGE) {
            for (int i = 0; i < currentFloor.length - 1; ++i) {
                if (!currentFloor[i].isTaken() && !currentFloor[i + 1].isTaken()) {
                    return currentFloor[i + 1];
                }
            }
        }
        return null;
    }

    public Space findAnyAvailableSpaceForCar(Car c) {
        for(int i = 0; i < parkingLot.getFloorPlan().length; ++i) {
            if(findAvailableSpaceOnFloor(i, c) != null) {
                return findAvailableSpaceOnFloor(i, c);
            }
        }
        return null;
    }

    // i apologize but if it ain't broke, don't fix it
    public Space findPreferredAvailableSpaceForCar(Car c) {
        int preferredFloor = c.getPreferredFloor();
        if (findAvailableSpaceOnFloor(preferredFloor, c) != null) {
            return findAvailableSpaceOnFloor(preferredFloor, c);
        }

        Space[][] currentLot = parkingLot.getFloorPlan();
        int index = 0;
        int oneway = 0; // 0 = we have not yet reached either side of the lot,
                        // 1 = we have reached the top therefore we can only go down,
                        // -1 = we have reached the bottom therefore we can only go up 

        for (int i = 1; i < currentLot.length; ++i) { // on n floors always check n-1 times since the preferred floor is checked right away
            index = -1 * i;

            if(preferredFloor + index < 0) { // we have reached the bottom of the lot
                oneway = -1;
                index = Math.abs(index);
                break;
            } else if(preferredFloor + index > currentLot.length) { // we have reached the top of the lot
                oneway = 1;
                index = Math.abs(index);
                break;
            } else { // we are still in the lot
                if(findAvailableSpaceOnFloor(index, c) != null) {
                    return findAvailableSpaceOnFloor(index, c);
                }
            }

        }
        switch (oneway) {
            case 1:
                for(int i = index; i > 0; --i) {
                    if (findAvailableSpaceOnFloor(preferredFloor, c) != null) {
                        return findAvailableSpaceOnFloor(preferredFloor, c);
                    }
                }
                break;
            case -1:
                for(int i = index; i < currentLot.length; ++i) {
                    if (findAvailableSpaceOnFloor(preferredFloor, c) != null) {
                        return findAvailableSpaceOnFloor(preferredFloor, c);
                    }
                }
                break;
        }
        return null;
    }

    public boolean registerCar(Car c) {
        if (findPreferredAvailableSpaceForCar(c) == null) {
            return false;
        }
        Space space = findPreferredAvailableSpaceForCar(c);
        parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].addOccupyingCar(c);
        cars.add(c);
        return true;
    }

    public void registerCars(Car... c) {
        for (Car car : c) {
            if (findAnyAvailableSpaceForCar(car) == null) {
                System.err.println("No available space for car: " + car.getLicensePlate());
                continue;
            }
            Space space = findAnyAvailableSpaceForCar(car);
            parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].addOccupyingCar(car);
            cars.add(car);
        }
    }

    public void deRegisterCar(String ticketId) {
        for (Car car : cars) {
            if (car.getTicketId().equals(ticketId)) {
                Space space = findTakenSpaceByCar(car);
                parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].removeOccupyingCar();
                cars.remove(car);
                break;
            }
        }
    }
}
