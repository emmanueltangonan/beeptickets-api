//border-bottom color of nav
function getPageName(url) {
    var index = url.lastIndexOf("/") + 1;
    var filenameWithExtension = url.substr(index);
    var filename = filenameWithExtension.split(".")[0]; // <-- added this line
    return filename;                                    // <-- added this line
}
//NAV BAR RESIZE ON SCROLL
$(document).scroll(function() {
	  if ($(this).scrollTop() > 50) { //Adjust 150
	    $('#head').addClass('shrinked');
	    $('li').css('padding-top','0');
//	    $('a.nav-li-elem').css('height','50px');
	    $('#logo-div').css('height','50px');
	    $('#nav-container-div').css('height','50px');
	    $('.nav-div').css('height','50px');
	    $('li.nav-menu-btn').css('margin-top', '-15px');
	    $('li.nav-menu-li').css('height','50px');
	    $('a.navbar-brand.logo-text').css('margin','0px');
	    $('a.navbar-brand.logo-text').css('margin-left','-10px');
	    $('img#img-logo').css('margin-top', '-10px');
	    $('img#img-logo').css('height', '40px');
	    $('img#img-logo').css('width', '40px');
	    $('#head').css('height', '40px');
	    $('.sidenav').css('margin-top', '40px');
	    $('#v-nav-title').css('margin-top', '-62px');
	  } else {
	    $('#head').removeClass('shrinked');
	    $('li').css('padding-top','25px');
	    $('li.nav-menu-btn').css('margin-top', '-15px');
//	    $('a.nav-li-elem').css('height','100px');
	    $('li.nav-menu-li').css('height','100px');
	    $('#logo-div').css('height','100px');
	    $('.nav-div').css('height','100px');
	    $('#nav-container-div').css('height','100px');
	    $('a.navbar-brand.logo-text').css('margin-top','25px');
	    $('a.navbar-brand.logo-text').css('margin-left','0px');
	    $('img#img-logo').css('margin-top', '0px');
	    $('img#img-logo').css('height', '80px');
	    $('img#img-logo').css('width', '80px');
	    $('#head').css('height', '100px');
	    $('.sidenav').css('margin-top', '90px');
	    $(' #v-nav-title').css('margin-top', '-20px');
	  }
});


$(".border-bottom").click(function() {
	var link_id = $(this).prop('id');
	var index = link_id.length - 5;
	
	var div_id = link_id.substring(0, index);
    $('html,body').animate({
        scrollTop: $("#" + div_id).offset().top - 50},
        'fast');
});


//slider on homepage
$(function(){
	$('.main-content').slick({
		dots: true,
		infinite: true,
		speed: 500,
		fade: true,
		cssEase: 'linear',
		autoplay: true,
		autoplaySpeed: 2000,
		speed: 300,
		adaptiveHeight: true
	});
	
	  var currentPageName = getPageName(window.location.pathname);
	  currentPageName = currentPageName == "" ? "home" : currentPageName;
	  $('#' + currentPageName).addClass('clicked');
	  $('#' + currentPageName).children().css( "color", "#fecb71" );
	   
	  $('.nav-menu-li').hover(
	  function(){
		  $(this).children().css( "color", "#fecb71" );
	  },
	  function(){
		  if($(this).attr('id') == currentPageName){
			  return false;
		  }else{
			  $(this).children().css( "color", "white" );
		  }
		
	  });
	  
});



//GOOGLE SIGN IN
function onLoadGoogleCallback(){
	  gapi.load('auth2', function() {
	    auth2 = gapi.auth2.init({
	      client_id: '239246160174-v00ck40rsicn72n9d21642v0gpdf2q0s.apps.googleusercontent.com',
	      cookiepolicy: 'single_host_origin',
	      scope: 'profile'
	    });

	  auth2.attachClickHandler(element, {},
	    function(googleUser) {
	        console.log('Signed in: ' + googleUser.getBasicProfile().getName());
	        console.log(JSON.stringify(googleUser.getBasicProfile()));
	        var json = {};
	        json["name"] = googleUser.getBasicProfile().getName();
	        json["email"] = "google-" + googleUser.getBasicProfile().getId();
	        json["password"] = "google-" + googleUser.getBasicProfile().getId();
	        
	        $.ajax({
				type: "POST",
				data: json,
				url: "googleLogin",
				success: function(response){
					window.location.replace("dev");
				}
	        });
	        
	      }, function(error) {
	        console.log('Sign-in error', error);
	      }
	    );
	  });

	  element = document.getElementById('googleSignIn');
}
//FACEBOOK SIGN IN
window.fbAsyncInit = function() {
	FB.init({
	  appId      : '1160700520694663',
	  xfbml      : true,
	  version    : 'v2.8'
	});
	
};

(function(d, s, id){
	 var js, fjs = d.getElementsByTagName(s)[0];
	 if (d.getElementById(id)) {return;}
	 js = d.createElement(s); js.id = id;
	 js.src = "//connect.facebook.net/en_US/sdk.js";
	 fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));

function fb_login(){
	  FB.login(function(response) {
		    if (response.authResponse) {
		     console.log('Welcome!  Fetching your information.... ');
		     FB.api('/me/?fields=id,name,first_name,last_name,email,permissions', function(response) {
		    	$.ajax({
						type: "POST",
						data: response,
						url: "fbLogin",
						success: function(response){
							window.location.replace("dev");
						}
			 	});
		     });
		    } else {
		     console.log('User cancelled login or did not fully authorize.');
		    }
		}, {
	        scope: 'email'
	    });
}
$(function(){
	  $('#fb-a').click(function(){
		  fb_login();
	  });
});

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("docs-main").style.marginLeft = "250px";
    $('#v-nav-title').prop('hidden', true);
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("docs-main").style.marginLeft= "0";
    $('#v-nav-title').prop('hidden', false);
}


