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
<body ng-app>
<% 
if(null == session.getAttribute("user")){%>
	<script>
	alert("Πρέπει να κάνετε login για να έχετε πρόσβαση στην υπηρεσία!");
	
	window.location.href = "bookme.jsp";
	
</script>
<%}
else{
	
String username1= (String)session.getAttribute("user");
   
   
  


%>
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
        <a class="nav-link" href="#">Είσοδος</a>
      </li> 
       <li class="nav-item">
        <a class="nav-link" href="delete.jsp">Εγγραφή</a>
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


<div class="container">
<div class="container mt-3">
<div id="demo" class="carousel slide" data-ride="carousel">
  
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="pictures/delete_user.jpg" alt="login" width="1100" height="500">
  
    </div>
   
</div>

</div>

<br> <br>

   <div class="customList">
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Διαγραφή Λογαριασμού!</h4>
                <small>info message</small>
            </div>
              <img class="photo" src="pictures/bye.jpg" alt="info" style="width:25%">
            <p>Λυπούμαστε που φεύγεις από την οικογένειά μας! Η συγκεκριμένη ενέργεια θα επιφέρει την οριστική διαγραφή σου από τις υπηρεσίες μας. Παρακαλούμε επιβεβαίωσε ότι επιθυμείς να διαγραφείς οριστικά από Bookme.</p>
        </a>
        
    </div>
</div>
<br> <br>
  <form name="delete" action="useraction.jsp" method="POST">
    <div class="form-group">
    
      <input type="text"  id="username1"  name="username1" style= "display:none"; value="<%out.println(username1); %>">
    </div>
    
    
    <button type="submit" class="btn btn-primary" name="delete_user">Ναι θέλω να διαγραφώ</button>
  </form>
</div>
</div>
<br/><br/><br/><br/>








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
<%}
%>
	</body>
</html>