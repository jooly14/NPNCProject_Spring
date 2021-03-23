<%@page import="com.npnc.board.dto.CDto"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="manage_access_chk.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/board/blist.css"/>
<link rel="stylesheet" href="/resources/css/common/header.css"/>
<link rel="stylesheet" href="/resources/css/common/nav_category.css"/>
<style>
	.list-style2{
		height: 20px;
	}
	.ajax-selw, .ajax-selr,select[name='readgrade'],select[name='writegrade']{
	    width: 80px;
	    height: 25px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
	.main-del,.cate-del,.move-cate,.add-cate,.add-mainc,.addbtn,.addMbtn,.add-cancel-c ,.add-cancel-m{
	    width: 50px;
	    height: 25px;
	    background-color: white;
	    border: 1px solid lightgray;
	    margin: 2px 0;
	}
	.add-cate,.add-mainc,.addbtn,.addMbtn{
		width:120px;
	}
	input[type="text"]{
		width:200px;
		height:25px;
	 	border: 1px solid gray;
	}
</style>
</head>
<body>
<div id="wrap">
	<%@ include file="../common/header.jsp" %>
	<section id="section1">
		<%@ include file="../common/manage_category.jsp" %>
		<div id="content">
			<h2 id="category-name">카테고리 관리</h2>
			<div class="list-style2"></div>
			<form id="fmc" action="/manage" method="post">
				<table class="list-table">
					<tr>
						<td>대분류</td>
						<td>카테고리</td>
						<td>읽기권한</td>
						<td>쓰기권한</td>
						<td>게시글 개수</td>
						<td>삭제</td>
						<td>게시글 이동</td>
					</tr>
				<%	/* 카테고리 값을 가져와서 테이블 생성 */
					Map<String,Vector<CDto>> map = (Map<String,Vector<CDto>>)request.getAttribute("clist");
					for(Map.Entry<String,Vector<CDto>> e :map.entrySet()){
				%>
					<tr>
						<td colspan="5"><%=e.getKey()%></td>
						<td style="text-align:center;"><input class="main-del" type="button" value="삭제"></td>
					</tr>
				<%
						HashMap<Integer,String> grades = (HashMap<Integer,String>)request.getAttribute("grades");
						/* 회원등급 테이블 값과 카테고리의 readgrade와 writegrade값을 비교해서 회원등급 번호가 아닌 회원등급이름을 보여줌 */
						for(int i=0;i<e.getValue().size();i++){
				%>
					<tr>
						<td style="width:150px;"><span style="display:none"><%=e.getKey()%></span></td>
						<td><%= e.getValue().get(i).getName()%></td>
						<td style="text-align:center;width:100px;">
						<select class="ajax-selr">
						<c:set var="readg" value="<%=e.getValue().get(i).getReadgrade()%>"></c:set>
						<c:forEach var="g" items="${requestScope.grades}">
							<c:if test="${g.key!=100}">
								<option value="${g.key}" ${readg==g.key?'selected':''}>${g.value}</option>
							</c:if>
						</c:forEach>
						</select>
						</td>
						<td style="text-align:center;width:100px;">
						<select class="ajax-selw">
						<c:set var="writeg" value="<%=e.getValue().get(i).getWritegrade()%>"></c:set>
						<c:forEach var="g" items="${requestScope.grades}">
							<c:if test="${g.key!=100 && g.key!=99}">
								<option value="${g.key}" ${writeg==g.key?'selected':''}>${g.value}</option>
							</c:if>
						</c:forEach>
						</select>
						</td>
						<td style="text-align:center;width:70px;"><%= e.getValue().get(i).getCnt()%></td>
						<td style="text-align:center;width:70px;"><input id="cidx-<%=e.getValue().get(i).getIdx() %>" class="cate-del" type="button" value="삭제"></td>
						<!-- 카테고리이동 버튼은 이동할 게시글이 카테고리에 있는 경우에 나타남 -->
						<td style="text-align:center;width:70px;"><c:if test='<%=e.getValue().get(i).getCnt()!=0%>'><input class="move-cate" type="button" value="이동"></c:if></td>
					</tr>
				<%
							if(i==e.getValue().size()-1){
				%>
					<tr>
						<td></td>
						<td><input class="add-cate" type="button" value="카테고리 추가"></td>
						<td colspan="5"></td>
					</tr>
				<%
							}
						}
					}	
				%> 
					<tr>
						<td><input class="add-mainc" type="button" value="대분류 추가"></td>
						<td colspan="6"></td>
					</tr>
				</table>
				</form>
				
		<!-- 팝업창에 데이터를 편하게 가져가기 위해서 -->		
		<div id="hidden" style="display:none">
			<span id="hidx"></span>
			<span id="hmaincategory"></span>
			<span id="hname"></span>
			<span id="hcnt"></span>
		</div>
	</section>
	<%@ include file="../common/footer.jsp" %>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		/* 카테고리 삭제 버튼 누른 경우 삭제 여부 확인후 동작 */
		$(".cate-del").click(function(){
			if(confirm($(this).parent().prev().prev().prev().prev().text()+" 카테고리를 정말 삭제하시겠습니까?\n포함된 모든 게시글이 삭제됩니다.")){
				location.href = "/manage/delc?idx="+$(this).attr("id").substring(5);			
			}
		});
		/* 메인 카테고리 삭제 버튼 누른 경우 삭제 여부 확인후 동작 */
		$(".main-del").click(function(){
			if(confirm($(this).parent().prev().text()+" 카테고리를 정말 삭제하시겠습니까?\n포함된 모든 카테고리 및 게시글이 삭제됩니다.")){
				location.href = "/manage/delmainc?name="+encodeURI(encodeURIComponent($(this).parent().prev().text()));			
			}
		});
		/* 카테고리 추가 버튼 누르면 새로운 입력 행 생성하고 버튼은 사라짐 */
		$(document).on("click",".add-cate",function(){
			var tr1 = $("<tr></tr>");
			var td1 = $("<td></td>");
			var td2 = $("<td><input type='text' name='name' placeholder='카테고리 이름'></td>");
			var td22 = $("<td style='text-align:center;width:100px;'><select name='readgrade'></select></td>");
			var td23 = $("<td style='text-align:center;width:100px;'><select name='writegrade'></select></td>");
			var td3 = $("<td colspan='2' style='text-align:center;'><input class='addbtn' type='button' value='카테고리 추가'></td>");
			var td4 = $("<td style='text-align:center;'><input class='add-cancel-c'  type='button' value='취소'></td>");
			var h1 = $("<input type='hidden' name='maincategory'>");
			h1.val($(this).parent().parent().prev().children().eq(0).text());
			
			<c:forEach var="e" items="${grades}">
				var op1 = $("<option></option>");
				var value1 = '${e.value}';
				var key1 = '${e.key}';
				op1.text(value1);
				op1.val(key1);
				if(key1!='100'){
					td22.children().eq(0).append(op1);
					var op2 =  op1.clone();
					if(!(op2.val()=='99')){
						td23.children().eq(0).append(op2);
					}
				}
			</c:forEach>
			td22.children().eq(0).children().last().attr("selected",true);
			td23.children().eq(0).children().last().attr("selected",true);
			td1.append(h1);
			tr1.append(td1);
			tr1.append(td2);
			tr1.append(td22);
			tr1.append(td23);
			tr1.append(td3);
			tr1.append(td4);
			$(this).parent().parent().before(tr1);
			$(this).parent().parent().remove();
		});
		/* 카테고리의 입력칸 채운 후 추가 버튼 클릭시 카테고리 생성 */
		$(document).on("click",".addbtn",function(){
			if($(this).parent().prev().prev().prev().children().val()!=""){
				$("#fmc").attr("action","/manage/addcategory");
				$("#fmc").submit();
			}
		});
		/* 메인카테고리의 입력칸 채운 후 추가 버튼 클릭시 카테고리 생성 */
		$(document).on("click",".addMbtn",function(){
			if($(this).parent().prev().prev().prev().prev().children().val()!=""&&$(this).parent().prev().prev().prev().children().val()!=""){
				$("#fmc").attr("action","/manage/addcategory");
				$("#fmc").submit();
			}
		});
		/* 메인카테고리 추가 버튼 누르면 새로운 입력 행 생성하고 버튼은 사라짐 */
		$(document).on("click",".add-mainc",function(){
			var tr1 = $("<tr></tr>");
			var td1 = $("<td><input style='width:120px;' type='text' name='maincategory' placeholder='대분류 이름'></td>");
			var td2 = $("<td><input type='text' name='name' placeholder='카테고리 이름'></td>");
			var td22 = $("<td style='text-align:center;'><select name='readgrade'></select></td>");
			var td23 = $("<td style='text-align:center;'><select name='writegrade'></select></td>");
			var td3 = $("<td colspan='2' style='text-align:center;'><input class='addMbtn' type='button' value='대분류 추가'></td>");
			var td4 = $("<td style='text-align:center;'><input type='button' class='add-cancel-m'  value='취소'></td>");
			var h1 = $("<input type='hidden' name='maincategory'>");

			<c:forEach var="e" items="${grades}">
				var op1 = $("<option></option>");
				var value1 = '${e.value}';
				var key1 = '${e.key}';
				op1.text(value1);
				op1.val(key1);
				if(key1!='100'){
					td22.children().eq(0).append(op1);
					var op2 =  op1.clone();
					if(!(op2.val()=='99')){
						td23.children().eq(0).append(op2);
					}
				}
			</c:forEach>
			td22.children().eq(0).children().last().attr("selected",true);
			td23.children().eq(0).children().last().attr("selected",true);
			tr1.append(td1);
			tr1.append(td2);
			tr1.append(td22);
			tr1.append(td23);
			tr1.append(td3);
			tr1.append(td4);
			$(this).parent().parent().before(tr1);
			$(this).parent().parent().remove();
		});
		
		$(document).on("click",".add-cancel-c",function(){
			var tr2 = $("<tr><td></td><td><input class='add-cate' type='button' value='카테고리 추가'></td><td colspan='5'></td></tr>");
			$(this).parent().parent().before(tr2);
			$(this).parent().parent().remove();
		});
		$(document).on("click",".add-cancel-m",function(){
			var tr2 = $("<tr><td><input class='add-mainc' type='button' value='대분류 추가'></td><td colspan='6'></td></tr>");
			$(this).parent().parent().before(tr2);
			$(this).parent().parent().remove();
		});
		
		/* 이동 버튼 클릭시 카테고리 안에 있는 모든 게시글을 한번에 카테고리 이동 시키는 팝업 생성 */
		$(".move-cate").click(function(){
				$("#hidx").text($(this).parent().prev().children().eq(0).attr("id").substring(5));
				$("#hmaincategory").text($(this).parent().prev().prev().prev().prev().prev().prev().text());
				$("#hname").text($(this).parent().prev().prev().prev().prev().prev().text());
				$("#hcnt").text($(this).parent().prev().prev().text());
			   	var popup = window.open('/manage/move_all_pop', '카테고리 이동', 'top=100px,left=500px,width=400px,height=290px,scrollbars=yes');
		});
		
		/*ajax - 읽기권한, 쓰기권한 변경 시 ajax로 비동기식 변경 */
		$(".ajax-selr").on('change',ajaxFnc);
		$(".ajax-selw").on('change',ajaxFnc);
		function ajaxFnc() {
			var params = "idx=";
			if($(this).attr("class")=="ajax-selr"){
				params += $(this).parent().next().next().next().children().eq(0).attr("id").substring(5)+"&rw=r";
			}else{
				params += $(this).parent().next().next().children().eq(0).attr("id").substring(5)+"&rw=w";
			}
			params += "&grade="+$(this).val();
			$.ajax({
				type:"post",
				url:"/manage/chgRWgrade",
				data:params,
				dataType:"json",
				success:function(data){
				},
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }

			});
		}
	});
	
</script>
</body>
</html>