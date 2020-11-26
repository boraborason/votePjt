package poll;

import java.sql.*;


	public class DbTest{
		public static void main(String args[]){
			Connection con;

			try{
				Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/poll?characterEncoding=UTF-8&serverTimezone=UTC","root", "qhfkths0446");
				System.out.println("Success");
			}
			catch(SQLException ex){ System.out.println("SQLException" + ex);}
			catch(Exception ex){ System.out.println("Exception:" + ex);}
		
	}
}
