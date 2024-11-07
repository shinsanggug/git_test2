
<%@page import="Vo.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	//받는 이유
	//list.jsp화면에서  1  2  3 페이지 번호중  만약 2페이지 번호를 클릭하면
	//nowBlock의 값은 0   nowPage의 값은 1 일것이다
	//조회된 화면에서 ~~  글쓰기 버튼을 클릭하면 글을 작성하는 화면 이 나올것이다
	//글을 작성하는 현재 wirte.jsp 디자인에서 [목록] <a>를 클릭했을때
	//글을 작성하는 현재 write.jsp로 오기전 이전 목록을 조회해서 바로 보여주기 위해
	//받았다~~  [목록] <a>태그의 href속성의 주소에 nowPage와 nowBlock 값 추가 시키자 
	String nowPage = (String)request.getAttribute("nowPage");
	String nowBlock = (String)request.getAttribute("nowBlock");
	
	//조회한 글작성자의 정보 
	MemberVo membervo = (MemberVo)request.getAttribute("membervo");
	String email = membervo.getEmail();
	String name = membervo.getName();
	String id = membervo.getId();
	
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<form action="<%=contextPath%>/FileBoard/writePro.bo"
      method="post" enctype="multipart/form-data">

<table width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr height="40"> 
    <td width="41%" style="text-align: left"> &nbsp;&nbsp;&nbsp; 
    	<img src="<%=contextPath%>/board/images/board02.gif" width="150" height="30">
    </td>
    <td width="57%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"><img src="<%=contextPath%>/board/images/line_870.gif" width="870" height="4"></div></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"> 
        <table width="95%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="20" colspan="3"></td>
          </tr>
          <tr> 
            <td colspan="3" valign="top">
            <div align="center"> 
                <table width="100%" height="373" border="0" cellpadding="0" cellspacing="1" class="border1">
                  <tr> 
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">작 성 자</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer" size="20" class="text2" value="<%=name%>" readonly />
                    </td>
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">아 이 디</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer_id" 
                    	size="20" class="text2" value="<%=id%>" readonly/>
                    </td>
                   </tr>
                   <tr>
                    <td width="13%" bgcolor="#e4e4e4">
                    	<div align="center"> 
                        	<p class="text2">메일주소</p>
                      	</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                        <input type="text" name="email" size="40" class="text2" value="<%=email%>" readonly/>
                    </td>
                  </tr>             
                  <tr> 
                    <td height="31" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">제&nbsp;&nbsp;&nbsp;목</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="title" size="70"/>
                    </td>
                  </tr>
                  <tr> 
                    <td height="31" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">첨부파일 선택</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="file" name="fileName" size="70"/>
                    </td>
                  </tr>                  
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">내 &nbsp;&nbsp; 용</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<textarea name="content" rows="15" cols="100"></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">패스워드</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="password" name="pass"/>
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
            <td width="48%">
            <!-- 등록 버튼 -->
            <div align="right">
            	<button type="submit">글 등록</button>
            </div>
            </td>
            <td width="10%">
            <!-- 목록보기 -->
            <div align="center">
            	<a href="#" id="list">
            		<img src="<%=contextPath%>/board/images/list.gif" border="0"/>
            	</a>
            </div>
            </td>
            <td width="42%" id="resultInsert"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
</form>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<script type="text/javascript">

		//목록 링크<a>를 선택해서 클릭 이벤트 등록
		$("#list").click(function(event){
			//<a href="#" id="list">목록</a>
			event.preventDefault(); //a태그  href속성의 주소요청 기본이벤트 차단
			
			//board테이블에 저장된 모든 글 조회 요청!
			location.href="<%=contextPath%>/FileBoard/list.bo?nowPage=<%=nowPage%>&nowBlock=<%=nowBlock%>";
		});
	</script>
</body>
</html>







