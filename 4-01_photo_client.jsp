<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>����ó�� Ŭ���̾�Ʈ</title>
</head>
<body>

<form name='fileForm' method='post' action='4-01_photo_server.jsp'
	enctype='multipart/form-data'>
	<p> <select name="algo">
		<option value=""> ~~ ���� �ϼ��� ~~~ </option>
		<option value="101"> ���� ó�� </option>
		<option value="102"> ���/��Ӱ�</option>
	</select>
	<p> value: <input type='text' value = 50 name='addVal'>
	<p> File: <input type='file' name='filename'>
	<p> <input type='submit' value='����ó��'>	
</form>
</body>
</html>