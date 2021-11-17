<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="javax.imageio.*" %>
<%@ page import="java.awt.image.*" %>
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
int[][][] inImage=null;
int inH=0, inW=0;
int[][][] outImage=null;
int outH=0, outW=0;


// (1) JSP ���� ó��
File inFp;
FileInputStream inFs;
inFp = new File("c:/Upload/" + filename);  // mypic.png
// Į�� �̹��� ó��
BufferedImage cImage = ImageIO.read(inFp);
// (2) JSP �迭 ó�� : ���� --> �޸�(2���迭)
//(�߿�!) �Է� ��, ���� ����
inW = cImage.getHeight();
inH = cImage.getWidth();

inImage = new int[3][inH][inW];
// ���� --> �޸�
for (int i=0; i<inH; i++) {
	for (int k=0; k<inW; k++) {
		int rgb = cImage.getRGB(i,k);
		int r = (rgb >> 16) & 0xFF;
		int g = (rgb >> 8) & 0xFF;
		int b = (rgb >> 0) & 0xFF;
		inImage[0][i][k] = r;
		inImage[1][i][k] = g;
		inImage[2][i][k] = b;		
	}
}

// (3) ����ó�� �˰��� �����ϱ�.
switch(algo) {
case "101" : 	// ���� �˰��� : out = 255 - in
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.
	outH = inH;
	outW = inW;
	outImage = new int[3][outH][outW];
	// ## ��¥ ����ó�� �˰��� ##
	for(int rgb=0; rgb<3; rgb++) {
		for(int i=0; i<inH; i++) {
			for (int k=0; k<inW; k++) {
				outImage[rgb][i][k] = 255 - inImage[rgb][i][k];
			}
		}
	}
	break;
case "102" : 	// ���/��Ӱ� : out = in + para
	// (�߿�!) ��� ��, ���� ���� --> �˰��� ����.

	break;
}

// (4) ����� ���Ͽ� ����
File outFp;
FileOutputStream outFs;
String outname = "out_"+ filename;
outFp = new File("c:/out/"+ outname);
// Į�� �̹��� ����
BufferedImage outCImage = new BufferedImage(outH, outW,
		BufferedImage.TYPE_INT_RGB);
// �޸� --> ����
for(int i=0; i<outH; i++) {
	for(int k=0; k<outW; k++) {
		int r = outImage[0][i][k];
		int g = outImage[1][i][k];
		int b = outImage[2][i][k];
		int px =0;
		px = px | (r << 16);
		px = px | (g << 8);
		px = px | (b << 0);
		outCImage.setRGB(i,k,px);
	}
}
ImageIO.write(outCImage,"jpg", outFp);
out.println(algo + "  <h1> ó�� ��! </h1>");
String url = "<p><h1><a href='http://192.168.56.101:8080/SampleJSP/";
url += "download.jsp?file=" + outname + "'>�ٿ�ε�</a></h1>";
out.println(url);

%>


</body>
</html>