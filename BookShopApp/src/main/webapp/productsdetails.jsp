<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bookme</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="BookmeFunctions.js"></script>
  <link rel="stylesheet" type="text/css" href="bookme.css">
  
  <style>
.jumbotron{
	  background-color:white;
  }

   .carousel-inner img {
    width: 100%;
    height: 100%;
  }
  .carousel-inner{
  background-color:white;
  }


  .customList{
        margin: 20px;
    }


  </style>
</head>
<body>

	 <!-- Εισαγωγή logo σελίδας-->
	<a href="bookme.jsp"><img id="logo" src="pictures/Bookme-logos_transparent.png" alt="logo png"></a>

	 <!--<div class="jumbotron text-center" style="margin-bottom:0">
  <h1>Bookme</</h1>
  <p>No 1 Ηλετρονικό Βιβλιοπωλείο!</p>
</div>-->

	  <!-- Δημιουργία header με τον τίτλο και τον υπότιτλο της σελίδας-->
	 <div class="header">
		<h1>Bookme</h1>
		<p>No 1 Ηλετρονικό Βιβλιοπωλείο!</p>
		</div>

	 <br/> <br/> <br/> <br/><br/>

	  <!-- Δημιουργία navbar με τους συνδέσμους της σελίδας-->
	 <nav class="navbar navbar-expand-lg bg-dark navbar-dark">
  <a class="navbar-brand" href="bookme.jsp">Αρχική</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
     <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="products.jsp?categoryId=C646043e1-05da-4f52-9152-7c81e378f493">Νέα Βιβλία</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="products.jsp?categoryId=Cec707641-835e-4d8e-bc98-3d46fd89c945">Comic Books</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="products.jsp?categoryId=C46dfeb36-54b7-4bba-b935-f4f10fc64e63">Best Sellers</a>
      </li>
	  <li class="nav-item">
        <a class="nav-link" href="category.jsp">Κατηγορίες</a>
      </li>
	   <li class="nav-item">
        <a class="nav-link" href="#">Επικοινωνία</a>
      </li>
    </ul>
    <ul class="navbar-nav mr-auto">
       
	  
	  
	
	  
	  
    </ul>
   <%if(null == session.getAttribute("user")){ %>
    <ul class="navbar-nav">
   
    <li class="nav-item">
        <a class="nav-link" href="login.jsp">Είσοδος</a>
      </li> 
       <li class="nav-item">
        <a class="nav-link" href="register.jsp">Εγγραφή</a>
      </li>
    </ul>
    <% }
    else{
    	String username=(String)session.getAttribute("user");
    %>
    	 <ul class="navbar-nav">
   
    <li class="nav-item">
        <a class="nav-link" href="cart.jsp">Το Καλάθι μου</a>
      </li> 
    
    <li class="nav-item">
        <a class="nav-link" href="userservices.jsp">Wellcome <% out.println(username);%></a>
      </li> 
       <li class="nav-item">
        <a class="nav-link"  href="#" onclick="logOff()">Αποσύνδεση</a>
      </li>
    </ul>
   <% }
    
    %>
  </div>
</nav>
 <!-- Τέλος δημιουργίας navbar-->
<br><br>
<div class="container mt-3">
<div class="jumbotron text-center" style="margin-bottom:0" >
  <form class="form-inline" action="search.jsp" method="POST">
    <input id="search_bar" class="form-control mr-sm-2" type="text" name="search" placeholder="Αναζήτησε όλα τα προϊόντα εδώ!">
    <button id="bcolor" class="btn" name="search" type="submit">Search</button>
  </form>
</div>
</div>
<br/><br/>



 <!-- Δημιουργία cards που σχετίζονται με το ηλεκτρονικό κατάστημα-->

<div class="container">
<%
	
	
	if(request.getParameter("productId")!=null && request.getParameter("productId").isEmpty()==false){
		String productId = request.getParameter("productId");
		
		Client client= Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/ShowProductDetails/"+productId);
		ClientResponse myresponse = webResource.accept("application/json").get(ClientResponse.class);
		
		System.out.println("productId "+productId);
		
		if (myresponse.getStatus() !=200){
			throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
		}

		String output = myresponse.getEntity(String.class);

			
		JSONObject mainObj2 = new JSONObject(output);


		JSONArray test2 = mainObj2.getJSONArray("productDetails");
	


%>

<%
if(test2.length()>0){


%>

    <div class="customList">
   <%for(int i=0; i<test2.length(); i++){%>
   <div class="list-group">
        <div  class="list-group-item">
            <div class="d-flex w-100 justify-content-between">
                <h4 id="pname"><%out.print(test2.getJSONObject(i).getString("productName"));%></h4>
                <small>Άμεσα Διαθέσιμο</small>
                
            </div>
              <img class="photo" src="data:image/<%out.print(test2.getJSONObject(i).getString("productImageType"));%>;base64, <%out.print(test2.getJSONObject(i).getString("productImage"));%>" alt="product_image" style="width:25%">
             <p><p/>
             <p>Συγγραφέας: <%out.print(test2.getJSONObject(i).getString("authorName"));%> <%out.print(test2.getJSONObject(i).getString("authorLastname"));%></p>
              <p>Εκδότης: <%out.print(test2.getJSONObject(i).getString("publisherName"));%></p>
               <p>Έτος Έκδοσης: <%out.print(test2.getJSONObject(i).getString("publicationYear"));%></p>
                <p>Σελίδες: <%out.print(test2.getJSONObject(i).getString("pages"));%></p>
                 <p id="price">Τιμή: <%out.print(test2.getJSONObject(i).getString("productPrice"));%> &euro;</p>
                  <p id="productId" style= "display:none;"><%out.print(test2.getJSONObject(i).getString("productId"));%></p>
                  <p id="user" style= "display:none;"><%out.println(session.getAttribute("user")); %></p>
                
               <%if(null == session.getAttribute("user")) {%>
               <p> <button id="bcolor" class="btn" disabled>Add to WishList <i class="fa fa-heart"></i></button></p>
               <%}
               else{%>
                <form name="wishlist" action="useraction.jsp" method="POST">
               <input type="text"  id="product"  name="product"   style="display:none;" value="<%out.print(test2.getJSONObject(i).getString("productId"));%>"/>
                <input type="text"  id="user1" name="username1"   style= "display:none;" value="<%out.println(session.getAttribute("user")); %>">
            	    <p> <button id="bcolor" class="btn" type="submit" name="wishlist" >Add to WishList <i class="fa fa-heart"></i></button></p>
            	    </form>
              <% }%>
                <p></p>
            <p>Περιγραφή: <%out.print(test2.getJSONObject(i).getString("productDescription"));%></p>
             <p></p>
             <%if(null == session.getAttribute("user")) {%>
            	 <p><button class="cartbutton" data-toggle="tooltip" title="Κάνε Login για να αγοράσεις το προϊόν!">Προσθήκη στο Καλάθι</button></p>
            	 <script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip();   
});
</script>
            <% }
            else{%>
            <p><button type="button" class="cartbutton"  onclick="addCartProducts()">Προσθήκη στο Καλάθι</button></p>
           <% }%>
            
        </div>
        
    </div>
 <% }%>

  
   </div>
   <br>
   <%}
   else{%>
	   <div class="customList">
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Κάτι πήγε στραβά!</h4>
                <small>info message</small>
            </div>
              <img class="photo" src="pictures/mesaage.png" alt="info" style="width:25%">
            <p>Το συγκεκριμένο προϊόν δεν είναι διαθέσιμο. Παρακαλούμε επέλεξε ένα διαφορετικό προϊόν από τις διαθέσιμες κατηγορίες!</p>
        </a>
        
    </div>
</div>
	<br>
  <%}%>
<%  }

else{%>

<div class="customList">
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Κάτι πήγε στραβά!</h4>
                <small>info message</small>
            </div>
              <img class="photo" src="pictures/mesaage.png" alt="info" style="width:25%">
            <p>Δεν έχετε επιλέξει κάποιο προϊόν. Παρακαλούμε προσπαθήστε εκ νέου!</p>
        </a>
        
    </div>
</div>

<%}%>
<br>

</div>

 <!-- Τέλος δημιουργίας cards-->
<br/> <br/>
<br/> <br/>

 









 <!-- Δημιουργία Footer-->

<div class="jumbotron text-center" style="margin-bottom:0">
 <!-- Δημιουργία συνδέσμων στο footer με χρήσιμες πληροφορίες-->
  <footer class="pt-4 my-md-5 pt-md-5 border-top">
        <div class="row">
            <div class="col-6 col-md">
            <h5>Κατηγορίες</h5>
            <ul class="list-unstyled text-small">
              <li><a class="text-muted" href="bookme.jsp">Αρχική</a></li>
              <li><a class="text-muted" href="#l">Νέα Βιβλία</a></li>
              <li><a class="text-muted" href="#">Comic Books</a></li>
              <li><a class="text-muted" href="#">Best Sellers</a></li>
              <li><a class="text-muted" href="#">Κατηγορίες</a></li>
              <li><a class="text-muted" href="#">Επικοινωνία</a></li>
            </ul>
          </div>
          <div class="col-6 col-md">
            <h5>Η εταιρεία</h5>
            <ul class="list-unstyled text-small">
              <li><a class="text-muted" href="#">Ποιοι είμαστε</a></li>
              <li><a class="text-muted" href="#">Δελτία Τύπου</a></li>
              <li><a class="text-muted" href="#">Κοινωνική Ευθύνη</a></li>
              <li><a class="text-muted" href="#">Χορηγίες</a></li>
              <li><a class="text-muted" href="#">Διακρίσεις</a></li>
              <li><a class="text-muted" href="#">Ευκαιρίες Καρίερας</a></li>
            </ul>
          </div>
          <div class="col-6 col-md">
            <h5>Χρήσιμα</h5>
            <ul class="list-unstyled text-small">
              <li><a class="text-muted" href="#">Όροι Χρήσης</a></li>
              <li><a class="text-muted" href="#">Τρόποι Αποστολής</a></li>
              <li><a class="text-muted" href="#">Τρόποι Πληρωμής</a></li>
              <li><a class="text-muted" href="#">Συνήγορος Καταναλωτή</a></li>
			  <li><a class="text-muted" href="#">Επίλυση Διαφορών</a></li>
			   <li><a class="text-muted" href="#">Newsletter</a></li>
            </ul>
          </div>
          <div class="col-6 col-md">
            <h5>Υποστήριξη</h5>
            <ul class="list-unstyled text-small">
              <li><a class="text-muted" href="#">Είμαστε Δίπλα σου</a></li>
              <li><a class="text-muted" href="#">Όροι & Πολιτικές</a></li>
              <li><a class="text-muted" href="#">Ασφάλεια στις Αγορές</a></li>
              <li><a class="text-muted" href="#">Πολιτική Απορρήτου</a></li>
			   <li><a class="text-muted" href=#">Reset Password</a></li>
			     <li><a class="text-muted" href="#">Cookies</a></li>
            </ul>
          </div>
        </div>
      </footer>

	   <!-- Τέλος δημιουργίας συνδέσμων-->
	  <hr>



	  <br/> <br/>

	   <!-- Δημιουργία copyright-->
  &copy;
				   <a href="bookme.jsp">2024 Bookme </a>
				   All rights reserved.
				    <!-- Τέλος δημιουργίας copyright-->
</div>

 <!-- Τέλος δημιουργίας Footer-->

	</body>
</html>