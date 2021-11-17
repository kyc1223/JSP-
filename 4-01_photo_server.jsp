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

// ** ���� ���� **
Enumeration files = multi.getFileNames();
tmp = (String) files.nextElement();
String filename = multi.getFilesystemName(tmp);
out.println("<p>���ε� ���ϸ� :" + filename);

///////////////////////

String para = addVal;

// ���� ���� ����
int[][] inImage=null;
int inH=0, inW=0;
int[][] outImage=null;
int outH=0, outW=0;

// (1) JSP ���� ó��
File inFp;
FileInputStream inFs;
inFp = new File("c:/Upload/" + filename);
inFs = new FileInputStream(inFp.getPath());

// (2) JSP �迭 ó�� : ���� --> �޸�(2���迭)
//(�߿�!) �Է� ��, ���� ����
Long fLen = inFp.length();
inH = inW = (int)Math.sqrt(fLen);

inImage = new int[inH][inW];
// ���� --> �޸�
for (int i=0; i<inH; i++) {
	for (int k=0; k<inW; k++) {
		inImage[i][k] = inFs.read();		
	}
}
inFs.close();

// (3) ����ó�� �˰��� �����ϱ�.
switch(algo) {
case "101" : 	// ���� �˰��� : out = 255 - in
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[outH][outW];
	// ## ��¥ ����ó�� �˰��� ##
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			outImage[i][k] = 255 - inImage[i][k];
		}
	}
	break;
case "102" : 	// ���/��Ӱ� : out = in + para
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[outH][outW];
	// ## ��¥ ����ó�� �˰��� ##
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			 int v = inImage[i][k] + Integer.parseInt(para);
			 if (v > 255)
				 v = 255;
			 if (v < 0)
				 v = 0;
			 outImage[i][k] = v;
		}
	}
	break;
}



// (4) ����� ���Ͽ� ����
File outFp;
FileOutputStream outFs;
String outname = "out_"+ filename;
outFp = new File("c:/out/"+ outname);
outFs = new FileOutputStream(outFp.getPath());
// �޸� --> ����
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		outFs.write(outImage[i][k]);
	}
}
outFs.close();

out.println(algo + "  <h1> ó�� ��! </h1>");

String url = "<p><h1><a href='http://192.168.56.101:8080/SampleJSP/";
url += "download.jsp?file=" + outname + "'>�ٿ�ε�</a></h1>";
out.println(url);

%>


</body>
</html>