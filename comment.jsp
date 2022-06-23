<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%    
    Cookie c[] = request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();                
            break;
        }        
    }
    String vcode = request.getParameter("vcode");
    String ch_code = request.getParameter("ch_code");
    String cvalue = request.getParameter("cvalue");
    String video_name=""; 
    
    java.util.Date d = new java.util.Date();
    String dt = " "+d;
    
    if(email != null || session.getAttribute(email) != null){  
            try{ 
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                
                Statement st = cn.createStatement(); 
                    ResultSet rs = st.executeQuery("select * from video where status=0 AND code='"+vcode+"'");
                    if(rs.next()){
                        video_name = rs.getString("video_name");                    
                    }
                    
                       PreparedStatement ps = cn.prepareStatement("insert into comment values(?,?,?,?,?,?)");
                       ps.setString(1,vcode);
                       ps.setString(2,video_name);                                   
                       ps.setString(3,ch_code);
                       ps.setString(4,email);
                       ps.setString(5,cvalue);
                       ps.setString(6,dt);
                       
                       if(ps.executeUpdate()>0){                           
                           out.print("<p>"+email+"<span style='color:gray;font-size:10px'> ("+dt+")</span></p><pre>&nbsp;&nbsp;"+cvalue+"</pre>");
                       }
                       else{
                          out.print("Dislike failed");
                       }                
            }
            catch(Exception e){
                out.print(e.getMessage());
            }          
    }
    else{
        out.print("try again");
    }
%>



