CREATE Procedure spPostaniKurir
@KorisnikID int,
@returnval int output
as
begin

	declare @vozilo int
	declare @brojZahteva int
	set @vozilo = 0

	select @vozilo=ZahtevKurir.IdVozilo from ZahtevKurir
	where ZahtevKurir.IdKorisnik = @KorisnikID
	
	if @vozilo = 0
		set @returnval=-1
	else
	begin
		insert into Kurir(IdKurir, BrojIsporucenihPaketa, Profit, Status, IdVozilo)
		values(@KorisnikID,0, 0, 0, @vozilo)

		delete from ZahtevKurir where IdKorisnik=@KorisnikID
		set @returnval = 1
	end
end