
<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%                                                                           
  Class.forName("com.mysql.jdbc.Driver");
  Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
  String code=request.getParameter("code");    

  Statement st1 = cn.createStatement();
  ResultSet rs1 = st1.executeQuery("select * from category where code='"+code+"'");
  
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/custom.css">
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	  <script src="https://use.fontawesome.com/09901d9403.js"></script>
        <title>Edit Categoty</title>
        
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
		<!--left sidebar-->
                <%@include file="sidebar.jsp"%>
                <!--end sidebar-->
                <!--main block-->
			<div class="col-sm-10" id="main-block">
				<div class="row">
					<!--Nav bar-->
                                        <%@include file="navbar.jsp" %>
					<!--End nav bar-->                                        
                                        <div class="col-sm-12" style="margin-top: 10px">
						<%
                                                    if(request.getParameter("success")!=null){
						%>
                                                   <div class="alert alert-success">Category updated Successfully</div>
						<%
                                                   }
                                                    else if(request.getParameter("exist")!=null){
						%>
                                                   <div class="alert alert-warning">Category already exist</div>
						<%
                                                   }
						%>
					</div>		
					<!--content-->					
					<div class="col-sm-12" style="margin-top: 5px">
						<div class="row">
							<div class="col-sm-12">
                                                            <%
                                                                if(rs1.next()){
                                                            %>
								<form method="post" action="update_category.jsp?code=<%=code%>">
									<h3 style="color: black">Edit Category :</h3>
									<input type="text" class="form-control" name="category" value="<%=rs1.getString("category_name")%>" required><br>
									<input type="submit" class="btn btn-primary" value="submit">
								</form>
                                                            <%
                                                                }  
                                                            %>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12" style="margin-top:50px">
								<h3 style="color:black">All Categories :</h3>
								<table class="table table-borderless">                                                                    
                                                                    <%
                                                                     Statement st = cn.createStatement();   
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
