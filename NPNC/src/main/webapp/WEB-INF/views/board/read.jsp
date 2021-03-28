<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.npnc.board.dto.RDto"%>
<%@page import="com.npnc.board.dao.BDao"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
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
		           
		            <div class="dto-header">
		                <a href="/board/list?category=${category}" class="board-title" style="color: #03c75a"></a>
		            </div>
		            <div class="dto-header">
		                <span class="content-title" style="font-size: 20px;">${dto.title}</span>
		            </div>
		            <div class="dto-header">
		                <span class="id" style="font-weight: bold; padding-left:2px">${dto.id}</span>
		            </div>
		            <div class="dto-header">
		                <span style="color:lightgray;">${dto.regdate}</span>&nbsp;|&nbsp;조회수&nbsp;&nbsp;${dto.hit}&nbsp;|&nbsp;<a class="gob" href="#" style="${goodbad == 1?'font-weight:bold':''}">좋아요&nbsp;&nbsp;<span style="color:red">${dto.good}</span></a>&nbsp;|&nbsp;<a class="gob" href="#" style="${goodbad == 0?'font-weight:bold':''}">싫어요&nbsp;&nbsp;<span style="color:blue">${dto.bad}</span></a></span>
		            </div>
		                <c:if test="${!empty dto.file}">
		            <div class="dto-header">
			                <span>첨부파일&nbsp;&nbsp;|&nbsp;&nbsp;<a href="${uploadpath}/${dto.savedfile}" download="${dto.file}">${dto.file}</a></span>
					</div>
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
		            	댓글&nbsp;<span id="reply-cnt" style="font-weight: bold;">${fn:length(rdto)}</span>
		            </div>
		            
		            
		            <div id="reply-list">
		            <c:forEach var="reply1" items="${rdto}" varStatus="status">
						<%--
						 댓글끼리 구분선 구현
						반복문 마지막때 구분선 사라지는 로직.
						--%>
			           			<div style="border-bottom: 1px solid lightgray;">
				            		<span style="font-weight:bold;">${reply1.id}</span><br>
					            	<span>${reply1.content}</span><br>
					            	<span style="color:lightgray;"><fmt:formatDate value="${reply1.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/>  </span>
					            		<!-- 작성자만 삭제 수정 가능 -->
					            		<c:if test="${sessionScope.id eq reply1.id }">
					            			<button class="reply-update">수정</button>
					            			<button class="reply-del ${reply1.ridx}">삭제</button>
					            		</c:if>
					            		<!-- 관리자는 삭제만 가능 -->
					            		<c:if test="${(sessionScope.id ne reply1.id) && (sessionScope.grade eq 0)}">
					            			<button class="reply-del ${reply1.ridx}">삭제</button>
					            		</c:if>
				            	</div>
		            </c:forEach>
		            
		            </div>
		            
		            
		            <!-- 댓글입력 구현부 -->
		            <c:if test="${!empty sessionScope.id}">
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
		            </c:if>
		        </article>
		        
		        
		        <!-- 수정 삭제, 게시글의 작성자 아이디와, 로그인세션 ID값 검사하여 보여줌. -->
		        <div id="btns">
		       	<c:if test="${sessionScope.id eq dto.id}">
			        <button id="btn-edit" onclick="location.href='/board/update?idx=${dto.idx}'">수정</button>
			        <button id="btn-del">삭제</button>
		   		</c:if>
		   		<!-- 관리자는 삭제만 가능 -->
		    	<c:if test="${(sessionScope.id ne reply1.id) && (sessionScope.grade eq 0)}">
		         	<button id="btn-del">삭제</button>
		    	</c:if>
		    	<button id="btn-list"  onclick="location.href='/board/list?category=${category}'">목록</button>
		    	</div>
		    </article>
	    </div>
    </section>
   	<%@ include file="ajax_blist.jsp" %>
	<%@ include file="../common/footer.jsp" %>
</div>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script>
	$(function(){
		
		//등록된지 1시간 안된 댓글 옆에 new 달기
		var updateTime = new Date();
		for(var i=0;i<$("#reply-list").children().length;i++){
			var dateTmp = $("#reply-list").children().eq(i).children().eq(4);
			//dateTmp = dateTmp.substring(0,dateTmp.length-2);
			var m = moment(dateTmp.text(),"YYYY-MM-DD HH:mm:ss");
			if(updateTime.getTime()-1000*60*60<m.toDate().getTime()){
				dateTmp.after($("<span style='color:red;font-size:10px;'>new  </span>"));	
			}
		}
		/*카테고리 이름 가져오기 */
		 var read_category = $("#cidx-${category}").text();
		 if(read_category==""){
			 $(".board-title").html("&nbsp;>");
		 }else{
			 $(".board-title").html(read_category+"&nbsp;>");
		 }
		 
		 $("#btn-del").click(function(){
			if(confirm("게시글을 삭제하시겠습니까?")){
				location.href = "/board/delete?idx="+${dto.idx}+"&category="+${category};
			}
		 });
		 
		 //댓글 수정 버튼 클릭시 수정 폼 생성
		 var reply_update_btn;
		 $(document).on("click",".reply-update",function(){
			 if($(this).prev().text()=="new  "){
				 var text = $(this).prev().prev().prev().prev().text();
				 $(this).prev().prev().prev().prev().html($("<input type='text' id='input-reply' name='update' value='"+text+"'><input type='button' class='reply_update_ok' value='완료'>  <input type='button' class='reply_update_cancel' value='취소'>"));
				 $(this).prev().prev().prev().prev().children().eq(0).focus();
				 $(this).prev().prev().prev().prev().children().eq(0).select();
			 }else{
				 var text = $(this).prev().prev().prev().text();
				 $(this).prev().prev().prev().html($("<input type='text' id='input-reply' name='update' value='"+text+"'><input type='button' class='reply_update_ok' value='완료'>  <input type='button' class='reply_update_cancel' value='취소'>"));
				 $(this).prev().prev().prev().children().eq(0).focus();
				 $(this).prev().prev().prev().children().eq(0).select();
			 }
			 reply_update_btn = $(this).detach();
		 });
		 //댓글 수정 취소 버튼 선택시 새로 댓글 리스트를 가져옴
		 $(document).on("click",".reply_update_cancel",function(){
			 var params = "bidx=${dto.idx}";
				$.ajax({
					type:"post",
					url:"/board/getReplyList",
					data:params,
					dataType:"json",
					success:function(data){
						var newR = data.newR;
						updateNewReply(newR);
					},
					error:function(request,status,error){
					    alert("작업 실패");
					 }

				});
		 });
		 //댓글 수정완료 버튼 클릭시
		 $(document).on("click",".reply_update_ok",function(){
			 var ridx = 0;
			 if($(this).parent().next().next().next().text()=="new  "){
				 ridx = $(this).parent().next().next().next().next().attr("class").split(" ")[1];
			 }else{
				 ridx = $(this).parent().next().next().next().attr("class").split(" ")[1];
			 }
			 var rcontent = $(this).prev().val(); 
			 var params = "ridx="+ridx+"&content="+ rcontent+"&bidx=${dto.idx}";
				$.ajax({
					type:"post",
					url:"/board/updateReply",
					data:params,
					dataType:"json",
					success:function(data){
						var newR = data.newR;
						updateNewReply(newR);
					},
					error:function(request,status,error){
					    alert("작업 실패");
					 }

				});
		 });
		 
		 //댓글 삭제
		 $(document).on("click",".reply-del",deleteReply);
		 //댓글 입력
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
					updateNewReply(newR);
					$("#input-reply").val("");
				},
				error:function(request,status,error){
				    alert("작업 실패");
				 }

			});
		}
		 function deleteReply() {
			 if(confirm("댓글을 삭제하시겠습니까?")){
				var params = "ridx="+$(this).attr("class").split(" ")[1]+"&bidx="+"${dto.idx}";
				$.ajax({
					type:"post",
					url:"/board/deleteReply",
					data:params,
					dataType:"json",
					success:function(data){
						var newR = data.newR;
						updateNewReply(newR);
					},
					error:function(request,status,error){
					    alert("작업 실패");
					 }
				});
			 }
		}
		//댓글 수정 및 입력 삭제 후 댓글 리스트 업데이트
		function updateNewReply(newR){
			var replylist = $("#reply-list");
			replylist.empty();
			for(var i=0;i<newR.length;i++){
				var divr = $("<div style='border-bottom: 1px solid lightgray;'></div>");
				var spanid = $("<span style='font-weight:bold;'></span>");
				spanid.text(newR[i].id);
				var spancontent = $("<span></span>");
				spancontent.text(newR[i].content);
				var spandate = $("<span style='color:lightgray;'></span>");
				var regdate_ = new Date(newR[i].regDate);
				spandate.text(moment(regdate_).format('YYYY-MM-DD HH:mm:ss')+"  ");
				var updBtn = $("<button class='reply-update'>수정</button>");
				var delBtn = $("<button class='reply-del'>삭제</button>");
				delBtn.addClass(newR[i].ridx+"");
				divr.append(spanid);
				divr.append($("<br>"));
				divr.append(spancontent);
				divr.append($("<br>"));
				divr.append(spandate);
				if(updateTime.getTime()-1000*60*60<newR[i].regDate){
					divr.append($("<span style='color:red;font-size:10px;'>new  </span>"));
				}
				
				
				if("${sessionScope.id}"==newR[i].id){
					divr.append(updBtn);
					divr.append("  ");
					divr.append(delBtn);
				}
				replylist.append(divr);
			}
			$("#reply-cnt").text(newR.length);
		} 
		
		//좋아요 싫어요 버튼 클릭시
		//기존에 선택 여부를 비교하여 처리
		$(document).on("click",".gob", function(e){
			e.preventDefault();
			if("${sessionScope.id}" != ""){
				var isG = $(".gob").eq(0).css("font-weight");
				var isB = $(".gob").eq(1).css("font-weight");
				var urlgob = "";
				var params = "idx="+${dto.idx};
				if(isG==400 && isB==400){
					urlgob = "/board/insertGob";
					if($(this).text().substring(0,3) == "좋아요"){
						params += "&gob=true";
					}else{
						params += "&gob=false";
					}
				}else if((isG==700 && $(this).text().substring(0,3) == "좋아요") || (isB==700 && $(this).text().substring(0,3) == "싫어요")){
					urlgob = "/board/deleteGob";
				}else{
					urlgob = "/board/updateGob";
					if($(this).text().substring(0,3) == "좋아요"){
						params += "&gob=true";
					}else{
						params += "&gob=false";
					}
				}
				
				$.ajax({
					type:"post",
					url: urlgob,
					data:params,
					dataType:"json",
					success:function(data){
						$(".gob").eq(0).children().eq(0).text(data.gbresult.good);
						$(".gob").eq(1).children().eq(0).text(data.gbresult.bad);
						$(".gob").eq(0).css("font-weight","400");
						$(".gob").eq(1).css("font-weight","400");
						if(data.dogob == "insert"){
							if(data.goodbad){
								$(".gob").eq(0).css("font-weight","700");
							}else{
								$(".gob").eq(1).css("font-weight","700");
							}
						}else if(data.dogob == "update"){
							if(data.goodbad){
								$(".gob").eq(0).css("font-weight","700");
							}else{
								$(".gob").eq(1).css("font-weight","700");
							}
						}
					},
					error:function(request,status,error){
						  alert("작업 실패");
				 	}
				});
			}else{
				alert("로그인 후에 이용하실 수 있습니다");
			}
		});
	});
</script>

</body>
</html>