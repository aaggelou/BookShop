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
 <!-- Δηιουργία carousel με εικόνες που σχετίζονται με το βιβλιοπωλείο-->
<div class="container mt-3">
<div id="demo" class="carousel slide" data-ride="carousel">
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1"></li>
    <li data-target="#demo" data-slide-to="2"></li>
	<li data-target="#demo" data-slide-to="3"></li>
	<li data-target="#demo" data-slide-to="4"></li>
  </ul>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="pictures/image_book2.png" alt="Book1" width="1100" height="500">
  
    </div>
    <div class="carousel-item">
      <img src="pictures/children_book2.jpg" alt="Βοοκ2" width="1100" height="500">
    
    </div>
    <div class="carousel-item">
      <img src="pictures/Comic.png" alt="Book3" width="1100" height="500">
     
    </div>

	  <div class="carousel-item">
      <img src="pictures/allaboutbooks.png" alt="Book4" width="1100" height="500">
     
    </div>

	  <div class="carousel-item">
      <img src="pictures/justarrived.gif" alt="Book5" width="1100" height="500">
     
    </div>
  </div>
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

</div>

 <!-- Τέλος δημιουργίας carousel-->


<br/> <br/>


 <!-- Δημιουργία cards που σχετίζονται με το ηλεκτρονικό κατάστημα-->

<div class="container">


   <div class="row">
    <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/newbooks5.jpg" alt="Card image" style="width:100%">
    <div class="card-body">
      <h4 class="card-title">Νέα Βιβλία</h4>
      <p class="card-text">Ό,τι νεότερο κυκλοφορεί αποκλειστικά εδώ!</p>
	  <br><br>
      <a href="products.jsp?categoryId=C646043e1-05da-4f52-9152-7c81e378f493" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>


   <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/comic_books.png" alt="Card image" style="width:100%">
    <div class="card-body">

      <h4 class="card-title">Comic Books</h4>
      <p class="card-text">Όλα Comic Books για τους μικρούς μας φίλους!</p>
	  <br>
      <a href="products.jsp?categoryId=Cec707641-835e-4d8e-bc98-3d46fd89c945" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>


   <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/category.png" alt="Card image" style="width:100%">
    <div class="card-body">
      <h4 class="card-title">Κατηγορίες</h4>
      <p class="card-text">Δες όλες τις κατηγορίες βιβλίων! Όλες για εσένα!</p>
      <br>
      <a href="category.jsp" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>
   </div>
<br>
  <div class="row">
    <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/best_sellers.png" alt="Card image" style="width:100%">
    <div class="card-body">
      <h4 class="card-title">Best Sellers</h4>
      <p class="card-text">Όλα τα Νο1 βιβλία σε πωλήσεις!</p>
	  <br><br>
      <a href="products.jsp?categoryId=C46dfeb36-54b7-4bba-b935-f4f10fc64e63" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>


   <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/login.png" alt="Card image" style="width:100%">
    <div class="card-body">

      <h4 class="card-title">Είσοδος</h4>
      <p class="card-text">Κάνε είσοδο για να αποκτήσεις τα προϊόντα μας!</p>
	  <br>
      <a href="login.jsp" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>


   <div class="col-md-6 col-lg-4 col-xl-4">
  <div class="card">
    <img class="card-img-top" src="pictures/register.png" alt="Card image" style="width:100%">
    <div class="card-body">
      <h4 class="card-title">Εγγραφή</h4>
      <p class="card-text">Γίνε μέλος στο Νο1 e-book shop!</p>
      <br><br>
      <a href="register.jsp" class="btn btn-primary">Περισσότερα</a>
    </div>
  </div>
  </div>
  <br>
   </div>
</div>

 <!-- Τέλος δημιουργίας cards-->
<br/> <br/>
<br/> <br/>

 <!-- Δημιουργία συνοπτικής λίστας με τα προτάσεις βιβλίων-->
<div class="container">
 <h1>Προτάσεις</h1>
<div class="customList">
    <div class="list-group">
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Ένοχοι</h4>
                <small>1 days ago</small>
            </div>
              <img class="photo" src="pictures/enoxoi.jpg" alt="enoxoi" style="width:25%">
            <p>Η Σεσίλια Βέρο στρέφει το όπλο ενάντια στον άντρα που έχει ερωτευτεί. Μέσα σε λίγα δευτερόλεπτα πατά τη σκανδάλη, η σφαίρα αποχωρίζεται την κάνη και τον τραυματίζει στον ώμο. Την ευκαιρία που της δίνει να εξαφανιστεί δεν την αφήνει ανεκμετάλλευτη, μα ένα χρόνο αργότερα οι άντρες του την ανακαλύπτουν σε ένα απομονωμένο χωριό της Ιταλίας....</p>
        </a>
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Γουέιτζερ</h4>
                <small>2 days ago</small>
            </div>
            <img class="photo" src="pictures/goueitzer.jpg" alt="goueitzer" style="width:25%">
            <p>Στις 28 Ιανουαρίου 1742 ένα μισοδιαλυμένο πλοιάριο, με τα πανιά κουρελιασμένα και το κατάρτι κομμάτια, ξεβράστηκε στις ακτές της Βραζιλίας. Επιβάτες του ήταν τριάντα άντρες, σχεδόν ολότελα αποστεωμένοι. Τα όσα αφηγήθηκαν έμοιαζαν απίστευτα.</p>
        </a>
        <a href="#" class="list-group-item list-group-item-action">
            <div class="d-flex w-100 justify-content-between">
                <h4>Κριστίν</h4>
                <small>3 days ago</small>
            </div>
            <img class="photo" src="pictures/kristinjpg.jpg" alt="kristin" style="width:25%">
            <p>«...εξαρχής τα πράγματα δεν έδειχναν καλά. Και στην πορεία χειροτέρεψαν ραγδαία». Είναι έρωτας με την πρώτη ματιά όταν ο μαθητής λυκείου Αρνι Κάνινγκχαμ και ο καλύτερός του φίλος, ο Ντένις Γκίλντερ, βρίσκουν προς πώληση μια σαραβαλιασμένη κόκκινη και άσπρη Πλίμουθ Φιούρι -με το όνομα Κριστίν, όπως τη βάφτισε ο αρχικός δύστροπος ιδιοκτήτης της. </p>
        </a>
    </div>
</div>
</div>

 <!-- Τέλος δημιουργίας λίστας-->










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