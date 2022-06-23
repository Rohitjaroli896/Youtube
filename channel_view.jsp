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
			<div class="col-sm-10" id="main-block" style="margin-top:100px;letter-spacing: 3px">
                            <center>
                            
                            <%
                                Class.forName("com.mysql.jdbc.Driver");
				Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                                Statement st = cn.createStatement();
                                
                                ResultSet rs = st.executeQuery("select * from channel where status=0 AND code='"+code+"'");                                
                                                                   
                                    if(rs.next()){
                                    %>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-4">
                                            <img src="cphoto/<%=rs.getString("code")%>.jpg" style="height:250px;width:300px;border-radius: 10%" class="img-fluid" />  
                                        </div>
                                        
                                        <div class="col-sm-4">
                                                <table class='table table-borderless'>
                                                    <tr><th>Channel :</th><td><%=rs.getString("channel_name")%></td></tr>
                                                    <tr><th>Category :</th><td><%=rs.getString("category")%></td></tr>
                                                </table>
                                        </div>                                    
                                    </div>
                                    <div class="row" style="margin-top:50px">
                                        <div class="col-sm-12"><h1>Videos :</h1></div>
                                        <%
                                            Statement st2 = cn.createStatement();                                
                                            ResultSet rs2 = st2.executeQuery("select * from video where status=0 AND ch_code='"+code+"'");                              
                                            while(rs2.next()){
                                            
                                        %>
                                        <div class="col-sm-3">
                                            <table class="table table-borderless w3-card-2">
                                                <tr><td><a href="home.jsp?code=<%=rs2.getString("code")%>"><img src="vphoto/<%=rs2.getString("code")%>.jpg" class="img-fluid" style="width: 300px;height: 180px"></a></td></tr>
						<tr><td><%=rs2.getString("Video_name")%> <br><%=rs2.getString("description")%></td></tr>
                                            </table>
                                        </div>
                                        <%
                                            }  
                                        %>                                       
                                    </div>
                                    <%
                                        }

                                    %>
				<!--End content-->
                            </center>
                        </div>
                        <div class="col-sm-2"></div>
                </div>
	</div>			
			<!--end main block-->                       
		
    </body>
</html>

