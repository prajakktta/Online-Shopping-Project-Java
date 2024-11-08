<%@ page import="project.ConnectionProvider"%>
<%@ page import="java.sql.*"%>
<%
String id=request.getParameter("id");
String email=request.getParameter("email");
String status="Cancel";
try
{
	Connection con=ConnectionProvider.getCon();
	Statement st=con.createStatement();
	st.executeUpdate("UPDATE cart SET status='"+status+"' WHERE product_id='"+id+"' AND email='"+email+"' AND address IS NOT NULL");
	response.sendRedirect("ordersReceived.jsp?msg=cancel");
}
catch(Exception e)
{
	System.out.println(e);
	response.sendRedirect("ordersReceived.jsp?msg=wrong");
}
%>