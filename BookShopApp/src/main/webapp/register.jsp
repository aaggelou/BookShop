<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
if(null != session.getAttribute("user")){%>
	<script>
	alert("Είστε συνδεδεμένος! Πρέπει να κάνετε logout για να εγγραφείτε!");
		
		window.location.href = "bookme.jsp";
	
</script>
<%}
else{%>




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
    <ul class="navbar-nav">
   
    <li class="nav-item">
        <a class="nav-link" href="login.jsp">Είσοδος</a>
      </li> 
       <li class="nav-item">
        <a class="nav-link" href="register.jsp">Εγγραφή</a>
      </li>
    </ul>
  </div>
</nav>
 <!-- Τέλος δημιουργίας navbar-->
<br><br>


<div class="container">
<div class="container mt-3">
<div id="demo" class="carousel slide" data-ride="carousel">
  
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="pictures/Comic (2).gif" alt="register" width="1100" height="500">
  
    </div>
   
</div>

</div>

<br> <br>
  <form  name="register" ACTION="finalregister.jsp" METHOD="POST" accept-charset="UTF-8">
    <div class="form-group">
      <label for="name">Όνομα:</label>
      <input type="text" class="form-control" id="name" placeholder="Όνομα" name="firstname" ng-model="firstname" onchange="validationName()" required>
      <span ng-show="register.firstname.$touched && register.firstname.$error.required">Δώστε Όνομα χωρίς κενά και αριθμούς!</span>
    </div>
    <div class="form-group">
      <label for="lastname">Επώνυμο:</label>
      <input type="text" class="form-control" id="lastname" placeholder="Επώνυμο" name="lastname"  ng-model="lastname" onchange="validationLastName()" required>
      <span ng-show="register.lastname.$touched && register.lastname.$error.required">Δώστε Επώνυμο χωρίς κενά και αριθμούς!</span>
    </div>
    
    
    <div class="form-group">
      <label for="telephone">Τηλέφωνο:</label>
      <input type="text" class="form-control" id="telephone" placeholder="Τηλέφωνο" name="telephone" ng-model="telephone" onchange="validationTelephone()" required>
      <span ng-show="register.telephone.$touched && register.telephone.$error.required">Δώστε Τηλέφωνο με 10 ψηφία χωρίς κενά!</span>
    </div>
    
    <div class="form-group">
      <label for="birth">Ημερομηνία Γέννησης:</label>
      <input type="date" class="form-control" id="birth" placeholder="Ημερομηνία Γέννησης" name="birth" ng-model="birth" onchange="validationBirth()" required>
      <span ng-show="register.birth.$touched && register.birth.$error.required">Δώστε Ημερομηνία χωρίς κενά!</span>
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
      <label for="user1">Username:</label>
      <input type="text" class="form-control" id="user1" placeholder="Username" name="username1" ng-model="username1" ng-minlength="3" ng-maxlength="15" onchange="validationUsername()" required>
      <span ng-show="register.username1.$touched && register.username1.$error.required">Δώστε Username χωρίς κενά!</span>
	  <span ng-show="register.username1.$touched && register.username1.$error.minlength">Δώστε Username με τουλάχιστον 3 χαρακτήρες!</span>
	  <span ng-show="register.username1.$touched && register.username1.$error.maxlength">Δώστε Username με το πολύ 15 χαρακτήρες!</span>
    </div>
    
    <div class="form-group">
      <label for="pass1">Password:</label>
      <input type="password" class="form-control" id="pass1" placeholder="Password" name="password1" ng-model="password1" ng-minlength="8" ng-maxlength="20" onchange="validationPassword()" required>
     <span ng-show="register.password1.$touched && register.password1.$error.required">Δώστε Password!</span>
	  <span ng-show="register.password1.$touched && register.password1.$error.minlength">Δώστε Password με τουλάχιστον 8 χαρακτήρες!</span>
	   <span ng-show="register.password1.$touched && register.password1.$error.maxlength">Δώστε Password με το πολύ 20 χαρακτήρες!</span>
    </div>
    
    
     <div class="form-group">
      <label for="pass1">Re-enter Password:</label>
      <input type="password" class="form-control" id="pass2" placeholder="Enter password" name="password2" ng-model="password2" onchange="validationPassword()" required>
     <span ng-show="register.password2.$touched && register.password2.$error.required">Οι δύο κωδικοί πρέπει να ταιριάζουν!</span>
    </div>
    
    
     <div class="form-group">
      <label for="email">E-mail:</label>
      <input type="email" class="form-control" id="email" placeholder="Email" ng-model="email"  name="email" onchange="validationEmail()" required>
     <span ng-show="register.email.$touched && register.email.$error.required">Δώστε e-mail χωρίς κενά!</span>
	 <span ng-show="register.email.$error.email">Δώστε σωστό e-mail!</span>
    </div>
    
      <div class="form-group form-check">
      <label class="form-check-label">
        <input class="form-check-input" type="checkbox" name="newsletter" > Επιθυμώ να λαμβάνω Newsletters
      </label>
    </div>
    
    <button id="activate" type="submit" class="btn btn-primary"  name="register_user" ng-disabled="register.$invalid">Υποβολή</button>
  </form>
</div>
</div>






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