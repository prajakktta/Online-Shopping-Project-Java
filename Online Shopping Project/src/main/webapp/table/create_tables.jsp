<%@ page import ="project.ConnectionProvider"%>
<%@ page import ="java.sql.*"%>
<%
try {
    Connection con = ConnectionProvider.getCon();
    Statement st = con.createStatement();

    // Create USERS table
    String q1 = "CREATE TABLE USERS ("
            + "name VARCHAR(100), "
            + "email VARCHAR(100) PRIMARY KEY, "
            + "mobilenumber VARCHAR(150), "
            + "securityquestion VARCHAR(200), "
            + "answer VARCHAR(200), "
            + "password VARCHAR(100), "
            + "address VARCHAR(500), "
            + "city VARCHAR(100), "
            + "state VARCHAR(100), "
            + "country VARCHAR(100)"
            + ")";

    // Create PRODUCT table
    String q2 = "CREATE TABLE PRODUCT ("
            + "id INT PRIMARY KEY, "
            + "name VARCHAR(500), "
            + "category VARCHAR(200), "
            + "price INT, "
            + "active BOOLEAN"
            + ")";

    // Create CART table with foreign keys
    String q3 = "CREATE TABLE CART ("
            + "email VARCHAR(100), "
            + "product_id INT, "
            + "quantity INT, "
            + "price INT, "
            + "total INT, "
            + "address VARCHAR(500), "
            + "city VARCHAR(100), "
            + "state VARCHAR(100), "
            + "country VARCHAR(100), "
            + "mobilenumber VARCHAR(150), "
            + "orderdate VARCHAR(100), "
            + "deliverydate VARCHAR(100), "
            + "paymentmethod VARCHAR(100), "
            + "transactionid VARCHAR(100), "
            + "status VARCHAR(10), "
            + "PRIMARY KEY (email, product_id), "
            + "FOREIGN KEY (email) REFERENCES USERS(email), "
            + "FOREIGN KEY (product_id) REFERENCES PRODUCT(id)"
            + ")";
    
    String q4 = "CREATE TABLE MESSAGE (id SERIAL, email VARCHAR(100), subject VARCHAR(200), body VARCHAR(1000), PRIMARY KEY (id))";


    
    System.out.println(q1);
	System.out.println(q2);
	System.out.println(q3);
	System.out.println(q4);
    st.execute(q1);
    st.execute(q2);
    st.execute(q3);
    st.execute(q4);
    System.out.println("Tables Created Successfully");

    con.close();
} catch (Exception e) {
    System.out.println(e);
}

%>
