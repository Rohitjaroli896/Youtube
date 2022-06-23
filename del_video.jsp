<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%  
    String code = request.getParameter("code");    
    String[] words = code.split("_",3);
    
    Cookie c[] = request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();                
            break;
        }
    }
    if(email != null && session.getAttribute(email) != null){
        if(request.getParameter("code").length()==0){
            out.print("Video code not found");
        }
        else{
                        
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                
                ResultSet rs = st.executeQuery("select * from video where status=0 AND code='"+code+"'");
                if(rs.next()){
                    if(st.executeUpdate("update video set status=1 where code='"+code+"'")>0){
                        response.sendRedirect("channel.jsp?success=1&code="+words[2]);
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
