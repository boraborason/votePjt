<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector,poll.*" %>
<jsp:useBean id="DBcon" class="poll.DBConnecter"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
<link href="style.css" rel ="stylesheet" type="text/css">
</head>
<body bgcolor="#808080">
	<div align="center">
		<br/>
		<h2>투표 프로그램</h2>
		<hr width="60%" />
		<h3><b>설문폼</b></h3>
		<!-- 설문 리스트 include -->
		<jsp:include page="pollForm.jsp"></jsp:include>
		<hr width="60%" />
		
		<!--리스트 테이블-->
		<h3><b>설문 리스트</b></h3>
		<table>
			<tr>
				<td>
					<table width="500" border="1">
						<tr>
							<td align="center"><b>번호</b></td>
							<td><b>제목</b></td>
							<td><b>시작일 ~ 종료일</b></td>
						</tr>
						<%
						
						Vector<ListBean> list = DBcon.getAllList(); //설문 리스트 담기
						
						int count = list.size();	
						for (int i = 0; i < list.size(); i++){
							ListBean listbean = list.get(i); //list에 담긴 값을 listbean에 담기
							int num = listbean.getNum();
							String question = listbean.getQuestion(); 
							String sdate = listbean.getSdate();
							String edate = listbean.getEdate();  //변수에 listbean 내용을 get하여 저장
						 
						out.println("<tr><td align='center'>" + count + "</td>");
						out.println("<td><a href='pollList.jsp?num="+num+"'>"+ question+ "</a></td>");
						out.println("<td>"+sdate+"~"+edate+"</td></tr>");
						count = count -1; 
						}
						%>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><a href="pollInsert.jsp">설문 작성하기</a></td>
			</tr>
		</table>
	</div>
	
</body>
</html>