<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="manage_access_chk.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/resources/css/board/blist.css"/>
<link rel="stylesheet" href="/resources/css/common/header.css"/>
<link rel="stylesheet" href="/resources/css/common/nav_category.css"/>
<style>
	.ajax-sel{
	    width: 80px;
	    height: 25px;
	    border-radius: 0;
	    padding-left: 4px;
	    border: 1px solid lightgray;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
	<%@ include file="../common/header.jsp" %>
	<section id="section1">
		<%@ include file="../common/manage_category.jsp" %>
		<div id="content">
			<h2 id="category-name">회원 관리</h2>
			<div class="list-style">
				<span id="total">${totalcnt}명의 회원</span>
				<!-- 한페이지당 회원 노출 수 -->
				<select id="psize">
					<option value="20" ${pagesize==20?'selected':''}>20명씩</option>
					<option value="50" ${pagesize==50?'selected':''}>50명씩</option>
					<option value="100" ${pagesize==100?'selected':''}>100명씩</option>
					<option value="200" ${pagesize==200?'selected':''}>200명씩</option>
					<option value="300" ${pagesize==300?'selected':''}>300명씩</option>
					<option value="400" ${pagesize==400?'selected':''}>400명씩</option>
					<option value="500" ${pagesize==500?'selected':''}>500명씩</option>
				</select>
			</div>
			<!-- 회원 테이블 -->
			<table class="list-table">
				<tr>
					<td>아이디</td>
					<td>회원등급</td>
					<td>이름</td>
					<td>이메일</td>
					<td>전화번호</td>
					<td>주소</td>
				</tr>
			<c:forEach var="d" items="${dtos}">
				<tr>
					<td style="text-align:center;width:100px;">${d.id}</td>
					<td style="text-align:center;width:100px;">
					<select class="ajax-sel">
					<c:forEach var="g" items="${grades}">
						<c:if test="${g.key!=99}">
							<option value="${g.key}" ${d.usergrade==g.key?'selected':''}>${g.value}</option>
						</c:if>
					</c:forEach>
					</select>
					</td>
					<td style="text-align:center;width:100px;">${d.name}</td><%-- <a href="manage?cmd=bread&idx=${d.idx}"></a> --%>
					<td style="width:180px;">${d.email}</td>
					<td style="text-align:center;width:120px;">${d.phonenum}</td>
					<td>${d.address}</td>
				</tr>
			</c:forEach>
			</table>
			
			<!-- 페이징 -->
			<div class="paging">
				<c:if test="${start ne 1}">
					<a class="abn" href="/manage/mlist?page=${start-1}&psize=${pagesize}&type=${type}&keyword=${keyword}"><i class="fas fa-angle-left"></i> 이전</a>
				</c:if>
				<c:forEach var="i" begin="${start}" end="${end<totalpage?end:totalpage}">
					<a style="${i eq page?'color:#03c75a;border:1px solid #e5e5e5;':'color:black'}" href="/manage/mlist?page=${i}&psize=${pagesize}&type=${type}&keyword=${keyword}">${i}</a>
				</c:forEach>
					<c:if test="${end<totalpage}">
					<a class="abn" href="/manage/mlist?page=${start+10}&psize=${pagesize}&type=${type}&keyword=${keyword}">다음 <i class="fas fa-angle-right"></i></a>
				</c:if>
			</div>
			<div class="search-form">
				<!-- 검색  -->
				<form action="/manage/mlist" method="post">
					<select name="type">
						<option value="id" ${empty type || type=='id'?'selected':''}>아이디</option>
						<option value="name" ${type=='name'?'selected':''}>이름</option>
						<option value="usergrade" ${type=='usergrade'?'selected':''}>회원등급</option>
					</select>
					<input type="search" name="keyword" value="${keyword}" placeholder="검색어를 입력해주세요">
					<input type="hidden" name="psize" value="${pagesize}">
					<input type="submit" value="검색">
				</form>
			</div> 
		</div>
		
	</section>
	<%@ include file="../common/footer.jsp" %>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		/* 회원등급 select값 변경시 비동기식으로 db반영. 관리자가 0명이 되지 않게 막아놓음 */
		$(".ajax-sel").on('change',ajaxFnc);
		function ajaxFnc() {
			var params = "grade="+$(this).val()+"&id="+$(this).parent().prev().text();
			$.ajax({
				type:"post",
				url:"/manage/chgMemGrade",
				data:params,
				dataType:"json",
				success:function(data){
					if(data.sign=="no"){
						alert("관리자는 한명 이상이여야합니다");
						location.reload();
					}
				},
				error:function(request,status,error){
				    alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				 }

			});
		}
		/* 한페이지당 노출되는 회원수 select 값 변경시 요청 */
		$("#psize").change(function(){
			var type = '${type}';
			var keyword = '${keyword}';
			console.log(type);
			var str ="/manage/mlist?type="+type+"&keyword="+keyword+"&psize="+$("#psize").val();
			location.href=str;
		});
	});
</script>
</body>
</html>