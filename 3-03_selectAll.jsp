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
ResultSet rs = null;  // ��ȸ����� ����
Statement stmt = conn.createStatement(); // SQL�� ���� Ʈ���غ�

String sql = "SELECT * FROM member_tbl";
rs = stmt.executeQuery(sql); // Ʈ���� ���� �Ǿ �ٸ��ǳ� �ξ� �ֱ�.

while(rs.next()) { // �ѹ��� ���� ����
	String m_id = rs.getString("m_id");
	String m_name = rs.getString("m_name");
	String m_age = Integer.toString(rs.getInt("m_age"));
	
	out.println(m_id + "\t" + m_name + "\t" + m_age + "<br>");
}
stmt.close();
conn.close();
out.println("��ȸ OK~");
%>
</body>
</html>