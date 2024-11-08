<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
String email=session.getAttribute("email").toString();
String securityQuestion=request.getParameter("securityQuestion");
String newAnswer=request.getParameter("newAnswer");
String password=request.getParameter("password");
int check=0;
try
{
	 Connection con = ConnectionProvider.getCon();
     Statement st = con.createStatement();
     ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + password + "'");
     while(rs.next())
     {
    	 check=1;
    	 st.executeUpdate("UPDATE users SET securityQuestion='"+securityQuestion+"',answer='"+newAnswer+"' WHERE email='"+email+"'");
    	 response.sendRedirect("changeSecurityQuestion.jsp?msg=done");
     }
     if(check==0)
    	 response.sendRedirect("changeSecurityQuestion.jsp?msg=wrong"); 
}
catch(Exception e)
{
	System.out.println(e);
}
%>