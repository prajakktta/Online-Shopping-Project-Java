<%@ page import="project.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ include file="adminHeader.jsp" %>
<%@ include file="../footer.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="../css/ordersReceived-style.css">
<title>Home</title>
<style>
/* Table styling for a cleaner look */
#customers {
    width: 100%;
    border-collapse: collapse;
    font-size: 16px;
    margin: 20px 0;
}
#customers th, #customers td {
    padding: 12px;
    border: 1px solid #ddd;
    text-align: center;
}
#customers th {
    background-color: #4CAF50;
    color: white;
}
#customers tr:nth-child(even) {
    background-color: #f9f9f9;
}
#customers tr:hover {
    background-color: #ddd;
}
.alert {
    color: red;
    text-align: center;
    font-size: 18px;
    margin: 10px 0;
}
</style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">Cancel Orders <i class='fas fa-window-close'></i></div>

<table id="customers">
    <tr>
        <th>Mobile Number</th>
        <th scope="col">Product Name</th>
        <th scope="col">Quantity</th>
        <th scope="col">Sub Total</th>
        <th>Address</th>
        <th>City</th>
        <th>State</th>
        <th>Country</th>
        <th scope="col">Order Date</th>
        <th scope="col">Expected Delivery Date</th>
        <th scope="col">Payment Method</th>
        <th scope="col">T-ID</th>
        <th scope="col">Status</th>
    </tr>

<%
try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(
    	    "SELECT * FROM cart " +
    	    "INNER JOIN product ON cart.product_id = product.id " +
    	    "WHERE cart.orderDate IS NOT NULL AND cart.status = 'Cancel'"
    	);


    while (rs.next()) {
       
    	
   %>
    <tr>
        <td><%= rs.getString(10) %></td>
        <td><%= rs.getString(17)%></td>
        <td><%= rs.getString(3) %></td>
        <td><i class="fa fa-inr"></i> <%= rs.getString(5) %></td>
        <td><%= rs.getString(6) %></td>
        <td><%= rs.getString(7) %></td>
        <td><%= rs.getString(8) %></td>
        <td><%= rs.getString(9) %></td>
        <td><%= rs.getString(11).split(" ")[0] %></td> <!-- Only the date part -->
        <td><%= rs.getString(12).split(" ")[0] %></td> <!-- Only the date part -->
        <td><%= rs.getString(13) %></td>
        <td><%= rs.getString(14) %></td>
        <td><%= rs.getString(15) %></td>
    </tr>
<%
    }
} catch (Exception e) {
    System.out.println(e);
}
%>
</table>

<br><br><br>
</body>
</html>
