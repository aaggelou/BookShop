<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <% request.setCharacterEncoding("UTF-8"); %>
    <%@ page import="com.sun.jersey.api.client.Client"%>
     <%@ page import="com.sun.jersey.api.client.ClientResponse"%>
      <%@ page import="com.sun.jersey.api.client.WebResource"%>
       <%@ page import="java.util.Random"%>
    	<%@ page import="java.util.ArrayList"%>
    	<%@ page import="org.json.JSONObject"%>
    	<%@ page import="org.json.JSONArray"%>
    	<%@ page import="java.util.UUID"%>
    	<%@page import="javax.ws.rs.core.MultivaluedMap"%>
    	<%@page import="javax.ws.rs.core.MediaType"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

if(request.getParameter("login_user")!=null){
	String username1= request.getParameter("username");
	String password1= request.getParameter("pswd");
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/BookShopIn/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("username1", username1);
	formData.add("password1", password1);
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}

String output = myresponse.getEntity(String.class);

if (output.equals("go_user")){
	/*out.println("ok");*/
	session.setAttribute("user", username1);
	 String redirectURL = "userservices.jsp";

     response.sendRedirect(redirectURL);
}

else if(output.equals("go_temp_user")){
	
	session.setAttribute("tempuser", username1);
	
	
	String redirectURL = "logintempuser.jsp";

    response.sendRedirect(redirectURL);
}

else{%>
<script>

	alert("Λάθος Συνδυασμός Username με Password! Παρακαλω ξαναπροσπαθήστε");
	
	window.location.href = "login.jsp";

</script>
<% }
	
	
}









%>
</body>
</html>