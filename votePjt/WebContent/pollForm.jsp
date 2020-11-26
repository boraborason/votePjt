<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector,poll.*" %>
<jsp:useBean id="DBcon" class="poll.DBConnecter"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollForm</title>
</head>
<body>
<%
	int num = 0; //num값을 통해 선택한 리스트를 pollForm에 출력
	
	if(!(request.getParameter("num")==null || request.getParameter("num").equals(""))){ //num값이 null이거나 공백이 아닐때 
		num = Integer.parseInt(request.getParameter("num")); //num값을 int로 형변환
 	}
	
	ListBean listBean = DBcon.getList(num); 
	Vector<String> list = DBcon.getItem(num);	//선택한 투표 설문 데이터를 받음
	
	String question = listBean.getQuestion();
	int type = listBean.getType();
	int active = listBean.getActive();
	
%>

	<link href="stylesheet.css" rel="stylesheet" type="text/css">
	<form method="post" action="pollFormProc.jsp">
		<table border="1" width="300">
			<tr>
				<td colspan="2"> Q : <%=question%></td>
			</tr>
			<tr>
				<td colsapn="2">
					<%
					 for(int i = 0; i < list.size(); i++){
						 String itemList = list.get(i);
						 if(type==1){
							 out.println("<input type=check name='itemnum' value='"+i+"'>");
						 }else{	 
							 out.println("<input type=radio name='itemnum' value='"+i+"'>");
						 }
						 out.println(itemList + "<br>");
					 }
					%>
				</td>
			</tr>
			<tr>
				<td>
					<%
						if(active==1){
							out.println("<input type='submit' value='투표'>");
						}else{
							out.println("투표");
						}
					%>
				</td>
				<td>
				<input type="button" value="결과"
				onclick="javascript:window.open('pollView.jsp?num=<%=num %>', 'PollView', 'width=500, height=350')">
				</td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=num%>">
	</form>
</body>
</html>