import java.sql.*;
import com.xp.dbConnection.*;

public class Main {
	public static void main(String[] args) {
		dbConnection dbCon = new dbConnection();
		
		try {

			System.out.println("Inside try block");
			Connection conn = dbCon.createConnection();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Outside try block");
	
	}

}
