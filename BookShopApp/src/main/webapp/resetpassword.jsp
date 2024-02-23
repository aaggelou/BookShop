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

if(request.getParameter("reset_user")!=null){
	String email= request.getParameter("email");
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/BookShopReset/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("email", email);
	;
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}
	
String output = myresponse.getEntity(String.class);

if (output.equals("reset_user")){%>
	/*out.println("ok");*/
	
	
	<script>

	alert("To reset πραγματοποιήθηκε!");
	
	window.location.href = "login.jsp";

</script>
	
<%}	
else if(output.equals("problem")){%>
	
	<script>

	alert("Προέκυψε τεχνικό πρόβλημα. Παρακαλούμε προσπαθήστε ξανά!");
	
	window.location.href = "login.jsp";

</script>
	
<%}
else{%>
<script>

	alert("Το Email που δώσατε δεν υπάρχει. Παρακαλούμε προσπαθήστε ξανά!");
	
	window.location.href = "login.jsp";

</script>
<% }
	
	
	
}
if(null != session.getAttribute("tempuser")){
if(request.getParameter("nregister_user")!=null){
	String username= request.getParameter("username1");
	String password= request.getParameter("password1");
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/BookShopNewPass/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("username1", username);
	formData.add("password1", password);
	;
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).put(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}
	
String output = myresponse.getEntity(String.class);

if (output.equals("password ok")){

	session.removeAttribute("tempuser");

	session.invalidate();
	/*out.println("ok");*/

%>


	<script>

	alert("To κωδικός άλλαξε");
	
	window.location.href = "login.jsp";

</script>
	
<%}	

else if(output.equals("go_active_use")){
	session.removeAttribute("tempuser");

	session.invalidate();
	/*out.println("ok");*/
	
	%>
	
	<script>

	alert("Η αλλαγή του κωδικού έχει ήδη πραγματοποιηθεί");
	
	window.location.href = "login.jsp";

</script>
<%}

else{
	session.removeAttribute("tempuser");

	session.invalidate();


%>
	<script>

	alert("Δεν βρέθηκε ο χρήστης προκειμένου να ολοκληρωθεί η αλλαγή του κωδικού");
	
	window.location.href = "login.jsp";

</script>
<%}
	
	
}

}
else{%>

<script>

	alert("Διεκόπη η πρόσβαση στην υπηρεσία. Παρακαλούμε ξαναπροσπαθήστε!");
	
	window.location.href = "login.jsp";

</script>
	
<%}


%>
</body>
</html>