<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
  Class.forName("com.mysql.jdbc.Driver");
  Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root",""); 
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
  <title>You Tube</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="css/index.css">
  
 <script src="https://kit.fontawesome.com/eed8a09782.js" crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  
  <script src="https://use.fontawesome.com/09901d9403.js"></script>
  <script src="js/index.js"></script>
  
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
        <!--Modal-->
        <%@include file="modal.jsp" %>
        <!--End Modal-->
    
        <!--Nav bar-->
        <%@include file="navbar.jsp" %>
	<!--End nav bar-->
        
	<div class="container-fluid">
		<div class="row">
			<!--left sidebar-->
			 <%@include file="sidebar.jsp" %>
			<!--End left sidebar-->
			<!--main block-->
			<div class="col-sm-10" id="main-block">
                            <div class="row" style="justify-content:center;margin-top: 55px;">
                                <h2>My Channels</h2>
                            </div>
                            
                                <%
                                    Statement st = cn.createStatement();
                                    ResultSet rs = st.executeQuery("select * from channel where status=0 AND email='"+email+"'");
                                    while(rs.next()){
                                %>                                        
                                <div class="row" style="margin-top:40px">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-4">
                                            <img src="cphoto/<%=rs.getString("code")%>.jpg" style="height:250px;width:300px;border-radius: 10%" class="img-fluid" />  
                                        </div>
                                        
                                        <div class="col-sm-4">
                                                <table class='table table-borderless'>
                                                    <tr><th>Channel :</th><td><%=rs.getString("channel_name")%></td></tr>
                                                    <tr><th>Category :</th><td><%=rs.getString("category")%></td></tr>
                                                    <tr>
                                                        <th>Go To Channel :</th>
                                                        <td><a href="channel.jsp?success=1&code=<%=rs.getString("code")%>"><button class="w3-border-blue"><i class="fa fa-eye" aria-hidden="true"></i> View Channel</button></a></td>
                                                    </tr>
                                                </table>
                                        </div>                                    
                                    </div>
                                <%
                                    }
                               %>
                               
                        </div>
                </div>
        </div>
                                
</body>
</html>
