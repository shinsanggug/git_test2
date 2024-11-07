
<%@page import="Vo.FileBoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 

<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	//조회한 글정보 얻기
	FileBoardVo vo = (FileBoardVo)request.getAttribute("vo");
	String name = vo.getB_name();//조회한 글을 작성한 사람
	String email = vo.getB_email();//조회한 글을 작성한 사람의 이메일
	String title = vo.getB_title();//조회한 글제목
	String content = vo.getB_content().replace("/r/n", "<br>");//조회한 글 내용
	
	String sfile = vo.getSfile();//업로드한 실제 파일명(조회후 받아온값)
								 //또는 다운로드할 파일명이 될수 있다.
	int downCount = vo.getDowncount(); //업로드한 파일을 실제 다운로드한 횟수 
		
	String b_idx = (String)request.getAttribute("b_idx");
	String nowPage = (String)request.getAttribute("nowPage");
	String nowBlock = (String)request.getAttribute("nowBlock");
	
	
	String id = (String)session.getAttribute("id");
	if(id == null){//로그인 하지 않았을 경우 , 글 수정, 삭제  , 답변달기 하지 못하도록
%>		
		<script>
			alert("로그인 하셔야 합니다.");
			history.back();
		</script>
<%		
	}
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정 화면</title>
</head>
<body>
	<table width="80%" border="0" cellspacing="0" cellpadding="0">
		<tr height="40">
			<td width="41%" style="text-align: left">&nbsp;&nbsp;&nbsp; 
				<img src="<%=contextPath%>/board/images/board02.gif" width="150" height="30">
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<img src="<%=contextPath%>/board/images/line_870.gif" width="870" height="4">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<table width="95%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="20" colspan="3"></td>
						</tr>
						<tr>
							<td height="327" colspan="3" valign="top">
								<div align="center">
									<table width="95%" height="373" border="0" cellpadding="0" cellspacing="1" class="border1">
										<tr>
											<td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
												<div align="center">작 성 자</div>
											</td>
											<td width="34%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="writer" id="writer" value="<%=name%>" disabled>
											</td>
											<td width="13%" bgcolor="#e4e4e4">
												<div align="center">
													<p class="text2">이메일</p>
												</div></td>
											<td width="40%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="email" name="email" id="email" value="<%=email%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="31" bgcolor="#e4e4e4" class="text2">
												<div align="center">제&nbsp;&nbsp;&nbsp;&nbsp;목</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="title" id="title" value="<%=title%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="31" bgcolor="#e4e4e4" class="text2">
												<div align="center">다운로드</div>
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<%--다운로드할 글번호 경로와  다운로드할 파일명 을 설정한 다운로드 요청 링크 --%>
											    <a href="<%=contextPath%>/FileBoard/Download.do?path=<%=b_idx%>&fileName=<%=sfile%>">
											    	&nbsp;&nbsp;<%=sfile%>
											    </a>
											
											</td>
											<td bgcolor="#f5f5f5">
												<p>다운로드 수:<%=downCount%></p>
											</td>
										</tr>										
										<tr>
											<td height="245" bgcolor="#e4e4e4" class="text2">
												<div align="center">내 &nbsp;&nbsp; 용</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left; vertical-align: top;">
												&nbsp; <textarea rows="20" cols="100" name="content" id="content" disabled><%=content%></textarea>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e4e4e4" class="text2">
												<div align="center">패스워드</div>
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<input type="password" name="pass" id="pass" />
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<p id="pwInput"></p>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td style="width: 48%">
								<div align="right" id="menuButton" >
								<%--수정하기 --%>	
									<input type="image" src="<%=contextPath%>/board/images/update.gif" id="update" style="visibility:hidden" />&nbsp;&nbsp; 
								<%--삭제하기 --%>	
									<input type="image" src="<%=contextPath%>/board/images/delete01.gif" id="delete" onclick="javascript:deletePro('<%=b_idx%>');" style="visibility:hidden" />&nbsp;&nbsp; 
								<%--답변달기 --%>
									<input type="image" src="<%=contextPath%>/board/images/reply.gif" id="reply" />&nbsp;&nbsp; 
								</div>
							</td>
							<td width="10%">
								<div align="center">
									<%--목록 이미지 버튼 --%>
									<input type="image" 
											src="<%=contextPath%>/board/images/list.gif"
											id="list" 
											onclick="location.href='<%=contextPath%>/FileBoard/list.bo?nowBlock=<%=nowBlock%>&nowPage=<%=nowPage%>'" />&nbsp;
								</div>
							</td>
							<td width="42%"></td>
						</tr>
						<tr>
							<td colspan="3" style="height: 19px">&nbsp;</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	
	<%-- 답변 버튼을 클릭했을때 답변을 작성할수 있는 화면 요청! --%>
	<form id="replyForm"  action="<%=contextPath%>/FileBoard/reply.do">
	
		<%--주글 의 글번호 전달 --%>
		<input type="hidden" name="b_idx" 
							 value="<%=b_idx%>" 
							 id="b_idx">
		<%--답변글을 작성하는 사람의 로그인된 아이디를 전달--%>					 
		<input type="hidden" name="id" value="<%=id%>">					 
	
	</form>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		//답변 버튼을 선택해서 가져와 클릭이벤트 등록
		//-> 답변 버튼을 클릭했을때
		$("#reply").on("click", function(){
			
			//<form id="replyForm"></form>한쌍을 선택해서 
			//답변글을 작성하는 화면 요청!
			$("#replyForm").submit();
			
		});
	
	
	
	
		//삭제 <input type="img" onclick>를 클릭하면
	  	//호출되는 함수 
		function deletePro(b_idx){
			
		 	let result	 = window.confirm("정말로 글을 삭제하시겠어요?");
							//[확인][취소] 버튼이 보이는 한번 물어보는 팝업창을 띄워
							//[확인]버튼을 누르면 true반환
							//[취소]버튼을 누르면 false반환
		 	
			if(result==true){//[확인]버튼 누름 //글삭제한다는 의미
				
				$.ajax({
					url:"<%=contextPath%>/FileBoard/deleteBoard.do",
					type:"post",
					data:{  b_idx : b_idx  },
					dataType:"text",
					success:function(data){
									//"삭제성공" 또는 "삭제실패"
						if(data=="삭제성공"){
							alert("삭제성공");
							
							//수정시 입력할수 있는 <input>2개 , <textarea>1개 비활성화
							document.getElementById("email").disabled = true;
					 		document.getElementById("title").disabled = true;
					 		document.getElementById("content").disabled = true;	
					 		
					 		//id속성이 list인 "목록"<input type="image">를 선택해
					 		//click이벤트를 강제로 발생시키게 하여
					 		//글목록조회 재요청을 하여 보여주자 
				 		//$("#list").trigger("click");
					 		
					 		//글삭제된 후  2 초 휴식한 뒤에 글 목록 조회 요청 강제로 하자 
					 		setTimeout(function(){
					 			
					 			//강제로 "목록" <input> 클릭이벤트 발생 
					 			$("#list").trigger("click");
					 			
					 		}, 2000);
					 				
							
						}else{//"삭제실패"
							
							$("#pwInput").text("삭제실패!").css("color","red");
							document.getElementById("email").disabled = false;
					 		document.getElementById("title").disabled = false;
					 		document.getElementById("content").disabled = false;
							
						}
					},
					error:function(){  alert('삭제 요청 비동기 통신 장애');  }
					
				});
		 		
				
		 	}else{//[취소]버튼을 누름
		 		
		 		return false;
		 	}		
				
		}
	
	
	
		//글 수정내용을 모두 입려하고 수정 이미지 버튼을 클릭했을때
		$("#update").click(function(){			
			//수정시 입력한 이메일, 글제목, 글내용
			let email = $("#email").val();
			let title = $("#title").val();
			let content = $("#content").val();
			let idx = $("#b_idx").val(); //글번호 얻기 
			
			$.ajax({
					url:"<%=contextPath%>/FileBoard/updateBoard.do",
					type:"post",
					async:true,
					data:{          
						   email : email,
						   title : title,
						   content : content,
						   idx : idx
					},
					dataType:"text",
					success:function(data){
								    //"수정성공" or "수정실패"
						//수정에 성공하면
						if(data === "수정성공"){
							//<p id="pwInput"></p>요소를 선택해서
							//텍스트노드 자리에 "수정성공" 메세지 녹색으로 보여주자
							$("#pwInput").html("<strong>수정성공</strong>")
										 .css("color","green");
							
							//수정시 입력할수 있는 <input>2개 , <textarea>1개 비활성화
							document.getElementById("email").disabled = true;
					 		document.getElementById("title").disabled = true;
					 		document.getElementById("content").disabled = true;
					 		
						}else{//수정에 실패하면
							//<p id="pwInput"></p>요소를 선택해서
							//텍스트노드 자리에 "수정실패" 메세지 빨간색으로 보여주자
							$("#pwInput").html("<strong>수정 실패</strong>")
										 .css("color","red");
							
							//수정시 입력할수 있는 <input>2개 , <textarea>1개 활성화
							document.getElementById("email").disabled = false;
					 		document.getElementById("title").disabled = false;
					 		document.getElementById("content").disabled = false;
						}
								    
						
					},
					error : function(){
						alert("수정 요청시 비동기 통신 장애");
					}	
			});
		});
	
	
		//글 수정 삭제를 위해 글 비밀번호를 입력하고 포커스가 떠난 이벤트가 발생했을때
		$("#pass").on("focusout", function(){
			
			$.ajax({
				 url:"<%=contextPath%>/FileBoard/password.do",
				 type:"post",
				 async:true,
				 data:{ b_idx: $("#b_idx").val(),
					    pass:$("#pass").val() },
				 dataType:"text",
				 success:function(responseData){
					 				//"비밀번호틀림" 또는 "비밀번호맞음" 
					 	console.log(responseData);
					 				
					 	if(responseData === "비밀번호틀림"){
					 		
					 		$("#pwInput").text("글의 비밀번호가 다릅니다")
					 					 .css("color","red");
					 		
					 		//수정을 위해 입력할수 있는 <input>2개 , <textarea>1개 비활성화(입력할수 없게)
					 		document.getElementById("email").disabled = true;
					 		document.getElementById("title").disabled = true;
					 		document.getElementById("content").disabled = true;
					 		
					 		//수정하기 , 삭제하기  <input type="img"> 버튼 2개 비활성화 (숨김)
					 		$("#update").css("visibility","hidden");
					 		$("#delete").css("visibility","hidden");
					 	
					 							 		
					 	}else{//"비밀번호맞음"
					 		
					 		$("#pwInput").text("글의 비밀번호가 일치합니다.")
		 					 			 .css("color","green");
					 		
					 		//수정을 위해 입력할수 있는 <input>2개 , <textarea>1개 활성화(입력할수 있게)
					 		document.getElementById("email").disabled = false;
					 		document.getElementById("title").disabled = false;
					 		document.getElementById("content").disabled = false;
					 		
					 		//수정하기 , 삭제하기  <input type="img"> 버튼 2개 활성화 (보이게)
					 		$("#update").css("visibility","visible");
					 		$("#delete").css("visibility","visible");
					 	
					 	}			
					 				 				
				 },
				 error:function(){
					 alert("비동기 통신 장애");
				 }
			});
		});
	

	
		
	</script>
	
	
</body>
</html>
















