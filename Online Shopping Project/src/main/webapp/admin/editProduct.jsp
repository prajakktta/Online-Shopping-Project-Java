<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%@include file="adminHeader.jsp" %>
<%@include file="../footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<title>Edit Product</title>
<style>
.back {
    color: white;
    margin-left: 2.5%;
}
</style>
</head>
<body>
<h2><a class="back" href="allProductEditProduct.jsp"><i class='fas fa-arrow-circle-left'> Back</i></a></h2>

<%
int id = Integer.parseInt(request.getParameter("id"));  // Ensure id is handled as an integer
try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM product WHERE id=" + id);  // Use the int 'id'

    while (rs.next()) {
%>
<form action="editProductAction.jsp" method="post">
    <!-- Hidden field to pass the product id for the update action -->
    <input type="hidden" name="id" value="<%= rs.getInt(1) %>">

    <div class="left-div">
        <h3>Enter Name</h3>
        <input class="input-style" type="text" name="name" value="<%= rs.getString(2) %>" required>
        <hr>
    </div>

    <div class="right-div">
        <h3>Enter Category</h3>
        <input class="input-style" type="text" name="category" value="<%= rs.getString(3) %>" required>
        <hr>
    </div>

    <div class="left-div">
        <h3>Enter Price</h3>
        <input class="input-style" type="number" name="price" value="<%= rs.getInt(4) %>" required>
        <hr>
    </div>

    <div class="right-div">
        <h3>Active</h3>
        <select class="input-style" name="active">
            <option value="True" <%= rs.getBoolean(5) ? "selected" : "" %>>True</option>
            <option value="False" <%= !rs.getBoolean(5) ? "selected" : "" %>>False</option>
        </select>
        <hr>
    </div>

    <button class="button">Save
        <i class='far fa-arrow-alt-circle-right'></i> 
    </button>
</form>
<%
    }
} catch (Exception e) {
    System.out.println(e);
}
%>

</body>
<br><br><br>
</html>
