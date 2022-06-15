package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import rs.etf.sab.DB;
import rs.etf.sab.operations.VehicleOperations;

public class ss170201_VehicleOperationsImpl implements VehicleOperations {

	@Override
	public boolean changeConsumption(String arg0, BigDecimal arg1) {
		Connection conn = DB.getInstance().getConnection();
		String query = "update Vozilo set Potrosnja = ? where RegBr = ?";
		try (PreparedStatement ps = conn.prepareStatement(query);){
			ps.setBigDecimal(1, arg1);
			ps.setString(2, arg0);
			int rowUpdated = ps.executeUpdate();
			if(rowUpdated > 0)
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean changeFuelType(String arg0, int arg1) {
		Connection conn = DB.getInstance().getConnection();
		String query = "update Vozilo set Tip = ? where RegBr = ?";
		try (PreparedStatement ps = conn.prepareStatement(query);){
			ps.setInt(1, arg1);
			ps.setString(2, arg0);
			int rowUpdated = ps.executeUpdate();
			if(rowUpdated > 0)
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public int deleteVehicles(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		String query = "delete from Vozilo where RegBr = ?";
		int deletedRecords = 0;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			for (String string : arg0) {
                                //System.out.println("Vozilo sa regBr-em : " + string);
				ps.setString(1, string);
				int rowDeleted = ps.executeUpdate();
				if (rowDeleted > 0)
					deletedRecords += rowDeleted;
                                //System.out.println("Broj obrisanih vozila je : " + rowDeleted);
			}
                        return deletedRecords;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return deletedRecords;
	}

	@Override
	public List<String> getAllVehichles() {
		Connection conn = DB.getInstance().getConnection();
		String query = "select * from Vozilo";
		List<String> userList = new LinkedList<>();
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
			while (rs.next()) {
				userList.add(rs.getString("RegBr"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userList;
	}

	@Override
	public boolean insertVehicle(String arg0, int arg1, BigDecimal arg2) {
		Connection conn = DB.getInstance().getConnection();
		boolean flagUnique = true;
		boolean flagInsert = false;
		boolean retValue = false;
		String queryUnique = "select * from Vozilo where RegBr = ?";
		try (PreparedStatement ps = conn.prepareStatement(queryUnique);){
			ps.setString(1, arg0);
			try (ResultSet rs = ps.executeQuery();){
				if(rs.next())
					flagUnique = false;
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
                //System.out.println("Postoji li 2 ista vozila ? " + flagUnique);
		
		if(arg1 >= 0 && arg1 <= 2) 
			flagInsert = true;
                //System.out.println("Da li je dobar tip goriva ? " + flagInsert);
		
		if(flagInsert && flagUnique) {
                        //System.out.println("Usao u if");
			String query = "insert into Vozilo(RegBr, Tip, Potrosnja) values(?,?,?)";
			try (PreparedStatement ps1 = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
				ps1.setString(1, arg0);
				ps1.setInt(2, arg1);
				ps1.setBigDecimal(3, arg2);
				try (ResultSet rs = ps1.executeQuery();) {
					if (rs.next()){
						retValue = true;
                                                //System.out.println("Ubaceno vozilo");
                                        }
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
			
		return retValue;
	}

}
