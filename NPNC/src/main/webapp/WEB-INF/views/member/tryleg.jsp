<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="width:200px;display:flex; flex-flow:row wrap; justify-content:center;margin:20px auto;">
<%
	if((int)request.getAttribute("result")>0){
%>
		회원가입을 축하합니다.<br>
		<input type="button" value="메인으로" onclick="location.href='/board/'" style="width: 70px; height: 30px; margin-top:10px; background-color: #03c75a; border: none; color: white;">
<%
	}else {
%>
		잘못된 정보입니다.
<%}%>
</div>
</body>
</html>