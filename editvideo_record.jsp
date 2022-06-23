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
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
    Statement st = cn.createStatement();                               
       
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
                                               
                        <div class="col-sm-10">                            
                            <div class="row">
                                <!--main block-->
                                <div class="col-sm-2"></div>
                                <div class="col-sm-6" id="main-block" style="margin-top:80px;letter-spacing: 3px">
                                    <center>
                                        <div class="row"> 
                                        <%
                                            if(request.getParameter("exist")!=null){
                                                out.print("<div class='form-control alert alert-info'>Video Name Already Exist</div>");
                                            }
                                            else if(request.getParameter("empty")!=null){
                                                out.print("<div class='form-control alert alert-warning'>All field Required</div>");
                                            }                                    
                                        %>
                                        </div>
                                        <%
                                            ResultSet rs = st.executeQuery("select * from video where status=0 AND code='"+code+"'");
                                            if(rs.next()){ 
                                        %>
                                    <form method="post" action="editvideoprocess.jsp?code=<%=code%>" name="uploadvideo">		
                                        <table class="table table-borderless">
                                            <tbody>
                                                <tr>
                                                    <th><h1>Edit Video </h1></th>
                                                </tr>                                                
                                                <tr>
                                                    <th><h3>Video Title : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td><input type="text" name="vtitle" value="<%=rs.getString("video_name")%>" class="w3-border-green form-control"></td>
                                                </tr>
                                                <tr>
                                                    <th><h3>Description : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td><input type="text" name="description" value="<%=rs.getString("description")%>" class="w3-border-green form-control"></td>
                                                </tr>
                                                <tr>
                                                    <th><h3>Channel Name : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td>
                                                        <select name="cname" class="w3-border-green form-control">
                                                            <option value="<%=rs.getString("channel_name")%>"><%=rs.getString("channel_name")%></option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th><h3>Category : </h3></th>
                                                </tr>
                                                <tr>   
                                                    <td>
                                                        <select name="category" class="w3-border-green form-control">
                                                            <option value="<%=rs.getString("category")%>"><%=rs.getString("category")%></option>
                                                        </select>
                                                </tr>
                                                <tr>   
                                                    <td><br></td>
                                                </tr>                            
                                                <tr><td><input type="submit" value="Edit" class="form-control w3-border-blue"></td></tr>
                                            </tbody>
                                        </table>			    
                                    </form>
                                    <%
                                        }
                                    %>
                                    </center>
                                </div>
                                <div class="col-sm-2"></div>
                                <!--end main block--> 
                            </div>                            
                        </div>
            </div>
	</div>

    </body>
</html>



