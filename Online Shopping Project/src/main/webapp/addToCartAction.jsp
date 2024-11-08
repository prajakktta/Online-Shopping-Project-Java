<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
String email = session.getAttribute("email").toString();
String product_id = request.getParameter("id");
int quantity = 1;
int product_price = 0;
int product_total = 0;
int cart_total = 0;

int z = 0; // Flag to check if product is already in the cart
try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    
    // Get product details from the product table
    ResultSet rs = st.executeQuery("SELECT * FROM product WHERE id='" + product_id + "'");
    if (rs.next()) {
        product_price = rs.getInt("price");  // Fetch product price
        product_total = product_price * quantity;  // Calculate total for the product
    }
    
    // Check if the product is already in the cart for this user
    ResultSet rs1 = st.executeQuery("SELECT * FROM cart WHERE product_id='" + product_id + "' AND email='" + email + "' AND address IS NULL");
    if (rs1.next()) {
        cart_total = rs1.getInt("total");
        cart_total += product_total;  // Update cart total
        quantity = rs1.getInt("quantity") + 1;  // Increment quantity
        
        // Set flag to indicate that the product already exists in the cart
        z = 1;
    }
    
    if (z == 1) {
        // Update the cart for an existing product
        st.executeUpdate("UPDATE cart SET total='" + cart_total + "', quantity='" + quantity + "' WHERE product_id='" + product_id + "' AND email='" + email + "' AND address IS NULL");
        response.sendRedirect("home.jsp?msg=exist");
    } else {
        // Insert a new product into the cart
        PreparedStatement ps = con.prepareStatement("INSERT INTO cart (email, product_id, quantity, price, total) VALUES (?, ?, ?, ?, ?)");
        ps.setString(1, email);
        ps.setInt(2, Integer.parseInt(product_id));  // product_id is an int
        ps.setInt(3, quantity);
        ps.setInt(4, product_price);
        ps.setInt(5, product_total);
        ps.executeUpdate();
        response.sendRedirect("home.jsp?msg=added");
    }
}
catch (Exception e) {
    System.out.println(e);
    response.sendRedirect("home.jsp?msg=invalid");
}
%>
