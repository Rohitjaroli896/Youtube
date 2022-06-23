<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%     
    String code = request.getParameter("code");
    String[] words = code.split("_",3);
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");  
    Statement st1 = cn.createStatement();                                
    ResultSet rs1 = st1.executeQuery("select * from video where status=0 AND code='"+code+"'");
    
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
  <link rel="stylesheet" href="css/index.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  
  <script src="https://use.fontawesome.com/09901d9403.js"></script>  
  <script src="js/index.js"></script>  
  <script>
    $(document).ready(function(){
        $("#commentrecord").css("display","none");
        var ch_code=$("#<%=words[2]%>").attr("id"); 
        var vcode = $(".fa.fa-thumbs-o-down").attr("rel");
        $.ajax({
            url:'view.jsp',
            type:'POST',
            data:{vcode:vcode,ch_code:ch_code},
        
            success:function(result){                
                countview();
            }            
        });             
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
               padding: 5px 0px 0px 0px;
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
				<div class="row">                                    
                                
                                <!--video-->
                                <%
                                    if(rs1.next()){
                                %>
                                <div class="col-sm-8" style="margin-top: 22px">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <video autoplay controls width="100%" height="100%">
                                                        <source src="video/<%=code%>.mp4" type="video/mp4">                                                                    
                                                    </video>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table">   
                                                        <tr><td><h3><%=rs1.getString("video_name")%> | <%=rs1.getString("description")%></h3><span style="color:gray;font-size: 12px" id="view"></span></td></tr>
                                                        
                                                        <%  
                                                            ResultSet rs2 = st1.executeQuery("select * from channel where code='"+rs1.getString("ch_code")+"'");                                                         
                                                            if(rs2.next()){
                                                        %>
                                                        <tr>
                                                            <td>
                                                                <table class="table table-borderless">
                                                                <tr>
                                                                    <td rowspan="3">
                                                                        <a href="channel_view.jsp?code=<%=rs2.getString("code")%>"><img src="cphoto/<%=rs2.getString("code")%>.jpg" style="height:40px;width:40px;border-radius: 50%" /></a>
                                                                    </td>                                                                    
                                                                </tr>
                                                                <tr>
                                                                    <td style="width:87%">                                                                
                                                                        <a href="channel_view.jsp?code=<%=rs2.getString("code")%>"><%=rs2.getString("channel_name")%></a><br>
                                                                        <span style="color:gray;font-size: 12px" id="subcount"> </span>
                                                                    </td>
                                                                </tr>                                                                
                                                                </table>
                                                            </td>
                                                            <td style="cursor:pointer"><i class="fa fa-heart-o fa-2x" id="favourite" aria-hidden="true"></i></td>
                                                            <td style="cursor:pointer"><i class="fa fa-thumbs-o-up fa-2x" id="<%=code%>" aria-hidden="true"></i><span id="likecount"> </span></td>
                                                            <td style="cursor:pointer"><i class="fa fa-thumbs-o-down fa-2x" rel="<%=code%>" aria-hidden="true"></i><span id="dislikecount"> </span></td>
                                                            <td>                                                                
                                                                <button class="w3-red" id="<%=rs2.getString("code")%>" style="padding:7px 15px 7px 15px;font-size:17px;float: right">Subscribe</button>
                                                            </td>                                                                                                                        
                                                        </tr>                                                       
                                                        <%
                                                           }
                                                        %>
                                                        <tr><td style="color:gray;font-size: 18px"><span id="commentcount"></span>Comments</td></tr>
                                                        <tr><td><textarea rows="2" cols="50" placeholder="Enter your comment..."></textarea></td></tr>
                                                        <tr><td><button id="comment" class="btn btn-primary" style="padding: 5px 10px 5px 10px">COMMENT</button></td></tr>
                                                    </table>                                                        
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-12" id="commentrecord"></div>        
                                            </div>
                                            <div class="row">
                                            <%  
                                                Statement st4 = cn.createStatement();
                                                ResultSet rs4 = st4.executeQuery("select * from comment where code='"+code+"' order by dt desc");                                                         
                                                while(rs4.next()){
                                            %> 
                                                <div class="col-sm-12">
                                                    <table class="table table-borderless">
                                                        <tr><td><%=rs4.getString("user_email")%><span style='color:gray;font-size:10px'> (<%=rs4.getString("dt")%>)</span></td></tr>
                                                        <tr><td><%=rs4.getString("comment")%></td></tr>
                                                    </table>
                                                </div> 
                                            <%  }
                                            %>
                                            </div>
                                    </div>
                                    <% 
                                        }
                                    %>
                                    <!--end video-->
                                    <div class="col-sm-4" style="margin-top: 15px">                                            
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <h3> &nbsp;&nbsp;Up next</h3>
                                                </div>
                                                <%
                                                    Statement st = cn.createStatement(); 
                                                    Statement st3 = cn.createStatement();
                                                    ResultSet rs = st.executeQuery("select * from video where status=0 AND code<>'"+code+"'");                                                     
                                                    while(rs.next()){
                                                        ResultSet rs3 = st3.executeQuery("select * from channel where status=0 AND code='"+rs.getString("ch_code")+"'");
                                                        if(rs3.next()){
                                                %>
                                                    <div class="col-sm-12">
                                                        <table class="table table-borderless">
                                                            <tr>
                                                                <td rowspan="3">
                                                                    <a href="home.jsp?code=<%=rs.getString("code")%>"><img src="vphoto/<%=rs.getString("code")%>.jpg" class="img-fluid" style="width: 180px;height: 90px"></a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:50%"><%=rs.getString("Video_name")%><br><%=rs.getString("description")%></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width:50%;font-size: 14px;color: grey"><a href="channel_view.jsp?code=<%=rs3.getString("code")%>"><%=rs3.getString("channel_name")%></a></td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                <%
                                                        }
                                                    }  
                                                %>
                                            </div>
                                        </div>
                                </div>
			</div>
				<!--Sports-->
                                
		</div>
			<!--end main block-->
	</div>
	 
  <script>
    countsub();
    countlike();
    countdislike();
    countcomment();
    countview();
    
    function countsub(){
        var ch_code=$("#<%=words[2]%>").attr("id"); 
        $.ajax({
            url:'count.jsp',
            type:'POST',
            data:{code:ch_code},
        
            success:function(result){                
                $("#subcount").html(result);
            }
        });
    }
    
    function countlike(){
        var vcode=$(".fa.fa-thumbs-o-up.fa-2x").attr("id");
        $.ajax({
            url:'count.jsp',
            type:'POST',
            data:{vcode:vcode},
        
            success:function(result){
                $("#likecount").html(result);
            }
        });
    }
    
    function countdislike(){
        var vcode=$(".fa.fa-thumbs-o-down.fa-2x").attr("rel");
        $.ajax({
            url:'count.jsp',
            type:'POST',
            data:{dcode:vcode},
        
            success:function(result){
                $("#dislikecount").html(result);
            }
        });
    }
    
    function countcomment(){
        var ccode=$(".fa.fa-thumbs-o-down.fa-2x").attr("rel");
        $.ajax({
            url:'count.jsp',
            type:'POST',
            data:{ccode:ccode},
        
            success:function(result){
                $("#commentcount").html(result);
            }
        });
    }

    function countview(){
        var vcode=$(".fa.fa-thumbs-o-down.fa-2x").attr("rel");
        $.ajax({
            url:'count.jsp',
            type:'POST',
            data:{cview:vcode},
        
            success:function(result){                
                $("#view").html(result);
            }
        });
    }
    
    $(document).on("click","#<%=words[2]%>",function(){
        var ch_code=$(this).attr("id"); 
	$.post(
            "subscribe.jsp",{code:ch_code},function(data){                
                if(data.trim() == "success"){  
                    
                    $("#<%=words[2]%>").text("Unsubscribe");                    
                    $("#<%=words[2]%>").attr("class","w3-gray");
                }
                else if(data.trim() == "deleted"){
                    $("#<%=words[2]%>").text("Subscribe");                    
                    $("#<%=words[2]%>").attr("class","w3-red");
                } 
                countsub();
            }
	);    
    }); 
 
    $(document).on("click",".fa.fa-thumbs-o-up",function(){
        var vcode = $(this).attr("id"); 
        var ch_code=$("#<%=words[2]%>").attr("id");         
	$.post(          
            "like.jsp",{vcode:vcode,ch_code:ch_code},function(data){
                if(data.trim() == "success" || data.trim() == "deletedsuccess"){ 
                    $(".fa.fa-thumbs-o-up").css("color","blue");
                }
                else if(data.trim() == "deleted"){
                    $(".fa.fa-thumbs-o-up").css("color","black"); 
                }
                if(data.trim() == "deletedsuccess"){
                    $(".fa.fa-thumbs-o-down").css("color","black"); 
                }
                countlike();                
                countdislike();
            }
	);    
    });
    
    $(document).on("click",".fa.fa-thumbs-o-down",function(){
        var vcode = $(this).attr("rel"); 
        var ch_code=$("#<%=words[2]%>").attr("id"); 
        
	$.post(          
            "dislike.jsp",{vcode:vcode,ch_code:ch_code},function(data){
                if(data.trim() == "success" || data.trim() == "deletedsuccess"){ 
                    $(".fa.fa-thumbs-o-down").css("color","red");
                }
                else if(data.trim() == "deleted"){
                    $(".fa.fa-thumbs-o-down").css("color","black"); 
                }
                if(data.trim() == "deletedsuccess"){
                    $(".fa.fa-thumbs-o-up").css("color","black"); 
                }
                countlike();
                countdislike();
            }
	);    
    });
    
    $(document).on("click","#comment",function(){
        var cvalue = $("textarea").val();         
        var ch_code=$("#<%=words[2]%>").attr("id"); 
        var vcode = $(".fa.fa-thumbs-o-down").attr("rel");
        $.ajax({
            url:'comment.jsp',
            type:'POST',
            data:{cvalue:cvalue,vcode:vcode,ch_code:ch_code},
        
            success:function(result){
                $("#commentrecord").css("display","block");
                $("#commentrecord").html(result);
                countcomment();
            }            
        });        
    });
           
    $(document).on("click","#favourite",function(){        
        var vcode=$(".fa.fa-thumbs-o-down").attr("rel");
        var ch_code=$("#<%=words[2]%>").attr("id");
	$.post(
            "favourite.jsp",{vcode:vcode,ch_code:ch_code},function(data){
                if(data.trim() == "success"){  
                    $("#favourite").attr("class","fa fa-heart fa-2x"); 
                }
                else if(data.trim() == "deleted"){                    
                    $("#favourite").attr("class","fa fa-heart-o fa-2x");
                }
            }
	);    
    });     
  </script>

</body>
</html>