<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="DBcon" class="poll.DBConnecter"/>
<jsp:useBean id="listbean" class="poll.ListBean" /> <!--insert페이지에 입력한 설문을 plbean에 저장-->
<jsp:setProperty property="*" name="listbean" />
<jsp:useBean id="itembean" class="poll.ItemBean" /> <!--insert페이지에 입력한 아이템을 pibean에 저장-->
<jsp:setProperty property="*" name="itembean" />

<%
	String sdate = request.getParameter("sdateY")+"-"+
			request.getParameter("sdateM")+"-"+
			request.getParameter("sdateD");
	String edate = request.getParameter("edateY")+"-"+
			request.getParameter("edateM")+"-"+
			request.getParameter("edateD");
	
	listbean.setSdate(sdate);
	listbean.setEdate(edate);
	
	boolean flag = DBcon.insertPoll(listbean, itembean); 
	String msg = "설문을 등록 할 수 없습니다.";
	String url = "pollInsert.jsp";
	
	if(flag){
		msg = "설문이 등록 되었습니다.";
		url = "pollList.jsp";		
	}
%>

	<script>
		alert("<%=msg%>");
		location.href="<%=url%>";
	</script>

