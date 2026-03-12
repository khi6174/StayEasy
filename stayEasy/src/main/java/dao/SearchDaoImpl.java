package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.Accommodation;
import model.Category;
import model.Reservation;
import model.Room;
import model.StartEnd;

@Repository
public class SearchDaoImpl implements SearchDao {

	@Autowired
	private SqlSession sqlsession;

	
	@Override
	public List<Accommodation> getAccListByCon(Accommodation ACC, Category TYPE, Room CAPA,
			Reservation RESERV, StartEnd se) {
		Map<String, Object> params = new HashMap<>();
		params.put("NAME", ACC.getAccname());
		params.put("LOC", ACC.getLocation());
		params.put("TYPE", TYPE.getCategory_id());
		params.put("CAPA", CAPA.getCapacity());
		params.put("CHECKIN", RESERV.getCheck_in_date());
		params.put("CHECKOUT", RESERV.getCheck_out_date());
		params.put("START", se.getStart());
		params.put("END", se.getEnd());
		return this.sqlsession.selectList("searchMapper.getAccListByCon", params);
	}

	@Override
	public Integer getAccCountByCon(Accommodation ACC, Category TYPE, Room CAPA, Reservation RESERV) {
		Map<String, Object> params = new HashMap<>();
		params.put("NAME", ACC.getAccname());
		params.put("LOC", ACC.getLocation());
		params.put("TYPE", TYPE.getCategory_id());
		params.put("CAPA", CAPA.getCapacity());
		params.put("CHECKIN", RESERV.getCheck_in_date());
		params.put("CHECKOUT", RESERV.getCheck_out_date());
		return this.sqlsession.selectOne("searchMapper.getAccCountByCon", params);
	}

}
