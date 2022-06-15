CREATE TRIGGER TR_TransportOffer_
   ON  Paket 
   AFTER UPDATE
AS 
BEGIN
	declare @myCursor Cursor
	declare @idPaket int
	declare @status int

	set @myCursor = cursor for
	select IdPaket, Status
	from inserted

	open @myCursor

	fetch next from @myCursor
	into @idPaket, @status

	while @@FETCH_STATUS = 0
	begin
		if(@status = 1)
		begin
			delete from Ponuda
			where IdPaket = @idPaket
		end



		fetch next from @myCursor
		into @idPaket, @status
	end

	close @myCursor
	deallocate @myCursor


END
GO
