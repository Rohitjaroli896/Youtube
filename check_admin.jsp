
<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>
<%    
    if(request.getParameter("email").trim().length()==0 || request.getParameter("password").trim().length()==0){
        response.sendRedirect("login.jsp?empty=1"); 
    }
    else{
        String email = request.getParameter("email");          
        String pass = request.getParameter("password");
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select * from admin where email='"+email+"'");
                
                if(rs.next()){
                    if(rs.getString("password").equals(pass)){
                        Cookie ct = new Cookie("login",email);
                        ct.setMaxAge(3600);
                        response.addCookie(ct);
                        session.setAttribute(email,pass);
                        session.setMaxInactiveInterval(3600);
                        response.sendRedirect("dashboard.jsp");
                    }
                    else{
                        response.sendRedirect("login.jsp?invalid_pass=1");
                    }
                }
                else{
                    response.sendRedirect("login.jsp?invalid_id=1");
                }
            }
            catch(Exception e){
                out.print(e.getMessage());
            }
    }
%>
