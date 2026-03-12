package controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dao.AccDao;
import dao.MyInformationDao;
import model.Accommodation;
import model.LoginUser;
import model.Room;
import model.RoomId;
import model.User;
import model.UserInfo;

@Controller
public class AccController {
   
    @Autowired
    private MyInformationDao myInformationDao;
    @Autowired
    private AccDao accDao;

    // 숙소 신청 페이지
    @RequestMapping(value="/acc/putAcc.html", method=RequestMethod.GET)
    public ModelAndView putAccmain(HttpSession session) {
        ModelAndView mav = new ModelAndView("main");

        // 로그인 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

        // 유저 정보 가져오기
        UserInfo userInfo = accDao.getUserInfoById(loginUser.getId());

        // 숙소 객체 생성 및 초기화
        Accommodation accommodation = new Accommodation();
        accommodation.setCategory(new model.Category());
        
        User user = new User();
        user.setUser_id(userInfo.getUser_id()); 
        user.setUsername(userInfo.getUsername()); 
        user.setPhone(userInfo.getPhone()); 
        accommodation.setUser(user);

        
        // 모델 추가
        mav.addObject("BODY", "putAccommodation.jsp");
        mav.addObject("accommodation", accommodation);
        return mav;
    }
    
    
 // 숙소 신청 데이터 저장 (POST 요청)
    @RequestMapping(value="/acc/submitAcc.html", method=RequestMethod.POST)
    public ModelAndView submitAcc(
          @Valid @ModelAttribute("accommodation") Accommodation accommodation,
          	BindingResult br,
            @RequestParam("main_photo") MultipartFile mainPhoto, // 숙소 대표 사진
            @RequestParam("room1_photo") MultipartFile room1Photo,
            @RequestParam("room2_photo") MultipartFile room2Photo,
            @RequestParam("room3_photo") MultipartFile room3Photo,
            @RequestParam("room1_name") String room1Name,
            @RequestParam("room1_price_per_night") Integer room1Price,
            @RequestParam("room1_capacity") Integer room1Capacity,
            @RequestParam("room2_name") String room2Name,
            @RequestParam("room2_price_per_night") Integer room2Price,
            @RequestParam("room2_capacity") Integer room2Capacity,
            @RequestParam("room3_name") String room3Name,
            @RequestParam("room3_price_per_night") Integer room3Price,
            @RequestParam("room3_capacity") Integer room3Capacity,
            HttpSession session
    ) {
        ModelAndView mav = new ModelAndView("main");

        // 로그인 확인
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }
        
        //폼체크
        if (br.hasErrors()) {
	        mav.addObject("BODY", "putAccommodation.jsp");
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }

        // 유저 정보 가져오기
        UserInfo userInfo = myInformationDao.getUser(loginUser.getId());
        if (userInfo == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

        // 숙소 ID 설정
        String newAccId = accDao.getNextAccommodationId();
        accommodation.setAccommodation_id(newAccId);
        
        // 유저 설정
        User user = new User();
        user.setUser_id(userInfo.getUser_id());
        accommodation.setUser(user); // user 추가
        
        // 최저가 설정
        if(room2Price == null) { //방 1개만 있을 때
        	accommodation.setPrice_per_night(room1Price);
        }
        else if(room3Price == null) { //방 2개만 있을 때
        	int minPrice = Math.min(room1Price,room2Price);
        	accommodation.setPrice_per_night(minPrice);
        }
        else { //방 3개 있을 때
	        int minPrice = Math.min(room1Price,Math.min(room2Price,room3Price));
	        accommodation.setPrice_per_night(minPrice);
        }
        
        //숙소 메인 사진 파일 업로드 확인 및 처리
        MultipartFile multiFile = mainPhoto;
        if (multiFile != null && !multiFile.isEmpty()) {
            String fileName = multiFile.getOriginalFilename();
            String path = session.getServletContext().getRealPath("/imgs/" + fileName);
            try (OutputStream os = new FileOutputStream(path);
                 BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
                byte[] buffer = new byte[8156];
                int read;
                while ((read = bis.read(buffer)) > 0) {
                    os.write(buffer, 0, read);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            accommodation.setAcc_image(fileName);
        }

        // 방 정보 리스트 생성
        List<Room> rooms = new ArrayList<>();

        Room room1 = new Room();
        room1.setAccommodation(accommodation);
        room1.setName(room1Name);
        room1.setPrice_per_night(room1Price);
        room1.setCapacity(room1Capacity);
        room1.setId(new RoomId(accDao.getNextRoomId(), newAccId));
        rooms.add(room1);

        if (room2Name != null && !room2Name.trim().isEmpty() && room2Price != null) {
        Room room2 = new Room();
        room2.setAccommodation(accommodation);
        room2.setName(room2Name);
        room2.setPrice_per_night(room2Price);
        room2.setCapacity(room2Capacity);
        room2.setId(new RoomId(accDao.getNextRoomId(), newAccId));
        rooms.add(room2);
        }
        
        if (room3Name != null && !room3Name.trim().isEmpty() && room3Price != null) {
        Room room3 = new Room();
        room3.setAccommodation(accommodation);
        room3.setName(room3Name);
        room3.setPrice_per_night(room3Price);
        room3.setCapacity(room3Capacity);
        room3.setId(new RoomId(accDao.getNextRoomId(), newAccId));
        rooms.add(room3);
        }
        
        MultipartFile[] photos = {room1Photo, room2Photo, room3Photo};
        int photoIndex = 0;
        for (Room room : rooms) {
            MultipartFile roomPhoto = photos[photoIndex];
            photoIndex++;

            if (roomPhoto != null && !roomPhoto.isEmpty()) {
                String fileName = roomPhoto.getOriginalFilename();
                String path = session.getServletContext().getRealPath("/imgs/" + fileName);
                try (OutputStream os = new FileOutputStream(path);
                     BufferedInputStream bis = new BufferedInputStream(roomPhoto.getInputStream())) {
                    byte[] buffer = new byte[8156];
                    int read;
                    while ((read = bis.read(buffer)) > 0) {
                        os.write(buffer, 0, read);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                room.setRoom_image(fileName);
            }
        }

        // 숙소에 방 리스트 추가
        accommodation.setRooms(rooms);

        // DB에 저장
        accDao.insertAccommodation(accommodation);
        for (Room room : rooms) {
            accDao.insertRoom(room, newAccId);
        }

        // 숙소 신청 완료 페이지로 이동
        mav.addObject("BODY", "putAccommodationUpdate.jsp");
        return mav;
    }
    
    @RequestMapping("/acc/myAccommodations.html")
    public ModelAndView myAccommodations(HttpSession session) {
        ModelAndView mav = new ModelAndView("main");

        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null) {
            mav.addObject("BODY", "login.jsp");
            mav.addObject(new LoginUser());
            return mav;
        }

        // 숙소 목록 조회
        List<Accommodation> accommodationList = accDao.getAccommodationsByUser(loginUser.getId());

        // 🔥 데이터 구조를 Map 형태로 변환
        List<Map<String, Object>> accommodations = new ArrayList<>();
        for (Accommodation acc : accommodationList) {
            Map<String, Object> map = new HashMap<>();
            String accId = acc.getAccommodation_id();
            String cateId = this.accDao.getCateIdByAcc(accId);
            String cateName = this.accDao.getCateName(cateId);
            map.put("accommodation_id", accId);
            map.put("accname", acc.getAccname());
            map.put("a_date", acc.getA_date() != null 
                             ? acc.getA_date().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate()
                             .format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"))
                             : "날짜 없음");  
            map.put("app_status", acc.getApp_status());
            map.put("cate_name", cateName); // 카테고리 이름 추가
            accommodations.add(map);
        }
        mav.addObject("accommodations", accommodations);
        mav.addObject("BODY", "myAccommodations.jsp");

        return mav;
    }
}