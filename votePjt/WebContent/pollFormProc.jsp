<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="DBcon" class="poll.DBConnecter"/>
	<%  //투표를 누르면 실행
		int num = Integer.parseInt(request.getParameter("num"));
		String[] itemnum = request.getParameterValues("itemnum");
		boolean flag = DBcon.updatePoll(num, itemnum);	//update성공시 true반환
		String msg = "투표가 등록되지 않았습니다."; 
		
		if(flag){
			msg = "정상적으로 투표가 되었습니다.";		
			}
	%>
	
	<script>
		alert("<%=msg%>")
		location.href="pollList.jsp?num=<%=num%>"; 
	</script>
