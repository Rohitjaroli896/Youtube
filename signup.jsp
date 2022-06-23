<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%
    if(request.getParameter("name").trim().length()==0 || request.getParameter("email").trim().length()==0 || request.getParameter("password").trim().length()==0 || request.getParameter("mob").trim().length()==0){
        out.print("empty");
    }
    else{
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mob = request.getParameter("mob");         
        int sn=0;        
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select MAX(sn) from user");
            
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
            
            PreparedStatement ps = cn.prepareStatement("insert into user values(?,?,?,?,?,?)");
            ps.setInt(1,sn);
            ps.setString(2,code);
            ps.setString(3,email);
            ps.setString(4,password);
            ps.setString(5,name);
            ps.setString(6,mob);
            
            if(ps.executeUpdate()>0){
                out.print("success");
            }
            else{
                out.print("again");
            }   
        }
        catch(Exception e){
            out.print(e.getMessage());
        }
            
    }
%>
