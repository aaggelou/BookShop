
/*document.addEventListener("DOMContentLoaded", function() {
  var cart = getCartFromLocalStorage();
  displayCart(cart);

  function getCartFromLocalStorage() {
    var cart = JSON.parse(localStorage.getItem("cart"));
    return cart ? cart : [];
  }

  function displayCart(cart) {
    var cartElement = document.getElementById("cart");
    if (cart.length === 0) {
      cartElement.src = "pictures/cart.png";
    } else {
      var cartContent = "<ul>";
      cart.forEach(function(item, index) {
        cartContent += "<li>" + item.name + " - $" + item.price + " <button class='remove-item' data-index='" + index + "'>Remove</button></li>";
      });
      cartContent += "</ul>";
      cartElement.innerHTML = cartContent;
    }
  }

  document.addEventListener("click", function(event) {
    if (event.target.classList.contains("remove-item")) {
      var index = event.target.getAttribute("data-index");
      removeFromCart(index);
    }
  });

  function removeFromCart(index) {
    var cart = getCartFromLocalStorage();
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    displayCart(cart);
  }
});*/




function validationName(){
	var x=document.register.firstname;
	/*firstname*/
	/*alert(x.value);*/
	var pass1 = false;
	var str = x.value;
  var patt1 = /\s/g;
  var patt2 = /[0-9]/g;
  var result = str.match(patt1);
  var result2 = str.match(patt2);
	if(result!=null || x.value=="" || result2!=null){
		/*alert("problem")*/
		document.register.firstname.value="";
	}
	
}

function validationLastName(){
	var x=document.register.lastname;
	/*firstname*/
	/*alert(x.value);*/
	var pass1 = false;
	var str = x.value;
  var patt1 = /\s/g;
  var patt2 = /[0-9]/g;
  var result = str.match(patt1);
  var result2 = str.match(patt2);
	if(result!=null || x.value=="" || result2!=null){
		/*alert("problem")*/
		document.register.lastname.value="";
	}
	
}


function validationUsername(){
	var e=document.register.username1;
	/*alert(e.value);*/
	var pass7 = false;
	var stre = e.value;
  var patte1 = /\s/g;
  /*var patte2 = /[0-9]/g;*/
  var resulte = stre.match(patte1);
 /* var resulte2 = stre.match(patte2);*/
	if(resulte!=null || e.value==""){
		/*alert("problem")*/
		document.register.username1.value="";
	}
	
}


function validationTelephone(){
	var te=document.register.telephone;
	/*alert(d.value);*/
	var pass8 = false;
	var strte = te.value;
  var pattte1 = /\D/g;
  /*var pattte2 = /[0-9]/g;*/
  var resultte = strte.match(pattte1);
  var tellength=te.value.length;
  /*var resultte2 = strte.match(pattte2);*/
	if(resultte!=null || te.value=="" || tellength!=10){
		/*alert("problem")*/
		document.register.telephone.value="";
	}
	
}


function validationCard(){
	var te=document.register.cardNumber;
	/*alert(d.value);*/
	var pass8 = false;
	var strte = te.value;
  var pattte1 = /\D/g;
  /*var pattte2 = /[0-9]/g;*/
  var resultte = strte.match(pattte1);
  var tellength=te.value.length;
  /*var resultte2 = strte.match(pattte2);*/
	if(resultte!=null || te.value=="" || tellength!=16){
		/*alert("problem")*/
		document.register.cardNumber.value="";
	}
	
}



function validationCvv(){
	var te=document.register.cvv;
	/*alert(d.value);*/
	var pass8 = false;
	var strte = te.value;
  var pattte1 = /\D/g;
  /*var pattte2 = /[0-9]/g;*/
  var resultte = strte.match(pattte1);
  var tellength=te.value.length;
  /*var resultte2 = strte.match(pattte2);*/
	if(resultte!=null || te.value=="" || tellength!=3){
		/*alert("problem")*/
		document.register.cvv.value="";
	}
	
}

function validationCreditCardExpireDate(){
	var da=document.register.CreditCardExpireDate;
	/*alert(d.value);*/
var pass9 = false;
	var strda = da.value;
  var pattda1 = /\s/g;
  /*var patte2 = /[0-9]/g;*/
  var resultda = strda.match(pattda1);
 /* var resulte2 = stre.match(patte2);*/
	if(resultda!=null || da.value==""){
		/*alert("problem")*/
		document.register.CreditCardExpireDate.value="";
	}
	
}


function validationBirth(){
	var da=document.register.birth;
	/*alert(d.value);*/
var pass9 = false;
	var strda = da.value;
  var pattda1 = /\s/g;
  /*var patte2 = /[0-9]/g;*/
  var resultda = strda.match(pattda1);
 /* var resulte2 = stre.match(patte2);*/
	if(resultda!=null || da.value==""){
		/*alert("problem")*/
		document.register.birth.value="";
	}
	
}


function validationCity(){
	var x=document.register.city;
	/*firstname*/
	/*alert(x.value);*/
	var pass1 = false;
	var str = x.value;
  var patt1 = /\s/g;
  var patt2 = /[0-9]/g;
  var result = str.match(patt1);
  var result2 = str.match(patt2);
	if(result!=null || x.value=="" || result2!=null){
		/*alert("problem")*/
		document.register.city.value="";
	}
	
}

function validationPc(){
	var f=document.register.postalcode;
	/*firstname*/
	/*alert(x.value);*/
	var pass6 = false;
	var strpc = f.value;
  var pattpc1 = /\D/g;
  /*var pattpc2 = /[0-9]/g;*/
  var resultpc = strpc.match(pattpc1);
  var resultpc2 = parseInt(f.value);
	if(resultpc!=null || f.value=="" || (resultpc2<10000) || resultpc2>99999){
		/*alert("problem")*/
		document.register.postalcode.value="";
	}
	
}

function validationPassword(){
	var p1=document.register.password1;
	var p2=document.register.password2;
	/*alert(p1.value);
	alert(p2.value);*/
	if(p1.value!=p2.value){
		
		document.register.password2.value="";
	}
	
}


function validationPassword2(){
	var p1=document.nregister.password1;
	var p2=document.nregister.password2;
	/*alert(p1.value);
	alert(p2.value);*/
	if(p1.value!=p2.value){
		
		document.nregister.password2.value="";
	}
	
}




function validationEmail(){
var e=document.register.email;
	/*alert(e.value);*/
	var pass7 = false;
	var stre = e.value;
  var patte1 = /\s/g;
  /*var patte2 = /[0-9]/g;*/
  var resulte = stre.match(patte1);
 /* var resulte2 = stre.match(patte2);*/
	if(resulte!=null || e.value==""){
		/*alert("problem")*/
		document.register.email.value="";
	}
	
}

function validationEmail2(){
var e=document.reset.email;
	/*alert(e.value);*/
	var pass7 = false;
	var stre = e.value;
  var patte1 = /\s/g;
  /*var patte2 = /[0-9]/g;*/
  var resulte = stre.match(patte1);
 /* var resulte2 = stre.match(patte2);*/
	if(resulte!=null || e.value==""){
		/*alert("problem")*/
		document.reset.email.value="";
	}
	
}

function logOff(){
	
	 localStorage.clear();
	window.location.href = "logoffuser.jsp"
	
}





function showCart(){
	
	 var cart = JSON.parse(localStorage.getItem("cart"));
	
	 if (!localStorage.getItem("cart")) {
      var no_cart = document.getElementById("empty_cart");
      no_cart.style.display="block";
    }
    else{
		
		var ulElement = document.getElementById('create_li');
		var no_empty_cart = document.getElementById("no_empty_cart");
		ulElement.innerHTML = '';
		
		  for (var i=0; i<cart.length; i++){
	   // Create the <li> element
		var liElement = document.createElement('li');
		liElement.classList.add('list-group-item', 'd-flex', 'justify-content-between', 'align-items-center');
		//liElement.textContent = cart[i].title+ " "+ cart[i].price;
		var productName = document.createElement( 'h4');
		var brElement= document.createElement('br');
		var pElement= document.createElement('p');
		var pId = document.createTextNode(cart[i].prdId);
		productName.textContent=(cart[i].title);
		liElement.textContent =  cart[i].price;
		pElement.appendChild(pId);
		pElement.style.display= 'none';
		liElement.appendChild(pElement);
		
		
		// Create the <span> element
		var spanElement = document.createElement('span');
		spanElement.classList.add('badge', 'badge-primary', 'badge-pill');
		
		// Create the <input> element
		var inputElement = document.createElement('input');
		inputElement.setAttribute('type', 'number');
		inputElement.setAttribute('id', cart[i].prdId);
		inputElement.setAttribute('name', 'quantity');
		inputElement.setAttribute('value', cart[i].qty);
		inputElement.setAttribute('min', '1');
		inputElement.setAttribute('max', '10');
		inputElement.setAttribute('onchange', 'handleChange(this)');
		
		// Append the <input> element to the <span> element
		spanElement.appendChild(inputElement);
		
		// Append the <span> element to the <li> element
		liElement.appendChild(spanElement);
		
		// Append the <li> element to the <ul> element
	
		ulElement.appendChild(productName);
		ulElement.appendChild(liElement);
		ulElement.appendChild(brElement);

		
	 
   }
		
	no_empty_cart.style.display="block";	
		
		
		
		
	}
    
	
	
}

function handleChange(inputElement){
	console.log(inputElement.id);
	var inputElementID=inputElement.id;
	
	 var cart = JSON.parse(localStorage.getItem("cart"));
	if (localStorage.getItem("cart")) {
     
     for (var i=0; i<cart.length; i++){
	   
	   if(cart[i].prdId==inputElementID){
		   if(inputElement.value>0){
		   cart[i].qty= inputElement.value;
		    }
		    else{
				
				cart[i].qty= cart[i].qty;
				inputElement.value=cart[i].qty;
			}
	   }
   }
     
      localStorage.setItem("cart", JSON.stringify(cart));
     
     
    }
	
}

function deleteCart(){
	
	 localStorage.clear();
	window.location.href = "bookme.jsp"
	
}




function completeBuy(){
	
	
	 var cart = JSON.parse(localStorage.getItem("cart"));
	 
	  if (localStorage.getItem("cart")) {
		  document.getElementById("total_to_pay").value="";
		  document.getElementById("totalCart").value="";
		  var total=0;
		  for (var i=0; i<cart.length; i++){
			var regex = /Τιμή: (\d+,\d+)/; 
			var match = cart[i].price.match(regex);
			var result = match[1];
			result = result.replace(',', '.');
				  
			var amoutToPay = (parseFloat(result)*parseInt(cart[i].qty));
			  
			  total=total+amoutToPay
			  
			  }
		  
		  console.log(total);
		  document.getElementById("total_to_pay").value=total;
		  
		   document.getElementById("totalCart").value=JSON.stringify(cart);
		   document.getElementById("timeToClose").disabled = true;
		    document.getElementById("no_empty_cart").style.display="none";
		   document.getElementById("no_empty_cart2").style.display="block";
		   
		   
		   
		  }
		  else{
			   console.log("no local storage");
			  
			  
		  }
	 
	
	
}


function goBack(){
	
	document.getElementById("no_empty_cart2").style.display="none";
	document.getElementById("timeToClose").disabled = false;
	 document.getElementById("no_empty_cart").style.display="block";
	 
	 
	
	
	
}







function addCartProducts(){
	
	
	 if (!localStorage.getItem("cart")) {
		 var cart = [];
		 var pname  = document.getElementById("pname").innerHTML;
		 var productPrice  = document.getElementById("price").innerHTML;
		 var productId  = document.getElementById("productId").innerHTML;
		 console.log(productId);
      var cartItem =  {
        title: pname,
        price: productPrice,
        qty: 1,
        prdId: productId
    };
    
    cart.push(cartItem);
    localStorage.setItem("cart", JSON.stringify(cart));
    
   
console.log("1");
   
    
    }
    
    else{
		
		 var cart2;
   cart2= JSON.parse(localStorage.getItem("cart"));
   
   var y =0;
   
    for (var i=0; i<cart2.length; i++){
	   
	   if(cart2[i].prdId==document.getElementById("productId").innerHTML){
		   console.log("OldQuantity: " +cart2[i].qty);
		   cart2[i].qty++;
		    console.log("NewQuantity: " +cart2[i].qty);
		    console.log("Name: " +cart2[i].title);
		     console.log("productId: " +document.getElementById("productId").innerHTML);
		      console.log("cart2[i].prdId: " +cart2[i].prdId);
		      y=y+1;
	   }
   }
   
   
   if(y==0){
	   var pname  = document.getElementById("pname").innerHTML;
		 var productPrice  = document.getElementById("price").innerHTML;
		 var productId  = document.getElementById("productId").innerHTML;
		 console.log(productId);
      var cartItem =  {
        title: pname,
        price: productPrice,
        qty: 1,
        prdId: productId
    };
    
    cart2.push(cartItem);
   }
   
   localStorage.setItem("cart", JSON.stringify(cart2));
   
   console.log("localstorage length : "+cart2.length);
  
    console.log("Newcart2[0].prdId: " +cart2[0].prdId)
   // console.log("Newcart2[1].prdId: " +cart2[1].prdId)
    console.log("NewQuantityPr1 : "+cart2[0].qty);
  //  console.log("NewQuantityPr2 : "+cart2[1].qty);
    
    
    if(cart2.length>1){
		console.log("Newcart2[1].prdId: " +cart2[1].prdId)
		 console.log("NewQuantityPr2 : "+cart2[1].qty);
		
		
	}
    
   
  /* var item  = cart2;
   console.log("localstorage: "+item.prdId);
   console.log("2");*/
   
  console.log("2");
   
	}
	console.log("Hello world!");
	
	
//	localStorage.clear();
	alert("Το προϊόν προστέθηκε στο Καλάθι σας!");
	
	window.location.href = "cart.jsp"
	
}




function myDeleteFunction() {
 	 localStorage.clear();
	window.location.href = "bookme.jsp"
}






/**
 * 
 */