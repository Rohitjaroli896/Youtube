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
    String video_name="";     
        
 
            try{ 
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from view where code='"+vcode+"' AND user_email='"+email+"'");
                if(rs1.next()){
                    out.print("not count views");
                }
                else{                   
                    Statement st = cn.createStatement(); 
                    ResultSet rs = st.executeQuery("select * from video where status=0 AND code='"+vcode+"'");
                    if(rs.next()){
                        video_name = rs.getString("video_name");                    
                    }
                    
                       PreparedStatement ps = cn.prepareStatement("insert into view values(?,?,?,?)");
                       ps.setString(1,vcode);
                       ps.setString(2,video_name);                                   
                       ps.setString(3,ch_code);
                       ps.setString(4,email);
                                              
                       if(ps.executeUpdate()>0){                           
                           out.print("success");
                       }
                       else{
                          out.print("failed");
                       } 
                }
            }
            catch(Exception e){
                out.print(e.getMessage());
            } 
%>




