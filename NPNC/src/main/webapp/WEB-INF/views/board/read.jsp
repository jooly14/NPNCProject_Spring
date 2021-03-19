<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.npnc.board.dto.RDto"%>
<%@page import="com.npnc.board.dao.BDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
   rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
 />
<link rel="stylesheet" href="/resources/css/board/blist.css"/>
<link rel="stylesheet" href="/resources/css/board/bread.css"/>
<link rel="stylesheet" href="/resources/css/common/nav_category.css"/>
<link rel="stylesheet" href="/resources/css/common/header.css"/>

</head>
<body>

<div id="wrap">
<%@ include file="../common/header.jsp" %>
	<section id="section1">
	<%@ include file="../common/nav_category.jsp" %>
    <div id="content">
	<article id="read" style="
							border : 1px solid lightgray;
							border-radius: 5px;
							padding : 30px;
	">
        <article id="read-head">
           
            <div>
                <a href="/board/list?category=${category}" class="board-title" style="color: #03c75a"></a><br>
                <span class="content-title" style="font-size: 20px;">&nbsp;${dto.title}</span>
            </div>
            
            <div>
                <span class="id" style="font-weight: bold;">&nbsp;${dto.id}</span><br>
                <span><span style="color:lightgray;">&nbsp;${dto.regdate}</span>&nbsp;|&nbsp;조회수&nbsp;:&nbsp;${dto.hit}&nbsp;|&nbsp;<a href="/board/upGob?idx=${dto.idx}&id=${sessionScope.id}&gob=true">좋아요</a>&nbsp;:&nbsp;<span style="color:red">${dto.good}</span>&nbsp;|&nbsp;<a href="/board/upGob?idx=${dto.idx}&id=${sessionScope.id}&gob=false">싫어요</a>&nbsp;:&nbsp;<span style="color:blue">${dto.bad}</span></span>
            </div>
            
		<c:if test="${gobResult eq 0}">
			<script>
				alert("이미 좋아요 & 싫어요 하였습니다.");
			</script>
		</c:if>
            
            <div class="content">
                <textarea style="resize: none;" readonly >${dto.content}</textarea>
            </div>
        </article>
        
        
        
        
        
        
        <%--댓글 가져오기 로직 --%>
        <%
        	 
        %>
        
        
        
        <!-- 댓글 가져오기 구현부 -->
        <article id="read-reply">
            <div style="border-bottom : 1px solid lightgray;
            			margin-top : 10px;
            			margin-bottom : 5px;
            			padding-bottom : 5px;
            			">
            	댓글&nbsp;<span style="font-weight: bold;">${fn:length(rdto)}</span>
            </div>
            
            
            <div id="reply-list">
            <c:forEach var="reply1" items="${rdto}" varStatus="status">
				<%--
				 댓글끼리 구분선 구현
				반복문 마지막때 구분선 사라지는 로직.
				--%>
	           			<div style="border-bottom: 1px solid lightgray;">
		            		<span style="font-weight:bold;">${reply1.id}</span><br>
			            	${reply1.content}<br>
			            	<span style="color:lightgray;">${reply1.regDate}</span>
			            		<c:if test="${sessionScope.id eq reply1.id }">
			            			<button id="reply-del" onclick="location.href='/board/rdel?ridx=${reply1.ridx}&bidx=${reply1.bidx}'">삭제</button>
			            		</c:if>
		            	</div>
            </c:forEach>
            
            </div>
            
            
            <!-- 댓글입력 구현부 -->
            <form id="insert-reply-form" action="/board/" style="border : 1px solid lightGray;
            			 border-radius: 3px;
            			 padding : 10px;
            			 margin-top : 5px;
            			">
            	<label style="font-weight : bold;">${sessionScope.id}</label><br>
            	<input type="text" name="reply" id="input-reply" placeholder="댓글을 남겨보세요">
            	<input type="hidden" name="bidx" value="${dto.idx}">
            	<input type="button" value="등록" id="btn-reply" style="background-color : #7affcf; margin : 0px;">
            </form>
        </article>
        
        
        <!-- 수정 삭제, 게시글의 작성자 아이디와, 로그인세션 ID값 검사하여 보여줌. -->
        <div id="btns">
        <c:choose>
        	<c:when test="${sessionScope.id eq dto.id}">
		        <button id="btn-edit"  onclick="location.href='/board/bedit?idx=${dto.idx}'">수정</button>
		        <button id="btn-del"  onclick="location.href='/board/bdelete?idx=${dto.idx}'">삭제</button>
		        
    		</c:when>
    		<c:otherwise>
    		</c:otherwise>
    	</c:choose>
    	<button id="btn-list"  onclick="location.href='/board/list?category=${category}'">목록</button>
    	</div>
    </article>
    </div>
    </section>
   <%--  <%@ include file="/view/board/ajax_blist.jsp" %> --%>
	<%@ include file="../common/footer.jsp" %>
</div>

<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	
	$(function(){
		/*카테고리 이름 가져오기 */
		 var read_category = $("#cidx-${category}").text();
		 if(read_category==""){
			 $(".board-title").html("&nbsp;&nbsp;>");
		 }else{
			 $(".board-title").html("&nbsp;"+read_category+"&nbsp;>");
		 }
		 
		 $(document).on("click","#btn-reply",insertReply);
		 function insertReply() {
				var params = $("#insert-reply-form").serialize() ;
				$.ajax({
					type:"post",
					url:"/board/insertReply",
					data:params,
					dataType:"json",
					success:function(data){
						var newR = data.newR;
						var replylist = $("#reply-list");
						replylist.empty();
						for(var i=0;i<newR.length;i++){
							var divr = $("<div style='border-bottom: 1px solid lightgray;'></div>");
							var spanid = $("<span style='font-weight:bold;'></span>");
							var spancontent = $("<span></span>");
							var spandate = $("<span style='color:lightgray;'></span>");
							console.log(newR[i].content);
		            		<span style="font-weight:bold;">${reply1.id}</span><br>
			            	${reply1.content}<br>
			            	<span style="color:lightgray;">${reply1.regDate}</span>
			            		<c:when test="${sessionScope.id eq reply1.id }">
			            			<button id="reply-del" onclick="location.href='/board/rdel?ridx=${reply1.ridx}&bidx=${reply1.bidx}'">삭제</button>
			            		</c:when>
							
							replylist.append();
						}
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