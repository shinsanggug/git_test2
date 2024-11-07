<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	//컨텍스트 주소 얻기
	String contextPath = request.getContextPath();
%>


	<!-- 메인로고 이미지 -->
	<a href="#"><img src="<%=contextPath%>/img/RENT.jpg" width="300" height="80"></a>
	
	<!-- 메뉴만들기 -->
	<table width="1000" background="<%=contextPath%>/img/aa.jpg" height="5">
		<tr>
			<!-- 예약하기 메뉴 -->
			<td align="center"  bgcolor="red">
				<a href="<%=contextPath%>/Car/bb?center=CarReservation.jsp">
					<img src="<%=contextPath%>/img/bb.jpg" border="0"/>
				</a>
			</td>
			<!-- 예약확인 메뉴 -->
			<td align="center"  bgcolor="red">
				<a href="<%=contextPath%>/Car/cc?center=CarReserveConfirm.jsp">
					<img src="<%=contextPath%>/img/cc.jpg" border="0"/>
				</a>
			</td>
			<!-- 자유게시판 메뉴 -->
			<td align="center"  bgcolor="red">
				<a href="#">
					<img src="<%=contextPath%>/img/dd.jpg" border="0"/>
				</a>
			</td>			
			<!-- 이벤트 메뉴 -->
			<td align="center"  bgcolor="red">
				<a href="#">
					<img src="<%=contextPath%>/img/even.jpg" border="0"/>
				</a>
			</td>	
			<!-- 공지사항 게시판 메뉴 -->
			<td align="center"  bgcolor="red">
				<a href="#">
					<img src="<%=contextPath%>/img/ee.jpg" border="0"/>
				</a>
			</td>			
		</tr>
	
	</table>
	
	
	
</body>
</html>











