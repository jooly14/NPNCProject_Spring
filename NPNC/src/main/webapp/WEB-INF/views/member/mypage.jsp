<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.npnc.member.dao.MDao" %>
<%@ page import ="com.npnc.member.dto.MDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        .wrap{
            width: 1024px;
            margin: 0 auto;
            display: flex;
            flex-flow: row wrap;
            justify-content: center;
        }
        .naver{
        	width:100%;
        	text-align: center;
            color: limegreen;
            font-size: 50px;
            font-weight: bold;
        }
        input[type=text],input[type=password]{
            width: 150px;
            height: 25px;
        }
        #regbtn,input[type=button]{
            width: 100px;
            height: 40px;
            border: 1px solid lightgray;
            background-color: limegreen;
            color: white;
            margin-top:10px;
        }
        #regbtn{
        	margin-left:140px;
        }
        input[type=button]{
        	background-color: gray;
        }
        td{
        	height:50px;
        	border-bottom: 1px solid lightgray;
        }
        a{
            font-size: 2em;
            font-weight: bold;
            color: limegreen;
            text-decoration: none;
        }
        input[class=phonenum]{
        	width:50px;
    		text-align:center;
        }
        .content{
        	margin-top:10px;
        }
    </style>
</head>
<body>
    <div class="wrap">
         <span class="naver"><a href="/board/">CAFE NAME</a></span><br><br>
        <div class="content">
            <form id="fm1" action="/member/update" method="post">
            <table>
            	<tr>
            		<td style="width:150px;">아이디</td>
            		<td><input type="text" value="${dto.id}" readonly></td>
            	</tr>
            	<tr>
            		<td>비밀번호</td>
            		<td><input type="button" id="chgPw" value="비밀번호 변경"  style="height:25px;margin-bottom:5px;"></td>
            	</tr>
            	<tr>
            		<td>이름</td>
            		<td><input type="text" value="${dto.name}" readonly></td>
            	</tr>
            	<tr>
            		<td>이메일</td>
            		<td><input type="hidden" name="email"><input class="email" type="text" value="${fn:split(dto.email,'@')[0]}" maxlength="20">@<input class="email" value="${fn:split(dto.email,'@')[1]}" type="text" maxlength="50"></td>
            	</tr>
            	<tr>
            		<td><div style="padding-bottom:80px;">주소</div></td>
            		<td><input type="hidden" name="address">
            		<input type="hidden" id="sample4_postcode" placeholder="우편번호">
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="height:25px;margin-bottom:5px;"><br>
					<input type="text" id="sample4_roadAddress" placeholder="도로명주소" style="width:315px; margin-bottom:5px;" maxlength="50" value="${fn:trim(fn:split(dto.address,'*')[0])}"><br>
					<input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="width:315px;margin-bottom:5px;" maxlength="50" value="${fn:trim(fn:split(dto.address,'*')[1])}"><br>
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" id="sample4_detailAddress" style="vertical-align:top;" placeholder="상세주소" maxlength="40" value="${fn:trim(fn:split(dto.address,'*')[2])}">
					<input type="text" id="sample4_extraAddress" placeholder="참고항목" maxlength="40" value="${fn:trim(fn:split(dto.address,'*')[3])}">
					<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
					    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
					    function sample4_execDaumPostcode() {
					        new daum.Postcode({
					            oncomplete: function(data) {
					                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					
					                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
					                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					                var roadAddr = data.roadAddress; // 도로명 주소 변수
					                var extraRoadAddr = ''; // 참고 항목 변수
					
					                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
					                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					                    extraRoadAddr += data.bname;
					                }
					                // 건물명이 있고, 공동주택일 경우 추가한다.
					                if(data.buildingName !== '' && data.apartment === 'Y'){
					                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					                }
					                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					                if(extraRoadAddr !== ''){
					                    extraRoadAddr = ' (' + extraRoadAddr + ')';
					                }
					
					                // 우편번호와 주소 정보를 해당 필드에 넣는다.
					                document.getElementById('sample4_postcode').value = data.zonecode;
					                document.getElementById("sample4_roadAddress").value = roadAddr;
					                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
					                
					                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
					                if(roadAddr !== ''){
					                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
					                } else {
					                    document.getElementById("sample4_extraAddress").value = '';
					                }
					
					                var guideTextBox = document.getElementById("guide");
					                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
					                if(data.autoRoadAddress) {
					                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					                    guideTextBox.style.display = 'block';
					
					                } else if(data.autoJibunAddress) {
					                    var expJibunAddr = data.autoJibunAddress;
					                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					                    guideTextBox.style.display = 'block';
					                } else {
					                    guideTextBox.innerHTML = '';
					                    guideTextBox.style.display = 'none';
					                }
					            }
					        }).open();
					    }
					</script>
            		</td>
            	</tr>
            	<tr>
            		<td>전화번호*</td>
            		<td><input type="hidden" name="phonenum"><input type="text" class="phonenum" maxlength="3"  value="${fn:split(dto.phonenum,'-')[0]}"> - <input type="text" class="phonenum" maxlength="4"  value="${fn:split(dto.phonenum,'-')[1]}"> - <input type="text" class="phonenum" maxlength="4"  value="${fn:split(dto.phonenum,'-')[2]}"></td>
            	</tr>
            </table>
            		<input id="regbtn" type="button" value="회원정보 변경">
            		<input type="button" id="del" value="탈퇴"">
            </form>
        </div>
    </div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#del").click(function(){
			window.open('/member/del_mem_pop', '회원 탈퇴', 'top=100px,left=500px,width=350px,height=180px,scrollbars=yes');
		});
		
		$("input[class=email]").eq(0).on("keyup focusout",function(){
			noHangle($(this));
		});
		$("input[class=email]").eq(1).on("keyup focusout",function(){
			noHangle2($(this));
		});
		$("input[class=phonenum]").on("keyup focusout",function(){
			onlyNum($(this));
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
		
		$("#chgPw").click(function(){
			window.open('/member/chgpw_pop', '비밀번호 변경', 'top=100px,left=500px,width=470px,height=250px,scrollbars=yes');
		});
	
		
		$("#regbtn").click(function(){
			 $("input[name=email]").val($("input[class=email]").eq(0).val()+"@"+$("input[class=email]").eq(1).val());
			$("input[name=phonenum]").val($("input[class=phonenum]").eq(0).val()+"-"+$("input[class=phonenum]").eq(1).val()+"-"+$("input[class=phonenum]").eq(2).val());
			$("input[name=address]").val($("#sample4_roadAddress").val()+"* "+$("#sample4_jibunAddress").val()+"* "+$("#sample4_detailAddress").val()+"* "+$("#sample4_extraAddress").val());
			//필수 항목 체크(id, pw, name, idnum, phonenum)
			if($("input[name=phonenum]").val().length<9){
				alert("전화번호의 형식이 잘못되었습니다.");
				$("input[name=phonenum]").focus();
				$("input[name=phonenum]").select();
			}else{
				if($("input[name=email]").val()=="@"){
					$("input[name=email]").val("");
				}
				$("#fm1").submit();
			}
			
		});
	})
</script>
</body>
</html>