<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
MultipartRequest  multi = new MultipartRequest(request, "c:/Upload", 
	5*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
String tmp;
Enumeration params = multi.getParameterNames(); //����! �Ѿ���� ������ �ݴ�.
tmp = (String) params.nextElement();
String addVal = multi.getParameter(tmp);
tmp = (String) params.nextElement();
String algo = multi.getParameter(tmp);

out.println("<p>�˰��� :" + algo);
out.println("<p>�� :" + addVal);

// ** ���� ���� **
Enumeration files = multi.getFileNames();
tmp = (String) files.nextElement();
String filename = multi.getFilesystemName(tmp);
out.println("<p>���ε� ���ϸ� :" + filename);

File inFp;
FileInputStream inFs;
inFp = new File("c:/Upload/" + filename);
Long fLen = inFp.length();
Integer inH, inW;
inH = inW = (int)Math.sqrt(fLen);
out.println("<p>���� ������ :" + inH.toString() + "x" + inW.toString());

%>


</body>
</html>