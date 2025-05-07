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
        Space[][] currentFloor = parkingLot.getFloorPlan();
        if(c.getSpotOccupation() == Size.SMALL) {
            for(Space[] floor : currentFloor) {
                for (Space space : floor) {
                    if (space.getCarLicensePlate() != null && space.getCarLicensePlate().equals(c.getLicensePlate())) {
                        return space;
                    }
                }
            }
        } else if (c.getSpotOccupation() == Size.LARGE) {
            for(int i = 0; i < currentFloor.length; ++i) {
                for(int j = 1; j < currentFloor[i].length; ++j) {
                    if (currentFloor[i][j].getCarLicensePlate() != null && currentFloor[i][j].getCarLicensePlate().equals(c.getLicensePlate())) {
                        return currentFloor[i][j];
                    }
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

    private static boolean allVisited(boolean visited[]) {
        for(int i = 0; i < visited.length; ++i) {
            if(visited[i] == false) {
                return false;
            }
        }
        return true;
    }

    public Space findPreferredAvailableSpaceForCar(Car c) {
        int preferredFloor = c.getPreferredFloor();
        Space[][] currentLot = parkingLot.getFloorPlan();
        boolean[] visited = {false, false, false, false, false};

        int step = 0;
        while(!allVisited(visited)) {
            int index;
            if (step % 2 == 0) {
                index = preferredFloor - step / 2;
            } else {
                index = preferredFloor + (step + 1) / 2;
            }

            if (index >= 0 && index < parkingLot.getFloorPlan().length && !visited[index]) {
                if(findAvailableSpaceOnFloor(index, c) != null) {
                    return findAvailableSpaceOnFloor(index, c);
                }
                visited[index] = true;
            }
            step++;
        }
        return null;
    }

    public boolean registerCar(Car c) {
        if (findPreferredAvailableSpaceForCar(c) == null) {
            return false;
        }
        if (c.getSpotOccupation() == Size.SMALL) {
            Space space = findPreferredAvailableSpaceForCar(c);
            parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].addOccupyingCar(c);
            cars.add(c);
            return true;
        } else if (c.getSpotOccupation() == Size.LARGE) {
            Space space = findPreferredAvailableSpaceForCar(c);
            parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].addOccupyingCar(c);
            parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber() - 1].addOccupyingCar(c);
            cars.add(c);
        }
        return true;
    }

    public void registerCars(Car... c) {
        for (Car car : c) {
            if (findAnyAvailableSpaceForCar(car) == null) {
                System.err.println("No available space for car: " + car.getLicensePlate());
                continue;
            }
            registerCar(car);
        }
    }

    public void deRegisterCar(String ticketId) {
        Car carToDeRegister = null;

        for (Car car : cars) {
            if(car.getTicketId().equals(ticketId)) {
                carToDeRegister = car;
                if(car.getSpotOccupation() == Size.SMALL) {
                    Space space = findTakenSpaceByCar(car);
                    parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].removeOccupyingCar();
                } else if (car.getSpotOccupation() == Size.LARGE) { 
                    Space space = findTakenSpaceByCar(car);
                    parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber()].removeOccupyingCar();
                    parkingLot.getFloorPlan()[space.getFloorNumber()][space.getSpaceNumber() - 1].removeOccupyingCar();
                    break;
                }
            }
        }
        cars.remove(carToDeRegister);
    }
}
