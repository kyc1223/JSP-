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
ResultSet rs = null;  // 조회결과의 더미
Statement stmt = conn.createStatement(); // SQL을 실을 트럭준비

String sql = "SELECT * FROM member_tbl";
rs = stmt.executeQuery(sql); // 트럭에 짐을 실어서 다리건너 부어 넣기.

while(rs.next()) { // 한번씩 톡톡 당기기
	String m_id = rs.getString("m_id");
	String m_name = rs.getString("m_name");
	String m_age = Integer.toString(rs.getInt("m_age"));
	
	out.println(m_id + "\t" + m_name + "\t" + m_age + "<br>");
}
stmt.close();
conn.close();
out.println("조회 OK~");
%>
</body>
</html>