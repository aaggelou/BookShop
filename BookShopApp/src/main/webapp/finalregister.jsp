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
if(request.getParameter("register_user")!=null){
	String firstname= request.getParameter("firstname");
	String lastname= request.getParameter("lastname");
	String telephone= request.getParameter("telephone");
	String birth= request.getParameter("birth");
	String address= request.getParameter("address");
	String city= request.getParameter("city");
	String postalcode= request.getParameter("postalcode");
	String username1= request.getParameter("username1");
	String password1= request.getParameter("password1");
	String email= request.getParameter("email");
	String newsletter = request.getParameter("newsletter");
	String uniqueID = UUID.randomUUID().toString();
	uniqueID = "U"+uniqueID;
	
	if(newsletter != null){
		newsletter="yes";
	}
	else{
		newsletter="no";
	}
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/BookShop/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	formData.add("firstname", firstname);
	formData.add("lastname", lastname);
	formData.add("telephone", telephone);
	formData.add("birth", birth);
	formData.add("address", address);
	formData.add("city", city);
	formData.add("postalcode", postalcode);
	formData.add("username1", username1);
	formData.add("password1", password1);
	formData.add("email", email);
	formData.add("newsletter", newsletter);
	formData.add("uniqueID", uniqueID);
	
	//formData.add("name2", "val2");
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}

String output = myresponse.getEntity(String.class);
if(output.equals("not ok")){%>
	<script>
		
			alert("Το username ή το email υπάρχουν ήδη! Παρακαλώ ξαναπροσπαθήστε!");
			window.location.href = "bookme.jsp";
		
	</script>
<%

}
else{%>
	<script>
	alert("Εγγραφήκατε επιτυχώς στις υπηρεσίες μας!");
		
		window.location.href = "bookme.jsp";
	
</script>
<%}
	
	
	

}

%>	
</body>
</html>