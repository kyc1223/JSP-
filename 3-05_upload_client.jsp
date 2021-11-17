<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
// 세션을 확인해서 통과 여부 시키기
String m_id = (String)session.getAttribute("m_id");
String m_age = (String)session.getAttribute("m_age");

if (m_id == null || m_age == null) {
	out.println("정상 경로가 아님... <br><br>");
	return;
}
%>

<form name='fileForm' method='post' action='3-05_upload_server.jsp'
	enctype='multipart/form-data'>
	<p> Algorithm : <input type='text' name='algo'>
	<p> value: <input type='text' value = 50 name='addVal'>
	<p> File: <input type='file' name='filename'>
	<p> <input type='submit' value='Upload'>	
</form>
</body>
</html>