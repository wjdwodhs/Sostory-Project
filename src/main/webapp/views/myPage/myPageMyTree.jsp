<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List
				,com.sos.recipe.model.vo.Recipe
				,com.sos.common.model.vo.PageInfo" 
%>
<%
	List<Recipe> list = (List<Recipe>)request.getAttribute("recipeList");
	PageInfo pi = (PageInfo)request.getAttribute("pageInfo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Tree</title>

<!-- 마이페이지(MyTree) css 파일 링크연결 -->
<link href="<%= request.getContextPath() %>/resources/css/myPage/myPageMyTree.css" rel="stylesheet">

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

            <div class="main-wrap" style="margin-top: 160px;">

<!-- =========================================================================================================================== -->

              <!-- 사이드 nav바 start -->
		      <div class="menu_wrap" style="width:200px;">
		
		          <div class="side_menu">
		              <button class="list">회원정보</button>
		              <div><a href="" id="updateMemInfo" style="color:white; text-decoration-line:none;">회원정보 변경</a></div>
		              <div><a href="<%= contextPath %>/updatePwdForm.me" style="color:white; text-decoration-line:none;">비밀변호 변경</a></div>
		              <div><a href="<%= contextPath %>/address.me" style="color:white; text-decoration-line:none;">배송지관리</a></div>
		              <div><a href="" id="deleteMember" style="color:white; text-decoration-line:none;">회원탈퇴</a></div>
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
		
			   <!-- 네비메뉴바 스크립트 -->
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
				   $("#deleteMember").click(function(e){
					   
					  /* 
					   * case 01) 회원탈퇴페이지 진입이후 동일페이지를 재요청할 경우 : 비밀번호확인 x
					   * case 02) 이외페이지에서 회원탈퇴페이지 요청할 경우 : 비밀번호확인
					  */
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
								    * 로그인한 회원(회원탈퇴 요청회원)의 비밀번호와 사용자가 입력한 비밀번호가 일치하지 않을경우
								    * ==> alert("실패메세지")
								   */
								   alert("비밀번호가 일치하지 않습니다.");
						   } 
					   }
					   
					   
				   })
				   
				   // 회원정보변경페이지 요청시 실행될 함수
				   $("#updateMemInfo").click(function(e){
					   
					   /* 
					    * case 01) 회원정보변경페이지 진입이후 동일페이지를 재요청할 경우 : 비밀번호확인 x
					    * case 02) 이외페이지에서 회원정보변경페이지 요청할 경우 : 비밀번호확인
					    */
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
		      	<!-- 사이드 nav바 end -->

<!-- =========================================================================================================================== -->

                <!-- MyTree 페이지 영역 start -->
                <div class="main-page">

                    <!-- 페이지 제목 영역 start -->
                    <div class="page-title">
                        <svg id="main" style="pointer-events: visible; cursor: pointer;" xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor" class="user-icon me-4 mb-2" viewBox="0 0 16 16">
                            <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                        </svg>
                        <h3><b>MyTree</b><label>내가 작성한 레시피</label></h3>
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

                    <!-- 작성한 레시피목록 테이블 영역 start -->
                    <div class="recipe-list mt-4">
                        <table class="table">
                            <thead>
                                <tr style="line-height:50px; font-size:20px;">
                                    <th></th>
                                    <th>레시피명</th>
                                    <th>작성일</th>
                                    <th>좋아요</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                            
                            <% if(list.isEmpty()) { %>
                            	<tr>
                            		<td colspan="5" class="fs-4">조회된 레시피가 없습니다.</td>
                            	</tr>
                            <% } else { %>
                            	<!-- 
                                    기능설명 : 이미지 or 레시피명 클릭시, 레시피 상세페이지로 이동
                                    기능구현 : 아래 script로 location.href 이동 함수있음 (URL 채우면됨)  
                                -->
                                <% for(Recipe r : list) { %>
                                <tr style="height:250px;">
                                    <td class="recipe-thumbnail" style="cursor:pointer;" onclick="detail(<%= r.getRecipeNo() %>);"><img src="<%= contextPath + '/' + r.getThumbnailUrl() %>" alt="레시피썸네일" style="width: 300px; height:200px; !important;"></td>
                                    <td class="recipe-title fs-4 fw-bold" style="cursor:pointer;" onclick="detail(<%= r.getRecipeNo() %>);"><%= r.getRecipeTitle() %></td>
                                    <td class="fs-5"><%= r.getPostDate() %></td>
                                    <td class="fs-5"><%= r.getLikeCount() %></td>
                                    <!-- 
                                        기능설명 : 수정버튼 클릭시, 레시피 수정페이지로 이동 
                                        기능구현 : 태그내 href 속성에 수정페이지 URL 넣으면됨
                                    -->
                                    <td> 
                                        <!-- 
                                            기능설명 : 삭제버튼 클릭시, confirm 팝업 후 삭제 
                                            기능구현 : 아래 삭제여부 확인용 팝업창있음
                                        -->
                                        <button type="button" class="btn text-danger fs-5" onclick="deleteRecipe(<%= r.getRecipeNo() %>)">삭제</button>
                                    </td>
                                </tr>
								<% } %>
                            <% } %>
                                
                            </tbody>
                        </table>
                        
                        
                        <script>
                        	// 레시피 상세피이지 이동요청시 실행될 함수
                        	function detail(recipeNo){
                        		location.href="<%= contextPath %>/detail.re?no=" + recipeNo;
                        	}
                        	
                        	// 사용자가 작성한 레시피 삭제요청시 실행될 함수
                        	function deleteRecipe(recipeNo){
                        		// 삭제여부 재확인
                        		if(confirm("해당 레시피를 삭제하시겠습니까?")){
                        			$.ajax({
                            			url:"<%= contextPath %>/deleteRecipe.me",
                            			data:{"recipeNo" : recipeNo},
                            			success:function(result){
                            				console.log(result);
                            				if(result > 0){
                            					alert("레시피가 삭제되었습니다.");
                            					location.reload();
                            				}else{
                            					alert("레시피 삭제가 정상적으로 진행되지않았습니다.");
                            				}
                            			}
                            		})
                        		}
                        		
                        	}
                        </script>

                        <!-- 레시피 삭제여부 확인 팝업창 start -->
                        <div class="modal" id="delete-recipe">
                            <div class="modal-dialog">
                            <div class="modal-content">
                            
                                <!-- Modal body -->
                                <div class="modal-body my-4" style="font-size: 20px;">
                                    레시피를 정말 삭제하시겠습니까?
                                </div>
                                
                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <div class="d-flex">
                                        <button type="reset" class="btn btn-secondary me-3 px-4" data-dismiss="modal">취소</button>
                                        <!-- 확인버튼 클릭시 삭제진행 -->
                                        <a href="" class="btn btn-danger px-4" data-dismiss="modal">확인</a>
                                    </div>
                                </div>
                                
                            </div>
                            </div>
                        </div>
                        <!-- 레시피 삭제여부 확인 팝업창 end -->

                        <script>
                            $(function(){

                                // 레시피이미지 or 레시피명 클릭이벤트 발생시 실행될 함수
                                $(".recipe-list").on("click", "#recipe-thumbnail, #recipe-title", function(){
                                    location.href="레시피 상세페이지 이동 URL";
                                })

                            })

                        </script>
                        
                        <!-- 기능 : 5개 단위 페이징처리 -->
                        <div class="center" style="margin-top: 150px;">
                            <ul class="pagination">
                            <!-- 이전페이지 이동버튼 활성화여부
                            	* 비활성화 : 현재페이지 == 1페이지   
                            	*  활성화 : 현재페이지 != 1페이지 ==> (현재페이지 - 1)페이지 이동요청 URL
                             -->
                            <% if(pi.getCurrentPage() == 1 || pi.getMaxPage() == 0) { %>
                            	<li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                            <% } else { %>
                            	<li class="page-item"><a class="page-link" href="<%= contextPath %>/recipe.me?page=<%= pi.getCurrentPage() - 1 %>">Previous</a></li>
                            <% } %>
                            <!-- 지정페이지 이동버튼 활성화여부 
                            	* 비활성화 : 현재페이지 != 보고있는페이지 ==> (지정)페이지 이동요청 URL
                            	*  활성화 : 현재페이지 == 보고있는페이지
                             -->
                           	<% for(int p=pi.getStartPage() ; p<=pi.getEndPage() ; p++) { %>
                                <% if(pi.getCurrentPage() == p) { %>
                                	<li class="page-item active"><a class="page-link" href="#"><%= p %></a></li>
                                <% } else { %>
                                	<li class="page-item"><a class="page-link" href="<%= contextPath %>/recipe.me?page=<%= p %>"><%= p %></a></li>
                                <% } %>
                            <% } %>
                            <!-- 다음페이지 이동버튼 활성화여부
                            	* 비활성화 : 현재페이지 == 최대페이지
                            	*  활성화 : 현재페이지 != 최대페이지 (현재페이지 + 1)페이지 이동요청 URL 
                             -->
                             <% if(pi.getCurrentPage() == pi.getMaxPage() || pi.getMaxPage() == 0) { %>
                             	<li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                             <% } else { %>
                             	<li class="page-item"><a class="page-link" href="<%= contextPath %>/recipe.me?page=<%= pi.getCurrentPage() + 1 %>">Next</a></li>
                             <% } %>
                            </ul>
                        </div>

                    </div>
                    <!-- 작성한 레시피목록 테이블 영역 end -->

                </div>   
                <!-- MyTree 페이지 영역 end -->
            </div>

        </section>
        <!-- Section end -->

<!-- ----------------------------------------------------------------------------------------------------------------------------------------- -->

        <%@ include file="/views/common/footer.jsp" %>
	     
	 </div>
</body>
</html>