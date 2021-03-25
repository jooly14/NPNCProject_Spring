<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:if test="${denied}">
	<script>
	alert("고객님의 정보와 일치하는 계정이 존재하지 않습니다");
	</script>
</c:if>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
	<style>
        html,body{
            margin: 0;
            padding: 0;
        }
        body{
            text-align: center;
        }
        .wrap{
            width: 1024px;
            text-align: center;
            display: inline-block;
        }
		.header{
	            background-color: limegreen;
	            color: yellow;
	            height: 25px;
	            padding: 10px;
	            text-align: center;
        }
		.header>input[type=button]{
	            background-color: limegreen;
	            border: none;
	            cursor: pointer;
	            color: white;
	            width: 200px;
	            font-size: 18px;
	            font-weight: bold;
        }
		.header>input[type=button]:nth-child(2){
		    color: yellow;
		}
		span{
            color: gray;
        }
        .content,table{
            display: inline-block;
        }
        .content{
            border: 1px solid lightgray;
            padding: 20px;
            width: 60%;
            display: inline-block;
        }
        #btn1{
        	background-color: limegreen;
        	width: 200px;
        	height: 40px;
        	color:white;
        	border: 1px solid lightgray;
        	margin-top:10px;
        }
        .goto{
        	width: 100px;
            padding: 0;
            background-color: white;
            border: none;
            color: grey;
            cursor: pointer;
        }
        table tr td{
        	text-align:left;
        }
        .idnum1{
        	width:100px;
        }
         .phonenum{
        	width:50px;
    		text-align:center;
        }
        .findpw{
            padding: 20px;
            width: 70%;
            display: inline-block;
        }
	</style>
</head>
<body>
	<div class="header"><input type="button" value="아이디 찾기" onclick="location.href='/member/findid'"> <input type="button" value="비밀번호 찾기" onclick="location.href='/member/findpw'"></div>
    <div class="wrap">
        <br><br>
        <div class=content>
            <span>회원정보에 등록한 정보가 입력한 정보를 똑같이 입력해 주세요.</span><br><br>
            <div class="findpw">
			<form id="fm1" action="/member/doFindpw" method="post">
				 <table>
					<tr>
                        <td style="width:150px;">아이디</td>
                        <td><input type="text" name="id" id="id"  maxlength="10"></td>
                    </tr>
                    <tr>
                        <td>휴대전화</td>
                        <td><input type="hidden" name="phonenum"><input type="text" class="phonenum"  maxlength="3"> - <input type="text" class="phonenum"  maxlength="4"> - <input type="text" class="phonenum"  maxlength="4"></td>
                    </tr>
                    <tr>
                        <td>주민등록번호</td>
                        <td><input type="hidden" id="idnum1" name="idnum"><input type="text" class="idnum1"  maxlength="6"> - <input type="password" class="idnum1"  maxlength="7"></td>
                    </tr>
                </table>
				<input type="button" id="btn1" value="비밀번호 찾기">
			</form>
			</div>
			</div>
		</div><br><br>
		<input class="goto login"type="button" value="로그인" onclick="location.href='/member/login'"> | <input class="goto leg" type="button" value="회원가입" onclick="location.href='/member/leg'">
	</div>
	
	<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    	$(function(){
    		$("#btn1").click(function(){
	    		$("#idnum1").val($("input[class=idnum1]").eq(0).val()+$("input[class=idnum1]").eq(1).val());
				$("input[name=phonenum]").val($("input[class=phonenum]").eq(0).val()+"-"+$("input[class=phonenum]").eq(1).val()+"-"+$("input[class=phonenum]").eq(2).val());
				if( $("#id").val() =='' || $("#idnum1").val() =='' ||$("input[name=phonenum]").val() == ''){
					alert("정보를 모두 입력해주세요");
				}else if($("#idnum1").val().length!=13){
					alert("주민등록번호의 형식이 잘못되었습니다");
				}else{
					$("#fm1").submit();
				}
    		});
    		
    		
    		
    		$("input[class=idnum1]").on("keyup focusout",function(){
    			onlyNum($(this));
    		});
    		$("input[class=phonenum]").on("keyup focusout",function(){
    			onlyNum($(this));
    		});
    		$("input[name=id]").on("keyup focusout",function(){
    			noHangle($(this));
    		});
    		
    		function onlyNum(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[^0-9]/gi,''));
    		}
    		function noHangle(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[^a-z0-9_]/gi,''));
    		}
    	});
    </script>
</body>
</html>