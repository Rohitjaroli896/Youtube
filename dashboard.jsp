
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();                
            break;
        }
    }        
        
    if(email != null && session.getAttribute(email) != null){
        try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();            
                
                email = request.getParameter("email");
%>   
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
          <link rel="stylesheet" href="../css/custom.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	  <script src="https://use.fontawesome.com/09901d9403.js"></script>
	
  
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!--left sidebar-->
			<div class="col-sm-2" id="sidenav">
				<table class="table table-borderless">					
					<tr><td align="center"><h4 style="letter-spacing: 3px;border: 
						2px solid #DF161A;padding: 8px 0px 8px 0px">Dashboard</h4></td></tr>
				</table>
				<hr>
				<table class="table table-borderless">
					<tr><td><a href="dashboard.jsp"><i class="fa fa-home" aria-hidden="true"></i> Home</a></td></tr>
					
					<tr><td><a href="#"><i class="fa fa-th-list" aria-hidden="true"></i> Categories</a></td></tr>
				</table>
			</div>
			<!--End left sidebar-->
			<!--main block-->
			<div class="col-sm-10" id="main-block">
				<div class="row">
					<!--Nav bar-->
					<div class="col-sm-12">
						<nav class="navbar navbar-expand-sm navbar-dark">
						  <ul class="navbar-nav">
							<li class="nav-item active">
							  <a class="nav-link" href="#">You Tube</a>
							</li>														
						  </ul>
						</nav>
					</div>
					<!--End nav bar-->
                                        <div class="col-sm-12" style="margin-top: 10px">
						<%
                                                    if(request.getParameter("success")!=null){
						%>
                                                   <div class="alert alert-success">Category added Successfully</div>
						<%
                                                   }
                                                    else if(request.getParameter("delsuccess")!=null){
						%>
                                                   <div class="alert alert-success">Category deleted Successfully</div>
						<%
                                                   }
						%>
					</div>
							
					<!--content-->					
					<div class="col-sm-12" style="margin-top: 5px">
						<div class="row">
							<div class="col-sm-12">
								<form method="post" action="add_category.jsp">
									<h3 style="color: black">Enter Category :</h3>
									<input type="text" class="form-control" name="category" required><br>
									<input type="submit" class="btn btn-primary" value="submit">
								</form>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12" style="margin-top:50px">
								<h3 style="color:black">All Categories :</h3>
								<table class="table table-borderless">
                                                                    <%
                                                                     ResultSet rs = st.executeQuery("select * from category where status=0");
                                                                     while(rs.next()){
                                                                    %>
									<tr>
                                                                            <td style="color:black"><%=rs.getString("category_name")%></td>										
										<td><a href="edit.jsp?code=<%=rs.getString("code")%>">Edit <i class="fa fa-edit" style="color:blue"></i></a></td>
										<td><a href="delete.jsp?code=<%=rs.getString("code")%>">Delete <i class="fa fa-trash" style="color:red"></i></a></td>
									</tr>
                                                                    <%
                                                                     }   
                                                                    %>    
								</table>
							</div>
						</div>
					</div>
					<!--End content-->
				</div>
			</div>
			<!--end main block-->
		</div>
	</div>
</body>
</html>
<%        
    }
    catch(Exception e){
        out.print(e.getMessage());
        //response.sendRedirect("login.jsp?exception=1"); 
    }        
}
else{
    response.sendRedirect("login.jsp?session=1");
}
%> 