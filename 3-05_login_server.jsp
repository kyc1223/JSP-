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
String m_age = request.getParameter("m_age");

ResultSet rs = null;  // 조회결과의 더미
Statement stmt = conn.createStatement(); // SQL을 실을 트럭준비

String sql = "SELECT m_id,m_age FROM member_tbl WHERE m_id='";
sql += m_id + "'";
rs = stmt.executeQuery(sql); // 트럭에 짐을 실어서 다리건너 부어 넣기.

String m_age2 ="";
while (rs.next()) {
	m_age2 = rs.getString("m_age");
}
if (m_age2.equals("")) {
	out.println("너 누구냐? 아이디 없다.");
} else if (!m_age.equals(m_age2)) {
	out.println("비번 틀림. 확인 바람.");
} else {
	out.println("어서 오세요~~ 방가방가..");
	out.println("<h1><a href='3-05_upload_client.jsp'> 영상처리 실행 </a></h1> ");
	// 세션 정보를 설정.
	session.setAttribute("m_id", m_id);
	session.setAttribute("m_age", m_age);
}
stmt.close();
conn.close();

%>
</body>
</html>