<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<style>
	#wrap{
		width:320px;
		margin : 0 auto;		
	}
	table{
		width:100%;
		border-collapse:collapse;
	}
	td{
		text-align: center;
		padding: 7px 7px;
	}
	#chk{
	    width: 180px;
	    height: 30px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	#del,#cancel,#closebtn{
		width: 80px;
	    height: 30px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
	#del{
		margin-left:70px;
	}
	#cancel{
		margin-right:70px;
	}
</style>
</head>
<body>
<div id="wrap">
<form id="fm1" onsubmit="return false;">
	<table>
		<tr>
			<td colspan="2">정말 탈퇴를 진행하시겠습니까?</td>
		</tr>
		<tr>
			<td colspan="2"><input id="pw" name="pw" type="password" placeholder="비밀번호를 입력해주세요"></td>
		</tr>
		<tr>
			<td><input id="del" type="button" value="탈퇴"></td>
			<td><input id="cancel" type="button" value="취소" onclick="window.close()"></td>
		</tr>
	</table>
</form>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#del").click(function(){
			var params = $("#fm1").serialize();
			$.ajax({
				type:"post",
				url:"/member/delmember",
				data:params,
				dataType:"json",
				success:function(data){
					if(data.result==1){
						$("#wrap").empty();
						$("#wrap").append($("<div style='width:100%;text-align:center;margin-top:20px;'>회원 탈퇴가 정상처리 되었습니다</div>"));
						$(window).unload(function() { 
							opener.location.href='/';
						});
						$("#wrap").append($("<input id='closebtn' type='button' value='닫기' style='margin:10px 0 0 115px;'>"));
					}else{
						$("#not").remove();
						$("#wrap").prepend($("<div id='not' style='color:red;width:100%;text-align:center;'>비밀번호가 일치하지 않습니다</div>"));
						$("#pw").focus();
						$("#pw").select();
					}
				},
				error:function(request,status,error){
				    alert("작업 실패");
				 }
			});
		});
		$("#pw").keyup(function(e){
			if(e.keyCode=='13'){
				$("#del").trigger("click");
			}
		});
		$(document).on("click","#closebtn",function(){
			window.close();
		});
	})
</script>
</body>
</html>