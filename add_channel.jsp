<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    String code ="";
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
            response.sendRedirect("channel.jsp?empty=1");
        }
        else{
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st = cn.createStatement();
                
                String cname = request.getParameter("cname");
                String category = request.getParameter("category"); 
                
                ResultSet rs = st.executeQuery("select * from channel where channel_name='"+cname+"' AND category='"+category+"'");
                if(rs.next()){
                    if(rs.getInt("status")==1){
                        code = rs.getString("code");
                        if(st.executeUpdate("update channel set status=0 where channel_name='"+cname+"' AND category='"+category+"'")>0){
                            response.sendRedirect("channel.jsp?success=1&code="+code);
                        }
                    }
                    else{
                        response.sendRedirect("channel.jsp?exist=1");
                    }
                }
                else{
                       
                    int sn=0;
                    int status = 0;

                       ResultSet rs1 = st.executeQuery("select MAX(sn) from channel");

                       if(rs1.next()){
                           sn = rs1.getInt(1);
                       }
                       sn++;
                    
                       code ="";
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

                       PreparedStatement ps = cn.prepareStatement("insert into channel values(?,?,?,?,?,?)");
                       ps.setInt(1,sn);
                       ps.setString(2,code);
                       ps.setString(3,email);
                       ps.setString(4,cname);
                       ps.setString(5,category);            
                       ps.setInt(6,status);
                       
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
