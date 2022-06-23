<%@ page import="java.io.*,java.sql.*" %>
<%
    if(request.getParameter("code").length()==0){
        response.sendRedirect("video_img.jsp?empty=1");
    }
    else{
        String contentType = request.getContentType();
        
        String ch_code = "";
        String imageSave=null;
        byte dataBytes[]=null;
        String saveFile=null;
        String code=request.getParameter("code");
        
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
        {
            DataInputStream in = new DataInputStream(request.getInputStream());
            int formDataLength = request.getContentLength();
            dataBytes = new byte[formDataLength];
            int byteRead = 0;
            int totalBytesRead = 0;
                        
            while (totalBytesRead < formDataLength)
            {
                byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                totalBytesRead += byteRead;
            }
                
                String file = new String(dataBytes);                
                
                saveFile = code+".mp4";
                
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1, contentType.length());
                
                int pos;
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                try
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                    Statement st1 = cn.createStatement();
                    ResultSet rs1 = st1.executeQuery("select ch_code from video where code='"+code+"'");
                    if(rs1.next()){
                        ch_code = rs1.getString(1);
                    }                   
                    
                    
                    
                    FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/video/"+saveFile);

                    fileOut.write(dataBytes, startPos, (endPos - startPos));
                    fileOut.flush();
                    fileOut.close();
                    imageSave="Success";
                }
                catch (Exception e)
                {
                    imageSave="Failure";
                }
        }
        response.sendRedirect("channel.jsp?success=1&code="+ch_code);
    }
%>


