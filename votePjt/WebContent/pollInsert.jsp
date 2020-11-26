<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollInsert</title>
<link href="style.css" rel ="stylesheet" type="text/css">
</head>
<body bgcolor="#A4A4A4">
<div align="center">
	<br />
	<h2>투표프로그램</h2>
	<hr width="60%" />
	<form method="post" action ="pollInsertProc.jsp">
		<table border="1" width="500">
			<tr>
				<td><b>질문</b></td>
				<td colspan="2" align='center'><input type="text" name="question" size="55" ></td>
			</tr>
			<tr>
				<td rowspan="10"><b>항목</b></td>
				<%
					for(int i = 1; i <=2; i++){
						out.println("<td>" + (i * 2 - 1) + " : <input type='text' name='item'></td>");
						out.println("<td>" + (i * 2) + " : <input type='text' name='item'></td>");
						out.println("</tr>");
					}
				%>
			</tr>
			<tr>
				<td><b>시작일</b></td>
				<td colspan="2">
					<select name="sdateY">
					<%
						for(int i = 1900; i <= 2020; i++){
							out.println("<option value='" + i + "'>"+ i);
						}
					%>	
					</select>년
					<select name ="sdateM">
					<%
						for(int i = 1; i <= 12; i++){
							out.println("<option value='" + i + "'>" + i);
						}
					%>
					</select>월
					<select name ="sdateD">
					<%
						for(int i = 1; i <= 31; i++){
							out.println("<option value='" + i + "'>"+ i);
						}
					%>
					</select>일
				</td>
			</tr>
			<tr>
				<td><b>종료일</b></td>
				<td colspan="2">
					<select name="edateY">
					<%
						for(int i = 1900; i <= 2020; i++){
							out.println("<option value='" + i + "'>"+ i);
						}
					%>	
					</select>년
					<select name ="edateM">
					<%
						for(int i = 1; i <= 12; i++){
							out.println("<option value='" + i + "'>" + i);
						}
					%>
					</select>월
					<select name ="edateD">
					<%
						for(int i = 1; i <= 31; i++){
							out.println("<option value='" + i + "'>"+ i);
						}
					%>
					</select>일
				</td>
			</tr>
			<tr>
				<td><b>복수 투표 가능여부</b></td>
				<td colspan=2>
					<input type='radio' value="1" name='type' checked> Yes
					<input type='radio' value="0" name='type'> No
				</td>
			<tr>
			<tr>
				<td colspan = 3 >
					<input type='submit' value="작성하기" >
					<input type='reset' value="다시쓰기" >
					<input type='button' value="리스트" onClick="javascript:location.href='pollList.jsp'">
				</td>
			<tr>
			</tr>
		</table>
	</form>
</div>
</body>
</html>