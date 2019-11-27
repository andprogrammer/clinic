package com.clinic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseService {

	static private boolean isDatabaseConnected;
	static private Statement statement;
	static private Connection connection;
	
	public DatabaseService() {
		isDatabaseConnected=false;
		statement=null;
		connection=null;
	}
	
	public static boolean connectToDataBase() {
		
		if(!isDatabaseConnected) {
			try
		    {
		      String driverName = "com.mysql.jdbc.Driver";
		      String url = "jdbc:mysql://localhost/clinic?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		      Class.forName(driverName);
		      
	    	    String username = "root";
	    	    String password = "#Krakow2019";
	    	    connection = DriverManager.getConnection(url, username, password);
	    	    isDatabaseConnected=true;
	    	    statement=connection.createStatement();
	    	    return true;
	        } catch (ClassNotFoundException e) {
	            // Could not find the database driver
	        	System.out.println("The exception raised is:" + e);
	        	return false;
	        } catch (SQLException e) {
	            // Could not connect to the database
	        	System.out.println("The exception raised is:" + e);
	        	return false;
	        }
		}
		return false;
	}
	
	public static boolean isDatabaseConnected() {
		return isDatabaseConnected;
	}
	
	public static Statement statementDataBase() {
		return isDatabaseConnected ? statement : null;
	}
	
	public static Connection connectionDataBase() {
		return isDatabaseConnected ? connection : null;
	}
	
	public boolean disableConnectionToDataBase() {
		if(isDatabaseConnected) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return true;
		}
		return false;
	}
}
