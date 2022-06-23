
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
        if(request.getParameter("code").length()==0){
            response.sendRedirect("dashboard.jsp?empty=1");
        }
        else{
            String code = request.getParameter("code");            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                
                ResultSet rs = st.executeQuery("select * from category where code='"+code+"'");
                if(rs.next()){
                    if(st.executeUpdate("update category set status=1 where code='"+code+"'")>0){
                        response.sendRedirect("dashboard.jsp?delsuccess=1");
                    }
                    else{
                        response.sendRedirect("dashboard.jsp?again=1");
                    }                     
                }                                                    
            }
            catch(Exception e){
                out.print(e.getMessage());
            }
        }
    }
%>
