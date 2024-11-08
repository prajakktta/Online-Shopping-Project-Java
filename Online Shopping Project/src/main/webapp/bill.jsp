<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%@include file="footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="css/bill.css">
<title>Bill</title>
</head>
<body>
<%
String email = (String) session.getAttribute("email");
if (email == null) {
    out.println("<p style='color:red;'>User not logged in. Please log in to view your bill.</p>");
    return;
}
try {
    int total = 0;
    int sno = 0;
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();

    // Calculate the total from the cart table
    ResultSet rs = st.executeQuery("SELECT SUM(total) FROM cart WHERE email='" + email + "' AND status='bill'");
    if (rs.next()) {
        total = rs.getInt(1);
    }

    // Fetch user and cart details for the bill
    ResultSet rs2 = st.executeQuery("SELECT * FROM users INNER JOIN cart ON users.email = cart.email WHERE cart.email='" + email + "' AND cart.status='bill'");
    if (rs2.next()) {
%>
<h3>Online Shopping Bill</h3>
<hr>
<div class="left-div"><h3>Name: <%= rs2.getString("name") %> </h3></div>
<div class="right-div-right"><h3>Email: <%= email %></h3></div>
<div class="right-div"><h3>Mobile Number: <%= rs2.getString("mobilenumber") %> </h3></div>

<div class="left-div"><h3>Order Date: <%= rs2.getString("orderdate") %> </h3></div>
<div class="right-div-right"><h3>Payment Method: <%= rs2.getString("paymentmethod") %></h3></div>
<div class="right-div"><h3>Expected Delivery: <%= rs2.getString("deliverydate") %> </h3></div>

<div class="left-div"><h3>Transaction Id: <%= rs2.getString("transactionid") %> </h3></div>
<div class="right-div-right"><h3>City: <%= rs2.getString("city") %> </h3></div>
<div class="right-div"><h3>Address: <%= rs2.getString("address") %> </h3></div>

<div class="left-div"><h3>State: <%= rs2.getString("state") %> </h3></div>
<div class="right-div-right"><h3>Country: <%= rs2.getString("country") %> </h3></div>

<hr>
<%
    }
%>

<br>

<table id="customers">
<h3>Product Details</h3>
  <tr>
    <th>S.No</th>
    <th>Product Name</th>
    <th>Category</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Sub Total</th>
  </tr>
  <%
  // Fetch product details for the cart items
  ResultSet rs1 = st.executeQuery("SELECT * FROM cart INNER JOIN product ON cart.product_id = product.id WHERE cart.email='" + email + "' AND cart.status='bill'");
  while (rs1.next()) {
      sno += 1;
  %>
  <tr>
    <td><%= sno %></td>
    <td><%= rs1.getString("name") %></td> <!-- Product name from the PRODUCT table -->
    <td><%= rs1.getString("category") %></td> <!-- Category from the PRODUCT table -->
    <td><%= rs1.getString("price") %></td> <!-- Price from the PRODUCT table -->
    <td><%= rs1.getString("quantity") %></td> <!-- Quantity from the CART table -->
    <td><%= rs1.getString("total") %></td> <!-- Subtotal (total) from the CART table -->
  </tr>
  <%
  }
  %>
</table>

<h3>Total: <%= total %></h3>
<a href="continueShopping.jsp"><button class="button left-button">Continue Shopping</button></a>
<a onclick="window.print();"><button class="button right-button">Print</button></a>
<br><br><br><br>
<%
} catch (Exception e) {
    out.println("<p style='color:red;'>An error occurred: " + e.getMessage() + "</p>");
    e.printStackTrace();
}
%>
</body>
</html>
