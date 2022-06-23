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
#sidenav{
          margin-top: 65px;
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
          font-size: 19px;
	  color: yellowgreen;
	}

	#main-block {
	  margin-left: 260px; /* Same as the width of the sidenav */	  
	  padding: 0px 10px;
          margin-top: 40px;
	}       
	
        @media only screen and (max-width: 450px) and (max-height: 640px) {
            #sidenav{display: none;}
            #main-block{
                display: block;
                margin-left: 0px;
                padding: 0px;
            }
            #signModal,#myModal{
                height:80%;
                width: 80%;
                margin-top: 10%;
                margin-left: 10%;
            }
            #search{width: 90%;}
          #mycard{
              width: 100%;
          }
          .navbar{
              width: 100%;              
          }           
          .navbar-brand{margin-left: 10px;}
          
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
			 <%@include file="sidebar.jsp" %>                       
			<!--End left sidebar-->
                                               
                    <div class="col-sm-10" id="main-block">
                        <center>
                            <div class="row">
                                <!--main block-->                                
                                <%
                                    if(request.getParameter("success")!=null){ 
                                %>                                
                                <div class="col-sm-12" style="margin-top:100px;letter-spacing: 3px">
                                    <form method="post" action="upload_video.jsp?code=<%=code%>" name="uploadphoto" enctype="multipart/form-data" >		
                                        <table class="table table-borderless">
                                            <tbody>
                                                <tr>
                                                    <th><h1>Upload Video </h1></th>
                                                </tr>
                                                <tr>   
                                                    <td><br><br></td>
                                                </tr>
                                                <tr>
                                                    <th><h3>Select Video : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td><input type="file" name="video" class="w3-border-green form-control"></td>
                                                </tr>
                                                <tr>   
                                                    <td><br></td>
                                                </tr>                            
                                                <tr><td><input type="submit" value="Upload" class="form-control w3-border-blue"></td></tr>
                                            </tbody>
                                        </table>			    
                                    </form>
                                </div>  
                                <%
                                   }
                                    else{
                                %>                                
                                <div class="col-sm-12" style="margin-top:100px;letter-spacing: 3px">
                                    <form method="post" action="uploadvideoimg.jsp?code=<%=code%>" name="uploadphoto" enctype="multipart/form-data" >		
                                        <table class="table table-borderless">
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
                                                    <td><input type="file" name="photo" class="w3-border-green form-control"></td>
                                                </tr>
                                                <tr>   
                                                    <td><br></td>
                                                </tr>                            
                                                <tr><td><input type="submit" value="Upload" class="form-control w3-border-blue"></td></tr>
                                            </tbody>
                                        </table>			    
                                    </form>
                                </div>
                                <%
                                   }
                                %>
                                <!--end main block--> 
                            </div>
                        </center>
                    </div>
            </div>
	</div>

    </body>
</html>


