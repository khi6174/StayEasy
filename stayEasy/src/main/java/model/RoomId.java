package model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class RoomId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	 @Column(name = "room_id")
	 private String roomId;
	 
	 @Column(name = "accommodation_id")
	 private String accommodationId;
	 
	// 기본 생성자
	    public RoomId() {}

	    // 생성자
	    public RoomId(String roomId, String accommodationId) {
	        this.roomId = roomId;
	        this.accommodationId = accommodationId;
	    }

		public String getRoomId() {
			return roomId;
		}

		public void setRoomId(String roomId) {
			this.roomId = roomId;
		}

		public String getAccommodationId() {
			return accommodationId;
		}

		public void setAccommodationId(String accommodationId) {
			this.accommodationId = accommodationId;
		}
		
		// equals() & hashCode() 오버라이딩 (필수)
	    @Override
	    public boolean equals(Object o) {
	        if (this == o) return true;
	        if (o == null || getClass() != o.getClass()) return false;
	        RoomId roomId1 = (RoomId) o;
	        return Objects.equals(roomId, roomId1.roomId) &&
	               Objects.equals(accommodationId, roomId1.accommodationId);
	    }

	    @Override
	    public int hashCode() {
	        return Objects.hash(roomId, accommodationId);
	    }
	    
}
