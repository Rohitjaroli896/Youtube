<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<% 
    String code = request.getParameter("code");
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Channel</title>
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
                                               
                        <div class="col-sm-10">
                            <div class="row">
                                <!--main block-->
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4" id="main-block" style="margin-top:100px;letter-spacing: 3px">
                                    <form method="post" action="uploadphoto.jsp?code=<%=code%>" name="uploadphoto" enctype="multipart/form-data" >		
                                        <table width="25%" height="25%">
                                            <tbody>
                                                <tr>
                                                    <th><h1>Upload Image </h1></th>
                                                </tr>
                                                <tr>   
                                                    <td><br><br></td>
                                                </tr>
                                                <tr>
                                                    <th><h3>Select Image : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td><input type="file" name="uploadPic" style="border: 1px solid black"></td>
                                                </tr>
                                                <tr>   
                                                    <td><br></td>
                                                </tr>                            
                                                <tr><td><input type="submit" value="Upload" class="form-control w3-border-blue"></td></tr>
                                            </tbody>
                                        </table>			    
                                    </form>
                                </div>
                                <div class="col-sm-2"></div>
                                <!--end main block--> 
                            </div>
                        </div>
            </div>
	</div>

    </body>
</html>


