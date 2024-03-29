<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sos.member.model.vo.Member
				,java.util.HashMap" 
%>

<%
	HashMap<String, Integer> me = (HashMap<String, Integer>)request.getAttribute("myInfo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 메인페이지</title>

<!-- 마이페이지(메인페이지) css 파일 링크연결 -->
<link href="<%= request.getContextPath() %>/resources/css/myPage/myPageMain.css" rel="stylesheet">

</head>
<body>

	 <div class="wrap">
	 
    	<%@ include file="/views/common/header.jsp" %>
    	
    	<% if(loginUser == null){ // alert 시킬 알람문구가 존재할 경우 %>
	        <script>
	           alert('로그인을 먼저 진행해주세요'); // 문자열 취급시 따옴표로 감싸야됨
	           location.href="<%=contextPath%>/loginForm.me";
	        </script>
		<% } %>

<!-- ----------------------------------------------------------------------------------------------------------------------------------------- -->

	    <!-- Section start -->
	    <section class="main-content pt-3">
	
	        <div class="main-wrap">
	        
<!-- ============================================================================================================================================== -->
	        
	            <!-- 마이페이지 사이드 nav바 start -->
				<div class="menu_wrap" style="margin-top: 120px; width:200px;">
				
				    <div class="side_menu">
				        <button class="list">회원정보</button>
				        <div><a href="" id="updateMemInfo" class="" style="color:white; text-decoration-line:none;">회원정보 변경</a></div>
				        <div><a href="<%= contextPath %>/updatePwdForm.me" style="color:white; text-decoration-line:none;">비밀변호 변경</a></div>
				        <div><a href="<%= contextPath %>/address.me" style="color:white; text-decoration-line:none;">배송지관리</a></div>
				        <div><a href="" id="deleteAccount" style="color:white; text-decoration-line:none;">회원탈퇴</a></div>
				    </div>
				
				    <div class="side_menu">
				        <button class="list" id="my-tree">My Tree</button>
				    </div>
				
				    <div class="side_menu">
				        <button type="button" id="likeList" class="list">찜목록</button>
				    </div>
				
				    <div class="side_menu">
				        <button class="list">고객문의</button>
				        <div>
				        <a href="<%= contextPath %>/qlist.me?type=1" style="color:white; text-decoration-line:none;">상품문의</a><br>
				        <a href="<%= contextPath %>/qlist.me?type=2" style="color:white; text-decoration-line:none;">1:1 문의</a>
				        </div>
				    </div>
				
				    <div class="side_menu">
				        <button class="list" id="orderList">주문조회</button>
				    </div>
				
				</div>
				
				<script>
				   $(function(){
					   
					   	// 사이드메뉴-MyTree(내가 작성한 레피시목록페이지) 이동요청 버튼클릭시 실행될 함수
					   	$("#my-tree").click(function(){
					   		location.href = "<%= contextPath %>/recipe.me?page=1";
					   	})
					   	
					   	// 사이드메뉴-주문조회 이동요청 버튼클릭시 실해될 함수
					   	$("#orderList").click(function(){
					   		location.href = "<%= contextPath %>/olist.me";
					   	})
					   	
					   	// 사이드메뉴-찜목록 이동요청 버튼클릭시 실행될 함수
					    $("#likeList").click(function(){
					    	location.href="<%= contextPath %>/like.me?type=p&page=1";
					    })	
					   
					    // 회원탈퇴페이지 요청시 실행될 함수
					    $("#deleteAccount").click(function(e){
					    	
					    	// 회원탈퇴페이지 진입이후 동일페이지 재요청할 경우 : 비밀번호확인 x
					    	if(location.href.indexOf("<%= contextPath %>/deleteForm.me") == -1){
					    		
					    		let userPwd = prompt("본인확인을 위해 비밀번호를 입력해주세요.", "");
					    		
					    		if("<%= loginUser.getUserPwd() %>" == userPwd){
					    			/* 
									    * 로그인한 회원(회원탈퇴 요청회원)의 비밀번호와 사용자가 입력한 비밀번호가 일치할경우
									   	* ==> 회원탈퇴페이지 이동
									   */
									   $(this).attr("href", "<%= contextPath %>/deleteForm.me");
					    		}
					    		
					    		 if(userPwd != null && "<%= loginUser.getUserPwd() %>" != userPwd){
									   /*
									    * 로그인한 회원(정보변경 요청한 회원)의 비밀번호와 사용자가 입력한 비밀번호가 일치하지 않을경우
									    * ==> alert("실패메세지")
									   */
									   alert("비밀번호가 일치하지 않습니다.");
							   } 
					    	}
					    })
					   
						// 회원정보변경페이지 요청시 실행될 함수
					    $("#updateMemInfo").click(function(e){
					    	
						  // 회원정보변경페이지 진입이후 동일페이지를 재요청할 경우 : 비밀번호확인 x
						   if(location.href.indexOf("<%= contextPath %>/updateForm.me") == -1){
							   
							   let userPwd = prompt("본인확인을 위해 비밀번호를 입력해주세요.", "");
							   
							   if("<%= loginUser.getUserPwd() %>" == userPwd){
									   /* 
									    * 로그인한 회원(정보변경을 요청한 회원)의 비밀번호와 사용자가 입력한 비밀번호가 일치할경우
									   	* ==> 회원정보변경 페이지 이동
									   */
									   $(this).attr("href", "<%= contextPath %>/updateForm.me");
								   }
							   
							   if(userPwd != null && "<%= loginUser.getUserPwd() %>" != userPwd){
									   /*
									    * 로그인한 회원(정보변경 요청한 회원)의 비밀번호와 사용자가 입력한 비밀번호가 일치하지 않을경우
									    * ==> alert("실패메세지")
									   */
									   alert("비밀번호가 일치하지 않습니다.");
							   } 
						   }
						   
						   
					   })
					   
						// 마이페이지 nav메뉴바 목록 슬라이딩 처리용 함수
				        $(".side_menu>button").click(function(){       
				            const $b = $(this).nextAll();
				
				            if($b.css("display") == "none") {          
				                $(".list").siblings("div").slideUp();
				                $b.slideDown();         
				            }else{
				                $b.slideUp();
				            }
				
				        })
				    })
				</script>
				<!-- 마이페이지 사이드 nav바 end -->

<!-- ============================================================================================================================================== -->

	
	            <!-- nav바 별 메인페이지 (보이는 페이지) : nav바 옆에 start -->
	            <div class="main-page" style="margin-top: 120px;">
	
	                <!-- 페이지 제목 영역 start -->
	                <div class="page-title">
	                    <svg id="main" style="pointer-events: visible; cursor: pointer;" xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="user-icon me-4 mb-2" viewBox="0 0 16 16">
	                        <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
	                    </svg>
	                    <h3><b>마이페이지</b></h3>
	                </div>
	                <!-- 페이지 제목 영역 end -->
	                
	                <script>
                    	$(function(){
                    		// 회원아이콘 클릭시, 마이페이지-메인페이지 이동요청시 실행될 함수
                    		$("#main").click(function(){
                    			location.href="<%= contextPath %>/myPage.me";
                    		})
                    	})
                    </script>
	
	                <!-- 회원정보 영역(오른쪽 상단) start -->
	                <div class="user-info">
	                    
	                    <div class="profile">
	                        <img src="<%= contextPath + '/' + loginUser.getUserPath() %>" alt="" id="userProfile">
	                    </div>
	
	                    <div class="profile-right">
	                        <h3><b id="userName"><%= loginUser.getUserName() %></b>님! 안녕하세요</h3>
	                        
	                        <!-- 각 메뉴 클릭시, 해당페이지로 이동 -->
	                        <div class="profile-right-bottom mt-5">
	                            
	                            <div class="user-info-etc" style="border-right: 2px solid lightgray;" onclick="orderList();">
	                                <b class="d-block">배송중</b>
	                                <h6><b><%= me.get("totalDelivering") %></b>개</h6>
	                            </div>
	
	                            <!--
	                                뺐지만, 일단 화면에 넣으는 놓음
	                            -->
	                            <!--  
	                            <div class="user-info-etc" style="border-right: 2px solid lightgray;">
	                                <b class="d-block">환불/반품</b>
	                                <h6><b>1</b>개</h6>
	                            </div>
								-->
	                            <div class="user-info-etc" style="border-right: 2px solid lightgray;" onclick="likedProduct();">
	                                <b class="d-block">찜한상품</b>
	                                <h6><b><%= me.get("totalLikedProduct") %></b>개</h6>
	                            </div>
	
	                            <div class="user-info-etc" style="border-right: 2px solid lightgray;" onclick="likedRecipe();">
	                                <b class="d-block">찜한레시피</b>
	                                <h6><b><%= me.get("totalLikedRecipe") %></b>개</h6>
	                            </div>
	
	                        </div>
	                    </div>
	                    
	                    <script>
	                    	// 주문목록페이지 이동시 실행될 함수
	                    	function orderList(){
	                    		location.href="<%= contextPath %>/olist.me";
	                    	}
	                    	
	                    	// 찜상품목록페이지 이동시 실행될 함수
	                    	function likedProduct(){
	                    		location.href="<%= contextPath %>/like.me?type=p&page=1";
	                    	}
	                    	
	                    	// 찜레시피페이지 이동시 실행될 함수
	                    	function likedRecipe(){
	                    		location.href="<%= contextPath %>/like.me?type=r&page=1";
	                    	}
	                    </script>
	
	                </div>
	                <!-- 회원정보 영역(오른쪽 상단) end -->
	
	                <!-- 고객문의 진행사항 영역(오른쪽 하단) start-->
	                <div class="customer-qna-area">
	                    
	                    <h3><b>고객문의 진행사항</b></h3>
	
	                    <div class="qna-wrap">
	                        <!-- 상품문의 -->
	                        <div class="product-qna">
	                            <h4 class="my-4"><b>상품문의</b></h4>
	
	                            <!-- 현재 진행중인 고객문의 표시 -->
	                            <h6 class="mt-2 mb-3 pb-3" style="width: 250px; text-align: center; padding-bottom:6px; border-bottom:1px solid grey;"><b>진행중 문의</b></h6>
	                            <% if(me.get("totalOngoingQnaProduct") == 0 ) { %>
	                            	<h6 style="color: rgb(158, 155, 155); margin-top:50px;">진행 중인 문의가 존재하지 않습니다.</h6>
	                            <% } else { %>
	                            	<h6 style="margin-top:50px;">진행 중인 문의 총 <b style="font-size: 20px;"><%= me.get("totalOngoingQnaProduct") %></b> 건 존재합니다.</h6>
	                            <% } %>
	                            
	                            <!-- 클릭시 해당 문의페이지로 이동-->
	                            <a class="btn btn-secondary confirm" href="<%= contextPath %>/qlist.me?type=1">문의확인</a>
	                        </div>
	
	                        <!-- 1:1 문의 -->
	                        <div class="etc-qna">
	                            <h4 class="my-4"><b>1 : 1 문의</b></h4>
	
	                            <!-- 현재 진행중인 고객문의 표시 -->
	                            <h6 class="mt-2 mb-3 pb-3" style="width: 250px; text-align: center; padding-bottom:6px; border-bottom:1px solid grey;"><b>진행중 문의</b></h6>
	                            <% if(me.get("totalOngoingQnaEtc") == 0 ) { %>
	                            	<h6 style="color: rgb(158, 155, 155); margin-top: 50px;">진행 중인 문의가 존재하지 않습니다.</h6>
	                            <% } else { %>
	                            	<h6 style="margin-top:50px;">진행 중인 문의 총 <b style="font-size: 20px;"><%= me.get("totalOngoingQnaEtc") %></b> 건 존재합니다.</h6>
	                            <% } %>
	
	                            <!-- 클릭시 해당 문의페이지로 이동-->
	                            <a class="btn btn-secondary confirm" href="<%= contextPath %>/qlist.me?type=2">문의확인</a>
	                        </div>
	                    </div>
	                    
	
	                </div>
	                <!-- 고객문의 진행사항 영역(오른쪽 하단) end-->
	
	            </div>
	            <!-- nav바 별 메인페이지 (보이는 페이지) : nav바 옆에 end -->
	
	        </div>
	
	    </section>
	    <!-- Section end -->

<!-- ----------------------------------------------------------------------------------------------------------------------------------------- -->

        <%@ include file="/views/common/footer.jsp" %>
        
    </div>
        
</body>
</html>