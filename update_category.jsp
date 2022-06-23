<%-- 
    Document   : update_category
    Created on : Sep 11, 2021, 12:09:12 AM
    Author     : lokes
--%>

<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%
    Cookie c[] = request.getCookies();
    String email = null;
    for(int i=0; i<c.length; i++){
        if(c[i].getName().equals("login")){
            email = c[i].getValue();                
            break;
        }
    }        
        
    if(email != null && session.getAttribute(email) != null){
        if(request.getParameter("category").length()==0 || request.getParameter("code").length()==0){
            response.sendRedirect("dashboard.jsp?empty=1");
        }
        else{            
            String category = request.getParameter("category");
            String code = request.getParameter("code");
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                     ResultSet rs = st.executeQuery("select * from category where category_name='"+category+"'");
                     if(rs.next()){
                        response.sendRedirect("edit.jsp?code="+code+"&exist=1");
                     }
                     else{
                         if(st.executeUpdate("update category set category_name='"+category+"' where code='"+code+"'")>0){
                             response.sendRedirect("edit.jsp?code="+code+"&success=1");
                         }
                         else{
                             response.sendRedirect("edit.jsp?code="+code+"&again=1");
                         }
                     }
            }
            catch(Exception e){
                out.print(e.getMessage());
            }
        }
    }
%>