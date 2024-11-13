package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectionProvider {

	public static Connection getCon() {
		
		try
		{
		Class.forName("org.postgresql.Driver"); 
		Connection con = DriverManager.getConnection(//jdbc connection);
		return con;
		}
		catch(Exception e)
		{
			System.out.println(e);
			return null;
		}
}
}
