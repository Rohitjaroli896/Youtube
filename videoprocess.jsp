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
    
    if(email != null || session.getAttribute(email) != null){                                                       
        if(request.getParameter("vtitle").trim().length()==0 || request.getParameter("description").trim().length()==0 || request.getParameter("cname").trim().length()==0 || request.getParameter("category").trim().length()==0){
            response.sendRedirect("channel.jsp?empty=1");            
        }
        else{            
            String vtitle = request.getParameter("vtitle");
            String description = request.getParameter("description");
            String cname = request.getParameter("cname");
            String category = request.getParameter("category");  
            String ch_code = request.getParameter("code");
            int sn=0;
            int status = 0;
            
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement st1 = cn.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from video where video_name='"+vtitle+"' AND description='"+description+"' AND channel_name='"+cname+"' AND category='"+category+"' AND ch_code='"+ch_code+"' AND status=0");
                if(rs1.next()){
                    response.sendRedirect("channel_video.jsp?exist=1");
                }
                else{
                       Statement st = cn.createStatement();
                       ResultSet rs = st.executeQuery("select MAX(sn) from video");

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
                       code = code+"_"+sn+"_"+ch_code;

                       PreparedStatement ps = cn.prepareStatement("insert into video values(?,?,?,?,?,?,?,?)");
                       ps.setInt(1,sn);
                       ps.setString(2,code);
                       ps.setString(3,vtitle);
                       ps.setString(4,description);
                       ps.setString(5,cname);
                       ps.setString(6,category); 
                       ps.setString(7,ch_code); 
                       ps.setInt(8,status);
                       
                       if(ps.executeUpdate()>0){
                           response.sendRedirect("video_img.jsp?code="+code);
                       }
                       else{
                          response.sendRedirect("channel_video.jsp"); 
                       }   
                   }                  
                }
                catch(Exception e){
                    out.print(e.getMessage());
                } 
            }
    }
%>

