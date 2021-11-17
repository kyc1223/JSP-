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
Enumeration params = multi.getParameterNames(); //주의! 넘어오는 순서가 반대.
tmp = (String) params.nextElement();
String addVal = multi.getParameter(tmp);
tmp = (String) params.nextElement();
String algo = multi.getParameter(tmp);

// ** 파일 전송 **
Enumeration files = multi.getFileNames();
tmp = (String) files.nextElement();
String filename = multi.getFilesystemName(tmp);
out.println("<p>업로드 파일명 :" + filename);

///////////////////////

String para = addVal;

// 전역 변수 선언
int[][] inImage=null;
int inH=0, inW=0;
int[][] outImage=null;
int outH=0, outW=0;

// (1) JSP 파일 처리
File inFp;
FileInputStream inFs;
inFp = new File("c:/Upload/" + filename);
inFs = new FileInputStream(inFp.getPath());

// (2) JSP 배열 처리 : 파일 --> 메모리(2차배열)
//(중요!) 입력 폭, 높이 결정
Long fLen = inFp.length();
inH = inW = (int)Math.sqrt(fLen);

inImage = new int[inH][inW];
// 파일 --> 메모리
for (int i=0; i<inH; i++) {
	for (int k=0; k<inW; k++) {
		inImage[i][k] = inFs.read();		
	}
}
inFs.close();

// (3) 영상처리 알고리즘 적용하기.
switch(algo) {
case "101" : 	// 반전 알고리즘 : out = 255 - in
	// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
	outH = inH;
	outW = inW;
	outImage = new int[outH][outW];
	// ## 진짜 영상처리 알고리즘 ##
	for(int i=0; i<inH; i++) {
		for (int k=0; k<inW; k++) {
			outImage[i][k] = 255 - inImage[i][k];
		}
	}
	break;
case "102" : 	// 밝게/어둡게 : out = in + para
	// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
	outH = inH;
	outW = inW;
	outImage = new int[outH][outW];
	// ## 진짜 영상처리 알고리즘 ##
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



// (4) 결과를 파일에 쓰기
File outFp;
FileOutputStream outFs;
String outname = "out_"+ filename;
outFp = new File("c:/out/"+ outname);
outFs = new FileOutputStream(outFp.getPath());
// 메모리 --> 파일
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		outFs.write(outImage[i][k]);
	}
}
outFs.close();

out.println(algo + "  <h1> 처리 끝! </h1>");

String url = "<p><h1><a href='http://192.168.56.101:8080/SampleJSP/";
url += "download.jsp?file=" + outname + "'>다운로드</a></h1>";
out.println(url);

%>


</body>
</html>