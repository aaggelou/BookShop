<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%if(null != session.getAttribute("user")){

session.removeAttribute("user");

session.invalidate();

response.sendRedirect("bookme.jsp");
	
	}
else{
	response.sendRedirect("bookme.jsp");
}
	
	%>
</body>
</html>