package parking;

import parking.facility.Space;

public class ParkingLot {
    private final Space[][] floorPlan;

    public Space[][] getFloorPlan() {
        return this.floorPlan;
    }

    public ParkingLot(int floorNumber, int spaceNumber) throws IllegalArgumentException {
        if(floorNumber < 1 || spaceNumber < 1) {
            throw new IllegalArgumentException();
        }
        floorPlan = new Space[floorNumber][spaceNumber];

        for (int i = 0; i < floorNumber; i++) {
            for (int j = 0; j < spaceNumber; j++) {
                floorPlan[i][j] = new Space(i, j);
            }
        }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Space[] floor : floorPlan) {
            for (Space space : floor) {
                if(space.getOccupyingCarSize() == null) {
                    sb.append("X ");
                } else if(space.getOccupyingCarSize() == vehicle.Size.SMALL) {
                    sb.append("S ");
                } else if(space.getOccupyingCarSize() == vehicle.Size.LARGE) {
                    sb.append("L ");
                }
            }
            sb.append("\n");
        }
        return sb.toString();
    }
}