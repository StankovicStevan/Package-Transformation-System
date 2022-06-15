package student;

import java.math.BigDecimal;
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
import rs.etf.sab.operations.CourierOperations;

public class ss170201_CourierOperationsImpl implements CourierOperations {

    @Override
    public boolean deleteCourier(String courierUsername) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String query = "delete from Kurir where  IdKurir = (\r\n"
                + "select Ku.IdKurir\r\n"
                + "from Kurir Ku join Korisnik Ko on Ku.IdKurir = Ko.IdKorisnik\r\n"
                + "where Ko.Username = ?)";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setString(1, courierUsername);
            int rowDeleted = ps.executeUpdate();
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
    public List<String> getAllCouriers() {//RADI
        Connection conn = DB.getInstance().getConnection();
        String query = "select Ko.Username\r\n"
                + "from Kurir Ku join Korisnik Ko on Ku.IdKurir = Ko.IdKorisnik \r\n"
                + "order by Ku.Profit DESC";
        List<String> courierList = new ArrayList<>();
        try (Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(query);) {
            while (rs.next()) {
                courierList.add(rs.getString(1));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return courierList;
    }

    @Override
    public BigDecimal getAverageCourierProfit(int deliveryNumber) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select coalesce(avg(Profit), 0) from Kurir where BrojIsporucenihPaketa >= ?";
        BigDecimal retValue = new BigDecimal(0);
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, deliveryNumber);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                retValue = rs.getBigDecimal(1);
                //System.out.println("Prosecan profit je : " + retValue);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return retValue;
    }

    @Override
    public List<String> getCouriersWithStatus(int statusCourier) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String query = "select Ko.Username\r\n"
                + "from Kurir Ku join Korisnik Ko on Ku.IdKurir = Ko.IdKorisnik \r\n"
                + "where Ku.Status = ?\r\n"
                + "order by Ku.Profit DESC";
        List<String> courierList = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(query);) {
            stmt.setInt(1, statusCourier);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    courierList.add(rs.getString(1));
                }
            } catch (SQLException ex) {
                
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return courierList;
    }

    @Override
    public boolean insertCourier(String courierUsername, String licencePlate) {//RADI
        Connection conn = DB.getInstance().getConnection();
        String queryKur = "select * from Korisnik where Username = ?";
        int idKurir = 0;
        int idVozilo = 0;
        boolean retValue = false;
        try (PreparedStatement ps = conn.prepareStatement(queryKur);) {
            ps.setString(1, courierUsername);
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
        String queryVoz = "select * from Vozilo where RegBr = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(queryVoz);) {
            ps1.setString(1, licencePlate);
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

        String query = "insert into Kurir(IdKurir, IdVozilo, BrojIsporucenihPaketa, Profit, Status) values (?, ?, 0, 0, 0)";

        try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
            if (idKurir > 0 && idVozilo > 0) {
                ps.setInt(1, idKurir);
                ps.setInt(2, idVozilo);
                try (ResultSet rs = ps.executeQuery();) {
                    if (rs.next()) {
                        retValue = true;
                    }
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return retValue;
    }

}
