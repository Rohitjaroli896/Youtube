<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();                
            break;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Video Upload</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/index.css">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <script src="https://use.fontawesome.com/09901d9403.js"></script>

  <style>
	#sidenav {
          margin-top: 55px;
	  height: 100%;	 
	  position: fixed;
	  z-index: 1;
	  top: 0;
	  left: 0;
	  background-color: #e3f2fd;
	  overflow-x: hidden;
	  padding-top: 20px;
	}

	#sidenav a {
	  padding: 6px 8px 6px 16px;
	  text-decoration: none;
	  font-size: 20px;
	  color:#253169;
	  display: block;
	}

	#sidenav a:hover {
	  color: #f1f1f1;
	}

	#main-block {
	  margin-left: 260px; /* Same as the width of the sidenav */	  
	  padding: 0px 10px;
	}

	@media screen and (max-height: 450px) {
	  #sidenav {padding-top: 15px;}
	  #sidenav a {font-size: 18px;}
	}
  </style>
</head>
<body>   
        <!--Nav bar-->
        <%@include file="navbar.jsp" %>
	<!--End nav bar-->
        
	<div class="container-fluid">
		<div class="row">
			<!--left sidebar-->
			<div class="col-sm-2" id="sidenav">
				<table class="table table-borderless">
					<tr><td><img src="user.jpg" class="img-fluid rounded-circle"></td></tr>
					<tr><td align="center">	<b>LOKESH DEV</b></td></tr>
				</table>
				<table class="table">
					<tr><td><a href="#">Home</a></td></tr>
					<tr><td><a href="#">Explore</a></td></tr>
					<tr><td><a href="#">History</a></td></tr>
					<tr><td><a href="#">Movies</a></td></tr>
					<tr><td><a href="#">Music</a></td></tr>
					<tr><td><a href="#">Liked videos</a></td></tr>
				</table>
			</div>
			<!--End left sidebar-->
			<!--main block-->
			<div class="col-sm-10" id="main-block">
				<div class="row">
					
					<!--content-->
                                        
					<!--End content-->
				</div>
			</div>
			<!--end main block-->
		</div>
	</div>


</body>
</html>