package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionProvider {

	public static Connection getCon() {
		
		try
		{
		Class.forName("org.postgresql.Driver"); 
		Connection con = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/Online Shopping Portal", "postgres", "pilsch");
		return con;
		}
		catch(Exception e)
		{
			System.out.println(e);
			return null;
		}
}
}