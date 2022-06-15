
CREATE TABLE [Administrator]
( 
	[IdAdmin]            integer  NOT NULL 
)
go

CREATE TABLE [Grad]
( 
	[IdGrad]             integer  IDENTITY  NOT NULL ,
	[Naziv]              varchar(100)  NOT NULL ,
	[PostBr]             varchar(100)  NOT NULL 
)
go

CREATE TABLE [Korisnik]
( 
	[IdKorisnik]         integer  IDENTITY  NOT NULL ,
	[Ime]                varchar(100)  NOT NULL ,
	[Prezime]            varchar(100)  NOT NULL ,
	[Username]           varchar(100)  NOT NULL ,
	[Password]           varchar(100)  NOT NULL ,
	[BrPoslatihPaketa]   integer  NOT NULL 
	CONSTRAINT [Vece_jednako_nula_704389422]
		CHECK  ( BrPoslatihPaketa >= 0 )
)
go

CREATE TABLE [Kurir]
( 
	[IdKurir]            integer  NOT NULL ,
	[BrojIsporucenihPaketa] integer  NOT NULL 
	CONSTRAINT [Vece_jednako_nula_443239047]
		CHECK  ( BrojIsporucenihPaketa >= 0 ),
	[Profit]             decimal(10,3)  NOT NULL ,
	[Status]             integer  NOT NULL 
	CONSTRAINT [Status_kurira_1939297174]
		CHECK  ( [Status]=0 OR [Status]=1 ),
	[IdVozilo]           integer  NOT NULL 
)
go

CREATE TABLE [Opstina]
( 
	[IdOpstina]          integer  IDENTITY  NOT NULL ,
	[Naziv]              varchar(100)  NOT NULL ,
	[xKoord]             integer  NOT NULL ,
	[yKoord]             integer  NOT NULL ,
	[Grad]               integer  NOT NULL 
)
go

CREATE TABLE [Paket]
( 
	[IdPaket]            integer  IDENTITY  NOT NULL ,
	[Status]             integer  NOT NULL 
	CONSTRAINT [Status_zahteva_paket_917101429]
		CHECK  ( [Status]=0 OR [Status]=1 OR [Status]=2 OR [Status]=3 ),
	[Cena]               decimal(10,3)  NOT NULL 
	CONSTRAINT [Vece_jednako_nula_1887292297]
		CHECK  ( Cena >= 0 ),
	[VremePrihvatanja]   timestamp  NOT NULL ,
	[IdKurir]            integer  NULL ,
	[TipPaketa]          integer  NOT NULL 
	CONSTRAINT [Tip_paketa_1698527591]
		CHECK  ( [TipPaketa]=0 OR [TipPaketa]=1 OR [TipPaketa]=2 ),
	[Tezina]             decimal(10,3)  NOT NULL ,
	[OpstinaDostavljanja] integer  NOT NULL ,
	[OpstinaPreuzimanja] integer  NOT NULL ,
	[IdKorisnik]         integer  NULL 
)
go

CREATE TABLE [Ponuda]
( 
	[IdPonuda]           integer  IDENTITY  NOT NULL ,
	[ProcenatCene]       decimal(10,3)  NOT NULL ,
	[IdKurir]            integer  NOT NULL ,
	[IdPaket]            integer  NOT NULL 
)
go

CREATE TABLE [Vozilo]
( 
	[IdVozilo]           integer  IDENTITY  NOT NULL ,
	[Potrosnja]          decimal(10,3)  NOT NULL ,
	[Tip]                integer  NOT NULL 
	CONSTRAINT [Tip_goriva_1241771768]
		CHECK  ( [Tip]=0 OR [Tip]=1 OR [Tip]=2 ),
	[RegBr]              varchar(8)  NOT NULL 
)
go

CREATE TABLE [Voznja]
( 
	[IdVoznja]           integer  IDENTITY  NOT NULL ,
	[Pocetak]            datetime  NOT NULL ,
	[Kraj]               datetime  NOT NULL ,
	[IdKurir]            integer  NOT NULL 
)
go

CREATE TABLE [ZahtevKurir]
( 
	[IdKorisnik]         integer  NOT NULL ,
	[IdVozilo]           integer  NOT NULL ,
	[Status]             varchar(100)  NOT NULL 
	CONSTRAINT [Status_zahteva_kurir_1195462325]
		CHECK  ( [Status]='prihvacen' OR [Status]='odbijen' OR [Status]='neobradjen' )
)
go

CREATE TABLE [ZaPrevoz]
( 
	[IdVoznja]           integer  NOT NULL ,
	[IdPaket]            integer  NOT NULL 
)
go

ALTER TABLE [Administrator]
	ADD CONSTRAINT [XPKAdministrator] PRIMARY KEY  CLUSTERED ([IdAdmin] ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XPKGrad] PRIMARY KEY  CLUSTERED ([IdGrad] ASC)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XPKKorisnik] PRIMARY KEY  CLUSTERED ([IdKorisnik] ASC)
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [XPKKurir] PRIMARY KEY  CLUSTERED ([IdKurir] ASC)
go

ALTER TABLE [Opstina]
	ADD CONSTRAINT [XPKOpstina] PRIMARY KEY  CLUSTERED ([IdOpstina] ASC)
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [XPKPaket] PRIMARY KEY  CLUSTERED ([IdPaket] ASC)
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [XPKPonuda] PRIMARY KEY  CLUSTERED ([IdPonuda] ASC)
go

ALTER TABLE [Vozilo]
	ADD CONSTRAINT [XPKVozilo] PRIMARY KEY  CLUSTERED ([IdVozilo] ASC)
go

ALTER TABLE [Voznja]
	ADD CONSTRAINT [XPKVoznja] PRIMARY KEY  CLUSTERED ([IdVoznja] ASC)
go

ALTER TABLE [ZahtevKurir]
	ADD CONSTRAINT [XPKZahtevKurir] PRIMARY KEY  CLUSTERED ([IdKorisnik] ASC)
go

ALTER TABLE [ZaPrevoz]
	ADD CONSTRAINT [XPKZaPrevoz] PRIMARY KEY  CLUSTERED ([IdVoznja] ASC,[IdPaket] ASC)
go


ALTER TABLE [Administrator]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdAdmin]) REFERENCES [Korisnik]([IdKorisnik])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([IdKurir]) REFERENCES [Korisnik]([IdKorisnik])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([IdVozilo]) REFERENCES [Vozilo]([IdVozilo])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Opstina]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([Grad]) REFERENCES [Grad]([IdGrad])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Paket]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([IdKurir]) REFERENCES [Kurir]([IdKurir])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [R_34] FOREIGN KEY ([OpstinaDostavljanja]) REFERENCES [Opstina]([IdOpstina])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [R_35] FOREIGN KEY ([OpstinaPreuzimanja]) REFERENCES [Opstina]([IdOpstina])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [R_36] FOREIGN KEY ([IdKorisnik]) REFERENCES [Korisnik]([IdKorisnik])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([IdKurir]) REFERENCES [Kurir]([IdKurir])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_12] FOREIGN KEY ([IdPaket]) REFERENCES [Paket]([IdPaket])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Voznja]
	ADD CONSTRAINT [R_16] FOREIGN KEY ([IdKurir]) REFERENCES [Kurir]([IdKurir])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [ZahtevKurir]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([IdVozilo]) REFERENCES [Vozilo]([IdVozilo])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZahtevKurir]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([IdKorisnik]) REFERENCES [Korisnik]([IdKorisnik])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [ZaPrevoz]
	ADD CONSTRAINT [R_32] FOREIGN KEY ([IdVoznja]) REFERENCES [Voznja]([IdVoznja])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ZaPrevoz]
	ADD CONSTRAINT [R_33] FOREIGN KEY ([IdPaket]) REFERENCES [Paket]([IdPaket])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_Administrator ON Administrator FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Administrator */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Administrator on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000153a5", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdAdmin" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.IdAdmin = Korisnik.IdKorisnik AND
        NOT EXISTS (
          SELECT * FROM Administrator
          WHERE
            /* %JoinFKPK(Administrator,Korisnik," = "," AND") */
            Administrator.IdAdmin = Korisnik.IdKorisnik
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Administrator because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Administrator ON Administrator FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Administrator */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdAdmin integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Administrator on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015e8c", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdAdmin" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdAdmin)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdAdmin = Korisnik.IdKorisnik
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Administrator because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Grad ON Grad FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Grad */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Grad  Opstina on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f72c", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Grad" */
    IF EXISTS (
      SELECT * FROM deleted,Opstina
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.Grad = deleted.IdGrad
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Grad because Opstina exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Grad ON Grad FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Grad */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdGrad integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Grad  Opstina on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0001639b", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Grad" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdGrad)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdGrad = inserted.IdGrad
        FROM inserted
      UPDATE Opstina
      SET
        /*  %JoinFKPK(Opstina,@ins," = ",",") */
        Opstina.Grad = @insIdGrad
      FROM Opstina,inserted,deleted
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.Grad = deleted.IdGrad
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Grad update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Korisnik ON Korisnik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003713e", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdKorisnik" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdKorisnik = deleted.IdKorisnik
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevKurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdKorisnik" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevKurir
      WHERE
        /*  %JoinFKPK(ZahtevKurir,deleted," = "," AND") */
        ZahtevKurir.IdKorisnik = deleted.IdKorisnik
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because ZahtevKurir exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Kurir on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdKurir" */
    DELETE Kurir
      FROM Kurir,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdKurir = deleted.IdKorisnik

    /* erwin Builtin Trigger */
    /* Korisnik  Administrator on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdAdmin" */
    DELETE Administrator
      FROM Administrator,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.IdAdmin = deleted.IdKorisnik


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Korisnik ON Korisnik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdKorisnik integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00055154", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdKorisnik" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdKorisnik = deleted.IdKorisnik
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Korisnik because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevKurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdKorisnik" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKorisnik = inserted.IdKorisnik
        FROM inserted
      UPDATE ZahtevKurir
      SET
        /*  %JoinFKPK(ZahtevKurir,@ins," = ",",") */
        ZahtevKurir.IdKorisnik = @insIdKorisnik
      FROM ZahtevKurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevKurir,deleted," = "," AND") */
        ZahtevKurir.IdKorisnik = deleted.IdKorisnik
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdKurir" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKorisnik = inserted.IdKorisnik
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.IdKurir = @insIdKorisnik
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdKurir = deleted.IdKorisnik
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Administrator on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdAdmin" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKorisnik = inserted.IdKorisnik
        FROM inserted
      UPDATE Administrator
      SET
        /*  %JoinFKPK(Administrator,@ins," = ",",") */
        Administrator.IdAdmin = @insIdKorisnik
      FROM Administrator,inserted,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.IdAdmin = deleted.IdKorisnik
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kurir ON Kurir FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004cd22", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="IdKurir" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdKurir = deleted.IdKurir
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Voznja on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdKurir" */
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdKurir = deleted.IdKurir
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Voznja exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdKurir" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdKurir = deleted.IdKurir
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="IdVozilo" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.IdVozilo = Vozilo.IdVozilo AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,Vozilo," = "," AND") */
            Kurir.IdVozilo = Vozilo.IdVozilo
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdKurir" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.IdKurir = Korisnik.IdKorisnik AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,Korisnik," = "," AND") */
            Kurir.IdKurir = Korisnik.IdKorisnik
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kurir ON Kurir FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdKurir integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00065dee", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="IdKurir" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKurir = inserted.IdKurir
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.IdKurir = @insIdKurir
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdKurir = deleted.IdKurir
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Voznja on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdKurir" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKurir = inserted.IdKurir
        FROM inserted
      UPDATE Voznja
      SET
        /*  %JoinFKPK(Voznja,@ins," = ",",") */
        Voznja.IdKurir = @insIdKurir
      FROM Voznja,inserted,deleted
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdKurir = deleted.IdKurir
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdKurir" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdKurir = inserted.IdKurir
        FROM inserted
      UPDATE Ponuda
      SET
        /*  %JoinFKPK(Ponuda,@ins," = ",",") */
        Ponuda.IdKurir = @insIdKurir
      FROM Ponuda,inserted,deleted
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdKurir = deleted.IdKurir
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="IdVozilo" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdVozilo)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.IdVozilo = Vozilo.IdVozilo
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdKurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdKurir = Korisnik.IdKorisnik
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Opstina ON Opstina FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Opstina */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Opstina  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002f18b", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="OpstinaPreuzimanja" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.OpstinaPreuzimanja = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="OpstinaDostavljanja" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.OpstinaDostavljanja = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Grad  Opstina on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Grad" */
    IF EXISTS (SELECT * FROM deleted,Grad
      WHERE
        /* %JoinFKPK(deleted,Grad," = "," AND") */
        deleted.Grad = Grad.IdGrad AND
        NOT EXISTS (
          SELECT * FROM Opstina
          WHERE
            /* %JoinFKPK(Opstina,Grad," = "," AND") */
            Opstina.Grad = Grad.IdGrad
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Opstina because Grad exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Opstina ON Opstina FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Opstina */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdOpstina integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Opstina  Paket on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003bbb2", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="OpstinaPreuzimanja" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.OpstinaPreuzimanja = deleted.IdOpstina
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Opstina because Paket exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="OpstinaDostavljanja" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdOpstina)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdOpstina = inserted.IdOpstina
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.OpstinaDostavljanja = @insIdOpstina
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.OpstinaDostavljanja = deleted.IdOpstina
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Opstina update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Grad  Opstina on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Grad" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Grad)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Grad
        WHERE
          /* %JoinFKPK(inserted,Grad) */
          inserted.Grad = Grad.IdGrad
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Opstina because Grad does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Paket ON Paket FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Paket */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  ZaPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00064213", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="IdPaket" */
    IF EXISTS (
      SELECT * FROM deleted,ZaPrevoz
      WHERE
        /*  %JoinFKPK(ZaPrevoz,deleted," = "," AND") */
        ZaPrevoz.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because ZaPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Paket  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IdPaket" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdKorisnik" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.IdKorisnik = Korisnik.IdKorisnik AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Korisnik," = "," AND") */
            Paket.IdKorisnik = Korisnik.IdKorisnik
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Korisnik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="OpstinaPreuzimanja" */
    IF EXISTS (SELECT * FROM deleted,Opstina
      WHERE
        /* %JoinFKPK(deleted,Opstina," = "," AND") */
        deleted.OpstinaPreuzimanja = Opstina.IdOpstina AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Opstina," = "," AND") */
            Paket.OpstinaPreuzimanja = Opstina.IdOpstina
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Opstina exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="OpstinaDostavljanja" */
    IF EXISTS (SELECT * FROM deleted,Opstina
      WHERE
        /* %JoinFKPK(deleted,Opstina," = "," AND") */
        deleted.OpstinaDostavljanja = Opstina.IdOpstina AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Opstina," = "," AND") */
            Paket.OpstinaDostavljanja = Opstina.IdOpstina
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Opstina exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Paket on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="IdKurir" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.IdKurir = Kurir.IdKurir AND
        NOT EXISTS (
          SELECT * FROM Paket
          WHERE
            /* %JoinFKPK(Paket,Kurir," = "," AND") */
            Paket.IdKurir = Kurir.IdKurir
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paket because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Paket ON Paket FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Paket */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPaket integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  ZaPrevoz on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00074274", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="IdPaket" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ZaPrevoz
      WHERE
        /*  %JoinFKPK(ZaPrevoz,deleted," = "," AND") */
        ZaPrevoz.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Paket because ZaPrevoz exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Paket  Ponuda on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IdPaket" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdPaket = deleted.IdPaket
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Paket because Ponuda exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="IdKorisnik" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdKorisnik = Korisnik.IdKorisnik
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.IdKorisnik IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Korisnik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="OpstinaPreuzimanja" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(OpstinaPreuzimanja)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.OpstinaPreuzimanja = Opstina.IdOpstina
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_34", FK_COLUMNS="OpstinaDostavljanja" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(OpstinaDostavljanja)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.OpstinaDostavljanja = Opstina.IdOpstina
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="IdKurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdKurir = Kurir.IdKurir
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Ponuda ON Ponuda FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Ponuda */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Ponuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023d41", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IdPaket" */
    IF EXISTS (SELECT * FROM deleted,Paket
      WHERE
        /* %JoinFKPK(deleted,Paket," = "," AND") */
        deleted.IdPaket = Paket.IdPaket AND
        NOT EXISTS (
          SELECT * FROM Ponuda
          WHERE
            /* %JoinFKPK(Ponuda,Paket," = "," AND") */
            Ponuda.IdPaket = Paket.IdPaket
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ponuda because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Ponuda on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdKurir" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.IdKurir = Kurir.IdKurir AND
        NOT EXISTS (
          SELECT * FROM Ponuda
          WHERE
            /* %JoinFKPK(Ponuda,Kurir," = "," AND") */
            Ponuda.IdKurir = Kurir.IdKurir
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ponuda because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Ponuda ON Ponuda FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Ponuda */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPonuda integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00028b08", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="IdPaket" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paket
        WHERE
          /* %JoinFKPK(inserted,Paket) */
          inserted.IdPaket = Paket.IdPaket
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because Paket does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="IdKurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdKurir = Kurir.IdKurir
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozilo ON Vozilo FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001fbb6", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="IdVozilo" */
    IF EXISTS (
      SELECT * FROM deleted,Kurir
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdVozilo = deleted.IdVozilo
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Kurir exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  ZahtevKurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdVozilo" */
    IF EXISTS (
      SELECT * FROM deleted,ZahtevKurir
      WHERE
        /*  %JoinFKPK(ZahtevKurir,deleted," = "," AND") */
        ZahtevKurir.IdVozilo = deleted.IdVozilo
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because ZahtevKurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vozilo ON Vozilo FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozilo */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVozilo integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0002c374", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="IdVozilo" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdVozilo)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdVozilo = inserted.IdVozilo
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.IdVozilo = @insIdVozilo
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdVozilo = deleted.IdVozilo
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  ZahtevKurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdVozilo" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdVozilo)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdVozilo = inserted.IdVozilo
        FROM inserted
      UPDATE ZahtevKurir
      SET
        /*  %JoinFKPK(ZahtevKurir,@ins," = ",",") */
        ZahtevKurir.IdVozilo = @insIdVozilo
      FROM ZahtevKurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZahtevKurir,deleted," = "," AND") */
        ZahtevKurir.IdVozilo = deleted.IdVozilo
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Voznja ON Voznja FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Voznja */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Voznja  ZaPrevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020975", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="IdVoznja" */
    IF EXISTS (
      SELECT * FROM deleted,ZaPrevoz
      WHERE
        /*  %JoinFKPK(ZaPrevoz,deleted," = "," AND") */
        ZaPrevoz.IdVoznja = deleted.IdVoznja
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Voznja because ZaPrevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Voznja on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdKurir" */
    IF EXISTS (SELECT * FROM deleted,Kurir
      WHERE
        /* %JoinFKPK(deleted,Kurir," = "," AND") */
        deleted.IdKurir = Kurir.IdKurir AND
        NOT EXISTS (
          SELECT * FROM Voznja
          WHERE
            /* %JoinFKPK(Voznja,Kurir," = "," AND") */
            Voznja.IdKurir = Kurir.IdKurir
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Voznja because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Voznja ON Voznja FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Voznja */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVoznja integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Voznja  ZaPrevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00029377", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="IdVoznja" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdVoznja)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdVoznja = inserted.IdVoznja
        FROM inserted
      UPDATE ZaPrevoz
      SET
        /*  %JoinFKPK(ZaPrevoz,@ins," = ",",") */
        ZaPrevoz.IdVoznja = @insIdVoznja
      FROM ZaPrevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(ZaPrevoz,deleted," = "," AND") */
        ZaPrevoz.IdVoznja = deleted.IdVoznja
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Voznja update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Voznja on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdKurir" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKurir)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdKurir = Kurir.IdKurir
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Voznja because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ZahtevKurir ON ZahtevKurir FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ZahtevKurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  ZahtevKurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00027830", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdVozilo" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.IdVozilo = Vozilo.IdVozilo AND
        NOT EXISTS (
          SELECT * FROM ZahtevKurir
          WHERE
            /* %JoinFKPK(ZahtevKurir,Vozilo," = "," AND") */
            ZahtevKurir.IdVozilo = Vozilo.IdVozilo
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevKurir because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  ZahtevKurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdKorisnik" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.IdKorisnik = Korisnik.IdKorisnik AND
        NOT EXISTS (
          SELECT * FROM ZahtevKurir
          WHERE
            /* %JoinFKPK(ZahtevKurir,Korisnik," = "," AND") */
            ZahtevKurir.IdKorisnik = Korisnik.IdKorisnik
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZahtevKurir because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ZahtevKurir ON ZahtevKurir FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ZahtevKurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdKorisnik integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  ZahtevKurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002b44c", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdVozilo" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdVozilo)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.IdVozilo = Vozilo.IdVozilo
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevKurir because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  ZahtevKurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="ZahtevKurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdKorisnik" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdKorisnik)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdKorisnik = Korisnik.IdKorisnik
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZahtevKurir because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_ZaPrevoz ON ZaPrevoz FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on ZaPrevoz */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  ZaPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00025578", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="IdPaket" */
    IF EXISTS (SELECT * FROM deleted,Paket
      WHERE
        /* %JoinFKPK(deleted,Paket," = "," AND") */
        deleted.IdPaket = Paket.IdPaket AND
        NOT EXISTS (
          SELECT * FROM ZaPrevoz
          WHERE
            /* %JoinFKPK(ZaPrevoz,Paket," = "," AND") */
            ZaPrevoz.IdPaket = Paket.IdPaket
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZaPrevoz because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Voznja  ZaPrevoz on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="IdVoznja" */
    IF EXISTS (SELECT * FROM deleted,Voznja
      WHERE
        /* %JoinFKPK(deleted,Voznja," = "," AND") */
        deleted.IdVoznja = Voznja.IdVoznja AND
        NOT EXISTS (
          SELECT * FROM ZaPrevoz
          WHERE
            /* %JoinFKPK(ZaPrevoz,Voznja," = "," AND") */
            ZaPrevoz.IdVoznja = Voznja.IdVoznja
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ZaPrevoz because Voznja exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_ZaPrevoz ON ZaPrevoz FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on ZaPrevoz */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdVoznja integer, 
           @insIdPaket integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  ZaPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002a092", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="IdPaket" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdPaket)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paket
        WHERE
          /* %JoinFKPK(inserted,Paket) */
          inserted.IdPaket = Paket.IdPaket
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZaPrevoz because Paket does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Voznja  ZaPrevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Voznja"
    CHILD_OWNER="", CHILD_TABLE="ZaPrevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="IdVoznja" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdVoznja)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Voznja
        WHERE
          /* %JoinFKPK(inserted,Voznja) */
          inserted.IdVoznja = Voznja.IdVoznja
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ZaPrevoz because Voznja does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


