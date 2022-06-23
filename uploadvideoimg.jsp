<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="java.io.*" %>
<%
    if(request.getParameter("code").length()==0){
        response.sendRedirect("video_img.jsp?empty=1");
    }
    else{
        String contentType = request.getContentType();

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
                
                saveFile = code+".jpg";
                
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
                    FileOutputStream fileOut = new FileOutputStream(request.getRealPath("/")+"/vphoto/"+saveFile);

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
        response.sendRedirect("video_img.jsp?success=1&code="+code);
    }
%>


