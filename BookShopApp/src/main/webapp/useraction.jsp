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
<%if(request.getParameter("wishlist")!=null){
	String username1= request.getParameter("username1");
	String productId= request.getParameter("product");
	String wishlistId = UUID.randomUUID().toString();
	wishlistId = "W"+wishlistId;
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/WishList/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("productId", productId);
	formData.add("username1", username1);
	formData.add("wishlistId", wishlistId);
	
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}

String output = myresponse.getEntity(String.class);


if(output.equals("user_ok")){%>
<script>

	alert("Το προϊόν προστέθηκε στην WishList");
	var url = '<%= response.encodeURL("productsdetails.jsp?productId="+ productId) %>';
	window.location.href = url;

</script>
<% }



else if(output.equals("the_product_exists")){%>
<script>

	alert("Το προϊόν έχει ήδη προστεθεί στην WishList");
	
	var url = '<%= response.encodeURL("productsdetails.jsp?productId="+ productId) %>';
	window.location.href = url;

</script>
<% }

else{%>
	
	<script>

	alert("Ο χρήστης δεν βρέθηκε! Παρακαλώ ξαναπροσπαθήστε!");
	
	var url = '<%= response.encodeURL("productsdetails.jsp?productId="+ productId) %>';
	window.location.href = url;

</script>
	
<%}
	
	
	
	
}

else if(request.getParameter("removewishlist")!=null){
	String userId= request.getParameter("userId");
	String wishlistId= request.getParameter("wishlistId");
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/RemoveFromWishList/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("wishlistId", wishlistId);
	formData.add("userId", userId);
	//formData.add("name2", "val2");
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).delete(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	
	if (myresponse.getStatus() !=200){
		throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
	}

	String output = myresponse.getEntity(String.class);
	if(output.equals("delete_ok")){%>
		<script>
		alert("Το προϊόν διαγράφηκε με επιτυχία από την WishList!");
			
			window.location.href = "userservices.jsp";
		
	</script>
	<% }
	else{%>
		<script>
		alert("Το προϊόν ή ο χρήστης δεν βρέθηκαν");
			
			window.location.href = "bookme.jsp";
		
	</script>
		
	<%}
	
	
	
	
}
else if(request.getParameter("delete_user")!=null){
	String username1= request.getParameter("username1");
	
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/CloseAccount/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	
	formData.add("username1", username1);
	//formData.add("name2", "val2");
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).delete(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	
	if (myresponse.getStatus() !=200){
		throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
	}
	String output = myresponse.getEntity(String.class);
	
	if(output.equals("delete_ok")){%>
	<script>
	alert("Ο χρήστης διαγράφηκε!");
		
		window.location.href = "logoffuser.jsp";
	
</script>
<% }
else{%>
	<script>
	alert("Ο χρήστης δεν βρέθηκε!");
		
		window.location.href = "bookme.jsp";
	
</script>
	
<%}
	
	
}

else if(request.getParameter("card_buy")!=null){
	
	String firstname= request.getParameter("firstname");
	String lastname= request.getParameter("lastname");
	String telephone= request.getParameter("telephone");
	String address= request.getParameter("address");
	String city= request.getParameter("city");
	String postalcode= request.getParameter("postalcode");
	String email= request.getParameter("email");
	String cardNumber= request.getParameter("cardNumber");
	String cardType= request.getParameter("cardType");
	String creditCardExpireDate= request.getParameter("CreditCardExpireDate");
	String cvv= request.getParameter("cvv");
	String campaign= request.getParameter("campaign");
	String total_to_pay= request.getParameter("total_to_pay");
	String userID= request.getParameter("userID");
	String totalCart= request.getParameter("totalCart");
	
	
	String uniqueID = UUID.randomUUID().toString();
	uniqueID = "O"+uniqueID;
	
	System.out.println(cardType);
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/MakeOrder/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("firstname", firstname);
	formData.add("lastname", lastname);
	formData.add("telephone", telephone);
	formData.add("address", address);
	formData.add("city", city);
	formData.add("postalcode", postalcode);
	formData.add("email", email);
	formData.add("cardNumber", cardNumber);
	formData.add("cardType", cardType);
	formData.add("creditCardExpireDate", creditCardExpireDate);
	formData.add("cvv", cvv);
	formData.add("campaign", campaign);
	formData.add("total_to_pay", total_to_pay);
	formData.add("userID", userID);
	formData.add("totalCart", totalCart);
	formData.add("uniqueID", uniqueID);
	
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	
	
	

	if (myresponse.getStatus() !=200){
		throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
	}
	
	String output = myresponse.getEntity(String.class);
	
	System.out.println(output);
	
	if(output.equals("ok")){%>
	<script>

		alert("Η παραγγελία σας ολοκληρώθηκε");
		
		window.location.href = "deletels.jsp";

	</script>
	<% }
	
	else if(output.equals("no_same_length_of_products")){%>
	<script>

		alert("Προέκυψε πρόβλημα με τα προϊόντα. Παρακαλούμε προσπαθήστε ξανά!");
		
		window.location.href = "bookme.jsp";

	</script>
	<% }
	else if(output.equals("no_user")){%>
	<script>

		alert("Δεν βρέθηκε ο χρήστης");
		
		window.location.href = "bookme.jsp";

	</script>
	<% }
	
	else if(output.equals("problem")){%>
	<script>

		alert("Προέκυψε πρόβλημα. Παρακαλούμε προσπαθήστε ξανά!");
		
		window.location.href = "bookme.jsp";

	</script>
	<% }
	
	else {%>
	
	<script>

		alert('<%=output%>');
		
		window.location.href = "bookme.jsp";

	</script>
	<% }
		
	
}

else if(request.getParameter("modify_news")!=null){
	
String username1= request.getParameter("username1");
String nstatus= request.getParameter("nstatus");
	
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/ChangeNewsletters/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("username1", username1);
	formData.add("nstatus", nstatus);
	
	
	ClientResponse myresponse = webResource.accept("text/plain").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).put(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	

if (myresponse.getStatus() !=200){
	//throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
}
	
String output = myresponse.getEntity(String.class);

if (output.equals("news_ok")){%>



<script>

alert("Η διαδικασία αλλαγής Newsletter πραγματοποιήθηκε!");

window.location.href = "userservices.jsp";

</script>

<%}	

else{%>
<script>

	alert("Συνέβη κάποιο σφάλμα. Παρακαλούμε προσπαθήστε ξανά!");
	
	window.location.href = "userservices.jsp";

</script>
<% }






}


%>

</body>
</html>