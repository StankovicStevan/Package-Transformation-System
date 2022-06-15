package student;

import java.sql.CallableStatement;
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
import rs.etf.sab.operations.CourierRequestOperation;

public class ss170201_CourierRequestOperationImpl implements CourierRequestOperation {

    @Override
    public boolean changeVehicleInCourierRequest(String arg0, String arg1) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String queryKur = "select * from Korisnik where Username = ?";
        int idKurir = 0;
        int idVozilo = 0;
        boolean retValue = false;
        try (PreparedStatement ps = conn.prepareStatement(queryKur);) {
            ps.setString(1, arg0);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idKurir = rs.getInt("IdKorisnik");
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String queryVoz = "select * from Vozilo where RegBr = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(queryVoz);) {
            ps1.setString(1, arg1);
            try (ResultSet rs1 = ps1.executeQuery()) {
                if (rs1.next()) {
                    idVozilo = rs1.getInt("IdVozilo");
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String queryUpdate = "update ZahtevKurir set IdVozilo = ? where IdKorisnik = ?";
        try (PreparedStatement ps = conn.prepareStatement(queryUpdate, Statement.RETURN_GENERATED_KEYS);) {
            if (idKurir > 0 && idVozilo > 0) {
                ps.setInt(1, idVozilo);
                ps.setInt(2, idKurir);
                int rowUpdated = ps.executeUpdate();
                if (rowUpdated > 0) {
                    return true;
                }
                //try (ResultSet rs = ps.executeQuery();) {
                //	if (rs.next())
                //		retValue = true;
                //} catch (SQLException e) {
                //	// TODO Auto-generated catch block
                //e.printStackTrace();
                //}
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteCourierRequest(String arg0) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String queryKur = "select * from Korisnik where Username = ?";
        int idKurir = 0;
        try (PreparedStatement ps = conn.prepareStatement(queryKur);) {
            ps.setString(1, arg0);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idKurir = rs.getInt("IdKorisnik");
                }
            } catch (SQLException ex) {
                
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String query = "delete from ZahtevKurir where IdKorisnik = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(query);) {
            ps1.setInt(1, idKurir);
            int rowDeleted = ps1.executeUpdate();
            if (rowDeleted > 0) {
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<String> getAllCourierRequests() {//RADI
        Connection conn = DB.getInstance().getConnection();
        String query = "select Username from ZahtevKurir, Korisnik\r\n"
                + "where ZahtevKurir.IdKorisnik = Korisnik.IdKorisnik";
        List<String> courierRequestList = new ArrayList<>();
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
            while (rs.next()) {
                courierRequestList.add(rs.getString(1));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return courierRequestList;
    }
    
    //MORA DA SE RADI PREKO PROCEDURE
    @Override
    public boolean grantRequest(String arg0) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from ZahtevKurir, Korisnik\r\n"
                + "where ZahtevKurir.IdKorisnik = Korisnik.IdKorisnik and Username = ?";
        int idKorisnik = 0;
        int idVozilo = 0;
        boolean retValue = false;
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setString(1, arg0);
            try (ResultSet rs = ps.executeQuery();) {
                if (rs.next()) {
                    idKorisnik = rs.getInt("IdKorisnik");
                    idVozilo = rs.getInt("IdVozilo");
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

//        String queryDelCourReq = "delete from ZahtevKurir where IdKorisnik = ?";
//        try (PreparedStatement ps = conn.prepareStatement(queryDelCourReq);) {
//            ps.setInt(1, idKorisnik);
//            int rowDeleted = ps.executeUpdate();
//            if (rowDeleted > 0) {
//                retValue = true;
//            }
//        } catch (SQLException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//
//        String queryInsert = "insert into Kurir(IdKurir, IdVozilo, BrojIsporucenihPaketa, Profit, Status) values (?, ?, 0, 0, 0)";
//
//        try (PreparedStatement ps = conn.prepareStatement(queryInsert, Statement.RETURN_GENERATED_KEYS);) {
//            if (idKorisnik > 0 && idVozilo > 0) {
//                ps.setInt(1, idKorisnik);
//                ps.setInt(2, idVozilo);
//                try (ResultSet rs = ps.executeQuery();) {
//                    if (rs.next()) {
//                        retValue = true;
//                    }
//                } catch (SQLException e) {
//                    // TODO Auto-generated catch block
//                    e.printStackTrace();
//                }
//            }
//        } catch (SQLException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }

//        String queryCall = " {call spPostaniKurir(?,?,?)}";
//        try(CallableStatement cs = conn.prepareCall(query);){
//            cs.setInt(1, idKorisnik);
//            cs.setString(2, "prihvacen");
//            cs.registerOutParameter(3, java.sql.Types.INTEGER);
//            cs.execute();
//            if(cs.getInt(3) == 1)
//                retValue = true;
//        } catch (SQLException ex) {
//            Logger.getLogger(CourierRequestOperationImpl.class.getName()).log(Level.SEVERE, null, ex);
//        }
        String query1 = "{call spPostaniKurir (?,?)}";
        Connection con = DB.getInstance().getConnection();
        try ( CallableStatement stmt = con.prepareCall(query1)) {
            stmt.setInt(1, idKorisnik);
            stmt.registerOutParameter(2, java.sql.Types.INTEGER);
            stmt.execute();
            int res = stmt.getInt(2);
            if(res == 1){
                return true;
            }
            else{
                return false;
            }
        } catch (SQLException ex) {
            //Logger.getLogger(ZahtevZaKurira.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        //return retValue;

    }

    @Override
    public boolean insertCourierRequest(String arg0, String arg1) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String queryKur = "select * from Korisnik where Username = ?";
        int idKurir = 0;
        int idVozilo = 0;
        boolean retValue = false;
        try (PreparedStatement ps = conn.prepareStatement(queryKur);) {
            ps.setString(1, arg0);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idKurir = rs.getInt("IdKorisnik");
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String queryVoz = "select * from Vozilo where RegBr = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(queryVoz);) {
            ps1.setString(1, arg1);
            try (ResultSet rs1 = ps1.executeQuery()) {
                if (rs1.next()) {
                    idVozilo = rs1.getInt("IdVozilo");
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_vezbe.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String query = "insert into ZahtevKurir(IdKorisnik, IdVozilo, Status) values (?, ?, 'neobradjen')";

        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
            if (idKurir > 0 && idVozilo > 0) {
                ps.setInt(1, idKurir);
                ps.setInt(2, idVozilo);
                int insertBool = ps.executeUpdate();
                if (insertBool > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return retValue;
    }

}
