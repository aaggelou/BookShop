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
  <script src="BookmeFunctions.js" ></script>
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
	Client client= Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BookShopApp/rest/BookShopAppService/GetUserData/");
	
	MultivaluedMap <String,String> formData = new com.sun.jersey.core.util.MultivaluedMapImpl();
	
	formData.add("username1", username1);
	
	
	ClientResponse myresponse = webResource.accept("application/json").type(MediaType.APPLICATION_FORM_URLENCODED_TYPE).post(ClientResponse.class,formData);//type(MediaType.APPLICATION_FORM_URLENCODED_TYPE)
	
	if (myresponse.getStatus() !=200){
		throw new RuntimeException("Failed : HTTP error code : " + myresponse.getStatus());
	}
	
	String output = myresponse.getEntity(String.class);

	
	JSONObject mainObj2 = new JSONObject(output);


	JSONArray test2 = mainObj2.getJSONArray("userData");
	
	JSONArray test3 = mainObj2.getJSONArray("campaign");
	
	
	
	
	
	
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
 <!-- <div class="container">
 <div class="customList">
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Κάτι πήγε στραβά!</h4>
                <small>info message</small>
            </div>
              <img class="photo" src="pictures/online_shop.png" alt="info" style="width:25%">
            <p>Δεν υπάρχουν κατηγορίες. Παρακαλούμε επέλεξε μία διαφορετική επιλογή από την αρχική σελίδα!</p>
        </a>
        
    </div>
</div>
	</div>-->


<br/> <br/>


<div class="container">
  <h2>Καλάθι Αγορών</h2>
  <p>Δες τα προϊόντα που έχει προσθέσει στο καλάθι σου!</p>
  <button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#demo2" onclick="showCart()" id="timeToClose">Οι Αγορές μου</button>
  <div id="demo2" class="collapse">
  <div class="customList" id="empty_cart" style="display:none;">
    <div class="list-group"  >
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Δεν υπάρχουν Προϊόντα!</h4>
                <small>info message</small>
            </div>
              <img class="photo" src="pictures/cart.png" alt="info" style="width:25%">
            <p>Το καλάθι σου είναι άδειο. Γέμισέ το κάνοντας τις αγορές σου μέσα από χιλιάδες βιβλία.</p>
        </a>
        
    </div>
</div>

<div class="container mt-3" id="no_empty_cart" style="display:none;">
 
  <p></p>
  <ul class="list-group" id="create_li">
    
  </ul>
   <p></p>
  <a href="category.jsp?" class="btn btn-primary">Συνέχισε Τις Αγορές Σου!</a>  <button type="button" class="btn btn-primary"  onclick="completeBuy()" >Ολοκλήρωση Αγοράς</button>  <button type="button" class="btn btn-primary" onclick="deleteCart()" >Άδειασμα Καλαθιού</button>
</div>
<div class="container mt-3" id="no_empty_cart2" style="display:none;">

 <form  name="register" ACTION="useraction.jsp" METHOD="POST" accept-charset="UTF-8">
    <div class="form-group">
      <label for="name">Όνομα:</label>
      <input type="text" class="form-control" id="name" placeholder="Όνομα" name="firstname" value="<%out.print(test2.getJSONObject(0).getString("firstName"));%>"  readonly required>

    </div>
    <div class="form-group">
      <label for="lastname">Επώνυμο:</label>
      <input type="text" class="form-control" id="lastname" placeholder="Επώνυμο" name="lastname"   value="<%out.print(test2.getJSONObject(0).getString("lastName"));%>"  readonly  required>
    
    </div>
    
    
    <div class="form-group">
      <label for="telephone">Τηλέφωνο:</label>
      <input type="text" class="form-control" id="telephone" placeholder="Τηλέφωνο" name="telephone" ng-model="telephone" onchange="validationTelephone()" required>
      <span ng-show="register.telephone.$touched && register.telephone.$error.required">Δώστε Τηλέφωνο με 10 ψηφία χωρίς κενά!</span>
    </div>
    
  
    
    <div class="form-group">
      <label for="address">Διεύθυνση:</label>
      <input type="text" class="form-control" id="address" placeholder="Διεύθυνση" name="address" ng-model="address" required>
      <span ng-show="register.address.$touched && register.address.$error.required">Δώστε Διεύθυνση!</span>
    </div>
    
    <div class="form-group">
      <label for="city">Πόλη:</label>
      <input type="text" class="form-control" id="city" placeholder="Πόλη" name="city" ng-model="city" onchange="validationCity()" required>
      <span ng-show="register.city.$touched && register.city.$error.required">Δώστε Πόλη χωρίς κενά και αριθμούς!</span>
    </div>
    
    <div class="form-group">
      <label for="postalcode">ΤΚ:</label>
      <input type="text" class="form-control" id="postalcode" placeholder="TK" name="postalcode" ng-model="postalcode" onchange="validationPc()" required>
      <span ng-show="register.postalcode.$touched && register.postalcode.$error.required">Δώστε ΤΚ μόνο 5-ψήφιο ακέραιο χωρίς κενά!!</span>
    </div>
    
    
    
    
     <div class="form-group">
      <label for="email">E-mail:</label>
      <input type="email" class="form-control" id="email" placeholder="Email"   name="email"  value="<%out.print(test2.getJSONObject(0).getString("email"));%>"  readonly required>
    
    </div>
    
    
    
    <div class="form-group">
      <label for="cardNumber">Αριθμός Κάρτας:</label>
      <input type="text" class="form-control" id="cardNumber" placeholder="Αριθμός Κάρτας" name="cardNumber" ng-model="cardNumber" onchange="validationCard()" required>
      <span ng-show="register.cardNumber.$touched && register.cardNumber.$error.required">Δώστε Αριθμό Κάρτας με 16 ψηφία χωρίς κενά!</span>
    </div>
      <div class="form-group">
     <label for="cardType">Τύπος Κάρτας:</label>
  <select name="cardType" id="cardType">
    <option value="Visa">Visa</option>
    <option value="MasterCard">MasterCard</option>
  </select>
    </div>
  <br><br>
     
     <div class="form-group">
      <label for="CreditCardExpireDate">Ημερομηνία Λήξης Κάρτας:</label>
      <input type="date" class="form-control" id="CreditCardExpireDate" placeholder="Ημερομηνία Λήξης Κάρτας" name="CreditCardExpireDate" ng-model="CreditCardExpireDate" onchange="validationCreditCardExpireDate()" required>
      <span ng-show="register.CreditCardExpireDate.$touched && register.CreditCardExpireDate.$error.required">Δώστε Ημερομηνία χωρίς κενά!</span>
    </div>
    
    
    
      <div class="form-group">
      <label for="cvv">CVV:</label>
      <input type="text" class="form-control" id="cvv" placeholder="CVV" name="cvv" ng-model="cvv" onchange="validationCvv()" required>
      <span ng-show="register.cvv.$touched && register.cvv.$error.required">Δώστε CVV με 3 ψηφία χωρίς κενά!</span>
    </div>
    
    <%if(test3.length()>0){%>
       <div class="form-group">
     <label for="campaigns">Καμπάνια:</label>
  <select name="campaign" id="campaign">
  <option value="noCampaign">Όχι</option>
   <%for(int i=0; i<test3.length(); i++){%>
    <option value="<%out.print(test3.getJSONObject(i).getString("campaignID"));%>"><%out.print(test3.getJSONObject(i).getString("CBeneficiaryName"));%>-<%out.print(test3.getJSONObject(i).getString("campaignTitle"));%>-<%out.print(test3.getJSONObject(i).getString("campaignID"));%></option>
     <% }%>
  </select>
    </div>
   <% }%>
   
   
   <div class="form-group">
      <label for="total">Σύνολο:</label>
      <input type="text" class="form-control" id="total_to_pay" placeholder="Σύνολο" name="total_to_pay"  required>
      
    </div>
     <input type="text"  id="user1" name="userID"   style= "display:none;" value="<%out.print(test2.getJSONObject(0).getString("userID"));%>">
      <input type="text"  id="totalCart" name="totalCart"   style= "display:none;">
    
    
    <button id="activate" type="submit" class="btn btn-primary"  name="card_buy" ng-disabled="register.$invalid">Ολοκλήρωση Αγοράς</button>  <button id="go_back_button" type="button" class="btn btn-primary"  name="go_back" onclick="goBack()">Πίσω</button>
  </form>


</div>
  </div>
</div>


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
 
  <%
}

%>

	</body>
</html>