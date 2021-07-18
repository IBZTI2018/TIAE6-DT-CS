If(db_id(N'TIAE6_DT_Staging') IS NULL) CREATE DATABASE TIAE6_DT_Staging
GO
Use TIAE6_DT_Staging

-- Create tables that are a copy of the production database
DROP TABLE IF EXISTS [Contract]
DROP TABLE IF EXISTS Customer
DROP TABLE IF EXISTS [Service]
DROP TABLE IF EXISTS Store

DROP TABLE IF EXISTS DeviceWareHouse
DROP TABLE IF EXISTS SupplierDevice

DROP TABLE IF EXISTS Supplier
DROP TABLE IF EXISTS Device
DROP TABLE IF EXISTS WareHouse

DROP TABLE IF EXISTS [Location]

-- ************************************** [Supplier]
CREATE TABLE [Supplier]
(
  [SupplierId] int NOT NULL ,
  [CompanyName] varchar(50) NOT NULL ,
  [Phone] varchar(50) NOT NULL ,
  [IsPrivateLabel] bit NOT NULL ,

  CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED ([SupplierId] ASC)
);
GO

-- ************************************** [Service]
CREATE TABLE [Service]
(
  [ServiceId] int NOT NULL ,
  [Name] varchar(50) NOT NULL ,
  [Type] varchar(50) NOT NULL ,
  [State] varchar(50) NOT NULL ,
  [Price] money NOT NULL ,

  CONSTRAINT [PK_service] PRIMARY KEY CLUSTERED ([ServiceId] ASC)
);
GO

-- ************************************** [Location]
CREATE TABLE [Location]
(
  [LocationId] int NOT NULL ,
  [Street] varchar(50) NOT NULL ,
  [City] varchar(50) NOT NULL ,
  [Region] varchar(50) NOT NULL ,
  [ZipCode] varchar(50) NOT NULL ,
  [Country] varchar(50) NOT NULL ,

  CONSTRAINT [PK_storelocation] PRIMARY KEY CLUSTERED ([LocationId] ASC)
);
GO

-- ************************************** [Device]
CREATE TABLE [Device]
(
  [DeviceId] int NOT NULL ,
  [Name] varchar(50) NOT NULL ,
  [Brand] varchar(50) NOT NULL ,
  [Type] varchar(50) NOT NULL ,
  [Price] money NOT NULL ,

  CONSTRAINT [PK_device] PRIMARY KEY CLUSTERED ([DeviceId] ASC)
);
GO

-- ************************************** [WareHouse]
CREATE TABLE [WareHouse]
(
  [WareHouseId] int NOT NULL ,
  [Name] varchar(50) NOT NULL ,
  [Phone] varchar(50) NOT NULL ,
  [Capacity] int NOT NULL ,
  [LocationId] int NOT NULL ,

  CONSTRAINT [PK_warehouseid] PRIMARY KEY CLUSTERED ([WareHouseId] ASC),
  CONSTRAINT [FK_111] FOREIGN KEY ([LocationId])  REFERENCES [Location]([LocationId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_111] ON [WareHouse] 
 (
  [LocationId] ASC
 )

GO

-- ************************************** [SupplierDevice]
CREATE TABLE [SupplierDevice]
(
  [SupplierDeviceId] int NOT NULL ,
  [SupplierId] int NOT NULL ,
  [DeviceId] int NOT NULL ,
  [PurchasePrice] money NOT NULL ,

  CONSTRAINT [PK_supplierdevice] PRIMARY KEY CLUSTERED ([SupplierDeviceId] ASC),
  CONSTRAINT [FK_126] FOREIGN KEY ([SupplierId])  REFERENCES [Supplier]([SupplierId]),
  CONSTRAINT [FK_129] FOREIGN KEY ([DeviceId])  REFERENCES [Device]([DeviceId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_126] ON [SupplierDevice] 
 (
  [SupplierId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_129] ON [SupplierDevice] 
 (
  [DeviceId] ASC
 )

GO

-- ************************************** [Store]
CREATE TABLE [Store]
(
  [StoreId] int NOT NULL ,
  [Name] varchar(50) NOT NULL ,
  [Phone] varchar(50) NOT NULL ,
  [LocationId] int NOT NULL ,

  CONSTRAINT [PK_store] PRIMARY KEY CLUSTERED ([StoreId] ASC),
  CONSTRAINT [FK_99] FOREIGN KEY ([LocationId])  REFERENCES [Location]([LocationId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_99] ON [Store] 
 (
  [LocationId] ASC
 )

GO

-- ************************************** [Customer]
CREATE TABLE [Customer]
(
  [CustomerId] int NOT NULL ,
  [FirstName] varchar(50) NOT NULL ,
  [LastName] varchar(50) NOT NULL ,
  [Phone] varchar(50) NOT NULL ,
  [Birthdate] date NOT NULL ,
  [Gender] char(1) NOT NULL ,
  [LocationId] int NOT NULL ,

  CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED ([CustomerId] ASC),
  CONSTRAINT [FK_136] FOREIGN KEY ([LocationId])  REFERENCES [Location]([LocationId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_136] ON [Customer] 
 (
  [LocationId] ASC
 )

GO

-- ************************************** [DeviceWareHouse]
CREATE TABLE [DeviceWareHouse]
(
  [DeviceWareHouseId] int NOT NULL ,
  [DeviceId] int NOT NULL ,
  [WareHouseId] int NOT NULL ,
  [Amount] int NOT NULL ,

  CONSTRAINT [PK_devicewarehouse] PRIMARY KEY CLUSTERED ([DeviceWareHouseId] ASC),
  CONSTRAINT [FK_114] FOREIGN KEY ([DeviceId])  REFERENCES [Device]([DeviceId]),
  CONSTRAINT [FK_117] FOREIGN KEY ([WareHouseId])  REFERENCES [WareHouse]([WareHouseId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_114] ON [DeviceWareHouse] 
 (
  [DeviceId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_117] ON [DeviceWareHouse] 
 (
  [WareHouseId] ASC
 )

GO

-- ************************************** [Contract]
CREATE TABLE [Contract]
(
  [ContractId] int NOT NULL ,
  [CustomerId] int NOT NULL ,
  [ServiceId] int NOT NULL ,
  [DeviceId] int NOT NULL ,
  [StoreId] int NOT NULL ,
  [ContractSignDate] date NOT NULL ,
  [ContractValidFrom] date NOT NULL ,
  [ContractValidTo] date NOT NULL ,

  CONSTRAINT [PK_customerservice] PRIMARY KEY CLUSTERED ([ContractId] ASC),
  CONSTRAINT [FK_139] FOREIGN KEY ([StoreId])  REFERENCES [Store]([StoreId]),
  CONSTRAINT [FK_36] FOREIGN KEY ([CustomerId])  REFERENCES [Customer]([CustomerId]),
  CONSTRAINT [FK_39] FOREIGN KEY ([ServiceId])  REFERENCES [Service]([ServiceId]),
  CONSTRAINT [FK_94] FOREIGN KEY ([DeviceId])  REFERENCES [Device]([DeviceId])
);
GO

CREATE NONCLUSTERED INDEX [fkIdx_139] ON [Contract] 
 (
  [StoreId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_36] ON [Contract] 
 (
  [CustomerId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_39] ON [Contract] 
 (
  [ServiceId] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_94] ON [Contract] 
 (
  [DeviceId] ASC
 )

GO



-- Create tables that are a copy of the dwh database
CREATE TABLE [dbo].[DimContractSignDate](
	[ContractSignDateId] [int] IDENTITY (1, 1) NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Week] [int] NOT NULL,
	[Day] [int] NOT NULL,
 CONSTRAINT [PK_DimContractSignDate] PRIMARY KEY CLUSTERED 
(
	[ContractSignDateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimContractValidFrom]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimContractValidFrom](
	[ContractValidFromId] [int] IDENTITY (1, 1) NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Week] [int] NOT NULL,
	[Day] [int] NOT NULL,
 CONSTRAINT [PK_DimContractValidFrom] PRIMARY KEY CLUSTERED 
(
	[ContractValidFromId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimContractValidTo]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimContractValidTo](
	[ContractValidToId] [int] IDENTITY (1, 1) NOT NULL,
	[Year] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Week] [int] NOT NULL,
	[Day] [int] NOT NULL,
 CONSTRAINT [PK_DimContractValidTo] PRIMARY KEY CLUSTERED 
(
	[ContractValidToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCustomer]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCustomer](
	[CustomerId] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[Gender] [char](1) NOT NULL,
 CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDevice]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDevice](
	[DeviceId] [int] NOT NULL,
	[DeviceName] [varchar](50) NOT NULL,
	[DeviceBrand] [varchar](50) NOT NULL,
	[DeviceType] [varchar](50) NOT NULL,
	[DevicePrice] [money] NOT NULL,
	[PurchasePrice] [money] NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[IsPrivateLabel] [bit] NOT NULL,
	[DeviceWareHouseAmount] [int] NOT NULL,
	[WareHouseName] [varchar](50) NOT NULL,
	[WareHousePhone] [varchar](50) NOT NULL,
	[WareHouseCapacity] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DimDevice] PRIMARY KEY CLUSTERED 
(
	[DeviceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimLocation]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimLocation](
	[LocationId] [int] NOT NULL,
	[Street] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DimLocation] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimStore]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimStore](
	[StoreId] [int] NOT NULL,
	[StoreName] [varchar](50) NOT NULL,
	[StorePhone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DimStore] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactSales]    Script Date: 09.07.2021 12:14:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactSales](
	[ContractId] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[DeviceId] [int] NOT NULL,
	[StoreId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
	[ContractSignDateId] [int] NOT NULL,
	[ContractValidFromId] [int] NOT NULL,
	[ContractValidToId] [int] NOT NULL,
	[ContractName] [varchar](50) NOT NULL,
	[ContractType] [varchar](50) NOT NULL,
	[ContractState] [char](10) NOT NULL,
	[ContractPrice] [money] NOT NULL,
 CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED 
(
	[ContractId] ASC,
	[CustomerId] ASC,
	[DeviceId] ASC,
	[StoreId] ASC,
	[LocationId] ASC,
	[ContractSignDateId] ASC,
	[ContractValidFromId] ASC,
	[ContractValidToId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_ContractSignDateId] FOREIGN KEY([ContractSignDateId])
REFERENCES [dbo].[DimContractSignDate] ([ContractSignDateId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_ContractSignDateId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_ContractValidFromId] FOREIGN KEY([ContractValidFromId])
REFERENCES [dbo].[DimContractValidFrom] ([ContractValidFromId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_ContractValidFromId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_ContractValidToId] FOREIGN KEY([ContractValidToId])
REFERENCES [dbo].[DimContractValidTo] ([ContractValidToId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_ContractValidToId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_CustomerId] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[DimCustomer] ([CustomerId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_CustomerId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_DeviceId] FOREIGN KEY([DeviceId])
REFERENCES [dbo].[DimDevice] ([DeviceId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_DeviceId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_LocationId] FOREIGN KEY([LocationId])
REFERENCES [dbo].[DimLocation] ([LocationId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_LocationId]
GO
ALTER TABLE [dbo].[FactSales]  WITH CHECK ADD  CONSTRAINT [FK_StoreId] FOREIGN KEY([StoreId])
REFERENCES [dbo].[DimStore] ([StoreId])
GO
ALTER TABLE [dbo].[FactSales] CHECK CONSTRAINT [FK_StoreId]
