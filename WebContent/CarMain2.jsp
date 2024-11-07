<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

    <center>
        <table width="1000" height="700">
            <tr>
                <td><jsp:include page="/Top2.jsp"/></td>
            </tr>                                  
            <tr>                                     
                <td height="500"> 
                    <!-- center 값을 EL로 가져오기 -->
                    <c:set var="center" value="${not empty center ? center : '/Center.jsp'}" />
                    <!-- center 값을 동적으로 포함 -->
                    <jsp:include page="${center}" />
                </td>
            </tr>                                       
            <tr>                       
                <td><jsp:include page="/Bottom.jsp"/></td>
            </tr>
        </table>
    </center> 
    
</body>
</html>
