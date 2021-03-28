<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<style>
	#wrap{
		width:400px;
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
	#pw2,#oldpw,#newpw{
	    width: 180px;
	    height: 25px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	#chg,#cancel,#closebtn{
		width: 80px;
	    height: 30px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
	#chg{
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
			<td colspan="2">비밀번호 변경</td>
		</tr>
		<tr>
			<td>현재 비밀번호</td><td><input id="oldpw" name="oldpw" type="password" placeholder="현재 비밀번호를 입력해주세요"></td>
		</tr>
		<tr>
			<td>새 비밀번호</td><td><input id="newpw" name="newpw" type="password" placeholder="새 비밀번호를 입력해주세요"></td>
		</tr>
		<tr>
			<td>새 비밀번호 확인</td><td><input id="pw2" type="password" placeholder="새 비밀번호 확인"> <span id="pwchk" style="display:none;font-size:12px; margin-left:2px;">비밀번호가 일치하지 않습니다</span></td>
		</tr>
		<tr>
			<td><input id="chg" type="button" value="변경"></td>
			<td><input id="cancel" type="button" value="취소" onclick="window.close()"></td>
		</tr>
	</table>
</form>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		/* 비밀번호 변경 버튼 클릭시 */
		$("#chg").click(function(){
			if($("#oldpw").val()==""){
				alert("현재 비밀번호를 입력해주세요");	
				$("#oldpw").focus();
				$("#oldpw").select();
			}else if($("#newpw").val()==""){
				alert("새 비밀번호를 입력해주세요");	
				$("#newpw").focus();
				$("#newpw").select();
			}else if($("#pw2").val()==""){
				alert("새 비밀번호 확인을 입력해주세요");	
				$("#pw2").focus();
				$("#pw2").select();
			}else if($("#pwchk").css("display")!="none"){
				alert("새 비밀번호 확인의 값이 일치하지 않습니다");
				$("#pw2").focus();
				$("#pw2").select();
			}else{
				var params = $("#fm1").serialize();
				$.ajax({
					type:"post",
					url:"/member/chgpw",
					data:params,
					dataType:"json",
					success:function(data){
						if(data.result==1){
							$("#wrap").empty();
							$("#wrap").append($("<div style='width:100%;text-align:center;margin-top:20px;'>비밀번호가 변경되었습니다</div>"));
							$("#wrap").css("width","200px");
							window.resizeTo(400,200);
							$(window).unload(function() { 
								opener.location.href='/member/mypage';
							});
							$("#wrap").append($("<input id='closebtn' type='button' value='닫기' style='margin:10px 0 0 60px;'>"));
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
				
			}
		});
		/* 엔터키 이벤트 */
		$(document).keyup(function(e){
			if(e.keyCode=='13'){
				$("#chg").trigger("click");
			}
		});
		/* 닫기 버튼 */
		$(document).on("click","#closebtn",function(){
			window.close();
		});
		/* 비밀번호 확인 칸에서 입력시 비밀번호 일치 여부 확인 */
		$("input[id=pw2]").keyup(function(){
			if($("input[name=newpw]").val()!=$(this).val()){
				$("#pwchk").css("display","inline-block");
			}else{
				$("#pwchk").css("display","none");
			}
		});
		/* 새 비밀번호 칸에 포커스가 생기면 비밀번호 확인 칸 내용을 지움 */
		$("input[name=newpw]").on("focusin",function(){
			$("input[id=pw2]").val("");
		});
	})
</script>
</body>
</html>