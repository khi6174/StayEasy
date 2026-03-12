package model;

public class RoomCompareDTO {
	private Room originRoom; // 기존 방
    private RoomUpdate updateRoom; // 수정 요청 방 (없을 수도)

    // 생성자
    public RoomCompareDTO(Room originRoom, RoomUpdate updateRoom) {
        this.originRoom = originRoom;
        this.updateRoom = updateRoom;
    }

	public Room getOriginRoom() {
		return originRoom;
	}

	public void setOriginRoom(Room originRoom) {
		this.originRoom = originRoom;
	}

	public RoomUpdate getUpdateRoom() {
		return updateRoom;
	}

	public void setUpdateRoom(RoomUpdate updateRoom) {
		this.updateRoom = updateRoom;
	}
    
    
}
