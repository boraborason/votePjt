<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poll.*,java.util.*"%>
<jsp:useBean id="DBcon" class="poll.DBConnecter"/>
<%
	
	int num = 0;
	if (request.getParameter("num") != null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	int sum = DBcon.sumCount(num);
	Vector<ItemBean> list = DBcon.getView(num);
	System.out.println(list);
	ListBean listbean = DBcon.getList(num);
	String question = listbean.getQuestion();
	Random r = new Random();
%>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Poll</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<table border="1" width="400">
			<tr>
				<td colspan="4"><b>Q : <%=question%></b></td>
			</tr>
			<tr>
				<td colspan="3"><b>총 투표자 : <%=sum%>명</b></td>
				<td width="40">count</td>
			</tr>
			<%
				for (int i = 0; i < list.size(); i++) {
					ItemBean itemBean = list.get(i);
					String[] item = itemBean.getItem();//아이템 ex)김태희
					int rgb = r.nextInt(255 * 255 * 255);
					String rgbt = Integer.toHexString(rgb);
					String hRGB = "#" + rgbt;
					int count = itemBean.getCount();//투표수
					int ratio = (new Double(Math.ceil((double) count / sum * 100))).intValue();
			%>
			<tr>
				<td width="20" align="center"><%=i+1%></td>
				<td width="120"><%=item[0]%></td>
				<td>
					<table width="<%=ratio%>" height="15">
						<tr>
							<td bgcolor="<%=hRGB%>"></td>
						</tr>
					</table>
				</td>
				<td width="40"><%=count%></td>
			</tr>
			<%} //for%>
		</table>
		<p />
		<a href="javascript:window.close()">닫기</a>
	</div>
</body>
</html>