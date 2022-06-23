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
        if(request.getParameter("vtitle").trim().length()==0 || request.getParameter("description").trim().length()==0 || request.getParameter("cname").trim().length()==0 || request.getParameter("category").trim().length()==0){
            response.sendRedirect("editvideo_record.jsp?empty=1&code="+code);            
        }
        else{            
            String vtitle = request.getParameter("vtitle");
            String description = request.getParameter("description");
            String cname = request.getParameter("cname");
            String category = request.getParameter("category");  
            String ch_code = request.getParameter("code");           
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from video where video_name='"+vtitle+"' AND description='"+description+"' AND channel_name='"+cname+"' AND category='"+category+"'");
                if(rs1.next()){
                    response.sendRedirect("editvideo_record.jsp?exist=1&code="+code);
                }
                else{                       
                       PreparedStatement ps = cn.prepareStatement("update video set video_name=?,description=?,channel_name=?,category=? where code=?");
                       ps.setString(1,vtitle);
                       ps.setString(2,description);
                       ps.setString(3,cname);
                       ps.setString(4,category);
                       ps.setString(5,code);                       
                       
                       if(ps.executeUpdate()>0){
                           response.sendRedirect("video_img.jsp?code="+code);
                       }
                       else{
                          response.sendRedirect("channel.jsp?again=1"); 
                       }   
                   }                  
                }
                catch(Exception e){
                    out.print(e.getMessage());
                } 
            }
    }
%>

