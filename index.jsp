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
  
  <script>
      $(document).ready(function(){
          $("#search-block").css("display","none");
      });
  </script>
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

	#main-block,#search-block {
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
<body id="main">
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
                            <div class="row">					
					<!--content-->					
					<%
                                            Statement st = cn.createStatement(); 
                                            Statement st1 = cn.createStatement();
                                            ResultSet rs = st.executeQuery("select * from video where status=0");                              
                                            while(rs.next()){
                                            ResultSet rs1 = st1.executeQuery("select * from channel where status=0 AND code='"+rs.getString("ch_code")+"'");
                                            if(rs1.next()){
                                        %>
                                        <div id="mycard" class="col-sm-3 w3-animate-zoom" style="margin-top:30px">
                                            <div class="w3-hover-shadow" style="border:1px solid greenyellow;padding: 3px 5px 15px 5px">
                                                <a href="home.jsp?code=<%=rs.getString("code")%>"><img src="vphoto/<%=rs.getString("code")%>.jpg" class="img-fluid" style="width: 400px;height: 180px"></a>

                                                <p style="padding-top:10px"> <%=rs.getString("Video_name")%></p>                                                

                                                <a style="color:grey" href="channel_view.jsp?code=<%=rs1.getString("code")%>"><img src="cphoto/<%=rs1.getString("code")%>.jpg" style="height:40px;width:40px;border-radius: 50%" /> <%=rs1.getString("channel_name")%></a>
                                            </div> 
                                        </div>
                                        <%
                                                }
                                            }  
                                        %>
					<!--End content-->
				</div>
			</div>
			<!--end main block-->
                        <div class="col-sm-10" id="search-block"> 
                        </div> 
		</div>
	</div> 
                                            <script src="js/index.js"></script>

    <script>
        $(document).on("click","#searchbtn",function(){
            var sdata= $("#search").val();
            $.post(
               "search.jsp",{sdata:sdata},function(data){
                   var result = data.trim();
                   $("#main-block").css("display","none");
                   $("#search-block").css("display","block");
                   $("#search-block").html(result); 
                }     
            );
        });
    </script>
</body>
</html>