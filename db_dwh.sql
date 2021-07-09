USE [master]
GO
/****** Object:  Database [db_dwh]    Script Date: 09.07.2021 12:14:17 ******/
CREATE DATABASE [db_dwh];
GO

USE db_dwh;
GO

CREATE TABLE [dbo].[DimContractSignDate](
	[ContractSignDateId] [int] NOT NULL,
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
	[ContractValidFromId] [int] NOT NULL,
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
	[ContractValidToId] [int] NOT NULL,
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
GO
USE [master]
GO
ALTER DATABASE [db_dwh] SET  READ_WRITE 
GO
