package dao;

import java.util.List;

import model.Accommodation;
import model.Category;
import model.Reservation;
import model.Room;
import model.StartEnd;

public interface SearchDao {
	List<Accommodation> getAccListByCon(Accommodation ACC, Category TYPE, Room CAPA, 
	         Reservation RESERV, StartEnd se);
	Integer getAccCountByCon(Accommodation ACC, Category TYPE, Room CAPA, Reservation RESERV);
}
