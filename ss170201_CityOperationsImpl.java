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
import rs.etf.sab.operations.CityOperations;

//NE RADI INT deleteCity(String... arg0) NE ZNAM ZASTO

public class ss170201_CityOperationsImpl implements CityOperations {

	@Override
	public int deleteCity(String... arg0) {//RADI
            Connection conn = DB.getInstance().getConnection();
            String query = "delete from Grad where Naziv = ?";
            int deletedRecords = 0;
            for (String string : arg0) {
                try (PreparedStatement ps = conn.prepareStatement(query);) {         
                    ps.setString(1, string);
                    int rowDeleted = ps.executeUpdate();
                    //System.out.println("Obrisano je do sad : " + rowDeleted+"a ime grada je : " + string);
                    if (rowDeleted > 0){
                        deletedRecords ++;
                        //System.out.println("DO SAD JE OBRISANO : " + deletedRecords );
                    }
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }                              
            return deletedRecords;
	}

	@Override
	public boolean deleteCity(int arg0) {//RADI
		Connection conn = DB.getInstance().getConnection();
		String query = "delete from Grad where IdGrad = ?";
                boolean retValue = false;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			ps.setInt(1, arg0);
			int rowDeleted = ps.executeUpdate();
                        //System.out.println("Broj obrisanih je: " + rowDeleted);
			if (rowDeleted > 0)
				retValue = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return retValue;
	}

	@Override
	public List<Integer> getAllCities() {//RADI
		Connection conn = DB.getInstance().getConnection();
		String query = "select * from Grad";
		List<Integer> citiesList = new ArrayList<>();
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
			while (rs.next()) {
				citiesList.add(rs.getInt("IdGrad"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return citiesList;
	}

	@Override
	public int insertCity(String Naziv, String PostBr) {//RADI
		Connection conn = DB.getInstance().getConnection();
                String queryCheck = "select * from Grad where PostBr = ? OR Naziv = ?";
                try (PreparedStatement psTest = conn.prepareStatement(queryCheck);){
                    psTest.setString(1, PostBr);
                    psTest.setString(2, Naziv);
                    ResultSet rsTest = psTest.executeQuery();
                    if(rsTest.next()){
                        //System.out.println("Nema istog grada + sa id-jem : " + rsTest.getInt(1));
                        return -1;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ss170201_CityOperationsImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
		String query = "insert into Grad(PostBr, Naziv) values(?,?)";
		int idCity = -1;
		try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
			ps.setString(1, PostBr);
			ps.setString(2, Naziv);
			//ps.executeUpdate();
			try (ResultSet rs = ps.executeQuery();) {
				if (rs.next()){
					idCity = rs.getInt(1);
                                        //System.out.println("Ubacio grad sa id - jem: " + idCity);
                                }
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return idCity;
        }

}
