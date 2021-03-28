<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 : no pain no code</title>
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
        .findid{
            border: 1px solid lightgray;
            padding: 20px;
            width: 60%;
            display: inline-block;
        }
        .find{
            margin: 10px;
        }
        table{
            display: inline-block;
        }
        span{
            color: gray;
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
        .header>input[type=button]:first-child{
            color: yellow;
        }
        #btn1,#btn2{
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
        .phonenum{
        	width:50px;
    		text-align:center;
        }
        table tr td{
        	text-align:left;
        }
        .idnum1,.idnum2,.email2{
        	width:100px;
        }
    </style>
</head>
<body>
    <div class="header"><input type="button" value="아이디 찾기" onclick="location.href='/member/findid'"> <input type="button" value="비밀번호 찾기" onclick="location.href='/member/findpw'"></div>
    <div class="wrap">
        <br><br>
        <span>회원정보에 등록한 정보가 입력한 정보를 똑같이 입력해 주세요.</span><br><br>
        <div class="findid">
            <span>회원정보에 등록한 휴대전화번호로 인증</span><br>
            <div class="find phone">
                <form id="fm1" action="/member/doFindid" method="post">
                    <table>
						<tr>
                            <td style="width:150px;">이름</td>
                            <td><input type="text" name="name" id="name1"  maxlength="10"></td>
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
                    <br>
                    <input type="button" id='btn1' value="아이디 찾기">
                </form>
            </div>
            
            <hr>
           <span>본인확인 이메일로 인증</span>
            <div class="find email">
                <form id ="fm2" action="/member/doFindid" method="post">
                    <table>
                        <tr>
                            <td style="width:150px;">이름</td>
                            <td><input type="text" name="name" id="name2" maxlength="10"></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td><input type="hidden" name="email"><input type="text" class="email2"  maxlength="20">@<input type="text" class="email2"  maxlength="50"></td>
                        </tr>
                        <tr>
                            <td>주민등록번호</td>
                            <td><input id="idnum2" type="hidden" name="idnum"><input type="text" class="idnum2" maxlength="6"> - <input type="password" class="idnum2"  maxlength="7"></td>
                        </tr>
                    </table>
                    <br>
                    <input type="button" id="btn2" value="아이디 찾기">
                </form>
            </div>
        </div><br><br>
       <input class="goto login"type="button" value="로그인" onclick="location.href='/member/login'"> | <input class="goto leg" type="button" value="회원가입" onclick="location.href='/member/leg'">
    </div>
    
    <script  src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    	$(function(){
    		/* 이메일로 찾기 */
    		$("#btn2").click(function(){
	    		$("#idnum2").val($("input[class=idnum2]").eq(0).val()+$("input[class=idnum2]").eq(1).val());
				$("input[name=email]").val($("input[class=email2]").eq(0).val()+"@"+$("input[class=email2]").eq(1).val());
				if($("#name2").val() =='' || $("#idnum2").val() =='' ||$("input[name=email]").val() == ''){
    				alert("정보를 모두 입력해주세요");
    			}else if($("#idnum2").val().length!=13){
    				alert("주민등록번호의 형식이 잘못되었습니다");
    			}else{
    				$("#fm2").submit();
    			}
    			
    		});
    		/* 전화번호로 찾기 */
    		$("#btn1").click(function(){
	    		$("#idnum1").val($("input[class=idnum1]").eq(0).val()+$("input[class=idnum1]").eq(1).val());
				$("input[name=phonenum]").val($("input[class=phonenum]").eq(0).val()+"-"+$("input[class=phonenum]").eq(1).val()+"-"+$("input[class=phonenum]").eq(2).val());
				if( $("#name1").val() =='' || $("#idnum1").val() =='' ||$("input[name=phonenum]").val() == ''){
					alert("정보를 모두 입력해주세요");
				}else if($("#idnum1").val().length!=13){
					alert("주민등록번호의 형식이 잘못되었습니다");
				}else{
					$("#fm1").submit();
				}
    		});
    		
    		/* 입력 칸마다 입력할 수 있는 문자를 제한 */
    		$("input[class=email2]").eq(0).on("keyup focusout",function(){
    			noHangle($(this));
    		});
    		$("input[class=email2]").eq(1).on("keyup focusout",function(){
    			noHangle2($(this));
    		});
    		$("input[class=idnum1]").on("keyup focusout",function(){
    			onlyNum($(this));
    		});
    		$("input[class=idnum2]").on("keyup focusout",function(){
    			onlyNum($(this));
    		});
    		$("input[class=phonenum]").on("keyup focusout",function(){
    			onlyNum($(this));
    		});
    		$("input[name=name]").on("keyup focusout",function(){
    			noNum($(this));
    		});
    		function noHangle(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[^a-z0-9_]/gi,''));
    		}
    		function noHangle2(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[^a-z0-9.]/gi,''));
    		}
    		function onlyNum(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[^0-9]/gi,''));
    		}
    		function noNum(obj){
    			var inputVal = obj.val();
    			obj.val(inputVal.replace(/[0-9]/gi,''));
    		}
    	});
    </script>
</body>
</html>