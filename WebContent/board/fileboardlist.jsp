
<%@page import="Vo.FileBoardVo"%>
<%@page import="Vo.BoardVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath(); 
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<script type="text/javascript">

    // 아래의 검색어를 입력하지 않고  검색버튼을 눌렀을때
    // 검색어 입력하지 않으면  검색어를 입력하세요!  체크 하는 함수 
	function fnSearch(){
    	
    	//입력한 검색어 얻기 
		var word = document.getElementById("word").value;
		
    	//검색어를 입력하지 않았다면?
		if(word == null || word == ""){
			//검색어 입력 메세지창 띄우기 
			alert("검색어를 입력하세요.");
			//검색어를 입력 하는 <input>에 강제 포커스를 주어 검색어를 입력하게 유도함.
			document.getElementById("word").focus();
			
			//<form>의 action속성에 작성된 BoardController서버페이지 요청을 차단 
			return false;
		}
		else{//검색어를 입력했다면
			
			//<form>을 선택해서 가져와 action속성에 작성된 주소를 이용해
			//BoardController로 입력한 검색어에 관한 글목록 조회 요청을 함 
			document.frmSearch.submit();
		}
	}
	
    //조회된 화면에서  글제목 하나를 클릭했을때  글번호를 매개변수로 받아서
    //아래에 작성된 <form>를 이용해 글번호에 해당되는 글 하나의 정보를 조회 요청!
    function fnRead(val){
    	document.frmRead.action="<%=contextPath%>/FileBoard/read.bo";
    	document.frmRead.b_idx.value = val;
    	document.frmRead.submit();//<form> 을 이용해 요청
    }
    
</script>
</head>
<body>
<%
	//페이징 처리를 위한 변수 선언
	
	int totalRecord = 0;//board테이블에 저장된  조회된 총 글의 갯수 저장  *
    int numPerPage = 5; //한 페이지 번호당 조회해서 보여줄 글 목록 개수 저장
    int pagePerBlock = 3; //한 블럭당 묶여질 페이지 번호 갯수 저장
    					  //예)   1   2    3   <-  한블럭으로 묶음 
	
	int totalPage = 0;  // 총 페이지 번호 갯수(총페이지 갯수) *
	int totalBlock = 0; // 총 페이지 번호 갯수에 따른 총블럭 갯수  *
	int nowPage = 0;  //현재 클라이언트 화면에 보여지고 있는 페이지가 위치한 번호 저장
					  //요약 : 아래 쪽 페이지번호 1 2  3  중에서 클릭한  현재 페이지번호 저장
					  //*
					  
					  
					  
    int nowBlock = 0; //클릭한 페이지번호가 속한 블럭위치 번호 저장  *
	
	int beginPerPage = 0;  //각 페이지마다 
						   //조회되어 보여지는 시작 행의  index위치 번호
						   //(가장 위의 조회된 레코드 행의 시작 index위치번호) 저장  
						   //*
	
						   
	//FileBoardController에서 request에 바인딩 한 ArrayList배열을 꺼내옵니다
	//조회된 글목록 정보 얻기 
	ArrayList list = (ArrayList)request.getAttribute("list");
    
	//조회된 글 총 갯수 
    totalRecord = list.size();	
				   
						   
	//게시판 아래쪽 페이지 번호 중 하나를 클릭했다면?
	if( request.getAttribute("nowPage") != null){
		//클릭한 페이지번호를 얻어 저장
		nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	}
    
    //각 페이지에 보여질 시작글번호 구하기
    beginPerPage = nowPage * numPerPage;
    			 //자유게시판 메뉴 클릭 또는 아래 하단의 페이지번호 중 1페이지 번호 클릭시!!!
    			 // 0      *     5       =   0 index
    			 
    			 //아래 하단의 페이지번호 중 2페이지 번호 클릭시!!! 
    			 // 1      *     5       =    5 index
    			 
    			 
    			 
  		//각 페이지마다 
	    //조회되어 보여지는 시작 행의  index위치 번호
	    //(가장 위의 조회된 레코드 행의 시작 index위치번호) 저장  
    
    //글이 몇개 인지에 따른 총 페이지 번호 갯수 구하기
    //총 페이지번호 갯수 = 총 글의 갯수 / 한 페이지당 보여질 글목록 갯수 
    totalPage = (int)Math.ceil((double)totalRecord / numPerPage);
				           			 //33.0         /     5
				           			 //			6.6
				           			 //         7.0
				           			 //         7
    //총 페이지 번호 갯수에 따른 총 블럭 갯수 구하기 
    totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
				           		//	        7.0  /  한 블럭당 묶여질 페이지 번호 갯수  3
				           		//	     2.333333333333333
								//       3.0
								//       3
    //게시판 아래쪽에 클릭한 페이지 번호가 속한 불럭 위치 번호 구하기
    if( request.getAttribute("nowBlock") != null ){
    	
    	//BoardController에서 request에 바인딩된 값을 다시 얻어 저장 
    	nowBlock = Integer.parseInt(request.getAttribute("nowBlock").toString()); 
    }

	
	String id = (String)session.getAttribute("id"); 	
%>


<%--글제목 하나를 클릭했을떄 BoardController 글 하나 조회 요청하기 위한 폼
	위 자바스크립트 function fnRead함수에서 사용하는 <form>
 --%>
<form name="frmRead">
	<input type="hidden" name="b_idx">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="nowBlock" value="<%=nowBlock%>">
</form>

	
<table width="97%" border="0" cellspacing="0" cellpadding="0">
	<tr height="40"> 
		<td width="46%" style="text-align: left"> 
			&nbsp;&nbsp;&nbsp; <img src="<%=contextPath%>/board/images/board02.gif" width="150" height="30">
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
		<td colspan="3" valign="top">
			<div align="center"> 
	    	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	        	<tr> 
	        		<td colspan="4" style="height: 19px">&nbsp;</td> 
	        	</tr>
	        	<tr>
	        		<td colspan="4" style="height: 19px">
	        			<img src="<%=contextPath%>/board/images/ink.gif" width="875" height="100">
	        		</td>
	        	</tr>
	        	<tr> 
	        		<td colspan="4">
						<table border="0" width="100%" cellpadding="2" cellspacing="0">
							<tr align="center" bgcolor="#D0D0D0" height="120%">
								<td align="left">번호</td>
								<td align="left">제목</td>
								<td align="left">이름</td>
								<td align="left">날짜</td>
								<td align="left">조회수</td>
								<td align="left">다운로드 횟수</td>
							</tr>	
					<%
						//Fileboard테이블에서 조회된 게시글이 없다면?
						if(list.isEmpty()){
					%>		
							<tr align="center">
								<td colspan="5">등록된 글이 없습니다.</td>
							</tr>
					<%		
						}else{//Fileboard테이블에서 조회된 게시글이 있다면?
							
							for(int i=beginPerPage;  i<(beginPerPage+numPerPage);  i++){
							  
								out.println(i);  //1페이지 번호 또는 자유게시판 메뉴 클릭시   0,  1 , 2,  3, 4
								                 //2페이지 번호 클릭시 5, 6, 7, 8, 9
								                 
								out.println(beginPerPage+numPerPage);
								out.println("-------------------------<br>");
								
								if(i == totalRecord){
									break;
								}
								
								FileBoardVo vo = (FileBoardVo)list.get(i);
					    //		int level = vo.getB_level(); 
								//모든 글들의 들여쓰기 정도값
								//0(주글)또는1(주글에 대한 답변글).....
					%>
							<tr>
								<td align="left"><%=vo.getB_idx()%></td>
								<td>
						<%-- 			
									<%for(int j=0; j<level*3; j++){%>
										     &nbsp;
									<%}%>	 
						--%>	
								<%
									int width = 0; //답변글에 대한 이미지level.gif의 들여 쓰기 너비width값 
									
									if(vo.getB_level() > 0){//답변글들			
										width = vo.getB_level() * 10;
								%>
										<img src="<%=contextPath%>/board/images/level.gif" 
											 width="<%=width%>" height="15">
											 
										<img src="<%=contextPath%>/board/images/re.gif">
								<%}%>	
									
									<a href="javascript:fnRead('<%=vo.getB_idx()%>')">
										<%=vo.getB_title()%>
									</a>
								</td>
								
								
								
								<td align="left"><%=vo.getB_name()%></td>
								<td align="left"><%=vo.getB_date()%></td>
								<td align="left"><%=vo.getB_cnt()%></td>
								<%--다운로드 횟수 --%>
								<td align="left"><%=vo.getDowncount()%></td>
							</tr>												
					<%			
							}
								
						}
					
					%>		
															
						</table>
	        		</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
				<tr>
					<form action="<%=contextPath%>/FileBoard/searchlist.bo" 
							method="post" 
							name="frmSearch" onsubmit="fnSearch(); return false;">
		            	<td colspan="2">
		            		<div align="right"> 
			            		<select name="key">
			              			<option value="titleContent">제목 + 내용</option>
			              			<option value="name">작성자</option>
			              		</select>
			              	</div>
		              	</td>
			            <td width="26%">
			            	<div align="center"> &nbsp;
			            		<input type="text" name="word" id="word"/>
			            		<input type="submit" value="검색"/>
			            	</div>
			            </td>
		            </form>
		            
		            <%-- 새 글쓰기 버튼 이미지 --%>
		            <td width="38%" style="text-align:left">
		            
		            <%
		            	//로그인을 하면 새글쓰기 <inpu>이 보이게 설정
		            	if(id != null){
		            %>			
		            	<input type="image"  
		            		   id="newContent"
		            		   src="<%=contextPath%>/board/images/write.gif"
		            		   onclick="location.href='<%=contextPath%>/FileBoard/write.bo?nowPage=<%=nowPage%>&nowBlock=<%=nowBlock%>'"
		            	/>
		            		
		            <%	} %>
		            
		            </td>
	           
	       		<tr>
	       			<td colspan="4">&nbsp;</td>
	       		</tr>
			</table>
			</div>
	 	</td>
	</tr>
	<tr align="center"> 
		<td colspan="3" align="center">Go To Page		
		<%
			if(totalRecord  != 0){//DB의 board테이블에서 조회된 글이 있다면?
				
				if(nowBlock > 0){
		%>			
				    <a href="<%=contextPath%>/FileBoard/list.bo?nowBlock=<%=nowBlock-1%>&nowPage=<%=((nowBlock-1)*pagePerBlock)%>">
					◀ 이전 <%=pagePerBlock %>개
					</a>
		<%	
				}
			
			
				//페이지 번호를 반복해서 3개씩 보여 주자 
				for(int i=0;   i<pagePerBlock;    i++){
		%>			
				&nbsp;&nbsp;
				<a href="<%=contextPath%>/FileBoard/list.bo?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock * pagePerBlock)+i%>">
					<%=(nowBlock * pagePerBlock)+i+1%>
					<%
						if((nowBlock * pagePerBlock)+i+1 == totalPage){
							break;
						}
					%>
				</a>
				&nbsp;&nbsp;
		<%		
				}//for 닫기
				
				
				if(totalBlock > nowBlock + 1){
		%>			
				 <a href="<%=contextPath%>/FileBoard/list.bo?nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>">
					▶ 다음 <%=pagePerBlock%>개 	
				 </a>
		<%			
				}
				
				
				
			}//바깥쪽 if닫기 
		%>
		
		
		
		
		
		</td> 
	</tr>
</table>
</body>
</html>












