<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
  Class.forName("com.mysql.jdbc.Driver");
  Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
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
<html lang="en">
<head>
  <title>Edit Channel</title>
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
          margin-top: 80px;
          letter-spacing: 3px;
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
                            <center>
                                <div class="row"> 
                                <%
                                    if(request.getParameter("exist")!=null){
                                        out.print("<div class='form-control alert alert-info'>Channel Already Exist</div>");
                                    }
                                    else if(request.getParameter("empty")!=null){
                                        out.print("<div class='form-control alert alert-warning'>All field Required</div>");
                                    }                                    
                                %>
                                </div>
                                <div class="row" style="margin-top:30px">
                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-6">
					<!--content-->
					<%					
					Statement st = cn.createStatement(); 
					ResultSet rs = st.executeQuery("select * from channel where status=0 AND code='"+code+"'");
                                        if(rs.next()){
					 %>
                                        <h1>Edit Your Channel</h1>
					<form method="post" action="update_channel.jsp?code=<%=code%>" style="margin-top: 20px">
                                                <label><h3>Channel Title/Name:</h3></label>
                                                <input type="text" name="cname" value="<%=rs.getString("channel_name")%>" placeholder="Enter Channel name" class="form-control">
                                                <label><h3>Select Channel Category:</h3></label><br>
						<select name="category" class="form-control">
                                                    <option value="<%=rs.getString("category")%>"><%=rs.getString("category")%></option>
                                                <%
                                                    ResultSet rs1 = st.executeQuery("select * from category where status=0");
                                                    while(rs1.next()){
                                                 %>
                                                 <option value="<%=rs1.getString("category_name")%>"><%=rs1.getString("category_name")%></option>
                                                <%
                                                    }
                                                %> 
						</select><br>
						<button class="w3-blue w3-animate-zoom form-control">Update Channel</button>
					</form>
                                        <%
                                            }
                                        %>
					<!--End content-->
                                    </div>
                                    <div class="col-sm-2"></div>
				</div> 
                            </center>
                        </div>
                </div>
        </div>
                                
</body>
</html>
