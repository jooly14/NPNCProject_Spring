# NPNCProject_Spring
### 1. 개발환경 및 사용기술 : 
- STS 3.9.9  
- Spring Framework 5.0.7
- JDK 1.8 
- Tomcat 8.5  
- Servlet 3.1 / JSP 2.3
- HTML/ CSS/ JavaScript/ Jquery
- MariaDB 10.4
- mybatis / commons-dbcp2 / commons-fileupload / jackson-databind 등
### 2. Servlet/JSP로 작성된 NPNCProject_JSP_Servlet(부동산 정보 공유 웹사이트)를 Spring Framework로 컨버팅
### 3. 개발인원 : 1명
### 4. 주요기능
#### 4.1 회원 관련 기능
- (추가) 회원가입에서 ajax를 이용하여 아이디 중복여부 확인  
- (추가) 회원가입 및 회원 정보 변경에서 입력 칸에 입력 문자 제한(숫자, 영어, 한글 등)
- (추가) 회원가입에서 비밀번호 확인  
- (추가) 마이페이지에서 비밀번호 변경  
- (추가) 로그인 시 계정정지 아이디의 로그인 제한
- (추가) 회원 탈퇴화면에서 javascript를 통해 비밀번호가 노출되던 문제를 ajax를 통해 비밀번호를 확인함으로써 해결  
- (추가) 회원가입 및 회원 정보 변경에서 다음 주소 API를 사용하여 주소 입력의 편의성을 높임
- 로그인 및 로그아웃  
- 아이디 찾기 및 비밀번호 찾기  
- 회원정보 변경 및 탈퇴
- 로그아웃
#### 4.2 게시판 기능 
- (추가) 게시글 읽기에서 댓글 수정/삭제 구현(ajax)  
- (추가) 게시글 읽기에서 좋아요/싫어요 선택 및 취소(ajax)  
- (추가) 게시글 읽기에서 파일 다운로드
- (추가) 게시글 수정에서 업로드된 파일 변경  
- (추가) 관리자 계정인 경우 게시글 및 댓글 삭제 가능(수정 불가)
- 게시글 리스트
  - 카테고리 별 게시글 리스트
  - 카테고리 마다 읽기권한 및 쓰기권한에 따라 회원등급과 비교해 게시글 쓰기 및 읽기 제한
- 게시글 쓰기  
  - 파일 업로드
- 게시글 읽기
  - 댓글 작성
  - 게시글 읽기 내 게시글 리스트
  - 좋아요/싫어요
- 게시글 수정  
- 게시글 삭제  
#### 4.3 관리자 기능 
- (추가) grade테이블에 전체공개를 추가하고 member테이블과 category테이블에 외래키 설정
- (추가) 회원등급 변경에 전체공개 option이 노출되는 것을 수정
- (추가) 게시글 관리에서도 게시글 읽기가 가능하도록 수정
- 게시글 관리 
  - 일괄 삭제 
  - 카테고리 이동 
- 카테고리 관리 
  - 카테고리 추가/삭제
  - 카테고리에 포함된 게시글 일괄 이동 
  - 읽기권한 및 쓰기권한 변경
- 회원 관리 
  - 회원 등급 변경 및 계정 정지
