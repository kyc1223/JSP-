<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>서버 사이드 영상 처리(Alpha 1)</title>
</head>
<body>
<%
String inFile = request.getParameter("inFile");
String outFile = request.getParameter("outFile");
String algo = request.getParameter("algo");
String para = request.getParameter("para");


// 전역 변수 선언
int[][] inImage=null;
int inH=0, inW=0;
int[][] outImage=null;
int outH=0, outW=0;

// (1) JSP 파일 처리
File inFp;
FileInputStream inFs;
inFp = new File("C:/images/Pet_RAW/Pet_RAW(512x512)/"+inFile);
inFs = new FileInputStream(inFp.getPath());

// (2) JSP 배열 처리 : 파일 --> 메모리(2차배열)
//(중요!) 입력 폭, 높이 결정
inH = inW = 512;
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
outFp = new File("c:/images/out/"+outFile);
outFs = new FileOutputStream(outFp.getPath());
// 메모리 --> 파일
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		outFs.write(outImage[i][k]);
	}
}
outFs.close();

out.println(algo + "  <h1> 처리 끝! </h1>");

%>

</body>
</html>