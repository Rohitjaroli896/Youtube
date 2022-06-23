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
                            <!--content-->	
                            <div class="row" style="margin-top:26px;display: flex;justify-content: center;align-items: center;border: 3px solid yellowgreen;height: 100px;width: 100%">
                                <p style="color: #666666;font-size: 26px;letter-spacing: 3px">Liked Videos</p>
                            </div>
					<%
                                            Statement st = cn.createStatement();
                                            ResultSet rs = st.executeQuery("select * from vlike where user_email='"+email+"'");                              
                                            while(rs.next()){
                                            
                                        %>
                                        <div class="row" style="margin-top:30px">
                                           <div class="col-sm-1"></div>
                                            <div class="col-sm-3">
                                                <a href="home.jsp?code=<%=rs.getString("code")%>"><img src="vphoto/<%=rs.getString("code")%>.jpg" class="img-fluid" style="width: 280px;height: 140px"></a>
                                            </div> 
                                            <div class="col-sm-6">
                                                <p style="padding-top:10px;font-size: 20px;letter-spacing: 1px"> <%=rs.getString("video_name")%></p>
                                                <a style="color:grey;font-size: 14px" href="channel_view.jsp?code=<%=rs.getString("ch_code")%>"><img src="cphoto/<%=rs.getString("ch_code")%>.jpg" style="height:25px;width:25px;border-radius: 50%" /></a>
                                            </div>
                                        </div>
                                        <%
                                            }
                                              
                                        %>
					<!--End content-->
                            
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