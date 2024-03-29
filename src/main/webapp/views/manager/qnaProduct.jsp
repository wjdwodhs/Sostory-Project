<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.sos.product.model.vo.Qna, java.util.List, com.sos.common.model.vo.PageInfo"%>

 <%
 	List<Qna> list = (List<Qna>)request.getAttribute("list");
 	List<Integer> aNoList = (List<Integer>)request.getAttribute("aNoList");
 	int count = (int)request.getAttribute("listCount");
 	
 	PageInfo pi = (PageInfo)request.getAttribute("pi");
 %>   
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품문의</title>
<style>
/*상품문의 스타일*/
     .section_right{
        width: 100%;
        margin: 20px;
        margin-top: 30px;
     }
     .section_right label{
        font-weight: bolder;
        font-size: 17px;   
     }
     .section_right>div{
        display: flex;
        
     }
     .pro_search{
        display: flex;
        margin-left: 10px;
        margin-top: 15px;
     }

     .pro_search button{
        width: 80px;
        background-color: #c20000; /* 배경색 설정 */
        color: #ffffff; /* 텍스트 색상 설정 */
        border: none; /* 테두리 제거 */
        font-weight: bold;
        height: 100%;
     }

    table{
        margin-top: 20px;
        width: 80%;
        text-align: center;
        border: 1px solid #dddddd;
     }
     td:hover{
        cursor: pointer;
     }
     
     .table_title th{
        background-color: #dddddd;;
        font-weight: bold; /* 헤더 글씨체를 굵게 설정 */
        padding: 8px; /* 셀 안의 여백 설정 */
     }

     .pro_name{
        display: flex;
        align-items: center; 
        justify-content: center;  
        background-color: #dddddd; 
        width: 100px; 
        font-weight: bold;
        border-bottom-left-radius: 10px;
        border-top-left-radius: 10px;
        border: 1px solid rgb(148, 146, 146);
        border: none; /* 테두리 제거 */
        border-radius: 5px; /* 모서리를 둥글게 만듦 */
     }

     

     .select_div{
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
        align-items: center;
        
     }
     .select_div select{
        width: 100px;
     }
     .select_delete{
        margin-right: 50px;
        height: 40px;
        width: 100px;
        background-color: #c20000; /* 배경색 설정 */
        color: #ffffff; /* 텍스트 색상 설정 */
        border: none; /* 테두리 제거 */
        border-radius: 5px; /* 모서리를 둥글게 만듦 */
        font-weight: bold;
     }
     .pagination{
        display: flex; justify-content: center; margin-top: 10px;
     }
     .table_d{display: flex; flex-direction: column;}
     .section_title b{font-size: 20px;}
</style>
</head>
<body>
<div class="wrap">

        <%@ include file="/views/common/header.jsp" %>
        
        <% if(loginUser == null){ // alert 시킬 알람문구가 존재할 경우 %>
		  <script>
		     alert('로그인을 먼저 진행해주세요'); // 문자열 취급시 따옴표로 감싸야됨
		     location.href="<%=contextPath%>"
		  </script>
		<% } %>

<!-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
        
        <!-- Section start -->
        <section class="main-content">
            <div class="section_1">
            
                <%@ include file="/views/common/managerMenu.jsp" %>
        <!-- 사이드메뉴바 클릭시 바뀌는 화면-->
        <div class="section_right">
            <div class="section_title" style="border-bottom: 2px solid gray">
                <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-house-gear-fill" viewBox="0 0 16 16">
                    <path d="M7.293 1.5a1 1 0 0 1 1.414 0L11 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l2.354 2.353a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708z"/>
                    <path d="M11.07 9.047a1.5 1.5 0 0 0-1.742.26l-.02.021a1.5 1.5 0 0 0-.261 1.742 1.5 1.5 0 0 0 0 2.86 1.5 1.5 0 0 0-.12 1.07H3.5A1.5 1.5 0 0 1 2 13.5V9.293l6-6 4.724 4.724a1.5 1.5 0 0 0-1.654 1.03"/>
                    <path d="m13.158 9.608-.043-.148c-.181-.613-1.049-.613-1.23 0l-.043.148a.64.64 0 0 1-.921.382l-.136-.074c-.561-.306-1.175.308-.87.869l.075.136a.64.64 0 0 1-.382.92l-.148.045c-.613.18-.613 1.048 0 1.229l.148.043a.64.64 0 0 1 .382.921l-.074.136c-.306.561.308 1.175.869.87l.136-.075a.64.64 0 0 1 .92.382l.045.149c.18.612 1.048.612 1.229 0l.043-.15a.64.64 0 0 1 .921-.38l.136.074c.561.305 1.175-.309.87-.87l-.075-.136a.64.64 0 0 1 .382-.92l.149-.044c.612-.181.612-1.049 0-1.23l-.15-.043a.64.64 0 0 1-.38-.921l.074-.136c.305-.561-.309-1.175-.87-.87l-.136.075a.64.64 0 0 1-.92-.382ZM12.5 14a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3"/>
                </svg>문의관리><b>상품문의</b>
            </div>
            <div class="pro_search">
                <div class="pro_name">상품명</div>
                <div><input type="text" id="searchBox" ></div>
                <div><button onclick="searchPid(1);">조회</button></div>
            </div>
            
            <div class="select_div">
                <div>
                    <select name="" id="categorySort" onchange="sortCategory(1);" style="display:none;">
                        <option value="all">전체</option>
                        <option value="jang">장류</option>
                        <option value="dress">드레싱</option>
                        <option value="etc">기타</option>
                    </select>
                </div>
                
                
                <script>
                
                function searchPid(page){
                var search = $("#searchBox").val();
                	$.ajax({
						url:"<%=contextPath%>/search.ma",
						data:{
							search:search,
							page:page
							
						},
						type:"post",
						success:function(hm){
							let value="";
							let pa ="";
							let unprocessed ="미처리";
							
								
								for(let i=0; i<hm.list.length; i++){
									
									if(hm.list[i].answerType== unprocessed){
										
									value+="<tr>" +
									"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
            						"<td>"+hm.list[i].answerNo+"</td>"+
            						"<td>"+hm.list[i].answerDate+"</td>"+
            						"<td>"+hm.list[i].userNo+"</td>"+
            						"<td>"+hm.list[i].productNo+"</td>"+
            						"<td onclick='listMe(" + hm.list[i].answerNo + ")'>"+hm.list[i].answerTitle+"</td>"+
            						"<td style='color: red;'>"+hm.list[i].answerType+"</td>"+
            						"</tr>";
									}else{
										value+="<tr onclick='listMe(" + hm.list[i].answerNo + ")'>" +
										"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
                						"<td>"+hm.list[i].answerNo+"</td>"+
                						"<td>"+hm.list[i].answerDate+"</td>"+
                						"<td>"+hm.list[i].userNo+"</td>"+
                						"<td>"+hm.list[i].productNo+"</td>"+
                						"<td onclick='listMe(" + hm.list[i].answerNo + ")'>"+hm.list[i].answerTitle+"</td>"+
                						"<td>"+hm.list[i].answerType+"</td>"+
                						"</tr>";
										
									}
										
            						
									
            						
								}
								
								$("#boardList tbody").html("");
								$("#boardList tbody").html(value);
								
								
								
	                              if(1 == hm.pi.currentPage) {
	                                 pa += "<li class='page-item disabled'><a class='page-link'>Previous</a></li>";
	                              }else {
	                                 pa += "<li class='page-item'><a class='page-link' onclick='searchPid(" + (page- 1) + ")'>Previous</a></li>";
	                              }
	                                  
	                                 for(let p=hm.pi.startPage; p<=hm.pi.endPage; p++) {
	                                     if (p == hm.pi.currentPage){
	                                    	 pa += '<li class="page-item active"><a class="page-link">' + p + '</a></li>';
	                                     } else {
	                                    	 pa += '<li class="page-item"><a class="page-link" onclick="searchPid(' + p + ')">' + p + '</a></li>';
	                                     }
	                                  }
	                              
	                              if(hm.pi.endPage != hm.pi.maxPage){         
	                            	  pa += '<li class="page-item"><a class="page-link" onclick="searchPid(' + (page + 1) + ')>Next</a></li>'
	                                  }else{
	                                	  pa += '<li class="page-item disabled"><a class="page-link">Next</a></li>'
	                                  }
	                              	$("#pagingg").html("");
									$("#pagingg").html(pa);
								
								
							
							
									let count = "";
		           	            	if(result.select == "all"){
		           	            		count +=  '총 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'
		           	            	}else if(result.select == "unprocessed"){
		           	            		count +=  '미처리 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'
		           	            		console.log(count);
		           	            	}else if(result.select == "processed"){
		           	            		count +=  '처리 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'              	            		
		           	            	}
		           	            	$("#qnaCount").html("");
		           	            	$("#qnaCount").html(count);
							
           	            	
							
						}
					})
                	
                	
                	
                }
                
                
                function sortCategory(page){
               	
		                var category
               			category = $("#categorySort").val();
               			console.log(category);
               			
               			$.ajax({
							url:"<%=contextPath%>/sort.ma",
							data:{
								category:category,
								page:page
								
							},
							type:"post",
							success:function(hm){
								let value="";
								let pa ="";
								let unprocessed ="미처리";
								
									
									for(let i=0; i<hm.list.length; i++){
										
										if(hm.list[i].answerType== unprocessed){
											
										value+="<tr>" +
										"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
                						"<td>"+hm.list[i].answerNo+"</td>"+
                						"<td>"+hm.list[i].answerDate+"</td>"+
                						"<td>"+hm.list[i].userNo+"</td>"+
                						"<td>"+hm.list[i].productNo+"</td>"+
                						"<td>"+hm.list[i].answerTitle+"</td>"+
                						"<td style='color: red;'>"+hm.list[i].answerType+"</td>"+
                						"</tr>";
										}else{
											value+="<tr>" +
											"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
	                						"<td>"+hm.list[i].answerNo+"</td>"+
	                						"<td>"+hm.list[i].answerDate+"</td>"+
	                						"<td>"+hm.list[i].userNo+"</td>"+
	                						"<td>"+hm.list[i].productNo+"</td>"+
	                						"<td>"+hm.list[i].answerTitle+"</td>"+
	                						"<td>"+hm.list[i].answerType+"</td>"+
	                						"</tr>";
											
										}
											
                						
										
                						
									}
									
									$("#boardList tbody").html("");
									$("#boardList tbody").html(value);
									
									
									
		                              if(1 == hm.pi.currentPage) {
		                                 pa += "<li class='page-item disabled'><a class='page-link'>Previous</a></li>";
		                              }else {
		                                 pa += "<li class='page-item'><a class='page-link' onclick='sortCategory(" + (page- 1) + ")'>Previous</a></li>";
		                              }
		                                  
		                                 for(let p=hm.pi.startPage; p<=hm.pi.endPage; p++) {
		                                     if (p == hm.pi.currentPage){
		                                    	 pa += '<li class="page-item active"><a class="page-link">' + p + '</a></li>';
		                                     } else {
		                                    	 pa += '<li class="page-item"><a class="page-link" onclick="sortCategory(' + p + ')">' + p + '</a></li>';
		                                     }
		                                  }
		                              
		                              if(hm.pi.endPage != hm.pi.maxPage){         
		                            	  pa += '<li class="page-item"><a class="page-link" onclick="sortCategory(' + (page + 1) + ')>Next</a></li>'
		                                  }else{
		                                	  pa += '<li class="page-item disabled"><a class="page-link">Next</a></li>'
		                                  }
		                              	$("#pagingg").html("");
										$("#pagingg").html(pa);
									
									
								
								
								let count = "";
               	            	if(hm.category == "all"){
               	            		count +=  '총 문의 수 : <label style="color: red;">' + hm.pi.listCount + '</label>'
               	            	}else if(hm.category == "jang"){
               	            		count +=  '총 문의 수 : <label style="color: red;">' + hm.pi.listCount + '</label>'              	            		
               	            	}else if(hm.category == "dress"){
               	            		count +=  '총 문의 수 : <label style="color: red;">' + hm.pi.listCount + '</label>'              	            		
               	            	}else if(hm.category == "etc"){
               	            		count +=  '총 문의 수 : <label style="color: red;">' + hm.pi.listCount + '</label>'              	            		
               	            	}
								
               	            	$("#qnaCount").html("");
               	            	$("#qnaCount").html(count);
								
							}
						})
						
					
						
                }
                
            	
            	  	$(function(){
            	  		
            	  	
                	$(".select_delete").click(function(){
                		const $deleteQ = $("input[name=typArr]:checked");
    	            	if($deleteQ.length != 0){
	                		if(confirm("정말 삭제하시겠습니까?")){
	                			
	                		$(".typArr:checked").each(function(){
	                			if($(this).is(":checked")){
	   	            			 location.href="<%=contextPath%>/delpr.ma?AnswerNo=" + $(this).parent().next().text();
	               				
	               				}
	    			  				
	                		})
	                      	}else{
	                    	  // confirm에서 아니요 클릭시 아무변화없는 현재페이지
	                   		}
    	            	} else {
    	            		alert("삭제할 상품문의를 선택해주세요.");
    	            	}
                	})
            	  })
            	  
                </script>
                
                <div class="option_2">
                    <button class="select_delete" >선택삭제</button>
                    <select name="selectp" id="selectp"  onchange="sortProc(1);">
                        <option value="all">전체</option>
                        <option value="processed">처리</option>
                        <option value="unprocessed">미처리</option>
                    </select>
                </div>
                
                <script>
                
                function sortProc(page){
                	
                	$.ajax({
           				url:"<%=contextPath%>/sortp.ma",
           				data:{
           					select:$("#selectp").val(),
           					page:page
           					
           				},
           				type:"post",
           				success:function(result){
           					let unprocessed ="미처리";
           					let list = "";
           					
           					for(let i=0; i<result.list.length; i++){
								
								if(result.list[i].answerType== unprocessed){
									
								list+="<tr>" +
								"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
        						"<td>"+result.list[i].answerNo+"</td>"+
        						"<td>"+result.list[i].answerDate+"</td>"+
        						"<td>"+result.list[i].userNo+"</td>"+
        						"<td>"+result.list[i].productNo+"</td>"+
        						"<td onclick='listMe(" + result.list[i].answerNo + ")'>"+result.list[i].answerTitle+"</td>"+
        						"<td style='color: red;'>"+result.list[i].answerType+"</td>"+
        						"</tr>";
								}else{
									list+="<tr>" +
									"<td><input type='checkbox' name='typArr' class='typArr'></td>"+
            						"<td>"+result.list[i].answerNo+"</td>"+
            						"<td>"+result.list[i].answerDate+"</td>"+
            						"<td>"+result.list[i].userNo+"</td>"+
            						"<td>"+result.list[i].productNo+"</td>"+
            						"<td onclick='listMe(" + result.list[i].answerNo + ")'>"+result.list[i].answerTitle+"</td>"+
            						"<td>"+result.list[i].answerType+"</td>"+
            						"</tr>";
									
								}
									
        						
								
        						
							}
           					
           					$("#boardList tbody").html("");
							$("#boardList tbody").html(list);
           					
           					let paging = "";
           				 	
           					if(1 == result.pi.currentPage) {
           						paging += "<li class='page-item disabled'><a class='page-link'>Previous</a></li>";
           	                }else {
           	                	paging += "<li class='page-item'><a class='page-link' onclick='sortProc(" + (page- 1) + ")'>Previous</a></li>";
           	                }
           	                
           	               for(let p=result.pi.startPage; p<=result.pi.endPage; p++) {
           		                if (p == result.pi.currentPage){
           		                	paging += '<li class="page-item active"><a class="page-link">' + p + '</a></li>';
           		                } else {
           		                	paging += '<li class="page-item"><a class="page-link" onclick="sortProc(' + p + ')">' + p + '</a></li>';
           		                }
           	                }
           					
           					if(result.pi.endPage != result.pi.maxPage){			
           						paging += '<li class="page-item"><a class="page-link" onclick="sortProc(' + (page + 1) + ')>Next</a></li>'
           	                }else{
           	                	paging += '<li class="page-item disabled"><a class="page-link">Next</a></li>'
           	                }
           					
           	            	$("#pagingg").html("");
           	            	$("#pagingg").html(paging);
           	            	
           	            	
           	            	let count = "";
           	            	if(result.select == "all"){
           	            		count +=  '총 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'
           	            	}else if(result.select == "unprocessed"){
           	            		count +=  '미처리 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'
           	            		console.log(count);
           	            	}else if(result.select == "processed"){
           	            		count +=  '처리 문의 수 : <label style="color: red;">' + result.pi.listCount + '</label>'              	            		
           	            	}
           	            	$("#qnaCount").html("");
           	            	$("#qnaCount").html(count);
           	            	
           				}
           				
           			})
                
                }
                </script>
                
                
                
                
                
                
                
            </div>
            <div class="table_d">
                <div>
                    <table class="table table-hover" id="boardList">
                        <thead>
                            <tr class="table_title">
                                <th><input type="checkbox" id="cbx_chkAll"></th>
                                <th>번호</th>
                                <th>작성일자</th>
                                <th>아이디</th>
                                <th>상품명</th>
                                <th>문의내역</th>
                                <th>처리결과</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<%if(list.isEmpty()){ %>
                        	  <td colspan="6" style="text-align: center;">존재하는 게시글이 없습니다.</td>
                        	<%}else{ %>
                        
                        	<% for(Qna q : list) { %>
                            <tr class="table_title productQna" >
                                <td><input type="checkbox" name="typArr" class="typArr" value="<%=q.getAnswerNo()%>"></td>
                                <td><%=q.getAnswerNo() %></td>
                                <td><%=q.getAnswerDate() %></td>
                                <td><%=q.getUserNo() %></td>
                                <td><%=q.getProductNo() %></td>
                                <td onclick="listMe(<%=q.getAnswerNo()%>);"><%=q.getAnswerTitle() %></td>
                                <td><%=q.getAnswerType() %></td>
                            </tr>
                            <%} %>
                          <%} %>
                        </tbody>
                    </table>     
                </div>
               
               <script>
               
		       
		            	<%--     $(document).on("click", "#boardList>tbody>tr", function() {
		            	        location.href = "<%=contextPath%>/productReply.ma?no=" + $(this).find('input[type="checkbox"]').val();
		            	    }); --%>
		         

		               function listMe(no){
		            	   location.href = "<%=contextPath%>/productReply.ma?no=" + no;
		               }
		            	
                    
             </script>
               
               
               
                
                
                
             <div id="qnaCount" style="font-weight: bold;">
                        총 문의 수 : <label style="color: red;"><%=count %></label>
            </div>                  
            </div>
             <!-- 페이징 바 영역 -->
             <div class="center">
             
                    <ul class="pagination justify-content center" id="pagingg">
                    	<%if(pi.getCurrentPage()==1){ %>
                        <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                        <%}else{ %>
                        <li class="page-item"><a class="page-link" href="<%= contextPath%>/qnaProduct.ma?page=<%=pi.getCurrentPage()-1 %>">Previous</a></li>
                        <%} %>
                        <%for(int p=pi.getStartPage(); p<=pi.getEndPage(); p++){ %>
	                        <%if(p== pi.getCurrentPage()) {%>
	                        <li class="page-item active"><a class="page-link" href="#"><%=p %></a></li>
	                        <%}else{ %>
	                        <li class="page-item"><a class="page-link" href="<%= contextPath%>/qnaProduct.ma?page=<%=p %>"><%=p %></a></li>
                        
                        <%} %>
                       <%} %>
                        
                        <% if(pi.getCurrentPage()==pi.getMaxPage()){ %>
                        <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        <%}else{ %>
                        <li class="page-item"><a class="page-link" href="<%= contextPath%>/qnaProduct.ma?page=<%=pi.getCurrentPage()+1 %>">Next</a></li>
                        <%} %>
                      </ul>
             </div>
             
             
             
             
             
             
            <script>

                $(function(){
                       // 전체 선택 / 해제
    
                   $("#cbx_chkAll").click(function() {
					    var isChecked = $(this).prop("checked");
					    $(".typArr").prop('checked', isChecked);
					});

                   
                    
                	$(".table_title>td").each(function(){
                       if($(this).text() == "미처리"){
                           $(this).css("color", "red");
                       }else{
                           $(this).css("color", "black");
                       }
                   })
                
                
                })
                
              </script>
              
              

        </div>

            
        </section>
        <!-- Section end -->

<!-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -->

		<%@ include file="/views/common/footer.jsp" %>
        
    </div>
</body>
</html>