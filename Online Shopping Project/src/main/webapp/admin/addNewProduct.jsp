<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%@include file="adminHeader.jsp" %>
<%@include file="../footer.jsp" %>
<html>
<head>
<link rel="stylesheet" href="../css/addNewProduct-style.css">
<title>Add New Product</title>
</head>
<body>

<%
String msg = request.getParameter("msg");
if ("done".equals(msg)) {
%>
    <h3 class="alert alert-success">Product Added Successfully!</h3>
<%
} else if ("invalid_input".equals(msg)) {
%>
    <h3 class="alert alert-warning">Invalid input for ID or price! Please enter valid numbers.</h3>
<%
} else if ("sql_error".equals(msg)) {
%>
    <h3 class="alert alert-danger">Database error! Could not add the product. Please try again later.</h3>
<%
} else if ("error".equals(msg)) {
%>
    <h3 class="alert alert-danger">Something went wrong! Please try again.</h3>
<%
}
%>

<%
int id=1;
try
{
	Connection con=ConnectionProvider.getCon();
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("SELECT MAX(ID) FROM product");
	while(rs.next())
	{
		id=rs.getInt(1);
		id++;
	}
}
catch(Exception e)
{
	
}
%>
<form action="addNewProductAction.jsp" method="post">
<h3 style="color: yellow;">Product ID: <%out.println(id);%> </h3>
<input type="hidden" name="id" value="<%out.println(id);%>">

<div class="left-div">
 <h3>Enter Name</h3>
 <input class="input-style" type="text" name="name" placeholder="Enter Name" required>
 
<hr>
</div>

<div class="right-div">
<h3>Enter Category</h3>
<input class="input-style" type="text" name="category" placeholder="Enter Category" required>
 
<hr>
</div>

<div class="left-div">
<h3>Enter Price</h3>
  <input class="input-style" type="number" name="price" placeholder="Enter Price" required>
 
<hr>
</div>

<div class="right-div">
    <h3>Active</h3>
    <select class="input-style" name="active">
        <option value="true">True</option>
        <option value="false">False<option>
    </select>
  
<hr>
</div>
 <button class="button">Save<i class='far fa-arrow-alt-circle-right'></i></button>
</form>
</body>
<br><br><br>
</body>
</html>