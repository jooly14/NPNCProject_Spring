<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.npnc.member.dao.MDao" %>
<%@ page import ="com.npnc.member.dto.MDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:if test="${result}">
	<script>
		alert("회원정보 수정이 완료되었습니다");
	</script>
</c:if>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            display: inline-block;
        }
        
        .wrap>div{
            width: 310px;
            display: inline-block;
            text-align: left
        }
         .naver{
            color: limegreen;
            font-size: 3em;
            font-weight: bold;
        }
        input[type=text],input[type=password]{
            width: 300px;
            height: 30px;
            margin-bottom: 20px;
        }
        input[type=submit]{
            width: 300px;
            height: 50px;
            border: 1px solid lightgray;
            background-color: limegreen;
            color: white;
        }
        input[type=button]{
            width: 300px;
            height: 50px;
            border: 1px solid lightgray;
            background-color: maroon;
            color: white;
        }
        a {
		    font-size: 2em;
		    font-weight: bold;
		    color: limegreen;
		    text-decoration: none;
		}
    </style>
</head>
<body>
    <div class="wrap">
         <span class="naver"><a href="/board/">CAFE NAME</a></span><br><br>
        <div class="content">
            <form action="/member/update" method="post">
                <span class="name">아이디</span><br>
                <input type="text" name="id" value ="${dto.id}" readonly><br>
                <span class="name">비밀번호</span><br>
                <input type="text" name="pw" value="${dto.pw}"><br>
                <span class="name">이름</span><br>
                <input type="text" name="name" value="${dto.name}" readonly><br>              
                <span class="name">이메일</span><br>
                <input type="text" name="email" value="${dto.email}"><br>
                <span class="name">주소</span><br>
                <input type="text" name="address" value="${dto.address}" ><br>
                <span class="name">전화번호</span><br>
                <input type="text" name="phonenum" value="${dto.phonenum}" ><br>
                <input type="submit" value="회원정보변경">
            </form>
            <form id="fm2" action="/member/delmember" method="post">
           		 <input id="del" type="button" value="회원탈퇴">
            </form>
        </div>
    </div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#del").click(function(){
			window.open('/member/del_mem_pop', '회원 탈퇴', 'top=100px,left=500px,width=350px,height=180px,scrollbars=yes');
		});
	})
</script>
</body>
</html>