package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import rs.etf.sab.DB;
import rs.etf.sab.operations.GeneralOperations;

public class ss170201_GeneralOperationsImpl implements GeneralOperations {

	@Override
	public void eraseAll() {
		Connection conn = DB.getInstance().getConnection();
		String queryAdmin = "delete from Administrator where 1 = 1";
		try (PreparedStatement ps = conn.prepareStatement(queryAdmin);) {
                    ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryPonuda = "delete from Ponuda where 1 = 1";
		try (PreparedStatement psPonuda = conn.prepareStatement(queryPonuda);) {
                    psPonuda.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryZahtevKurir = "delete from ZahtevKurir where 1 = 1";
		try (PreparedStatement psZahtevKurir = conn.prepareStatement(queryZahtevKurir);) {
                    psZahtevKurir.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryZaPrevoz = "delete from ZaPrevoz where 1 = 1";
		try (PreparedStatement psZaPrevoz = conn.prepareStatement(queryZaPrevoz);) {
                    psZaPrevoz.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryPaket = "delete from Paket where 1 = 1";
		try (PreparedStatement psPaket = conn.prepareStatement(queryPaket);) {
                    psPaket.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryOpstina = "delete from Opstina where 1 = 1";
		try (PreparedStatement psOpstina = conn.prepareStatement(queryOpstina);) {
                    psOpstina.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String queryGrad = "delete from Grad where 1 = 1";
		try (PreparedStatement psGrad = conn.prepareStatement(queryGrad);) {
                    psGrad.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryKurir = "delete from Kurir where 1 = 1";
		try (PreparedStatement psKurir = conn.prepareStatement(queryKurir);) {
                    psKurir.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
                String queryVoznja = "delete from Voznja where 1 = 1";
		try (PreparedStatement psVoznja = conn.prepareStatement(queryVoznja);) {
                    psVoznja.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
                String queryVozilo = "delete from Vozilo where 1 = 1";
		try (PreparedStatement psVozilo = conn.prepareStatement(queryVozilo);) {
                    psVozilo.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String queryKorisnik = "delete from Korisnik where 1 = 1";
		try (PreparedStatement psKorisnik = conn.prepareStatement(queryKorisnik);) {
                    psKorisnik.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		
		
		

	}

}
