USE [master]
GO
/****** Object:  Database [BD_BLANKITO]    Script Date: 04/07/2016 02:51:49 a.m. ******/
CREATE DATABASE [BD_BLANKITO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BD_BLANKITO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BD_BLANKITO.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BD_BLANKITO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BD_BLANKITO_log.ldf' , SIZE = 1040KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BD_BLANKITO] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BD_BLANKITO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BD_BLANKITO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET ARITHABORT OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BD_BLANKITO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BD_BLANKITO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BD_BLANKITO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BD_BLANKITO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BD_BLANKITO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET RECOVERY FULL 
GO
ALTER DATABASE [BD_BLANKITO] SET  MULTI_USER 
GO
ALTER DATABASE [BD_BLANKITO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BD_BLANKITO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BD_BLANKITO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BD_BLANKITO] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BD_BLANKITO', N'ON'
GO
USE [BD_BLANKITO]
GO
/****** Object:  Schema [Almacen]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Almacen]
GO
/****** Object:  Schema [Compras]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Compras]
GO
/****** Object:  Schema [Comunes]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Comunes]
GO
/****** Object:  Schema [Logistica]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Logistica]
GO
/****** Object:  Schema [Produccion]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Produccion]
GO
/****** Object:  Schema [RRHH]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [RRHH]
GO
/****** Object:  Schema [Seguridad]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Seguridad]
GO
/****** Object:  Schema [Ventas]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE SCHEMA [Ventas]
GO
/****** Object:  UserDefinedTableType [dbo].[DetalleCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE TYPE [dbo].[DetalleCompra] AS TABLE(
	[id_compra] [int] NULL,
	[id_nota_ingreso] [int] NULL,
	[id_producto] [int] NULL,
	[cantidad] [decimal](18, 2) NULL,
	[descripcion] [nvarchar](255) NULL,
	[precio] [decimal](18, 2) NULL,
	[importe] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DetalleHorasTrabajadas]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE TYPE [dbo].[DetalleHorasTrabajadas] AS TABLE(
	[id_orden_produccion] [int] NULL,
	[id_personal] [int] NULL,
	[fecha_hora_inicio] [datetime] NULL,
	[fecha_hora_fin] [datetime] NULL,
	[costo] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DetalleNota]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE TYPE [dbo].[DetalleNota] AS TABLE(
	[id_nota] [int] NULL,
	[id_producto] [int] NULL,
	[cantidad] [decimal](18, 2) NULL,
	[descripcion] [nvarchar](255) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DetallePedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE TYPE [dbo].[DetallePedido] AS TABLE(
	[id_pedido] [int] NULL,
	[id_producto] [int] NULL,
	[descripcion] [varchar](100) NULL,
	[cantidad] [decimal](18, 2) NULL,
	[precio] [decimal](18, 2) NULL,
	[importe] [decimal](18, 2) NULL,
	[id_venta] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Elimina_Datos]    Script Date: 04/07/2016 02:51:50 a.m. ******/
CREATE TYPE [dbo].[Elimina_Datos] AS TABLE(
	[tabla] [varchar](50) NULL,
	[id_tabla] [int] NULL,
	[estado] [smallint] NULL
)
GO
/****** Object:  StoredProcedure [Almacen].[spGuardar_Categoria]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spGuardar_Categoria]
 @id_categoria int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_categoria FROM Almacen.Categoria WHERE descripcion = @descripcion AND id_categoria != @id_categoria AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_categoria <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_categoria + 1 FROM Almacen.Categoria ORDER BY id_categoria DESC),1)
		INSERT INTO Almacen.Categoria(
					 id_categoria
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE Almacen.Categoria
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_categoria = @id_categoria
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Almacen].[spGuardar_Marca]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spGuardar_Marca]
 @id_marca int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_marca FROM Almacen.Marca WHERE descripcion = @descripcion AND id_marca != @id_marca AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_marca <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_marca + 1 FROM Almacen.Marca ORDER BY id_marca DESC),1)
		INSERT INTO Almacen.Marca(
					 id_marca
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE Almacen.Marca
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_marca = @id_marca
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Almacen].[spGuardar_NotaIngreso]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spGuardar_NotaIngreso]
@id_nota_ingreso int,
@id_motivo	int,
@id_orden_compra int,
@id_orden_produccion int,
@id_usuario	int,
@id_sucursal int,
@observacion nvarchar(50),
@TYPE_DETALLENOTA AS dbo.DetalleNota READONLY 
AS
	BEGIN TRANSACTION
		DECLARE @NuevoId INT

		IF @id_nota_ingreso <= 0
		BEGIN
			SET @NuevoId = ISNULL((SELECT TOP 1 id_nota_ingreso + 1 FROM Almacen.Nota_Ingreso ORDER BY id_nota_ingreso DESC),1)

			DECLARE @NuevoNumero NVARCHAR(10)
			SET @NuevoNumero = ISNULL((SELECT TOP 1 RIGHT('000000000'+LTRIM(RIGHT(ISNULL(NI.numero,'000000000'),10)+1),10) 
								FROM Almacen.Nota_Ingreso NI INNER JOIN Logistica.Sucursal S ON NI.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY NI.id_nota_ingreso DESC),'0000000001')

			INSERT INTO Almacen.Nota_Ingreso(
						 id_nota_ingreso
						,fecha
						,numero
						,id_motivo
						,id_orden_compra
						,id_orden_produccion
						,id_usuario
						,id_sucursal
						,observacion
						,estado
						,usuario_registro
						,fecha_registro
				)
				VALUES( 
						 @NuevoId
						,GETDATE()
						,@NuevoNumero
						,@id_motivo
						,@id_orden_compra
						,@id_orden_produccion
						,@id_usuario
						,@id_sucursal
						,@observacion
						,'Pendiente'
						,@id_usuario
						,GETDATE()
				)					
		END

		ELSE  
		BEGIN  
			  UPDATE Almacen.Nota_Ingreso    
			  SET     
				  id_motivo			=@id_motivo
				,id_orden_compra	=@id_orden_compra
				,id_orden_produccion=@id_orden_produccion
				,observacion		=@observacion
				,usuario_modifico	=@id_usuario
				,fecha_modifico		=GETDATE()
			  WHERE id_nota_ingreso =@id_nota_ingreso    

			  SET @NuevoId = @id_nota_ingreso

			  DELETE FROM Almacen.Detalle_Nota_Ingreso WHERE id_nota_ingreso =@id_nota_ingreso
		END  


		INSERT INTO Almacen.Detalle_Nota_Ingreso(  
						 id_nota_ingreso
						,id_producto
						,cantidad
						,descripcion
				 )  
			 SELECT  
						 @NuevoId
						,id_producto
						,cantidad
						,descripcion
			 FROM @TYPE_DETALLENOTA

			------------------------------------------------------------------------
			-- ACTUALIZAR EL STOCK DEL PRODUCTO
			------------------------------------------------------------------------
			IF @id_orden_compra > 0
			BEGIN
				UPDATE Compras.Orden_Compra Set estado = 'Atendido' Where id_orden_compra = @id_orden_compra

				UPDATE S
				SET S.stock = S.stock + D.cantidad
				FROM Almacen.Stock_Producto S
					INNER JOIN Almacen.Detalle_Nota_Ingreso D ON S.id_producto = D.id_producto 
					INNER JOIN Almacen.Nota_Ingreso N ON D.id_nota_ingreso = N.id_nota_ingreso AND S.id_sucursal = N.id_sucursal
				WHERE N.id_orden_compra = @id_orden_compra
			END

			--IF @id_orden_produccion > 0
			--BEGIN
			--	UPDATE Produccion.Orden_Produccion Set estado = 'Atendido' Where id_orden_produccion = @id_orden_produccion

			--	UPDATE S
			--	SET S.stock = S.stock + D.cantidad
			--	FROM Almacen.Stock_Producto S
			--		INNER JOIN Almacen.Detalle_Nota_Ingreso D ON S.id_producto = D.id_producto 
			--		INNER JOIN Almacen.Nota_Ingreso N ON D.id_nota_ingreso = N.id_nota_ingreso AND S.id_sucursal = N.id_sucursal
			--	WHERE N.id_orden_produccion = @id_orden_produccion
			--END

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION


GO
/****** Object:  StoredProcedure [Almacen].[spGuardar_Producto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spGuardar_Producto]
@id_producto int,
@descripcion nvarchar(255),
@unidad_med nvarchar(3),
@precio_min decimal(18,2),
@precio_max decimal(18,2),
@id_marca int,
@id_categoria int,
@estado smallint,
@usuario_registro int
AS
DECLARE @VALOR INT
BEGIN TRANSACTION
	
	IF EXISTS(SELECT id_producto FROM Almacen.Producto WHERE descripcion=@descripcion AND id_producto!= @id_producto AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION 
		SET @VALOR= -2
		RETURN @VALOR
	END

	IF @id_producto<=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_producto + 1 FROM Almacen.Producto ORDER BY id_producto DESC),1)
		INSERT INTO Almacen.Producto(
					id_producto,
					descripcion,
					unidad_med,
					precio_min,
					precio_max,
					id_marca,
					id_categoria,
					estado,
					usuario_registro,
					fecha_registro
			) VALUES(
					@NuevoId,
					@descripcion,
					@unidad_med,
					@precio_min,
					@precio_max,
					@id_marca,
					@id_categoria,
					@estado,
					@usuario_registro,
					GETDATE()
			)
	END
	ELSE
	BEGIN 
		UPDATE Almacen.Producto
		SET
			descripcion	=@descripcion,
			unidad_med	=@unidad_med,
			precio_min	=@precio_min,
			precio_max	=@precio_max,
			id_marca	=@id_marca,
			id_categoria=@id_categoria,
			estado		=@estado,
			usuario_modifico = @usuario_registro,
			fecha_modifico = GETDATE()
		WHERE 
			id_producto	=@id_producto
	END
	SET @VALOR=1

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR



GO
/****** Object:  StoredProcedure [Almacen].[spListar_Categoria]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spListar_Categoria]
@id_categoria int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT 
					 C.id_categoria
					,C.descripcion
					,C.estado
			FROM 
					Almacen.Categoria C
			WHERE   
					(C.id_categoria=@id_categoria OR @id_categoria = 0) 
					AND C.estado != 2

	END


GO
/****** Object:  StoredProcedure [Almacen].[spListar_DetalleNota]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spListar_DetalleNota]
@id_nota int,
@tipo varchar(20)
AS
	BEGIN
		IF @tipo = 'NotaIngreso'
		BEGIN
			SELECT * FROM Almacen.Detalle_Nota_Ingreso
			WHERE id_nota_ingreso = @id_nota
		END
	END


GO
/****** Object:  StoredProcedure [Almacen].[spListar_Marca]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spListar_Marca]
@id_marca int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT 
					 M.id_marca
					,M.descripcion
					,M.estado
			FROM 
					Almacen.Marca M
			WHERE   
					(M.id_marca=@id_marca OR @id_marca = 0) 
					AND M.estado != 2

	END


GO
/****** Object:  StoredProcedure [Almacen].[spListar_Producto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spListar_Producto]
@id_producto int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	select 
			 P.id_producto
			,P.descripcion
			,P.unidad_med
			,P.precio_min
			,P.precio_max
			,P.id_marca
			,P.id_categoria
			,P.estado
			,M.descripcion as marca
			,C.descripcion as categoria
	from 
			Almacen.Producto P
			INNER JOIN Almacen.Marca		M ON P.id_marca		= M.id_marca
			INNER JOIN Almacen.Categoria	C ON P.id_categoria	= C.id_categoria
	where 
			(P.id_producto = @id_producto OR @id_producto = 0)
			AND P.estado!=2
END


GO
/****** Object:  StoredProcedure [Almacen].[spListar_StockProducto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Almacen].[spListar_StockProducto]
@id_producto int,
@id_sucursal int
AS
	BEGIN
			SELECT
					 P.id_producto
					,S.descripcion as sucursal
					,RTRIM(P.descripcion) as producto
					,C.descripcion as categoria
					,M.descripcion as marca
					,SP.cpm
					,P.precio_min
					,P.precio_max
					,SP.stock
					,P.estado
			FROM 
					Almacen.Stock_Producto SP
					INNER JOIN Logistica.Sucursal S	ON SP.id_sucursal	=S.id_sucursal
					INNER JOIN Almacen.Producto P	ON SP.id_producto	=P.id_producto
					INNER JOIN Almacen.Marca M		ON P.id_marca		=M.id_marca
					INNER JOIN Almacen.Categoria C	ON P.id_categoria	=C.id_categoria
			WHERE   
					(P.id_producto = @id_producto OR @id_producto = 0)
					AND (S.id_sucursal = @id_sucursal OR @id_sucursal = 0)
					AND P.estado=1
	END



GO
/****** Object:  StoredProcedure [Compras].[spGuardar_ComprobanteCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spGuardar_ComprobanteCompra]
@id_compra int,
@id_proveedor int,
@id_contacto_proveedor int,
@id_tipo_documento int,
@id_usuario	int,
@id_sucursal int,
@id_tipo_pago int,
@id_moneda int,
@sub_total decimal(18,2),
@igv decimal(18,2),
@total decimal(18,2),
@TYPE_DETALLECOMPRA AS dbo.DetalleCompra READONLY 
AS
	BEGIN TRANSACTION
		DECLARE @NuevoId INT

		IF @id_compra <= 0
		BEGIN
			SET @NuevoId = ISNULL((SELECT TOP 1 id_compra + 1 FROM Compras.ComprobanteCompra ORDER BY id_compra DESC),1)

			DECLARE @NuevaSerie NCHAR(5)
			SET @NuevaSerie = ISNULL((SELECT TOP 1 RIGHT('0000'+LTRIM(RIGHT(ISNULL(C.numero,'0000'),5)+1),5) 
								FROM Compras.ComprobanteCompra C INNER JOIN Logistica.Sucursal S	ON C.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY C.id_compra DESC),'00001')
			
			DECLARE @NuevoNumero NCHAR(8)
			SET @NuevoNumero = ISNULL((SELECT TOP 1 RIGHT('0000000'+LTRIM(RIGHT(ISNULL(C.numero,'0000000'),8)+1),8) 
								FROM Compras.ComprobanteCompra C INNER JOIN Logistica.Sucursal S	ON C.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY C.id_compra DESC),'00000001')

			INSERT INTO Compras.ComprobanteCompra(
						 id_compra
						,serie
						,numero
						,fecha
						,estado
						,id_proveedor
						,id_contacto_proveedor
						,id_tipo_documento						
						,id_usuario
						,id_sucursal						
						,id_tipo_pago
						,id_moneda
						,sub_total
						,igv
						,total						
						,observacion
						,usuario_registro
						,fecha_registro
				)
				VALUES( 
						 @NuevoId
						,@NuevaSerie
						,@NuevoNumero
						,GETDATE()
						,1
						,@id_proveedor
						,@id_contacto_proveedor
						,@id_tipo_documento
						,@id_usuario						
						,@id_sucursal
						,@id_tipo_pago
						,@id_moneda
						,@sub_total
						,@igv
						,@total
						,''
						,@id_usuario
						,GETDATE()
				)	
				
				------------------------------------------------------------------------
				-- REGISTRAR CUENTA DE DEUDA AL PROVEEDOR
				------------------------------------------------------------------------
				DECLARE @DESCRIPCIONPAGO NVARCHAR(50) = (SELECT descripcion FROM Comunes.Tipo_Pago WHERE id_tipo_pago = @id_tipo_pago)
				IF (@DESCRIPCIONPAGO = 'CRÉDITO' OR @DESCRIPCIONPAGO = 'CREDITO')
				BEGIN
					DECLARE @NuevoId_Cuenta INT = ISNULL((SELECT TOP 1 id_cuenta_proveedor + 1 FROM Compras.Cuenta_Proveedor ORDER BY id_cuenta_proveedor DESC),1)

					INSERT INTO Compras.Cuenta_Proveedor(
									 id_cuenta_proveedor
									,monto
									,saldo
									,acuenta
									,fecha
									,id_proveedor
									,id_compra
									,id_sucursal
									,id_usuario
									,estado
							)
							VALUES(
									 @NuevoId_Cuenta
									,@total
									,@total
									,0
									,GETDATE()
									,@id_proveedor
									,@NuevoId
									,@id_sucursal
									,@id_usuario
									,'DEBE'
							)
				END			
		END

		ELSE  
		BEGIN  
			  UPDATE Compras.ComprobanteCompra    
			  SET 
				 id_proveedor			=@id_proveedor
				,id_contacto_proveedor	=@id_contacto_proveedor
				,id_tipo_documento		=@id_tipo_documento
				,id_tipo_pago			=@id_tipo_pago
				,id_moneda				=@id_moneda
				,sub_total				=@sub_total
				,igv					=@igv
				,total					=@total				
				,usuario_modifico		=@id_usuario
				,fecha_modifico			=GETDATE()
			  WHERE 
					id_compra			=@id_compra 

			  SET @NuevoId = @id_compra

			  DELETE FROM Compras.Detalle_Compra WHERE id_compra = @id_compra
		END  

		INSERT INTO Compras.Detalle_Compra(  
						 id_compra
						,id_nota_ingreso
						,id_producto
						,cantidad
						,descripcion
						,precio
						,importe
				 )  
			 SELECT  
						 @NuevoId
						,id_nota_ingreso
						,id_producto						
						,cantidad
						,descripcion
						,precio
						,importe  
			 FROM @TYPE_DETALLECOMPRA

			UPDATE N SET N.estado = 'Registrado'
			FROM Almacen.Nota_Ingreso N
				INNER JOIN Compras.Detalle_Compra DC ON N.id_nota_ingreso = DC.id_nota_ingreso
			WHERE DC.id_compra = @NuevoId

		
	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION


GO
/****** Object:  StoredProcedure [Compras].[spGuardar_ContactoProveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spGuardar_ContactoProveedor]
 @id_contacto_proveedor int
,@nombres varchar(50)
--,@apellidos varchar(50)
,@dni varchar(11)
,@correo varchar(50)
,@telefono varchar(12)
,@celular varchar(12)
,@estado smallint
,@id_proveedor int
,@usuario_registro int
AS
	
DECLARE @VALOR INT
BEGIN TRANSACTION

	IF EXISTS(SELECT id_contacto_proveedor FROM Compras.Contacto_Proveedor WHERE dni = @dni AND id_contacto_proveedor != @id_contacto_proveedor)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		Return @VALOR
	END

	IF @id_contacto_proveedor <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_contacto_proveedor + 1 FROM Compras.Contacto_Proveedor ORDER BY id_contacto_proveedor DESC),1)
		INSERT INTO Compras.Contacto_Proveedor(
					 id_contacto_proveedor
					,nombres
					,apellidos
					,dni					
					,correo
					,telefono
					,celular
					,estado
					,id_proveedor
					,usuario_registro
					,fecha_registro				
			)
			VALUES( 
					 @NuevoId
					,@nombres
					,''--@apellidos
					,@dni					
					,@correo
					,@telefono
					,@celular
					,1
					,@id_proveedor
					,@usuario_registro
					,GETDATE()					
			)
	END

	ELSE
	BEGIN
		UPDATE Compras.Contacto_Proveedor
		SET
				 nombres = @nombres
				,apellidos = ''--@apellidos
				,dni = @dni				
				,correo = @correo
				,telefono = @telefono
				,celular = @celular
				,estado = @estado
				,id_proveedor = @id_proveedor
				,usuario_modifico = @usuario_registro
				,fecha_modifico = GETDATE()				
		WHERE
				id_contacto_proveedor = @id_contacto_proveedor
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR



GO
/****** Object:  StoredProcedure [Compras].[spGuardar_OrdenCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spGuardar_OrdenCompra]
@id_orden_compra int,
@fecha_vencimiento date,
@sub_total decimal(18,2),
@igv decimal(18,2),
@total decimal(18,2),
@id_proveedor int,
@id_contacto_proveedor int,
@id_moneda int,
@id_sucursal int,
@id_usuario	int,
@TYPE_DETALLEORDENCOMPRA AS dbo.DetalleCompra READONLY 
AS
	BEGIN TRANSACTION
		DECLARE @NuevoId INT

		IF @id_orden_compra <= 0
		BEGIN
			SET @NuevoId = ISNULL((SELECT TOP 1 id_orden_compra + 1 FROM Compras.Orden_Compra ORDER BY id_orden_compra DESC),1)
			
			DECLARE @NuevoNumero NVARCHAR(10)
			SET @NuevoNumero = ISNULL((SELECT TOP 1 RIGHT('000000000'+LTRIM(RIGHT(ISNULL(O.numero,'000000000'),10)+1),10) 
								FROM Compras.Orden_Compra O INNER JOIN Logistica.Sucursal S	ON O.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY O.id_orden_compra DESC),'0000000001')

			INSERT INTO Compras.Orden_Compra(
						 id_orden_compra
						,numero
						,fecha
						,fecha_vencimiento						
						,id_proveedor
						,id_contacto_proveedor
						,id_moneda
						,id_sucursal
						,id_usuario
						,sub_total
						,igv
						,total						
						,observacion
						,estado
						,usuario_registro
						,fecha_registro
				)
				VALUES( 
						 @NuevoId
						,@NuevoNumero
						,GETDATE()
						,@fecha_vencimiento
						,@id_proveedor
						,@id_contacto_proveedor
						,@id_moneda
						,@id_sucursal
						,@id_usuario
						,@sub_total
						,@igv
						,@total
						,''
						,'Pendiente'
						,@id_usuario
						,GETDATE()
				)			
		END

		ELSE  
		BEGIN  
			  UPDATE Compras.Orden_Compra    
			  SET 
				 fecha_vencimiento		=@fecha_vencimiento
				,id_proveedor			=@id_proveedor
				,id_contacto_proveedor	=@id_contacto_proveedor
				,id_moneda				=@id_moneda
				,sub_total				=@sub_total
				,igv					=@igv
				,total					=@total				
				,usuario_modifico		=@id_usuario
				,fecha_modifico			=GETDATE()
			  WHERE id_orden_compra		=@id_orden_compra 

			  SET @NuevoId = @id_orden_compra

			  DELETE FROM Compras.Detalle_Orden_Compra WHERE id_orden_compra = @id_orden_compra
		END  

		INSERT INTO Compras.Detalle_Orden_Compra(  
						 id_orden_compra
						,id_producto
						,cantidad
						,descripcion
						,precio
						,importe
				 )  
			 SELECT  
						 @NuevoId
						,id_producto
						,cantidad
						,descripcion
						,precio
						,importe  
			 FROM @TYPE_DETALLEORDENCOMPRA

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION


GO
/****** Object:  StoredProcedure [Compras].[spGuardar_Proveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spGuardar_Proveedor]
@id_proveedor int,
@razon_social nvarchar(100),
@dni_ruc nvarchar(11),
@direccion nvarchar(100),
@correo nvarchar(50),
@telefono nvarchar(12),
@celular nvarchar(12),
@estado smallint,
@usuario_registro int
AS
	
DECLARE @VALOR INT
BEGIN TRANSACTION

	IF EXISTS(SELECT id_proveedor FROM Compras.Proveedor WHERE dni_ruc = @dni_ruc AND id_proveedor != @id_proveedor AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		Return @VALOR
	END

	IF EXISTS(SELECT id_proveedor FROM Compras.Proveedor WHERE razon_social = @razon_social AND id_proveedor != @id_proveedor AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -3
		Return @VALOR
	END

	IF @id_proveedor <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_proveedor + 1 FROM Compras.Proveedor ORDER BY id_proveedor DESC),1)
		INSERT INTO Compras.Proveedor(
					id_proveedor
					,razon_social
					,dni_ruc
					,direccion
					,correo
					,telefono
					,celular
					,estado
					,usuario_registro
					,fecha_registro
			)
			VALUES( 
					 @NuevoId
					,@razon_social					
					,@dni_ruc					
					,@direccion
					,@correo
					,@telefono
					,@celular
					,1					
					,@usuario_registro
					,GETDATE()					
			)
	END

	ELSE
	BEGIN
		UPDATE Compras.Proveedor
		SET
				 razon_social = @razon_social
				,dni_ruc = @dni_ruc				
				,direccion = @direccion
				,correo = @correo
				,telefono = @telefono
				,celular = @celular
				,estado = @estado
				,usuario_modifico = @usuario_registro
				,fecha_modifico = GETDATE()
				
		WHERE
				id_proveedor = @id_proveedor
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR



GO
/****** Object:  StoredProcedure [Compras].[spListar_ContactoProveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spListar_ContactoProveedor]
@id_contacto_proveedor int,
@dni nchar(8),
@id_proveedor int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT 
				 CP.id_contacto_proveedor
				,(CP.nombres + ' ' + CP.apellidos) as nombres
				,CP.dni
				,CP.correo		
				,CP.telefono
				,CP.celular
				,CP.estado
				,CP.id_proveedor
				,P.razon_social
				,P.dni_ruc
		FROM 
				Compras.Contacto_Proveedor CP
				INNER JOIN Compras.Proveedor P ON CP.id_proveedor = P.id_proveedor
		WHERE	
				(CP.id_contacto_proveedor = @id_contacto_proveedor OR @id_contacto_proveedor = 0)
				AND (CP.id_proveedor = @id_proveedor OR @id_proveedor = 0)
				AND (CP.dni = @dni OR @dni = '')
				AND CP.estado != 2
	END


GO
/****** Object:  StoredProcedure [Compras].[spListar_DetalleOrdenCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spListar_DetalleOrdenCompra]
@id_orden_compra int,
@tipo nvarchar(20)
AS
	BEGIN
		IF @tipo = 'orden'
		BEGIN
			SELECT 
					OC.id_producto,
					OC.cantidad,
					OC.descripcion,					
					OC.precio,
					OC.importe
			FROM 
					Compras.Detalle_Orden_Compra OC
			WHERE
					OC.id_orden_compra=@id_orden_compra
		END

		IF @tipo = 'compra'
		BEGIN
			SELECT 
					C.id_producto,
					C.cantidad,
					C.descripcion,					
					C.precio,
					C.importe
			FROM 
					Compras.Detalle_Compra C
			WHERE
					C.id_compra=@id_orden_compra
		END
	END


GO
/****** Object:  StoredProcedure [Compras].[spListar_OrdenCompraDetalle]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spListar_OrdenCompraDetalle]
@id_orden_compra int
AS
	BEGIN
		SELECT 
				O.id_orden_compra,
				O.sub_total,
				O.igv,
				O.total,
				CONVERT(VARCHAR(25), O.fecha_vencimiento,  105) as fecha_vencimiento,
				O.id_proveedor,
				P.dni_ruc,
				P.razon_social,
				O.id_contacto_proveedor,
				CP.dni,
				(CP.nombres + ' ' + CP.apellidos) as contacto,
				O.id_moneda,
				M.descripcion as moneda,
				PR.id_producto,
				DOC.cantidad,
				DOC.descripcion,					
				DOC.precio,
				DOC.importe
		FROM 
				Compras.Orden_Compra O
				INNER JOIN Compras.Proveedor			P	ON	O.id_proveedor			=P.id_proveedor
				INNER JOIN Compras.Contacto_Proveedor	CP	ON	O.id_contacto_proveedor	=CP.id_contacto_proveedor
				INNER JOIN Logistica.Moneda				M	ON	O.id_moneda				=M.id_moneda
				INNER JOIN Compras.Detalle_Orden_Compra	DOC	ON	O.id_orden_compra		=DOC.id_orden_compra
				INNER JOIN Almacen.Producto				PR	ON	DOC.id_producto			=PR.id_producto
		WHERE
				O.estado='Pendiente'
				AND O.id_orden_compra = @id_orden_compra
	END


GO
/****** Object:  StoredProcedure [Compras].[spListar_OrdenesCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spListar_OrdenesCompra]
@id_sucursal int,
@fecha_inicio date,
@fecha_fin date
AS
	BEGIN
		SELECT
				 O.id_orden_compra
				,CONVERT(VARCHAR(25), O.fecha,  105) as fecha
				,CONVERT(VARCHAR(25), O.fecha_vencimiento,  105) as fecha_vencimiento
				,O.total
				,O.id_proveedor
				,P.razon_social
				,O.id_contacto_proveedor
				,(CP.nombres + ' ' + CP.apellidos) as nombres
				,O.id_moneda
				,M.descripcion as moneda
				,S.descripcion as sucursal
				,O.estado
		FROM 
				Compras.Orden_Compra O
				INNER JOIN Compras.Proveedor			P	ON	O.id_proveedor			=P.id_proveedor
				INNER JOIN Compras.Contacto_Proveedor	CP	ON	O.id_contacto_proveedor	=CP.id_contacto_proveedor
				INNER JOIN Logistica.Moneda				M	ON	O.id_moneda				=M.id_moneda
				INNER JOIN Logistica.Sucursal			S	ON	O.id_sucursal			=S.id_sucursal
		WHERE
				O.estado='Pendiente'
				AND (O.id_sucursal = @id_sucursal OR @id_sucursal = 0)
				AND CONVERT(DATE, O.fecha) BETWEEN @fecha_inicio AND @fecha_fin
		ORDER BY
				O.id_orden_compra DESC
	END


GO
/****** Object:  StoredProcedure [Compras].[spListar_Proveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Compras].[spListar_Proveedor]
@id_proveedor int,
@dni_ruc varchar(11)
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @Total AS MONEY = ISNULL ((SELECT TOP 1 C.total FROM Compras.ComprobanteCompra C INNER JOIN Compras.Proveedor P ON C.id_proveedor=P.id_proveedor
										WHERE P.dni_ruc=@dni_ruc ORDER BY C.id_compra DESC),0.00)

		SELECT 
				 P.id_proveedor
				,P.razon_social
				,P.dni_ruc
				,P.direccion
				,P.correo
				,P.telefono
				,P.celular
				,P.estado
				,@Total AS total
		FROM 
				Compras.Proveedor P
		WHERE   
				(P.id_proveedor = @id_proveedor OR @id_proveedor = 0)
				AND (P.dni_ruc= @dni_ruc OR @dni_ruc = '') 
				AND P.estado != 2
	END


GO
/****** Object:  StoredProcedure [Comunes].[spEliminar_Datos]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spEliminar_Datos]
@tabla varchar(50),
@estado varchar(50),
@campo varchar(20),
@id_tabla varchar(20)

AS
	BEGIN
		DECLARE @texto NVARCHAR(MAX)
             SET @texto  = ' UPDATE ' + @tabla + ' SET estado = ' + @estado + ' WHERE ' + @campo + ' = ' + @id_tabla
	    EXEC(@texto)
	END

	



GO
/****** Object:  StoredProcedure [Comunes].[spEliminar_DatosTT]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spEliminar_DatosTT]
@tabla varchar(50),
@TYPE_BASEID AS dbo.Elimina_Datos READONLY
AS
	BEGIN
		IF @tabla = 'Cliente'
		BEGIN
			UPDATE C 
				SET estado = 2
			FROM	
				Ventas.CLiente C INNER JOIN @TYPE_BASEID TB
				ON C.id_cliente = TB.id_tabla
		END

		IF @tabla = 'Producto'
		BEGIN
			UPDATE P 
				SET estado = 2
			FROM	
				Almacen.Producto P INNER JOIN @TYPE_BASEID TB
				ON P.id_producto = TB.id_tabla
		END

		IF @tabla = 'Proveedor'
		BEGIN
			UPDATE P 
				SET estado = 2
			FROM	
				Compras.Proveedor P INNER JOIN @TYPE_BASEID TB
				ON P.id_proveedor = TB.id_tabla
		END
		 
		--DECLARE @texto NVARCHAR(MAX)
		--	SET @texto  = ' UPDATE TT SET estado = ' + @estado + ' FROM ' + @tabla + ' TT INNER JOIN @TYPE_BASEID TB ON TT.' + @campo + ' = TB.id_tabla ';
	 --   EXEC(@texto)

		
	END


GO
/****** Object:  StoredProcedure [Comunes].[spGuardar_TipoDocumento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spGuardar_TipoDocumento]
 @id_tipo_documento int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_tipo_documento FROM Comunes.Tipo_Documento WHERE descripcion = @descripcion AND id_tipo_documento != @id_tipo_documento AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_tipo_documento <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_tipo_documento + 1 FROM Comunes.Tipo_Documento ORDER BY id_tipo_documento DESC),1)
		INSERT INTO Comunes.Tipo_Documento(
					 id_tipo_documento
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE Comunes.Tipo_Documento
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_tipo_documento = @id_tipo_documento
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR



GO
/****** Object:  StoredProcedure [Comunes].[spGuardar_TipoPago]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spGuardar_TipoPago]
 @id_tipo_pago int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_tipo_pago FROM Comunes.Tipo_Pago WHERE descripcion = @descripcion AND id_tipo_pago != @id_tipo_pago AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_tipo_pago <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_tipo_pago + 1 FROM Comunes.Tipo_Pago ORDER BY id_tipo_pago DESC),1)
		INSERT INTO Comunes.Tipo_Pago(
					 id_tipo_pago
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE Comunes.Tipo_Pago
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_tipo_pago = @id_tipo_pago
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Comunes].[spListar_Motivo]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spListar_Motivo]
@id_motivo int,
@tipo nvarchar(50)
AS
	BEGIN
		SET NOCOUNT ON
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT 
				 M.id_motivo
				,M.descripcion
				,M.tipo
				,M.estado
		FROM 
				Comunes.Motivo M
		WHERE   
				(M.id_motivo = @id_motivo OR @id_motivo = 0)
				AND (M.tipo = @tipo OR @tipo = '' OR M.tipo = 'T') 
				AND M.estado != 2
	END


GO
/****** Object:  StoredProcedure [Comunes].[spListar_Ordenes_Notas]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spListar_Ordenes_Notas]
@tipo nvarchar(50)
AS
	BEGIN
		IF @tipo = 'compra'
		BEGIN
			SELECT 
					 id_orden_compra
					,numero
					,CONVERT(VARCHAR(25), fecha,  105) as fecha
			FROM 
					Compras.Orden_Compra
			WHERE
					estado = 'Pendiente'
		END

		IF @tipo = 'notaingreso'
		BEGIN
			SELECT 
					 id_nota_ingreso
					,numero
					,CONVERT(VARCHAR(25), fecha,  105) as fecha
			FROM 
					Almacen.Nota_Ingreso
			WHERE
					estado = 'Pendiente'
		END
	END


GO
/****** Object:  StoredProcedure [Comunes].[spListar_TipoDocumento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spListar_TipoDocumento]
@id_tipo_documento int
AS
	BEGIN
		SELECT 
				 TP.id_tipo_documento
				,TP.descripcion
				,TP.estado
		FROM 
				Comunes.Tipo_Documento TP
		WHERE   
				(TP.id_tipo_documento = @id_tipo_documento OR @id_tipo_documento = 0)
				AND TP.estado != 2
	END


GO
/****** Object:  StoredProcedure [Comunes].[spListar_TipoPago]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Comunes].[spListar_TipoPago]
@id_tipo_pago int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT 
					 TP.id_tipo_pago
					,TP.descripcion
					,TP.estado
			FROM 
					Comunes.Tipo_Pago TP
			WHERE   
					(TP.id_tipo_pago=@id_tipo_pago OR @id_tipo_pago = 0) 
					AND TP.estado != 2

	END


GO
/****** Object:  StoredProcedure [dbo].[spActualizar_CuentaCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizar_CuentaCliente]
@id_cliente int,
@id_cuenta_cliente int,
@id_venta	int,
@pago money
AS
	BEGIN
		DECLARE @saldo AS MONEY
		DECLARE @debe AS MONEY

		DECLARE CURSOR_CUENTACLIENTE CURSOR  FOR
			SELECT 
					 CC.id_cuenta_cliente
					,CC.saldo 
			FROM 
					Ventas.Cuenta_Cliente CC 
					INNER JOIN Ventas.Venta V ON CC.id_venta=V.id_venta
			WHERE	
					CC.id_cliente			=@id_cliente  
					AND CC.id_cuenta_cliente=@id_cuenta_cliente
					AND V.id_venta			=@id_venta
					AND CC.ESTADO='DEBE'

		
		OPEN CURSOR_CUENTACLIENTE
		FETCH NEXT FROM CURSOR_CUENTACLIENTE
		  INTO @id_cuenta_cliente,@saldo
			WHILE @@FETCH_STATUS = 0 
			BEGIN 
 				IF @pago=@saldo -- Si el monto que pagas es igual a lo que debes
 					BEGIN
 						UPDATE Ventas.Cuenta_Cliente SET 
													acuenta	=@pago,
													Saldo	=0,
													estado	='PAGÓ'
						WHERE 
								id_cuenta_cliente=@id_cuenta_cliente

 						INSERT INTO Ventas.Detalle_Cuenta_Cliente(
															id_cuenta_cliente,
															fecha,
															pago,
															debe)
 													VALUES(
															@id_cuenta_cliente,
															GETDATE(),
															@pago,
															0)		
 						BREAK				
 					END
		 		
 				IF @pago<@saldo -- Si el monto que pagas es menor a lo que debes
 				BEGIN
 					SET @debe=(SELECT saldo FROM Ventas.Cuenta_Cliente WHERE id_cuenta_cliente=@id_cuenta_cliente)
 						UPDATE Ventas.Cuenta_Cliente SET 
													acuenta	=@pago + acuenta, 
													saldo	=monto - (@pago + ACuenta)
 						WHERE 
								id_cuenta_cliente=@id_cuenta_cliente

 						INSERT INTO Ventas.Detalle_Cuenta_Cliente(
															id_cuenta_cliente,
															fecha,
															pago,
															debe)
 													VALUES(
															@id_cuenta_cliente,
															GETDATE(),
															@pago,
															(@debe-@pago))
					BREAK
 				END

		 		FETCH NEXT FROM CURSOR_CUENTACLIENTE
				INTO @id_cuenta_cliente,@saldo

			END 
		  CLOSE CURSOR_CUENTACLIENTE
		  DEALLOCATE CURSOR_CUENTACLIENTE
	END




GO
/****** Object:  StoredProcedure [dbo].[spActualizarPersonal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActualizarPersonal]
@id_personal int,
@nombres varchar(50),
@apellidos varchar(50),
@dni int,
@fecha_nac date,
@sexo char(1),
@direccion varchar(50),
@correo varchar(50),
@telefono varchar(50),
@celular varchar(50),
@imagen varchar(100),
@id_usuario int
AS
	BEGIN
		UPDATE Personal SET
				nombres			= @nombres,
				apellidos		= @apellidos,
				dni				= @dni,
				fecha_nac		= @fecha_nac,
				sexo			= @sexo,
				direccion		= @direccion,
				correo			= @correo,
				telefono		= @telefono,
				celular			= @celular,
				imagen			= @imagen,
				usuario_modifico= @id_usuario,
				fecha_modifico	= GETDATE()
		WHERE
				id_personal		= @id_personal
	END


GO
/****** Object:  StoredProcedure [dbo].[spAdelantar_Sueldo]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAdelantar_Sueldo]
@id_personal int,
@monto money
AS
	BEGIN
		DECLARE @NewId INT
			SELECT TOP 1 @NewId = id_adelanto + 1 FROM Adelanto ORDER BY id_adelanto DESC
			IF @NewId IS NULL SET @NewId = 1

		INSERT INTO Adelanto(
								 id_adelanto
								,fecha
								,monto
								,estado
								,id_personal
							)
						VALUES(
								 @NewId
								,GETDATE()
								,@monto
								,'DEUDA'
								,@id_personal
							)
	END


GO
/****** Object:  StoredProcedure [dbo].[spGestionar_Evento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGestionar_Evento]
@id_evento int,
@fecha_inicio datetime,
@fecha_fin datetime,
@nombre varchar(200),
@ubicacion varchar(200),
@descripcion varchar(500),
@id_usuario int
AS
	BEGIN
		IF @id_evento = 0
			BEGIN
					DECLARE @NewId INT
					SELECT TOP 1 @NewId = id_evento + 1 FROM Evento ORDER BY id_evento DESC

					INSERT INTO Evento(
										id_evento,
										fecha_inicio,
										fecha_fin,
										nombre,
										ubicacion,
										descripcion,
										id_usuario,
										estado,
										usuario_registro,
										fecha_registro) 
							VALUES (
										@id_evento,
										@fecha_inicio,
										@fecha_fin,
										@nombre,
										@ubicacion,
										@descripcion,
										@id_usuario,
										1,
										@id_usuario,
										GETDATE())
				END

			ELSE
				BEGIN
						UPDATE Evento 
								SET
										fecha_inicio	= @fecha_inicio,
										fecha_fin		= @fecha_fin,
										nombre			= @nombre,
										ubicacion		= @ubicacion,
										descripcion		= @descripcion,
										usuario_modifico= @id_usuario,
										fecha_modifico	= GETDATE()
								WHERE
										id_evento = @id_evento
				END
	END



GO
/****** Object:  StoredProcedure [dbo].[spGestionar_Personal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGestionar_Personal]
@prmstrCadXML varchar(max)
AS
	Declare @h int
	Declare @intPKPedido int
Begin Transaction
	EXEC sp_xml_preparedocument @h output, @prmstrCadXML

	DECLARE @NewId INT
			SELECT TOP 1 @NewId = id_personal + 1 FROM Personal ORDER BY id_personal DESC


	SELECT		id_personal, 
				nombres,
				apellidos,
				dni,
				fecha_nac,
				sexo,
				direccion,
				correo,
				telefono,
				celular,
				sueldo,
				id_sucursal,
				id_tipo_personal,
				usuario_registro
	INTO #PersonalXML
	FROM openXML(@h, '/root/Personal', 1) WITH(
				id_personal int,
				nombres varchar(50),
				apellidos varchar(50),
				dni varchar(11),
				fecha_nac date,
				sexo char(1),
				direccion varchar(50),
				correo varchar(50),
				telefono varchar(12),
				celular varchar(12),
				sueldo money,
				id_sucursal int,
				id_tipo_personal int,
				usuario_registro int) X

	--Valida DNI iguales
	IF( SELECT count(*) 
		FROM Personal P INNER JOIN #PersonalXML X ON P.dni = X.dni
		WHERE P.id_personal <> X.id_personal)>0
	begin
		Rollback Transaction
		SET @intPKPedido = -2
		Return @intPKPedido
	end

	--Insertar Personal
	INSERT INTO Personal(
						id_personal, 
						nombres,
						apellidos,
						dni,
						fecha_nac,
						sexo,
						direccion,
						correo,
						telefono,
						celular,
						sueldo,
						id_sucursal,
						id_tipo_personal,
						estado,
						usuario_registro,
						fecha_registro
			)SELECT 
						@NewId, 
						X.nombres,
						X.apellidos,
						X.dni,
						X.fecha_nac,
						X.sexo,
						X.direccion,
						X.correo,
						X.telefono,
						X.celular,
						X.sueldo,
						X.id_sucursal,
						X.id_tipo_personal,
						1,
						X.usuario_registro,
						GETDATE()
			FROM #PersonalXML X
			WHERE X.id_personal = 0

	-- Modifica al Personal
	UPDATE P SET 
				 P.nombres				=X.nombres
				,P.apellidos			=X.apellidos
				,P.dni					=X.dni
				,P.fecha_nac			=X.fecha_nac
				,P.sexo					=X.sexo
				,P.direccion			=X.direccion
				,P.correo				=X.correo
				,P.telefono				=X.telefono
				,P.celular				=X.celular
				,P.sueldo				=X.sueldo
				,P.id_sucursal			=X.id_sucursal
				,P.id_tipo_personal		=X.id_tipo_personal
				,P.usuario_modifico		=X.usuario_registro
				,P.fecha_modifico		=GETDATE()
	FROM openXML(@h, '/root/Personal', 1) WITH(
				id_personal int,
				nombres varchar(50),
				apellidos varchar(50),
				dni varchar(11),
				fecha_nac date,
				sexo char(1),
				direccion varchar(50),
				correo varchar(50),
				telefono varchar(12),
				celular varchar(12),
				sueldo money,
				id_sucursal int,
				id_tipo_personal int,
				usuario_registro int) X INNER JOIN Personal P ON X.id_personal = P.id_personal
	WHERE X.id_personal <> 0

	SET @intPKPedido = 1

	DROP TABLE #PersonalXML

	EXEC sp_xml_removedocument @h
	if @@Error<>0
	Begin
		Rollback Transaction
		Return -1
	End

Commit Transaction
return @intPKPedido


GO
/****** Object:  StoredProcedure [dbo].[spGestionar_Venta]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGestionar_Venta]
@id_sucursal int,
@id_numeros int,
@prmstrCadXML varchar(max)
AS
	Declare @h int
	Declare @intPKPedido int
Begin Transaction
	EXEC sp_xml_preparedocument @h output, @prmstrCadXML

	DECLARE @NewId INT
			SELECT TOP 1 @NewId = id_venta + 1 FROM Venta ORDER BY id_venta DESC
			IF @NewId IS NULL SET @NewId = 1

	DECLARE @NewSerie CHAR(3)
			SET @NewSerie = (SELECT TOP 1 V.serie FROM Venta V 
														INNER JOIN Numero_Documento	ND	ON	V.id_numeros		=ND.id_numeros
														INNER JOIN Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
														INNER JOIN Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
														WHERE V.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal
														ORDER BY V.id_venta DESC)

			IF @NewSerie IS NULL SET @NewSerie =(SELECT ND.serie FROM Numero_Documento ND
														INNER JOIN Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
														INNER JOIN Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
														WHERE ND.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal)
	DECLARE @NewNumero CHAR(10)
			SET @NewNumero = (SELECT TOP 1 RIGHT('000000000'+LTRIM(RIGHT(ISNULL(V.Numero,'000000000'),10)+1),10) FROM Venta V 
															INNER JOIN Numero_Documento	ND	ON	V.id_numeros		=ND.id_numeros
															INNER JOIN Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
															INNER JOIN Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
															WHERE V.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal
															ORDER BY V.id_venta desc)

			IF @NewNumero IS NULL SET @NewNumero =(SELECT ND.numero FROM Numero_Documento ND
														INNER JOIN Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
														INNER JOIN Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
														WHERE ND.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal)

	--Insertar Venta
	SELECT		
				 id_venta
				,total
				,observacion
				,id_cliente
				,id_numeros
				,id_usuario
				,id_sucursal
				,id_tipo_pago
				,id_pedido
	INTO #VentaXML
	
	FROM openXML(@h, '/root/Venta', 1) WITH(
				id_venta int,
				total money,
				observacion varchar(50),
				id_cliente int,
				id_numeros int,
				id_usuario int,
				id_sucursal int,
				id_tipo_pago int,
				id_pedido int) X

	INSERT INTO Venta(
						id_venta, 
						serie,
						numero,
						fecha,
						total,
						estado,
						id_cliente,
						id_numeros,
						id_usuario,
						id_sucursal,
						id_pedido,
						id_tipo_pago,
						observacion
			)SELECT 
						@NewId, 
						@NewSerie, 
						@NewNumero,
						GETDATE(),
						X.total,
						1,
						X.id_cliente,
						X.id_numeros, --documento 
						X.id_usuario, -- usuario
						X.id_sucursal,
						X.id_pedido,
						X.id_tipo_pago,
						X.observacion
	FROM #VentaXML X
	WHERE X.id_venta = 0

	UPDATE Pedido Set estado='Registrado' Where id_pedido=(SELECT X.id_pedido FROM #VentaXML X WHERE X.id_pedido <> 0)
	UPDATE Detalle_Pedido Set id_venta=@NewId Where id_pedido=(SELECT X.id_pedido FROM #VentaXML X WHERE X.id_pedido <> 0)
	
	IF (SELECT X.id_tipo_pago FROM #VentaXML X) = 2
		BEGIN
			DECLARE @NewId_Cuenta INT
				SELECT TOP 1 @NewId_Cuenta = id_cuenta_cliente + 1 FROM Cuenta_Cliente ORDER BY id_cuenta_cliente DESC
				IF @NewId_Cuenta IS NULL SET @NewId_Cuenta = 1

			INSERT INTO Cuenta_Cliente(
										id_cuenta_cliente,
										Monto,
										Saldo,
										Acuenta,
										fecha,
										id_cliente,
										id_venta,
										id_sucursal,
										estado)
								SELECT 
										@NewId_Cuenta, 
										X.total,
										X.total,
										0,
										GETDATE(),
										X.id_cliente,
										@NewId,
										X.id_sucursal,
										'DEBE'
					FROM #VentaXML X

		END
			------------------------------------------------------------------------
			-- ACTUALIZAR EL STOCK DEL PRODUCTO
			------------------------------------------------------------------------
			declare @IDPRODUCTO as nchar(10)
			declare @CANTIDAD as float
						
			DECLARE CURSOR_VENTA CURSOR  FOR
	
				SELECT id_producto,cantidad FROM Detalle_Pedido WHERE id_venta=@NewId

			OPEN CURSOR_VENTA
				FETCH NEXT FROM CURSOR_VENTA INTO @IDPRODUCTO,@CANTIDAD				
  				WHILE @@FETCH_STATUS = 0 
			BEGIN 
 				UPDATE Stock_Producto SET Stock=Stock - @CANTIDAD WHERE id_producto=@IDPRODUCTO AND id_sucursal=@id_sucursal

				FETCH NEXT FROM CURSOR_VENTA INTO @IDPRODUCTO,@CANTIDAD	
			END 
			CLOSE CURSOR_VENTA 
			DEALLOCATE CURSOR_VENTA

	SET @intPKPedido = 1

	DROP TABLE #VentaXML

	EXEC sp_xml_removedocument @h
	if @@Error<>0
	Begin
		Rollback Transaction
		Return -1
	End

Commit Transaction
return @intPKPedido


GO
/****** Object:  StoredProcedure [dbo].[spGestionarCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGestionarCliente]
@prmstrCadXML varchar(max)
AS
	Declare @h int
	Declare @intPKPedido int
Begin Transaction
	EXEC sp_xml_preparedocument @h output, @prmstrCadXML

	DECLARE @NewId INT
			SELECT TOP 1 @NewId = id_cliente + 1 FROM Cliente ORDER BY id_cliente DESC


	SELECT		id_cliente, 
				nombres,
				dni,
				sexo,
				direccion,
				correo,
				telefono,
				celular,
				id_tipo_cliente,
				usuario_registro
	INTO #ClienteXML
	FROM openXML(@h, '/root/Cliente', 1) WITH(
				id_cliente int,
				nombres varchar(150),
				dni varchar(11),
				sexo char(1),
				direccion varchar(50),
				correo varchar(50),
				telefono varchar(12),
				celular varchar(12),
				id_tipo_cliente int,
				usuario_registro int) X

	--Valida DNI iguales
	IF( SELECT count(*) 
		FROM Cliente C INNER JOIN #ClienteXML X ON C.dni = X.dni
		WHERE C.id_cliente <> X.id_cliente)>0
	begin
		Rollback Transaction
		SET @intPKPedido = -2
		Return @intPKPedido
	end

	--Insertar Cliente
	INSERT INTO Cliente(
						id_cliente, 
						nombres,
						dni,
						sexo,
						direccion,
						correo,
						telefono,
						celular,
						estado,
						id_tipo_cliente,
						usuario_registro,
						fecha_registro
			)SELECT 
						@NewId, 
						X.nombres,
						X.dni,
						X.sexo,
						X.direccion,
						X.correo,
						X.telefono,
						X.celular,
						1,
						X.id_tipo_cliente,
						X.usuario_registro,
						GETDATE()
			FROM #ClienteXML X
			WHERE X.id_cliente = 0


	UPDATE C SET 
				 C.nombres				=X.nombres
				,C.dni					=X.dni
				,C.sexo					=X.sexo
				,C.direccion			=X.direccion
				,C.correo				=X.correo
				,C.telefono				=X.telefono
				,C.celular				=X.celular
				,C.id_tipo_cliente		=X.id_tipo_cliente
				,C.usuario_modifico		=X.usuario_registro
				,C.fecha_modifico		=GETDATE()
	FROM openXML(@h, '/root/Cliente', 1) WITH(
				id_cliente int,
				nombres varchar(150),
				dni varchar(11),
				sexo char(1),
				direccion varchar(50),
				correo varchar(50),
				telefono varchar(12),
				celular varchar(12),
				id_tipo_cliente int,
				usuario_registro int) X INNER JOIN Cliente C ON X.id_cliente = C.id_cliente
	WHERE X.id_cliente <> 0

	SET @intPKPedido = 1

	DROP TABLE #ClienteXML

	EXEC sp_xml_removedocument @h
	if @@Error<>0
	Begin
		Rollback Transaction
		Return -1
	End

Commit Transaction
return @intPKPedido


GO
/****** Object:  StoredProcedure [dbo].[spGestionarPedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGestionarPedido]
@id_sucursal int,
@id_numero int,
@prmstrCadXML varchar(max)
AS
	Declare @h int
	Declare @intPKPedido int
Begin Transaction
	EXEC sp_xml_preparedocument @h output, @prmstrCadXML

	DECLARE @NewId INT
			SELECT TOP 1 @NewId = id_pedido + 1 FROM Pedido ORDER BY id_pedido DESC
			IF @NewId IS NULL SET @NewId = 1

	--Insertar Pedido
	SELECT		
				 id_pedido
				,sub_total
				,igv
				,total
				,observacion
				,id_cliente
				,id_tipo_documento
				,id_usuario
				,id_sucursal
	INTO #PedidoXML
	
	FROM openXML(@h, '/root/Pedido', 1) WITH(
		id_pedido int,
		sub_total money,
		igv money,
		total money,
		observacion varchar(50),
		id_cliente int,
		id_tipo_documento int,
		id_usuario int,
		id_sucursal int) X

	INSERT INTO Pedido(
						id_pedido, 
						fecha,
						sub_total,
						igv,
						total,
						estado,
						id_cliente,
						id_tipo_documento,
						id_usuario,
						id_sucursal,
						observacion
			)SELECT 
						@NewId, 
						GETDATE(),
						X.sub_total,
						X.igv,
						X.total,
						'Pendiente',
						X.id_cliente,
						X.id_tipo_documento, --documento 
						X.id_usuario, -- usuario
						X.id_sucursal,
						X.observacion
	FROM #PedidoXML X
	WHERE X.id_pedido = 0


	--Insertar el Detalle del Pedido
	SELECT		
				 id_pedido
				,id_producto
				,cantidad
				,descripcion
				,precio
				,importe
	INTO #DetallePedidoXML
	
	FROM openXML(@h, '/root/DetallePedido', 1) WITH(
				id_pedido int,
				id_producto int,
				cantidad float,
				descripcion varchar(100),				
				precio money,
				importe money) DP

	INSERT INTO Detalle_Pedido(
								id_pedido, 
								id_producto, 
								cantidad,
								descripcion,
								precio,
								importe,
								id_venta
				)SELECT 
								@NewId,
								DP.id_producto, 
								DP.cantidad, 
								DP.descripcion, 
								DP.precio, 
								DP.importe,
								0
	FROM #DetallePedidoXML DP
	WHERE DP.id_pedido = 0


--***********************************************************************************

	-- Actualizar Pedido
	UPDATE P SET 
				 P.sub_total				=X.sub_total
				,P.igv						=X.igv
				,P.total					=X.total
				,P.observacion				=X.observacion
				,P.id_cliente				=X.id_cliente
				,P.id_tipo_documento		=X.id_tipo_documento
	FROM openXML(@h, '/root/Pedido', 1) WITH(
				id_pedido int,
				sub_total money,
				igv money,
				total money,
				observacion varchar(50),
				id_cliente int,
				id_tipo_documento int,
				id_usuario int,
				id_sucursal int) X INNER JOIN Pedido P ON X.id_pedido = P.id_pedido
	WHERE X.id_pedido <> 0


	--Actualizar detalle
	SELECT * INTO #DetallePedidoModXML FROM openXML(@h, '/root/DetallePedido', 1) WITH(
				id_pedido int,
				id_producto int,
				cantidad float,
				descripcion varchar(100),
				precio money,
				importe money) DPM
	DELETE FROM Detalle_Pedido WHERE id_pedido=(SELECT TOP 1 DPM.id_pedido FROM #DetallePedidoModXML DPM WHERE DPM.id_pedido <> 0)

	INSERT INTO Detalle_Pedido(
								id_pedido, 
								id_producto, 
								cantidad,
								descripcion,
								precio,
								importe,
								id_venta
				)SELECT 
								DPM.id_pedido,
								DPM.id_producto, 
								DPM.cantidad, 
								DPM.descripcion, 
								DPM.precio, 
								DPM.importe,
								0
	FROM #DetallePedidoModXML DPM
	WHERE DPM.id_pedido <> 0

	SET @intPKPedido = 1

	DROP TABLE #PedidoXML
	DROP TABLE #DetallePedidoXML
	DROP TABLE #DetallePedidoModXML

	EXEC sp_xml_removedocument @h
	if @@Error<>0
	Begin
		Rollback Transaction
		Return -1
	End

Commit Transaction
return @intPKPedido



GO
/****** Object:  StoredProcedure [dbo].[spListar_Adelantos]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_Adelantos]
@id_personal int,
@tipo varchar(20)
AS
	BEGIN
		IF @tipo='MES'
			BEGIN
					SELECT 
							 A.id_adelanto
							,CONVERT(VARCHAR(25), A.fecha,  105)as fecha
							,A.monto
							,A.id_personal
							,P.nombres
							,P.apellidos
							,A.estado
					FROM 
							Adelanto A
							INNER JOIN Personal P	ON A.id_personal= P.id_personal
					WHERE   
							MONTH(A.fecha)=(select datepart(MONTH,getdate()))
							AND A.id_personal=@id_personal
					ORDER BY A.fecha DESC
			END

		ELSE
			BEGIN
					SELECT 
							 A.id_adelanto
							,CONVERT(VARCHAR(25), A.fecha,  105)as fecha
							,A.monto
							,A.id_personal
							,P.nombres
							,P.apellidos
							,A.estado
					FROM 
							Adelanto A
							INNER JOIN Personal P	ON A.id_personal= P.id_personal
					WHERE   
							A.id_personal=@id_personal
					ORDER BY A.fecha DESC
			END

					
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_CuentaCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_CuentaCliente]
@id_cliente int,
@id_cuenta_cliente int
AS
	BEGIN
		IF @id_cliente = 0 SET @id_cliente = NULL
		IF @id_cuenta_cliente = 0 SET @id_cuenta_cliente = NULL

		 SELECT 
				CC.id_cuenta_cliente,
				C.id_cliente,
				CONVERT(VARCHAR(25), CC.fecha,  105)as fecha,
				CC.Monto,
				CC.Saldo,
				CC.Acuenta,
				C.nombres,
				CC.id_venta,
				TD.descripcion,
				V.serie,
				V.numero
		FROM 
				Cuenta_Cliente CC
					INNER JOIN Cliente			C	ON CC.id_cliente		= C.id_cliente
					INNER JOIN Venta			V	ON CC.id_venta			= V.id_venta
					INNER JOIN Numero_Documento	ND	ON V.id_numeros			= ND.id_numeros
					INNER JOIN Tipo_Documento	TD	ON ND.id_tipo_documento	= TD.id_tipo_documento
		WHERE
					C.id_cliente=ISNULL(@id_cliente,C.id_cliente) 
					AND CC.id_cuenta_cliente=ISNULL(@id_cuenta_cliente,CC.id_cuenta_cliente) 
					AND CC.estado='DEBE'
		ORDER BY CC.fecha
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_CuentaClienteDetalle]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_CuentaClienteDetalle]
@id_cliente int,
@id_cuenta_cliente int,
@id_venta int

AS
	BEGIN
			SELECT 
					CC.id_cuenta_cliente,
					C.id_cliente,
					V.id_venta,
					DP.cantidad,
					DP.descripcion,
					DP.precio,
					DP.importe 
			FROM 
					Cuenta_Cliente CC
							INNER JOIN Venta V		ON CC.id_venta	=V.id_venta
							INNER JOIN Cliente C	ON CC.id_cliente=C.id_cliente
							INNER JOIN Detalle_Pedido DP ON V.id_venta = DP.id_venta
			WHERE 
					CC.id_cuenta_cliente=@id_cuenta_cliente
					AND V.id_venta=@id_venta
					AND C.id_cliente=@id_cliente
					AND CC.estado='DEBE'
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_Evento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_Evento]
@id_evento int
AS
	BEGIN
			IF @id_evento = 0 SET @id_evento = NULL
			SELECT 
					id_evento,
					fecha_inicio,
					fecha_fin,
					nombre,
					descripcion,
					id_usuario
			FROM
					Evento
			WHERE
					id_evento=ISNULL(@id_evento,id_evento)
					AND estado=1
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_NumeroDocumento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_NumeroDocumento]
@id_numeros int,
@id_sucursal int
AS
	BEGIN
		IF @id_numeros = 0 SET @id_numeros = NULL
		IF @id_sucursal = 0 SET @id_sucursal = NULL
			SELECT 
					ND.id_numeros, 
					ND.serie, 
					ND.numero,
					TD.id_tipo_documento,
					TD.descripcion	AS documento,
					S.descripcion	AS sucursal
			FROM  
					Numero_Documento ND 
						INNER JOIN Tipo_Documento TD ON ND.id_tipo_documento=TD.id_tipo_documento
						INNER JOIN Sucursal S		 ON ND.id_sucursal=S.id_sucursal
			WHERE   
					ND.id_numeros=ISNULL(@id_numeros,ND.id_numeros) 
					AND S.id_sucursal	=ISNULL(@id_sucursal,S.id_sucursal)

	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_Personal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_Personal]
@id_personal int
AS
	BEGIN
		IF @id_personal = 0 SET @id_personal = NULL
			SELECT
					 P.id_personal
					,P.nombres
					,P.apellidos
					,P.dni
					,CONVERT(VARCHAR(25), P.fecha_nac,  105)as fecha_nac
					,P.sexo
					,P.direccion
					,P.correo
					,P.telefono
					,P.celular
					,P.estado
					,S.id_sucursal
					,S.descripcion
					,P.sueldo
					,P.imagen
					,P.id_tipo_personal
					,TP.descripcion
			FROM 
					Personal P
					INNER JOIN Sucursal S ON P.id_sucursal=S.id_sucursal
					INNER JOIN Tipo_Personal TP ON P.id_tipo_personal = TP.id_tipo_personal
			WHERE   
					P.id_personal		=ISNULL(@id_personal,P.id_personal)
					AND P.estado=1
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_Producto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_Producto]
@id_producto int
AS
	BEGIN
		IF @id_producto = 0 SET @id_producto = NULL
			SELECT
					 P.id_producto
					,P.descripcion as producto
					,C.descripcion as categoria
					,M.descripcion as marca
					,P.precio_min
					,P.precio_max
					,P.estado
			FROM 
					Producto P
					INNER JOIN Marca M		ON P.id_marca		=M.id_marca
					INNER JOIN Categoria C	ON P.id_categoria	=C.id_categoria
			WHERE   
					P.id_producto		=ISNULL(@id_producto,P.id_producto)
					AND P.estado=1
	END


GO
/****** Object:  StoredProcedure [dbo].[spListar_Sucursal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spListar_Sucursal]
@id_sucursal int
AS
	BEGIN
		IF @id_sucursal = 0 SET @id_sucursal = NULL
			SELECT 
					 S.id_sucursal
					,S.descripcion
					,S.direccion
					,S.telefono
			FROM 
					Sucursal S
			WHERE   
					S.id_sucursal=ISNULL(@id_sucursal,S.id_sucursal)
					AND S.estado=1
	END


GO
/****** Object:  StoredProcedure [dbo].[spLogin_Clientes]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spLogin_Clientes]
@usuario varchar(20),
@password varchar(20)
AS
	BEGIN
			SELECT 
					id_cliente,
					nombres,
					usuario,
					password,
					estado
			FROM Cliente
			WHERE usuario=@usuario AND [password]=@password

	END


GO
/****** Object:  StoredProcedure [Logistica].[spGuardar_Moneda]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Logistica].[spGuardar_Moneda]
@id_moneda int,
@descripcion varchar(50),
@estado smallint
AS
DECLARE @VALOR INT
BEGIN TRANSACTION
	
	IF EXISTS(SELECT id_moneda FROM Logistica.Moneda WHERE descripcion=@descripcion AND id_moneda!= @id_moneda AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION 
		SET @VALOR= -2
		RETURN @VALOR
	END

	IF @id_moneda<=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_moneda + 1 FROM Logistica.Moneda ORDER BY id_moneda DESC),1)
		INSERT INTO Logistica.Moneda(
				id_moneda,
				descripcion,				
				estado
				) VALUES(
				@NuevoId,
				@descripcion,				
				@estado
				)
	END
	ELSE
	BEGIN 
		UPDATE Logistica.Moneda
		SET
			descripcion=@descripcion,			
			estado=@estado
		WHERE 
			id_moneda=@id_moneda			
	END
	SET @VALOR=1

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Logistica].[spGuardar_Sucursal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Logistica].[spGuardar_Sucursal]
@id_sucursal int,
@descripcion varchar(50),
@direccion varchar(100),
@telefono varchar(20),
@estado smallint
AS
DECLARE @VALOR INT
BEGIN TRANSACTION
	
	IF EXISTS(SELECT id_sucursal FROM Logistica.Sucursal WHERE descripcion=@descripcion AND id_sucursal!= @id_sucursal AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION 
		SET @VALOR= -2
		RETURN @VALOR
	END

	IF @id_sucursal<=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_sucursal + 1 FROM Logistica.Sucursal ORDER BY id_sucursal DESC),1)
		INSERT INTO Logistica.Sucursal(
				id_sucursal,
				descripcion,
				direccion,
				telefono,
				estado
				) VALUES(
				@NuevoId,
				@descripcion,
				@direccion,
				@telefono,
				@estado
				)
	END
	ELSE
	BEGIN 
		UPDATE Logistica.Sucursal
		SET
			descripcion=@descripcion,
			direccion=@direccion,
			telefono=@telefono,
			estado=@estado
		WHERE 
			id_sucursal=@id_sucursal			
	END
	SET @VALOR=1

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR



GO
/****** Object:  StoredProcedure [Logistica].[spListar_Moneda]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Logistica].[spListar_Moneda]
@id_moneda int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	select 
			 m.id_moneda
			,m.descripcion
			,m.estado
	from 
			Logistica.Moneda m
	where 
			(m.id_moneda=@id_moneda OR @id_moneda=0)
			AND m.estado!=2
END


GO
/****** Object:  StoredProcedure [Logistica].[spListar_Sucursal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Logistica].[spListar_Sucursal]
@id_sucursal int
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	select 
			 s.id_sucursal
			,s.descripcion
			,s.direccion
			,s.telefono
			,s.estado
	from 
			Logistica.Sucursal s
	where 
			(s.id_sucursal = @id_sucursal OR @id_sucursal = 0)
			AND s.estado!=2
END



GO
/****** Object:  StoredProcedure [Produccion].[spGuardar_OrdenProduccion]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Produccion].[spGuardar_OrdenProduccion]
@id_orden_produccion int,
@descripcion nvarchar(255),
@fecha_entrega datetime,
@id_motivo int,
@id_pedido int,
@id_producto int,
@descripcion_producto nvarchar(255),
@cantidad decimal(18,2),
@id_usuario	int,
@id_sucursal int,
@TYPE_DETALLEHORASTRABAJADAS AS dbo.DetalleHorasTrabajadas READONLY 
AS
	BEGIN TRANSACTION
		DECLARE @NuevoId INT

		IF @id_orden_produccion <= 0
		BEGIN
			SET @NuevoId = ISNULL((SELECT TOP 1 id_orden_produccion + 1 FROM Produccion.Orden_Produccion ORDER BY id_orden_produccion DESC),1)
			
			DECLARE @NuevoNumero NVARCHAR(10)
			SET @NuevoNumero = ISNULL((SELECT TOP 1 RIGHT('000000000'+LTRIM(RIGHT(ISNULL(OP.numero,'000000000'),10)+1),10) 
								FROM Produccion.Orden_Produccion OP INNER JOIN Logistica.Sucursal S	ON OP.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY OP.id_orden_produccion DESC),'0000000001')

			INSERT INTO Produccion.Orden_Produccion(
						 id_orden_produccion
						,numero
						,fecha
						,descripcion						
						,fecha_entrega
						,id_motivo
						,id_pedido
						,id_producto
						,descripcion_producto
						,cantidad
						,id_usuario
						,id_sucursal
						,usuario_registro
						,fecha_registro
				)
				VALUES( 
						 @NuevoId
						,@NuevoNumero
						,GETDATE()
						,@descripcion
						,@fecha_entrega
						,@id_motivo
						,@id_pedido
						,@id_producto
						,@descripcion_producto
						,@cantidad
						,@id_usuario
						,@id_sucursal
						,@id_usuario
						,GETDATE()
				)			
		END

		ELSE  
		BEGIN  
			  UPDATE Produccion.Orden_Produccion
			  SET 
				 descripcion			=@descripcion
				,fecha_entrega			=@fecha_entrega
				,id_motivo				=@id_motivo
				,id_pedido				=@id_pedido
				,id_producto			=@id_producto
				,descripcion_producto	=@descripcion_producto
				,cantidad				=@cantidad				
				,usuario_modifico		=@id_usuario
				,fecha_modifico			=GETDATE()
			  WHERE id_orden_produccion	=@id_orden_produccion 

			  SET @NuevoId = @id_orden_produccion

			  DELETE FROM Produccion.Detalle_Horas_Trabajadas WHERE id_orden_produccion = @id_orden_produccion
		END  

		INSERT INTO Produccion.Detalle_Horas_Trabajadas(  
						 id_orden_produccion
						,id_personal
						,fecha_hora_inicio
						,fecha_hora_fin
						,costo
				 )  
			 SELECT  
						 @NuevoId
						,id_personal
						,fecha_hora_inicio
						,fecha_hora_fin
						,costo
			 FROM @TYPE_DETALLEHORASTRABAJADAS

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION


GO
/****** Object:  StoredProcedure [RRHH].[spGuardar_TipoPersonal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [RRHH].[spGuardar_TipoPersonal]
 @id_tipo_personal int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_tipo_personal FROM RRHH.Tipo_Personal WHERE descripcion = @descripcion AND id_tipo_personal != @id_tipo_personal AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_tipo_personal <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_tipo_personal + 1 FROM RRHH.Tipo_Personal ORDER BY id_tipo_personal DESC),1)
		INSERT INTO RRHH.Tipo_Personal(
					 id_tipo_personal
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE RRHH.Tipo_Personal
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_tipo_personal = @id_tipo_personal
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR




GO
/****** Object:  StoredProcedure [RRHH].[spListar_Personal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [RRHH].[spListar_Personal]
@id_personal int,
@dni int
AS
	BEGIN
		SET NOCOUNT ON
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT
				 P.id_personal
				,P.nombres
				,P.apellido_paterno
				,P.apellido_materno
				,P.dni
				,CONVERT(VARCHAR(25), P.fecha_nac,  105)as fecha_nac
				,P.sexo
				,P.direccion
				,P.correo
				,P.telefono
				,P.celular
				,P.estado
				,S.id_sucursal
				,S.descripcion sucursal
				,P.sueldo_total
				,P.sueldo_hora
				,P.imagen
				,P.id_tipo_personal
				,TP.descripcion tipo_personal
		FROM 
				RRHH.Personal P
				INNER JOIN Logistica.Sucursal S ON P.id_sucursal = S.id_sucursal
				INNER JOIN RRHH.Tipo_Personal TP ON P.id_tipo_personal = TP.id_tipo_personal
		WHERE   
				(P.id_personal = @id_personal OR @id_personal = 0)
				AND (P.dni = @dni OR @dni = 0)
				AND P.estado != 2
	END


GO
/****** Object:  StoredProcedure [RRHH].[spListar_TipoPersonal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [RRHH].[spListar_TipoPersonal]
@id_tipo_personal int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT 
					 TP.id_tipo_personal
					,TP.descripcion
					,TP.estado
			FROM 
					RRHH.Tipo_Personal TP
			WHERE   
					(TP.id_tipo_personal=@id_tipo_personal OR @id_tipo_personal = 0) 
					AND TP.estado != 2

	END


GO
/****** Object:  StoredProcedure [Seguridad].[spListar_Usuario]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Seguridad].[spListar_Usuario]
@id_usuario int,
@usuario varchar(20),
@password varchar(20)
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		IF @id_usuario=0 and @usuario='' and  @password=''--Listar todos los usuarios
			BEGIN
					SELECT 
							 U.id_usuario
							,U.usuario
							,U.password
							,(P.nombres +' '+ P.apellido_paterno +' '+ P.apellido_materno) AS Nombres
							,S.id_sucursal
							,S.descripcion
							,U.estado
					FROM 
							Seguridad.Usuario U 
							INNER JOIN RRHH.Personal P ON U.id_personal=P.id_personal
							INNER JOIN Logistica.Sucursal S ON P.id_sucursal=S.id_sucursal
					--WHERE	U.estado=1
			END

		ELSE IF @id_usuario=0 -- login para el usuario
			BEGIN
					SELECT 
							 U.id_usuario
							,U.usuario
							,U.password
							,P.id_personal
							,P.nombres 
							,P.apellido_paterno
							,P.apellido_materno
							,P.dni
							,P.fecha_nac
							,P.sexo
							,P.direccion
							,P.correo
							,P.telefono phono
							,P.celular cel
							,P.estado estado_personal
							,P.sueldo_total
							,S.id_sucursal
							,S.descripcion sucursal
							,U.estado estado_usuario
							,P.imagen
							,P.id_tipo_personal
							,TP.descripcion as tipo_personal
					FROM 
							Seguridad.Usuario U 
							INNER JOIN RRHH.Personal P ON U.id_personal=P.id_personal
							INNER JOIN Logistica.Sucursal S ON P.id_sucursal=S.id_sucursal
							INNER JOIN RRHH.Tipo_Personal TP ON P.id_tipo_personal=TP.id_tipo_personal
					WHERE	
								U.usuario	=@usuario
							AND U.password	=@password
			END
	END


GO
/****** Object:  StoredProcedure [Ventas].[spActualizar_CuentaCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spActualizar_CuentaCliente]
@id_cliente int,
@pago decimal(18,2)
AS
	BEGIN
		DECLARE @id_cuenta_cliente AS INT
		DECLARE @saldo AS DECIMAL(18,2)
		DECLARE @debe AS DECIMAL(18,2)

		DECLARE CURSOR_CUENTACLIENTE CURSOR  FOR
			SELECT 
					 CC.id_cuenta_cliente
					,CC.saldo 
			FROM 
					Ventas.Cuenta_Cliente CC 
					INNER JOIN Ventas.ComprobanteVenta V ON CC.id_venta=V.id_venta
			WHERE	
					CC.id_cliente = @id_cliente 
					AND CC.ESTADO = 'DEBE'

		
		OPEN CURSOR_CUENTACLIENTE
		FETCH NEXT FROM CURSOR_CUENTACLIENTE
		  INTO @id_cuenta_cliente,@saldo
			WHILE @@FETCH_STATUS = 0 
			BEGIN 
 				IF @pago = @saldo -- Si el monto que pagas es IGUAL a lo que debes
 				BEGIN
 					UPDATE Ventas.Cuenta_Cliente 
					SET 
							 acuenta = @pago
							,saldo	 = 0
							,estado	 = 'PAGÓ'
					WHERE 
							id_cuenta_cliente=@id_cuenta_cliente

 					INSERT INTO Ventas.Detalle_Cuenta_Cliente(
									 id_cuenta_cliente
									,fecha
									,pago
									,debe
							)
 							VALUES(
									 @id_cuenta_cliente
									,GETDATE()
									,@pago
									,0
							)
 					BREAK				
 				END
		 		
				IF @pago > @saldo -- Si el monto que pagas es MAYOR a lo que debes
 				BEGIN
 					UPDATE Ventas.Cuenta_Cliente 
					SET 
							 acuenta = monto
							,saldo	 = 0
							,estado	 = 'PAGÓ'
					WHERE 
							id_cuenta_cliente=@id_cuenta_cliente

 					SET @pago = @pago - @saldo -- para restar el pago realizado y verificar si entra al 'else if'
					INSERT INTO Ventas.Detalle_Cuenta_Cliente(
									 id_cuenta_cliente
									,fecha
									,pago
									,debe
							)
 							VALUES(
									 @id_cuenta_cliente
									,GETDATE()
									,@pago
									,0
							)
 				END

 				ELSE IF @pago < @saldo -- Si el monto que pagas es MENOR a lo que debes
 				BEGIN
 					SET @debe = (SELECT saldo FROM Ventas.Cuenta_Cliente WHERE id_cuenta_cliente=@id_cuenta_cliente)
 					UPDATE Ventas.Cuenta_Cliente 
					SET 
							acuenta	= @pago + acuenta, 
							saldo	= monto - (@pago + ACuenta)
 					WHERE 
							id_cuenta_cliente=@id_cuenta_cliente

 					INSERT INTO Ventas.Detalle_Cuenta_Cliente(
									 id_cuenta_cliente
									,fecha
									,pago
									,debe
							)
 							VALUES(
									 @id_cuenta_cliente
									,GETDATE()
									,@pago
									,(@debe-@pago)
							)
					BREAK
 				END

		 		FETCH NEXT FROM CURSOR_CUENTACLIENTE
				INTO @id_cuenta_cliente,@saldo

			END 
		  CLOSE CURSOR_CUENTACLIENTE
		  DEALLOCATE CURSOR_CUENTACLIENTE
	END


GO
/****** Object:  StoredProcedure [Ventas].[spGuardar_Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spGuardar_Cliente]
 @id_cliente int
,@nombres varchar(150)
,@apellidos varchar(50)
,@dni_ruc varchar(11)
,@sexo char(1)
,@direccion varchar(100)
,@correo varchar(50)
,@telefono varchar(12)
,@celular varchar(12)
,@estado smallint
,@id_tipo_cliente int
,@usuario_registro int
,@registro_online smallint
,@usuario varchar(20)
,@password varchar(20)
AS
	
DECLARE @VALOR INT
BEGIN TRANSACTION

	IF EXISTS(SELECT id_cliente FROM Ventas.Cliente WHERE dni_ruc = @dni_ruc AND id_cliente != @id_cliente AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		Return @VALOR
	END

	IF EXISTS(SELECT id_cliente FROM Ventas.Cliente WHERE nombres = @nombres AND id_cliente != @id_cliente AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -3
		Return @VALOR
	END

	IF @id_cliente <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_cliente + 1 FROM Ventas.Cliente ORDER BY id_cliente DESC),1)
		INSERT INTO Ventas.Cliente(
					 id_cliente
					,nombres
					,apellidos
					,dni_ruc
					,sexo
					,direccion
					,correo
					,telefono
					,celular
					,estado
					,id_tipo_cliente
					,usuario_registro
					,fecha_registro
					,registro_online
					,usuario
					,password
			)
			VALUES( 
					 @NuevoId
					,@nombres
					,@apellidos
					,@dni_ruc
					,@sexo
					,@direccion
					,@correo
					,@telefono
					,@celular
					,1
					,@id_tipo_cliente
					,@usuario_registro
					,GETDATE()
					,@registro_online
					,@usuario
					,@password
			)
	END

	ELSE
	BEGIN
		UPDATE Ventas.Cliente
		SET
				 nombres = @nombres
				,apellidos = @apellidos
				,dni_ruc = @dni_ruc
				,sexo = @sexo
				,direccion = @direccion
				,correo = @correo
				,telefono = @telefono
				,celular = @celular
				,estado = @estado
				,id_tipo_cliente = @id_tipo_cliente
				,usuario_modifico = @usuario_registro
				,fecha_modifico = GETDATE()
				,registro_online = @registro_online
		WHERE
				id_cliente = @id_cliente
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Ventas].[spGuardar_ComprobanteVenta]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spGuardar_ComprobanteVenta]
 @id_venta int
,@id_cliente int
,@id_numeros int
,@id_usuario int
,@id_sucursal int
,@id_pedido	int
,@id_tipo_pago int
,@total	decimal(18, 2)
AS
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_venta + 1 FROM Ventas.ComprobanteVenta ORDER BY id_venta DESC),1)

		-----------------------------------------------------------------------------
		-- OBTENER LA ÚLTIMA SERIE DE LA VENTA O ESCOGER LA SERIE DE INICIO ASIGNADA
		-----------------------------------------------------------------------------
		DECLARE @NuevaSerie NCHAR(5)
		SET @NuevaSerie = (SELECT TOP 1 V.serie 
							 FROM Ventas.ComprobanteVenta V 
								INNER JOIN Comunes.Numero_Documento	ND	ON	V.id_numeros		=ND.id_numeros
								INNER JOIN Comunes.Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
								INNER JOIN Logistica.Sucursal		S	ON	ND.id_sucursal		=S.id_sucursal
							WHERE V.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal
							ORDER BY V.id_venta DESC)

		IF @NuevaSerie IS NULL 
		SET @NuevaSerie =(SELECT ND.serie_inicio
							FROM Comunes.Numero_Documento ND
								INNER JOIN Comunes.Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
								INNER JOIN Logistica.Sucursal		S	ON	ND.id_sucursal		=S.id_sucursal
							WHERE ND.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal)

		-------------------------------------------------------------------------------
		-- OBTENER EL ÚLTIMO NÚMERO DE LA VENTA O ESCOGER EL NÚMERO DE INICIO ASIGNADO
		-------------------------------------------------------------------------------
		DECLARE @NuevoNumero NCHAR(8)
		SET @NuevoNumero = (SELECT TOP 1 RIGHT('0000000'+LTRIM(RIGHT(ISNULL(V.Numero,'0000000'),10)+1),8) 
							FROM Ventas.ComprobanteVenta V 
								INNER JOIN Comunes.Numero_Documento	ND	ON	V.id_numeros		=ND.id_numeros
								INNER JOIN Comunes.Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
								INNER JOIN Logistica.Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
							WHERE V.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal
							ORDER BY V.id_venta DESC)

		IF @NuevoNumero IS NULL 
		SET @NuevoNumero =(SELECT ND.numero_inicio
							FROM Comunes.Numero_Documento ND
								INNER JOIN Comunes.Tipo_Documento	TD	ON	ND.id_tipo_documento=TD.id_tipo_documento
								INNER JOIN Logistica.Sucursal			S	ON	ND.id_sucursal		=S.id_sucursal
							WHERE ND.id_numeros=@id_numeros  AND S.id_sucursal=@id_sucursal)

		INSERT INTO Ventas.ComprobanteVenta(
					 id_venta 
					,serie
					,numero
					,fecha
					,total
					,estado
					,id_cliente
					,id_numeros
					,id_usuario
					,id_sucursal
					,id_pedido
					,id_tipo_pago
					,usuario_registro
					,fecha_registro
			)
			VALUES(
					 @NuevoId
					,@NuevaSerie
					,@NuevoNumero
					,GETDATE()
					,@total
					,1
					,@id_cliente
					,@id_numeros
					,@id_usuario
					,@id_sucursal
					,@id_pedido
					,@id_tipo_pago
					,@id_usuario
					,GETDATE()
			)


		UPDATE Ventas.Pedido Set estado = 'Registrado' Where id_pedido = @id_pedido
		UPDATE Ventas.Detalle_Pedido Set id_venta = @NuevoId Where id_pedido = @id_pedido
		------------------------------------------------------------------------
		-- ACTUALIZAR EL STOCK DEL PRODUCTO
		------------------------------------------------------------------------
		UPDATE S
		SET S.stock = S.stock - D.cantidad
		FROM Almacen.Stock_Producto S
			INNER JOIN Ventas.Detalle_Pedido D ON S.id_producto = D.id_producto 
			INNER JOIN Ventas.Pedido P ON D.id_pedido = P.id_pedido AND S.id_sucursal = P.id_sucursal
		WHERE P.id_pedido = @id_pedido

		------------------------------------------------------------------------
		-- REGISTRAR CUENTA DE DEUDA AL CLIENTE
		------------------------------------------------------------------------
		DECLARE @DESCRIPCIONPAGO NVARCHAR(50) = (SELECT descripcion FROM Comunes.Tipo_Pago WHERE id_tipo_pago = @id_tipo_pago)
		IF (@DESCRIPCIONPAGO = 'CRÉDITO' OR @DESCRIPCIONPAGO = 'CREDITO')
		BEGIN
			DECLARE @NuevoId_Cuenta INT = ISNULL((SELECT TOP 1 id_cuenta_cliente + 1 FROM Ventas.Cuenta_Cliente ORDER BY id_cuenta_cliente DESC),1)

			INSERT INTO Ventas.Cuenta_Cliente(
							 id_cuenta_cliente
							,Monto
							,Saldo
							,Acuenta
							,fecha
							,id_cliente
							,id_venta
							,id_sucursal
							,id_usuario
							,estado
					)
					VALUES(
							 @NuevoId_Cuenta
							,@total
							,@total
							,0
							,GETDATE()
							,@id_cliente
							,@NuevoId
							,@id_sucursal
							,@id_usuario
							,'DEBE'
					)
		END

	END


GO
/****** Object:  StoredProcedure [Ventas].[spGuardar_Pedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spGuardar_Pedido]
@id_pedido int,
@sub_total decimal(18,2),
@igv decimal(18,2),
@total decimal(18,2),
@id_cliente	int,
@id_tipo_documento int,
@id_usuario	int,
@id_sucursal int,
@produccion smallint,
@TYPE_DETALLEPEDIDO AS dbo.DetallePedido READONLY 
AS
	BEGIN TRANSACTION
		DECLARE @NuevoId INT

		IF @id_pedido <= 0
		BEGIN
			SET @NuevoId = ISNULL((SELECT TOP 1 id_pedido + 1 FROM Ventas.Pedido ORDER BY id_pedido DESC),1)

			DECLARE @NuevoNumero NVARCHAR(10)
			SET @NuevoNumero = ISNULL((SELECT TOP 1 RIGHT('000000000'+LTRIM(RIGHT(ISNULL(P.numero,'000000000'),10)+1),10) 
								FROM Ventas.Pedido P INNER JOIN Logistica.Sucursal S	ON P.id_sucursal =S.id_sucursal
								WHERE S.id_sucursal=@id_sucursal
								ORDER BY P.id_pedido DESC),'0000000001')

			INSERT INTO Ventas.Pedido(
						 id_pedido
						,fecha
						,numero
						,sub_total
						,igv
						,total
						,estado
						,id_cliente
						,id_tipo_documento
						,id_usuario
						,id_sucursal
						,observacion
						,produccion
						,usuario_registro
						,fecha_registro
				)
				VALUES( 
						 @NuevoId
						,GETDATE()
						,@NuevoNumero
						,@sub_total
						,@igv
						,@total
						,'Pendiente'
						,@id_cliente
						,@id_tipo_documento
						,@id_usuario
						,@id_sucursal
						,''
						,@produccion
						,@id_usuario
						,GETDATE()
				)			
		END

		ELSE  
		BEGIN  
			  UPDATE Ventas.Pedido    
			  SET     
				 sub_total			=@sub_total
				,igv				=@igv
				,total				=@total
				,id_cliente			=@id_cliente
				,id_tipo_documento	=@id_tipo_documento
				,produccion		=@produccion
				,usuario_modifico	=@id_usuario
				,fecha_modifico		=GETDATE()
			  WHERE id_pedido =		@id_pedido    

			  SET @NuevoId = @id_pedido

			  DELETE FROM Ventas.Detalle_Pedido WHERE id_pedido = @id_pedido
			  --UPDATE DP
			  --SET 
					--DP.id_producto = DPT.id_producto,
					--DP.cantidad = DPT.cantidad,
					--DP.descripcion = DPT.descripcion,
					--DP.precio = DPT.precio,
					--DP.importe = DPT.importe
			  --FROM Ventas.Detalle_Pedido DP
			  --INNER JOIN @TYPE_DETALLEPEDIDO DPT ON DP.id_pedido = DPT.id_pedido
		END  

		INSERT INTO Ventas.Detalle_Pedido(  
						 id_pedido
						,id_producto
						,cantidad
						,descripcion
						,precio
						,importe
				 )  
			 SELECT  
						 @NuevoId
						,id_producto
						,cantidad
						,descripcion
						,precio
						,importe  
			 FROM @TYPE_DETALLEPEDIDO

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION


GO
/****** Object:  StoredProcedure [Ventas].[spGuardar_TipoCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spGuardar_TipoCliente]
 @id_tipo_cliente int
,@descripcion varchar(50)
,@estado smallint
AS
DECLARE @VALOR INT	
BEGIN TRANSACTION

	IF EXISTS(SELECT id_tipo_cliente FROM Ventas.Tipo_Cliente WHERE descripcion = @descripcion AND id_tipo_cliente != @id_tipo_cliente AND estado != 2)
	BEGIN
		ROLLBACK TRANSACTION
		SET @VALOR = -2
		RETURN @VALOR
	END

	IF @id_tipo_cliente <=0
	BEGIN
		DECLARE @NuevoId INT = ISNULL((SELECT TOP 1 id_tipo_cliente + 1 FROM Ventas.Tipo_Cliente ORDER BY id_tipo_cliente DESC),1)
		INSERT INTO Ventas.Tipo_Cliente(
					 id_tipo_cliente
					,descripcion
					,estado					
			)
			VALUES( 
					 @NuevoId
					,@descripcion
					,@estado
			)
	END

	ELSE
	BEGIN
		UPDATE Ventas.Tipo_Cliente
		SET
				 descripcion = @descripcion
				,estado = @estado
		WHERE
				id_tipo_cliente = @id_tipo_cliente
	END

	SET @VALOR = 1

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END

COMMIT TRANSACTION
RETURN @VALOR


GO
/****** Object:  StoredProcedure [Ventas].[spListar_Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_Cliente]
@id_cliente int,
@dni_ruc varchar(11)
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		IF @id_cliente=0 and @dni_ruc='' --Listar todos los clientes
			BEGIN
					SELECT 
							 C.id_cliente
							,C.nombres
							,C.apellidos
							,C.id_tipo_cliente
							,TC.descripcion tipo_cliente
							,C.dni_ruc
							,C.sexo
							,C.direccion
							,C.correo
							,C.telefono
							,C.celular
							,C.estado
							,'0' AS total
							,C.registro_online
					FROM 
							Ventas.Cliente C
							INNER JOIN Ventas.Tipo_Cliente TC ON C.id_tipo_cliente = TC.id_tipo_cliente
					WHERE	C.estado != 2
			END

		ELSE IF @id_cliente != 0 OR  @dni_ruc != '' -- Buscar el cliente y Su último precio de venta
			BEGIN
				DECLARE @vNULL AS MONEY = NULL
				DECLARE @vVACIO AS NVARCHAR(10) = ''
					SET @vNULL = (SELECT TOP 1 V.total FROM Ventas.ComprobanteVenta V INNER JOIN Ventas.Cliente Cli ON V.id_cliente=Cli.id_cliente WHERE Cli.dni_ruc=@dni_ruc 
										ORDER BY V.id_venta DESC)

					SELECT 
							 C.id_cliente
							,C.nombres
							,C.apellidos
							,C.id_tipo_cliente
							,TC.descripcion tipo_cliente
							,C.dni_ruc
							,C.sexo
							,C.direccion
							,C.correo
							,C.telefono
							,C.celular
							,C.estado
							,(SELECT CASE WHEN ISNULL( @vNULL , '' ) = @vVACIO THEN 0.00 ELSE @vNULL END) AS total
							,C.registro_online
					FROM 
							Ventas.Cliente C
							INNER JOIN Ventas.Tipo_Cliente TC ON C.id_tipo_cliente = TC.id_tipo_cliente
					WHERE   
							(C.dni_ruc=@dni_ruc OR C.id_cliente = @id_cliente) AND C.estado != 2
			END
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_ComprobanteVenta]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_ComprobanteVenta]
@id_venta int,
@id_sucursal int,
@id_tipo_documento int,
@id_tipo_pago int,
@fecha_ini date,
@fecha_fin date
AS
	BEGIN
		SELECT 
				V.id_venta,
				CONVERT(VARCHAR(25), V.fecha,  105)as fecha,
				TP.descripcion as tipopago,
				TD.descripcion as tipodocumento,
				V.serie,
				V.numero,
				C.dni_ruc,
				C.nombres,
				V.total,
				U.usuario,
				S.descripcion as sucursal

		FROM 
				Ventas.ComprobanteVenta V
					INNER JOIN Comunes.Tipo_Pago TP			ON V.id_tipo_pago		= TP.id_tipo_pago
					INNER JOIN Ventas.Cliente C				ON V.id_cliente			= C.id_cliente
					INNER JOIN Seguridad.Usuario U			ON V.id_usuario			= U.id_usuario
					INNER JOIN Logistica.Sucursal S			ON V.id_sucursal		= S.id_sucursal
					INNER JOIN Comunes.Numero_Documento	ND	ON V.id_numeros			= ND.id_numeros
					INNER JOIN Comunes.Tipo_Documento	TD	ON ND.id_tipo_documento	= TD.id_tipo_documento
		WHERE
				(V.id_venta = @id_venta OR @id_venta = 0)
				AND (S.id_sucursal = @id_sucursal OR @id_sucursal = 0)
				AND (TD.id_tipo_documento = @id_tipo_documento OR @id_tipo_documento = 0)
				AND (TP.id_tipo_pago = @id_tipo_pago OR @id_tipo_pago = 0)
				AND CONVERT (date, V.fecha) BETWEEN @fecha_ini AND @fecha_fin 
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_Cuentas]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_Cuentas]
AS
	BEGIN
		SELECT 
				 CC.id_cliente				
				,C.nombres
				,S.descripcion sucural
				,COUNT(CC.id_cliente) num
		FROM 
				Ventas.Cuenta_Cliente CC
				INNER JOIN Ventas.Cliente		C ON CC.id_cliente	= C.id_cliente
				INNER JOIN Logistica.Sucursal	S ON CC.id_sucursal	= S.id_sucursal
		WHERE
				CC.estado='DEBE'
		GROUP BY
				CC.id_cliente, C.nombres, S.descripcion
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_CuentasCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_CuentasCliente]
@id_cliente int
AS
	BEGIN
		SELECT 
				 CC.id_cuenta_cliente
				,CC.id_cliente
				,CONVERT(VARCHAR(25), CC.fecha,  105) as fecha
				,CC.Monto
				,CC.Saldo
				,CC.Acuenta
				,C.nombres
				,CC.id_venta
				,TD.descripcion as tipo_documento
				,V.serie
				,V.numero
				,V.id_pedido
		FROM 
				Ventas.Cuenta_Cliente CC
					INNER JOIN Ventas.Cliente			C	ON CC.id_cliente		= C.id_cliente
					INNER JOIN Ventas.ComprobanteVenta	V	ON CC.id_venta			= V.id_venta
					INNER JOIN Comunes.Numero_Documento	ND	ON V.id_numeros			= ND.id_numeros
					INNER JOIN Comunes.Tipo_Documento	TD	ON ND.id_tipo_documento	= TD.id_tipo_documento
		WHERE
					(C.id_cliente = @id_cliente OR @id_cliente = 0) 
					AND CC.estado='DEBE'		
		ORDER BY CC.fecha
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_DetallePedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_DetallePedido]
@id_pedido int
AS
	BEGIN
			SELECT 
					DP.cantidad,
					DP.descripcion,					
					DP.precio,
					DP.importe
			FROM 
					Ventas.Detalle_Pedido DP
			WHERE
					DP.id_pedido=@id_pedido
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_PedidoDetalle]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_PedidoDetalle]
@id_pedido int
AS
	BEGIN
		SET NOCOUNT ON
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SELECT 
				P.id_pedido,
				P.numero,
				P.sub_total,
				P.igv,
				P.total,
				CONVERT(VARCHAR(25), P.fecha,  105)as fecha,
				P.id_cliente,
				C.dni_ruc,
				C.nombres AS Cliente,
				P.id_tipo_documento,
				TD.descripcion as TipoDocumento,
				P.produccion,
				PR.id_producto,
				DP.cantidad,
				DP.descripcion,					
				DP.precio,
				DP.importe
		FROM 
				Ventas.Pedido P
				INNER JOIN Ventas.Cliente			C	ON	P.id_cliente		=C.id_cliente
				INNER JOIN Ventas.Detalle_Pedido	DP	ON	P.id_pedido			=DP.id_pedido
				INNER JOIN Almacen.Producto			PR	ON	DP.id_producto		=PR.id_producto
				INNER JOIN Comunes.Tipo_Documento	TD	ON	P.id_tipo_documento	=TD.id_tipo_documento
		WHERE
				P.estado='Pendiente'
				--AND CONVERT (date, P.fecha)=CONVERT(date, GETDATE())
				AND P.id_pedido = @id_pedido
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_PedidosDiarios]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_PedidosDiarios]
@id_sucursal int
AS
	BEGIN
		SELECT 
				P.id_pedido,
				P.sub_total,
				P.igv,
				P.total,
				CONVERT(VARCHAR(25), P.fecha,  105)as fecha,
				P.id_cliente,
				C.dni_ruc,
				C.nombres AS Cliente,
				P.estado,
				S.descripcion,
				P.id_tipo_documento,
				TD.descripcion as TipoDocumento,
				P.numero,
				P.produccion
		FROM 
				Ventas.Pedido P
				INNER JOIN Ventas.Cliente			C	ON	P.id_cliente		=C.id_cliente
				INNER JOIN Logistica.Sucursal			S	ON	P.id_sucursal		=S.id_sucursal
				INNER JOIN Comunes.Tipo_Documento	TD	ON	P.id_tipo_documento	=TD.id_tipo_documento
		WHERE
				P.estado='Pendiente'
				AND CONVERT (date, P.fecha)=CONVERT(date, GETDATE())
				AND P.produccion = 0
				AND P.id_sucursal=@id_sucursal
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_PedidosProduccion]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_PedidosProduccion]
@id_sucursal int
AS
	BEGIN
		SELECT 
				 P.id_pedido
				,P.numero
				,P.total
				,C.nombres
		FROM 
				Ventas.Pedido P
				INNER JOIN Ventas.Cliente C ON P.id_cliente = C.id_cliente
		WHERE	
				P.produccion = 1 
				AND P.estado = 'Pendiente'
				AND P.id_sucursal = @id_sucursal
	END


GO
/****** Object:  StoredProcedure [Ventas].[spListar_TipoCliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Ventas].[spListar_TipoCliente]
@id_tipo_cliente int
AS
	BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
			SELECT 
					 TC.id_tipo_cliente
					,TC.descripcion
					,TC.estado
			FROM 
					Ventas.Tipo_Cliente TC
			WHERE   
					(TC.id_tipo_cliente=@id_tipo_cliente OR @id_tipo_cliente = 0) 
					AND TC.estado != 2

	END


GO
/****** Object:  Table [Almacen].[Categoria]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Almacen].[Categoria](
	[id_categoria] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Almacen].[Detalle_Nota_Ingreso]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Almacen].[Detalle_Nota_Ingreso](
	[id_nota_ingreso] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Almacen].[Marca]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Almacen].[Marca](
	[id_marca] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Marca] PRIMARY KEY CLUSTERED 
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Almacen].[Nota_Ingreso]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Almacen].[Nota_Ingreso](
	[id_nota_ingreso] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[numero] [nchar](10) NULL,
	[id_motivo] [int] NOT NULL,
	[id_orden_compra] [int] NULL,
	[id_orden_produccion] [int] NULL,
	[id_usuario] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[observacion] [nvarchar](200) NULL,
	[estado] [nvarchar](20) NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Nota_Ingreso] PRIMARY KEY CLUSTERED 
(
	[id_nota_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Almacen].[Producto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Almacen].[Producto](
	[id_producto] [int] NOT NULL,
	[codigo] [nvarchar](20) NULL,
	[descripcion] [nvarchar](255) NOT NULL,
	[unidad_med] [nvarchar](3) NULL,
	[precio_min] [decimal](18, 2) NOT NULL,
	[precio_max] [decimal](18, 2) NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_categoria] [int] NOT NULL,
	[estado] [smallint] NOT NULL,
	[usuario_registro] [int] NULL,
	[fecha_registro] [datetime] NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Producto] PRIMARY KEY CLUSTERED 
(
	[id_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Almacen].[Stock_Producto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Almacen].[Stock_Producto](
	[id_sucursal] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[stock] [decimal](18, 2) NOT NULL,
	[cpm] [decimal](18, 2) NULL,
	[estado] [smallint] NOT NULL,
	[usuario_registro] [int] NULL,
	[fecha_registro] [datetime] NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[ComprobanteCompra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[ComprobanteCompra](
	[id_compra] [int] NOT NULL,
	[serie] [nchar](5) NOT NULL,
	[numero] [nchar](8) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[estado] [smallint] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[id_contacto_proveedor] [int] NOT NULL,
	[id_tipo_documento] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_tipo_pago] [int] NOT NULL,
	[id_moneda] [int] NOT NULL,
	[sub_total] [decimal](18, 2) NOT NULL,
	[igv] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[observacion] [nvarchar](200) NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_ComprobanteCompra] PRIMARY KEY CLUSTERED 
(
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Contacto_Proveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Contacto_Proveedor](
	[id_contacto_proveedor] [int] NOT NULL,
	[nombres] [nvarchar](50) NOT NULL,
	[apellidos] [nvarchar](50) NULL,
	[dni] [nchar](8) NULL,
	[correo] [nvarchar](50) NULL,
	[telefono] [nvarchar](12) NULL,
	[celular] [nvarchar](12) NULL,
	[estado] [smallint] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Contacto_Proveedor] PRIMARY KEY CLUSTERED 
(
	[id_contacto_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Cuenta_Proveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Cuenta_Proveedor](
	[id_cuenta_proveedor] [int] NOT NULL,
	[monto] [decimal](18, 2) NOT NULL,
	[saldo] [decimal](18, 2) NOT NULL,
	[acuenta] [decimal](18, 2) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[id_compra] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[estado] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Cuenta_Proveedor] PRIMARY KEY CLUSTERED 
(
	[id_cuenta_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Detalle_Compra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Detalle_Compra](
	[id_compra] [int] NOT NULL,
	[id_nota_ingreso] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[precio] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Detalle_Orden_Compra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Detalle_Orden_Compra](
	[id_orden_compra] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
	[precio] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Orden_Compra]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Orden_Compra](
	[id_orden_compra] [int] NOT NULL,
	[numero] [nvarchar](10) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[fecha_vencimiento] [date] NOT NULL,
	[id_proveedor] [int] NOT NULL,
	[id_contacto_proveedor] [int] NOT NULL,
	[id_moneda] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[sub_total] [decimal](18, 2) NOT NULL,
	[igv] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[observacion] [nvarchar](200) NULL,
	[estado] [nvarchar](20) NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Orden_Compra] PRIMARY KEY CLUSTERED 
(
	[id_orden_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Compras].[Proveedor]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Compras].[Proveedor](
	[id_proveedor] [int] NOT NULL,
	[razon_social] [nvarchar](100) NOT NULL,
	[dni_ruc] [nvarchar](11) NOT NULL,
	[direccion] [nvarchar](100) NULL,
	[correo] [nvarchar](50) NULL,
	[telefono] [nvarchar](12) NULL,
	[celular] [nvarchar](12) NULL,
	[estado] [smallint] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Proveedor] PRIMARY KEY CLUSTERED 
(
	[id_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comunes].[Elimina_Datos]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comunes].[Elimina_Datos](
	[tabla] [varchar](50) NULL,
	[id_tabla] [int] NULL,
	[estado] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comunes].[Motivo]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comunes].[Motivo](
	[id_motivo] [int] NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
	[tipo] [nvarchar](10) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Motivo] PRIMARY KEY CLUSTERED 
(
	[id_motivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comunes].[Numero_Documento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Comunes].[Numero_Documento](
	[id_numeros] [int] NOT NULL,
	[serie_inicio] [nchar](3) NOT NULL,
	[numero_inicio] [nchar](10) NOT NULL,
	[serie_fin] [nchar](3) NULL,
	[numero_fin] [nchar](10) NULL,
	[id_tipo_documento] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
 CONSTRAINT [PK_Numero_Documento] PRIMARY KEY CLUSTERED 
(
	[id_numeros] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Comunes].[Tipo_Documento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comunes].[Tipo_Documento](
	[id_tipo_documento] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Tipo_Documento] PRIMARY KEY CLUSTERED 
(
	[id_tipo_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Comunes].[Tipo_Pago]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Comunes].[Tipo_Pago](
	[id_tipo_pago] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Tipo_Pago] PRIMARY KEY CLUSTERED 
(
	[id_tipo_pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Evento]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Evento](
	[id_evento] [int] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[fecha_fin] [datetime] NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[ubicacion] [varchar](200) NOT NULL,
	[descripcion] [varchar](500) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[estado] [bit] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Evento] PRIMARY KEY CLUSTERED 
(
	[id_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Logistica].[Moneda]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Logistica].[Moneda](
	[id_moneda] [int] NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Moneda] PRIMARY KEY CLUSTERED 
(
	[id_moneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Logistica].[Sucursal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Logistica].[Sucursal](
	[id_sucursal] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[direccion] [varchar](100) NOT NULL,
	[telefono] [varchar](20) NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Tienda] PRIMARY KEY CLUSTERED 
(
	[id_sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Produccion].[Detalle_Horas_Trabajadas]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Produccion].[Detalle_Horas_Trabajadas](
	[id_orden_produccion] [int] NOT NULL,
	[id_personal] [int] NOT NULL,
	[fecha_hora_inicio] [datetime] NOT NULL,
	[fecha_hora_fin] [datetime] NOT NULL,
	[costo] [decimal](18, 2) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Produccion].[Orden_Produccion]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Produccion].[Orden_Produccion](
	[id_orden_produccion] [int] NOT NULL,
	[numero] [nvarchar](10) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
	[fecha_entrega] [datetime] NOT NULL,
	[id_motivo] [int] NOT NULL,
	[id_pedido] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[descripcion_producto] [nvarchar](255) NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Orden_Trabajo] PRIMARY KEY CLUSTERED 
(
	[id_orden_produccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RRHH].[Adelanto]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RRHH].[Adelanto](
	[id_adelanto] [int] NOT NULL,
	[fecha] [datetime] NULL,
	[monto] [money] NULL,
	[estado] [nchar](10) NULL,
	[id_personal] [int] NULL,
 CONSTRAINT [PK_Adelanto] PRIMARY KEY CLUSTERED 
(
	[id_adelanto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [RRHH].[Personal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [RRHH].[Personal](
	[id_personal] [int] NOT NULL,
	[nombres] [nvarchar](50) NOT NULL,
	[apellido_paterno] [nvarchar](20) NOT NULL,
	[apellido_materno] [nvarchar](20) NOT NULL,
	[dni] [int] NOT NULL,
	[fecha_nac] [date] NOT NULL,
	[sexo] [char](1) NOT NULL,
	[direccion] [nvarchar](80) NOT NULL,
	[correo] [nvarchar](50) NULL,
	[telefono] [nvarchar](12) NULL,
	[celular] [nvarchar](12) NULL,
	[estado] [bit] NULL,
	[id_sucursal] [int] NOT NULL,
	[id_tipo_personal] [int] NOT NULL,
	[sueldo_total] [decimal](18, 2) NULL,
	[sueldo_hora] [decimal](18, 2) NULL,
	[imagen] [nvarchar](100) NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Personal] PRIMARY KEY CLUSTERED 
(
	[id_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [RRHH].[Tipo_Personal]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [RRHH].[Tipo_Personal](
	[id_tipo_personal] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Tipo_Personal] PRIMARY KEY CLUSTERED 
(
	[id_tipo_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Seguridad].[Usuario]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Seguridad].[Usuario](
	[id_usuario] [int] NOT NULL,
	[usuario] [varchar](20) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[id_personal] [int] NOT NULL,
	[estado] [bit] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Ventas].[Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Ventas].[Cliente](
	[id_cliente] [int] NOT NULL,
	[nombres] [varchar](150) NOT NULL,
	[apellidos] [varchar](50) NULL,
	[dni_ruc] [varchar](11) NULL,
	[sexo] [char](1) NULL,
	[direccion] [varchar](100) NULL,
	[correo] [varchar](50) NULL,
	[telefono] [varchar](12) NULL,
	[celular] [varchar](12) NULL,
	[estado] [smallint] NOT NULL,
	[id_tipo_cliente] [int] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
	[registro_online] [smallint] NULL,
	[usuario] [varchar](20) NULL,
	[password] [varchar](20) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Ventas].[ComprobanteVenta]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Ventas].[ComprobanteVenta](
	[id_venta] [int] NOT NULL,
	[serie] [char](5) NOT NULL,
	[numero] [nchar](8) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[estado] [smallint] NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_numeros] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_pedido] [int] NOT NULL,
	[id_tipo_pago] [int] NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[observacion] [nvarchar](200) NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[id_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Ventas].[Cuenta_Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Ventas].[Cuenta_Cliente](
	[id_cuenta_cliente] [int] NOT NULL,
	[monto] [money] NOT NULL,
	[saldo] [money] NOT NULL,
	[acuenta] [money] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_venta] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[estado] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Cuenta_Cliente] PRIMARY KEY CLUSTERED 
(
	[id_cuenta_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Ventas].[Detalle_Cuenta_Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Ventas].[Detalle_Cuenta_Cliente](
	[id_cuenta_cliente] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[pago] [money] NOT NULL,
	[debe] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Ventas].[Detalle_Pedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Ventas].[Detalle_Pedido](
	[id_pedido] [int] NOT NULL,
	[id_producto] [int] NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[precio] [decimal](18, 2) NOT NULL,
	[importe] [decimal](18, 2) NOT NULL,
	[id_venta] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Ventas].[Pedido]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Ventas].[Pedido](
	[id_pedido] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[numero] [nchar](10) NOT NULL,
	[sub_total] [decimal](18, 2) NOT NULL,
	[igv] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[estado] [nvarchar](20) NOT NULL,
	[id_cliente] [int] NOT NULL,
	[id_tipo_documento] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_sucursal] [int] NOT NULL,
	[observacion] [varchar](200) NULL,
	[produccion] [smallint] NOT NULL,
	[usuario_registro] [int] NOT NULL,
	[fecha_registro] [datetime] NOT NULL,
	[usuario_modifico] [int] NULL,
	[fecha_modifico] [datetime] NULL,
 CONSTRAINT [PK_Pedido] PRIMARY KEY CLUSTERED 
(
	[id_pedido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Ventas].[Tipo_Cliente]    Script Date: 04/07/2016 02:51:50 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Ventas].[Tipo_Cliente](
	[id_tipo_cliente] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[estado] [smallint] NOT NULL,
 CONSTRAINT [PK_Tipo_Cliente] PRIMARY KEY CLUSTERED 
(
	[id_tipo_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (1, N'PINTURAS', 1)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (2, N'BROCHAS', 1)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (3, N'TINNER', 1)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (4, N'AGUARRAS', 1)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (5, N'fsdfsdfs', 2)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (6, N'fsdd', 2)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (7, N'sdfs', 2)
INSERT [Almacen].[Categoria] ([id_categoria], [descripcion], [estado]) VALUES (8, N'aaaaaaaaa', 2)
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (2, 74, CAST(2.00 AS Decimal(18, 2)), N'BROCAS CONICAS Nº 38')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (2, 32, CAST(1.00 AS Decimal(18, 2)), N'PISTOLA P/PINTAR SAGOLA PROFESIONAL')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (3, 60, CAST(2.00 AS Decimal(18, 2)), N'ESCALERAS DE SEGURIDAD 3MS')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (1, 1, CAST(3.00 AS Decimal(18, 2)), N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (1, 9, CAST(2.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 20"')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (4, 14, CAST(1.00 AS Decimal(18, 2)), N'JGO LLAVES TODA MEDIADA STANLEY')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (5, 5, CAST(2.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 24"')
INSERT [Almacen].[Detalle_Nota_Ingreso] ([id_nota_ingreso], [id_producto], [cantidad], [descripcion]) VALUES (5, 7, CAST(5.00 AS Decimal(18, 2)), N'ALCANTARILLAS  METALICA  E=2.00 MM   72"')
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (1, N'BLANKITO', 1)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (2, N'VENCEDOR', 1)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (3, N'MAESTRO', 1)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (4, N'ROCKY', 1)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (5, N'dfgdf', 2)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (6, N'dd', 2)
INSERT [Almacen].[Marca] ([id_marca], [descripcion], [estado]) VALUES (7, N'dfgfd', 2)
INSERT [Almacen].[Nota_Ingreso] ([id_nota_ingreso], [fecha], [numero], [id_motivo], [id_orden_compra], [id_orden_produccion], [id_usuario], [id_sucursal], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, CAST(0x0000A54901452840 AS DateTime), N'0000000001', 1, 3, 0, 1, 1, N'', N'Registrado', 1, CAST(0x0000A54901452840 AS DateTime), NULL, NULL)
INSERT [Almacen].[Nota_Ingreso] ([id_nota_ingreso], [fecha], [numero], [id_motivo], [id_orden_compra], [id_orden_produccion], [id_usuario], [id_sucursal], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, CAST(0x0000A54D0176DFB4 AS DateTime), N'0000000002', 1, 6, 0, 1, 1, N'', N'Pendiente', 1, CAST(0x0000A54D0176DFB4 AS DateTime), NULL, NULL)
INSERT [Almacen].[Nota_Ingreso] ([id_nota_ingreso], [fecha], [numero], [id_motivo], [id_orden_compra], [id_orden_produccion], [id_usuario], [id_sucursal], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, CAST(0x0000A54E000B6C3F AS DateTime), N'0000000003', 1, 9, 0, 1, 1, N'', N'Registrado', 1, CAST(0x0000A54E000B6C3F AS DateTime), NULL, NULL)
INSERT [Almacen].[Nota_Ingreso] ([id_nota_ingreso], [fecha], [numero], [id_motivo], [id_orden_compra], [id_orden_produccion], [id_usuario], [id_sucursal], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, CAST(0x0000A54E00129446 AS DateTime), N'0000000004', 1, 10, 0, 1, 1, N'', N'Registrado', 1, CAST(0x0000A54E00129446 AS DateTime), NULL, NULL)
INSERT [Almacen].[Nota_Ingreso] ([id_nota_ingreso], [fecha], [numero], [id_motivo], [id_orden_compra], [id_orden_produccion], [id_usuario], [id_sucursal], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, CAST(0x0000A61F00F222A1 AS DateTime), N'0000000005', 1, 12, 0, 1, 1, N'', N'Pendiente', 1, CAST(0x0000A61F00F222A1 AS DateTime), NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, NULL, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT                                                                                                                                    ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, NULL, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA                                                                                                                                                                        ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, NULL, N'CJA JGO DADOS LLAVES BOSH                                                                                                                                                                               ', N'UNI', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, NULL, N'TUBOS PVC 5-25 24"                                                                                                                                                                                      ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, NULL, N'TUBOS PVC S-25 24"                                                                                                                                                                                      ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, NULL, N'ESMERIL ( MOLADOR) BOSCH 1600 C PROFECIONAL                                                                                                                                                             ', N'UNI', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, NULL, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"                                                                                                                                                                ', N'PZA', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, NULL, N'TUBOS PVC 5-25 20"                                                                                                                                                                                      ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (9, NULL, N'TUBOS PVC S-25 20"                                                                                                                                                                                      ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (10, NULL, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS                                                                                                                                                           ', N'UNI', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (11, NULL, N'LADRILLO PANDERETA                                                                                                                                                                                      ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (12, NULL, N'TROMPO MEZCLADOR CON MOTOR 1.14HP                                                                                                                                                                       ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (13, NULL, N'DEWALT TALADRO DE ROTACIÓN 5/8" 710W                                                                                                                                                                    ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (14, NULL, N'JGO LLAVES TODA MEDIADA STANLEY                                                                                                                                                                         ', N'UNI', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (15, NULL, N'ALCANTARILLAS  METALICA  E=2.00 MM   60"                                                                                                                                                                ', N'PZA', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (16, NULL, N'CIL DE ASFALTO LIQUIDO RC 250                                                                                                                                                                           ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (17, NULL, N'LADRILLO MAQUINADO 18 HUECOS                                                                                                                                                                            ', N'GL ', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (18, NULL, N'TUBO PVC ISO 4435 400MM S-20 (SN 4) X 6M U/F                                                                                                                                                            ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (19, NULL, N'TUBOS PVC S-25 16"                                                                                                                                                                                      ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (20, NULL, N'MILLARES DE LADRILLOS PIRAMIDE PANDERETRA                                                                                                                                                               ', N'MIL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (21, NULL, N'CURADORES DE CONCRETO CILL                                                                                                                                                                              ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (22, NULL, N'LLAVE STYLSON BOSCH                                                                                                                                                                                     ', N'UNI', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 1, 1, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (23, NULL, N'BARNIZ INNIFUGO X 1 GL                                                                                                                                                                                  ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (24, NULL, N'ALCANTARILLAS  METALICA  E=2.00 MM   48"                                                                                                                                                                ', N'PZA', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (25, NULL, N'TUBOS PVC 5-25 10"                                                                                                                                                                                      ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (26, NULL, N'BARRENO CONICAS 8"                                                                                                                                                                                      ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (27, NULL, N'BARRETAS CONICAS 8"                                                                                                                                                                                     ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (28, NULL, N'LLAVE FRANCESA BOSCH 20''''                                                                                                                                                                               ', N'UNI', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (29, NULL, N'BOQUILLAS P/ARENADO D THUNSTENO ALTA 1 1/2                                                                                                                                                              ', N'UNI', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (30, NULL, N'DUCHA DE BAÑO SPRINLKEY                                                                                                                                                                                 ', N'UNI', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (31, NULL, N'BOQUILLAS PARA ARENADO                                                                                                                                                                                  ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (32, NULL, N'PISTOLA P/PINTAR SAGOLA PROFESIONAL                                                                                                                                                                     ', N'UNI', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (33, NULL, N'BARRENO CONICAS 5"                                                                                                                                                                                      ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (34, NULL, N'BARRETAS CONICAS 5"                                                                                                                                                                                     ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (35, NULL, N'ROLLOS DE ALAMBRE RECOJIDO Nº 16 X 100 KG                                                                                                                                                               ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (36, NULL, N'GENERADOR GASOLINA GG920                                                                                                                                                                                ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (37, NULL, N'ALCANTARILLAS  METALICA  E=2.00 MM   36"                                                                                                                                                                ', N'PZA', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (38, NULL, N'TUBOS PVC 5-25 16"                                                                                                                                                                                      ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (39, NULL, N'TALADRO PERCUTOR 1/2" + 54 ACCS - BOSCH                                                                                                                                                                 ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (40, NULL, N'BARRENO CONICAS 3"                                                                                                                                                                                      ', N'GL ', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (41, NULL, N'BARRETAS CONICAS 3"                                                                                                                                                                                     ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (42, NULL, N'LINTERNAS LED RECARGABLE 350 WTS                                                                                                                                                                        ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (43, NULL, N'SOLDADURA CELLOCORD AP 6011 1/8                                                                                                                                                                         ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (44, NULL, N'MANGUERA REFORZADA                                                                                                                                                                                      ', N'UNI', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (45, NULL, N'ROLLO DE CABLE THW # 16                                                                                                                                                                                 ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (46, NULL, N'TUBOS PVC S-25 10"                                                                                                                                                                                      ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (47, NULL, N'GRIFO CUELLO DE CISNE SPRINLE CROMADO                                                                                                                                                                   ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (48, NULL, N'ADITIVO PARA CONTROLADOR DE ROTURA                                                                                                                                                                      ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (49, NULL, N'ARNES DE SEGURIDAD 3M                                                                                                                                                                                   ', N'UNI', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (50, NULL, N'ROLLO DE CABLE THW # 14                                                                                                                                                                                 ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (51, NULL, N'TUBOS DE PVC 200 MM X 6 MT SERIE Nº 20                                                                                                                                                                  ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (52, NULL, N'CARRETILLA BUG.ORE SEMI PESADA RUEDA-NEUM ATICO                                                                                                                                                         ', N'UNI', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (53, NULL, N'CARRETILLAS CON LLANTA REFORZADA DE 6 LONAS ARO Nº 48                                                                                                                                                   ', N'UNI', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (54, NULL, N'TUBOS DE  PVC 160 MM X 6 MT SERIE Nº 20                                                                                                                                                                 ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (55, NULL, N'COCHE DE CARGA 250 KG                                                                                                                                                                                   ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (56, NULL, N'MALLA METALICA ACERDAD DE 3/8 X M2                                                                                                                                                                      ', N'PZA', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (57, NULL, N'MANGUERA P/ARENADO DE 4'''' ALTA PRESION                                                                                                                                                                  ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (58, NULL, N'MANGUERA PARA ARENADO                                                                                                                                                                                   ', N'UNI', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (59, NULL, N'COCHES DE CARGA 250 KG                                                                                                                                                                                  ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (60, NULL, N'ESCALERAS DE SEGURIDAD 3MS                                                                                                                                                                              ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (61, NULL, N'DESMOLDANTE CHEMALAC EXTRA GL                                                                                                                                                                           ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (62, NULL, N'AGLOMERADO MDPKOR 2.14 X 2.44 X 18MM                                                                                                                                                                    ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (63, NULL, N'COMBOS DE 12 KILOS MARCA CORONA                                                                                                                                                                         ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (64, NULL, N'CARRETILLA DE 10 KG  - MARCA : RENDLINE                                                                                                                                                                 ', N'UNI', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (65, NULL, N'PLATAFORMA CON RUEDAS X 150 KG                                                                                                                                                                          ', N'UNI', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (66, NULL, N'SET DE ERRAMIENTAS 250 PIEZAS                                                                                                                                                                           ', N'UNI', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (67, NULL, N'BOTAS PARA SEGURIDAD  3M                                                                                                                                                                                ', N'UNI', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (68, NULL, N'ANGULO 2 1/2'''' X 3/16                                                                                                                                                                                   ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (69, NULL, N'CILINDRO DE PLASTICO                                                                                                                                                                                    ', N'CL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (70, NULL, N'MASCARILLAS DE SEGURIDAD 3 M                                                                                                                                                                            ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (71, NULL, N'CAÑO DE MEDIO TIEMPO INDECO                                                                                                                                                                             ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (72, NULL, N'PERNO EXPANSION 1/2 X 3 X CTO                                                                                                                                                                           ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (73, NULL, N'BROCAS CONICAS Nº 41                                                                                                                                                                                    ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (74, NULL, N'BROCAS CONICAS Nº 38                                                                                                                                                                                    ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (75, NULL, N'CINTAS METRICAS DE 60 MT                                                                                                                                                                                ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (76, NULL, N'COMBA CON MANGO 20 LB - MARCA: MAJOR                                                                                                                                                                    ', N'UNI', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (77, NULL, N'LLAVE FRANCESA BOSCH 20''''                                                                                                                                                                               ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (78, NULL, N'LATEX ROCKY BLANCO 5/1 BAL', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (79, NULL, N'PLATINA PZA 3'''' X 3/16                                                                                                                                                                                  ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (80, NULL, N'COMBA CON MANGO 10 LB PROFESIONAL -MARCA: REDLINE                                                                                                                                                       ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (81, NULL, N'VENCELATEX BLANCO 2 1/2 BAL', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (82, NULL, N'VENCELATEX CREMA 2 1/2 BAL                                                                                                                                                                              ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (83, NULL, N'VENCELATEX MARFIL 2 1/2 BAL                                                                                                                                                                             ', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (84, NULL, N'WATER DE CERAMICO MARCA RECOR                                                                                                                                                                           ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (85, NULL, N'LATEX FIESTA COLOR BLANCO 1/5 BAL                                                                                                                                                                       ', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (86, NULL, N'LATEX FIESTA COLOR VERDE NILO  1GL                                                                                                                                                                      ', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (87, NULL, N'BARRETAS D 1'' X 3''                                                                                                                                                                                      ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (88, NULL, N'BARRETAS DE ACERO MARCA BELLOTA                                                                                                                                                                         ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (89, NULL, N'FIERRO CORRUGADO DE 3/4                                                                                                                                                                                 ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (90, NULL, N'ROLLOS DE CABLE INDECO TW Nª 16 AWG X 100 MT                                                                                                                                                            ', N'PZ ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (91, NULL, N'CILINDRO DE THINER ACRILICO X 55 GL US RECICLABLE                                                                                                                                                       ', N'CL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (92, NULL, N'SET 34 BROCAS PARA TALADRO - BOSCH                                                                                                                                                                      ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (93, NULL, N'TANQUE PARA TAZA DE BAÑO X PZA                                                                                                                                                                          ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (94, NULL, N'SET 5 BROCAS SDS                                                                                                                                                                                        ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (95, NULL, N'EXTENSION VENCEDOR MERIT PRO 6 - 12  (AMARILLA)                                                                                                                                                                   ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (96, NULL, N'BARNIZ TRANSPARENTE ANTI POLILLA 1 GL                                                                                                                                                                   ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (97, NULL, N'COMBA 6 LB PROFESIONAL REDLINE                                                                                                                                                                          ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (98, NULL, N'MALLAS DE SEGURIDAD CUADRADA X 50 MTS                                                                                                                                                                   ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (99, NULL, N'PICOS MARCA BELLOTA                                                                                                                                                                                     ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (100, NULL, N'BOTIN BC 01 T 39                                                                                                                                                                                        ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (101, NULL, N'ALAMBRE DE PUA                                                                                                                                                                                          ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (102, NULL, N'BROCA CONICA HSS 5/8 BLACK CROSS                                                                                                                                                                        ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (103, NULL, N'CASCOS CON RACHET BLANCO 3M                                                                                                                                                                             ', N'UNI', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (104, NULL, N'LATEX ROCKY BLANCO 2 1/2 BAL                                                                                                                                                                            ', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (105, NULL, N'LATEX ROCKY BLANCO HUMO 2 1/2 BAL', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (106, NULL, N'LATEX ROCKY CREMA 2 1/2 BAL', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (107, NULL, N'LATEX ROCKY MARFIL 2 1/2 BAL', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (108, NULL, N'LATEX ROCKY MARFIL CLARO 2 1/2 BAL', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (109, NULL, N'FIERRO CORRUGADO DE 5 / 8                                                                                                                                                                               ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (110, NULL, N'LENTES DE SEGURIDAD                                                                                                                                                                                     ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (111, NULL, N'PARES DE GUANTES X PZS                                                                                                                                                                                  ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (112, NULL, N'PROTECTORES DE OIDO 3M                                                                                                                                                                                  ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (113, NULL, N'THINER ACRILICO KLAP-300 1 GL                                                                                                                                                                           ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (114, NULL, N'EXTENSION VENCEDOR MERIT PRO 4 - 8 (AMARILLA)                                                                                                                                                                     ', N'UNI', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (115, NULL, N'CHALECOS PARA SEGURIDAD  3M                                                                                                                                                                             ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (116, NULL, N'CHALECOS REFLEXIVO POLIESTER LIJERO NARANJA                                                                                                                                                             ', N'UNI', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (117, NULL, N'EXTENSION DE ALUMINIO 4-8 MERIT PRO  (PLATEADA)                                                                                                                                                                 ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (118, NULL, N'PALAS REDONDAS - MARCA: TRUPER                                                                                                                                                                          ', N'UNI', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (119, NULL, N'LAVATORIO DE CERAMICA X PZA                                                                                                                                                                             ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (120, NULL, N'ALMENDRA   VENCEDOR  1/1 BAL                                                                                                                                                                            ', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (121, NULL, N'LATEX COLORES 1/1 BAL                                                                                                                                                                                   ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (122, NULL, N'SUNSET      VENCEDOR   1/1 BAL                                                                                                                                                                          ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (123, NULL, N'VENCELATEX   BLANCO     1   1/2 BAL                                                                                                                                                                     ', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (124, NULL, N'VENCELATEX ALABASTO 1/1 BAL', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (125, NULL, N'VENCELATEX ALBARICOQUE 1/1 BAL', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (126, NULL, N'VENCELATEX ALMENDRA 1/1 BAL', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (127, NULL, N'VENCELATEX ARENA 1/1 BAL', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (128, NULL, N'VENCELATEX ARRECIFE 1/1 BAL', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (129, NULL, N'VENCELATEX AZUL  1/1 BAL                                                                                                                                                                                ', N'BAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (130, NULL, N'VENCELATEX AZUL EMOTION 1/1 BAL', N'BAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (131, NULL, N'VENCELATEX AZUL NOCTURNO 1/1 BAL', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (132, NULL, N'VENCELATEX AZUL ORIENTE 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (133, NULL, N'VENCELATEX BLANCO 1/1 BAL', N'BAL', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (134, NULL, N'VENCELATEX BLANCO HUMO 1/1 BAL', N'BAL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (135, NULL, N'VENCELATEX BLANCO OSTRA 1/1 BAL', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (136, NULL, N'VENCELATEX BLANCO OSTRA 2 1/2  BAL                                                                                                                                                                      ', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (137, NULL, N'VENCELATEX CANCHA DE TENNIS 1/1 BAL                                                                                                                                                                     ', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (138, NULL, N'VENCELATEX CAPUCCINO 1/1 BAL', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (139, NULL, N'VENCELATEX CASTANA 1/1 BAL', N'BAL', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (140, NULL, N'VENCELATEX CERAMICO 1/1 BAL', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (141, NULL, N'VENCELATEX COLORES 1/1 BAL                                                                                                                                                                              ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (142, NULL, N'VENCELATEX COLORES 1/16 BAL                                                                                                                                                                             ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (143, NULL, N'VENCELATEX COLORES 3/4 BAL                                                                                                                                                                              ', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (144, NULL, N'VENCELATEX CREMA 1/1 BAL', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (145, NULL, N'VENCELATEX EMBRUJO DE SOL 1/1 BAL', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (146, NULL, N'VENCELATEX EXPRESSION 1/1 BAL', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (147, NULL, N'VENCELATEX GRIS CLARO 1/1 BAL', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (148, NULL, N'VENCELATEX MARFIL 1/1 BAL', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (149, NULL, N'VENCELATEX MATIZADO 1/1 BAL                                                                                                                                                                             ', N'BAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (150, NULL, N'VENCELATEX MELON 1/1 BAL', N'BAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (151, NULL, N'VENCELATEX MISTICO 1/1 BAL', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (152, NULL, N'VENCELATEX NEGRO 1/1 BAL', N'BAL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (153, NULL, N'VENCELATEX OCRE 1/1 BAL', N'BAL', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (154, NULL, N'VENCELATEX ROJO TEJA 1/1 BAL', N'BAL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (155, NULL, N'VENCELATEX ROSADO VIRREYNAL 1/1 BAL', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (156, NULL, N'VENCELATEX SUNSET 1/1 BAL', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (157, NULL, N'VENCELATEX TABACO 1/1 BAL                                                                                                                                                                               ', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (158, NULL, N'VENCELATEX VERDE CANCHA T. 1/1 BAL', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (159, NULL, N'VENCELATEX VERDE HOJA 1/1 BAL', N'BAL', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (160, NULL, N'VENCELATEX VERDE TENIS 1/1 BAL                                                                                                                                                                          ', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (161, NULL, N'VENCELATEX VERDE TROPICAL  1/1 BAL                                                                                                                                                                      ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (162, NULL, N'CASCOS 3 M                                                                                                                                                                                              ', N'UNI', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (163, NULL, N'LAMPA CUCHARA CONSTRUCCIÓN                                                                                                                                                                              ', N'UNI', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (164, NULL, N'PALAS PUNTA HUEVO CON MANGO  - MARCA : TRAMONTINA                                                                                                                                                       ', N'UNI', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (165, NULL, N'TUBO GALVANIZADO X 2" X 6 MT                                                                                                                                                                            ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (166, NULL, N'PRESERVANTE PARA MADERA 1 GL DERQUSA                                                                                                                                                                    ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (167, NULL, N'TONEL CARTON RECICLABLE X 50 KG                                                                                                                                                                         ', N'UNI', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (168, NULL, N'BROCHA TUMI EXTRA NYLON 6                                                                                                                                                                               ', N'PZA', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (169, NULL, N'CERA EN PASTA AROLIT AMARILLO 1 GL DERQUSA                                                                                                                                                              ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (170, NULL, N'CERA EN PASTA AROLIT NEGRO 1 GL DERQUSA                                                                                                                                                                 ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (171, NULL, N'CERA EN PASTA AROLIT ROJO 1 GL DERQUSA                                                                                                                                                                  ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (172, NULL, N'CEMENTO PACASMAYO EXTRA FORTE – ROJO- (42,5 KG)                                                                                                                                                         ', N'BOL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (173, NULL, N'PARES DE BOTAS DE CUERO ECONOMICO PUNTA DE ACERO                                                                                                                                                        ', N'UNI', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (174, NULL, N'FIERRO CORRUGADO DE 1/2                                                                                                                                                                                 ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (175, NULL, N'FIERRO CORRUGADO DE 1/2                                                                                                                                                                                 ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (176, NULL, N'CAJAS DE DESAGUE PRE FABRICADOS                                                                                                                                                                         ', N'UNI', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (177, NULL, N'PALANAS CUCHARA MARCA: MAJOR                                                                                                                                                                            ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (178, NULL, N'PICO SIN MANGO ECONOMICO - MAJOR                                                                                                                                                                        ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (179, NULL, N'BROCHA TUMI EXTRA NYLON 5                                                                                                                                                                               ', N'PZA', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (180, NULL, N'SUPER GLOSS COLORES 3/8 GL ANYPSA                                                                                                                                                                       ', N'GAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (181, NULL, N'ANILLO DE JEBE 400MM ALCANTARILLADO                                                                                                                                                                     ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (182, NULL, N'CEMENTO PACASMAYO, ANTI SALITRE MS -AZUL- (42,5 KG)                                                                                                                                                     ', N'BOL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (183, NULL, N'BARILLA DE ACERO DE 12 MM                                                                                                                                                                               ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (184, NULL, N'FIERRO CORRUGADO DE 12 MM                                                                                                                                                                               ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (185, NULL, N'FORTACHO DE MADERA 20 X 36                                                                                                                                                                              ', N'PZA', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (186, NULL, N'TEMPLE BLANCO 30 KG ATLANTI                                                                                                                                                                             ', N'BOL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (187, NULL, N'TEMPLE BLANCO 30 KG CHANG                                                                                                                                                                               ', N'BOL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (188, NULL, N'CAJAS DE AGUA PRE FABRICADOS                                                                                                                                                                            ', N'UNI', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (189, NULL, N'IMPRIMANTE 20 LT VENCEDOR                                                                                                                                                                               ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (190, NULL, N'PLANCHAS DE TECNOPOR 1.20 X 2.40 MT X 2"                                                                                                                                                                ', N'PZA', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (191, NULL, N'BROCHA MERIT PRO 4" (VERDE)                                                                                                                                                                             ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (192, NULL, N'THINER ACRILICO KLAP-300 1/2 GL                                                                                                                                                                         ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (193, NULL, N'CERAMICA BLANCA PARA PARED X 12 MM                                                                                                                                                                      ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (194, NULL, N'LATEX ROCKY AGUAMARINA 1/1 BAL                                                                                                                                                                          ', N'BAL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (195, NULL, N'LATEX ROCKY AMARILLO TROPICAL 1/1 BAL', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (196, NULL, N'LATEX ROCKY AMBAR 1/1 BAL', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (197, NULL, N'LATEX ROCKY ARENA 1/1 BAL', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (198, NULL, N'LATEX ROCKY AZUL ELECTRICO 1/1 BAL                                                                                                                                                                      ', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (199, NULL, N'LATEX ROCKY BISCUIT 1/1 BAL', N'BAL', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (200, NULL, N'LATEX ROCKY BLANCO 1/1 BAL', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (201, NULL, N'LATEX ROCKY BLANCO ARENA 1/1 BAL', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (202, NULL, N'LATEX ROCKY BLANCO HUMO 1/1 BAL', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (203, NULL, N'LATEX ROCKY BLANCO OSTRA 1/1 BAL', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (204, NULL, N'LATEX ROCKY CALIPSO 1/1 BAL                                                                                                                                                                             ', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (205, NULL, N'LATEX ROCKY CALIPSO 1/1 BAL', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (206, NULL, N'LATEX ROCKY CANELO 1/1 BAL', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (207, NULL, N'LATEX ROCKY CELESTE 1/1 BAL', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (208, NULL, N'LATEX ROCKY CERAMICO 1/1 BAL', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (209, NULL, N'LATEX ROCKY COLORES      2  1/2 BAL                                                                                                                                                                     ', N'BAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (210, NULL, N'LATEX ROCKY COLORES 1/1 BAL                                                                                                                                                                             ', N'BAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (211, NULL, N'LATEX ROCKY CREMA 1/1 BAL', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (212, NULL, N'LATEX ROCKY CREMA 5  BAL                                                                                                                                                                                ', N'BAL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (213, NULL, N'LATEX ROCKY DURAZNO 1/1 BAL', N'BAL', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (214, NULL, N'LATEX ROCKY GRIS CLARO 1/1 BAL', N'BAL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (215, NULL, N'LATEX ROCKY GRIS OSCURO   5/1 BAL                                                                                                                                                                       ', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (216, NULL, N'LATEX ROCKY GRIS PERLA 1/1 BAL', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (217, NULL, N'LATEX ROCKY MARFIL 1/1 BAL', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (218, NULL, N'LATEX ROCKY MARFIL CLARO 1/1 BAL', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (219, NULL, N'LATEX ROCKY MATIZADO 1/1 BAL                                                                                                                                                                            ', N'BAL', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (220, NULL, N'LATEX ROCKY MATIZADO 1/2 BAL                                                                                                                                                                            ', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (221, NULL, N'LATEX ROCKY MATIZADO 5/1 BAL                                                                                                                                                                            ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (222, NULL, N'LATEX ROCKY MELON 1/1 BAL', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (223, NULL, N'LATEX ROCKY OCRE 1/1 BAL', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (224, NULL, N'LATEX ROCKY ROJO BANDERA 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3, 3, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (225, NULL, N'LATEX ROCKY ROSADO COLON 1/1 BAL', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (226, NULL, N'LATEX ROCKY TABACO 1/1 BAL', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (227, NULL, N'LATEX ROCKY TEJA 1/1 BAL', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (228, NULL, N'LATEX ROCKY VERDE 1/1 BAL                                                                                                                                                                               ', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (229, NULL, N'LATEX ROCKY VERDE BAMBU 1/1 BAL', N'BAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (230, NULL, N'LATEX ROCKY VERDE CAPTUS 1/1 BAL', N'BAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (231, NULL, N'LATEX ROCKY VERDE NILO 1/1 BAL', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (232, NULL, N'LATEX ROCKY VERDE TENIS 1/1 BAL', N'BAL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (233, NULL, N'LATEX ROCKY VERDE TUNA 1/1 BAL                                                                                                                                                                          ', N'BAL', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (234, NULL, N'MANGUERA DE AIRE 1/8 X 4''                                                                                                                                                                               ', N'UNI', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (235, NULL, N'BROCHA TUMI EXTRA NYLON 4                                                                                                                                                                               ', N'PZA', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (236, NULL, N'PARES DE  BOTAS DE  PVC                                                                                                                                                                                 ', N'UNI', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (237, NULL, N'PARES DE GUANTES DE CUERO MARCA: STEELPRO                                                                                                                                                               ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (238, NULL, N'DISCO CORTE INOX 14"X7/64"X1" (355.6X3.0X25.4) - NORTON                                                                                                                                                 ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (239, NULL, N'BARRA DE CAERO 3/8 " - ACEROS AREQUIPA                                                                                                                                                                  ', N'UNI', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (240, NULL, N'IMPRIMANTE ACRILICO 4 LT MONTENEGRO                                                                                                                                                                     ', N'GL ', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (241, NULL, N'SELLADOR P'' PARED BASE LATEX 1/1 CPP                                                                                                                                                                    ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (242, NULL, N'SELLADOR P'' PARED BASE LATEX 1/1 VENCEDOR                                                                                                                                                               ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (243, NULL, N'SELLADORA GRANEL 1/16 GL PARACAS                                                                                                                                                                        ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (244, NULL, N'UNDERCOATING PROTECTOR AUTOMOTRIZ 1 GL DERQUSA                                                                                                                                                          ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (245, NULL, N'WINCHA 5 MTS GLOBAL PLUS 30-615 - STANLEY                                                                                                                                                               ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (246, NULL, N'FIERRO CORRUGADO 3/8 X 9 MTS SIDER PERU                                                                                                                                                                 ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (247, NULL, N'FIERRO CORRUGADO DE 3/ 8                                                                                                                                                                                ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (248, NULL, N'MAESTRO THINER ACRILICO 1 GL                                                                                                                                                                            ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (249, NULL, N'PARES DE GUANTES DE CUERO MARCA: STEELPRO                                                                                                                                                               ', N'UNI', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (250, NULL, N'RODILLO AMARILLO ONE COAT                                                                                                                                                                               ', N'PZA', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (251, NULL, N'THINER STANDAR                                                                                                                                                                                          ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (252, NULL, N'THINER STANDAR 1 GL                                                                                                                                                                                     ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (253, NULL, N'BARILLA DE ACERO DE 3/8                                                                                                                                                                                 ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (254, NULL, N'FOCOS AHORRADORES 25 WTS                                                                                                                                                                                ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (255, NULL, N'LATEX FIESTA COLOR AMARILLO CROMO 1/1 BAL                                                                                                                                                               ', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (256, NULL, N'LATEX FIESTA COLOR ARENA 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (257, NULL, N'LATEX FIESTA COLOR AZUL CALIPSO 1/1 BAL                                                                                                                                                                 ', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (258, NULL, N'LATEX FIESTA COLOR AZUL ELECTRICO 1/1 BAL                                                                                                                                                               ', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (259, NULL, N'LATEX FIESTA COLOR BLANCO 1/1 BAL                                                                                                                                                                       ', N'BAL', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (260, NULL, N'LATEX FIESTA COLOR BLANCO NACAR 1/1 BAL                                                                                                                                                                 ', N'BAL', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (261, NULL, N'LATEX FIESTA COLOR CELESTE 1/1 BAL                                                                                                                                                                      ', N'BAL', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (262, NULL, N'LATEX FIESTA COLOR CORAL 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (263, NULL, N'LATEX FIESTA COLOR CREMA 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (264, NULL, N'LATEX FIESTA COLOR MANDARINA 1/1 BAL                                                                                                                                                                    ', N'BAL', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (265, NULL, N'LATEX FIESTA COLOR MARFIL CONGO 1/1 BAL                                                                                                                                                                 ', N'BAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (266, NULL, N'LATEX FIESTA COLOR MATIZADO  1   GL                                                                                                                                                                     ', N'BAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (267, NULL, N'LATEX FIESTA COLOR NEGRO 1/1 BAL                                                                                                                                                                        ', N'BAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (268, NULL, N'LATEX FIESTA COLOR OCRE 1/1 BAL                                                                                                                                                                         ', N'BAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (269, NULL, N'LATEX FIESTA COLOR ROJO BANDERA 1/1 BAL                                                                                                                                                                 ', N'BAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (270, NULL, N'LATEX FIESTA COLOR ROJO TEJA 1/1 BAL                                                                                                                                                                    ', N'BAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (271, NULL, N'LATEX FIESTA COLOR TEJA 1/1 BAL                                                                                                                                                                         ', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (272, NULL, N'LATEX FIESTA COLOR VERDE ESMERALDA 1/1 BAL                                                                                                                                                              ', N'BAL', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (273, NULL, N'LATEX FIESTA COLOR VERDE ESPERANZA 1/1 BAL                                                                                                                                                              ', N'BAL', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (274, NULL, N'LATEX FIESTA COLOR VERDE GRASS 1/1 BAL                                                                                                                                                                  ', N'BAL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (275, NULL, N'LATEX FIESTA COLOR VERDE PASTEL 1/1 BAL                                                                                                                                                                 ', N'BAL', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (276, NULL, N'LATEX FIESTA COLOR VERDE TENIS 1/1 BAL                                                                                                                                                                  ', N'BAL', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (277, NULL, N'LATEX FIESTA COLORES                                                                                                                                                                                    ', N'BAL', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (278, NULL, N'LATEX FIESTA COLORES 1/2                                                                                                                                                                                ', N'BAL', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (279, NULL, N'AQUARAMA TONERS 4 LT AMARILLO LIMON MONTENGRO                                                                                                                                                           ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (280, NULL, N'AQUARAMA TONERS 4 LT AMARILLO MEDIO MONTENGRO                                                                                                                                                           ', N'GL ', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (281, NULL, N'AQUARAMA TONERS 4 LT AZUL ELECTRICO MONTENGRO                                                                                                                                                           ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (282, NULL, N'AQUARAMA TONERS 4 LT AZUL ULRAMAR MONTENGRO                                                                                                                                                             ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (283, NULL, N'AQUARAMA TONERS 4 LT NEGRO MONTENGRO                                                                                                                                                                    ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (284, NULL, N'AQUARAMA TONERS 4 LT ROJO BANDERA MONTENGRO                                                                                                                                                             ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (285, NULL, N'AQUARAMA TONERS 4 LT VERDE PINO MONTENGRO                                                                                                                                                               ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (286, NULL, N'AQUARAMA TONERS 4 LT VIOLETA MONTENGRO                                                                                                                                                                  ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (287, NULL, N'ESCOBAS BAJA POLICIA                                                                                                                                                                                    ', N'UNI', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (288, NULL, N'MANGO DE MADERA PARA PICO                                                                                                                                                                               ', N'UNI', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (289, NULL, N'RODILLO AMARILLO TORO 12''''                                                                                                                                                                              ', N'PZA', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (290, NULL, N'BROCHA TUMI EXTRA NYLON 3''''                                                                                                                                                                             ', N'PZA', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (291, NULL, N'RODILLO AMARILLO TORO 9''''                                                                                                                                                                               ', N'PZA', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (292, NULL, N'RODILLO BLANCO TORO 12''''                                                                                                                                                                                ', N'PZA', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 1, 1, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (293, NULL, N'THINER ACRILICO KLAP-300 1 LT                                                                                                                                                                           ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (294, NULL, N'THINER ACRILICO KLAP-300 1/4 GL                                                                                                                                                                         ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (295, NULL, N'JALADOR DE AGUA                                                                                                                                                                                         ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (296, NULL, N'GUANTES CROMO ALMA AMARILLO                                                                                                                                                                             ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (297, NULL, N'GUANTEX PROTEX CALIBRE 25/ LARGO 12''                                                                                                                                                                    ', N'GL ', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (298, NULL, N'RODILLO BLANCO TORO 9''''                                                                                                                                                                                 ', N'PZA', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (299, NULL, N'THINER ACRILICO 2 LTS ASTRO                                                                                                                                                                             ', N'LT ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (300, NULL, N'CINCEL PLANO 3/4 "                                                                                                                                                                                      ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (301, NULL, N'BASE ZINCROMATO MAESTRO 1/4 GL ANYPSA                                                                                                                                                                   ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (302, NULL, N'BROCHA KAISER X 6 ''''                                                                                                                                                                                    ', N'UNI', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (303, NULL, N'BROCHA TUMI EXTRA NYLON 2 1/2''''                                                                                                                                                                         ', N'PZA', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (304, NULL, N'CANTO AZUL NOVOKOR 22 X 3.00 MM                                                                                                                                                                         ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (305, NULL, N'SUPER GLOSS BLANCO 1/4 GL ANYPSA                                                                                                                                                                        ', N'GAL', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (306, NULL, N'SUPER GLOSS BLANCO 1/8 GL ANYPSA                                                                                                                                                                        ', N'GAL', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (307, NULL, N'SUPER GLOSS COLORES 1/4 GL ANYPSA                                                                                                                                                                       ', N'GAL', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (308, NULL, N'SUPER GLOSS COLORES 1/8 GL ANYPSA                                                                                                                                                                       ', N'GAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (309, NULL, N'SUPER GLOSS COLORES 6/8 GL ANYPSA                                                                                                                                                                       ', N'GAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (310, NULL, N'BIDON 20 LTS                                                                                                                                                                                            ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (311, NULL, N'BROCHA KAISER X 5 ''''                                                                                                                                                                                    ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (312, NULL, N'MASILLA VELOZ FLEX                                                                                                                                                                                      ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (313, NULL, N'PINTURA SPRAY  NEGRO                                                                                                                                                                                    ', N'UNI', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (314, NULL, N'PINTURA SPRAY AMARILLO LIMON ABRO                                                                                                                                                                       ', N'UNI', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (315, NULL, N'PINTURA SPRAY AZUL CLARO ABRO                                                                                                                                                                           ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (316, NULL, N'PINTURA SPRAY AZUL OSCURO ABRO                                                                                                                                                                          ', N'UNI', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (317, NULL, N'PINTURA SPRAY BLANCO ABRO                                                                                                                                                                               ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (318, NULL, N'PINTURA SPRAY CELESTE                                                                                                                                                                                   ', N'UNI', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (319, NULL, N'PINTURA SPRAY CREMA PASTEL  ABRO                                                                                                                                                                        ', N'UNI', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (320, NULL, N'PINTURA SPRAY DORADO ABRO                                                                                                                                                                               ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (321, NULL, N'PINTURA SPRAY GRIS ABRO                                                                                                                                                                                 ', N'UNI', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (322, NULL, N'PINTURA SPRAY LIGHT GREEN ABRO                                                                                                                                                                          ', N'UNI', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (323, NULL, N'PINTURA SPRAY MARFIL ABRO                                                                                                                                                                               ', N'UNI', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (324, NULL, N'PINTURA SPRAY MEDIUN GREY KNAUF                                                                                                                                                                         ', N'UNI', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (325, NULL, N'PINTURA SPRAY NARANJA ABRO                                                                                                                                                                              ', N'UNI', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (326, NULL, N'PINTURA SPRAY NEGRO                                                                                                                                                                                     ', N'UNI', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (327, NULL, N'PINTURA SPRAY ROJO FUEGO ABRO                                                                                                                                                                           ', N'UNI', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (328, NULL, N'PINTURA SPRAY TRANSPARENTE ABRO                                                                                                                                                                         ', N'UNI', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (329, NULL, N'PINTURA SPRAY VERDE IRLANDES ABRO                                                                                                                                                                       ', N'UNI', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (330, NULL, N'PINTURA SPRAY VERDE OSCURO                                                                                                                                                                              ', N'UNI', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (331, NULL, N'SELLADOR P'' PARED BASE LATEX 1/2                                                                                                                                                                        ', N'BAL', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (332, NULL, N'SPRAY COLORES                                                                                                                                                                                           ', N'UNI', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (333, NULL, N'THINER ACRILICO 1 1/2 LT  ASTRO                                                                                                                                                                         ', N'LT ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (334, NULL, N'THINER ACRILICO 1/2 GL ASTRO                                                                                                                                                                            ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (335, NULL, N'THINER STANDAR 1/2 GL                                                                                                                                                                                   ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (336, NULL, N'ANTEOJOS ASTRO  LITE NEGRO CLARO                                                                                                                                                                        ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (337, NULL, N'BROCHA TUMI EXTRA NYLON 2''                                                                                                                                                                              ', N'PZA', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (338, NULL, N'BROCHA KAISER X 4 ''''                                                                                                                                                                                    ', N'UNI', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (339, NULL, N'BARILLA DE ACERO DE 6 MM                                                                                                                                                                                ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (340, NULL, N'BROCHA TUMI EXTRA NYLON 1 1/2                                                                                                                                                                           ', N'PZA', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (341, NULL, N'BROCHA KAISER X 3 ''''                                                                                                                                                                                    ', N'UNI', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (342, NULL, N'ENVASES PLASTICOS 20 LTS                                                                                                                                                                                ', N'LT ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (343, NULL, N'THINER ACRILICO KLAP-300 1/2  LT                                                                                                                                                                        ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (344, NULL, N'THINER STANDAR 1 LT                                                                                                                                                                                     ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (345, NULL, N'TUBO DE 1/2 " X 6 MT CLASE Nº 10                                                                                                                                                                        ', N'PZA', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (346, NULL, N'RODILLO AMARILLO TIGRE 3 ''''                                                                                                                                                                             ', N'PZA', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (347, NULL, N'THINER ACRILICO 1 LT ASTRO                                                                                                                                                                              ', N'LT ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (348, NULL, N'DUCO BLANCO 1/8 GL                                                                                                                                                                                      ', N'GAL', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (349, NULL, N'DUCO NEGRO 1/8 GL                                                                                                                                                                                       ', N'GAL', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (350, NULL, N'DUCO ROJO BERMELLON 1/8 GL                                                                                                                                                                              ', N'GAL', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (351, NULL, N'BROCHA KAISER X 2 1/2 ''''                                                                                                                                                                                ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (352, NULL, N'BROCHA TUMI EXTRA NYLON 1''''                                                                                                                                                                             ', N'PZA', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (353, NULL, N'KRESO                                                                                                                                                                                                   ', N'LT ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (354, NULL, N'TEMPLE BLANCO X 5  KG CHANG                                                                                                                                                                             ', N'BOL', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (355, NULL, N'THINER ACRILICO 1/4 GL ASTRO                                                                                                                                                                            ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (356, NULL, N'THINER ACRILICO KLAP-300 1/16 GL                                                                                                                                                                        ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (357, NULL, N'UNION Y DE 4 - 2                                                                                                                                                                                        ', N'GL ', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (358, NULL, N'UNION Y DE 4 X 90                                                                                                                                                                                       ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (359, NULL, N'BROCHA KAISER X 2 ''''                                                                                                                                                                                    ', N'UNI', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (360, NULL, N'BROCHA TUMI EXTRA NYLON 3/4                                                                                                                                                                             ', N'PZA', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (361, NULL, N'CINTAS PEGAFAN MULTIUSO  1''  X 30 YDS - KURESA                                                                                                                                                          ', N'PZA', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (362, NULL, N'SELLADOR P'' PARED BASE LATEX 1/8 GL VENCEDOR                                                                                                                                                            ', N'BAL', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (363, NULL, N'ACIDO MURIATICO                                                                                                                                                                                         ', N'LT ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (364, NULL, N'ESMALTE  COLORES                                                                                                                                                                                        ', N'LT ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (365, NULL, N'BROCHA TUMI EXTRA NYLON 1/2                                                                                                                                                                             ', N'PZA', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (366, NULL, N'CARTON RECICLABLE X 1KG                                                                                                                                                                                 ', N'UNI', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (367, NULL, N'CINTAS PEGAFAN MULTIUSO  3/4 X 30 YDS - KURESA                                                                                                                                                          ', N'PZA', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (368, NULL, N'THINER ACRILICO 1/2  LTS ASTRO                                                                                                                                                                          ', N'LT ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (369, NULL, N'THINER STANDAR 1/2 LT                                                                                                                                                                                   ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (370, NULL, N'LADRILLO TIERNO                                                                                                                                                                                         ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (371, NULL, N'BROCHA KAISER X 1 1/2 ''''                                                                                                                                                                                ', N'UNI', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (372, NULL, N'CARPA DE PLASTICOLO COLOR AZUL                                                                                                                                                                          ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (373, NULL, N'PRODUCTO NUEVO COLOR 1                                                                                                                                                                                  ', N'LT ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (374, NULL, N'PRODUCTO NUEVO COLOR 2                                                                                                                                                                                  ', N'LT ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (375, NULL, N'SEÑALIZADORES 3M                                                                                                                                                                                        ', N'UNI', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (376, NULL, N'PERIODICO X KG                                                                                                                                                                                          ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (377, NULL, N'BROCHA KAISER X 1 ''''                                                                                                                                                                                    ', N'UNI', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (378, NULL, N'CORDON DE NYLON X 1MM X 5MM                                                                                                                                                                             ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (379, NULL, N'TELA ESMERIL ASA 100''                                                                                                                                                                                   ', N'UNI', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (380, NULL, N'TELA ESMERIL ASA 120''                                                                                                                                                                                   ', N'UNI', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (381, NULL, N'TELA ESMERIL ASA 150''''                                                                                                                                                                                  ', N'UNI', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (382, NULL, N'TELA ESMERIL ASA 180''''                                                                                                                                                                                  ', N'INU', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (383, NULL, N'THINER ACRILICO 1/4  LTS ASTRO                                                                                                                                                                          ', N'LT ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (384, NULL, N'THINER STANDAR 1/4 LT                                                                                                                                                                                   ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (385, NULL, N'CAJA DE CARTON RECICLABLE                                                                                                                                                                               ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (386, NULL, N'BROCHA KAISER X 3/4 ''''                                                                                                                                                                                  ', N'UNI', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (387, NULL, N'CODO 2 X 90                                                                                                                                                                                             ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (388, NULL, N'FLUORECENTE X 220 WATTS FILLIPS                                                                                                                                                                         ', N'UNI', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (389, NULL, N'TOMACORRIENTE X UNI BTCINO                                                                                                                                                                              ', N'UNI', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (390, NULL, N'BROCHA KAISER X 1/2 ''''                                                                                                                                                                                  ', N'UNI', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (391, NULL, N'TUBO 2''                                                                                                                                                                                                 ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (392, NULL, N'ESPONJA                                                                                                                                                                                                 ', N'UNI', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (393, NULL, N'3T ACONDICIONADOR PARA METALES POWER X-5                                                                                                                                                                ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (394, NULL, N'3T ACRYLIC LACQUER X-5 COLORES                                                                                                                                                                          ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (395, NULL, N'3T ACRYLIC PERLADO TRICAPA X-5 ANYPSA                                                                                                                                                                   ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (396, NULL, N'3T BASE A LA PIROXILINA X-5 ANYPSA                                                                                                                                                                      ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (397, NULL, N'3T BONKFLEX KONG X-5 ANYPSA                                                                                                                                                                             ', N'GL ', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (398, NULL, N'3T EXTRA THINER ULTRAPREMIUN L300                                                                                                                                                                       ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (399, NULL, N'3T PULIDOR PLUS FINO X-5 ANYPSA                                                                                                                                                                         ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (400, NULL, N'3T REMOVEDOR DE PINTURA POWER X-5                                                                                                                                                                       ', N'GL ', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (401, NULL, N'3T UNDERCAUTING X-5 ANYPSA                                                                                                                                                                              ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 2, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (402, NULL, N'ACONDICIONADOR DE METALES  1 GL ANYPSA                                                                                                                                                                  ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (403, NULL, N'ACONDICIONADOR DE METALES  1 GL CRONS                                                                                                                                                                   ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (404, NULL, N'ACONDICIONADOR DE METALES  1 GL PARACAS                                                                                                                                                                 ', N'GL ', CAST(17.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (405, NULL, N'ACONDICIONADOR DE METALES  1 LT PARACAS                                                                                                                                                                 ', N'GL ', CAST(20.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (406, NULL, N'ACONDICIONADOR DE METALES  1/16 GL PARACAS                                                                                                                                                              ', N'GL ', CAST(22.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (407, NULL, N'ACONDICIONADOR DE METALES  1/2 GL ANYPSA                                                                                                                                                                ', N'GL ', CAST(25.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (408, NULL, N'ACONDICIONADOR DE METALES  1/2 GL PARACAS                                                                                                                                                               ', N'GL ', CAST(27.67 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (409, NULL, N'ACONDICIONADOR DE METALES  1/2 LT ANYPSA                                                                                                                                                                ', N'GL ', CAST(30.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (410, NULL, N'ACONDICIONADOR DE METALES  1/32 GL PARACAS                                                                                                                                                              ', N'GL ', CAST(32.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (411, NULL, N'ACONDICIONADOR DE METALES  1/4 GL ANYPSA                                                                                                                                                                ', N'GL ', CAST(35.17 AS Decimal(18, 2)), CAST(37.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (412, NULL, N'ACONDICIONADOR DE METALES  1/4 GL PARACAS                                                                                                                                                               ', N'GL ', CAST(37.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (413, NULL, N'ACONDICIONADOR DE METALES  1/8 GL PARACAS                                                                                                                                                               ', N'GL ', CAST(40.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (414, NULL, N'AGUA RRAZ ENVASADO   1 GL                                                                                                                                                                               ', N'GL ', CAST(42.67 AS Decimal(18, 2)), CAST(44.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (415, NULL, N'AGUA RRAZ ENVASADO GL 2DA                                                                                                                                                                               ', N'GL ', CAST(45.17 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (416, NULL, N'AGUA RRAZ ENVASADO GL 2DA 1/2 GL                                                                                                                                                                        ', N'GL ', CAST(47.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (417, NULL, N'AGUA RRAZ ENVASADO GL 2DA 1/2 LT                                                                                                                                                                        ', N'GL ', CAST(50.17 AS Decimal(18, 2)), CAST(52.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (418, NULL, N'AGUA RRAZ ENVASADO GL 2DA 1/4 LT                                                                                                                                                                        ', N'GL ', CAST(52.67 AS Decimal(18, 2)), CAST(54.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (419, NULL, N'AGUA RRAZ ENVASADO GL 2DA 1LT                                                                                                                                                                           ', N'GL ', CAST(55.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (420, NULL, N'AGUA RRAZ ENVASADO GL 2DA 2LT                                                                                                                                                                           ', N'GL ', CAST(57.67 AS Decimal(18, 2)), CAST(59.67 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (421, NULL, N'ALAMBRE NEGRO RECOCIDO NRO 8                                                                                                                                                                            ', N'GL ', CAST(10.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (422, NULL, N'ALAMBRE Nº 16                                                                                                                                                                                           ', N'GL ', CAST(13.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (423, NULL, N'ALAMBRE Nº 80                                                                                                                                                                                           ', N'GL ', CAST(15.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2, 2, 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (424, NULL, N'TEST', N'QWE', CAST(23.50 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), 2, 1, 2, 1, CAST(0x0000A53800C1F1BB AS DateTime), 1, CAST(0x0000A53800C25018 AS DateTime))
INSERT [Almacen].[Producto] ([id_producto], [codigo], [descripcion], [unidad_med], [precio_min], [precio_max], [id_marca], [id_categoria], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (425, NULL, N'TESTING', N'GL', CAST(20.00 AS Decimal(18, 2)), CAST(28.00 AS Decimal(18, 2)), 2, 1, 2, 1, CAST(0x0000A61F00EFF9E2 AS DateTime), 1, CAST(0x0000A61F00F01D56 AS DateTime))
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 1, CAST(27.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 2, CAST(9.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 3, CAST(49.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 4, CAST(29.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 5, CAST(49.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 6, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 7, CAST(39.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 8, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 9, CAST(37.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 10, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 11, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 12, CAST(41.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 13, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 14, CAST(6.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 15, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 16, CAST(18.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 17, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 18, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 19, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 20, CAST(223.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 21, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 22, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 23, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 24, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 25, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 26, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 27, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 28, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 29, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 30, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 31, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 32, CAST(424.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 33, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 34, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 35, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 36, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 37, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 38, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 39, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 40, CAST(28.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 41, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 42, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 43, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 44, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 45, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 46, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 47, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 48, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 49, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 50, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 51, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 52, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 53, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 54, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 55, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 56, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 57, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 58, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 59, CAST(31.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 60, CAST(-4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 61, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 62, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 63, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 64, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 65, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 66, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 67, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 68, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 69, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 70, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 71, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 72, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 73, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 74, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 75, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 76, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 77, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 78, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 79, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 80, CAST(22.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 81, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 82, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 83, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 84, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 85, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 86, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 87, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 88, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 89, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 90, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 91, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 92, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 93, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 94, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 95, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 96, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 97, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 98, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 99, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 100, CAST(405.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 101, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 102, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 103, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 104, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 105, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 106, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 107, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 108, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 109, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 110, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 111, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 112, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 113, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 114, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 115, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 116, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 117, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 118, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 119, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 120, CAST(29.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 121, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 122, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 123, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 124, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 125, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 126, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 127, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 128, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 129, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 130, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 131, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 132, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 133, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 134, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 135, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 136, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 137, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 138, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 139, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 140, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 141, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 142, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 143, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 144, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 145, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 146, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 147, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 148, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 149, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 150, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 151, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 152, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 153, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 154, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 155, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 156, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 157, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 158, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 159, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 160, CAST(230.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 161, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 162, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 163, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 164, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 165, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 166, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 167, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 168, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 169, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 170, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 171, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 172, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 173, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 174, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 175, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 176, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 177, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 178, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 179, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 180, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 181, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 182, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 183, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 184, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 185, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 186, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 187, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 188, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 189, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 190, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 191, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 192, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 193, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 194, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 195, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 196, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 197, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 198, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 199, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 200, CAST(26.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 201, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 202, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 203, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 204, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 205, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 206, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 207, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 208, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 209, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 210, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 211, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 212, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 213, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 214, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 215, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 216, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 217, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 218, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 219, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 220, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 221, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 222, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 223, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 224, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 225, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 226, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 227, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 228, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 229, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 230, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 231, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 232, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 233, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 234, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 235, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 236, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 237, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 238, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 239, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 240, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 241, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 242, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 243, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 244, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 245, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 246, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 247, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 248, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 249, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 250, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 251, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 252, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 253, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 254, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 255, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 256, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 257, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 258, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 259, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 260, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 261, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 262, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 263, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 264, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 265, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 266, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 267, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 268, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 269, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 270, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 271, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 272, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 273, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 274, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 275, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 276, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 277, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 278, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 279, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 280, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 281, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 282, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 283, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 284, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 285, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 286, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 287, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 288, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 289, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 290, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 291, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 292, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 293, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 294, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 295, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 296, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 297, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 298, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 299, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 300, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 301, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 302, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 303, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 304, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 305, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 306, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 307, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 308, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 309, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 310, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 311, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 312, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 313, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 314, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 315, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 316, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 317, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 318, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 319, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 320, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 321, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 322, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 323, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 324, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 325, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 326, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 327, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 328, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 329, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 330, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 331, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 332, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 333, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 334, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 335, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 336, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 337, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 338, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 339, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 340, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 341, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 342, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 343, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 344, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 345, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 346, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 347, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 348, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 349, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 350, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 351, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 352, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 353, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 354, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 355, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 356, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 357, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 358, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 359, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 360, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 361, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 362, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 363, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 364, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 365, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 366, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 367, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 368, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 369, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 370, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 371, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 372, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 373, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 374, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 375, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 376, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 377, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 378, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 379, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 380, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 381, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 382, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 383, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 384, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 385, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 386, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 387, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 388, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 389, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 390, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 391, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 392, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 393, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 394, CAST(228.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 395, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 396, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 397, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 398, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 399, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 400, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 401, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 402, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 403, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 404, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 405, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 406, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 407, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 408, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 409, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 410, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 411, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 412, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 413, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 414, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 415, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 416, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 417, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 418, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 419, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 420, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 421, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 422, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, 423, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 1, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 2, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 3, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 4, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 5, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 6, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 7, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 8, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 58, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 59, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 60, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 61, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 62, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 63, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 64, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 65, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 66, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 67, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 68, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 69, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 70, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 71, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 72, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 73, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 74, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 75, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 76, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 77, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 78, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 79, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 80, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 81, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 82, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 83, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 84, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 85, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 86, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 87, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 88, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 89, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 90, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 91, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 92, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 93, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 94, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 95, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 96, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 97, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 98, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 99, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 100, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 101, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 102, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 103, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 104, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 105, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 106, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 107, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 108, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 109, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 110, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 111, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 112, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 113, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 114, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 115, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 116, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 117, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 118, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 119, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 120, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 121, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 122, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 123, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 124, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 125, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 126, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 127, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 128, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 129, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 130, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 131, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 132, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 133, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 134, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 135, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 136, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 137, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 138, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 139, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 140, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 141, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 142, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 143, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 144, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 145, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 146, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 147, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 148, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 149, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 150, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 151, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 152, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 153, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 154, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 155, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 156, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 157, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 158, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 159, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 160, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 161, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 162, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 163, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 164, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 165, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 166, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 167, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 168, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 169, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 170, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 171, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 172, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 173, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 174, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 175, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 176, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 177, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 178, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 179, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 180, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 181, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 182, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 183, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 184, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 185, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 186, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 187, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 188, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 189, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 190, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 191, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 192, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 193, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 194, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 195, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 196, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 197, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 198, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 199, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 200, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 201, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 202, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 203, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 204, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 205, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 206, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 207, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 208, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 209, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 210, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 211, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 212, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 213, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 214, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 215, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 216, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 217, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 218, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 219, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 220, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 221, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 222, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 223, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 224, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 225, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 226, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 227, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 228, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 229, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 230, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 231, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 232, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 233, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 234, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 235, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 236, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 237, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 238, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 239, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 240, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 241, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 242, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 243, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 244, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 245, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 246, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 247, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 248, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 249, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 250, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 251, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 252, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 253, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 254, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 255, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 256, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 257, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 258, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 259, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 260, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 261, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 262, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 263, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 264, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 265, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 266, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 267, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 268, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 269, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 270, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 271, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 272, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 273, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 274, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 275, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 276, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 277, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 278, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 279, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 280, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 281, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 282, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 283, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 284, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 285, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 286, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 287, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 288, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 289, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 290, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 291, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 292, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 293, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 294, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 295, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 296, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 297, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 298, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 299, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 300, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 301, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 302, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 303, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 304, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 305, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 306, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 307, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 308, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 309, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 310, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 311, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 312, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 313, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 314, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 315, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 316, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 317, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 318, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 319, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 320, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 321, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 322, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 323, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 324, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 325, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 326, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
GO
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 327, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 328, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 329, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 330, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 331, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 332, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 333, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 334, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 335, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 336, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 337, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 338, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 339, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 340, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 341, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 342, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 343, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 344, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 345, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 346, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 347, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 348, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 349, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 350, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 351, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 352, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 353, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 354, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 355, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 356, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 357, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 358, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 359, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 360, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 361, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 362, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 363, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 364, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 365, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 366, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 367, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 368, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 369, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 370, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 371, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 372, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 373, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 374, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 375, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 376, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 377, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 378, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 379, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 380, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 381, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 382, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 383, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 384, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 385, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 386, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 387, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 388, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 389, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 390, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 391, CAST(2.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 392, CAST(33.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 393, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 394, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 395, CAST(23.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 396, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 397, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 398, CAST(234.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 399, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 400, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 401, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 402, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 403, CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 404, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 405, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 406, CAST(423.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 407, CAST(42.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 408, CAST(32.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 409, CAST(30.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 410, CAST(14.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 411, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 412, CAST(36.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 413, CAST(54.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 414, CAST(34.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 415, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 416, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 417, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 418, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 419, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 420, CAST(43.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 421, CAST(4.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 422, CAST(5.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Almacen].[Stock_Producto] ([id_sucursal], [id_producto], [stock], [cpm], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, 423, CAST(45.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 1, NULL, NULL, NULL, NULL)
INSERT [Compras].[ComprobanteCompra] ([id_compra], [serie], [numero], [fecha], [estado], [id_proveedor], [id_contacto_proveedor], [id_tipo_documento], [id_usuario], [id_sucursal], [id_tipo_pago], [id_moneda], [sub_total], [igv], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'00001', N'00000001', CAST(0x0000A551010D446B AS DateTime), 1, 1, 1, 1, 1, 1, 1, 1, CAST(280.51 AS Decimal(18, 2)), CAST(50.49 AS Decimal(18, 2)), CAST(331.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A551010D446B AS DateTime), NULL, NULL)
INSERT [Compras].[ComprobanteCompra] ([id_compra], [serie], [numero], [fecha], [estado], [id_proveedor], [id_contacto_proveedor], [id_tipo_documento], [id_usuario], [id_sucursal], [id_tipo_pago], [id_moneda], [sub_total], [igv], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'00002', N'00000002', CAST(0x0000A564013AFADB AS DateTime), 1, 1, 5, 3, 1, 1, 2, 1, CAST(21.19 AS Decimal(18, 2)), CAST(3.81 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A564013AFADB AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'PEDRO', N'LUJAN', N'12345678', NULL, N'123456', N'987789987', 1, 1, 1, CAST(0x0000A53700000000 AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'LUIS', N'SANCHEZ', N'11223344', NULL, N'656565', N'988854755', 1, 2, 1, CAST(0x0000A53700000000 AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'CARLOS', N'MARTINEZ', N'11223344', NULL, NULL, NULL, 1, 3, 1, CAST(0x0000A53C00000000 AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'TEST', N'', N'22123123', N'', N'', N'', 1, 2, 1, CAST(0x0000A5440183AA8A AS DateTime), 1, CAST(0x0000A5440188B8A6 AS DateTime))
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, N'OTHER TEST', N'', N'21111111', N'', N'', N'', 1, 1, 1, CAST(0x0000A54401842CAB AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, N'TESTER', N'', N'21343242', N'', N'', N'', 1, 7, 1, CAST(0x0000A5450006316F AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, N'JAIME LUJAN', N'', N'22221111', N'', N'', N'', 1, 2, 1, CAST(0x0000A54B01803FB8 AS DateTime), NULL, NULL)
INSERT [Compras].[Contacto_Proveedor] ([id_contacto_proveedor], [nombres], [apellidos], [dni], [correo], [telefono], [celular], [estado], [id_proveedor], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, N'test ', N'', N'33333333', N'a@test.com', N'666666666', N'333333', 1, 2, 1, CAST(0x0000A61F00F12F4E AS DateTime), 1, CAST(0x0000A61F00F13BCE AS DateTime))
INSERT [Compras].[Cuenta_Proveedor] ([id_cuenta_proveedor], [monto], [saldo], [acuenta], [fecha], [id_proveedor], [id_compra], [id_sucursal], [id_usuario], [estado]) VALUES (1, CAST(25.00 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A564013AFADB AS DateTime), 1, 2, 1, 1, N'DEBE')
INSERT [Compras].[Detalle_Compra] ([id_compra], [id_nota_ingreso], [id_producto], [descripcion], [cantidad], [precio], [importe]) VALUES (1, 1, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(3.00 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), CAST(75.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Compra] ([id_compra], [id_nota_ingreso], [id_producto], [descripcion], [cantidad], [precio], [importe]) VALUES (1, 1, 9, N'TUBOS PVC S-25 20"', CAST(2.00 AS Decimal(18, 2)), CAST(18.00 AS Decimal(18, 2)), CAST(36.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Compra] ([id_compra], [id_nota_ingreso], [id_producto], [descripcion], [cantidad], [precio], [importe]) VALUES (1, 3, 60, N'ESCALERAS DE SEGURIDAD 3MS', CAST(2.00 AS Decimal(18, 2)), CAST(110.00 AS Decimal(18, 2)), CAST(220.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Compra] ([id_compra], [id_nota_ingreso], [id_producto], [descripcion], [cantidad], [precio], [importe]) VALUES (2, 4, 14, N'JGO LLAVES TODA MEDIADA STANLEY', CAST(1.00 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)), CAST(25.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (2, 5, CAST(1.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 24"', CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (2, 15, CAST(2.00 AS Decimal(18, 2)), N'ALCANTARILLAS  METALICA  E=2.00 MM   60"', CAST(22.00 AS Decimal(18, 2)), CAST(44.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (3, 1, CAST(3.00 AS Decimal(18, 2)), N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(20.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (4, 59, CAST(1.00 AS Decimal(18, 2)), N'COCHES DE CARGA 250 KG', CAST(24.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (5, 14, CAST(2.00 AS Decimal(18, 2)), N'JGO LLAVES TODA MEDIADA STANLEY', CAST(20.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (5, 50, CAST(1.00 AS Decimal(18, 2)), N'ROLLO DE CABLE THW # 14', CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (6, 74, CAST(2.00 AS Decimal(18, 2)), N'BROCAS CONICAS Nº 38', CAST(15.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (6, 32, CAST(1.00 AS Decimal(18, 2)), N'PISTOLA P/PINTAR SAGOLA PROFESIONAL', CAST(40.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (7, 14, CAST(3.00 AS Decimal(18, 2)), N'JGO LLAVES TODA MEDIADA STANLEY', CAST(20.00 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (8, 5, CAST(4.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 24"', CAST(20.00 AS Decimal(18, 2)), CAST(80.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (9, 60, CAST(2.00 AS Decimal(18, 2)), N'ESCALERAS DE SEGURIDAD 3MS', CAST(20.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (10, 14, CAST(1.00 AS Decimal(18, 2)), N'JGO LLAVES TODA MEDIADA STANLEY', CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (11, 9, CAST(1.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 20"', CAST(20.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (11, 2, CAST(2.00 AS Decimal(18, 2)), N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(20.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (12, 5, CAST(2.00 AS Decimal(18, 2)), N'TUBOS PVC S-25 24"', CAST(20.00 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)))
INSERT [Compras].[Detalle_Orden_Compra] ([id_orden_compra], [id_producto], [cantidad], [descripcion], [precio], [importe]) VALUES (12, 7, CAST(5.00 AS Decimal(18, 2)), N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(20.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'0000000001', CAST(0x0000A53700000000 AS DateTime), CAST(0xB13A0B00 AS Date), 1, 1, 1, 1, 1, CAST(20.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), NULL, N'Anulado', 1, CAST(0x0000A53700000000 AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'0000000002', CAST(0x0000A5380159000F AS DateTime), CAST(0x973A0B00 AS Date), 2, 2, 2, 1, 1, CAST(54.24 AS Decimal(18, 2)), CAST(9.76 AS Decimal(18, 2)), CAST(64.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A5380159000F AS DateTime), 1, CAST(0x0000A53C011FD5CC AS DateTime))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'0000000003', CAST(0x0000A53A017E4606 AS DateTime), CAST(0xA43A0B00 AS Date), 1, 1, 3, 1, 1, CAST(50.85 AS Decimal(18, 2)), CAST(9.15 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), N'', N'Atendido', 1, CAST(0x0000A53A017E4606 AS DateTime), 1, CAST(0x0000A5490144C2B5 AS DateTime))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'0000000004', CAST(0x0000A53A017E8BC7 AS DateTime), CAST(0x9B3A0B00 AS Date), 2, 2, 3, 1, 1, CAST(20.34 AS Decimal(18, 2)), CAST(3.66 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A53A017E8BC7 AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, N'0000000005', CAST(0x0000A53C0120D03E AS DateTime), CAST(0x973A0B00 AS Date), 1, 1, 2, 1, 1, CAST(50.85 AS Decimal(18, 2)), CAST(9.15 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A53C0120D03E AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, N'0000000006', CAST(0x0000A53C01226733 AS DateTime), CAST(0x9C3A0B00 AS Date), 3, 3, 3, 1, 1, CAST(59.32 AS Decimal(18, 2)), CAST(10.68 AS Decimal(18, 2)), CAST(70.00 AS Decimal(18, 2)), N'', N'Atendido', 1, CAST(0x0000A53C01226733 AS DateTime), 1, CAST(0x0000A53C0122C0F2 AS DateTime))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, N'0000000007', CAST(0x0000A53C012FC559 AS DateTime), CAST(0xA43A0B00 AS Date), 3, 3, 1, 1, 1, CAST(50.85 AS Decimal(18, 2)), CAST(9.15 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A53C012FC559 AS DateTime), 1, CAST(0x0000A549014A7A30 AS DateTime))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, N'0000000008', CAST(0x0000A54C00190668 AS DateTime), CAST(0xA93A0B00 AS Date), 2, 7, 3, 1, 1, CAST(67.80 AS Decimal(18, 2)), CAST(12.20 AS Decimal(18, 2)), CAST(80.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A54C00190668 AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (9, N'0000000009', CAST(0x0000A54E000B1C9C AS DateTime), CAST(0xA93A0B00 AS Date), 7, 6, 1, 1, 1, CAST(33.90 AS Decimal(18, 2)), CAST(6.10 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), N'', N'Atendido', 1, CAST(0x0000A54E000B1C9C AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (10, N'0000000010', CAST(0x0000A54E0011EB18 AS DateTime), CAST(0xA93A0B00 AS Date), 2, 4, 2, 1, 1, CAST(16.95 AS Decimal(18, 2)), CAST(3.05 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), N'', N'Atendido', 1, CAST(0x0000A54E0011EB18 AS DateTime), NULL, NULL)
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (11, N'0000000011', CAST(0x0000A56401352970 AS DateTime), CAST(0xC23A0B00 AS Date), 1, 5, 1, 1, 1, CAST(50.85 AS Decimal(18, 2)), CAST(9.15 AS Decimal(18, 2)), CAST(60.00 AS Decimal(18, 2)), N'', N'Pendiente', 1, CAST(0x0000A56401352970 AS DateTime), 1, CAST(0x0000A56401354030 AS DateTime))
INSERT [Compras].[Orden_Compra] ([id_orden_compra], [numero], [fecha], [fecha_vencimiento], [id_proveedor], [id_contacto_proveedor], [id_moneda], [id_sucursal], [id_usuario], [sub_total], [igv], [total], [observacion], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (12, N'0000000012', CAST(0x0000A61F00F1B727 AS DateTime), CAST(0x7C3B0B00 AS Date), 2, 8, 1, 1, 1, CAST(118.64 AS Decimal(18, 2)), CAST(21.36 AS Decimal(18, 2)), CAST(140.00 AS Decimal(18, 2)), N'', N'Atendido', 1, CAST(0x0000A61F00F1B727 AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'SODIMAC', N'22222222222', N'TEST', N'test@gmail.com', N'123456', N'123456789', 1, 1, CAST(0x0000A53700000000 AS DateTime), 1, CAST(0x0000A53A016B0F0D AS DateTime))
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'MAESTRO', N'11111111111', N'TEST', N'test@test.com', N'654321', N'321321321', 1, 1, CAST(0x0000A53700000000 AS DateTime), 1, CAST(0x0000A53A017DFF03 AS DateTime))
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'PROMART', N'33333333333', N'', N'', N'', N'', 1, 1, CAST(0x0000A53A016E3A8A AS DateTime), 1, CAST(0x0000A53C0121B594 AS DateTime))
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'TEST TEST', N'43434343', N'', N'', N'', N'', 1, 1, CAST(0x0000A53A017D71A6 AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, N'TEST 2', N'54354354354', N'', N'test@hotmail.com', N'', N'', 1, 1, CAST(0x0000A53A017DBA79 AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, N'TEST', N'12222222222', N'', N'', N'', N'', 1, 1, CAST(0x0000A53C014D1BEA AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, N'TECHO PROPIO', N'22222222211', N'', N'', N'', N'', 1, 1, CAST(0x0000A53C014D7732 AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, N'TEST PROVEEDOR', N'12121222121', N'', N'', N'', N'', 1, 1, CAST(0x0000A544017778EE AS DateTime), NULL, NULL)
INSERT [Compras].[Proveedor] ([id_proveedor], [razon_social], [dni_ruc], [direccion], [correo], [telefono], [celular], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (9, N'AAAAAAAA', N'88888888888', N'test2', N'test@hotmail.com', N'2222', N'33333', 2, 1, CAST(0x0000A61F00F0CB73 AS DateTime), 1, CAST(0x0000A61F00F0DAF1 AS DateTime))
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (1, N'ORDEN DE COMPRA', N'NI', 1)
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (2, N'ORDEN DE PRODUCCIÓN', N'NI', 1)
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (3, N'FACTURACIÓN', N'NS', 1)
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (4, N'DEVOLUCIÓN', N'T', 1)
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (5, N'FALTA DE STOCK', N'OP', 1)
INSERT [Comunes].[Motivo] ([id_motivo], [descripcion], [tipo], [estado]) VALUES (6, N'PEDIDO PENDIENTE', N'OP', 1)
INSERT [Comunes].[Numero_Documento] ([id_numeros], [serie_inicio], [numero_inicio], [serie_fin], [numero_fin], [id_tipo_documento], [id_sucursal]) VALUES (1, N'001', N'0000000001', N'001', N'0000000080', 1, 1)
INSERT [Comunes].[Numero_Documento] ([id_numeros], [serie_inicio], [numero_inicio], [serie_fin], [numero_fin], [id_tipo_documento], [id_sucursal]) VALUES (2, N'002', N'0000000100', NULL, NULL, 2, 1)
INSERT [Comunes].[Numero_Documento] ([id_numeros], [serie_inicio], [numero_inicio], [serie_fin], [numero_fin], [id_tipo_documento], [id_sucursal]) VALUES (3, N'003', N'0000000050', NULL, NULL, 3, 1)
INSERT [Comunes].[Numero_Documento] ([id_numeros], [serie_inicio], [numero_inicio], [serie_fin], [numero_fin], [id_tipo_documento], [id_sucursal]) VALUES (4, N'001', N'0000000005', NULL, NULL, 1, 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (1, N'NOTA PEDIDO', 1)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (2, N'BOLETA', 1)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (3, N'FACTURA', 1)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (4, N'test', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (5, N'fdsfdsfsd', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (6, N'hgfhgfhgf', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (7, N'ghgfhgf', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (8, N'hgjghjgh', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (9, N'ñl{lñ{lñ{ñl', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (10, N'hfghfghfg', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (11, N'yhtghfgh', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (12, N'gdx', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (13, N'tres', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (14, N'hghgfh', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (15, N'hgfhfgh', 2)
INSERT [Comunes].[Tipo_Documento] ([id_tipo_documento], [descripcion], [estado]) VALUES (16, N'yyyyyyyyyyyyyy', 2)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (1, N'CONTADO', 1)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (2, N'CRÉDITO', 1)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (3, N'TEWST', 2)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (4, N'AWAW', 2)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (5, N'FFD', 2)
INSERT [Comunes].[Tipo_Pago] ([id_tipo_pago], [descripcion], [estado]) VALUES (6, N'V', 2)
INSERT [dbo].[Evento] ([id_evento], [fecha_inicio], [fecha_fin], [nombre], [ubicacion], [descripcion], [id_usuario], [estado], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, CAST(0x0000A51F00000000 AS DateTime), CAST(0x0000A51F00000000 AS DateTime), N'TEST', N'TEST', N'TEST', 1, 1, 1, CAST(0x0000A51F00000000 AS DateTime), NULL, NULL)
INSERT [Logistica].[Moneda] ([id_moneda], [descripcion], [estado]) VALUES (1, N'SOLES', 1)
INSERT [Logistica].[Moneda] ([id_moneda], [descripcion], [estado]) VALUES (2, N'EURO', 1)
INSERT [Logistica].[Moneda] ([id_moneda], [descripcion], [estado]) VALUES (3, N'DOLAR', 1)
INSERT [Logistica].[Sucursal] ([id_sucursal], [descripcion], [direccion], [telefono], [estado]) VALUES (1, N'TRUJILLO', N'Av. José María Eguren 23', N'#956032410', 1)
INSERT [Logistica].[Sucursal] ([id_sucursal], [descripcion], [direccion], [telefono], [estado]) VALUES (2, N'CHICLAYO', N'Av. José María Eguren Sur 296', N'#956032410', 1)
INSERT [Logistica].[Sucursal] ([id_sucursal], [descripcion], [direccion], [telefono], [estado]) VALUES (3, N'CHIMBOTE', N'TEST', N'33231234', 1)
INSERT [Produccion].[Detalle_Horas_Trabajadas] ([id_orden_produccion], [id_personal], [fecha_hora_inicio], [fecha_hora_fin], [costo]) VALUES (1, 4, CAST(0x0000A56000A4CB80 AS DateTime), CAST(0x0000A56000E6B680 AS DateTime), CAST(62.00 AS Decimal(18, 2)))
INSERT [Produccion].[Detalle_Horas_Trabajadas] ([id_orden_produccion], [id_personal], [fecha_hora_inicio], [fecha_hora_fin], [costo]) VALUES (1, 3, CAST(0x0000A56000A4CB80 AS DateTime), CAST(0x0000A56000E6B680 AS DateTime), CAST(40.00 AS Decimal(18, 2)))
INSERT [Produccion].[Detalle_Horas_Trabajadas] ([id_orden_produccion], [id_personal], [fecha_hora_inicio], [fecha_hora_fin], [costo]) VALUES (2, 3, CAST(0x0000A56400D79B50 AS DateTime), CAST(0x0000A56401090B90 AS DateTime), CAST(30.00 AS Decimal(18, 2)))
INSERT [Produccion].[Detalle_Horas_Trabajadas] ([id_orden_produccion], [id_personal], [fecha_hora_inicio], [fecha_hora_fin], [costo]) VALUES (3, 4, CAST(0x0000A56400D79B50 AS DateTime), CAST(0x0000A564012A0110 AS DateTime), CAST(77.50 AS Decimal(18, 2)))
INSERT [Produccion].[Detalle_Horas_Trabajadas] ([id_orden_produccion], [id_personal], [fecha_hora_inicio], [fecha_hora_fin], [costo]) VALUES (4, 3, CAST(0x0000A564016A8C80 AS DateTime), CAST(0x0000A5650083D600 AS DateTime), CAST(100.00 AS Decimal(18, 2)))
INSERT [Produccion].[Orden_Produccion] ([id_orden_produccion], [numero], [fecha], [descripcion], [fecha_entrega], [id_motivo], [id_pedido], [id_producto], [descripcion_producto], [cantidad], [id_usuario], [id_sucursal], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'0000000001', CAST(0x0000A560002AE6E3 AS DateTime), N'test', CAST(0x0000A5600107AC00 AS DateTime), 5, 0, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(3.00 AS Decimal(18, 2)), 1, 1, 1, CAST(0x0000A560002AE6E3 AS DateTime), NULL, NULL)
INSERT [Produccion].[Orden_Produccion] ([id_orden_produccion], [numero], [fecha], [descripcion], [fecha_entrega], [id_motivo], [id_pedido], [id_producto], [descripcion_producto], [cantidad], [id_usuario], [id_sucursal], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'0000000002', CAST(0x0000A56400D7D46C AS DateTime), N'test', CAST(0x0000A5670107AC00 AS DateTime), 5, 0, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(5.00 AS Decimal(18, 2)), 1, 1, 1, CAST(0x0000A56400D7D46C AS DateTime), NULL, NULL)
INSERT [Produccion].[Orden_Produccion] ([id_orden_produccion], [numero], [fecha], [descripcion], [fecha_entrega], [id_motivo], [id_pedido], [id_producto], [descripcion_producto], [cantidad], [id_usuario], [id_sucursal], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'0000000003', CAST(0x0000A56400D88D40 AS DateTime), N'prueba con pedido', CAST(0x0000A56A0107AC00 AS DateTime), 6, 36, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(5.00 AS Decimal(18, 2)), 1, 1, 1, CAST(0x0000A56400D88D40 AS DateTime), NULL, NULL)
INSERT [Produccion].[Orden_Produccion] ([id_orden_produccion], [numero], [fecha], [descripcion], [fecha_entrega], [id_motivo], [id_pedido], [id_producto], [descripcion_producto], [cantidad], [id_usuario], [id_sucursal], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'0000000004', CAST(0x0000A564016AEEF5 AS DateTime), N'prueba', CAST(0x0000A567016A8C80 AS DateTime), 6, 43, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(4.00 AS Decimal(18, 2)), 1, 1, 1, CAST(0x0000A564016AEEF5 AS DateTime), NULL, NULL)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (1, CAST(0x0000A441017DE5DE AS DateTime), 545.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (2, CAST(0x0000A441017E2B0D AS DateTime), 400.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (3, CAST(0x0000A45D017E6CBD AS DateTime), 344.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (4, CAST(0x0000A443000C878A AS DateTime), 100.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (5, CAST(0x0000A443000E68DC AS DateTime), 50.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (6, CAST(0x0000A443000F869A AS DateTime), 100.0000, N'DEUDA     ', 1)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (7, CAST(0x0000A4430014BB14 AS DateTime), 500.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (8, CAST(0x0000A4430015939E AS DateTime), 300.0000, N'DEUDA     ', 1)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (9, CAST(0x0000A46F01841265 AS DateTime), 500.0000, N'DEUDA     ', 1)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (10, CAST(0x0000A46F01841865 AS DateTime), 300.0000, N'DEUDA     ', 1)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (11, CAST(0x0000A46F0184359C AS DateTime), 200.0000, N'DEUDA     ', 1)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (12, CAST(0x0000A46F01847532 AS DateTime), 1499.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Adelanto] ([id_adelanto], [fecha], [monto], [estado], [id_personal]) VALUES (13, CAST(0x0000A46F01880FA1 AS DateTime), 1.0000, N'DEUDA     ', 2)
INSERT [RRHH].[Personal] ([id_personal], [nombres], [apellido_paterno], [apellido_materno], [dni], [fecha_nac], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_sucursal], [id_tipo_personal], [sueldo_total], [sueldo_hora], [imagen], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'Alexis', N'Garcia', N'Montoya', 70465434, CAST(0x0D190B00 AS Date), N'M', N'Trujillo', N'', N'', N'962910520', 1, 1, 1, CAST(1000.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A46F00000000 AS DateTime), 1, CAST(0x0000A48C000B6055 AS DateTime))
INSERT [RRHH].[Personal] ([id_personal], [nombres], [apellido_paterno], [apellido_materno], [dni], [fecha_nac], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_sucursal], [id_tipo_personal], [sueldo_total], [sueldo_hora], [imagen], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'Juan', N'Perez', N'Perez', 12345678, CAST(0x56190B00 AS Date), N'M', N'aaa', N'', N'', N'', 1, 1, 1, CAST(1500.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A46F00000000 AS DateTime), 1, CAST(0x0000A48C0019A0CC AS DateTime))
INSERT [RRHH].[Personal] ([id_personal], [nombres], [apellido_paterno], [apellido_materno], [dni], [fecha_nac], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_sucursal], [id_tipo_personal], [sueldo_total], [sueldo_hora], [imagen], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'Brayan', N'Rios', N'Briceño', 22222222, CAST(0xCD250B00 AS Date), N'M', N'hurares', N'', N'', N'', 1, 1, 2, CAST(1000.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A46F013B55D5 AS DateTime), 1, CAST(0x0000A48C000B8605 AS DateTime))
INSERT [RRHH].[Personal] ([id_personal], [nombres], [apellido_paterno], [apellido_materno], [dni], [fecha_nac], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_sucursal], [id_tipo_personal], [sueldo_total], [sueldo_hora], [imagen], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'lucinda', N'briceño', N'alva', 33333333, CAST(0xC8FC0A00 AS Date), N'F', N'husares de junin', N'', N'', N'', 1, 2, 3, CAST(1500.00 AS Decimal(18, 2)), CAST(15.50 AS Decimal(18, 2)), N'', 1, CAST(0x0000A46F013DB494 AS DateTime), 1, CAST(0x0000A48C000BBBB0 AS DateTime))
INSERT [RRHH].[Personal] ([id_personal], [nombres], [apellido_paterno], [apellido_materno], [dni], [fecha_nac], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_sucursal], [id_tipo_personal], [sueldo_total], [sueldo_hora], [imagen], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, N'Carla', N'valverde', N'valverde', 44444444, CAST(0x56190B00 AS Date), N'M', N'la libertad', N'', N'', N'', 1, 1, 4, CAST(2000.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'', 1, CAST(0x0000A46F01561EED AS DateTime), 1, CAST(0x0000A48C000BA576 AS DateTime))
INSERT [RRHH].[Tipo_Personal] ([id_tipo_personal], [descripcion], [estado]) VALUES (1, N'GERENTE', 1)
INSERT [RRHH].[Tipo_Personal] ([id_tipo_personal], [descripcion], [estado]) VALUES (2, N'ADMINISTRADOR', 1)
INSERT [RRHH].[Tipo_Personal] ([id_tipo_personal], [descripcion], [estado]) VALUES (3, N'SUPERVISOR', 1)
INSERT [RRHH].[Tipo_Personal] ([id_tipo_personal], [descripcion], [estado]) VALUES (4, N'VENDEDOR', 1)
INSERT [Seguridad].[Usuario] ([id_usuario], [usuario], [password], [id_personal], [estado]) VALUES (1, N'a', N'a', 1, 1)
INSERT [Seguridad].[Usuario] ([id_usuario], [usuario], [password], [id_personal], [estado]) VALUES (2, N'b', N'b', 2, 0)
INSERT [Seguridad].[Usuario] ([id_usuario], [usuario], [password], [id_personal], [estado]) VALUES (3, N'c', N'c', 3, 1)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (1, N'Alan Breidyn', N'', N'22222222222', N'M', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A4280180F792 AS DateTime), NULL, NULL, 0, N'alan', N'123')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (2, N'Juan PEREZ', N'', N'33333333333', N' ', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A42E00F7EC11 AS DateTime), 1, CAST(0x0000A521017DA4FF AS DateTime), 1, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (3, N'ECONOMAXAE SAC', N'', N'11111111', N'M', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A42F00B44E95 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (4, N'PEDRO CARRANZA', N'', N'88888888', N'M', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A431014811DB AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (5, N'UPN SAC', N'', N'55555555555', N'M', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A4310148D329 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (6, N'int sac', N'', N'66666666666', N'M', N'', N'', N'', N'', 1, 1, 2, CAST(0x0000A4310148FC6E AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (7, N'INKAFARMA', N'', N'33232333333', N' ', N'', N'tesras@test.sdd', N'', N'', 1, 1, 1, CAST(0x0000A431014BF4AA AS DateTime), 1, CAST(0x0000A53A016AE219 AS DateTime), 1, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (8, N'INKOMEX', N'', N'55555554545', N'M', N'', N'', N'', N'', 1, 1, 2, CAST(0x0000A431014C35B4 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (9, N'DELTRON SAC', N'', N'43434343434', N'M', N'', N'', N'', N'', 1, 1, 2, CAST(0x0000A431014C50AC AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (10, N'LUIS SANCHEZ FERRER', N'', N'12345678', N'M', N'', N'', N'', N'', 1, 2, 2, CAST(0x0000A431014C7E9D AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (11, N'PABLO MARMOL LUJAN', N'', N'23333333333', N'M', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A4390119B5B8 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (12, N'NEIL LLIQUE MESIA', N'', N'22333333333', N'M', N'', N'', N'', N'', 2, 1, 1, CAST(0x0000A439011D72E6 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (13, N'EVELYN FUENTES RAMIREZ', N'', N'21222222222', N'M', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A439011F845B AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (14, N'ANTHONY BRICEÑO', N'', N'12312312', N'M', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A43901200BBF AS DateTime), 1, CAST(0x0000A4390120F368 AS DateTime), 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (15, N'LUCINDA EMILIA BRICEÑO', N'', N'32333333333', N'M', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A4390127328A AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (16, N'THALIA PAREDES', N'', N'22777777777', N'M', N'', N'', N'', N'', 2, 1, 1, CAST(0x0000A4390146E38B AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (17, N'MARIA JODAS', N'', N'23232323', N'M', N'', N'', N'', N'', 2, 2, 1, CAST(0x0000A4390146E902 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (18, N'BRAYAN RIOS', N'', N'21323234', N'M', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A43B00F19818 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (19, N'CARLA VALVERDE', N'', N'43434343', N'M', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A441017CB488 AS DateTime), NULL, NULL, 0, NULL, NULL)
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (20, N'test 1', N'', N'43432432', N' ', N'', N'', N'', N'', 2, 2, 1, CAST(0x0000A51F004E16A6 AS DateTime), 1, CAST(0x0000A52B00165CB0 AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (21, N'SAN JORGE', N'', N'21212324', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A51F004E55EF AS DateTime), 1, CAST(0x0000A5200178D060 AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (22, N'upn trujillo', N'', N'22222333333', N' ', N'san isidro #232', N'upn@gmail.com', N'044-25235', N'998860123', 1, 1, 1, CAST(0x0000A51F004EA931 AS DateTime), 1, CAST(0x0000A52001799497 AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (23, N'cibertec', N'', N'43534544', N' ', N'', N'cibertec@gmail.com', N'044-282555', N'', 1, 2, 1, CAST(0x0000A52000EAED20 AS DateTime), 1, CAST(0x0000A52001786EB5 AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (24, N'cidunt', N'', N'65654645645', N' ', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A52000EEC4DC AS DateTime), 1, CAST(0x0000A52001796FFA AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (25, N'fsdefsdfsd', N'', N'32432432432', N' ', N'fsdfdsfdsfdsfs', N'dsdsds@fsdfds.fdsf', N'32432432432', N'32432432432', 2, 1, 1, CAST(0x0000A5260030CA28 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (26, N'test 2', N'', N'43232432', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A52600411D52 AS DateTime), 1, CAST(0x0000A52B0016EAB0 AS DateTime), 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (27, N'test 3', N'', N'23432432', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A52B0016FC48 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (28, N'test 4', N'', N'23123213213', N' ', N'', N'', N'', N'', 1, 1, 1, CAST(0x0000A52B00190429 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (29, N'test 5', N'', N'34324324', N' ', N'', N'', N'', N'', 2, 2, 1, CAST(0x0000A52B00191009 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (30, N'test 6', N'', N'43243242', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A52B0019223D AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (31, N'test 7', N'', N'54354353453', N' ', N'', N'', N'', N'', 2, 1, 1, CAST(0x0000A52B001A2657 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (32, N'NALA', N'', N'12121212', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A52E00FB6427 AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (33, N'GORDILLO', N'', N'21212121', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A52E00FB8ABB AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[Cliente] ([id_cliente], [nombres], [apellidos], [dni_ruc], [sexo], [direccion], [correo], [telefono], [celular], [estado], [id_tipo_cliente], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico], [registro_online], [usuario], [password]) VALUES (34, N'5464', N'', N'56546546', N' ', N'', N'', N'', N'', 1, 2, 1, CAST(0x0000A53A010AB16A AS DateTime), NULL, NULL, 1, N'', N'')
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, N'002  ', N'00000001', CAST(0x0000A53100097EFB AS DateTime), 1, 32, 2, 1, 1, 13, 1, CAST(24.67 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53100097EFB AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, N'001  ', N'00000000', CAST(0x0000A531000991B9 AS DateTime), 1, 2, 1, 1, 1, 14, 2, CAST(30.00 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A531000991B9 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, N'001  ', N'00000000', CAST(0x0000A53100182E1E AS DateTime), 1, 1, 1, 1, 1, 12, 2, CAST(15.00 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53100182E1E AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, N'002  ', N'00000001', CAST(0x0000A531016C9F82 AS DateTime), 1, 1, 2, 1, 1, 15, 2, CAST(42.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A531016C9F82 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, N'002  ', N'00000002', CAST(0x0000A53800D0DA95 AS DateTime), 1, 1, 2, 1, 1, 23, 2, CAST(22.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53800D0DA95 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, N'001  ', N'00000001', CAST(0x0000A53A00F85789 AS DateTime), 1, 1, 1, 1, 1, 25, 1, CAST(15.00 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53A00F85789 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, N'002  ', N'00000003', CAST(0x0000A53A010D1111 AS DateTime), 1, 32, 2, 1, 1, 27, 1, CAST(57.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53A010D1111 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, N'002  ', N'00000004', CAST(0x0000A53A01135393 AS DateTime), 1, 3, 2, 1, 1, 26, 2, CAST(51.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53A01135393 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (9, N'002  ', N'00000005', CAST(0x0000A53C010D2BC0 AS DateTime), 1, 8, 2, 1, 1, 29, 2, CAST(32.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A53C010D2BC0 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (10, N'002  ', N'00000006', CAST(0x0000A5490141F2EA AS DateTime), 1, 1, 2, 1, 1, 31, 1, CAST(418.87 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A5490141F2EA AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (11, N'002  ', N'00000007', CAST(0x0000A54B016A512D AS DateTime), 1, 1, 2, 1, 1, 33, 1, CAST(27.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A54B016A512D AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (12, N'002  ', N'00000008', CAST(0x0000A54B016A60F5 AS DateTime), 1, 1, 2, 1, 1, 34, 1, CAST(27.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A54B016A60F5 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (13, N'002  ', N'00000009', CAST(0x0000A55F0161D1A6 AS DateTime), 1, 10, 2, 1, 1, 37, 1, CAST(44.34 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A55F0161D1A6 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (14, N'002  ', N'00000010', CAST(0x0000A55F016D4504 AS DateTime), 1, 2, 2, 1, 1, 35, 1, CAST(76.84 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A55F016D4504 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (15, N'003  ', N'00000000', CAST(0x0000A56400B36386 AS DateTime), 1, 1, 3, 1, 1, 38, 1, CAST(32.17 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A56400B36386 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (16, N'002  ', N'00000011', CAST(0x0000A56400B3AB0A AS DateTime), 1, 10, 2, 1, 1, 40, 1, CAST(64.34 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A56400B3AB0A AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (17, N'002  ', N'00000012', CAST(0x0000A56400B45819 AS DateTime), 1, 10, 2, 1, 1, 41, 1, CAST(49.67 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A56400B45819 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (18, N'003  ', N'00000001', CAST(0x0000A56400B55656 AS DateTime), 1, 2, 3, 1, 1, 42, 2, CAST(39.67 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A56400B55656 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (19, N'003  ', N'00000002', CAST(0x0000A56401311C91 AS DateTime), 1, 1, 3, 1, 1, 39, 1, CAST(44.34 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A56401311C91 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (20, N'003  ', N'00000003', CAST(0x0000A5640133B9F4 AS DateTime), 1, 1, 3, 1, 1, 36, 1, CAST(81.84 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A5640133B9F4 AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (21, N'002  ', N'00000013', CAST(0x0000A5640133E07C AS DateTime), 1, 10, 2, 1, 1, 44, 1, CAST(99.34 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A5640133E07C AS DateTime), NULL, NULL)
INSERT [Ventas].[ComprobanteVenta] ([id_venta], [serie], [numero], [fecha], [estado], [id_cliente], [id_numeros], [id_usuario], [id_sucursal], [id_pedido], [id_tipo_pago], [total], [observacion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (22, N'002  ', N'00000014', CAST(0x0000A564013435CC AS DateTime), 1, 10, 2, 1, 1, 45, 2, CAST(49.67 AS Decimal(18, 2)), NULL, 1, CAST(0x0000A564013435CC AS DateTime), NULL, NULL)
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (1, 30.0000, 0.0000, 15.0000, CAST(0x0000A531000991BD AS DateTime), 2, 2, 1, 1, N'PAGÓ      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (2, 15.0000, 0.0000, 15.0000, CAST(0x0000A53100182E1F AS DateTime), 1, 3, 1, 1, N'PAGÓ      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (3, 42.1700, 0.0000, 27.1700, CAST(0x0000A531016C9F83 AS DateTime), 1, 4, 1, 1, N'PAGÓ      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (4, 22.1700, 0.0000, 22.1700, CAST(0x0000A53800D0DAA5 AS DateTime), 1, 5, 1, 1, N'PAGÓ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (5, 51.1700, 51.1700, 0.0000, CAST(0x0000A53A011353A6 AS DateTime), 3, 8, 1, 1, N'DEBE      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (6, 32.1700, 32.1700, 0.0000, CAST(0x0000A53C010D2BD8 AS DateTime), 8, 9, 1, 1, N'DEBE      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (7, 39.6700, 39.6700, 0.0000, CAST(0x0000A56400B55657 AS DateTime), 2, 18, 1, 1, N'DEBE      ')
INSERT [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente], [monto], [saldo], [acuenta], [fecha], [id_cliente], [id_venta], [id_sucursal], [id_usuario], [estado]) VALUES (8, 49.6700, 19.6700, 30.0000, CAST(0x0000A564013435CD AS DateTime), 10, 22, 1, 1, N'DEBE      ')
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (2, CAST(0x0000A5320012FB7F AS DateTime), 15.0000, 0.0000)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (3, CAST(0x0000A5320012FB9E AS DateTime), 15.0000, 27.1700)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (1, CAST(0x0000A53800CD7CA7 AS DateTime), 15.0000, 15.0000)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (8, CAST(0x0000A56401344B46 AS DateTime), 30.0000, 19.6700)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (1, CAST(0x0000A56401349EFB AS DateTime), 15.0000, 0.0000)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (3, CAST(0x0000A5640134B220 AS DateTime), 27.1700, 0.0000)
INSERT [Ventas].[Detalle_Cuenta_Cliente] ([id_cuenta_cliente], [fecha], [pago], [debe]) VALUES (4, CAST(0x0000A61F00ED782A AS DateTime), 22.1700, 0.0000)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (1, 4, N'TUBOS PVC 5-25 24''', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (2, 4, N'TUBOS PVC 5-25 24''', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (2, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72''', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (2, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (2, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(1.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (3, 5, N'TUBOS PVC S-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (3, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (3, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (4, 5, N'TUBOS PVC S-25 24''', CAST(1.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (4, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72''', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (4, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (5, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (5, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (5, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (6, 8, N'TUBOS PVC 5-25 20"', CAST(2.00 AS Decimal(18, 2)), CAST(29.67 AS Decimal(18, 2)), CAST(59.34 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (7, 4, N'TUBOS PVC 5-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 4)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (8, 9, N'TUBOS PVC S-25 20"', CAST(1.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 3)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (8, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 3)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (9, 4, N'TUBOS PVC 5-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), 3)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (10, 3, N'CJA JGO DADOS LLAVES BOSH', CAST(1.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), 2)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (11, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(1.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), 1)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (12, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 3)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (13, 6, N'ESMERIL ( MOLADOR) BOSCH 1600 C PROFECIONAL', CAST(1.00 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), 1)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (14, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(2.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), 2)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (15, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 4)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (15, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 4)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (16, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (17, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(2.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (18, 4, N'TUBOS PVC 5-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (23, 5, N'TUBOS PVC S-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), 5)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (24, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (24, 16, N'CIL DE ASFALTO LIQUIDO RC 250', CAST(1.00 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (25, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), 6)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (26, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 8)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (26, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(2.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), 8)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (27, 59, N'COCHES DE CARGA 250 KG', CAST(1.00 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), 7)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (30, 15, N'ALCANTARILLAS  METALICA  E=2.00 MM   60"', CAST(3.00 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), CAST(141.51 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (31, 5, N'TUBOS PVC S-25 24"', CAST(4.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(88.68 AS Decimal(18, 2)), 10)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (31, 15, N'ALCANTARILLAS  METALICA  E=2.00 MM   60"', CAST(7.00 AS Decimal(18, 2)), CAST(47.17 AS Decimal(18, 2)), CAST(330.19 AS Decimal(18, 2)), 10)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (32, 9, N'TUBOS PVC S-25 20"', CAST(1.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (32, 49, N'ARNES DE SEGURIDAD 3M', CAST(2.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(64.34 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (33, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 11)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (34, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 12)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (36, 12, N'TROMPO MEZCLADOR CON MOTOR 1.14HP', CAST(1.00 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 20)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (36, 13, N'DEWALT TALADRO DE ROTACIÓN 5/8" 710W', CAST(1.00 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), 20)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (38, 9, N'TUBOS PVC S-25 20"', CAST(1.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 15)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (39, 5, N'TUBOS PVC S-25 24"', CAST(2.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(44.34 AS Decimal(18, 2)), 19)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (41, 16, N'CIL DE ASFALTO LIQUIDO RC 250', CAST(1.00 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 17)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (42, 12, N'TROMPO MEZCLADOR CON MOTOR 1.14HP', CAST(1.00 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), 18)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (19, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(1.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (20, 3, N'CJA JGO DADOS LLAVES BOSH', CAST(2.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), CAST(34.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (20, 3, N'CJA JGO DADOS LLAVES BOSH', CAST(2.00 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), CAST(34.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (20, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(1.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (21, 4, N'TUBOS PVC 5-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (21, 4, N'TUBOS PVC 5-25 24"', CAST(1.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (21, 1, N'COMPRENSORA NEUMATICA A TORNILLO -MODELO:850 CFM MOTOR: 6V71-DETROIT', CAST(2.00 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), CAST(24.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (22, 10, N'CAPUCHAS DE LONA PARA ARENADO Y ACC COMPLETOS', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (22, 2, N'MAKER TROMPO 9P3 MOTOR 9HP HONDA', CAST(2.00 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (22, 25, N'TUBOS PVC 5-25 10"', CAST(1.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (37, 5, N'TUBOS PVC S-25 24"', CAST(2.00 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), CAST(44.34 AS Decimal(18, 2)), 13)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (40, 9, N'TUBOS PVC S-25 20"', CAST(2.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(64.34 AS Decimal(18, 2)), 16)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (28, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(2.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(54.34 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (29, 9, N'TUBOS PVC S-25 20"', CAST(1.00 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), 9)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (35, 7, N'ALCANTARILLAS  METALICA  E=2.00 MM   72"', CAST(1.00 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), 14)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (35, 16, N'CIL DE ASFALTO LIQUIDO RC 250', CAST(1.00 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 14)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (43, 50, N'ROLLO DE CABLE THW # 14', CAST(1.00 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), NULL)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (44, 16, N'CIL DE ASFALTO LIQUIDO RC 250', CAST(2.00 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), CAST(99.34 AS Decimal(18, 2)), 21)
INSERT [Ventas].[Detalle_Pedido] ([id_pedido], [id_producto], [descripcion], [cantidad], [precio], [importe], [id_venta]) VALUES (45, 16, N'CIL DE ASFALTO LIQUIDO RC 250', CAST(1.00 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), 22)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (1, CAST(0x0000A52B00704498 AS DateTime), N'0000000001', CAST(16.67 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A52B00704498 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (2, CAST(0x0000A52B00709587 AS DateTime), N'0000000002', CAST(79.25 AS Decimal(18, 2)), CAST(14.26 AS Decimal(18, 2)), CAST(93.51 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A52B00709587 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (3, CAST(0x0000A52B0071EF18 AS DateTime), N'0000000003', CAST(71.19 AS Decimal(18, 2)), CAST(12.82 AS Decimal(18, 2)), CAST(84.01 AS Decimal(18, 2)), N'Pendiente', 2, 1, 1, 1, N'', 0, 1, CAST(0x0000A52B0071EF18 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (4, CAST(0x0000A52B00725E29 AS DateTime), N'0000000004', CAST(71.19 AS Decimal(18, 2)), CAST(12.82 AS Decimal(18, 2)), CAST(84.01 AS Decimal(18, 2)), N'Pendiente', 2, 1, 1, 1, N'', 0, 1, CAST(0x0000A52B00725E29 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (5, CAST(0x0000A52D012F1038 AS DateTime), N'0000000005', CAST(29.38 AS Decimal(18, 2)), CAST(5.29 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A52D012F1038 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (6, CAST(0x0000A52D012F1EB9 AS DateTime), N'0000000006', CAST(50.29 AS Decimal(18, 2)), CAST(9.05 AS Decimal(18, 2)), CAST(59.34 AS Decimal(18, 2)), N'Pendiente', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A52D012F1EB9 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (7, CAST(0x0000A52E00F666CD AS DateTime), N'0000000007', CAST(16.67 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A52E00F666CD AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (8, CAST(0x0000A52E0122D828 AS DateTime), N'0000000008', CAST(50.29 AS Decimal(18, 2)), CAST(9.05 AS Decimal(18, 2)), CAST(59.34 AS Decimal(18, 2)), N'Pendiente', 14, 2, 1, 1, N'', 0, 1, CAST(0x0000A52E0122D828 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (9, CAST(0x0000A52E013380BE AS DateTime), N'0000000009', CAST(16.67 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), N'Registrado', 33, 2, 1, 1, N'', 0, 1, CAST(0x0000A52E013380BE AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (10, CAST(0x0000A52E01339A17 AS DateTime), N'0000000010', CAST(14.41 AS Decimal(18, 2)), CAST(2.59 AS Decimal(18, 2)), CAST(17.00 AS Decimal(18, 2)), N'Registrado', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A52E01339A17 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (11, CAST(0x0000A52E0133EB3F AS DateTime), N'0000000011', CAST(10.17 AS Decimal(18, 2)), CAST(1.83 AS Decimal(18, 2)), CAST(12.00 AS Decimal(18, 2)), N'Registrado', 2, 1, 1, 1, N'', 0, 1, CAST(0x0000A52E0133EB3F AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (12, CAST(0x0000A5310008ED11 AS DateTime), N'0000000012', CAST(12.71 AS Decimal(18, 2)), CAST(2.29 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), N'Registrado', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A5310008ED11 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (13, CAST(0x0000A5310009133B AS DateTime), N'0000000013', CAST(20.91 AS Decimal(18, 2)), CAST(3.76 AS Decimal(18, 2)), CAST(24.67 AS Decimal(18, 2)), N'Registrado', 32, 2, 1, 1, N'', 0, 1, CAST(0x0000A5310009133B AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (14, CAST(0x0000A531000926E6 AS DateTime), N'0000000014', CAST(25.42 AS Decimal(18, 2)), CAST(4.58 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)), N'Registrado', 2, 1, 1, 1, N'', 0, 1, CAST(0x0000A531000926E6 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (15, CAST(0x0000A53100094069 AS DateTime), N'0000000015', CAST(35.74 AS Decimal(18, 2)), CAST(6.43 AS Decimal(18, 2)), CAST(42.17 AS Decimal(18, 2)), N'Registrado', 33, 2, 1, 1, N'', 0, 1, CAST(0x0000A53100094069 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (16, CAST(0x0000A536013110FE AS DateTime), N'0000000016', CAST(12.71 AS Decimal(18, 2)), CAST(2.29 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), N'Pendiente', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A536013110FE AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (17, CAST(0x0000A53601319DA2 AS DateTime), N'0000000017', CAST(35.59 AS Decimal(18, 2)), CAST(6.41 AS Decimal(18, 2)), CAST(42.00 AS Decimal(18, 2)), N'Pendiente', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A53601319DA2 AS DateTime), 1, CAST(0x0000A53601364262 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (18, CAST(0x0000A5360138F5CE AS DateTime), N'0000000018', CAST(16.67 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), CAST(19.67 AS Decimal(18, 2)), N'Anulado', 32, 1, 1, 1, N'', 0, 1, CAST(0x0000A5360138F5CE AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (19, CAST(0x0000A536013B4254 AS DateTime), N'0000000019', CAST(42.09 AS Decimal(18, 2)), CAST(7.58 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), N'Anulado', 33, 1, 1, 1, N'', 0, 1, CAST(0x0000A536013B4254 AS DateTime), 1, CAST(0x0000A536013B5DD3 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (20, CAST(0x0000A536013BF29F AS DateTime), N'0000000020', CAST(38.98 AS Decimal(18, 2)), CAST(7.02 AS Decimal(18, 2)), CAST(46.00 AS Decimal(18, 2)), N'Anulado', 33, 2, 1, 1, N'', 0, 1, CAST(0x0000A536013BF29F AS DateTime), 1, CAST(0x0000A536013CA8A1 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (21, CAST(0x0000A536013D93A2 AS DateTime), N'0000000021', CAST(37.01 AS Decimal(18, 2)), CAST(6.66 AS Decimal(18, 2)), CAST(43.67 AS Decimal(18, 2)), N'Pendiente', 2, 1, 1, 1, N'', 0, 1, CAST(0x0000A536013D93A2 AS DateTime), 1, CAST(0x0000A536013DBC4E AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (22, CAST(0x0000A5360145ADE7 AS DateTime), N'0000000022', CAST(73.59 AS Decimal(18, 2)), CAST(13.25 AS Decimal(18, 2)), CAST(86.84 AS Decimal(18, 2)), N'Pendiente', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A5360145ADE7 AS DateTime), 1, CAST(0x0000A53601463C0A AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (23, CAST(0x0000A53800D07083 AS DateTime), N'0000000023', CAST(18.79 AS Decimal(18, 2)), CAST(3.38 AS Decimal(18, 2)), CAST(22.17 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A53800D07083 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (24, CAST(0x0000A53801567E95 AS DateTime), N'0000000024', CAST(65.12 AS Decimal(18, 2)), CAST(11.72 AS Decimal(18, 2)), CAST(76.84 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A53801567E95 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (25, CAST(0x0000A53A00F8407F AS DateTime), N'0000000025', CAST(12.71 AS Decimal(18, 2)), CAST(2.29 AS Decimal(18, 2)), CAST(15.00 AS Decimal(18, 2)), N'Registrado', 1, 1, 1, 1, N'', 0, 1, CAST(0x0000A53A00F8407F AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (26, CAST(0x0000A53A00FC43BD AS DateTime), N'0000000026', CAST(43.36 AS Decimal(18, 2)), CAST(7.81 AS Decimal(18, 2)), CAST(51.17 AS Decimal(18, 2)), N'Registrado', 3, 2, 1, 1, N'', 0, 1, CAST(0x0000A53A00FC43BD AS DateTime), 1, CAST(0x0000A53A010657A6 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (27, CAST(0x0000A53A0106E2C1 AS DateTime), N'0000000027', CAST(48.45 AS Decimal(18, 2)), CAST(8.72 AS Decimal(18, 2)), CAST(57.17 AS Decimal(18, 2)), N'Registrado', 32, 2, 1, 1, N'', 0, 1, CAST(0x0000A53A0106E2C1 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (28, CAST(0x0000A53B00D4E678 AS DateTime), N'0000000028', CAST(46.05 AS Decimal(18, 2)), CAST(8.29 AS Decimal(18, 2)), CAST(54.34 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A53B00D4E678 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (29, CAST(0x0000A53C010CFB18 AS DateTime), N'0000000029', CAST(27.26 AS Decimal(18, 2)), CAST(4.91 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), N'Registrado', 8, 2, 1, 1, N'', 0, 1, CAST(0x0000A53C010CFB18 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (30, CAST(0x0000A53C013EC4AA AS DateTime), N'0000000030', CAST(119.92 AS Decimal(18, 2)), CAST(21.59 AS Decimal(18, 2)), CAST(141.51 AS Decimal(18, 2)), N'Pendiente', 3, 2, 1, 1, N'', 0, 1, CAST(0x0000A53C013EC4AA AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (31, CAST(0x0000A5490141DC08 AS DateTime), N'0000000031', CAST(354.97 AS Decimal(18, 2)), CAST(63.90 AS Decimal(18, 2)), CAST(418.87 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A5490141DC08 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (32, CAST(0x0000A549014DC424 AS DateTime), N'0000000032', CAST(81.79 AS Decimal(18, 2)), CAST(14.72 AS Decimal(18, 2)), CAST(96.51 AS Decimal(18, 2)), N'Pendiente', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A549014DC424 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (33, CAST(0x0000A54B016A38A2 AS DateTime), N'0000000033', CAST(23.03 AS Decimal(18, 2)), CAST(4.14 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A54B016A38A2 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (34, CAST(0x0000A54B016A3A0D AS DateTime), N'0000000034', CAST(23.03 AS Decimal(18, 2)), CAST(4.14 AS Decimal(18, 2)), CAST(27.17 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A54B016A3A0D AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (35, CAST(0x0000A55F00DA03AB AS DateTime), N'0000000035', CAST(65.12 AS Decimal(18, 2)), CAST(11.72 AS Decimal(18, 2)), CAST(76.84 AS Decimal(18, 2)), N'Registrado', 2, 2, 1, 1, N'', 1, 1, CAST(0x0000A55F00DA03AB AS DateTime), 1, CAST(0x0000A55F01567099 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (36, CAST(0x0000A55F00DA1972 AS DateTime), N'0000000036', CAST(69.36 AS Decimal(18, 2)), CAST(12.48 AS Decimal(18, 2)), CAST(81.84 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 1, 1, CAST(0x0000A55F00DA1972 AS DateTime), 1, CAST(0x0000A55F016EE94F AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (37, CAST(0x0000A55F01588D3B AS DateTime), N'0000000037', CAST(37.58 AS Decimal(18, 2)), CAST(6.76 AS Decimal(18, 2)), CAST(44.34 AS Decimal(18, 2)), N'Registrado', 10, 2, 1, 1, N'', 0, 1, CAST(0x0000A55F01588D3B AS DateTime), 1, CAST(0x0000A55F0160D2D4 AS DateTime))
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (38, CAST(0x0000A56400ADAD5F AS DateTime), N'0000000038', CAST(27.26 AS Decimal(18, 2)), CAST(4.91 AS Decimal(18, 2)), CAST(32.17 AS Decimal(18, 2)), N'Registrado', 1, 2, 1, 1, N'', 0, 1, CAST(0x0000A56400ADAD5F AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (39, CAST(0x0000A56400B348FF AS DateTime), N'0000000039', CAST(37.58 AS Decimal(18, 2)), CAST(6.76 AS Decimal(18, 2)), CAST(44.34 AS Decimal(18, 2)), N'Registrado', 1, 3, 1, 1, N'', 1, 1, CAST(0x0000A56400B348FF AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (40, CAST(0x0000A56400B39643 AS DateTime), N'0000000040', CAST(54.53 AS Decimal(18, 2)), CAST(9.81 AS Decimal(18, 2)), CAST(64.34 AS Decimal(18, 2)), N'Registrado', 10, 2, 1, 1, N'', 0, 1, CAST(0x0000A56400B39643 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (41, CAST(0x0000A56400B42131 AS DateTime), N'0000000041', CAST(42.09 AS Decimal(18, 2)), CAST(7.58 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), N'Registrado', 10, 2, 1, 1, N'', 0, 1, CAST(0x0000A56400B42131 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (42, CAST(0x0000A56400B54AC8 AS DateTime), N'0000000042', CAST(33.62 AS Decimal(18, 2)), CAST(6.05 AS Decimal(18, 2)), CAST(39.67 AS Decimal(18, 2)), N'Registrado', 2, 3, 1, 1, N'', 0, 1, CAST(0x0000A56400B54AC8 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (43, CAST(0x0000A564012E6199 AS DateTime), N'0000000043', CAST(29.38 AS Decimal(18, 2)), CAST(5.29 AS Decimal(18, 2)), CAST(34.67 AS Decimal(18, 2)), N'Pendiente', 1, 3, 1, 1, N'', 1, 1, CAST(0x0000A564012E6199 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (44, CAST(0x0000A56401338C49 AS DateTime), N'0000000044', CAST(84.19 AS Decimal(18, 2)), CAST(15.15 AS Decimal(18, 2)), CAST(99.34 AS Decimal(18, 2)), N'Registrado', 10, 2, 1, 1, N'', 0, 1, CAST(0x0000A56401338C49 AS DateTime), NULL, NULL)
INSERT [Ventas].[Pedido] ([id_pedido], [fecha], [numero], [sub_total], [igv], [total], [estado], [id_cliente], [id_tipo_documento], [id_usuario], [id_sucursal], [observacion], [produccion], [usuario_registro], [fecha_registro], [usuario_modifico], [fecha_modifico]) VALUES (45, CAST(0x0000A564013423DD AS DateTime), N'0000000045', CAST(42.09 AS Decimal(18, 2)), CAST(7.58 AS Decimal(18, 2)), CAST(49.67 AS Decimal(18, 2)), N'Registrado', 10, 2, 1, 1, N'', 0, 1, CAST(0x0000A564013423DD AS DateTime), NULL, NULL)
INSERT [Ventas].[Tipo_Cliente] ([id_tipo_cliente], [descripcion], [estado]) VALUES (1, N'JURÍDICO', 1)
INSERT [Ventas].[Tipo_Cliente] ([id_tipo_cliente], [descripcion], [estado]) VALUES (2, N'NATURAL', 1)
INSERT [Ventas].[Tipo_Cliente] ([id_tipo_cliente], [descripcion], [estado]) VALUES (3, N'test', 2)
INSERT [Ventas].[Tipo_Cliente] ([id_tipo_cliente], [descripcion], [estado]) VALUES (4, N'test tes', 2)
INSERT [Ventas].[Tipo_Cliente] ([id_tipo_cliente], [descripcion], [estado]) VALUES (5, N'TEST', 1)
ALTER TABLE [Almacen].[Detalle_Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_N__id_no__3F1C4B12] FOREIGN KEY([id_nota_ingreso])
REFERENCES [Almacen].[Nota_Ingreso] ([id_nota_ingreso])
GO
ALTER TABLE [Almacen].[Detalle_Nota_Ingreso] CHECK CONSTRAINT [FK__Detalle_N__id_no__3F1C4B12]
GO
ALTER TABLE [Almacen].[Detalle_Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_N__id_pr__40106F4B] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Almacen].[Detalle_Nota_Ingreso] CHECK CONSTRAINT [FK__Detalle_N__id_pr__40106F4B]
GO
ALTER TABLE [Almacen].[Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Nota_Ingr__id_mo__396371BC] FOREIGN KEY([id_motivo])
REFERENCES [Comunes].[Motivo] ([id_motivo])
GO
ALTER TABLE [Almacen].[Nota_Ingreso] CHECK CONSTRAINT [FK__Nota_Ingr__id_mo__396371BC]
GO
ALTER TABLE [Almacen].[Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Nota_Ingr__id_su__3E2826D9] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Almacen].[Nota_Ingreso] CHECK CONSTRAINT [FK__Nota_Ingr__id_su__3E2826D9]
GO
ALTER TABLE [Almacen].[Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Nota_Ingr__id_us__3A5795F5] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Nota_Ingreso] CHECK CONSTRAINT [FK__Nota_Ingr__id_us__3A5795F5]
GO
ALTER TABLE [Almacen].[Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Nota_Ingr__usuar__3C3FDE67] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Nota_Ingreso] CHECK CONSTRAINT [FK__Nota_Ingr__usuar__3C3FDE67]
GO
ALTER TABLE [Almacen].[Nota_Ingreso]  WITH CHECK ADD  CONSTRAINT [FK__Nota_Ingr__usuar__3D3402A0] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Nota_Ingreso] CHECK CONSTRAINT [FK__Nota_Ingr__usuar__3D3402A0]
GO
ALTER TABLE [Almacen].[Producto]  WITH CHECK ADD  CONSTRAINT [FK__Producto__id_cat__345EC57D] FOREIGN KEY([id_categoria])
REFERENCES [Almacen].[Categoria] ([id_categoria])
GO
ALTER TABLE [Almacen].[Producto] CHECK CONSTRAINT [FK__Producto__id_cat__345EC57D]
GO
ALTER TABLE [Almacen].[Producto]  WITH CHECK ADD  CONSTRAINT [FK__Producto__id_mar__336AA144] FOREIGN KEY([id_marca])
REFERENCES [Almacen].[Marca] ([id_marca])
GO
ALTER TABLE [Almacen].[Producto] CHECK CONSTRAINT [FK__Producto__id_mar__336AA144]
GO
ALTER TABLE [Almacen].[Producto]  WITH CHECK ADD  CONSTRAINT [FK__Producto__usuari__5A054B78] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Producto] CHECK CONSTRAINT [FK__Producto__usuari__5A054B78]
GO
ALTER TABLE [Almacen].[Producto]  WITH CHECK ADD  CONSTRAINT [FK__Producto__usuari__5AF96FB1] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Producto] CHECK CONSTRAINT [FK__Producto__usuari__5AF96FB1]
GO
ALTER TABLE [Almacen].[Stock_Producto]  WITH CHECK ADD  CONSTRAINT [FK__Stock_Pro__id_pr__36470DEF] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Almacen].[Stock_Producto] CHECK CONSTRAINT [FK__Stock_Pro__id_pr__36470DEF]
GO
ALTER TABLE [Almacen].[Stock_Producto]  WITH CHECK ADD  CONSTRAINT [FK__Stock_Pro__id_su__3552E9B6] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Almacen].[Stock_Producto] CHECK CONSTRAINT [FK__Stock_Pro__id_su__3552E9B6]
GO
ALTER TABLE [Almacen].[Stock_Producto]  WITH CHECK ADD  CONSTRAINT [FK__Stock_Pro__usuar__5ECA0095] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Stock_Producto] CHECK CONSTRAINT [FK__Stock_Pro__usuar__5ECA0095]
GO
ALTER TABLE [Almacen].[Stock_Producto]  WITH CHECK ADD  CONSTRAINT [FK__Stock_Pro__usuar__5FBE24CE] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Almacen].[Stock_Producto] CHECK CONSTRAINT [FK__Stock_Pro__usuar__5FBE24CE]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD FOREIGN KEY([id_contacto_proveedor])
REFERENCES [Compras].[Contacto_Proveedor] ([id_contacto_proveedor])
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_mo__127EAEC5] FOREIGN KEY([id_moneda])
REFERENCES [Logistica].[Moneda] ([id_moneda])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_mo__127EAEC5]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_pr__2101D846] FOREIGN KEY([id_proveedor])
REFERENCES [Compras].[Proveedor] ([id_proveedor])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_pr__2101D846]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_su__23DE44F1] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_su__23DE44F1]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_ti__21F5FC7F] FOREIGN KEY([id_tipo_documento])
REFERENCES [Comunes].[Tipo_Documento] ([id_tipo_documento])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_ti__21F5FC7F]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_ti__22EA20B8] FOREIGN KEY([id_tipo_pago])
REFERENCES [Comunes].[Tipo_Pago] ([id_tipo_pago])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_ti__22EA20B8]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__id_us__24D2692A] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__id_us__24D2692A]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__usuar__25C68D63] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__usuar__25C68D63]
GO
ALTER TABLE [Compras].[ComprobanteCompra]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__usuar__26BAB19C] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[ComprobanteCompra] CHECK CONSTRAINT [FK__Comproban__usuar__26BAB19C]
GO
ALTER TABLE [Compras].[Contacto_Proveedor]  WITH CHECK ADD FOREIGN KEY([id_proveedor])
REFERENCES [Compras].[Proveedor] ([id_proveedor])
GO
ALTER TABLE [Compras].[Contacto_Proveedor]  WITH CHECK ADD  CONSTRAINT [FK__Contacto___usuar__422DC1E7] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Contacto_Proveedor] CHECK CONSTRAINT [FK__Contacto___usuar__422DC1E7]
GO
ALTER TABLE [Compras].[Contacto_Proveedor]  WITH CHECK ADD  CONSTRAINT [FK__Contacto___usuar__4321E620] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Contacto_Proveedor] CHECK CONSTRAINT [FK__Contacto___usuar__4321E620]
GO
ALTER TABLE [Compras].[Cuenta_Proveedor]  WITH CHECK ADD FOREIGN KEY([id_compra])
REFERENCES [Compras].[ComprobanteCompra] ([id_compra])
GO
ALTER TABLE [Compras].[Cuenta_Proveedor]  WITH CHECK ADD FOREIGN KEY([id_proveedor])
REFERENCES [Compras].[Proveedor] ([id_proveedor])
GO
ALTER TABLE [Compras].[Cuenta_Proveedor]  WITH CHECK ADD FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Compras].[Cuenta_Proveedor]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Detalle_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_C__id_co__1372D2FE] FOREIGN KEY([id_compra])
REFERENCES [Compras].[ComprobanteCompra] ([id_compra])
GO
ALTER TABLE [Compras].[Detalle_Compra] CHECK CONSTRAINT [FK__Detalle_C__id_co__1372D2FE]
GO
ALTER TABLE [Compras].[Detalle_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_C__id_no__17CD73C7] FOREIGN KEY([id_nota_ingreso])
REFERENCES [Almacen].[Nota_Ingreso] ([id_nota_ingreso])
GO
ALTER TABLE [Compras].[Detalle_Compra] CHECK CONSTRAINT [FK__Detalle_C__id_no__17CD73C7]
GO
ALTER TABLE [Compras].[Detalle_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_C__id_pr__1466F737] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Compras].[Detalle_Compra] CHECK CONSTRAINT [FK__Detalle_C__id_pr__1466F737]
GO
ALTER TABLE [Compras].[Detalle_Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_O__id_or__3BB5CE82] FOREIGN KEY([id_orden_compra])
REFERENCES [Compras].[Orden_Compra] ([id_orden_compra])
GO
ALTER TABLE [Compras].[Detalle_Orden_Compra] CHECK CONSTRAINT [FK__Detalle_O__id_or__3BB5CE82]
GO
ALTER TABLE [Compras].[Detalle_Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_O__id_pr__3D9E16F4] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Compras].[Detalle_Orden_Compra] CHECK CONSTRAINT [FK__Detalle_O__id_pr__3D9E16F4]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__id_co__33208881] FOREIGN KEY([id_contacto_proveedor])
REFERENCES [Compras].[Contacto_Proveedor] ([id_contacto_proveedor])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__id_co__33208881]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__id_mo__118A8A8C] FOREIGN KEY([id_moneda])
REFERENCES [Logistica].[Moneda] ([id_moneda])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__id_mo__118A8A8C]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__id_pr__322C6448] FOREIGN KEY([id_proveedor])
REFERENCES [Compras].[Proveedor] ([id_proveedor])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__id_pr__322C6448]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__id_su__02133CD2] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__id_su__02133CD2]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__id_us__3138400F] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__id_us__3138400F]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__usuar__2B7F66B9] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__usuar__2B7F66B9]
GO
ALTER TABLE [Compras].[Orden_Compra]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Com__usuar__2C738AF2] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Orden_Compra] CHECK CONSTRAINT [FK__Orden_Com__usuar__2C738AF2]
GO
ALTER TABLE [Compras].[Proveedor]  WITH CHECK ADD FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Compras].[Proveedor]  WITH CHECK ADD FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Comunes].[Numero_Documento]  WITH CHECK ADD  CONSTRAINT [FK__Numero_Do__id_su__49AEE81E] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Comunes].[Numero_Documento] CHECK CONSTRAINT [FK__Numero_Do__id_su__49AEE81E]
GO
ALTER TABLE [Comunes].[Numero_Documento]  WITH CHECK ADD  CONSTRAINT [FK__Numero_Do__id_ti__48BAC3E5] FOREIGN KEY([id_tipo_documento])
REFERENCES [Comunes].[Tipo_Documento] ([id_tipo_documento])
GO
ALTER TABLE [Comunes].[Numero_Documento] CHECK CONSTRAINT [FK__Numero_Do__id_ti__48BAC3E5]
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD  CONSTRAINT [FK__Evento__id_usuar__6497E884] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Evento] CHECK CONSTRAINT [FK__Evento__id_usuar__6497E884]
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD  CONSTRAINT [FK__Evento__usuario___658C0CBD] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Evento] CHECK CONSTRAINT [FK__Evento__usuario___658C0CBD]
GO
ALTER TABLE [dbo].[Evento]  WITH CHECK ADD  CONSTRAINT [FK__Evento__usuario___668030F6] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [dbo].[Evento] CHECK CONSTRAINT [FK__Evento__usuario___668030F6]
GO
ALTER TABLE [Produccion].[Detalle_Horas_Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_H__id_or__0A3E6E7F] FOREIGN KEY([id_orden_produccion])
REFERENCES [Produccion].[Orden_Produccion] ([id_orden_produccion])
GO
ALTER TABLE [Produccion].[Detalle_Horas_Trabajadas] CHECK CONSTRAINT [FK__Detalle_H__id_or__0A3E6E7F]
GO
ALTER TABLE [Produccion].[Detalle_Horas_Trabajadas]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_H__id_pe__7DD8979A] FOREIGN KEY([id_personal])
REFERENCES [RRHH].[Personal] ([id_personal])
GO
ALTER TABLE [Produccion].[Detalle_Horas_Trabajadas] CHECK CONSTRAINT [FK__Detalle_H__id_pe__7DD8979A]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Pro__id_mo__0B3292B8] FOREIGN KEY([id_motivo])
REFERENCES [Comunes].[Motivo] ([id_motivo])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Pro__id_mo__0B3292B8]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Pro__id_pr__0C26B6F1] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Pro__id_pr__0C26B6F1]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Pro__id_su__6F556E19] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Pro__id_su__6F556E19]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Pro__id_us__6E6149E0] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Pro__id_us__6E6149E0]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Tra__usuar__6418C597] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Tra__usuar__6418C597]
GO
ALTER TABLE [Produccion].[Orden_Produccion]  WITH CHECK ADD  CONSTRAINT [FK__Orden_Tra__usuar__650CE9D0] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Produccion].[Orden_Produccion] CHECK CONSTRAINT [FK__Orden_Tra__usuar__650CE9D0]
GO
ALTER TABLE [RRHH].[Adelanto]  WITH CHECK ADD  CONSTRAINT [FK__Adelanto__id_per__147C05D0] FOREIGN KEY([id_personal])
REFERENCES [RRHH].[Personal] ([id_personal])
GO
ALTER TABLE [RRHH].[Adelanto] CHECK CONSTRAINT [FK__Adelanto__id_per__147C05D0]
GO
ALTER TABLE [RRHH].[Personal]  WITH CHECK ADD  CONSTRAINT [FK__Personal__id_per__4AB81AF0] FOREIGN KEY([id_personal])
REFERENCES [RRHH].[Personal] ([id_personal])
GO
ALTER TABLE [RRHH].[Personal] CHECK CONSTRAINT [FK__Personal__id_per__4AB81AF0]
GO
ALTER TABLE [RRHH].[Personal]  WITH CHECK ADD  CONSTRAINT [FK__Personal__id_suc__4BAC3F29] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [RRHH].[Personal] CHECK CONSTRAINT [FK__Personal__id_suc__4BAC3F29]
GO
ALTER TABLE [RRHH].[Personal]  WITH CHECK ADD  CONSTRAINT [FK__Personal__id_tip__1DD065E0] FOREIGN KEY([id_tipo_personal])
REFERENCES [RRHH].[Tipo_Personal] ([id_tipo_personal])
GO
ALTER TABLE [RRHH].[Personal] CHECK CONSTRAINT [FK__Personal__id_tip__1DD065E0]
GO
ALTER TABLE [RRHH].[Personal]  WITH CHECK ADD  CONSTRAINT [FK__Personal__usuari__3E723F9C] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [RRHH].[Personal] CHECK CONSTRAINT [FK__Personal__usuari__3E723F9C]
GO
ALTER TABLE [RRHH].[Personal]  WITH CHECK ADD  CONSTRAINT [FK__Personal__usuari__3F6663D5] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [RRHH].[Personal] CHECK CONSTRAINT [FK__Personal__usuari__3F6663D5]
GO
ALTER TABLE [Seguridad].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK__Usuario__id_pers__29221CFB] FOREIGN KEY([id_personal])
REFERENCES [RRHH].[Personal] ([id_personal])
GO
ALTER TABLE [Seguridad].[Usuario] CHECK CONSTRAINT [FK__Usuario__id_pers__29221CFB]
GO
ALTER TABLE [Ventas].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cliente__id_tipo__603D47BB] FOREIGN KEY([id_tipo_cliente])
REFERENCES [Ventas].[Tipo_Cliente] ([id_tipo_cliente])
GO
ALTER TABLE [Ventas].[Cliente] CHECK CONSTRAINT [FK__Cliente__id_tipo__603D47BB]
GO
ALTER TABLE [Ventas].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cliente__usuario__61316BF4] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Cliente] CHECK CONSTRAINT [FK__Cliente__usuario__61316BF4]
GO
ALTER TABLE [Ventas].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cliente__usuario__6225902D] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Cliente] CHECK CONSTRAINT [FK__Cliente__usuario__6225902D]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__usuar__65E11278] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Comproban__usuar__65E11278]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Comproban__usuar__66D536B1] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Comproban__usuar__66D536B1]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_client__01142BA1] FOREIGN KEY([id_cliente])
REFERENCES [Ventas].[Cliente] ([id_cliente])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_client__01142BA1]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_numero__3EA749C6] FOREIGN KEY([id_numeros])
REFERENCES [Comunes].[Numero_Documento] ([id_numeros])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_numero__3EA749C6]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_pedido__04E4BC85] FOREIGN KEY([id_pedido])
REFERENCES [Ventas].[Pedido] ([id_pedido])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_pedido__04E4BC85]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_sucurs__6166761E] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_sucurs__6166761E]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_tipo_p__595B4002] FOREIGN KEY([id_tipo_pago])
REFERENCES [Comunes].[Tipo_Pago] ([id_tipo_pago])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_tipo_p__595B4002]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK__Venta__id_usuari__59C55456] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK__Venta__id_usuari__59C55456]
GO
ALTER TABLE [Ventas].[ComprobanteVenta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Venta] FOREIGN KEY([id_venta])
REFERENCES [Ventas].[ComprobanteVenta] ([id_venta])
GO
ALTER TABLE [Ventas].[ComprobanteVenta] CHECK CONSTRAINT [FK_Venta_Venta]
GO
ALTER TABLE [Ventas].[Cuenta_Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cuenta_Cl__id_cl__5A4F643B] FOREIGN KEY([id_cliente])
REFERENCES [Ventas].[Cliente] ([id_cliente])
GO
ALTER TABLE [Ventas].[Cuenta_Cliente] CHECK CONSTRAINT [FK__Cuenta_Cl__id_cl__5A4F643B]
GO
ALTER TABLE [Ventas].[Cuenta_Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cuenta_Cl__id_su__5C37ACAD] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Ventas].[Cuenta_Cliente] CHECK CONSTRAINT [FK__Cuenta_Cl__id_su__5C37ACAD]
GO
ALTER TABLE [Ventas].[Cuenta_Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cuenta_Cl__id_us__51300E55] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Cuenta_Cliente] CHECK CONSTRAINT [FK__Cuenta_Cl__id_us__51300E55]
GO
ALTER TABLE [Ventas].[Cuenta_Cliente]  WITH CHECK ADD  CONSTRAINT [FK__Cuenta_Cl__id_ve__5B438874] FOREIGN KEY([id_venta])
REFERENCES [Ventas].[ComprobanteVenta] ([id_venta])
GO
ALTER TABLE [Ventas].[Cuenta_Cliente] CHECK CONSTRAINT [FK__Cuenta_Cl__id_ve__5B438874]
GO
ALTER TABLE [Ventas].[Detalle_Cuenta_Cliente]  WITH CHECK ADD FOREIGN KEY([id_cuenta_cliente])
REFERENCES [Ventas].[Cuenta_Cliente] ([id_cuenta_cliente])
GO
ALTER TABLE [Ventas].[Detalle_Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_P__id_pe__4F7CD00D] FOREIGN KEY([id_pedido])
REFERENCES [Ventas].[Pedido] ([id_pedido])
GO
ALTER TABLE [Ventas].[Detalle_Pedido] CHECK CONSTRAINT [FK__Detalle_P__id_pe__4F7CD00D]
GO
ALTER TABLE [Ventas].[Detalle_Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Detalle_P__id_pr__5070F446] FOREIGN KEY([id_producto])
REFERENCES [Almacen].[Producto] ([id_producto])
GO
ALTER TABLE [Ventas].[Detalle_Pedido] CHECK CONSTRAINT [FK__Detalle_P__id_pr__5070F446]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__id_clien__239E4DCF] FOREIGN KEY([id_cliente])
REFERENCES [Ventas].[Cliente] ([id_cliente])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__id_clien__239E4DCF]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__id_sucur__6BE40491] FOREIGN KEY([id_sucursal])
REFERENCES [Logistica].[Sucursal] ([id_sucursal])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__id_sucur__6BE40491]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__id_tipo___473C8FC7] FOREIGN KEY([id_tipo_documento])
REFERENCES [Comunes].[Tipo_Documento] ([id_tipo_documento])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__id_tipo___473C8FC7]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__id_usuar__6CD828CA] FOREIGN KEY([id_usuario])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__id_usuar__6CD828CA]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__usuario___66161CA2] FOREIGN KEY([usuario_registro])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__usuario___66161CA2]
GO
ALTER TABLE [Ventas].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK__Pedido__usuario___670A40DB] FOREIGN KEY([usuario_modifico])
REFERENCES [Seguridad].[Usuario] ([id_usuario])
GO
ALTER TABLE [Ventas].[Pedido] CHECK CONSTRAINT [FK__Pedido__usuario___670A40DB]
GO
USE [master]
GO
ALTER DATABASE [BD_BLANKITO] SET  READ_WRITE 
GO
