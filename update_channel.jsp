<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
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
    if(email != null || session.getAttribute(email) != null){                                                          

        if(request.getParameter("cname").trim().length()==0 || request.getParameter("category").trim().length()==0){
            response.sendRedirect("edit_channel.jsp?empty=1");
        }
        else{
            String cname = request.getParameter("cname");
            String category = request.getParameter("category");            
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from channel where channel_name='"+cname+"' AND category='"+category+"'");
                if(rs1.next()){
                    response.sendRedirect("edit_channel.jsp?exist=1&code="+code);
                }
                else{                       
                       PreparedStatement ps = cn.prepareStatement("update channel set channel_name=?,category=? where code=?");
                       ps.setString(1,cname);
                       ps.setString(2,category);
                       ps.setString(3,code);                       
                       
                       if(ps.executeUpdate()>0){
                           response.sendRedirect("channel.jsp?success=1&code="+code);
                       }
                       else{
                          response.sendRedirect("channel.jsp"); 
                       }   
                   }                  
                }
                catch(Exception e){
                    out.print(e.getMessage());
                } 
            }
    }
%>
