<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<div id="hwrap">
	<a class="home-link" href="/">CAFE NAME</a>
	<%
		if(session.getAttribute("id")==null){
	%>
	<div>
		<input type="button" value="로그인" onclick="location.href='/member/login'">
		<input type="button" value="회원가입" onclick="location.href='/member/leg'">
	</div>
	<%
		}else{
	%>
	<div>
		<span style="font-size:14px;">${sessionScope.id}님</span>
		<span style="font-size:14px;"><%=((HashMap<Integer,String>)request.getAttribute("grades")).get(session.getAttribute("grade")) %></span>
		<input type="button" value="마이페이지" onclick="location.href='/member/mypage'">
		<input type="button" value="로그아웃" onclick="location.href='/member/logout'">
	</div>	
	<%
		}
	%>
	<div id="logo">CAFE NAME</div>
	</div>
</header>