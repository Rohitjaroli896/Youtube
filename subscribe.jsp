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
    String code = request.getParameter("code");
    String channel_name="";    
    
    if(email != null || session.getAttribute(email) != null){  
            try{ 
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                
                Statement st2 = cn.createStatement();                
                ResultSet rs2 = st2.executeQuery("select * from subscribe where ch_code='"+code+"' AND user_email='"+email+"'");
                
                if(rs2.next()){                
                    Statement st1 = cn.createStatement();                
                    if(st1.executeUpdate("delete from subscribe where ch_code='"+code+"'")>0){
                        out.print("deleted");
                    }
                    else{
                        out.print("del failed");
                    }                        
                }
                else{                    
                    Statement st = cn.createStatement();                
                    ResultSet rs = st.executeQuery("select * from channel where status=0 AND code='"+code+"'");
                    if(rs.next()){
                        channel_name = rs.getString("channel_name");                    
                    }

                    int sn=0;

                    ResultSet rs1 = st.executeQuery("select MAX(sn) from subscribe");

                       if(rs1.next()){
                           sn = rs1.getInt(1);
                       }
                       sn++;
                    
                       PreparedStatement ps = cn.prepareStatement("insert into subscribe values(?,?,?,?)");                       
                       ps.setInt(1,sn);
                       ps.setString(2,code);
                       ps.setString(3,channel_name);                                   
                       ps.setString(4,email);
                       
                       if(ps.executeUpdate()>0){                           
                           out.print("success");
                       }
                       else{
                          out.print("subscribe failed");
                       }
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
