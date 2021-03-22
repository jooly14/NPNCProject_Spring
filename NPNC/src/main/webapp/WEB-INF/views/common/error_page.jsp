<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>${msg}</title>
</head>
<body>
<div style="width:1080px;margin:0 auto; display:flex; flex-flow:row wrap; justify-content:center;">
	<div style="width:100%;height:50px;margin-top:20px;text-align:center;">${msg}</div>
	<div style="width:100%;text-align:center;">
		<input style="width: 100px;height: 36px;background-color: #03c75a;border: none;color: white;" type="button" value="메인화면으로" onclick="location.href='/board/'">
	</div>
</div>
</body>
</html>