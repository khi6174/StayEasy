# StayEasy

Spring MVC 기반 숙소 예약 웹 애플리케이션 프로젝트입니다.  
사용자는 숙소를 검색하고 예약할 수 있으며, 숙소 등록자는 숙소 정보를 등록하고 관리할 수 있습니다.  
관리자는 등록된 숙소, 사용자, 예약, 공지사항 등을 관리할 수 있는 숙박 예약 플랫폼 형태의 웹 프로젝트입니다.

## 프로젝트 소개

StayEasy는 숙소 예약 서비스를 주제로 제작한 Spring 기반 웹 애플리케이션입니다.

사용자는 회원가입 및 로그인 후 숙소 목록을 조회하고, 지역별 검색, 숙소 상세 조회, 장바구니, 예약, 리뷰 작성, 문의 작성 등의 기능을 이용할 수 있습니다.

숙소 등록자는 자신의 숙소를 등록하고 수정할 수 있으며, 관리자의 승인 절차를 통해 숙소가 서비스에 노출되는 구조를 구현했습니다.

관리자는 사용자 관리, 숙소 승인 및 거절, 공지사항 관리, 이벤트 관리, 문의 확인 등 서비스 운영에 필요한 기능을 수행할 수 있습니다.

이 프로젝트는 Spring MVC 구조를 기반으로 Controller, DAO, Model, Mapper를 분리하여 구현했으며, JSP 화면과 MyBatis 기반 데이터베이스 연동을 통해 숙박 예약 서비스의 주요 흐름을 구현하는 것을 목표로 했습니다.

## 주요 기능

### 사용자 기능

- 회원가입
- 로그인 / 로그아웃
- 아이디 찾기
- 비밀번호 찾기
- 비밀번호 변경
- 마이페이지
- 숙소 목록 조회
- 숙소 상세 조회
- 지역별 숙소 조회
- 숙소 검색
- 장바구니 담기
- 장바구니 조회 및 수정
- 숙소 예약
- 결제 결과 확인
- 예약 내역 확인
- 리뷰 작성 및 조회
- 문의 작성 및 조회
- 공지사항 조회
- 이벤트 조회

### 숙소 등록자 기능

- 숙소 등록 신청
- 등록한 숙소 목록 조회
- 등록 숙소 상세 조회
- 숙소 정보 수정 신청
- 숙소 승인 / 반려 상태 확인
- 숙소 관련 문의 확인

### 관리자 기능

- 사용자 관리
- 사용자 상세 정보 확인
- 등록 대기 숙소 조회
- 숙소 승인 및 반려
- 등록된 숙소 관리
- 숙소 수정 요청 관리
- 공지사항 작성, 수정, 삭제
- 이벤트 작성, 수정, 삭제
- 문의사항 관리
- 예약 및 서비스 운영 관리

## 기술 스택

### Backend

- Java 1.8
- Spring MVC
- Spring JDBC
- MyBatis
- Oracle DB
- Maven

### Frontend

- JSP
- JSTL
- HTML
- CSS
- JavaScript

### Library / Tool

- Commons FileUpload
- Commons IO
- Commons Email
- Jackson Databind
- Logback
- JUnit

### Server / Environment

- Apache Tomcat
- STS / Eclipse
- Maven WAR Packaging

## 프로젝트 구조

```bash
StayEasy
└── stayEasy
    ├── src
    │   └── main
    │       ├── java
    │       │   ├── controller
    │       │   ├── dao
    │       │   ├── mail
    │       │   ├── mapper
    │       │   ├── model
    │       │   ├── pwdEncoder
    │       │   ├── utils
    │       │   └── mybatisConfig.xml
    │       │
    │       ├── resources
    │       │   ├── spring
    │       │   └── logback.xml
    │       │
    │       └── webapp
    │           ├── WEB-INF
    │           │   ├── view
    │           │   ├── mvc-config.xml
    │           │   └── web.xml
    │           ├── css
    │           ├── imgs
    │           ├── stay
    │           └── index.jsp
    │
    └── pom.xml
```

## 주요 기능 상세

### 1. 회원 기능

사용자는 회원가입을 통해 계정을 생성할 수 있으며, 로그인 후 숙소 예약, 장바구니, 리뷰, 문의, 마이페이지 기능을 이용할 수 있습니다.

아이디 찾기, 비밀번호 찾기, 비밀번호 변경 기능을 통해 계정 관리 기능도 제공합니다.

### 2. 숙소 조회 및 검색 기능

사용자는 전체 숙소 목록을 확인할 수 있으며, 지역별 숙소 조회와 검색 기능을 통해 원하는 숙소를 찾을 수 있습니다.

숙소 상세 페이지에서는 숙소 정보, 객실 정보, 예약 가능 여부, 리뷰 등을 확인할 수 있습니다.

### 3. 장바구니 기능

예약하고 싶은 숙소를 장바구니에 담을 수 있습니다.  
장바구니 화면에서 예약 대상 숙소를 확인하고 예약 단계로 이동할 수 있습니다.

### 4. 예약 기능

사용자는 숙소 상세 정보와 예약 일정을 확인한 후 예약을 진행할 수 있습니다.  
예약 완료 후 결제 결과 화면을 통해 예약 처리 결과를 확인할 수 있습니다.

### 5. 리뷰 기능

사용자는 숙소 이용 후 리뷰를 작성할 수 있습니다.  
리뷰 목록을 통해 다른 사용자의 이용 후기를 확인할 수 있도록 구현했습니다.

### 6. 문의 기능

사용자는 숙소 또는 서비스와 관련된 문의를 작성할 수 있습니다.  
관리자와 숙소 등록자는 문의 내용을 확인하고 대응할 수 있습니다.

### 7. 숙소 등록 및 승인 기능

숙소 등록자는 숙소 정보를 입력하여 등록을 신청할 수 있습니다.  
관리자는 등록 대기 숙소를 확인한 뒤 승인 또는 반려 처리를 할 수 있습니다.

승인된 숙소는 사용자에게 노출되며, 반려된 숙소는 반려 상세 내용을 확인할 수 있습니다.

### 8. 관리자 기능

관리자는 사용자 관리, 숙소 승인 관리, 공지사항 관리, 이벤트 관리, 문의 관리 등 서비스 운영에 필요한 기능을 수행할 수 있습니다.

관리자 전용 화면을 통해 등록 대기 숙소, 등록 완료 숙소, 사용자 정보 등을 확인할 수 있습니다.

### 9. 공지사항 및 이벤트 기능

공지사항과 이벤트를 통해 사용자에게 서비스 관련 정보를 제공할 수 있습니다.  
관리자는 공지사항과 이벤트를 작성, 수정, 삭제할 수 있습니다.

## 주요 Controller

| Controller | 설명 |
|---|---|
| AccController | 숙소 조회, 숙소 상세, 숙소 등록 및 수정 관련 처리 |
| AdminController | 관리자 기능 처리 |
| CartController | 장바구니 기능 처리 |
| EventController | 이벤트 기능 처리 |
| FindController | 아이디 / 비밀번호 찾기 처리 |
| InquireController | 문의사항 처리 |
| LoginController | 로그인 처리 |
| LogoutController | 로그아웃 처리 |
| MypageController | 마이페이지 처리 |
| NoticeController | 공지사항 처리 |
| ReservController | 예약 기능 처리 |
| ReviewController | 리뷰 기능 처리 |
| SearchController | 숙소 검색 처리 |
| StayController | 메인 화면 및 기본 페이지 이동 처리 |

## 주요 Model

| Model | 설명 |
|---|---|
| User | 사용자 정보 |
| LoginUser | 로그인 사용자 정보 |
| UserInfo | 사용자 상세 정보 |
| UserId | 아이디 찾기 관련 정보 |
| UserPwd | 비밀번호 찾기 / 변경 관련 정보 |
| Accommodation | 숙소 정보 |
| AccUpdate | 숙소 수정 요청 정보 |
| Room | 객실 정보 |
| RoomId | 객실 식별 정보 |
| RoomCompareDTO | 객실 비교용 데이터 |
| RoomListWrapper | 객실 목록 처리용 데이터 |
| Reservation | 예약 정보 |
| CartItem | 장바구니 상품 정보 |
| Review | 리뷰 정보 |
| Inquire | 문의 정보 |
| Notice | 공지사항 정보 |
| Event | 이벤트 정보 |
| Category | 숙소 카테고리 정보 |
| Datee | 날짜 처리 관련 정보 |
| StartEnd | 시작일 / 종료일 처리 정보 |

## 화면 구성 예시

### 사용자 화면

- 메인 화면
- 로그인 화면
- 회원가입 화면
- 숙소 목록 화면
- 숙소 상세 화면
- 지역별 숙소 목록 화면
- 숙소 검색 결과 화면
- 장바구니 화면
- 예약 화면
- 결제 결과 화면
- 리뷰 작성 화면
- 리뷰 목록 화면
- 문의 작성 화면
- 마이페이지 화면
- 공지사항 화면
- 이벤트 화면

### 숙소 등록자 화면

- 숙소 등록 화면
- 내 숙소 목록 화면
- 내 숙소 상세 화면
- 숙소 수정 화면
- 숙소 승인 / 반려 결과 화면

### 관리자 화면

- 사용자 관리 화면
- 사용자 상세 정보 화면
- 등록 대기 숙소 목록 화면
- 숙소 승인 상세 화면
- 등록 숙소 관리 화면
- 공지사항 작성 화면
- 이벤트 작성 화면
- 문의 상세 확인 화면

## 실행 방법

### 1. 저장소 클론

```bash
git clone https://github.com/khi6174/StayEasy.git
```

### 2. STS 또는 Eclipse에서 프로젝트 Import

1. STS 또는 Eclipse 실행
2. `File` → `Import`
3. `Existing Maven Projects` 선택
4. `StayEasy/stayEasy` 폴더 선택
5. Maven 프로젝트로 Import

### 3. Maven 업데이트

프로젝트 우클릭 후 아래 메뉴를 실행합니다.

```bash
Maven > Update Project
```

### 4. DB 설정

프로젝트는 Oracle DB와 MyBatis 기반으로 구성되어 있으므로 실행 전 DB 연결 정보를 본인 환경에 맞게 수정해야 합니다.

확인 대상 예시:

```bash
src/main/java/mybatisConfig.xml
src/main/resources/spring/
src/main/webapp/WEB-INF/mvc-config.xml
```

### 5. Tomcat 서버 실행

1. Tomcat 서버 등록
2. 프로젝트를 서버에 추가
3. 서버 실행
4. 브라우저에서 접속

```bash
http://localhost:8080/stayEasy/
```

## 구현 포인트

- Spring MVC 기반 숙소 예약 웹 애플리케이션 구현
- Controller, DAO, Model, Mapper 역할 분리
- MyBatis를 활용한 SQL Mapper 방식의 데이터베이스 연동
- JSP와 JSTL을 활용한 서버 사이드 렌더링 화면 구성
- 세션 기반 로그인 처리
- 사용자, 숙소 등록자, 관리자 역할별 기능 분리
- 숙소 등록 신청 및 관리자 승인 / 반려 흐름 구현
- 숙소 검색, 예약, 장바구니, 리뷰, 문의 기능 구현
- 공지사항 및 이벤트 관리 기능 구현
- 파일 업로드 라이브러리를 활용한 숙소 이미지 관리 기반 구성
- 메일 라이브러리를 활용한 계정 찾기 기능 기반 구성

## 개발 환경

| 항목 | 내용 |
|---|---|
| IDE | STS / Eclipse |
| Language | Java 1.8 |
| Framework | Spring MVC |
| View | JSP, JSTL |
| Database | Oracle DB |
| Persistence | MyBatis, JDBC |
| Build Tool | Maven |
| Server | Apache Tomcat |
| Packaging | WAR |

## 프로젝트를 통해 배운 점

- Spring MVC 기반 웹 애플리케이션의 전체 요청 처리 흐름을 이해하고 구현했습니다.
- 숙소 예약 서비스의 사용자 흐름을 분석하고, 검색부터 예약까지 이어지는 기능을 구현했습니다.
- Controller, DAO, Model, Mapper를 분리하여 MVC 패턴과 계층형 구조를 학습했습니다.
- MyBatis를 활용하여 SQL과 Java 객체를 연결하는 방식을 익혔습니다.
- JSP와 JSTL을 사용하여 동적인 웹 화면을 구성했습니다.
- 사용자, 숙소 등록자, 관리자 역할을 구분하여 권한별 기능을 설계했습니다.
- 숙소 등록 승인 절차를 구현하며 실제 서비스 운영 흐름을 고려한 기능을 경험했습니다.
- 예약, 장바구니, 리뷰, 문의, 공지사항 등 웹 서비스에서 자주 사용되는 기능을 직접 구현했습니다.

## 향후 개선 방향

- Spring Boot 기반 프로젝트로 마이그레이션
- 비밀번호 암호화 로직 강화
- DB 접속 정보 외부 설정 파일 분리
- 관리자 / 사용자 / 숙소 등록자 권한 관리 강화
- 예약 가능 날짜 검증 로직 보완
- 결제 기능 고도화
- 숙소 이미지 업로드 및 관리 기능 개선
- 입력값 검증 및 예외 처리 보완
- REST API 구조 도입
- UI / UX 디자인 개선
- 프로젝트 실행 화면 이미지 추가

## 작성자

김용우
