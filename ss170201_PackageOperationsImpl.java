package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import rs.etf.sab.DB;

import rs.etf.sab.operations.PackageOperations;
import rs.etf.sab.operations.PackageOperations.Pair;

public class ss170201_PackageOperationsImpl implements PackageOperations {

    @Override
    public boolean acceptAnOffer(int offerId) {
        Connection conn = DB.getInstance().getConnection();
        int idPaket = 0;
        int idKurir = 0;
        BigDecimal procenatBG = new BigDecimal(0);
        String queryCourier = "select * from Ponuda where IdPonuda = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(queryCourier);) {
            ps1.setInt(1, offerId);
            ResultSet rs = ps1.executeQuery();
            if (rs.next()) {
                idPaket = rs.getInt("IdPaket");
                idKurir = rs.getInt("IdKurir");
                procenatBG = rs.getBigDecimal("ProcenatCene");
            } else {
                return false;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        //System.out.println("Procenat dohvacen : " + procenatBG);

        procenatBG = (procenatBG.divide(new BigDecimal(100))).add(new BigDecimal(1));
        //System.out.println("Procenat nov + 1 : " + procenatBG);
        boolean retValue = false;
        String query = "update Paket set Status = ?, IdKurir = ?, Cena = Cena * ? where IdPaket = ?";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, 1);
            ps.setInt(2, idKurir);
            ps.setBigDecimal(3, procenatBG);
            ps.setInt(4, idPaket);
            int rowUpdated = ps.executeUpdate();
            if (rowUpdated > 0) {
                retValue = true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        //Ovo trigger radi!!!
//        String queryDelete = "delete Ponuda where IdPonuda = ?";
//        try(PreparedStatement ps = conn.prepareStatement(queryDelete);){
//            ps.setInt(1, offerId);
//            int ret = ps.executeUpdate();
//        }catch (SQLException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
        return retValue;
    }

    @Override
    public boolean changeType(int idPaket, int Tip) {
        Connection conn = DB.getInstance().getConnection();
        String query = "update Paket set TipPaketa = ? where IdPaket = ?";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, Tip);
            ps.setInt(2, idPaket);
            int rowUpdated = ps.executeUpdate();
            if (rowUpdated > 0) {
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean changeWeight(int idPaket, BigDecimal Tezina) {
        Connection conn = DB.getInstance().getConnection();
        String query = "update Paket set Tezina = ? where IdPaket = ?";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setBigDecimal(1, Tezina);
            ps.setInt(2, idPaket);
            int rowUpdated = ps.executeUpdate();
            if (rowUpdated > 0) {
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deletePackage(int idPaket) {
        Connection conn = DB.getInstance().getConnection();
        String query = "delete from Paket where IdPaket = ?";
        boolean retValue = false;
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, idPaket);
            int rowDeleted = ps.executeUpdate();
            //System.out.println("Broj obrisanih je: " + rowDeleted);
            if (rowDeleted > 0) {
                retValue = true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return retValue;
    }

    //POPRAVI!!!!!!!!!!!!!!!!!!!!!!
    @Override
    public int driveNextPackage(String courierUsername) {

        Connection conn = DB.getInstance().getConnection();
        int idPaket = 0;
        int status = 0;
        int idKurir = 0;
        String query = "select * from Kurir where IdKurir = (\n"
                + "select IdKorisnik from Korisnik where Username = ?)";
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setString(1, courierUsername);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = rs.getInt("Status");
                idKurir = rs.getInt("IdKurir");
            } else {
                //System.out.println("Ne postoji kurir");
                return -2;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if (status != 0) {
            //System.out.println("Status kurira je da vozi");
            return -2;
        }
        String queryPackage = "select * from Paket where status = 1 and IdKurir = ?";
        List<Integer> listPackagesForDrive = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(queryPackage);) {
            ps.setInt(1, idKurir);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listPackagesForDrive.add(rs.getInt("IdPaket"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if (listPackagesForDrive.size() != 0) {
            //System.out.println("Nema paketa za isporuku");
            //System.out.println("Prosao if za nema paketa za isporuku");

            //if (status == 0) {
            String queryUpdatePackage = "update Paket set status = 2 where Status = 1 and IdKurir = ?";

            try (PreparedStatement ps = conn.prepareStatement(queryUpdatePackage, Statement.RETURN_GENERATED_KEYS);) {
                ps.setInt(1, idKurir);
                //ps.executeUpdate();
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    //System.out.println("Broj kljuca je : " + rs.getInt(1));
                }

            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();

            }
            //}
        }

        String query1 = "select TOP 2 * from Paket where IdKurir = ? and Status = 2";
        //List<Integer> listOfPackages = new ArrayList<>();
        int idPaketaDostavljen[] = {0, 0};
        try (PreparedStatement ps = conn.prepareStatement(query1);) {
            ps.setInt(1, idKurir);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next()) {
                idPaketaDostavljen[i] = rs.getInt(1);
                i++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ss170201_PackageOperationsImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        //System.out.println("Id paketa za dostavljanje je : " + idPaketaDostavljen);
        if (idPaketaDostavljen[0] != 0) {
            String queryUpdate = "update Paket set Status = 3 where IdPaket = ?";
            try (PreparedStatement ps = conn.prepareStatement(queryUpdate, PreparedStatement.RETURN_GENERATED_KEYS);) {
                ps.setInt(1, idPaketaDostavljen[0]);
                int ret = ps.executeUpdate();
                if (ret > 0) {
                    String queryVehicleCourier = "select * from Kurir K join Vozilo V on K.IdVozilo = V.IdVozilo where IdKurir = ?";
                    String regBr = "";
                    int tip = -1;
                    BigDecimal potrosnja = new BigDecimal(-1);
                    try (PreparedStatement ps1 = conn.prepareStatement(queryVehicleCourier);) {
                        ps1.setInt(1, idKurir);
                        ResultSet rs = ps1.executeQuery();
                        if (rs.next()) {
                            regBr = rs.getString("RegBr");
                            tip = rs.getInt("Tip");
                            potrosnja = rs.getBigDecimal("Potrosnja");
                        }
                    }
                    String queryDistricts = "select * from Paket where IdPaket = ?";
                    int opstinaPreuzimanja[] = {0, 0};
                    int opstinaDostavljanja[] = {0, 0};
                    BigDecimal cena = new BigDecimal(0);
                    try (PreparedStatement ps2 = conn.prepareStatement(queryDistricts);) {
                        ps2.setInt(1, idPaketaDostavljen[0]);
                        ResultSet rs = ps2.executeQuery();
                        if (rs.next()) {
                            opstinaPreuzimanja[0] = rs.getInt("OpstinaPreuzimanja");
                            opstinaDostavljanja[0] = rs.getInt("OpstinaDostavljanja");
                            cena = rs.getBigDecimal("Cena");
                        }
                    }
                    int opstinaPreuzimanjaX = 0;
                    int opstinaPreuzimanjaY = 0;
                    int opstinaDostavljanjaX = 0;
                    int opstinaDostavljanjaY = 0;

                    String queryOpstina = "select * from Opstina where IdOpstina = ?";
                    try (PreparedStatement ps3 = conn.prepareStatement(queryOpstina);) {
                        ps3.setInt(1, opstinaPreuzimanja[0]);
                        ResultSet rs = ps3.executeQuery();
                        if (rs.next()) {
                            opstinaPreuzimanjaX = rs.getInt(3);
                            opstinaPreuzimanjaY = rs.getInt(4);
                        }
                        ps3.setInt(1, opstinaDostavljanja[0]);
                        rs = ps3.executeQuery();
                        if (rs.next()) {
                            opstinaDostavljanjaX = rs.getInt("xKoord");
                            opstinaDostavljanjaY = rs.getInt("yKoord");
                        }
                    } catch (SQLException ex) {

                    }
                    BigDecimal euklidska_distanca_izmedju = new BigDecimal(0);
                    if (idPaketaDostavljen[1] != 0) {
                        String queryDistricts1 = "select * from Paket where IdPaket = ?";

                        //BigDecimal cena1 = new BigDecimal(0);
                        try (PreparedStatement ps2 = conn.prepareStatement(queryDistricts1);) {
                            ps2.setInt(1, idPaketaDostavljen[1]);
                            ResultSet rs = ps2.executeQuery();
                            if (rs.next()) {
                                opstinaPreuzimanja[1] = rs.getInt("OpstinaPreuzimanja");
                                opstinaDostavljanja[1] = rs.getInt("OpstinaDostavljanja");
                                //cena1 = rs.getBigDecimal("Cena");
                            }
                        }
                        int opstinaPreuzimanjaX1 = 0;
                        int opstinaPreuzimanjaY1 = 0;
                        int opstinaDostavljanjaX1 = 0;
                        int opstinaDostavljanjaY1 = 0;

                        String queryOpstina1 = "select * from Opstina where IdOpstina = ?";
                        try (PreparedStatement ps3 = conn.prepareStatement(queryOpstina1);) {
                            ps3.setInt(1, opstinaDostavljanja[0]);
                            ResultSet rs = ps3.executeQuery();
                            if (rs.next()) {
                                opstinaPreuzimanjaX1 = rs.getInt(3);
                                opstinaPreuzimanjaY1 = rs.getInt(4);
                            }
                            ps3.setInt(1, opstinaPreuzimanja[1]);
                            rs = ps3.executeQuery();
                            if (rs.next()) {
                                opstinaDostavljanjaX1 = rs.getInt("xKoord");
                                opstinaDostavljanjaY1 = rs.getInt("yKoord");
                            }
                        } catch (SQLException ex) {

                        }
                        euklidska_distanca_izmedju = BigDecimal.valueOf(ss170201_UtilMoja.euclidean(opstinaPreuzimanjaX1, opstinaPreuzimanjaY1, opstinaDostavljanjaX1, opstinaDostavljanjaY1));
                        //System.out.println("Euklidska distanca izmedju je " + euklidska_distanca_izmedju);
                    }
                    //System.out.println("Id opstine preuzimanja je : " + opstinaPreuzimanja + "Id opstine dostavljanja je " + opstinaDostavljanja);
                    //System.out.println("X i Y koord za preuzimanje : " + opstinaPreuzimanjaX + " i " + opstinaPreuzimanjaY + " X i Y koord za dostavljanje : " + opstinaDostavljanjaX + " i " + opstinaDostavljanjaY);
                    BigDecimal euklidska_distanca = BigDecimal.valueOf(ss170201_UtilMoja.euclidean(opstinaPreuzimanjaX, opstinaPreuzimanjaY, opstinaDostavljanjaX, opstinaDostavljanjaY));
                    BigDecimal cenaGorivaPoLitru = new BigDecimal(0);
                    switch (tip) {
                        case 0:
                            cenaGorivaPoLitru = new BigDecimal(15);
                            break;
                        case 1:
                            cenaGorivaPoLitru = new BigDecimal(36);
                            break;
                        case 2:
                            cenaGorivaPoLitru = new BigDecimal(32);
                            break;
                    }

                    BigDecimal profit = cena.subtract(euklidska_distanca.multiply(potrosnja).multiply(cenaGorivaPoLitru)).subtract(euklidska_distanca_izmedju.multiply(potrosnja).multiply(cenaGorivaPoLitru));
                    //System.out.println("Euklidska distanca je : " + euklidska_distanca + " potrosnja je : " + potrosnja + " cena goriva po litru je : " + cenaGorivaPoLitru);
                    BigDecimal trosak = (euklidska_distanca.multiply(potrosnja).multiply(cenaGorivaPoLitru)).add(euklidska_distanca_izmedju.multiply(potrosnja).multiply(cenaGorivaPoLitru));
                    //System.out.println("Trosak nam je : " + trosak);
                    //System.out.println("Profit je : " + profit + " a cena je : " + cena);
                    //System.out.println("Profit je : " + profit);

                    String queryUpdateFinal = "update Kurir set Profit = Profit + ? where IdKurir = ?";
                    try (PreparedStatement ps4 = conn.prepareStatement(queryUpdateFinal, PreparedStatement.RETURN_GENERATED_KEYS);) {
                        ps4.setBigDecimal(1, profit);
                        ps4.setInt(2, idKurir);

                        int res = ps4.executeUpdate();
                    }
                }
                return idPaketaDostavljen[0];
            } catch (SQLException ex) {
                Logger.getLogger(ss170201_PackageOperationsImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return -1;
    }

    @Override
    public Date getAcceptanceTime(int idPaket) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket where IdPaket = ?";
        Date acceptanceTime = null;
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                acceptanceTime = rs.getDate("VremePrihvatanja");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return acceptanceTime;
    }

    @Override
    public List<Integer> getAllOffers() {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Ponuda";
        List<Integer> list = new ArrayList<>();
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
            while (rs.next()) {
                list.add(rs.getInt("IdPonuda"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Pair<Integer, BigDecimal>> getAllOffersForPackage(int idPaket) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Ponuda where IdPaket = ?";
        List<Pair<Integer, BigDecimal>> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ss170201_PairOffer(rs.getInt(1), rs.getBigDecimal("ProcenatCene")));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Integer> getAllPackages() {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket";
        List<Integer> list = new ArrayList<>();
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query);) {
            while (rs.next()) {
                list.add(rs.getInt("IdPaket"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Integer> getAllPackagesWithSpecificType(int tip) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket where TipPaketa = ?";
        List<Integer> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, tip);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Integer getDeliveryStatus(int idPaket) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket where IdPaket = ?";
        int status = 0;
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = rs.getInt("Status");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return status;
    }

    @Override
    public List<Integer> getDrive(String courierUsername) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket where IdKurir = (select IdKorisnik from Korisnik where Username = ?) and Status = 2";
        List<Integer> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setString(1, courierUsername);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("IdPaket"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if (list.size() == 0) {
            list = null;
        }
        return list;
    }

    //
    @Override
    public BigDecimal getPriceOfDelivery(int idPaket) {
        Connection conn = DB.getInstance().getConnection();
        String query = "select * from Paket where IdPaket = ?";
        BigDecimal cena = new BigDecimal(0);
        try (PreparedStatement ps = conn.prepareStatement(query);) {
            ps.setInt(1, idPaket);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cena = rs.getBigDecimal("Cena");
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        if (cena == new BigDecimal(0)) {
            cena = null;
        }
        return cena;
    }

    @Override
    public int insertPackage(int districtFrom, int districtTo, String usernameSender, int packageType, BigDecimal weight) {
        Connection conn = DB.getInstance().getConnection();
        int idSender = 0;
        boolean flagSender = true;
        boolean flagType = false;
        String querySender = "select * from Korisnik where username = ?";
        try (PreparedStatement psSender = conn.prepareStatement(querySender)) {
            psSender.setString(1, usernameSender);
            ResultSet rs = psSender.executeQuery();
            if (rs.next()) {
                idSender = rs.getInt(1);
            }
        } catch (SQLException ex) {

        }
        if (idSender == 0) {
            flagSender = false;
        }
        if (packageType >= 0 && packageType <= 2) {
            flagType = true;
        }
//        int cena = -1;
//        int tezinski_faktor = -1;
//        int cenaPoKg = -1;
//        
//        switch(packageType){
//            case 0:
//                cena = 10;
//                tezinski_faktor = 0;
//                cenaPoKg = 0;
//                break;
//            case 1:
//                cena = 25;
//                tezinski_faktor = 1;
//                cenaPoKg = 200;
//                break;
//            case 2:
//                cena = 75;
//                tezinski_faktor = 2;
//                cenaPoKg = 300;
//                break;
//        }
        int opstinaPreuzimanjaX = 0;
        int opstinaPreuzimanjaY = 0;
        int opstinaDostavljanjaX = 0;
        int opstinaDostavljanjaY = 0;

        String queryOpstina = "select * from Opstina where IdOpstina = ?";
        try (PreparedStatement ps = conn.prepareStatement(queryOpstina);) {
            ps.setInt(1, districtFrom);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                opstinaPreuzimanjaX = rs.getInt("xKoord");
                opstinaPreuzimanjaY = rs.getInt("yKoord");
            }
            ps.setInt(1, districtTo);
            rs = ps.executeQuery();
            if (rs.next()) {
                opstinaDostavljanjaX = rs.getInt("xKoord");
                opstinaDostavljanjaY = rs.getInt("yKoord");
            }
        } catch (SQLException ex) {

        }
        double euklidska_distanca = ss170201_UtilMoja.euclidean(opstinaPreuzimanjaX, opstinaPreuzimanjaY, opstinaDostavljanjaX, opstinaDostavljanjaY);
        BigDecimal cena = ss170201_UtilMoja.getPackagePrice(packageType, weight, euklidska_distanca, new BigDecimal(0));
        //System.out.println("Cena paketa je : " + cena);
        String query = "insert into Paket(OpstinaPreuzimanja, OpstinaDostavljanja, IdKorisnik, TipPaketa, Tezina, Status, Cena) values(?,?,?,?,?,0,?)";
        int idPaket = -1;
        if (flagSender && flagType && cena != new BigDecimal(0)) {
            //System.out.println("Usao u if !!!");
            try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
                ps.setInt(1, districtFrom);
                ps.setInt(2, districtTo);
                ps.setInt(3, idSender);
                ps.setInt(4, packageType);
                ps.setBigDecimal(5, weight);
                ps.setBigDecimal(6, cena);
                try (ResultSet rs = ps.executeQuery();) {
                    if (rs.next()) {
                        idPaket = rs.getInt(1);
                        //System.out.println("Ubacio paket sa id - jem: " + idPaket);
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

        return idPaket;
    }

    @Override
    public int insertTransportOffer(String courierUsername, int idPaket, BigDecimal percentage) {
        Connection conn = DB.getInstance().getConnection();
        BigDecimal procenat = new BigDecimal(0);
        if (percentage == null) {
            procenat = new BigDecimal(Math.random() * 20 - 10);
        } else {
            procenat = percentage;
        }
        int idKurir = 0;
        boolean flagKurir = true;
        String querySender = "select * from Korisnik where username = ?";
        try (PreparedStatement psSender = conn.prepareStatement(querySender)) {
            psSender.setString(1, courierUsername);
            ResultSet rs = psSender.executeQuery();
            if (rs.next()) {
                idKurir = rs.getInt("IdKorisnik");
            }
        } catch (SQLException ex) {

        }
        if (idKurir == 0) {
            flagKurir = false;
        }
        String query = "insert into Ponuda(IdKurir, IdPaket, ProcenatCene) values(?,?,?)";
        int idPonuda = -1;
        if (flagKurir) {
            try (PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);) {
                ps.setInt(1, idKurir);
                ps.setInt(2, idPaket);
                ps.setBigDecimal(3, procenat);
                //ps.executeUpdate();
                try (ResultSet rs = ps.executeQuery();) {
                    if (rs.next()) {
                        idPonuda = rs.getInt(1);
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
        }

        return idPonuda;
    }

}
