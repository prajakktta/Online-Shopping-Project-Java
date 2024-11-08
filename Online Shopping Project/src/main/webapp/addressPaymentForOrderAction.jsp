<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
try {
    // Retrieve session attributes with null checks
    String email = session.getAttribute("email") != null ? session.getAttribute("email").toString() : "";
    String address = request.getParameter("address") != null ? request.getParameter("address") : "";
    String city = request.getParameter("city") != null ? request.getParameter("city") : "";
    String state = request.getParameter("state") != null ? request.getParameter("state") : "";
    String country = request.getParameter("country") != null ? request.getParameter("country") : "";
    String mobilenumber = request.getParameter("mobilenumber") != null ? request.getParameter("mobilenumber") : "";
    String paymentmethod = request.getParameter("paymentmethod") != null ? request.getParameter("paymentmethod") : "";
    String transactionid = request.getParameter("transactionid") != null ? request.getParameter("transactionid") : "";
    String status = "bill";

    // Ensure required fields are filled in
    if (email.isEmpty() || address.isEmpty() || city.isEmpty() || state.isEmpty() || country.isEmpty() || mobilenumber.isEmpty() || paymentmethod.isEmpty()) {
        throw new Exception("Some required fields are missing in session attributes or request parameters.");
    }

    // Establish database connection
    Connection con = ConnectionProvider.getCon();

    // Update USERS table
    PreparedStatement ps = con.prepareStatement(
        "UPDATE USERS SET address=?, city=?, state=?, country=?, mobilenumber=? WHERE email=?"
    );
    ps.setString(1, address);
    ps.setString(2, city);
    ps.setString(3, state);
    ps.setString(4, country);
    ps.setString(5, mobilenumber);
    ps.setString(6, email);
    ps.executeUpdate();

    // Update CART table with PostgreSQL date syntax
    PreparedStatement ps1 = con.prepareStatement(
        "UPDATE CART SET address=?, city=?, state=?, country=?, mobilenumber=?, orderdate=NOW(), deliverydate=(NOW() + INTERVAL '7 days'), paymentmethod=?, transactionid=?, status=? WHERE email=? AND address IS NULL"
    );
    ps1.setString(1, address);
    ps1.setString(2, city);
    ps1.setString(3, state);
    ps1.setString(4, country);
    ps1.setString(5, mobilenumber);
    ps1.setString(6, paymentmethod);
    ps1.setString(7, transactionid);
    ps1.setString(8, status);
    ps1.setString(9, email);
    ps1.executeUpdate();

    response.sendRedirect("bill.jsp");

} catch(Exception e) {
    // Output error message for debugging
    out.println("<p style='color:red;'>An error occurred: " + e.getMessage() + ". Please try again later.</p>");
    e.printStackTrace();
}
%>
