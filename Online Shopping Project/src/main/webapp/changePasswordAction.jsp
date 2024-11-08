<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
String email = session.getAttribute("email").toString();
String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");
String confirmPassword = request.getParameter("confirmPassword"); // Corrected spelling here

if (!confirmPassword.equals(newPassword))
    response.sendRedirect("changePassword.jsp?msg=notMatch");
else 
{
    int check = 0;
    try
    {
        Connection con = ConnectionProvider.getCon();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM users WHERE email='" + email + "' AND password='" + oldPassword + "'");
        while (rs.next())
        {
            check = 1;
            st.executeUpdate("UPDATE users SET password='" + newPassword + "' WHERE email='" + email + "'");
            response.sendRedirect("changePassword.jsp?msg=done");
        }
        if (check == 0)
        {
            response.sendRedirect("changePassword.jsp?msg=wrong");
        }
    }
    catch (Exception e)
    {
        System.out.println(e);
    }
}
%>
