<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sos.recipe.model.vo.Recipe"%>
<%@ page import= "java.util.List"%>
<%@ page import= "com.sos.member.model.vo.Member"%>
 
<% 
 	Recipe r = (Recipe)request.getAttribute("detailRecipe"); //레시피 상세에 들어갈 데이터들
 	List<Recipe> step = (List<Recipe>)request.getAttribute("step");//step
	List<Recipe> list = (List<Recipe>)request.getAttribute("ingredient");//재료
	int userLike = (int)request.getAttribute("userLike");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피상세</title>
<style>
	.main-content {
		margin-top: 50px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
	.detail_head{
		width: 100%;
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
	.detail_head>button{margin-left: auto;}
	.step_wrap{
		width: 100%;
		margin: 20px 0px;
	}
	.thumbnail{
		width: 100%;
		height: 500px;
		margin: 20px 0px;
		/* 임시 */
		background-color: grey;
	}
	.thumbnail>img{
		width: 100%;
		height: 100%;
	}
	.etc{
		display: flex;
		flex-direction: column;
		margin-right: auto;
		justify-content: flex-start;
	}
	.like{cursor: pointer;}
	.recipe_info{
	 	position:absolute;
		width: 350px;
		height: 200px;
		background-color: rgb(231, 76, 60);
		left: 60%;
		top: 700px;
		right: 630px;
		display: flex;
		flex-direction: column;
		align-items: center;
		box-shadow: 5px 5px 3px grey;
	}
	.recipe_info td{
		width: 100px;
		text-align: center;
		font-weight: bold;
	}
	.recipe_info *{color: white;}
	.recipe_info table{margin-top: 20px;}
	.info_top>td, .info_btm>td{font-size: large;}
	.info_mid>td{font-size: 35px;}
	.recipe_summary{
		border-top: 1px solid lightgray;
		font-size: large;
		color: grey;
		padding: 10px 0px;
	}
	.content{
		width: 100%;
		margin: 20px 0px;
		display: flex;
	}
	.content_detail{
		width: 60%;
		display: flex;
		flex-direction: column;
		align-items: flex-start;
	}
	.content_detail>div{width: 100%;}
	.recipe_step{
		font-size: 25px;
		color: rgb(231, 76, 60);
		font-weight: bold;
		margin-bottom: 5px;
	}
	.step_content{
		font-weight: bold;
		font-size: large;
		margin: 10px 0px;
		padding-right: 40px;
	}
	.content_etc{
		width: 60%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.step_img{
		background-color: grey;
		width: 100%;
		height: 350px;
		padding-right: 40px;
		background-clip: content-box;
		margin-bottom: 40px;
	}
	.ingredient_info{
		width: 80%;
		margin-bottom: 50px;
	}
	.ingredient_info>div{
		font-size: 20px;
		font-weight: bold;
		padding-bottom: 20px;
	}
	.content_etc table *{text-align: center;}
	.product:hover{
		cursor: pointer;
		opacity: 0.8;
	}
</style>
</head>
<body>
	<div class="wrap">
		
		<%@ include file="/views/common/header.jsp" %>
		
	    <!-- Section start -->
		<section class="main-content">
			<div class="detail_head"> 
				<span>홈  > <%=r.getCategoryName() %></span>
				<% if(loginUser != null && loginUser.getUserNo() == r.getUserNo()) { %>
				<!-- 
				<button id="updateButton" type="button" class="btn" style="background-color: rgb(231, 76, 60); color: white;">수정하기</button>
				 -->
				<% } %>
			</div>
			 <script>
			    $("#updateButton").click(function(){
			    		location.href = "<%= contextPath %>/updateForm.re?no=<%=r.getRecipeNo()%>";  
			      });
	    	  </script>
			
			<!-- 대표사진 -->
			<div class="thumbnail">
				<img src="<%=contextPath + "/" + r.getThumbnailUrl() %>" alt="대표사진">
			</div>

			<!-- 레시피 요약 -->
			<div class="etc" style="width:50%">
				<div class="recipe_info">
					<div style="margin-right: auto; margin-top: 5px;">
						<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-bookmark" viewBox="0 0 16 16">
							<path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.777.416L8 13.101l-5.223 2.815A.5.5 0 0 1 2 15.5zm2-1a1 1 0 0 0-1 1v12.566l4.723-2.482a.5.5 0 0 1 .554 0L13 14.566V2a1 1 0 0 0-1-1z"/>
						</svg>
					</div>
					<table>
						<tr class="info_top">
							<td>조리시간</td>
							<td>인분수</td>
							<td>난이도</td>
						</tr>
						<tr class="info_mid">
							<td><%=r.getCookingTime() %></td>
							<td><%=r.getServing() %></td>
							<td><%=r.getDifficulty() %></td>
						</tr>
						<tr class="info_btm">
							<td>분</td>
							<td>인분</td>
							<td></td>
						</tr>
					</table>
				</div>
				<div>
					<h1 style="display: inline;"><b><%=r.getRecipeTitle() %></b></h1>
					<span class="recipe_like" style="font-size: 20px;">
						<!-- 내가 찜하지 않은 레시피인 경우 -->
						<% if(userLike == 0) { %>
						<svg id="like" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-heart like" viewBox="0 0 16 16">
							<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
						</svg>
						<% } else { %>
						<!-- 내가 찜한 레시피인 경우 -->
						<svg id="like" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="red" class="bi bi-heart like" viewBox="0 0 16 16">
							<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
						</svg>
						<% } %>
						<span style="font-size:25px">(<%= r.getLikeCount() %>)</span>
					</span>
					
				</div>
				
				<script>
				let getLikeCount = <%= r.getLikeCount() %>;
				$("#like").click(function(){
         			
         			if(<%=loginUser == null%>){
         				alert("로그인후에 사용가능합니다.");
         			}else{
         				const $this = $(this);
                 		if($(this).attr("fill") == "red"){
                 			$.ajax({
                 				url:"<%=contextPath%>/dlike.re",
                 				data:{
                 					rNo:<%=r.getRecipeNo()%>
                 				},
                 				type:"post",
                 				success:function(){
		                 			$this.attr("fill", "black");
		                 			getLikeCount--;
		                 			$this.next().text("(" + getLikeCount + ")");
                 					alert("레시피 찜 목록에서 삭제되었습니다.");
                 				}, error:function(){
                 					console.log("추가실패");
                 				}
                 			})
                 			
                 		}else{
                 			$.ajax({
                 				url:"<%=contextPath%>/like.re",
                 				data:{
                 					rNo:<%=r.getRecipeNo()%>
                 				},
                 				type:"post",
                 				success:function(){
		                 			$this.attr("fill", "red");
		                 			getLikeCount++;
		                 			$this.next().text("(" + getLikeCount + ")");
                 					alert("레시피 찜 목록에 저장되었습니다.");
                 				}, error:function(){
                 					console.log("삭제실패");
                 				}
                 			})
                 		}
         			}
         		})
				</script>
				<div style="height: 90px; margin: 10px 0px;" class="recipe_summary"><%=r.getRecipeIntro()%></div>
				<div>
					<div class="recipe_tag">
						<%for(Recipe in : list) { %>
							<span>#<%=in.getIngredientName() %></span>
						<%} %>
					</div>
				</div>
			</div>

			<!-- 레시피 메인 컨텐츠 영역 -->
			<div class="content">
				<!-- 조리 방법 영역 -->
				<div class="content_detail">
					<div style="font-size: 30px; font-weight: bold; margin-bottom: 20px;">조리방법</div>
					    
					    <%int i = 0; %>
					    <% for(Recipe st : step) { %> 
					    <div class="step_wrap">
					        <div class="recipe_step">Step <%= i + 1 %></div>
					      
					        <%if(st.getStepContent() != null) {%>
					        	<div class="step_content"><%= st.getStepContent() %></div>
					        <% }else{ %>
					       		 <div class="step_content"></div>
					        <% } %>
					        
					        <%if(st.getStepAttachmentUrl() != null) {%>
					       	<div class="step_img"><img src="<%=contextPath + "/" + st.getStepAttachmentUrl() %>" style="width: 100%; height: 100%;" alt="스텝사진"></div>
					        <% } %>
					    </div>
					    <% i++; %>
					    <% } %>
					</div>
 
				<!-- 레시피 부가 내용 하나만 값 채워넣고 FOR문으로 길이만큼 돌리게?  -->
				<div class="content_etc">
					<div class="ingredient_info">
						<div>재료 정보</div>
						<table width="80%" class="table">
							<tr>
								<td>재료명</td>
								<td>수량</td>								
							</tr>
							<%for(Recipe in : list) { %>
					            <tr>
					                 <th><%= in.getIngredientName() %></th>
					                 <td><%= in.getIngredientAmount() + in.getIngredientUnit() %></td>
					            </tr>
					           <% } %>
					       </table>
					    </div>
					

					<!-- 상품 썸네일 start -->
					<div class="product img-thumbnail p-2" style="width:300px; height:350px" onclick="location.href='<%=contextPath%>/detail.pr?no=<%=r.getProductNo()%>'">
						<img class="product-img" src="<%=contextPath + "/" + r.getPath()%>" alt="Card image" style="width:100%; height:60%">
						<div class="product-body">
							<small class="product-category text-secondary d-block mb-3 mt-2">분류><%=r.getCategoryName() %></small>
							<h6 class="product-title"><b class="text"><%=r.getProductName() %></b></h6>
							<h6 class="product-price d-block my-4">

								   <% if(r.getDiscountPrice() == 0) { %> 
		                              <div class="product_price"><%=r.getPrice()%>원</div>                        
		                           <%}else { %>
			                       <!-- 할인하고 있을 때 -->
		                              <div class="product_price"><s style="color:grey; font-size:14px"><%=r.getPrice()%>원</s>&nbsp;<%=r.getPrice()-r.getDiscountPrice()%>원</div>
		                           <% } %>

							</h6>
						</div>
					</div>
					<!-- 상품 썸네일 end -->
				</div>
			</div>
		</section>
	     <!-- Section end -->
	     
	     <%@ include file="/views/common/footer.jsp" %>
	     
	</div>
</body>
</html>
