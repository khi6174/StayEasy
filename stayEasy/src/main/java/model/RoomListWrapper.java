package model;

import java.util.ArrayList;
import java.util.List;

public class RoomListWrapper {
    private List<Room> rooms = new ArrayList<>();

    // getter, setter
    public List<Room> getRooms() {
        return rooms;
    }

    public void setRooms(List<Room> rooms) {
        this.rooms = rooms;
    }
}