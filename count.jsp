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
    String code = request.getParameter("code"); 
    String vcode = request.getParameter("vcode"); 
    String dcode = request.getParameter("dcode");  
    String ccode = request.getParameter("ccode");
    String cview = request.getParameter("cview");
    
           try{ 
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                
                if(code != null){
                    Statement st2 = cn.createStatement();                
                    ResultSet rs2 = st2.executeQuery("select * from subscribe where ch_code='"+code+"'");
                    int count = 0;
                    while(rs2.next()){   
                        count++ ;                    
                    }
                    out.print(count+" subscriber");
                }
                else if(vcode != null){
                    Statement st = cn.createStatement();                
                    ResultSet rs = st.executeQuery("select * from vlike where code='"+vcode+"'");
                    int lcount = 0;
                    while(rs.next()){   
                        lcount++ ;                    
                    }
                    out.print(lcount);
                }
                else if(dcode != null){
                    Statement st = cn.createStatement();                
                    ResultSet rs = st.executeQuery("select * from dislike where code='"+dcode+"'");
                    int dcount = 0;
                    while(rs.next()){   
                        dcount++ ;                    
                    }
                    out.print(dcount);
                }
                else if(ccode != null){
                    Statement st = cn.createStatement();                
                    ResultSet rs = st.executeQuery("select * from comment where code='"+ccode+"'");
                    int ccount = 0;
                    while(rs.next()){   
                        ccount++ ;                    
                    }
                    out.print(ccount);
                }
                else if(cview != null){
                    Statement st3 = cn.createStatement();                
                    ResultSet rs3 = st3.executeQuery("select * from view where code='"+cview+"'");
                    int viewcount = 0;
                    while(rs3.next()){   
                        viewcount++ ;                    
                    }
                    out.print(viewcount+" views");
                }
            }
            catch(Exception e){
                out.print(e.getMessage());
            }   
%>
