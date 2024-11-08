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

    // Database connection and update query
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();

    // Updating the product with correct data types
    String query = "UPDATE product SET name='" + name + "', category='" + category + "', price=" + price + ", active=" + active + " WHERE id=" + id;
    st.executeUpdate(query);

    // If active is false, delete the product from the cart if the address is null
    if (!active) {
        String deleteQuery = "DELETE FROM cart WHERE product_id=" + id + " AND address IS NULL";
        st.executeUpdate(deleteQuery);
    }

    // Redirect on successful update
    response.sendRedirect("allProductEditProduct.jsp?msg=done");
} 
catch (Exception e) {
    // Handle exceptions and redirect in case of an error
    System.out.println(e);
    response.sendRedirect("allProductEditProduct.jsp?msg=wrong");
} 
%>
