<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
String email=session.getAttribute("email").toString();
String status="processing";
try
{
	Connection con = ConnectionProvider.getCon();
    PreparedStatement ps=con.prepareStatement("UPDATE cart SET status=? WHERE email=? AND status='bill'");
    ps.setString(1,status);
    ps.setString(2,email);
    ps.executeUpdate();
    response.sendRedirect("home.jsp");
}
catch(Exception e)
{
	System.out.println(e);
}
%>