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

// conn은 교량 개념
Statement stmt = conn.createStatement(); // SQL을 실을 트럭준비
//INSERT INTO member_tbl(m_id, m_name, m_age) VALUES('lee', '이순신', 25);
String sql = "INSERT INTO member_tbl(m_id, m_name, m_age) VALUES('";
sql += m_id + "', n'" + m_name + "', " +  m_age + ")";
stmt.executeUpdate(sql); // 트럭에 짐을 실어서 다리건너 부어 넣기.

stmt.close();
conn.close();
out.println("입력 OK~");
%>


</body>
</html>