<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%@include file="footer.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/addressPaymentForOrder-style.css">
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<title>Home</title>
<script>
if(window.history.forward(1)!=null)
    window.history.forward(1);
</script>
</head>
<body>
<br>
<table>
<thead>
<%
String email = (String) session.getAttribute("email");
int total = 0;
int sno = 0;
if (email == null) {
    // Redirect to login page or show error if email is not found in session
    response.sendRedirect("login.jsp");
    return;
}

try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    
    // Calculate the total from CART
    ResultSet rs1 = st.executeQuery("SELECT sum(total) FROM cart WHERE email='" + email + "' AND address is NULL");
    if (rs1.next()) {
        total = rs1.getInt(1);
    }
%>
      <tr>
      <th scope="col"><a href="myCart.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></th>
        <th scope="col" style="background-color: yellow;">Total: <i class="fa fa-inr"></i><% out.println(total); %> </th>
      </tr>
    </thead>
    <thead>
      <tr>
      <th scope="col">S.No</th>
        <th scope="col">Product Name</th>
        <th scope="col">Category</th>
        <th scope="col"><i class="fa fa-inr"></i> price</th>
        <th scope="col">Quantity</th>
        <th scope="col">Sub Total</th>
      </tr>
    </thead>
    <tbody>
<%
    // Query to get product and cart information for the specified email
    ResultSet rs = st.executeQuery("SELECT * FROM product INNER JOIN cart ON product.id = cart.product_id WHERE cart.email='" + email + "' AND cart.address IS NULL");
    while (rs.next()) {
        sno++;
%> 
      <tr>
       <td><%= sno %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("category") %></td>
        <td><i class="fa fa-inr"></i><%= rs.getInt("price") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><i class="fa fa-inr"></i><%= rs.getInt("total") %></td>
      </tr>
<%
    }

    // Get user details for the form
    ResultSet rs2 = st.executeQuery("SELECT * FROM users WHERE email='" + email + "'");
    if (rs2.next()) {
%> 
    </tbody>
  </table>

<hr style="width: 100%">
<form action="addressPaymentForOrderAction.jsp" method="post">
 <div class="left-div">
 <h3>Enter Address</h3>
 <input class="input-style" type="text" name="address" value="<%= rs2.getString("address") %>" placeholder="Enter Address" required>
 </div>

<div class="right-div">
<h3>Enter city</h3>
<input class="input-style" type="text" name="city" value="<%= rs2.getString("city") %>" placeholder="Enter City" required>
</div> 

<div class="left-div">
<h3>Enter State</h3>
<input class="input-style" type="text" name="state" value="<%= rs2.getString("state") %>" placeholder="Enter State" required>
</div>

<div class="right-div">
<h3>Enter country</h3>
<input class="input-style" type="text" name="country" value="<%= rs2.getString("country") %>" placeholder="Enter Country" required>
</div>

<h3 style="color: red">*If there is no address, it means you have not set your address!</h3>
<h3 style="color: red">*This address will also be updated to your profile</h3>
<hr style="width: 100%">
<div class="left-div">
<h3>Select Payment Method</h3>
 <select class="input-style" name="paymentmethod">
 <option value="Cash on Delivery(COD)">Cash on Delivery(COD)</option>
 <option value="Online Payment">Online Payment</option>
 </select>
</div>

<div class="right-div">
<h3>Enter Transaction ID (if paying online)</h3>
<input class="input-style" type="text" name="transactionid" placeholder="Enter Transaction ID">
<h3 style="color: red">*If you select Online Payment, enter your transaction ID here; otherwise, leave this blank.</h3>
</div>
<hr style="width: 100%">

<div class="left-div">
<h3>Mobile Number</h3>
<input class="input-style" type="text" name="mobilenumber" value="<%= rs2.getString("mobilenumber") %>" placeholder="Enter Mobile Number" required>
<h3 style="color: red">*This mobile number will also be updated to your profile.</h3>
</div>
<div class="right-div">
<h3 style="color: red">*If you enter an incorrect transaction ID, your order may be canceled!</h3>
<button class="button" type="submit">Proceed to Generate Bill & Save <i class='far fa-arrow-alt-circle-right'></i></button>
<h3 style="color: red">*Please fill out the form carefully.</h3>
</div>
</form>
<%
    }
} catch (Exception e) {
    System.out.println(e);
}
%>

<br>
<br>
<br>

</body>
</html>
