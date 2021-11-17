<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>���� ���̵� ���� ó��(Alpha 1)</title>
</head>
<body>
<%
String inFile = request.getParameter("inFile");
String outFile = request.getParameter("outFile");
String algo = request.getParameter("algo");
String para = request.getParameter("para");


// ���� ���� ����
int[][] inImage=null;
int inH=0, inW=0;
int[][] outImage=null;
int outH=0, outW=0;

// (1) JSP ���� ó��
File inFp;
FileInputStream inFs;
inFp = new File("C:/images/Pet_RAW/Pet_RAW(512x512)/"+inFile);
inFs = new FileInputStream(inFp.getPath());

// (2) JSP �迭 ó�� : ���� --> �޸�(2���迭)
//(�߿�!) �Է� ��, ���� ����
inH = inW = 512;
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
outFp = new File("c:/images/out/"+outFile);
outFs = new FileOutputStream(outFp.getPath());
// �޸� --> ����
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		outFs.write(outImage[i][k]);
	}
}
outFs.close();

out.println(algo + "  <h1> ó�� ��! </h1>");

%>

</body>
</html>