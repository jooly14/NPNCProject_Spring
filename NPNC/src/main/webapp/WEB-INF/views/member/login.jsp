<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:if test="${denied}">
	<script>
	alert("로그인 정보가 잘못되었습니다");
	</script>
</c:if>
<c:if test="${grade == 100}">
	<script>
	alert("계정이 정지되었습니다");
	</script>
</c:if>
<meta charset="UTF-8">
<title>로그인</title>
    <style>
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            display: inline-block
        }
        input{
            width: 400px;
            height: 30px;
            
            border: 1px solid lightgray;
            padding: 10px;
            margin: 5px;
        }
        input[type=submit]{
            background-color: limegreen;
            color: white;
            cursor: pointer;
            height: 50px;
            width: 420px;
        }
        a{
            font-size: 4em;
            font-weight: bold;
            color: limegreen;
            text-decoration: none;
        }
        .find,.leg{
            width: 100px;
            padding: 0;
            background-color: white;
            border: none;
            color: grey;
            cursor: pointer;
        }
    </style>
</head>
<body>
	<div class="wrap">
	<form action="/member/doLogin" method="post">
        <div class="logo"><a href="/board/">CAFE NAME</a></div>
        <input type="text" placeholder="아이디" name="id"><br>
        <input type="password" placeholder="패스워드" name="pw"><br>
        <input type="submit"  value="로그인"><br>
	</form>
        <input class="find id" type="button" onclick="location.href='/member/findid'" value="아이디 찾기">|<input class="find pw" type="button" onclick="location.href='/member/findpw'" value="비밀번호 찾기">|<input class="leg" type="button" onclick="location.href='/member/leg'" value="회원 가입">
        <hr>
    </div>
</body>
</html>