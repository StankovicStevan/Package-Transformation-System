package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.DB;
import rs.etf.sab.JDBC_vezbe;
import rs.etf.sab.operations.DistrictOperations;

//NE RADI int deleteDistricts(String... arg0) NE ZNAM ZASTO, POPRAVI

public class ss170201_DistrictOperationsImpl implements DistrictOperations {

	@Override
	public int deleteAllDistrictsFromCity(String arg0) {//RADI
		Connection conn = DB.getInstance().getConnection();

                int retValue = 0;
                
		String query = "delete from Opstina where Grad = (select IdGrad from Grad where Naziv = ?)";
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			ps.setString(1, arg0);
			int rowDeleted = ps.executeUpdate();
                        //System.out.println("RowDeleted = " + rowDeleted);
			if (rowDeleted > 0)
				retValue = rowDeleted;
                        //System.out.println("Broj obrisanih opstina iz grada: " + arg0 + " je : " + retValue);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return retValue;
	}

	@Override
	public boolean deleteDistrict(int arg0) {//RADI
		Connection conn = DB.getInstance().getConnection();
		String query = "delete from Opstina where IdOpstina = ?";
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			ps.setInt(1, arg0);
			int rowDeleted = ps.executeUpdate();
			if (rowDeleted > 0)
				return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public int deleteDistricts(String... arg0) {//RADI
            Connection conn = DB.getInstance().getConnection();
            String query = "delete from Opstina where Naziv = ?";
            int deletedRecords = 0;
            
		try (PreparedStatement ps = conn.prepareStatement(query);) {
                    for (String string : arg0) {
                        //System.out.println("Opstina za brisanje je : " + string);
                        ps.setString(1, string);
                        int rowDeleted = ps.executeUpdate();
                        //System.out.println("Za opstinu : " + string + " je doslo do brisanja : " + rowDeleted);
                        if (rowDeleted > 0)
                            deletedRecords ++;
                    }
		} catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
		}
            
            //System.out.println("Broj obrisanih opstina je : " + deletedRecords);
            return deletedRecords;
	}

	@Override
	public List<Integer> getAllDistricts() {//RADI
		Connection conn = DB.getInstance().getConnection();
		String query = "select * from Opstina";
		List<Integer> citiesList = new ArrayList<>();
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
			while (rs.next()) {
				citiesList.add(rs.getInt("IdOpstina"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return citiesList;
	}

	@Override
	public List<Integer> getAllDistrictsFromCity(int arg0) {//RADI
            Connection conn = DB.getInstance().getConnection();
            String query = "select * from Opstina where Grad = ?";
            List<Integer> districtList = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(query); ) {
		stmt.setInt(1, arg0);
		try (ResultSet rs=stmt.executeQuery()){

                        while(rs.next()){
                            //System.out.println("IdOpstine je : "+ rs.getInt("IdOpstina"));
                            districtList.add(rs.getInt("IdOpstina"));
                        }
                } catch (SQLException ex) {
                    Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
                    }
            } catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
            }
            
            if(districtList.size() == 0){
                districtList = null;
            }
            
            return districtList;
	}

	@Override
	public int insertDistrict(String arg0, int arg1, int arg2, int arg3) {//RADI
		Connection conn = DB.getInstance().getConnection();
		String query = "insert into Opstina(Naziv, Grad, xKoord, yKoord) values(?,?,?,?)";
		int idOpstine = 0;
		try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
			ps.setString(1, arg0);
			ps.setInt(2, arg1);
			ps.setInt(3, arg2);
			ps.setInt(4, arg3);
			ps.executeUpdate();
			ResultSet rs = ps.getGeneratedKeys();
			if(rs.next())
				idOpstine = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return idOpstine;
	}

}
