<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
try {
    // Trim and sanitize input values
    String idParam = request.getParameter("id").trim();
    String priceParam = request.getParameter("price").trim();
    
    // Convert the sanitized strings to integer
    int id = Integer.parseInt(idParam);
    int price = Integer.parseInt(priceParam);

    String name = request.getParameter("name").trim();
    String category = request.getParameter("category").trim();
    boolean active = Boolean.parseBoolean(request.getParameter("active"));

    // Database connection and insertion
    Connection con = ConnectionProvider.getCon();
    PreparedStatement ps = con.prepareStatement("INSERT INTO product (id, name, category, price, active) VALUES (?, ?, ?, ?, ?)");
    ps.setInt(1, id);           // id as an integer
    ps.setString(2, name);       // name as a string
    ps.setString(3, category);   // category as a string
    ps.setInt(4, price);         // price as an integer
    ps.setBoolean(5, active);    // active as a boolean
    ps.executeUpdate();

    // Redirect on success
    response.sendRedirect("addNewProduct.jsp?msg=done");
} catch (NumberFormatException e) {
    // Handle invalid id or price input
    response.sendRedirect("addNewProduct.jsp?msg=invalid_input");
} catch (SQLException e) {
    // Handle SQL exceptions, for example, duplicate id or database connection issues
    response.sendRedirect("addNewProduct.jsp?msg=sql_error");
} catch (Exception e) {
    // Catch-all for any other unexpected errors
    response.sendRedirect("addNewProduct.jsp?msg=error");
}
%>
