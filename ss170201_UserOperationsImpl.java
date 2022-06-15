package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import rs.etf.sab.DB;
import rs.etf.sab.operations.UserOperations;

public class ss170201_UserOperationsImpl implements UserOperations {

	@Override
	public int declareAdmin(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		String query = "select IdKorisnik from Korisnik where Username = ?";
		int idAdmin = 0;
		boolean alreadyAdmin = false;
		try (PreparedStatement ps = conn.prepareStatement(query);){
			ps.setString(1, arg0);
			try (ResultSet rs = ps.executeQuery();){
				if(rs.next())
					idAdmin = rs.getInt("IdKorisnik");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(idAdmin == 0) {
			return 2;
		}
		
		String queryAdmin = "select * from Administrator where IdAdmin = ?";
		try (PreparedStatement ps1 = conn.prepareStatement(queryAdmin);){
			ps1.setInt(1, idAdmin);
			try (ResultSet rs1 = ps1.executeQuery();){
				if(rs1.next()) {
					idAdmin = rs1.getInt("IdAdmin");
					return 1;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(!alreadyAdmin) {
			String queryInsert = "insert into Administrator(IdAdmin) values (?)";

			try (PreparedStatement ps2 = conn.prepareStatement(queryInsert, Statement.RETURN_GENERATED_KEYS);) {
				if (idAdmin > 0) {
					ps2.setInt(1, idAdmin);
					try (ResultSet rs = ps2.executeQuery();) {
						if (rs.next())
							return 0;
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return 2;
		
	}

	@Override
	public int deleteUsers(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		String query = "delete from Korisnik where Username = ?";
		int deletedRecords = 0;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			for (String string : arg0) {
				ps.setString(1, string);
				int rowDeleted = ps.executeUpdate();
				if (rowDeleted > 0)
					deletedRecords += rowDeleted;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return deletedRecords;
	}

	@Override
	public List<String> getAllUsers() {
		Connection conn = DB.getInstance().getConnection();
		String query = "select * from Korisnik";
		List<String> userList = new ArrayList<>();
		try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
			while (rs.next()) {
				userList.add(rs.getString("Username"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return userList;
	}

	@Override
	public Integer getSentPackages(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		int sum = 0;
		String query = "select * from Korisnik where Username = ?";
		for(String string : arg0) {
			try (PreparedStatement ps = conn.prepareStatement(query);){
				ps.setString(1, string);
				try (ResultSet rs = ps.executeQuery();) {
                                        if(!rs.next()){
                                            return null;
                                        }
					while (rs.next()) {
						sum += rs.getInt("BrPoslatihPaketa");
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
		return sum;
		
	}

	@Override
	public boolean insertUser(String username, String firstname, String lastname, String password) {
		Connection conn = DB.getInstance().getConnection();
		boolean flagInsert = false;
		boolean flagUnique = true;
		boolean retValue = false;
		
		String queryUnique = "select * from Korisnik where Username = ?";
		try (PreparedStatement ps = conn.prepareStatement(queryUnique);){
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery();){
				if(rs.next()){
					flagUnique = false;
                                        System.out.println("Korisnik vec postoji");
                                }
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

                boolean matchFound = false;
                
                if(password.matches(".*\\d.*") && password.matches(".*[a-zA-Z].*")){
                    matchFound = true;
                    //System.out.println("Valja li sifra? " + matchFound + " Sifra je : " + password);
                }
		if(password.length() >= 8 && matchFound && Character.isUpperCase(firstname.charAt(0)) && Character.isUpperCase(lastname.charAt(0))){
			flagInsert = true;
                        //System.out.println("Uslovi za kredencijale zadovoljeni");
                }
		if(flagInsert && flagUnique) {
                        //System.out.println("Usao u if ! ");
			String query = "insert into Korisnik(Username, Ime, Prezime, Password, BrPoslatihPaketa) values(?,?,?,?,0)";
			try (PreparedStatement ps1 = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
				ps1.setString(1, username);
				ps1.setString(2, firstname);
                                ps1.setString(3, lastname);
                                ps1.setString(4, password);
				try (ResultSet rs = ps1.executeQuery();) {
					if (rs.next()){
                                                //System.out.println("Korisnik ubacen !");
						return true;
                                                
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
