<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%@ include file="dbconn.jsp" %>
<%
String m_id = request.getParameter("m_id");
String m_name = request.getParameter("m_name");
String m_age = request.getParameter("m_age");

// conn�� ���� ����
Statement stmt = conn.createStatement(); // SQL�� ���� Ʈ���غ�
//UPDATE member_tbl SET m_name='kys', m_age=31 WHERE m_id='kim';
String sql = "UPDATE member_tbl SET m_name='";
sql += m_name + "', m_age=" + m_age + "  WHERE m_id='" +  m_id + "'";
stmt.executeUpdate(sql); // Ʈ���� ���� �Ǿ �ٸ��ǳ� �ξ� �ֱ�.

stmt.close();
conn.close();
out.println("���� OK~");
%>


</body>
</html>