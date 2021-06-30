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
  [SupplierId] int IDENTITY (1, 1) NOT NULL ,
  [CompanyName] varchar(50) NOT NULL ,
  [Phone] varchar(50) NOT NULL ,
  [IsPrivateLabel] bit NOT NULL ,


  CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED ([SupplierId] ASC)
);
GO








-- ************************************** [Service]

CREATE TABLE [Service]
(
  [ServiceId] int IDENTITY (1, 1) NOT NULL ,
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
  [LocationId] int IDENTITY (1, 1) NOT NULL ,
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
  [DeviceId] int IDENTITY (1, 1) NOT NULL ,
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
  [WareHouseId] int IDENTITY (1, 1) NOT NULL ,
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
  [SupplierDeviceId] int IDENTITY (1, 1) NOT NULL ,
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
  [StoreId] int IDENTITY (1, 1) NOT NULL ,
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
  [CustomerId] int IDENTITY (1, 1) NOT NULL ,
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
  [DeviceWareHouseId] int IDENTITY (1, 1) NOT NULL ,
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
  [ContractId] int IDENTITY (1, 1) NOT NULL ,
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