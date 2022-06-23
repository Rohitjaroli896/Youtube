
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
        
    if(email != null && session.getAttribute(email) != null){
        if(request.getParameter("category").length()==0){
            response.sendRedirect("dashboard.jsp?empty=1");
        }
        else{
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();

                String category = request.getParameter("category");
                ResultSet rs1 = st.executeQuery("select * from category where category_name='"+category+"'");
                
                if(rs1.next()){
                    if(rs1.getInt("status")==1){
                        if(st.executeUpdate("update category set status=0 where category_name='"+category+"'")>0){
                            response.sendRedirect("dashboard.jsp?success=1");
                        }
                    }
                    else{
                        response.sendRedirect("dashboard.jsp?exist=1");
                    }
                }
                else{
                    int sn=0; 
                    int status=0;            

                        ResultSet rs = st.executeQuery("select MAX(sn) from category");

                        if(rs.next()){
                            sn = rs.getInt(1);
                        }
                        sn++;

                        String code ="";
                        LinkedList l = new LinkedList();

                        for(char i='A'; i<='Z'; i++){
                            l.add(String.valueOf(i));            
                        }

                        for(char i='a'; i<='z'; i++){
                            l.add(String.valueOf(i));
                        }

                        for(int i=0; i<=9; i++){
                            l.add(i);		
                        }

                        Collections.shuffle(l);       
                        for(int i=0; i<=5; i++){
                            code=code+l.get(i);
                        }
                        code = code+"_"+sn;
                        
                        PreparedStatement ps = cn.prepareStatement("insert into category values(?,?,?,?)");
                        ps.setInt(1,sn);
                        ps.setString(2,code);
                        ps.setString(3,category);
                        ps.setInt(4,status);

                        if(ps.executeUpdate()>0){
                            response.sendRedirect("dashboard.jsp?success=1");
                        }
                        else{
                            response.sendRedirect("register.jsp?again=1");
                        }   
                }
            }
            catch(Exception e){

                out.print(e.getMessage());
            }
        }
    }
    else{
        response.sendRedirect("login.jsp?session=1");
    }
%>

