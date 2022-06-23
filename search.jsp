<%@page contentType="text/html" import="java.sql.*,java.util.*" pageEncoding="UTF-8"%>
<%

    try {        
        String sdata = request.getParameter("sdata");

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");

        Statement st1 = cn.createStatement();
        Statement st2 = cn.createStatement();
        ResultSet rs2 = st2.executeQuery("select * from video where status=0 AND video_name LIKE '%" + sdata + "%' OR video_name LIKE '%" + sdata + "' OR video_name LIKE '" + sdata + "%'");

        while (rs2.next()) {
            int count = 0;
            ResultSet rs1 = st1.executeQuery("select * from view where code='"+rs2.getString(2)+"'");
            while(rs1.next()){
                count++;
            }
        
%>
        
        <div class="row" style="margin-top:30px">
            <div class="col-sm-1"></div>
            <div class="col-sm-3">
                <a href="home.jsp?code=<%=rs2.getString("code")%>"><img src="vphoto/<%=rs2.getString("code")%>.jpg" class="img-fluid" style="width: 320px;height: 180px"></a>
            </div> 
            <div class="col-sm-6">
                <p style="padding-top:10px;font-size: 20px;letter-spacing: 1px"> <%=rs2.getString("Video_name")%> | <%=rs2.getString("description")%></p>
                <p><span style="color:gray;font-size: 12px"><%=count%> views</span></p>                
                <a style="color:grey;font-size: 14px" href="channel_view.jsp?code=<%=rs2.getString("ch_code")%>"><img src="cphoto/<%=rs2.getString("ch_code")%>.jpg" style="height:25px;width:25px;border-radius: 50%" /> <%=rs2.getString("channel_name")%></a>
            </div>
        </div>
                 
<%
        }
    } catch (Exception e) {
        out.print(e.getMessage());
    }

%>


