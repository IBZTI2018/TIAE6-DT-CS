If(db_id(N'TIAE6_DT_Production') IS NULL) CREATE DATABASE TIAE6_DT_Production
GO
Use TIAE6_DT_Production

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



-- *** 100x Supplier ***
INSERT INTO Supplier
  ([CompanyName],[Phone],[IsPrivateLabel])
VALUES('Texas Instruments', '39284195999', '1'),
  ('Abbott Laboratories', '12967660299', '0'),
  ('Texas Instruments', '06909089199', '0'),
  ('Booking Holdings Inc', '11599257699', '1'),
  ('Celanese', '83881196299', '0'),
  ('UDR Inc.', '60274044099', '1'),
  ('ABIOMED Inc', '52453599199', '1'),
  ('D. R. Horton', '45560691799', '0'),
  ('Centene Corporation', '40284842899', '0'),
  ('Booking Holdings Inc', '52388866799', '0'),
  ('Autodesk Inc.', '61466278399', '0'),
  ('Booking Holdings Inc', '41937914699', '1'),
  ('Federal Realty Investment Trust', '81679971999', '0'),
  ('Eastman Chemical', '37369647499', '1'),
  ('Church & Dwight', '47904236999', '1'),
  ('Aon plc', '34400455799', '1'),
  ('Everest Re Group Ltd.', '04782726199', '1'),
  ('D. R. Horton', '29961372799', '1'),
  ('Church & Dwight', '26810640799', '1'),
  ('Maxim Integrated Products Inc', '25517648299', '0'),
  ('O''Reilly Automotive', '73990762199', '1'),
  ('Cboe Global Markets', '80947248899', '0'),
  ('NetApp', '55322461599', '1'),
  ('Aon plc', '49326953999', '1'),
  ('Carrier Global', '69533410099', '0'),
  ('Digital Realty Trust Inc', '96672572099', '1'),
  ('BorgWarner', '21773559099', '0'),
  ('BorgWarner', '94603461299', '0'),
  ('Digital Realty Trust Inc', '07420080899', '0'),
  ('BorgWarner', '20458444499', '0'),
  ('United Airlines Holdings', '69658308499', '0'),
  ('Evergy', '61318207099', '1'),
  ('DXC Technology', '96274844799', '1'),
  ('Federal Realty Investment Trust', '85726532799', '0'),
  ('Adobe Inc.', '37526658499', '0'),
  ('AbbVie Inc.', '94535468499', '0'),
  ('Activision Blizzard', '33613399999', '1'),
  ('Apache Corporation', '21521908399', '1'),
  ('NVR Inc.', '49374427699', '1'),
  ('ONEOK', '07563513299', '0'),
  ('CVS Health', '47517715599', '1'),
  ('BorgWarner', '45744836899', '1'),
  ('NVR Inc.', '78235068499', '0'),
  ('Masco Corp.', '10390238899', '0'),
  ('Ulta Beauty', '83275665199', '1'),
  ('Netflix Inc.', '83595987999', '1'),
  ('CBRE Group', '82219686699', '1'),
  ('BlackRock', '79721212799', '1'),
  ('Eastman Chemical', '46202696999', '1'),
  ('Fifth Third Bancorp', '17605077099', '1'),
  ('Autodesk Inc.', '94973641499', '0'),
  ('Centene Corporation', '03256820399', '0'),
  ('Progressive Corp.', '81309422199', '1'),
  ('National Oilwell Varco Inc.', '09250531499', '0'),
  ('Assurant', '75215433699', '1'),
  ('Otis Worldwide', '32981660499', '0'),
  ('Caterpillar Inc.', '20704634599', '1'),
  ('CSX Corp.', '40676679599', '0'),
  ('JM Smucker', '94668500499', '0'),
  ('Caterpillar Inc.', '58659988699', '1'),
  ('CBRE Group', '21336856999', '0'),
  ('Broadcom Inc.', '39513811199', '1'),
  ('National Oilwell Varco Inc.', '45630594299', '1'),
  ('Boeing Company', '89774728199', '0'),
  ('Federal Realty Investment Trust', '03916870299', '1'),
  ('Centene Corporation', '03258824399', '1'),
  ('Hasbro Inc.', '61290861299', '0'),
  ('Analog Devices Inc.', '87503109999', '1'),
  ('HCA Healthcare', '70261648999', '1'),
  ('DuPont de Nemours Inc', '74763468199', '1'),
  ('NVR Inc.', '01520409799', '1'),
  ('CBRE Group', '99956669299', '1'),
  ('Johnson & Johnson', '64750768499', '0'),
  ('E*Trade', '47341710499', '0'),
  ('Anthem', '06989228099', '1'),
  ('Otis Worldwide', '67530399799', '0'),
  ('Carnival Corp.', '77952014399', '1'),
  ('Jack Henry & Associates', '07310295299', '0'),
  ('Apache Corporation', '90768522999', '0'),
  ('A.O. Smith Corp', '13985221699', '0'),
  ('Maxim Integrated Products Inc', '82524197399', '0'),
  ('Broadcom Inc.', '20382338899', '1'),
  ('Healthpeak Properties', '03996320199', '0'),
  ('Regeneron Pharmaceuticals', '00299374899', '0'),
  ('Centene Corporation', '34417282299', '1'),
  ('Danaher Corp.', '72920874199', '1'),
  ('Campbell Soup', '75782447499', '0'),
  ('DuPont de Nemours Inc', '17791357599', '1'),
  ('Johnson & Johnson', '12472780299', '1'),
  ('Bio-Rad Laboratories', '90543898099', '1'),
  ('Eaton Corporation', '23749225799', '1'),
  ('Bristol-Myers Squibb', '12713190399', '0'),
  ('Everest Re Group Ltd.', '57243320199', '0'),
  ('Martin Marietta Materials', '78851772799', '1'),
  ('Boston Properties', '55745354699', '0'),
  ('National Oilwell Varco Inc.', '00988384299', '0'),
  ('HCA Healthcare', '12873663699', '0'),
  ('Zebra Technologies', '53253259799', '1'),
  ('Hewlett Packard Enterprise', '35200863999', '1'),
  ('Martin Marietta Materials', '20941942999', '0');

-- *** 40x Devices ***
INSERT INTO Device
  ([Name],[Brand],[Type], [Price])
VALUES
  ('Home Theater System - Black Diamond', 'Boytone', 'Stereos', '69.0'),
  ('Channel Home Theater System - Black Diamond', 'Yamaha', 'Surround Speakers', '244.01'),
  ('Air-Fi Runaway', 'MEE audio', 'Bluetooth Headsets', '49.0'),
  ('JBL Everest 710 Silver', 'Jbl', 'Bluetooth Headphones', '219.99'),
  ('Touch-Screen Laptop', 'Acer', 'Computers', '764.99'),
  ('Internal PCI Express 3.0', 'Samsung', 'Storage', '229.99'),
  ('Wifi Video Monitoring Camera', 'Logitech', 'Computers/Tablets', '139.99'),
  ('microSDXC Memory Card', 'SanDisk', 'Camera Accessories', '54.99'),
  ('Air Bluetooth Wireless Earbuds', 'SOL REPUBLIC', 'Bluetooth Headphones', '179.99'),
  ('Mirrorless Digital Camera', 'Sony', 'Digital Cameras', '1786.64'),
  ('Type-R Speaker Set', 'Alpine', 'Speakers', '176.99'),
  ('Car Speakers', 'Alpine', 'Speakers', '150.0'),
  ('Channel Speaker', 'MartinLogan', 'Speakers', '209.98'),
  ('SATA Solid State Drive', 'SanDisk', 'Internal Drives', '109.99'),
  ('NVIDIA GeForce GTX 1060', 'MSI', 'Computers', '1382.41'),
  ('Ultimate Keyboard Case', 'Belkin', 'Computer Accessories', '74.99'),
  ('In-Wall Speaker', 'Definitive Technology', 'Speakers', '549.0'),
  ('Ultra HD Touch-Screen Laptop', 'Intel Core i7', 'Computers/Tablets', '3519.99'),
  ('Spherical VR Camera', 'Body Mounted', 'Cameras', '439.0'),
  ('Amplifier', 'Grace Digital', 'Home Audio', '143.89'),
  ('Wi-Fi HD Home Monitoring', 'Motorola', 'Electronics', '108.16'),
  ('4K Ultra HD TV', 'Samsung', 'Electronics', '599.99'),
  ('A/V Receiver', 'Denon', 'Electronics', '229.0'),
  ('Wall Mount Stand', 'Sonax', 'TV Accessories', '35.99'),
  ('Recorder Boombox MP3', 'Memorex', 'Portable Audio', '47.99'),
  ('WinTV-dualHD Cordcutter', 'Hauppauge', 'TV Tuner', '69.99'),
  ('Air Bluetooth Wireless Earbuds', 'SOL REPUBLIC', 'Bluetooth Headphones', '99.99'),
  ('Signature Series', 'SunBriteTV', 'UHD TV', '2799.99'),
  ('GTK-XB90 Bluetooth Speaker', 'Sony', 'Wireless Speakers', '298.0'),
  ('7.2-Channel Network A/V Receiver', 'Yamaha', 'Home Theater', '449.95'),
  ('Center Channel Speaker', 'Pioneer', 'Stereos', '99.99'),
  ('UHD Smart LED TV', 'Samsung', 'Home Audio', '1471.99'),
  ('512GB Internal PCI Express', 'Samsung', 'Internal Drives', '327.99'),
  ('microSDXC U3 Memory Card with Adapter', 'Samsung', 'Photo Accessories', '169.99'),
  ('15.6 Touchscreen Touch Screen', 'HP', 'Computers', '469.0'),
  ('VGA Adapter for iPhones', 'Apple', 'Cables/Adapters', '48.94'),
  ('Ceiling-Mount Swivel', 'Power Acoustik', 'Overhead Video', '173.74'),
  ('1080p Dash Camera', 'GEKO', 'Dash Cameras', '61.53'),
  ('Phono Preamplifier', 'Pyle', 'Video Accessories', '22.99'),
  ('4K UHD TV with HDR', 'Sony', 'TV', '3099.52');

-- *** 500x SupplerDevice***
INSERT INTO SupplierDevice
  ([SupplierId],[DeviceId],[PurchasePrice])
VALUES(36, 36, '0,101'),
  (59, 27, '0,413'),
  (79, 10, '0,318'),
  (41, 18, '0,135'),
  (59, 35, '0,638'),
  (11, 30, '0,294'),
  (52, 33, '0,560'),
  (26, 28, '0,060'),
  (92, 33, '0,266'),
  (34, 24, '0,222'),
  (18, 27, '0,502'),
  (27, 35, '0,387'),
  (95, 25, '0,564'),
  (73, 1, '0,715'),
  (96, 17, '0,251'),
  (98, 40, '0,248'),
  (46, 10, '0,260'),
  (87, 10, '0,346'),
  (24, 31, '0,647'),
  (73, 31, '0,256'),
  (67, 23, '0,413'),
  (96, 11, '0,146'),
  (94, 35, '0,487'),
  (32, 9, '0,631'),
  (71, 39, '0,686'),
  (36, 35, '0,760'),
  (80, 34, '0,719'),
  (78, 6, '0,528'),
  (63, 9, '0,746'),
  (88, 39, '0,115'),
  (54, 10, '0,056'),
  (26, 20, '0,826'),
  (14, 6, '0,521'),
  (29, 16, '0,176'),
  (20, 26, '0,508'),
  (70, 23, '0,323'),
  (61, 13, '0,785'),
  (59, 9, '0,524'),
  (16, 3, '0,149'),
  (60, 26, '0,264'),
  (94, 36, '0,825'),
  (81, 34, '0,034'),
  (80, 21, '0,645'),
  (93, 36, '0,551'),
  (3, 21, '0,344'),
  (7, 29, '0,234'),
  (13, 31, '0,450'),
  (76, 38, '0,276'),
  (36, 21, '0,324'),
  (22, 14, '0,317'),
  (2, 21, '0,548'),
  (38, 12, '0,778'),
  (22, 13, '0,669'),
  (54, 26, '0,681'),
  (85, 24, '0,855'),
  (42, 32, '0,040'),
  (46, 25, '0,101'),
  (21, 26, '0,489'),
  (92, 29, '0,642'),
  (26, 34, '0,048'),
  (5, 31, '0,411'),
  (72, 19, '0,721'),
  (5, 17, '0,501'),
  (69, 3, '0,309'),
  (91, 27, '0,567'),
  (6, 27, '0,457'),
  (29, 29, '0,363'),
  (8, 14, '0,726'),
  (27, 18, '0,207'),
  (32, 36, '0,200'),
  (99, 39, '0,450'),
  (18, 36, '0,122'),
  (64, 31, '0,545'),
  (54, 8, '0,026'),
  (18, 22, '0,266'),
  (42, 4, '0,116'),
  (19, 11, '0,839'),
  (62, 27, '0,042'),
  (13, 30, '0,030'),
  (20, 24, '0,395'),
  (98, 6, '0,748'),
  (95, 31, '0,667'),
  (38, 40, '0,131'),
  (50, 22, '0,757'),
  (63, 9, '0,258'),
  (84, 22, '0,423'),
  (28, 14, '0,517'),
  (56, 13, '0,534'),
  (24, 24, '0,339'),
  (35, 26, '0,334'),
  (68, 38, '0,349'),
  (93, 19, '0,045'),
  (96, 9, '0,209'),
  (43, 36, '0,497'),
  (34, 40, '0,172'),
  (27, 2, '0,255'),
  (72, 40, '0,848'),
  (86, 28, '0,092'),
  (36, 13, '0,619'),
  (54, 8, '0,210');

-- *** 100x SupplerDevice***
INSERT INTO SupplierDevice
  ([SupplierId],[DeviceId],[PurchasePrice])
VALUES(50, 9, '0,261'),
  (74, 7, '0,696'),
  (54, 25, '0,327'),
  (47, 1, '0,224'),
  (39, 2, '0,028'),
  (46, 28, '0,405'),
  (20, 8, '0,253'),
  (58, 20, '0,377'),
  (56, 13, '0,517'),
  (22, 7, '0,023'),
  (88, 38, '0,581'),
  (40, 20, '0,261'),
  (70, 40, '0,435'),
  (47, 23, '0,767'),
  (42, 35, '0,149'),
  (93, 39, '0,607'),
  (35, 31, '0,113'),
  (22, 26, '0,418'),
  (2, 6, '0,417'),
  (54, 15, '0,488'),
  (21, 18, '0,723'),
  (12, 29, '0,149'),
  (50, 16, '0,405'),
  (34, 28, '0,117'),
  (69, 10, '0,313'),
  (11, 34, '0,489'),
  (50, 26, '0,487'),
  (57, 1, '0,846'),
  (94, 15, '0,076'),
  (28, 24, '0,405'),
  (12, 26, '0,045'),
  (10, 11, '0,500'),
  (6, 5, '0,702'),
  (68, 28, '0,540'),
  (70, 25, '0,565'),
  (24, 31, '0,725'),
  (8, 24, '0,678'),
  (71, 9, '0,684'),
  (99, 16, '0,167'),
  (100, 21, '0,785'),
  (15, 17, '0,178'),
  (38, 40, '0,237'),
  (23, 18, '0,127'),
  (67, 16, '0,599'),
  (63, 36, '0,430'),
  (78, 18, '0,164'),
  (14, 5, '0,397'),
  (46, 3, '0,664'),
  (30, 14, '0,853'),
  (8, 23, '0,877'),
  (71, 26, '0,042'),
  (12, 18, '0,872'),
  (52, 28, '0,709'),
  (14, 15, '0,474'),
  (82, 19, '0,807'),
  (6, 38, '0,848'),
  (34, 33, '0,351'),
  (91, 39, '0,672'),
  (51, 21, '0,533'),
  (78, 20, '0,872'),
  (59, 25, '0,620'),
  (12, 2, '0,672'),
  (10, 21, '0,756'),
  (37, 26, '0,737'),
  (43, 17, '0,638'),
  (9, 18, '0,328'),
  (98, 18, '0,474'),
  (3, 30, '0,371'),
  (30, 39, '0,190'),
  (68, 10, '0,349'),
  (17, 15, '0,810'),
  (46, 30, '0,101'),
  (54, 3, '0,413'),
  (83, 30, '0,064'),
  (100, 25, '0,495'),
  (93, 10, '0,380'),
  (18, 32, '0,730'),
  (52, 4, '0,145'),
  (62, 34, '0,551'),
  (35, 6, '0,118'),
  (4, 39, '0,729'),
  (22, 25, '0,695'),
  (52, 37, '0,401'),
  (34, 8, '0,267'),
  (60, 29, '0,635'),
  (2, 8, '0,409'),
  (57, 16, '0,201'),
  (50, 27, '0,377'),
  (88, 24, '0,315'),
  (99, 16, '0,699'),
  (29, 3, '0,346'),
  (28, 33, '0,381'),
  (74, 17, '0,723'),
  (73, 19, '0,242'),
  (42, 22, '0,643'),
  (42, 28, '0,134'),
  (52, 3, '0,042'),
  (66, 12, '0,495'),
  (17, 10, '0,852'),
  (65, 20, '0,091');

INSERT INTO SupplierDevice
  ([SupplierId],[DeviceId],[PurchasePrice])
VALUES(2, 2, '0,837'),
  (14, 2, '0,504'),
  (83, 29, '0,396'),
  (81, 8, '0,776'),
  (44, 40, '0,826'),
  (25, 35, '0,246'),
  (1, 39, '0,695'),
  (38, 31, '0,454'),
  (77, 18, '0,717'),
  (59, 39, '0,115'),
  (89, 11, '0,154'),
  (52, 37, '0,306'),
  (81, 15, '0,249'),
  (58, 30, '0,225'),
  (26, 32, '0,224'),
  (2, 22, '0,526'),
  (43, 15, '0,235'),
  (49, 20, '0,103'),
  (71, 37, '0,733'),
  (46, 38, '0,357'),
  (58, 12, '0,662'),
  (24, 35, '0,433'),
  (9, 22, '0,621'),
  (16, 39, '0,429'),
  (77, 1, '0,222'),
  (7, 33, '0,651'),
  (82, 22, '0,218'),
  (22, 19, '0,218'),
  (68, 10, '0,880'),
  (76, 32, '0,770'),
  (36, 34, '0,448'),
  (60, 16, '0,178'),
  (20, 33, '0,799'),
  (75, 35, '0,448'),
  (9, 34, '0,167'),
  (100, 23, '0,234'),
  (3, 21, '0,293'),
  (29, 23, '0,716'),
  (70, 1, '0,677'),
  (17, 39, '0,166'),
  (67, 20, '0,249'),
  (57, 13, '0,228'),
  (54, 10, '0,503'),
  (56, 13, '0,192'),
  (95, 37, '0,248'),
  (4, 36, '0,441'),
  (28, 24, '0,216'),
  (61, 24, '0,223'),
  (13, 2, '0,164'),
  (67, 39, '0,772'),
  (44, 11, '0,249'),
  (41, 10, '0,050'),
  (42, 20, '0,821'),
  (65, 39, '0,552'),
  (58, 7, '0,364'),
  (58, 33, '0,379'),
  (68, 23, '0,868'),
  (15, 31, '0,781'),
  (18, 7, '0,542'),
  (24, 40, '0,792'),
  (98, 28, '0,849'),
  (43, 26, '0,193'),
  (26, 27, '0,827'),
  (13, 31, '0,273'),
  (100, 2, '0,389'),
  (2, 23, '0,631'),
  (81, 25, '0,555'),
  (82, 37, '0,180'),
  (53, 14, '0,425'),
  (86, 37, '0,808'),
  (53, 37, '0,483'),
  (8, 27, '0,797'),
  (85, 3, '0,643'),
  (27, 4, '0,286'),
  (97, 10, '0,761'),
  (5, 7, '0,716'),
  (78, 33, '0,602'),
  (84, 14, '0,087'),
  (42, 7, '0,284'),
  (48, 25, '0,399'),
  (80, 9, '0,676'),
  (53, 22, '0,069'),
  (66, 7, '0,334'),
  (84, 24, '0,806'),
  (45, 12, '0,773'),
  (25, 16, '0,802'),
  (87, 40, '0,380'),
  (93, 37, '0,454'),
  (14, 32, '0,704'),
  (32, 13, '0,703'),
  (98, 33, '0,501'),
  (42, 22, '0,202'),
  (89, 8, '0,814'),
  (45, 16, '0,685'),
  (17, 12, '0,542'),
  (29, 28, '0,328'),
  (70, 8, '0,319'),
  (97, 13, '0,382'),
  (53, 38, '0,327'),
  (22, 28, '0,311');

INSERT INTO SupplierDevice
  ([SupplierId],[DeviceId],[PurchasePrice])
VALUES(45, 35, '0,525'),
  (23, 20, '0,281'),
  (91, 33, '0,275'),
  (53, 10, '0,766'),
  (67, 6, '0,634'),
  (37, 34, '0,088'),
  (38, 35, '0,567'),
  (37, 25, '0,253'),
  (59, 25, '0,659'),
  (75, 13, '0,383'),
  (62, 35, '0,732'),
  (93, 10, '0,410'),
  (69, 37, '0,141'),
  (30, 36, '0,427'),
  (67, 28, '0,538'),
  (9, 20, '0,293'),
  (53, 13, '0,110'),
  (13, 34, '0,631'),
  (23, 8, '0,107'),
  (55, 17, '0,266'),
  (44, 3, '0,315'),
  (60, 7, '0,591'),
  (32, 24, '0,459'),
  (27, 39, '0,145'),
  (92, 6, '0,258'),
  (66, 2, '0,744'),
  (90, 34, '0,175'),
  (7, 40, '0,220'),
  (28, 28, '0,090'),
  (6, 2, '0,852'),
  (16, 7, '0,499'),
  (47, 22, '0,329'),
  (64, 18, '0,747'),
  (50, 6, '0,880'),
  (41, 10, '0,662'),
  (24, 9, '0,293'),
  (70, 35, '0,138'),
  (43, 8, '0,411'),
  (16, 10, '0,566'),
  (52, 29, '0,235'),
  (67, 8, '0,051'),
  (48, 1, '0,582'),
  (80, 3, '0,379'),
  (84, 7, '0,443'),
  (89, 12, '0,834'),
  (97, 2, '0,491'),
  (18, 33, '0,859'),
  (37, 16, '0,852'),
  (47, 15, '0,512'),
  (75, 7, '0,417'),
  (50, 34, '0,366'),
  (3, 32, '0,508'),
  (11, 17, '0,605'),
  (61, 6, '0,355'),
  (86, 11, '0,555'),
  (31, 5, '0,521'),
  (17, 25, '0,550'),
  (81, 25, '0,510'),
  (37, 19, '0,086'),
  (7, 9, '0,183'),
  (76, 15, '0,576'),
  (86, 9, '0,318'),
  (6, 31, '0,547'),
  (66, 25, '0,857'),
  (13, 25, '0,797'),
  (46, 35, '0,247'),
  (99, 39, '0,339'),
  (51, 13, '0,181'),
  (97, 38, '0,441'),
  (87, 19, '0,396'),
  (31, 35, '0,792'),
  (25, 34, '0,350'),
  (17, 19, '0,786'),
  (25, 22, '0,374'),
  (20, 19, '0,023'),
  (56, 38, '0,690'),
  (37, 4, '0,844'),
  (60, 22, '0,168'),
  (12, 21, '0,727'),
  (6, 10, '0,053'),
  (87, 36, '0,187'),
  (42, 35, '0,074'),
  (73, 20, '0,828'),
  (92, 20, '0,500'),
  (8, 8, '0,755'),
  (26, 15, '0,868'),
  (22, 9, '0,727'),
  (30, 16, '0,364'),
  (68, 16, '0,157'),
  (47, 12, '0,302'),
  (14, 38, '0,247'),
  (13, 31, '0,769'),
  (56, 12, '0,183'),
  (95, 6, '0,556'),
  (60, 17, '0,138'),
  (90, 20, '0,121'),
  (86, 23, '0,132'),
  (26, 5, '0,758'),
  (35, 17, '0,821'),
  (25, 22, '0,331');

INSERT INTO SupplierDevice
  ([SupplierId],[DeviceId],[PurchasePrice])
VALUES(12, 3, '0,023'),
  (78, 13, '0,098'),
  (91, 14, '0,525'),
  (52, 36, '0,624'),
  (37, 30, '0,473'),
  (19, 1, '0,631'),
  (89, 39, '0,742'),
  (1, 4, '0,443'),
  (41, 2, '0,657'),
  (20, 17, '0,161'),
  (81, 38, '0,799'),
  (34, 33, '0,362'),
  (58, 29, '0,140'),
  (56, 28, '0,421'),
  (19, 25, '0,260'),
  (76, 39, '0,599'),
  (73, 7, '0,295'),
  (24, 19, '0,696'),
  (6, 34, '0,779'),
  (26, 32, '0,502'),
  (39, 7, '0,446'),
  (78, 2, '0,801'),
  (78, 37, '0,122'),
  (86, 6, '0,127'),
  (31, 9, '0,047'),
  (28, 5, '0,237'),
  (10, 26, '0,789'),
  (75, 7, '0,406'),
  (54, 3, '0,665'),
  (56, 1, '0,148'),
  (18, 26, '0,624'),
  (2, 10, '0,280'),
  (6, 12, '0,413'),
  (63, 19, '0,115'),
  (20, 31, '0,185'),
  (44, 4, '0,353'),
  (68, 27, '0,069'),
  (94, 19, '0,693'),
  (90, 22, '0,414'),
  (98, 36, '0,425'),
  (1, 34, '0,880'),
  (39, 37, '0,489'),
  (45, 13, '0,785'),
  (53, 35, '0,395'),
  (70, 36, '0,768'),
  (48, 24, '0,131'),
  (54, 33, '0,286'),
  (45, 4, '0,365'),
  (25, 15, '0,823'),
  (7, 11, '0,793'),
  (51, 31, '0,617'),
  (95, 32, '0,234'),
  (6, 36, '0,021'),
  (46, 39, '0,312'),
  (45, 10, '0,120'),
  (81, 9, '0,128'),
  (11, 39, '0,839'),
  (62, 17, '0,279'),
  (96, 16, '0,269'),
  (94, 15, '0,510'),
  (63, 22, '0,093'),
  (39, 14, '0,364'),
  (13, 10, '0,860'),
  (58, 30, '0,598'),
  (1, 21, '0,621'),
  (80, 26, '0,392'),
  (26, 2, '0,053'),
  (70, 24, '0,276'),
  (57, 34, '0,722'),
  (50, 22, '0,584'),
  (9, 4, '0,092'),
  (15, 23, '0,355'),
  (99, 36, '0,210'),
  (26, 32, '0,093'),
  (20, 17, '0,480'),
  (39, 17, '0,510'),
  (83, 11, '0,332'),
  (36, 21, '0,299'),
  (22, 15, '0,536'),
  (56, 15, '0,593'),
  (21, 24, '0,690'),
  (25, 37, '0,635'),
  (32, 23, '0,044'),
  (25, 7, '0,653'),
  (63, 27, '0,558'),
  (10, 7, '0,647'),
  (26, 6, '0,097'),
  (80, 25, '0,099'),
  (87, 32, '0,390'),
  (69, 32, '0,154'),
  (48, 34, '0,237'),
  (90, 6, '0,167'),
  (87, 4, '0,636'),
  (63, 4, '0,525'),
  (84, 39, '0,743'),
  (16, 35, '0,612'),
  (72, 35, '0,165'),
  (47, 35, '0,209'),
  (25, 8, '0,760'),
  (75, 38, '0,115');


-- *** 500x Location***
INSERT INTO Location
  ([Street],[City],[Region],[ZipCode],[Country])
VALUES('Ap #360-7830 Enim, Street', 'A Coru�a', 'GA', '45-992', 'Tunisia'),
  ('Ap #967-4279 Sed Av.', 'Issy-les-Moulineaux', 'IL', '32063-077', 'Korea, South'),
  ('315-4959 Urna. Rd.', 'Barranquilla', 'ATL', '17972', 'Cambodia'),
  ('124-1565 Phasellus Av.', 'Minna', 'NI', '2940', 'Peru'),
  ('P.O. Box 597, 7110 Velit St.', 'Butte', 'MT', '55131', 'Saint Lucia'),
  ('741-1432 Blandit Ave', 'Mogi das Cruzes', 'S�o Paulo', '20423', 'Pitcairn Islands'),
  ('318-7476 Egestas St.', 'Kharan', 'Balochistan', '134471', 'Bulgaria'),
  ('7543 Malesuada Rd.', 'Sciacca', 'Sicilia', '69487', 'Qatar'),
  ('4357 Sit Ave', 'Istanbul', 'Ist', '988510', 'Italy'),
  ('Ap #249-3064 Eu Ave', 'Sicuani', 'Cusco', '48-809', 'Gabon'),
  ('P.O. Box 263, 3736 In Rd.', 'Proddatur', 'AP', '3512', 'Taiwan'),
  ('3943 Elementum Rd.', 'Bhuj', 'GJ', 'Z2311', 'Cura�ao'),
  ('P.O. Box 524, 2574 Mollis Avenue', 'Alphen aan den Rijn', 'Z.', '132085', 'Thailand'),
  ('Ap #463-1905 Tempor St.', 'Clovenfords', 'SE', '4127 DD', 'Malawi'),
  ('5398 Ut Av.', 'Snezhinsk', 'Chelyabinsk Oblast', '79956', 'Lebanon'),
  ('Ap #287-3862 Convallis Rd.', 'New Westminster', 'BC', '6903', 'Zambia'),
  ('P.O. Box 565, 3022 Fusce St.', 'Barranca', 'Puntarenas', '527821', 'Cambodia'),
  ('P.O. Box 277, 8528 Vitae, Av.', 'Mexico City', 'CDM', '21815', 'Kiribati'),
  ('P.O. Box 768, 6486 Nonummy Rd.', 'Annapolis County', 'Nova Scotia', '800925', 'United Arab Emirates'),
  ('3368 Nec St.', 'Liverpool', 'New South Wales', '99626', 'Martinique'),
  ('7404 In Rd.', 'Workington', 'Cumberland', '45073', 'Kiribati'),
  ('296-7655 Eget St.', 'Vienna', 'Vienna', '70065-86858', 'Dominica'),
  ('Ap #128-1498 Et Road', 'Wagga Wagga', 'New South Wales', '54218', 'Lesotho'),
  ('P.O. Box 699, 2774 Aliquet, Street', 'Colina', 'Metropolitana de Santiago', 'LV5 9DH', 'Palestine, State of'),
  ('104-6701 Magna. Rd.', 'Gojal Upper Hunza', 'GB', '89911', 'Sudan'),
  ('441-1225 Auctor Ave', 'Caucaia', 'Cear�', '8208', 'Indonesia'),
  ('P.O. Box 357, 5648 Velit St.', 'Motueka', 'SI', '6625 BG', 'Mauritius'),
  ('822-4289 Ullamcorper Rd.', 'Morrinsville', 'North Island', '721266', 'Mongolia'),
  ('Ap #170-5617 Donec St.', 'Tasikmalaya', 'West Java', '6172 ES', 'Christmas Island'),
  ('Ap #671-3855 Scelerisque Av.', 'Tver', 'TVE', '99570', 'Bouvet Island'),
  ('426-1833 Sit St.', 'Whitchurch-Stouffville', 'ON', '59468', 'Solomon Islands'),
  ('P.O. Box 545, 3548 Dictum St.', 'Heerenveen', 'Fr', '34853', 'Liberia'),
  ('P.O. Box 320, 6426 In Av.', 'Gloucester', 'ON', '76019', 'Slovakia'),
  ('P.O. Box 679, 6686 Natoque Avenue', 'Oaxaca', 'Oax', '47086', 'Saint Lucia'),
  ('144-9936 Tortor Av.', 'Bolln�s', 'G�vleborgs l�n', '43408', 'Grenada'),
  ('Ap #288-7896 Orci. St.', 'Vienna', 'Wie', '449478', 'Eritrea'),
  ('P.O. Box 363, 8333 Suspendisse Rd.', 'Cartagena', 'BOL', '46821', 'Cape Verde'),
  ('685-5339 Massa. St.', '�kersberga', 'AB', 'I0 9HK', 'Bosnia and Herzegovina'),
  ('2255 Tristique Rd.', 'Marcq-en-Baroeul', 'NO', '09291', 'Jersey'),
  ('P.O. Box 321, 5374 Neque. Rd.', 'Istanbul', 'Istanbul', '352981', 'Antigua and Barbuda'),
  ('Ap #939-726 Nam Road', 'Lampa', 'Metropolitana de Santiago', '825260', 'Reunion'),
  ('172 Sit Av.', 'Renfrew', 'ON', '22536', 'Denmark'),
  ('P.O. Box 573, 1191 Sed Rd.', 'Radom', 'MA', '04185-352', 'Tokelau'),
  ('Ap #638-6220 Phasellus Rd.', 'Mobile', 'AL', '45825-06268', 'Tokelau'),
  ('313-6255 Parturient Rd.', 'Serefliko�hisar', 'Ank', '251390', 'Bolivia'),
  ('Ap #697-7257 Felis Street', 'Rionegro', 'ANT', '5263', 'South Georgia and The South Sandwich Islands'),
  ('8477 Eros. St.', 'Kirov', 'Kirov Oblast', '336671', 'Korea, South'),
  ('679-3752 Sagittis Rd.', 'Quill�n', 'Biob�o', '3592', 'Turkmenistan'),
  ('183-1213 Vel Av.', 'Warszawa', 'Mazowieckie', '664179', 'Ireland'),
  ('9068 Aliquam St.', 'Barranquilla', 'ATL', '23631-946', 'Djibouti'),
  ('Ap #400-3128 Montes, Ave', 'Makassar', 'SN', '71890', 'Dominican Republic'),
  ('119-6057 Et Rd.', 'Vienna', 'Vienna', '43199', 'Indonesia'),
  ('603-6834 Nonummy Av.', 'Gu�piles', 'L', '61934', 'Cuba'),
  ('Ap #950-6488 Hymenaeos. Road', 'Ryazan', 'Ryazan Oblast', '38304-493', 'Marshall Islands'),
  ('4906 Vitae St.', 'Kawerau', 'NI', '6404', 'Sweden'),
  ('2246 Nisl Ave', 'Mobile', 'Alabama', '71601', 'Niue'),
  ('Ap #718-2282 Nibh St.', 'Arequipa', 'Arequipa', '24404', 'Finland'),
  ('P.O. Box 311, 2355 Leo. Road', 'Huelva', 'Andaluc�a', '86563-92193', 'Pakistan'),
  ('283 Curae; Road', 'Wanganui', 'North Island', '93104', 'Gambia'),
  ('183-1977 Odio. Ave', 'Lagos', 'Lagos', '34179', 'Tuvalu'),
  ('Ap #649-5970 Enim. St.', 'Surrey', 'British Columbia', '18960', 'Timor-Leste'),
  ('Ap #718-4316 Amet St.', 'Te Puke', 'NI', '8429', 'Chad'),
  ('994-1806 Integer Rd.', 'Olsztyn', 'WM', '22062', 'Singapore'),
  ('Ap #967-7769 Dui, Rd.', 'Cabrero', 'VII', '21753', 'Zambia'),
  ('8121 Orci, Road', 'Norman', 'Oklahoma', 'Z0159', 'Samoa'),
  ('955-2046 A Street', 'Goi�nia', 'Goi�s', '492309', 'Argentina'),
  ('Ap #793-524 Dis Avenue', 'Hudiksvall', 'X', '84922', 'Greece'),
  ('P.O. Box 281, 7187 Ac Street', 'Chimbote', 'Ancash', '531504', 'Netherlands'),
  ('P.O. Box 103, 7203 Mauris, Rd.', 'Watford', 'HR', '449026', '�land Islands'),
  ('4549 Vulputate, Av.', 'Kingston', 'Ontario', 'K8T 0Y4', 'Samoa'),
  ('691 Mollis. Street', 'Cambridge', 'MA', '51555', 'French Guiana'),
  ('Ap #814-9930 A Street', 'Kemerovo', 'KEM', '54328', 'Sierra Leone'),
  ('7166 Nam St.', 'Chulucanas', 'Piura', '519739', 'Mongolia'),
  ('487-9146 Suspendisse Street', 'Bello', 'Antioquia', '7434', 'Niger'),
  ('926-4509 Iaculis, St.', 'Funtua', 'KT', 'ZO1 0VT', 'Taiwan'),
  ('Ap #708-2627 Odio. Avenue', 'Maranguape', 'Cear�', '1792', 'South Sudan'),
  ('391-5920 Cursus, Street', 'Moradabad', 'UP', '924794', 'Fiji'),
  ('6562 Nibh St.', 'San Francisco', 'H', '120325', 'Ireland'),
  ('3148 Cras Ave', 'Victoria', 'British Columbia', '771876', 'Iraq'),
  ('4332 Risus. Road', 'Paju', 'Gye', '2668 OC', 'Anguilla'),
  ('363-5668 Ornare Avenue', 'Sicuani', 'CUS', '69625', 'El Salvador'),
  ('8736 Sed, Rd.', 'Bogor', 'JB', '72745', 'Peru'),
  ('488-9270 Feugiat Av.', 'Tarn�w', 'MP', '83626', 'Palestine, State of'),
  ('4452 Enim St.', 'Ch�lons-en-Champagne', 'Champagne-Ardenne', '667936', 'Libya'),
  ('3927 Dignissim Street', 'Lampa', 'Metropolitana de Santiago', '15782', 'Brunei'),
  ('6892 Libero. Av.', 'Kirikhan', 'Hat', '92586-31978', 'Saint Barth�lemy'),
  ('Ap #279-3318 Sem, Avenue', 'Ludvika', 'W', '91367', 'Lithuania'),
  ('179-9889 Pulvinar St.', 'Soledad', 'Atl�ntico', '80050', 'Liberia'),
  ('1769 Nibh. Avenue', 'Bhakkar', 'Sindh', 'M4H 1V2', 'Panama'),
  ('P.O. Box 681, 5751 Mi Rd.', 'Istanbul', 'Ist', '70101', 'Tajikistan'),
  ('P.O. Box 317, 4614 Dictum. Road', 'San Diego', 'California', '28-974', 'Micronesia'),
  ('5546 A Avenue', 'Townsville', 'QLD', '801949', 'Azerbaijan'),
  ('873-5553 Ut Ave', 'Catacaos', 'Piura', 'Z5599', 'Equatorial Guinea'),
  ('7814 Sed Rd.', 'Orenburg', 'ORE', '200150', 'Rwanda'),
  ('965-3873 Aenean Avenue', 'Girona', 'CA', '63854', 'South Sudan'),
  ('P.O. Box 261, 7042 Diam Rd.', 'Cervinara', 'CAM', '455310', 'Eritrea'),
  ('2062 Penatibus St.', 'Barchi', 'MAR', '14355', 'Australia'),
  ('370-5281 Malesuada. St.', 'Istanbul', 'Ist', '0512 IM', 'Jersey'),
  ('3962 Egestas. Rd.', 'Morrinsville', 'NI', 'Z7159', 'United Kingdom (Great Britain)'),
  ('767-2830 Lobortis Avenue', 'Okene', 'KO', '441331', 'Reunion');

INSERT INTO Location
  ([Street],[City],[Region],[ZipCode],[Country])
VALUES('Ap #465-1591 Cursus. Av.', 'Rzesz�w', 'Podkarpackie', '7443', 'Latvia'),
  ('397-9462 Fermentum Avenue', 'Rostov', 'Rostov Oblast', '704306', 'Holy See (Vatican City State)'),
  ('Ap #580-7738 Ipsum Rd.', 'Konin', 'WP', '89256-61563', 'Sudan'),
  ('Ap #394-3087 Malesuada Ave', 'Palembang', 'SS', '32386', 'Swaziland'),
  ('936-1300 Amet Rd.', 'Tokoroa', 'NI', '1534 BU', 'Mongolia'),
  ('330-1074 Fusce Road', 'Berlin', 'BE', '09-545', 'Mayotte'),
  ('910-3977 Tempor Avenue', 'Fairbanks', 'Alaska', 'J44 0YQ', 'Gabon'),
  ('P.O. Box 577, 1777 Metus. St.', 'Puerto Vallarta', 'Jal', '23488-36078', 'Malta'),
  ('Ap #454-9536 Dictum Rd.', 'Orizaba', 'Ver', 'Z8782', 'Aruba'),
  ('7506 Sociis Road', 'Olathe', 'KS', '35214', 'New Zealand'),
  ('7980 Nulla Rd.', 'Semarang', 'JT', '4063', 'American Samoa'),
  ('P.O. Box 435, 4305 Proin Rd.', 'Brighton', 'Sussex', '53610', 'Myanmar'),
  ('P.O. Box 111, 7475 Massa. Ave', 'M�rsta', 'AB', 'Z0693', 'Bolivia'),
  ('P.O. Box 127, 9626 Justo St.', 'Cincinnati', 'OH', '4144', 'Taiwan'),
  ('Ap #420-3631 Dui. Rd.', 'Rawalpindi', 'Punjab', '56-873', 'Zambia'),
  ('336-1088 Lectus. Avenue', 'Mohmand Agency', 'FATA', '01356-887', 'Sweden'),
  ('Ap #970-5634 Donec Street', 'Rio de Janeiro', 'RJ', '424892', 'Thailand'),
  ('P.O. Box 575, 6823 Lacinia Av.', 'Morwell', 'VIC', 'MH1P 2XI', 'Mauritania'),
  ('3500 Faucibus Avenue', 'Vienna', 'Vienna', '9848', 'Russian Federation'),
  ('486-9503 Augue St.', 'Alness', 'Ross-shire', '459013', 'Nepal'),
  ('Ap #222-972 Lorem, Road', 'Overmere', 'OV', '19203', 'Cocos (Keeling) Islands'),
  ('1862 Sed St.', 'Vienna', 'Vienna', '90795-702', 'Cape Verde'),
  ('P.O. Box 779, 4975 Vel Ave', 'Izel', 'Luxemburg', '22076', 'Korea, North'),
  ('P.O. Box 992, 6724 Turpis St.', 'Sapele', 'Delta', 'S6Z 2W9', 'Estonia'),
  ('875-8628 Nibh. St.', 'Sobral', 'Cear�', 'R8T 4H0', 'Ireland'),
  ('P.O. Box 550, 240 Vitae, Avenue', 'Rouyn-Noranda', 'Quebec', '10017', 'Somalia'),
  ('400 Sed St.', 'Hamilton', 'VIC', '90208', 'China'),
  ('P.O. Box 570, 9048 Arcu. Rd.', 'Veere', 'Zl', 'Z5305', 'Tuvalu'),
  ('P.O. Box 524, 2836 Eget St.', 'N�mes', 'LA', '38741-02242', 'Montserrat'),
  ('Ap #615-5688 Donec St.', 'Hamburg', 'HH', '29946', 'France'),
  ('122-137 Mi St.', 'Halesowen', 'WO', '539654', 'Iceland'),
  ('152-9260 Accumsan Avenue', 'Vico nel Lazio', 'Lazio', '51775', 'Fiji'),
  ('466 Ultricies Av.', 'Quinchao', 'Los Lagos', '30551-79803', 'Aruba'),
  ('Ap #326-6591 Egestas. St.', 'Crescentino', 'Piemonte', '5750', 'Belgium'),
  ('200-6537 Volutpat. Rd.', 'Voronezh', 'Voronezh Oblast', 'C1Y 7Y5', 'Nicaragua'),
  ('7284 Id Rd.', 'Talara', 'PIU', '02337-099', 'Romania'),
  ('P.O. Box 715, 9023 Pharetra. Avenue', 'Whittlesey', 'Cambridgeshire', '467767', 'Brunei'),
  ('395-9957 Aliquam Avenue', 'Parla', 'MA', '1826', 'Sao Tome and Principe'),
  ('2314 Massa Road', 'Curitiba', 'PR', '86311-111', 'Iran'),
  ('Ap #995-5247 Dui. Av.', 'Khuzdar', 'BL', '45503', 'Suriname'),
  ('786-3110 Tempor Road', 'Oosterhout', 'N.', '4999', 'Iraq'),
  ('Ap #370-2643 Cubilia St.', 'Vancouver', 'Washington', '24623', 'Australia'),
  ('6333 Sociis Road', 'Galway', 'Connacht', 'N4G 4T0', 'Azerbaijan'),
  ('Ap #181-744 Odio Ave', 'C�diz', 'AN', '81112', 'Jersey'),
  ('P.O. Box 675, 5307 Sodales St.', 'Zamora de Hidalgo', 'Mic', '1248', 'Brazil'),
  ('P.O. Box 897, 4148 Blandit Av.', 'Pittsburgh', 'PA', 'ES1 6WJ', 'Svalbard and Jan Mayen Islands'),
  ('P.O. Box 364, 8650 Semper St.', 'Huelva', 'Andaluc�a', '81503', 'Taiwan'),
  ('605 Ligula. Rd.', 'Notre-Dame-du-Nord', 'QC', '19820-567', 'Palestine, State of'),
  ('P.O. Box 292, 8092 Odio Street', 'Pincher Creek', 'Alberta', '3371', 'Kuwait'),
  ('6616 Ultrices Avenue', 'Cajamarca', 'Cajamarca', '06330', 'Dominican Republic'),
  ('773-6225 Massa. St.', 'Nicoya', 'Guanacaste', '1460', 'Suriname'),
  ('P.O. Box 561, 6997 Ultrices Rd.', 'Kerikeri', 'North Island', 'CO90 3AN', 'Maldives'),
  ('Ap #869-7489 Magnis Road', 'Okara', 'Sindh', 'B7H 9J6', 'Isle of Man'),
  ('Ap #344-8220 Mauris, Road', 'Pontianak', 'West Kalimantan', '06708', 'Finland'),
  ('6530 Consequat Ave', 'Weyburn', 'SK', '2841', 'Western Sahara'),
  ('917-1292 Commodo Avenue', 'Vienna', 'Vienna', 'Z1877', 'Swaziland'),
  ('P.O. Box 832, 1567 Nec Road', 'Cusco', 'CUS', '6659 MN', 'Central African Republic'),
  ('8989 Suspendisse Ave', 'Dadu', 'Punjab', '229944', 'Azerbaijan'),
  ('P.O. Box 242, 7611 Semper Road', 'Castelvetere in Val Fortore', 'CAM', '2560', 'Congo (Brazzaville)'),
  ('748-6559 Facilisis, Road', 'Llanwrtwd Wells', 'BR', '6869', 'Saint Helena, Ascension and Tristan da Cunha'),
  ('830-9800 Pharetra Rd.', 'San Rafael', 'A', '42929', 'Peru'),
  ('916-2353 Adipiscing Street', 'Katsina', 'KT', '62093', 'Serbia'),
  ('999-4263 Fringilla, Ave', 'Meppel', 'Drenthe', '79447-160', 'South Sudan'),
  ('5889 Dolor. St.', 'Villata', 'PIE', '217817', 'Canada'),
  ('605-1001 Turpis. St.', 'Sabadell', 'CA', '99183', 'Luxembourg'),
  ('767-7745 Gravida. Av.', 'Ulloa (Barrial)', 'Heredia', '15093', 'Equatorial Guinea'),
  ('441-5885 Est Road', 'Ivangorod', 'Leningrad Oblast', '37829', 'Bangladesh'),
  ('5574 Arcu Rd.', 'Waiuku', 'North Island', '15287', 'Uganda'),
  ('P.O. Box 735, 8975 Sed Rd.', 'Masone', 'Liguria', '77991', 'South Sudan'),
  ('803-8658 Urna. St.', 'Starachowice', 'Swietokrzyskie', '431432', 'Honduras'),
  ('277 Ipsum. Street', 'Sandy', 'UT', 'Z3711', 'Virgin Islands, British'),
  ('468-4660 Mattis St.', 'Curitiba', 'Paran�', '934300', 'Saint Lucia'),
  ('P.O. Box 345, 5001 Mattis Av.', 'Caprino Bergamasco', 'LOM', 'C0E 8Z3', 'China'),
  ('Ap #849-7433 Ac Street', 'Iquitos', 'Loreto', '57453', 'Croatia'),
  ('Ap #967-7377 In Rd.', 'Juazeiro do Norte', 'CE', '6324 RA', 'Mauritania'),
  ('203-5179 Sit Road', 'Sujawal', 'SI', '846869', 'Bonaire, Sint Eustatius and Saba'),
  ('236-1912 Pretium Road', 'Ulsan', 'South Gyeongsang', '50818', 'Saint Pierre and Miquelon'),
  ('803-1570 Sit Ave', 'Oaxaca', 'Oaxaca', '8094', 'San Marino'),
  ('Ap #679-5433 Turpis. Ave', 'Yurimaguas', 'Loreto', '79823', 'Congo (Brazzaville)'),
  ('4175 Donec Street', 'Diyarbakir', 'Diy', '936821', 'India'),
  ('953 Ut, St.', 'Vienna', 'Vienna', '341032', 'Serbia'),
  ('Ap #212-2135 Ipsum. St.', 'Port Harcourt', 'RI', '00833', 'Costa Rica'),
  ('2967 Molestie Av.', 'Namyangju', 'Gyeonggi', '1327', 'Saint Martin'),
  ('Ap #730-1967 Donec St.', 'South Bend', 'IN', '42023', 'Azerbaijan'),
  ('9908 Varius Street', 'Reus', 'CA', '89789', 'Palau'),
  ('633-2574 Consectetuer St.', 'Bozeman', 'MT', '76100-055', 'Guyana'),
  ('6189 Nisl. Avenue', 'Ribeir�o Preto', 'SP', '06672', 'Costa Rica'),
  ('392 Lacus. Ave', 'Waitakere', 'North Island', '37008', 'Mauritania'),
  ('Ap #511-3006 Molestie Street', 'Calera de Tango', 'RM', '1574 JL', 'Saint Pierre and Miquelon'),
  ('P.O. Box 247, 4936 Id St.', 'Lake Cowichan', 'British Columbia', '7287', 'Nauru'),
  ('130-5684 Aliquam Street', 'Cork', 'M', '14605', 'South Africa'),
  ('5967 Enim Avenue', 'Borno', 'LOM', '96166', 'United Arab Emirates'),
  ('Ap #521-8903 Sem St.', 'Dublin', 'L', '69262-958', 'Israel'),
  ('7196 Non Rd.', 'Paris', '�le-de-France', '60408', 'Grenada'),
  ('411-4260 Posuere St.', 'Charsadda', 'Khyber Pakhtoonkhwa', '30500', 'Turks and Caicos Islands'),
  ('Ap #843-7205 Volutpat. Rd.', 'Akron', 'OH', '436984', 'Mauritania'),
  ('P.O. Box 136, 4523 Lectus Av.', 'Mogi das Cruzes', 'S�o Paulo', '029565', 'Paraguay'),
  ('P.O. Box 955, 3348 Sit Rd.', 'Cessnock', 'New South Wales', '911692', 'Pitcairn Islands'),
  ('415-5959 Vestibulum Av.', 'Palma de Mallorca', 'BA', '3597', 'Malta'),
  ('P.O. Box 872, 7049 Consectetuer, St.', 'Vienna', 'Wie', '30846-176', 'Philippines');

INSERT INTO Location
  ([Street],[City],[Region],[ZipCode],[Country])
VALUES('P.O. Box 650, 8072 Lobortis Rd.', 'Bello', 'ANT', '27992', 'Sint Maarten'),
  ('Ap #763-3356 Ante Av.', 'Tarma', 'JUN', '18782', 'Niger'),
  ('P.O. Box 946, 3129 Suscipit, Rd.', 'Mau�', 'S�o Paulo', '79227', 'Qatar'),
  ('Ap #410-5987 Rhoncus. Avenue', 'Antakya', 'Hat', '853986', 'United States'),
  ('851-5350 Sed, Av.', 'Serang', 'BT', '10173', 'Isle of Man'),
  ('P.O. Box 919, 4467 Arcu. St.', 'Hamburg', 'HH', '610509', 'Malta'),
  ('P.O. Box 182, 1582 Mauris Rd.', 'Cairns', 'Queensland', 'V2P 9Y2', 'United Kingdom (Great Britain)'),
  ('336 Egestas. St.', 'Guadalupe', 'Nuevo Le�n', '64558', 'Laos'),
  ('Ap #653-5508 In Avenue', 'Nice', 'PR', '00997', 'Uruguay'),
  ('718-3006 Amet Street', 'Boise', 'ID', '20963', 'Liechtenstein'),
  ('947-5589 Eu Ave', 'Cuenca', 'Castilla - La Mancha', '01115', 'Myanmar'),
  ('Ap #293-3557 A, St.', 'Lithgow', 'New South Wales', '30327-45626', 'Namibia'),
  ('654 Orci. St.', 'Hamburg', 'Hamburg', '16022', 'Korea, South'),
  ('109-5306 Ullamcorper, Av.', 'Dublin', 'Leinster', '566820', 'Montserrat'),
  ('7650 Nam Avenue', 'Tire', 'Izmir', '65038', 'Saudi Arabia'),
  ('754-9228 Odio Av.', 'Sokoto', 'Sokoto', '26149', 'Singapore'),
  ('292-8497 Sit Avenue', 'Itag��', 'ANT', '21-074', 'Kuwait'),
  ('P.O. Box 477, 1855 Mi Ave', 'Alajuela', 'Alajuela', '09834', 'Antigua and Barbuda'),
  ('5057 Pede Street', 'Blue Mountains', 'NSW', '1831 NH', 'Svalbard and Jan Mayen Islands'),
  ('P.O. Box 331, 8946 Pede St.', 'Clovenfords', 'SE', '5472', 'Tajikistan'),
  ('247-9771 Nec Rd.', 'Tando Allahyar', 'PU', '1326 HL', 'Greece'),
  ('878-522 Non Av.', 'Ingolstadt', 'BY', '795587', 'Svalbard and Jan Mayen Islands'),
  ('Ap #979-5657 Mollis St.', 'Vienna', 'Vienna', '63956', 'Italy'),
  ('Ap #278-9445 Et, St.', 'Istanbul', 'Istanbul', '31914', 'San Marino'),
  ('P.O. Box 496, 189 Tincidunt St.', 'Kielce', 'SK', '5018', 'Cook Islands'),
  ('7375 Mauris Rd.', 'S�o Gon�alo', 'RJ', '28506-37575', 'Anguilla'),
  ('5882 Nunc St.', 'Kharabali', 'AST', '1226', 'Aruba'),
  ('4108 Egestas Rd.', 'Athens', 'Georgia', '2538', 'Turkey'),
  ('454-8018 Libero. Rd.', 'Saint-Malo', 'Bretagne', '632233', 'Jersey'),
  ('Ap #257-4754 Dui. Ave', 'Shangla', 'KPK', 'WP23 1ZP', 'Rwanda'),
  ('889-6522 Tempor Rd.', 'Galway', 'Connacht', '70512', 'Malta'),
  ('P.O. Box 297, 6962 Est Av.', 'Tanjung Pinang', 'KR', '256801', 'Malawi'),
  ('Ap #875-6133 Turpis Rd.', 'Medemblik', 'Noord Holland', '78105', 'Singapore'),
  ('419-5970 Vitae Road', 'Saguenay', 'Quebec', '48685-638', 'Portugal'),
  ('397 Scelerisque, Av.', 'Kurgan', 'Kurgan Oblast', '853912', 'Virgin Islands, United States'),
  ('P.O. Box 251, 6302 Tempor Av.', 'Puno', 'Puno', '095079', 'Chad'),
  ('358-9115 Pede St.', 'Puno', 'PUN', '80423', 'Trinidad and Tobago'),
  ('Ap #848-6264 Eget Street', 'Wuppertal', 'NW', '25137', 'Croatia'),
  ('Ap #258-3235 Ligula. St.', 'Bauchi', 'BA', '76422', 'Reunion'),
  ('P.O. Box 856, 7222 Mattis Ave', 'Dublin', 'L', '945012', 'Samoa'),
  ('8779 Elit, Street', 'Bihar Sharif', 'Bihar', '3341', 'Malaysia'),
  ('P.O. Box 610, 7945 Donec Ave', 'Sabanalarga', 'Atl�ntico', 'Z1668', 'Lesotho'),
  ('P.O. Box 261, 307 Parturient Road', 'Murree', 'Sindh', '156407', 'Hong Kong'),
  ('P.O. Box 684, 4803 Consequat Rd.', 'Torun', 'KP', '4450', 'Guam'),
  ('367-7080 Nec Rd.', 'G�tzis', 'Vorarlberg', '73443', 'Mexico'),
  ('283-6971 Aliquet St.', 'Soledad de Graciano S�nchez', 'S.L', '60016', 'Iraq'),
  ('315-6677 Risus Rd.', 'Mj�lby', 'E', '61969', 'Nicaragua'),
  ('7834 Nec Rd.', 'Colomiers', 'Midi-Pyr�n�es', '2256 IG', 'Holy See (Vatican City State)'),
  ('631-1283 Libero Avenue', 'Vetlanda', 'J�nk�pings l�n', '665632', 'Bouvet Island'),
  ('5055 Tempor St.', 'Berlin', 'Berlin', '1562 JW', 'Cape Verde'),
  ('Ap #676-7968 Adipiscing St.', 'Bandung', 'JB', '844737', 'Guernsey'),
  ('662-8811 Augue Rd.', 'Ozyorsk', 'Chelyabinsk Oblast', 'Z7799', 'Ethiopia'),
  ('P.O. Box 546, 292 Nam Street', 'Jette', 'Brussels Hoofdstedelijk Gewest', '62-431', 'Jordan'),
  ('Ap #900-4946 Dui Road', 'Muzaffarpur', 'Bihar', '42722', 'Suriname'),
  ('9622 Aliquam Rd.', 'Middelburg', 'Zl', 'T6H 2T5', '�land Islands'),
  ('Ap #752-715 Mi Street', 'San Felipe', 'V', '474071', 'Northern Mariana Islands'),
  ('672-8489 Elit St.', 'Missoula', 'MT', '56903', 'Antigua and Barbuda'),
  ('6658 Tincidunt Av.', 'Washuk', 'Balochistan', '18560', 'South Africa'),
  ('P.O. Box 576, 6737 Sapien, St.', 'Oaxaca', 'Oaxaca', '21018', 'Azerbaijan'),
  ('891-7322 Mi St.', 'Whitchurch-Stouffville', 'ON', '11808', 'Palestine, State of'),
  ('7604 Dolor Ave', 'Daly', 'Manitoba', '9737', 'China'),
  ('607-1625 Vitae Road', 'Lawton', 'OK', 'QW0 0TN', 'Turkmenistan'),
  ('8638 Eros Ave', 'Ivanovo', 'Ivanovo Oblast', '2729', 'Guernsey'),
  ('351-9807 Quis Street', 'Bydgoszcz', 'KP', '25484', 'Korea, North'),
  ('P.O. Box 335, 9132 Ultrices. Avenue', 'Uddevalla', 'O', '806523', 'Uruguay'),
  ('7256 Sapien St.', 'San Vicente de Ca�ete', 'Lima', '21240', 'Mozambique'),
  ('270-3197 Ipsum. Ave', 'Vienna', 'Vienna', '70154-727', 'Libya'),
  ('Ap #365-6769 Ut Rd.', 'Mexico City', 'Mexico City', '098654', 'Sierra Leone'),
  ('P.O. Box 594, 8844 Lobortis Av.', 'Gdansk', 'Pomorskie', 'E9B 5C7', 'Christmas Island'),
  ('P.O. Box 732, 850 Pellentesque Rd.', 'Dallas', 'TX', '3349', 'Brunei'),
  ('6942 Et St.', 'Novosibirsk', 'Novosibirsk Oblast', '9394', 'Poland'),
  ('5052 Amet, Street', 'Townsville', 'Queensland', '02361-927', 'Uruguay'),
  ('P.O. Box 343, 5610 Sagittis Street', 'Montb�liard', 'Franche-Comt�', 'N65 4UZ', 'Bonaire, Sint Eustatius and Saba'),
  ('387-3731 Eu, Rd.', 'Metro', 'Lampung', '0258 NN', 'Moldova'),
  ('Ap #456-1884 Proin Avenue', 'Uijeongbu', 'Gyeonggi', 'J6J 5M3', 'Peru'),
  ('383-3063 Vehicula. Ave', 'Vehari', 'Punjab', '75430', 'Moldova'),
  ('Ap #183-7366 Orci Avenue', 'Hilversum', 'Noord Holland', '15000', 'Fiji'),
  ('839-7500 Arcu. Av.', 'Latinne', 'Luik', '18498-559', 'Montenegro'),
  ('239-7433 Vel St.', 'Den Helder', 'N.', '8276', 'Lebanon'),
  ('Ap #766-8621 Arcu. St.', 'Tire', 'Izm', '71700', 'Laos'),
  ('Ap #820-9887 Nulla. Road', 'Moe', 'VIC', '903730', 'Azerbaijan'),
  ('Ap #754-4814 Fermentum St.', 'Canberra', 'Australian Capital Territory', '9115', 'Nauru'),
  ('Ap #326-9521 Ligula Ave', 'Samarinda', 'East Kalimantan', '283538', 'French Southern Territories'),
  ('P.O. Box 741, 1641 Enim St.', 'Dublin', 'Leinster', '2185', 'Cocos (Keeling) Islands'),
  ('P.O. Box 297, 2846 Curabitur Rd.', 'Stewart', 'BC', '83491-832', 'Croatia'),
  ('205-7909 Vel Rd.', 'Dunedin', 'SI', '555479', 'Slovakia'),
  ('671-7333 Curae; St.', 'Voronezh', 'Voronezh Oblast', '02457', 'Mongolia'),
  ('P.O. Box 617, 4661 Nullam Rd.', 'Galway', 'Connacht', '642009', 'Taiwan'),
  ('371-3725 Tempus Street', 'Ziarat', 'BL', '905510', 'Guam'),
  ('Ap #269-2275 Id, Avenue', 'Burlington', 'Vermont', '5555', 'Heard Island and Mcdonald Islands'),
  ('P.O. Box 867, 5811 Lobortis, Avenue', 'Swan Hill', 'VIC', '52305', 'Ghana'),
  ('6794 Nulla St.', 'Zaanstad', 'N.', '9847', 'Ukraine'),
  ('Ap #476-1357 Elit. Road', 'Avennes', 'LU', 'Z7373', 'Dominican Republic'),
  ('9351 Donec Av.', 'Sahiwal', 'Punjab', '88365', 'Algeria'),
  ('6018 Id, Av.', 'Shigar', 'GB', '3911', 'Sweden'),
  ('7181 Dolor Av.', 'Ichalkaranji', 'Maharastra', '20449', 'Bonaire, Sint Eustatius and Saba'),
  ('5165 A, Street', 'Belmont', 'WA', 'H6M 3L6', 'Bolivia'),
  ('5288 Commodo Road', 'Didim', 'Ayd', '363425', 'Fiji'),
  ('777-2312 Molestie Ave', 'Palma de Mallorca', 'Illes Balears', 'X2S 6W1', 'Austria'),
  ('7320 Non Street', 'Ananindeua', 'PA', '311933', 'Kuwait');

INSERT INTO Location
  ([Street],[City],[Region],[ZipCode],[Country])
VALUES('8101 Congue. Av.', 'Sicuani', 'Cusco', '42398', 'Singapore'),
  ('254-1723 Lectus Ave', 'Zamora de Hidalgo', 'Mic', '214463', 'United States Minor Outlying Islands'),
  ('Ap #939-540 Nibh St.', 'Yangju', 'Gyeonggi', 'B0 8HO', 'Malaysia'),
  ('103 Nulla St.', 'Port Harcourt', 'RI', '66198', 'Nigeria'),
  ('Ap #189-1125 Ipsum St.', 'Damoh', 'MP', '75448', 'Morocco'),
  ('Ap #595-5176 Eget Rd.', 'Hwaseong', 'Gyeonggi', '83215', 'Guinea'),
  ('1619 Non Rd.', 'Belfast', 'Ulster', '377564', 'Afghanistan'),
  ('928-3088 Augue Rd.', 'Legnica', 'Dolnoslaskie', '82613', 'Barbados'),
  ('8968 Cras St.', 'Muzzafarabad', 'AK', '59608', 'Niger'),
  ('9007 Vitae St.', 'Uberl�ndia', 'Minas Gerais', '519633', 'Montserrat'),
  ('P.O. Box 172, 4591 Phasellus Rd.', 'Miryang', 'South Gyeongsang', '92588-77477', 'United States'),
  ('5060 Maecenas Avenue', 'Waiheke Island', 'NI', '86740', 'Guam'),
  ('3075 Lectus St.', 'Brisbane', 'QLD', '712134', 'Guyana'),
  ('9491 Ut Ave', 'Rostov', 'ROS', '5114', 'Turkey'),
  ('648-7360 Etiam St.', 'Oxford County', 'ON', '81388', 'Trinidad and Tobago'),
  ('P.O. Box 311, 3912 Viverra. Rd.', 'Keith', 'BA', '890376', 'Bouvet Island'),
  ('1401 Aliquam Street', 'Catacaos', 'PIU', '05256', 'Iran'),
  ('Ap #352-334 Ligula. Street', 'Warszawa', 'Mazowieckie', '8296', 'Cura�ao'),
  ('969-4551 Justo. Av.', 'Bama', 'Borno', '03214', 'Saint Vincent and The Grenadines'),
  ('Ap #114-9381 Erat Street', 'San Rafael Abajo', 'San Jos�', '29078', 'Costa Rica'),
  ('958 Leo. Rd.', 'Antakya', 'Hatay', '7852', 'Palau'),
  ('Ap #230-9303 A Avenue', 'Rio Grande', 'RS', '80-063', 'Virgin Islands, United States'),
  ('854-4851 Vitae, Avenue', 'Jakarta', 'JK', '74499', 'Thailand'),
  ('Ap #883-2311 Sed St.', 'Sherani', 'Balochistan', '54954-32801', 'Saint Pierre and Miquelon'),
  ('306-6879 Dignissim Av.', 'Little Rock', 'AR', '5160', 'Tanzania'),
  ('4424 Ultrices Street', 'Hamburg', 'HH', '272843', 'Wallis and Futuna'),
  ('Ap #255-8046 Ac Ave', 'Tacoma', 'Washington', '200116', 'Nauru'),
  ('P.O. Box 665, 9984 Dui Ave', 'Bekkerzeel', 'Vlaams-Brabant', 'TW5 2WA', 'Turks and Caicos Islands'),
  ('Ap #109-7241 Primis Rd.', 'Anamur', 'Mer', '6469', 'Botswana'),
  ('202-8381 Sem St.', 'Notre-Dame-du-Nord', 'Quebec', '26558-275', 'Switzerland'),
  ('P.O. Box 744, 7758 Luctus St.', 'Brandon', 'MB', '54690', 'Belize'),
  ('300-5540 Magna St.', 'Hulst', 'Zeeland', '95898', 'Cape Verde'),
  ('P.O. Box 122, 831 Malesuada Av.', 'Mastung', 'Balochistan', '78-937', 'Venezuela'),
  ('881-7001 In, St.', 'Kemerovo', 'Kemerovo Oblast', 'B4Q 6XC', 'South Africa'),
  ('Ap #909-2600 Libero St.', 'Steendorp', 'OV', '17222', 'Malta'),
  ('393-9533 Quam. Rd.', 'Dutse', 'JI', '24262', 'Tajikistan'),
  ('Ap #696-1444 Sit Street', 'Etobicoke', 'Ontario', '54911-852', 'Iraq'),
  ('P.O. Box 850, 8482 Adipiscing Rd.', 'Brecon', 'Brecknockshire', '09260', 'Nigeria'),
  ('3830 Sem Street', 'Fraser-Fort George', 'BC', 'Z3765', 'United States'),
  ('Ap #977-3015 Cursus Road', 'Veere', 'Zeeland', '11766-465', 'Mongolia'),
  ('Ap #198-823 Enim Street', 'Sabanalarga', 'ATL', '24365-746', 'United Kingdom (Great Britain)'),
  ('7760 Egestas Street', 'Picton', 'South Island', '4270 ZJ', 'Uruguay'),
  ('580-7159 Libero. St.', 'Wanneroo', 'WA', 'Z8409', 'Italy'),
  ('3086 Ligula Street', 'College', 'Alaska', '36213', 'Cameroon'),
  ('P.O. Box 984, 8297 Arcu Street', 'Jalgaon', 'Maharastra', '23631', 'Montserrat'),
  ('P.O. Box 261, 5719 Primis Av.', 'Saint Petersburg', 'Sai', '68127', 'Guinea'),
  ('P.O. Box 338, 3280 Amet Road', 'Bunbury', 'Western Australia', '8277', 'Serbia'),
  ('Ap #899-7314 Cras Ave', 'Gyeongju', 'Gye', '60119', 'Monaco'),
  ('393-785 Volutpat. Ave', 'Shepparton', 'Victoria', '443867', 'Sint Maarten'),
  ('Ap #811-8561 Purus Av.', 'Honolulu', 'Hawaii', '32724-579', 'Uganda'),
  ('6696 Dolor Ave', 'Te Awamutu', 'North Island', '10613', 'Saint Vincent and The Grenadines'),
  ('P.O. Box 855, 9941 Et, Av.', 'Oaxaca', 'Oax', '0820', 'Haiti'),
  ('707-6793 Sollicitudin Rd.', 'Spaniard''s Bay', 'NL', '5546 WM', 'Bangladesh'),
  ('7708 Enim. Rd.', 'Tver', 'TVE', '90-465', 'Zimbabwe'),
  ('9181 A, St.', 'Campinas', 'S�o Paulo', '59126', 'Luxembourg'),
  ('Ap #403-7838 Sed Street', 'Desamparados', 'SJ', '2891', 'Bhutan'),
  ('P.O. Box 774, 796 Habitant St.', 'Torgny', 'LX', '481071', 'Panama'),
  ('P.O. Box 619, 3493 A Rd.', 'Banjarmasin', 'KS', '02989-684', 'Oman'),
  ('Ap #786-8981 Urna Street', 'Vienna', 'Wie', 'HM5 9RF', 'Armenia'),
  ('P.O. Box 534, 8586 Facilisis. St.', 'Rezzoaglio', 'Liguria', '21418', 'Paraguay'),
  ('9998 Class Av.', 'Tumba', 'AB', '87085-638', 'Vanuatu'),
  ('Ap #313-4874 Urna St.', 'Enschede', 'Ov', '61778-67673', 'San Marino'),
  ('796-2368 Non Rd.', 'Kalisz', 'WP', 'Y4X 2W4', 'Malaysia'),
  ('P.O. Box 258, 9052 Molestie Street', 'El Bosque', 'RM', 'OA66 6ND', 'Jersey'),
  ('9649 Elementum Street', 'Bairnsdale', 'VIC', '2337', 'Saint Kitts and Nevis'),
  ('Ap #946-5857 Parturient Ave', 'Istanbul', 'Ist', '06696', 'Cayman Islands'),
  ('590-150 Donec Street', 'Saint-Denis-Bovesse', 'NA', 'X0X 7S5', 'Lesotho'),
  ('804-7424 Pellentesque, Rd.', 'Augusta', 'ME', '91415-079', 'Peru'),
  ('139-3391 Scelerisque Street', 'Bama', 'BO', '697323', 'Bangladesh'),
  ('Ap #789-2417 Sodales. Av.', 'Burgos', 'CL', '57960', 'Malta'),
  ('720-8863 Nibh. St.', 'Waitakere', 'North Island', '02214', 'Iran'),
  ('P.O. Box 846, 2086 Sociis Rd.', 'Gimcheon', 'North Gyeongsang', '91-358', 'Philippines'),
  ('623-5982 Tellus Rd.', 'Idaho Falls', 'Idaho', '20517-770', 'Macedonia'),
  ('5453 Lacus St.', 'Hengelo', 'Overijssel', '28286', 'Reunion'),
  ('Ap #408-8713 Velit Rd.', 'Oosterhout', 'N.', 'S4W 8R0', 'Martinique'),
  ('155-7266 Nec Rd.', 'Bergen op Zoom', 'N.', 'Y2E 7J3', 'Kazakhstan'),
  ('4790 Ultricies Ave', 'Saint-Georges', 'QC', '7959', 'Estonia'),
  ('P.O. Box 601, 172 Felis, Rd.', 'Irkutsk', 'IRK', '79487-65697', 'Monaco'),
  ('Ap #430-2214 Ut, Street', 'Bolln�s', 'G�vleborgs l�n', '44230', 'Palestine, State of'),
  ('Ap #803-9183 Placerat, Av.', 'Gojal Upper Hunza', 'Gilgit Baltistan', '07-690', 'Korea, South'),
  ('Ap #525-4897 Dui. Road', 'Bremerhaven', 'Bremen', '26276', 'Mongolia'),
  ('P.O. Box 502, 889 A St.', 'Picton', 'South Island', '67539', 'Liechtenstein'),
  ('P.O. Box 699, 4289 Quisque Avenue', 'Vienna', 'Vienna', '77-531', 'Saint Helena, Ascension and Tristan da Cunha'),
  ('940-6324 Pellentesque St.', 'Kostroma', 'KOS', '729007', 'Mali'),
  ('Ap #327-2111 Eu, Avenue', 'Kostroma', 'KOS', '3325', 'Malta'),
  ('P.O. Box 864, 2275 Massa. St.', 'Calle Blancos', 'San Jos�', '89801', 'French Polynesia'),
  ('P.O. Box 763, 645 Sit Rd.', 'Cherbourg-Octeville', 'Basse-Normandie', '4657', 'Viet Nam'),
  ('2476 Massa. St.', 'Campagna', 'Campania', '7692', 'Palestine, State of'),
  ('754-5759 Iaculis Road', 'Morelia', 'Michoac�n', '062571', 'Czech Republic'),
  ('913-9238 Sapien, Road', 'Kalisz', 'WP', '71403', 'Bosnia and Herzegovina'),
  ('916-9718 Dis Avenue', 'Zaragoza', 'AR', '6404', 'Norfolk Island'),
  ('Ap #694-3523 Aliquam St.', 'Prince Albert', 'Saskatchewan', 'Z8949', 'Niger'),
  ('566 Venenatis Ave', 'Pointe-aux-Trembles', 'QC', '00213', 'Singapore'),
  ('P.O. Box 382, 8925 Praesent Av.', 'Nurdagi', 'Gaz', '5576 OI', 'Kuwait'),
  ('Ap #501-7397 Erat Ave', 'Argenteuil', 'IL', '6144', 'Jamaica'),
  ('550-9495 Sed Rd.', 'Magangu�', 'BOL', '47593', 'Tunisia'),
  ('Ap #600-1700 Risus. Ave', 'Biloxi', 'Mississippi', '4733', 'Dominican Republic'),
  ('8174 Taciti Street', 'Baddeck', 'Nova Scotia', '161000', 'Bermuda'),
  ('6453 Posuere Ave', 'Hilo', 'HI', '31073', 'Namibia'),
  ('544-8122 Tempor St.', 'Prince George', 'BC', '61113', 'Saint Martin');

INSERT INTO Location
  ([Street],[City],[Region],[ZipCode],[Country])
VALUES('Ap #796-3996 Elementum Av.', 'Yeosu', 'South Jeolla', 'X1V 1M4', 'Djibouti'),
  ('694-2970 Urna. Ave', 'Bremen', 'HB', '17060', 'Suriname'),
  ('3717 Vulputate, Rd.', 'Cerro Navia', 'Metropolitana de Santiago', '26189', 'Norfolk Island'),
  ('453-516 Id, Av.', 'Montreuil', 'IL', 'C9M 3K2', 'Heard Island and Mcdonald Islands'),
  ('258-5961 Nec Avenue', 'Nowshera', 'KPK', '75144-632', 'Aruba'),
  ('2418 Purus. Rd.', 'Vienna', 'Wie', '19399', 'Jordan'),
  ('Ap #640-889 Magna. Ave', 'Ophoven', 'L.', '23159', 'Nigeria'),
  ('8186 Interdum. Av.', 'Sabanalarga', 'ATL', '10915', 'Hungary'),
  ('Ap #971-891 Ac Avenue', 'Nurdagi', 'Gaziantep', '00084', 'Tonga'),
  ('900-5224 Integer Street', 'Hamburg', 'HH', '17083-837', 'Andorra'),
  ('9397 A, Av.', 'Kedzierzyn-Kozle', 'OP', '342297', 'Chile'),
  ('4532 Ipsum. Avenue', 'Swan Hill', 'Victoria', '7433', 'Niger'),
  ('172-9780 Vestibulum Road', 'Stratford', 'Prince Edward Island', '13793', 'Bahrain'),
  ('3329 Suspendisse Rd.', 'Niort', 'Poitou-Charentes', '83234-336', 'Saint Vincent and The Grenadines'),
  ('3574 Viverra. St.', 'Tampico', 'Tam', 'H8R 6P3', 'South Africa'),
  ('526-7098 Ac, Av.', 'Legnica', 'Dolnoslaskie', 'MX2I 0OX', 'British Indian Ocean Territory'),
  ('7276 Iaculis, St.', 'Antalya', 'Antalya', '962406', 'Jordan'),
  ('Ap #528-3271 Et Avenue', 'Mata de Pl�tano', 'SJ', '47200', 'Bhutan'),
  ('P.O. Box 753, 7290 Id St.', 'Girona', 'CA', 'XF9 1HA', 'Uganda'),
  ('376-6610 Aliquet Avenue', 'Dos Hermanas', 'Andaluc�a', '36253', 'Ireland'),
  ('P.O. Box 446, 6305 Consectetuer Road', 'Krak�w', 'Malopolskie', '98291', 'Ukraine'),
  ('P.O. Box 552, 6839 Tellus St.', 'Saint-Nazaire', 'Pays de la Loire', '4772', 'Zimbabwe'),
  ('2638 Enim St.', 'Sint-Gillis', 'BU', '69089', 'Costa Rica'),
  ('257-4551 Iaculis St.', 'Torgny', 'LX', '20074', 'Zimbabwe'),
  ('P.O. Box 475, 9430 Nulla Rd.', 'Otukpo', 'BE', '384229', 'Papua New Guinea'),
  ('Ap #565-8099 Donec St.', 'Gloucester', 'Ontario', '59970', 'Turkey'),
  ('P.O. Box 519, 3946 Lobortis Avenue', 'Leval-Chaudeville', 'HE', 'B5V 1B1', 'Macao'),
  ('P.O. Box 732, 4409 Lorem, Avenue', 'Sapele', 'Delta', '182383', 'Georgia'),
  ('935-7112 In Avenue', 'San Felice a Cancello', 'CAM', '81442-227', 'Saint Pierre and Miquelon'),
  ('249-3677 Egestas St.', 'Miami', 'FL', '64377', 'Norfolk Island'),
  ('Ap #274-1474 Ultrices, Avenue', 'Lambayeque', 'LAM', '08336', 'Jamaica'),
  ('Ap #693-9757 Lacus. St.', 'Karachi', 'Punjab', '963414', 'Barbados'),
  ('P.O. Box 607, 3753 Nec, Avenue', 'Vienna', 'Vienna', '90598', 'Suriname'),
  ('P.O. Box 338, 9021 Aenean Rd.', 'Vienna', 'Vienna', '776673', 'United States Minor Outlying Islands'),
  ('Ap #897-7240 Vel St.', 'Sterling Heights', 'MI', '2848', 'Guam'),
  ('271-5202 Aliquam St.', 'Katsina', 'Katsina', '7282', 'Portugal'),
  ('Ap #749-6473 Tellus St.', 'M�stoles', 'Madrid', '92-590', 'Philippines'),
  ('8426 Mi. Av.', 'Stamford', 'Connecticut', '3552', 'Saint Martin'),
  ('619-4730 Sed Street', 'Anyang', 'Gye', '9254', 'French Polynesia'),
  ('P.O. Box 244, 9262 Felis St.', 'Motueka', 'South Island', '27307', 'Jordan'),
  ('P.O. Box 494, 8522 Amet, Road', 'Dublin', 'L', '311212', 'Chad'),
  ('Ap #822-8404 Nunc St.', 'Ratlam', 'MP', 'Z8959', 'Afghanistan'),
  ('P.O. Box 784, 9205 Lorem, Road', 'Vienna', 'Wie', '230054', 'Philippines'),
  ('Ap #168-7028 Suspendisse Street', 'Uijeongbu', 'Gyeonggi', '385319', 'Tunisia'),
  ('3416 Massa. St.', 'Kano', 'KN', '669231', 'Swaziland'),
  ('P.O. Box 541, 1586 A St.', 'Rouyn-Noranda', 'QC', '761552', 'Mozambique'),
  ('P.O. Box 389, 817 Ullamcorper Rd.', 'Dutse', 'Jigawa', '523144', 'Turks and Caicos Islands'),
  ('3429 Risus. St.', 'Chakwal', 'SI', '30510', 'Ukraine'),
  ('139-132 Ultricies Rd.', 'Isle-aux-Coudres', 'Quebec', '41815', 'Andorra'),
  ('542-1607 Ut Rd.', 'Tasikmalaya', 'JB', '61609', 'Bulgaria'),
  ('Ap #981-5930 Ante Avenue', 'Sakhalin', 'SAK', '2640', 'Northern Mariana Islands'),
  ('P.O. Box 399, 6945 Dolor St.', 'Girona', 'CA', '77440', 'Equatorial Guinea'),
  ('Ap #506-5251 Semper Road', 'Recife', 'Pernambuco', '73-643', 'Antigua and Barbuda'),
  ('P.O. Box 319, 4973 Ut St.', 'Malambo', 'ATL', '3611', 'C�te D''Ivoire (Ivory Coast)'),
  ('Ap #540-6721 Commodo Avenue', 'Rochester', 'Kent', '98408', 'Kenya'),
  ('712-2563 Donec Street', 'Niort', 'PO', '74917', '�land Islands'),
  ('380-1508 Duis St.', 'Paradise', 'Newfoundland and Labrador', '0050 NY', 'Montenegro'),
  ('P.O. Box 538, 9758 Felis Road', 'Wroclaw', 'Dolnoslaskie', '13885', 'Argentina'),
  ('646-5928 Aliquam St.', 'Le Mans', 'PA', 'NX3M 3DE', 'Guyana'),
  ('591-3130 Convallis Av.', 'Cerro Navia', 'RM', '67786', 'Angola'),
  ('Ap #131-5429 Quisque Avenue', 'Norfolk', 'Virginia', '25949', 'Estonia'),
  ('167-8046 Elit Ave', 'Wodonga', 'Victoria', '5925 AN', 'Latvia'),
  ('P.O. Box 574, 177 Augue, Street', 'Roosendaal', 'N.', '1574', 'Virgin Islands, British'),
  ('P.O. Box 760, 8533 Et Road', 'Duluth', 'MN', 'V9B 7K0', 'Algeria'),
  ('9316 Pharetra Rd.', 'Mj�lby', '�sterg�tlands l�n', '93-117', 'Iceland'),
  ('Ap #108-4283 Eros Av.', 'Radom', 'Mazowieckie', 'CK00 4EM', 'Mauritania'),
  ('P.O. Box 985, 5093 Turpis. Rd.', 'Cork', 'M', 'Z5232', 'Lithuania'),
  ('333-6401 Accumsan St.', 'Mulhouse', 'Alsace', '07782', 'Colombia'),
  ('Ap #507-5578 Nec Ave', 'Galway', 'C', '21412', 'Cambodia'),
  ('491-294 Lacus. Rd.', 'Rzesz�w', 'PK', '68025-005', 'Algeria'),
  ('527-9559 Dolor. Road', 'Nelson', 'South Island', '509815', 'Haiti'),
  ('Ap #771-3271 Venenatis Rd.', 'Galway', 'Connacht', '514607', 'Burundi'),
  ('2538 Ipsum Ave', 'Kemzeke', 'Oost-Vlaanderen', '663721', 'Mayotte'),
  ('750-5469 Augue Av.', 'Moe', 'Victoria', '77549', 'United Kingdom (Great Britain)'),
  ('847-1870 A Street', 'Cork', 'M', '377819', 'Western Sahara'),
  ('9892 Natoque Ave', 'Salamanca', 'Castilla y Le�n', '28580', 'Cuba'),
  ('P.O. Box 561, 7559 Dolor St.', 'Ciudad Apodaca', 'Nuevo Le�n', '956405', 'South Africa'),
  ('P.O. Box 533, 1576 Ut Street', 'Gunsan', 'North Jeolla', '89430-281', 'Tuvalu'),
  ('690-1413 Interdum St.', 'Montigny-le-Tilleul', 'Henegouwen', '03257', 'Vanuatu'),
  ('Ap #392-6299 Vel Street', 'Pessac', 'Aquitaine', '466049', 'Lithuania'),
  ('2404 Congue, Rd.', 'Ligny', 'Namen', '20511', 'Malawi'),
  ('Ap #255-9551 Ullamcorper St.', 'Sechura', 'PIU', '36326-20358', 'Bermuda'),
  ('8633 Tincidunt Rd.', 'Oostkamp', 'WV', '15583', 'Tokelau'),
  ('P.O. Box 360, 8057 Quam Rd.', 'Huancayo', 'JUN', '502780', 'Macao'),
  ('Ap #384-5792 Nam St.', 'Gongju', 'Chu', '775058', 'Bosnia and Herzegovina'),
  ('Ap #908-4230 Urna, Street', 'Val�ncia', 'CV', '888634', 'Aruba'),
  ('797-2332 Magnis Street', 'Shawville', 'QC', '51542-083', 'Tonga'),
  ('804-9780 Tristique St.', 'Cajamarca', 'Cajamarca', '7104', 'Thailand'),
  ('Ap #908-1571 Vel St.', 'Martigues', 'PR', '134196', 'Svalbard and Jan Mayen Islands'),
  ('552-569 Auctor Avenue', 'Apeldoorn', 'Gl', '5034', 'American Samoa'),
  ('Ap #994-8800 Leo. Avenue', 'R�nquil', 'VII', '475078', 'Finland'),
  ('792-7879 Rhoncus St.', 'Kohlu', 'Balochistan', '19442-399', 'Maldives'),
  ('P.O. Box 436, 8680 Nec Avenue', 'Draguignan', 'PR', '08999', 'Wallis and Futuna'),
  ('Ap #348-2710 Donec St.', 'Empedrado', 'Maule', '110624', 'Aruba'),
  ('Ap #495-1969 Fringilla Road', 'Burlington', 'Vermont', '9737', 'Falkland Islands'),
  ('Ap #589-3658 Fringilla Av.', 'Upper Hutt', 'North Island', '50143', 'San Marino'),
  ('P.O. Box 776, 6921 Fermentum Ave', 'Tours', 'Centre', '30227', 'Costa Rica'),
  ('P.O. Box 780, 6404 Nulla Rd.', 'Zierikzee', 'Zeeland', '171393', 'Vanuatu'),
  ('8718 Aliquet, St.', 'Ja�n', 'Cajamarca', '31113-87985', 'Indonesia'),
  ('691-2820 Fames Av.', 'Quimper', 'BR', '25964', 'Christmas Island');


-- *** 100x WareHouse***
INSERT INTO WareHouse
  ([Name],[Phone],[Capacity],[LocationId])
VALUES('�sterg�tlands l�n', '16380212 4382', 2562, 271),
  ('RM', '16620908 7771', 2061, 197),
  ('Henegouwen', '16520402 4532', 1234, 49),
  ('�le-de-France', '16940107 8093', 1964, 432),
  ('FC', '16030421 1543', 1122, 107),
  ('SP', '16321126 2021', 417, 293),
  ('Zeeland', '16140828 1507', 1422, 251),
  ('Ktn', '16801109 2882', 376, 254),
  ('BO', '16280401 8683', 235, 371),
  ('N.L', '16140524 4169', 1958, 252),
  ('Tamaulipas', '16201002 7734', 89, 132),
  ('Stockholms l�n', '16600421 8092', 35, 204),
  ('Provence-Alpes-C�te d''Azur', '16921230 5495', 1287, 456),
  ('FATA', '16900119 8473', 1980, 184),
  ('E', '16300408 4657', 899, 20),
  ('ANC', '16620926 5138', 287, 70),
  ('Gelderland', '16431017 8175', 1905, 120),
  ('Victoria', '16651120 4122', 692, 141),
  ('FA', '16520927 7895', 2419, 269),
  ('Veracruz', '16540225 9047', 2035, 399),
  ('Zl', '16880608 5125', 624, 334),
  ('Vermont', '16920507 3662', 450, 52),
  ('South Jeolla', '16660927 0605', 1980, 69),
  ('F', '16680720 6153', 1539, 476),
  ('RM', '16840421 0463', 2399, 241),
  ('WB', '16141222 5409', 732, 257),
  ('Izmir', '16190612 0199', 35, 302),
  ('Balochistan', '16310428 8257', 2358, 141),
  ('HP', '16780114 3475', 1185, 279),
  ('V�stra G�talands l�n', '16990304 0039', 135, 133),
  ('Kujawsko-pomorskie', '16110801 8357', 2482, 244),
  ('Piemonte', '16140207 7497', 2016, 254),
  ('Bremen', '16860220 7782', 2073, 123),
  ('Alajuela', '16661211 8635', 913, 297),
  ('ERM', '16981107 3429', 526, 477),
  ('MU', '16680430 0207', 1560, 218),
  ('MAR', '16771008 1816', 1394, 13),
  ('Lagos', '16860323 8828', 374, 133),
  ('SN', '16600213 2543', 1832, 289),
  ('NI', '16550129 5306', 1500, 194),
  ('Morayshire', '16360630 4339', 511, 301),
  ('UP', '16450802 6053', 1452, 165),
  ('U', '16540325 1340', 905, 38),
  ('Brecknockshire', '16060326 8004', 922, 403),
  ('Victoria', '16730719 8148', 2187, 372),
  ('WB', '16011108 9009', 1075, 376),
  ('Fl', '16910724 2217', 1170, 417),
  ('Gye', '16541027 6967', 2428, 179),
  ('Luik', '16110615 4097', 2463, 454),
  ('Maryland', '16860703 6939', 1210, 296),
  ('Kano', '16530711 8421', 2296, 217),
  ('PO', '16120708 7311', 121, 99),
  ('JUN', '16260122 7628', 2112, 7),
  ('PB', '16750127 1865', 2141, 182),
  ('Khyber Pakhtoonkhwa', '16140912 0282', 2025, 152),
  ('Noord Holland', '16070825 4255', 1393, 441),
  ('South Island', '16410730 7888', 555, 10),
  ('NU', '16641118 2048', 2032, 82),
  ('SK', '16670111 8249', 1710, 246),
  ('Maranh�o', '16020829 3092', 2437, 226),
  ('Colorado', '16060408 4038', 2412, 100),
  ('North Island', '16351210 9947', 547, 492),
  ('AK', '16990805 0009', 2264, 356),
  ('NI', '16250104 6680', 964, 496),
  ('NB', '16170421 4178', 417, 365),
  ('S�o Paulo', '16130803 0095', 2421, 132),
  ('C', '16510513 6369', 1663, 495),
  ('VIC', '16280612 8993', 477, 74),
  ('Andaluc�a', '16910521 7070', 265, 419),
  ('IM', '16901030 2637', 2274, 371),
  ('MG', '16840921 8107', 319, 279),
  ('Santa Catarina', '16010816 2207', 2136, 267),
  ('Opolskie', '16841226 7307', 199, 284),
  ('Principado de Asturias', '16780227 6829', 1162, 469),
  ('South Island', '16620703 1532', 1778, 274),
  ('AN', '16140807 4878', 998, 154),
  ('C', '16251204 7461', 1101, 86),
  ('Kogi', '16890817 8166', 1451, 272),
  ('Ist', '16791205 2417', 1186, 292),
  ('Limburg', '16380307 7555', 2048, 78),
  ('Quebec', '16280109 0743', 1059, 443),
  ('JT', '16420702 4672', 1163, 263),
  ('MA', '16900128 4380', 780, 347),
  ('MA', '16880428 0439', 1920, 347),
  ('SA', '16500426 2431', 2275, 276),
  ('AN', '16731205 0144', 1534, 414),
  ('Ulster', '16920223 4333', 1687, 170),
  ('PB', '16530707 3592', 1271, 205),
  ('Andaluc�a', '16050818 8406', 2277, 240),
  ('Pomorskie', '16940430 2169', 2056, 197),
  ('Andaluc�a', '16320701 6951', 2439, 232),
  ('LAL', '16851126 4544', 2167, 451),
  ('C', '16270119 4702', 418, 406),
  ('FATA', '16400211 4090', 1635, 75),
  ('HB', '16120709 5900', 2327, 291),
  ('Zl', '16010717 7693', 1993, 157),
  ('OMS', '16331202 2977', 92, 181),
  ('Punjab', '16370215 4489', 1306, 49),
  ('San Jos�', '16560325 9382', 2081, 477),
  ('ON', '16431119 3876', 1917, 389);


-- *** 500x DeviceWareHouse***
INSERT INTO DeviceWareHouse
  ([DeviceId],[WareHouseId],[Amount])
VALUES(8, 47, 394),
  (14, 50, 994),
  (34, 37, 700),
  (28, 5, 1175),
  (32, 23, 964),
  (16, 41, 1006),
  (25, 20, 776),
  (31, 27, 106),
  (10, 22, 183),
  (7, 48, 1111),
  (20, 28, 301),
  (21, 13, 300),
  (28, 25, 389),
  (22, 36, 1220),
  (2, 27, 4),
  (16, 5, 1022),
  (12, 28, 516),
  (7, 46, 532),
  (36, 44, 861),
  (39, 42, 241),
  (2, 11, 474),
  (35, 25, 993),
  (22, 27, 918),
  (3, 48, 898),
  (17, 34, 552),
  (3, 23, 1206),
  (3, 29, 141),
  (32, 3, 1102),
  (4, 46, 432),
  (19, 49, 1204),
  (14, 4, 1025),
  (11, 26, 326),
  (38, 25, 128),
  (39, 40, 93),
  (23, 44, 74),
  (28, 42, 95),
  (12, 27, 462),
  (31, 50, 117),
  (22, 17, 502),
  (24, 26, 958),
  (33, 22, 956),
  (12, 17, 1114),
  (18, 22, 103),
  (15, 4, 674),
  (36, 49, 224),
  (33, 12, 607),
  (10, 49, 226),
  (39, 31, 41),
  (17, 28, 642),
  (20, 30, 74),
  (33, 23, 340),
  (36, 33, 356),
  (23, 48, 266),
  (3, 12, 620),
  (7, 5, 908),
  (25, 8, 253),
  (20, 32, 69),
  (4, 15, 427),
  (5, 29, 232),
  (12, 12, 951),
  (28, 29, 593),
  (13, 5, 663),
  (28, 28, 977),
  (4, 17, 891),
  (35, 4, 932),
  (20, 15, 186),
  (30, 16, 360),
  (20, 22, 961),
  (12, 45, 587),
  (2, 34, 389),
  (27, 23, 147),
  (9, 14, 293),
  (8, 3, 524),
  (28, 6, 194),
  (19, 10, 648),
  (15, 24, 1116),
  (17, 16, 522),
  (25, 36, 383),
  (15, 15, 157),
  (27, 7, 641),
  (21, 11, 820),
  (19, 37, 664),
  (15, 43, 1181),
  (36, 11, 1114),
  (3, 50, 266),
  (40, 47, 1141),
  (2, 19, 28),
  (15, 20, 3),
  (25, 44, 121),
  (38, 22, 817),
  (28, 32, 449),
  (18, 1, 977),
  (36, 28, 1085),
  (19, 3, 41),
  (35, 12, 652),
  (33, 18, 136),
  (15, 10, 521),
  (10, 2, 225),
  (14, 48, 729),
  (32, 39, 1159);

INSERT INTO DeviceWareHouse
  ([DeviceId],[WareHouseId],[Amount])
VALUES(1, 6, 1086),
  (40, 9, 950),
  (18, 44, 1239),
  (34, 43, 359),
  (9, 9, 1143),
  (32, 20, 673),
  (27, 41, 1067),
  (23, 9, 597),
  (22, 34, 469),
  (38, 16, 780),
  (5, 40, 865),
  (8, 45, 736),
  (10, 26, 314),
  (18, 14, 76),
  (9, 22, 1123),
  (30, 30, 727),
  (24, 1, 507),
  (37, 17, 75),
  (16, 12, 45),
  (16, 6, 129),
  (8, 50, 1205),
  (25, 18, 118),
  (8, 13, 1032),
  (14, 32, 666),
  (29, 17, 718),
  (26, 33, 816),
  (7, 41, 55),
  (2, 41, 861),
  (21, 31, 933),
  (2, 3, 1112),
  (40, 26, 850),
  (23, 50, 427),
  (38, 29, 244),
  (8, 42, 116),
  (34, 17, 1130),
  (36, 1, 603),
  (4, 17, 1120),
  (14, 20, 341),
  (12, 23, 1161),
  (9, 35, 577),
  (35, 35, 36),
  (22, 7, 593),
  (1, 32, 665),
  (3, 5, 1072),
  (16, 39, 1092),
  (9, 46, 545),
  (32, 36, 776),
  (20, 43, 863),
  (8, 3, 658),
  (34, 23, 1202),
  (40, 43, 122),
  (3, 45, 618),
  (4, 43, 377),
  (33, 34, 235),
  (21, 24, 712),
  (1, 12, 703),
  (15, 45, 619),
  (25, 48, 882),
  (9, 29, 923),
  (21, 21, 616),
  (5, 46, 847),
  (38, 12, 1202),
  (6, 12, 303),
  (18, 20, 258),
  (13, 1, 899),
  (29, 14, 692),
  (12, 18, 1088),
  (37, 17, 980),
  (36, 5, 1021),
  (28, 23, 1059),
  (3, 1, 925),
  (28, 9, 259),
  (7, 37, 32),
  (10, 16, 680),
  (36, 14, 15),
  (11, 26, 728),
  (17, 35, 880),
  (37, 21, 1153),
  (15, 10, 854),
  (8, 24, 844),
  (32, 50, 1181),
  (16, 24, 100),
  (3, 23, 200),
  (26, 10, 264),
  (5, 46, 680),
  (36, 13, 65),
  (13, 31, 838),
  (33, 10, 143),
  (28, 38, 226),
  (31, 15, 831),
  (2, 35, 850),
  (34, 23, 822),
  (16, 45, 230),
  (34, 44, 718),
  (35, 19, 909),
  (10, 40, 528),
  (21, 41, 120),
  (36, 8, 145),
  (14, 49, 117),
  (8, 29, 604);

INSERT INTO DeviceWareHouse
  ([DeviceId],[WareHouseId],[Amount])
VALUES(20, 17, 1171),
  (1, 42, 1211),
  (4, 37, 154),
  (1, 26, 1232),
  (38, 14, 1040),
  (34, 31, 200),
  (34, 21, 661),
  (15, 43, 227),
  (18, 6, 438),
  (29, 46, 221),
  (2, 9, 848),
  (11, 43, 898),
  (35, 1, 986),
  (8, 49, 508),
  (19, 15, 421),
  (4, 36, 29),
  (30, 11, 1056),
  (5, 34, 6),
  (12, 30, 722),
  (40, 29, 505),
  (16, 23, 146),
  (15, 41, 914),
  (2, 2, 788),
  (34, 23, 745),
  (40, 45, 315),
  (35, 15, 517),
  (30, 13, 435),
  (6, 23, 1012),
  (34, 47, 968),
  (19, 4, 340),
  (25, 7, 982),
  (28, 43, 635),
  (7, 48, 77),
  (8, 14, 584),
  (17, 23, 589),
  (25, 46, 379),
  (15, 41, 1149),
  (4, 11, 68),
  (25, 28, 190),
  (3, 43, 301),
  (25, 7, 764),
  (33, 10, 1096),
  (36, 38, 1224),
  (39, 42, 388),
  (17, 27, 857),
  (11, 24, 661),
  (31, 37, 384),
  (37, 22, 1130),
  (12, 34, 631),
  (25, 9, 944),
  (30, 46, 1011),
  (14, 16, 243),
  (14, 18, 987),
  (17, 7, 947),
  (40, 26, 332),
  (4, 11, 720),
  (22, 42, 404),
  (9, 18, 704),
  (7, 27, 1129),
  (13, 44, 472),
  (20, 17, 365),
  (23, 15, 106),
  (14, 27, 971),
  (30, 11, 392),
  (14, 25, 358),
  (29, 1, 545),
  (6, 31, 976),
  (14, 32, 1102),
  (19, 5, 432),
  (39, 19, 1035),
  (33, 28, 686),
  (3, 3, 447),
  (35, 32, 15),
  (18, 32, 1151),
  (6, 33, 576),
  (9, 26, 118),
  (5, 20, 1191),
  (11, 49, 716),
  (40, 18, 247),
  (29, 17, 521),
  (6, 27, 1066),
  (35, 41, 9),
  (23, 35, 93),
  (17, 32, 225),
  (16, 43, 255),
  (32, 47, 689),
  (34, 17, 1223),
  (3, 14, 1217),
  (19, 47, 712),
  (33, 7, 516),
  (12, 44, 624),
  (37, 40, 1144),
  (23, 46, 834),
  (1, 8, 706),
  (15, 47, 860),
  (21, 45, 976),
  (35, 21, 987),
  (4, 25, 1110),
  (36, 3, 315),
  (25, 28, 136);

INSERT INTO DeviceWareHouse
  ([DeviceId],[WareHouseId],[Amount])
VALUES(8, 10, 272),
  (28, 19, 24),
  (17, 5, 48),
  (33, 13, 116),
  (28, 9, 71),
  (28, 12, 335),
  (7, 45, 792),
  (16, 48, 168),
  (33, 22, 130),
  (27, 43, 816),
  (11, 5, 628),
  (20, 8, 1200),
  (5, 31, 826),
  (19, 31, 1006),
  (16, 37, 973),
  (6, 48, 1224),
  (38, 45, 1041),
  (21, 9, 992),
  (8, 6, 685),
  (22, 24, 132),
  (12, 45, 278),
  (29, 3, 935),
  (5, 19, 854),
  (30, 4, 323),
  (24, 12, 959),
  (38, 36, 1200),
  (19, 18, 118),
  (21, 30, 927),
  (32, 13, 230),
  (6, 36, 403),
  (20, 8, 863),
  (5, 36, 116),
  (7, 1, 513),
  (19, 29, 534),
  (24, 18, 426),
  (17, 1, 338),
  (36, 7, 1124),
  (23, 14, 333),
  (28, 22, 1118),
  (5, 34, 747),
  (8, 33, 12),
  (26, 42, 1167),
  (31, 14, 761),
  (26, 46, 568),
  (29, 11, 1007),
  (4, 4, 381),
  (40, 30, 339),
  (25, 17, 670),
  (30, 20, 968),
  (21, 10, 613),
  (20, 32, 847),
  (35, 48, 1116),
  (32, 39, 898),
  (25, 28, 688),
  (30, 48, 1070),
  (15, 39, 660),
  (29, 4, 1005),
  (6, 34, 507),
  (32, 30, 300),
  (33, 17, 314),
  (16, 34, 1160),
  (37, 20, 1086),
  (10, 2, 79),
  (30, 43, 177),
  (29, 18, 989),
  (22, 4, 501),
  (29, 10, 923),
  (17, 13, 155),
  (39, 50, 254),
  (7, 41, 547),
  (39, 49, 257),
  (23, 19, 710),
  (5, 23, 597),
  (36, 40, 942),
  (37, 16, 488),
  (14, 46, 196),
  (12, 26, 630),
  (32, 43, 470),
  (4, 38, 505),
  (12, 14, 303),
  (22, 33, 206),
  (17, 48, 956),
  (3, 23, 973),
  (1, 13, 1111),
  (15, 32, 917),
  (11, 7, 179),
  (21, 41, 944),
  (5, 37, 221),
  (29, 19, 546),
  (5, 29, 492),
  (1, 45, 163),
  (23, 3, 85),
  (3, 14, 90),
  (13, 49, 926),
  (9, 45, 406),
  (8, 9, 364),
  (30, 24, 1162),
  (16, 34, 1062),
  (35, 17, 215),
  (31, 30, 731);

INSERT INTO DeviceWareHouse
  ([DeviceId],[WareHouseId],[Amount])
VALUES(3, 24, 427),
  (36, 42, 184),
  (2, 29, 1052),
  (7, 7, 195),
  (5, 2, 697),
  (32, 50, 122),
  (5, 49, 1161),
  (37, 2, 116),
  (1, 43, 687),
  (23, 3, 208),
  (29, 38, 146),
  (22, 33, 1242),
  (20, 20, 1197),
  (30, 42, 32),
  (35, 2, 232),
  (22, 44, 625),
  (13, 3, 832),
  (8, 9, 1043),
  (17, 11, 360),
  (1, 34, 368),
  (16, 17, 727),
  (1, 5, 488),
  (13, 14, 939),
  (35, 49, 93),
  (21, 4, 790),
  (21, 16, 215),
  (19, 17, 833),
  (2, 46, 1203),
  (12, 1, 1025),
  (20, 20, 237),
  (12, 29, 903),
  (6, 28, 99),
  (18, 10, 1162),
  (32, 8, 950),
  (40, 27, 960),
  (1, 6, 321),
  (36, 17, 253),
  (37, 24, 1034),
  (31, 28, 1213),
  (40, 37, 683),
  (36, 19, 490),
  (20, 42, 947),
  (13, 17, 285),
  (27, 48, 542),
  (8, 18, 742),
  (8, 33, 839),
  (4, 34, 528),
  (1, 33, 196),
  (26, 30, 372),
  (3, 12, 1015),
  (22, 43, 425),
  (16, 12, 730),
  (26, 1, 434),
  (1, 17, 1068),
  (20, 13, 516),
  (8, 4, 79),
  (25, 3, 852),
  (39, 41, 679),
  (16, 26, 558),
  (30, 12, 527),
  (23, 39, 914),
  (27, 30, 1088),
  (39, 12, 986),
  (36, 46, 690),
  (10, 23, 209),
  (10, 38, 392),
  (26, 33, 1153),
  (8, 17, 1171),
  (18, 43, 591),
  (6, 32, 527),
  (5, 34, 557),
  (21, 18, 330),
  (28, 11, 288),
  (9, 49, 1015),
  (26, 2, 566),
  (33, 44, 208),
  (11, 50, 312),
  (3, 36, 1222),
  (7, 30, 1170),
  (3, 38, 809),
  (23, 37, 213),
  (1, 29, 361),
  (38, 1, 680),
  (11, 21, 1044),
  (3, 19, 648),
  (30, 26, 1086),
  (2, 18, 566),
  (33, 48, 678),
  (17, 31, 882),
  (37, 17, 1129),
  (18, 18, 226),
  (5, 14, 113),
  (29, 42, 1224),
  (11, 16, 900),
  (3, 43, 1066),
  (31, 7, 671),
  (28, 46, 265),
  (27, 34, 37),
  (38, 27, 60),
  (12, 26, 678);

-- *** 100x Store***
INSERT INTO Store
  ([Name],[Phone],[LocationId])
VALUES('Minnesota', '16050913 8038', 145),
  ('VII', '16800525 6824', 157),
  ('MV', '16010101 1252', 73),
  ('L', '16960723 0449', 193),
  ('Metropolitana de Santiago', '16730612 4061', 214),
  ('Vienna', '16860724 6520', 307),
  ('BE', '16350909 7147', 227),
  ('C', '16430811 0453', 26),
  ('Lubelskie', '16670811 3714', 339),
  ('SP', '16100615 7794', 260),
  ('Wie', '16161125 2220', 369),
  ('NI', '16231223 4061', 235),
  ('New Brunswick', '16420810 5827', 215),
  ('Vienna', '16030226 5129', 294),
  ('Vienna', '16920109 7343', 461),
  ('MA', '16871004 8417', 296),
  ('Trentino-Alto Adige', '16840615 3273', 65),
  ('ARE', '16300201 2643', 493),
  ('North Gyeongsang', '16561101 0389', 433),
  ('Aceh', '16561205 1432', 251),
  ('Madrid', '16091124 9191', 200),
  ('PR', '16200427 4177', 247),
  ('J�nk�pings l�n', '16910814 7944', 223),
  ('Ontario', '16511124 7192', 122),
  ('GA', '16790308 8859', 255),
  ('SN', '16821216 8986', 423),
  ('Florida', '16381209 8972', 242),
  ('Ontario', '16031023 1329', 213),
  ('Slaskie', '16440804 6508', 397),
  ('Uttar Pradesh', '16510809 9127', 193),
  ('IL', '16181116 8184', 315),
  ('Araucan�a', '16460706 6075', 212),
  ('O', '16940508 2059', 388),
  ('MA', '16001011 7554', 440),
  ('Quebec', '16120712 9881', 301),
  ('West-Vlaanderen', '16470119 5978', 249),
  ('Leinster', '16201218 5704', 400),
  ('L', '16780705 6408', 302),
  ('Alaska', '16790110 4005', 417),
  ('M', '16600214 1015', 81),
  ('Tab', '16310320 6011', 429),
  ('AB', '16690522 1245', 336),
  ('Oregon', '16860405 4653', 156),
  ('Atl�ntico', '16680212 0425', 464),
  ('AB', '16250123 2744', 164),
  ('Antwerpen', '16570803 6396', 1),
  ('Ontario', '16451227 7577', 326),
  ('Extremadura', '16770609 9426', 20),
  ('Gyeonggi', '16501104 0663', 218),
  ('Pskov Oblast', '16661101 9289', 230),
  ('NSW', '16380726 5222', 22),
  ('AK', '16480722 8590', 185),
  ('�sterg�tlands l�n', '16480401 8648', 378),
  ('MA', '16620818 4793', 192),
  ('Gto', '16570615 0405', 485),
  ('Balochistan', '16700922 5058', 167),
  ('BA', '16131111 8416', 150),
  ('Calabria', '16170314 9292', 464),
  ('Atl�ntico', '16120310 8772', 180),
  ('MH', '16840827 5074', 393),
  ('X', '16500824 3296', 211),
  ('Ontario', '16311220 6325', 459),
  ('JB', '16810309 8946', 229),
  ('Vienna', '16300511 3398', 102),
  ('ID', '16630130 9693', 368),
  ('Virginia', '16660125 8756', 5),
  ('North Sulawesi', '16910728 0985', 82),
  ('Manitoba', '16851227 9160', 359),
  ('CAJ', '16640915 2516', 36),
  ('MG', '16690718 3104', 85),
  ('Balochistan', '16830710 4185', 15),
  ('Washington', '16390711 6408', 341),
  ('LU', '16380417 4989', 360),
  ('Gyeonggi', '16780508 0210', 436),
  ('ON', '16270501 4906', 362),
  ('JH', '16141127 1438', 76),
  ('PNZ', '16701004 8655', 53),
  ('West-Vlaanderen', '16200424 6928', 288),
  ('Ktn', '16150217 3311', 107),
  ('KPK', '16240915 9718', 360),
  ('U', '16860903 7034', 475),
  ('Bol�var', '16750824 7157', 12),
  ('Vbg', '16801116 1638', 210),
  ('SJ', '16110223 5668', 415),
  ('Vlaams-Brabant', '16030910 0543', 414),
  ('Slaskie', '16290207 1071', 206),
  ('ANT', '16801003 8167', 49),
  ('Noord Holland', '16621220 2169', 252),
  ('Warwickshire', '16791013 1023', 371),
  ('Berlin', '16730502 3520', 342),
  ('San Jos�', '16420316 1734', 466),
  ('JB', '16991215 1918', 347),
  ('Zeeland', '16411001 8993', 62),
  ('North Island', '16850429 2734', 343),
  ('l�dzkie', '16290501 8731', 411),
  ('Antioquia', '16150322 2844', 145),
  ('South Sulawesi', '16070520 7884', 225),
  ('Lombardia', '16020129 2125', 388),
  ('Para�ba', '16070703 7214', 227),
  ('Swietokrzyskie', '16450123 5388', 474);


-- *** 1000x Customer***
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lorie', 'Cooke', '223-985-3259', '2012-02-06 20:30:55', 'F', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Celestina', 'Cottingham', '299-672-1196', '1977-11-17 01:59:11', 'M', 327);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karna', 'Eakeley', '611-630-8326', '2010-09-24 13:46:53', 'M', 53);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Efrem', 'Restill', '979-256-5469', '2010-05-30 15:51:22', 'F', 282);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Missy', 'Solomonides', '976-975-3127', '1995-08-07 14:27:09', 'F', 321);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gian', 'Pinar', '625-179-9011', '2003-06-04 20:34:57', 'F', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sabra', 'Pretswell', '138-714-6483', '1981-12-03 02:45:03', 'F', 77);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Berget', 'Klais', '877-276-1895', '2001-04-16 15:56:00', 'M', 19);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Emylee', 'Swash', '560-737-7468', '1997-05-05 01:58:01', 'M', 275);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Keefer', 'Coulthard', '552-534-6984', '1980-12-03 21:27:23', 'F', 451);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Venus', 'Mohamed', '315-187-1824', '1979-05-24 10:43:02', 'F', 39);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Weber', 'Sedgemore', '236-948-8885', '2007-03-23 20:44:57', 'M', 470);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sky', 'Sang', '492-277-6811', '1993-01-24 05:23:34', 'F', 235);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mohandas', 'Rosel', '810-623-8657', '2000-06-01 13:21:39', 'M', 441);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hollie', 'Dhennin', '971-786-8941', '2007-03-24 17:50:47', 'M', 4);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paulette', 'Foxen', '247-822-2277', '1983-04-29 20:25:47', 'F', 120);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clywd', 'Petschelt', '299-633-4524', '1998-07-21 11:47:13', 'M', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maybelle', 'Summerton', '151-367-2790', '1996-11-02 19:14:06', 'F', 219);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Liesa', 'Ciccoloi', '711-375-5615', '2003-10-05 01:20:28', 'M', 396);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tara', 'Cecchetelli', '594-209-3817', '1989-07-01 18:53:58', 'M', 185);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ellwood', 'Yoseloff', '702-437-0699', '2009-01-06 21:19:21', 'F', 304);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Catharina', 'Mattersey', '820-405-6464', '1989-06-14 15:50:38', 'M', 286);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Evered', 'Leinthall', '993-120-1324', '1976-12-09 08:15:45', 'M', 316);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Goldia', 'Peplay', '983-604-8166', '1992-02-26 15:46:09', 'M', 313);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hirsch', 'Mellodey', '305-888-2945', '1979-03-11 10:24:41', 'F', 203);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Saunders', 'Langthorne', '636-721-2763', '1989-05-13 17:36:28', 'F', 50);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Waldon', 'Etty', '214-965-5002', '1977-05-03 00:45:18', 'F', 40);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elaine', 'Whight', '123-171-7652', '2011-08-05 12:23:46', 'M', 260);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Antonina', 'Prudence', '810-670-3390', '1976-07-28 02:04:47', 'M', 364);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Amelina', 'Segges', '934-580-2160', '1990-03-29 03:37:46', 'M', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Constancia', 'Bubbear', '253-810-9053', '2004-01-10 11:28:45', 'F', 227);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karrie', 'Lutz', '661-451-4010', '1986-04-16 20:33:26', 'F', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kessiah', 'Ismirnioglou', '832-137-4227', '2007-05-31 23:42:18', 'M', 3);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chryste', 'Clue', '337-294-1288', '1980-08-10 09:10:53', 'F', 178);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dory', 'Blondel', '362-361-7289', '2009-08-14 03:49:17', 'F', 432);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Druci', 'Swadon', '552-808-1470', '2003-06-29 15:30:13', 'M', 304);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Melamie', 'Ridges', '704-314-3776', '1991-08-04 13:14:37', 'F', 23);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cassaundra', 'Schwander', '753-603-7400', '2005-04-24 03:49:12', 'M', 442);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orlando', 'Playfoot', '486-965-2889', '2004-07-10 22:27:37', 'F', 103);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maddy', 'Schmuhl', '971-819-0144', '2003-10-23 11:52:15', 'M', 371);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dallis', 'Blazic', '967-192-7103', '1985-11-30 23:52:08', 'F', 342);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Odey', 'Rosso', '918-236-2343', '1997-09-06 03:28:09', 'M', 189);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tommi', 'Jedrzejewski', '186-609-4447', '1977-10-22 00:21:33', 'F', 179);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Morissa', 'Layhe', '340-781-3006', '2004-08-30 23:26:17', 'F', 482);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bard', 'Navarro', '311-436-1881', '2010-11-23 06:42:29', 'M', 81);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dalila', 'Vannar', '806-865-8350', '2002-01-27 08:11:00', 'M', 349);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mona', 'Pellant', '507-974-1864', '2011-08-18 03:12:59', 'F', 48);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lydia', 'Gomer', '482-500-4946', '2004-10-23 18:08:27', 'M', 331);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Johna', 'Offord', '783-139-1179', '1992-02-09 23:09:34', 'M', 417);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Max', 'Frenzel;', '902-968-2245', '1996-06-18 18:28:21', 'F', 493);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Niccolo', 'Burdess', '950-996-9577', '1982-09-16 12:41:28', 'M', 133);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nollie', 'De Few', '834-811-6415', '1976-04-21 14:20:35', 'M', 385);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sherlock', 'Scroggie', '828-285-0602', '1979-11-30 12:43:06', 'F', 435);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Correy', 'Treppas', '647-887-7129', '1990-10-17 03:34:02', 'M', 124);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tally', 'Farquharson', '531-301-2523', '1983-04-15 09:31:12', 'F', 336);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bruce', 'Voyce', '727-216-0116', '1985-08-11 17:12:17', 'M', 428);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Herve', 'Millwater', '994-454-5932', '1993-03-27 07:46:40', 'F', 120);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chantalle', 'Shawyers', '495-898-2292', '1998-12-30 11:10:51', 'F', 207);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Odo', 'Lotherington', '929-991-4263', '1981-07-24 21:56:41', 'F', 389);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jimmie', 'Cronk', '106-605-6239', '1996-04-07 23:38:47', 'F', 55);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ricki', 'Archbold', '466-194-8227', '2000-05-14 00:07:34', 'M', 421);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bernardina', 'Deddum', '518-422-4400', '1994-09-12 21:38:24', 'M', 216);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Allegra', 'Scotchbrook', '421-254-3009', '1981-05-15 03:35:08', 'M', 214);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hanny', 'Orth', '841-248-0504', '2010-06-29 03:54:16', 'M', 37);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elfrieda', 'Itzkov', '823-561-6667', '1996-11-10 08:56:00', 'F', 366);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlyle', 'Buntain', '614-500-7217', '2006-12-09 05:23:34', 'F', 396);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pail', 'Fricker', '879-285-6328', '1990-04-24 13:32:22', 'M', 282);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Glenn', 'Halliberton', '200-708-8194', '1995-04-09 20:20:36', 'F', 46);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Angelina', 'Cunradi', '943-591-7020', '2003-06-03 02:31:55', 'M', 25);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ahmed', 'Dioniso', '438-375-3502', '1987-03-07 18:36:25', 'M', 85);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Woodman', 'Cooke', '139-784-7009', '1981-06-13 19:57:15', 'M', 461);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cirstoforo', 'McIan', '539-475-7556', '2010-08-29 05:26:34', 'M', 336);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dag', 'Khomich', '475-914-2215', '1979-12-25 01:14:14', 'F', 480);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gregorio', 'Metherell', '956-691-3795', '2008-12-31 22:44:38', 'F', 169);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rafi', 'Waby', '979-988-2402', '1986-02-15 07:15:09', 'M', 186);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jere', 'Burr', '271-478-8248', '1989-01-12 16:43:06', 'M', 78);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Simone', 'Gilliard', '685-601-9338', '2010-07-28 00:29:39', 'F', 363);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Harvey', 'Sleep', '190-938-8317', '2008-02-28 06:50:48', 'F', 488);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marillin', 'Witherden', '812-864-0089', '1979-08-14 18:56:51', 'M', 20);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Demetris', 'Chandlar', '222-637-9258', '1998-04-24 13:48:40', 'F', 397);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Reagen', 'Crowson', '486-371-2066', '1983-05-07 11:04:57', 'M', 160);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Thacher', 'Scambler', '635-863-1201', '1984-11-06 16:34:56', 'M', 468);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maddie', 'Friedman', '427-180-9346', '2006-07-10 16:42:15', 'F', 391);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Haily', 'McGreal', '615-332-4140', '2009-09-27 03:23:04', 'F', 101);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kaile', 'Waddell', '867-159-9309', '1980-09-05 16:52:51', 'M', 46);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Constancia', 'Fraczkiewicz', '588-635-3464', '2003-04-01 06:02:35', 'F', 193);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dickie', 'Dami', '467-981-2856', '1998-12-11 12:39:48', 'M', 159);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Martynne', 'Georgeon', '895-310-8726', '2012-02-01 20:14:49', 'M', 251);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ranique', 'Abramamov', '589-523-6881', '1994-06-14 15:57:47', 'F', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Callie', 'Sisnett', '260-919-9641', '1976-08-06 20:37:09', 'M', 239);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pooh', 'Wilkenson', '713-167-2912', '1999-10-05 10:19:41', 'F', 67);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Saul', 'Grinin', '223-357-7530', '2003-12-16 20:46:43', 'M', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Merrilee', 'Firmin', '667-441-6317', '2001-10-14 04:48:00', 'F', 82);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Weidar', 'Swancock', '578-603-8831', '2005-01-05 18:31:58', 'F', 401);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aubree', 'Glasner', '121-372-1650', '1988-06-15 23:26:40', 'F', 350);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Renaud', 'Staig', '293-912-5258', '1990-01-03 21:43:15', 'F', 443);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shanie', 'Druitt', '421-554-9261', '1982-11-25 02:52:51', 'F', 293);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dianne', 'Chuney', '888-532-7774', '1975-12-15 10:38:36', 'M', 259);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Skip', 'Canet', '998-260-0023', '1985-12-11 15:46:18', 'F', 192);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paton', 'Hatwell', '419-572-7053', '1999-11-14 09:12:11', 'F', 419);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hilary', 'Beaton', '189-112-4220', '1986-08-06 05:16:59', 'F', 50);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Peter', 'Abramovitch', '540-360-9194', '2012-02-21 04:48:19', 'F', 349);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leena', 'Shillabeer', '156-757-9850', '1999-01-13 19:48:31', 'M', 222);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Skipton', 'Bibbie', '144-565-7694', '2005-12-21 18:25:33', 'M', 100);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olag', 'Jumeau', '863-441-3370', '1984-02-10 04:35:53', 'F', 469);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mikol', 'Coldbathe', '240-702-5139', '1988-03-15 15:48:45', 'M', 251);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aliza', 'Beaushaw', '351-232-5180', '1994-11-28 04:31:23', 'M', 124);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Quillan', 'Dawber', '280-966-4805', '2002-04-08 05:16:40', 'M', 431);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gwenore', 'Jukubczak', '647-816-6238', '1978-05-08 13:23:43', 'F', 89);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paulita', 'Mc Meekin', '641-801-7983', '1985-05-25 20:11:29', 'M', 185);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ambrosio', 'Simenet', '176-608-0059', '1984-01-09 02:36:40', 'M', 380);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Don', 'Broose', '508-164-7715', '1981-01-13 11:12:15', 'F', 105);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gisella', 'Tippin', '754-299-6253', '1986-01-15 20:53:59', 'M', 495);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Doe', 'Grubey', '740-124-7841', '2005-12-23 10:33:46', 'M', 422);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Heloise', 'Le Houx', '842-987-4850', '1999-10-06 12:45:24', 'F', 194);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Andros', 'Laight', '153-258-1597', '1998-05-29 10:43:26', 'F', 326);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marti', 'Shackelton', '153-249-1215', '1993-03-20 23:05:28', 'F', 216);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cissy', 'Ashe', '962-715-3475', '2000-01-20 03:13:56', 'F', 496);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vladamir', 'Morphew', '727-469-6895', '1975-01-23 08:37:10', 'F', 110);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Morissa', 'Kitchingman', '934-255-7885', '1992-04-22 20:22:25', 'M', 106);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ysabel', 'Grisdale', '133-794-2577', '2005-08-16 10:29:24', 'M', 33);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Janela', 'Craven', '999-897-5339', '1991-04-02 09:43:13', 'M', 372);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kristal', 'Ferriman', '881-504-6507', '1992-07-13 06:17:47', 'M', 419);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Franz', 'Falvey', '329-916-1430', '2008-05-22 20:25:48', 'F', 367);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Judah', 'Deshorts', '592-249-9720', '2005-08-03 05:17:55', 'F', 343);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Justis', 'Champion', '639-620-6207', '1993-01-08 13:43:04', 'M', 186);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Roy', 'Ilsley', '336-772-0599', '1987-04-10 10:02:49', 'M', 84);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gard', 'Laughrey', '156-294-9871', '1995-09-09 07:42:15', 'M', 51);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rivalee', 'Gibbings', '904-585-9433', '2002-08-16 22:28:28', 'F', 203);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Onida', 'Lasselle', '304-742-0398', '2000-02-03 22:35:43', 'M', 105);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Philly', 'Culbard', '206-740-3292', '1998-05-22 07:56:02', 'F', 75);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Loni', 'Pea', '673-362-5384', '1983-04-09 10:09:25', 'F', 317);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lilah', 'McVeigh', '734-143-0146', '2003-04-28 05:39:58', 'M', 484);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carolin', 'Blaes', '100-455-6701', '1986-01-26 14:53:51', 'F', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fraze', 'Hillyatt', '464-794-3658', '1993-10-23 19:18:45', 'M', 480);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nap', 'Drews', '997-917-2352', '1979-01-26 13:29:17', 'F', 132);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Archambault', 'Comusso', '469-100-4149', '1994-07-04 12:19:01', 'M', 236);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Andromache', 'Hollyman', '832-690-7002', '1999-10-04 18:17:31', 'F', 51);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aleksandr', 'Hanks', '524-557-6753', '1983-09-15 11:53:48', 'F', 457);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Midge', 'Lettice', '134-868-1938', '1979-11-12 14:30:07', 'F', 487);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ofilia', 'Polamontayne', '314-333-1882', '1997-12-15 17:21:33', 'M', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Korella', 'Woodyatt', '645-304-3440', '1999-01-07 02:15:58', 'F', 19);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ilene', 'Lygoe', '244-686-7851', '1978-10-08 10:36:50', 'M', 280);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cozmo', 'Cleen', '985-139-3836', '1993-07-01 10:41:29', 'F', 238);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karlan', 'Geipel', '491-452-8496', '2009-11-26 16:50:32', 'M', 64);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dido', 'Davidesco', '951-124-9251', '2008-08-19 11:04:36', 'M', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Constantine', 'Zuppa', '188-632-3303', '1984-06-02 05:15:07', 'F', 361);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bambie', 'Cradoc', '177-669-7160', '2000-06-05 00:22:42', 'M', 316);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Reagen', 'Izsak', '488-543-9715', '1988-11-07 15:46:11', 'M', 160);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sarina', 'Smallcomb', '752-148-1659', '1986-01-16 13:46:26', 'F', 321);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gisela', 'Robertet', '381-466-5737', '1984-05-12 12:05:47', 'F', 238);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Iain', 'Gilcrist', '730-414-2055', '2000-08-17 15:57:41', 'M', 384);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ulrike', 'Heasley', '982-406-4177', '2008-09-05 20:40:50', 'F', 195);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elfie', 'Edlyn', '986-675-0368', '1989-04-12 12:20:28', 'F', 290);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hilarius', 'Gwioneth', '769-304-7881', '2009-11-29 23:09:04', 'M', 367);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tymon', 'Slyme', '607-393-7044', '1996-05-06 01:08:49', 'M', 214);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brana', 'Venmore', '948-693-7650', '1994-10-02 04:01:01', 'M', 300);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marcellus', 'Elks', '132-223-0958', '1980-09-06 23:00:06', 'F', 410);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Edan', 'Sappson', '663-501-7434', '1982-07-06 19:13:30', 'F', 2);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chery', 'Neno', '757-646-5251', '1987-08-22 21:00:10', 'F', 473);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dale', 'Belch', '607-853-0280', '1977-04-11 13:04:11', 'M', 132);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lyssa', 'Murdie', '162-973-1421', '1984-08-14 22:25:06', 'M', 428);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tadio', 'Bakster', '789-692-4841', '1996-09-13 09:17:32', 'F', 245);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Petronille', 'Kensall', '760-268-2971', '2006-10-03 08:17:00', 'F', 490);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leanora', 'Basnall', '800-847-2890', '1996-03-04 02:28:04', 'M', 280);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Winifield', 'Vost', '241-883-6686', '1983-06-28 07:09:17', 'F', 487);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Arin', 'Alleyne', '244-320-2090', '1985-12-14 20:06:29', 'F', 205);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elie', 'Poge', '995-334-7501', '1986-04-19 11:53:12', 'M', 59);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sheppard', 'McPhail', '318-404-9194', '1989-09-30 03:37:55', 'M', 456);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Merna', 'Huggard', '563-668-9672', '1986-07-17 03:23:31', 'F', 143);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pryce', 'Schulter', '781-666-1207', '1982-06-04 03:28:37', 'M', 489);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marquita', 'Julyan', '832-390-0166', '1976-04-17 01:47:51', 'M', 84);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marty', 'Constantinou', '349-289-6979', '2003-08-11 00:42:55', 'M', 77);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mildred', 'Luckes', '412-605-1292', '2011-06-26 05:16:09', 'F', 392);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Melisande', 'Abby', '816-219-4854', '2003-03-08 09:37:46', 'F', 201);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aurthur', 'Dyble', '719-615-1705', '1984-04-28 20:02:46', 'F', 115);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Itch', 'O''Dougherty', '533-195-4940', '1994-04-19 02:12:15', 'F', 25);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Claretta', 'Neilus', '783-178-8529', '2001-01-16 09:22:24', 'F', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kaitlyn', 'Pheazey', '782-620-8420', '1991-03-16 04:55:41', 'M', 399);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gael', 'Longrigg', '228-767-9053', '1989-05-10 07:13:28', 'M', 206);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marsiella', 'Fries', '668-373-6737', '2012-07-01 15:11:16', 'F', 204);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leighton', 'Twede', '858-345-5771', '1997-03-08 01:54:04', 'M', 384);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kathrine', 'Heinke', '347-584-3403', '1992-05-30 14:40:45', 'F', 315);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aharon', 'Loffhead', '445-602-3222', '1984-06-06 23:18:12', 'F', 398);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Danella', 'Vango', '538-725-1561', '1997-12-02 09:18:17', 'M', 114);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olin', 'Carbery', '188-931-7708', '2001-09-30 13:13:34', 'M', 117);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Benn', 'Espinas', '535-105-6319', '2004-09-23 08:38:06', 'M', 478);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alene', 'Huish', '573-470-8800', '2011-04-09 05:43:42', 'F', 314);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Penni', 'Garfit', '168-875-9457', '1980-02-01 00:46:02', 'M', 222);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Meredeth', 'Prester', '742-447-8493', '1984-05-15 02:53:01', 'M', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Oona', 'Halbeard', '842-213-3023', '1986-11-23 11:06:58', 'F', 301);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Latia', 'McNee', '261-879-4730', '2006-04-29 14:35:45', 'F', 268);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Luella', 'Vergine', '989-129-1852', '2002-04-03 18:35:05', 'M', 307);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cordie', 'Aseef', '270-509-1173', '1985-10-10 21:24:42', 'M', 284);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jenna', 'Nys', '325-692-2878', '1983-08-28 09:57:42', 'F', 169);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Delcina', 'Novic', '545-221-3281', '1996-06-12 07:21:06', 'F', 393);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Holden', 'Trowler', '623-496-4233', '2007-12-15 09:48:15', 'M', 483);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Toinette', 'Crampin', '931-266-2196', '1983-02-07 18:59:19', 'M', 281);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kathlin', 'Greenshields', '238-863-9449', '1992-08-13 08:11:30', 'M', 237);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Coral', 'Debold', '323-168-8265', '1979-06-04 11:54:33', 'M', 170);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Caritta', 'Armsden', '484-206-2093', '2011-10-17 21:56:55', 'F', 159);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joanie', 'Kimblin', '436-590-6410', '2004-11-23 00:32:56', 'M', 286);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Deena', 'Mandre', '175-615-8749', '1992-10-26 00:31:40', 'M', 262);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fifine', 'Greenway', '492-707-1477', '1984-11-23 06:15:24', 'M', 460);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leonerd', 'Flack', '579-225-1860', '2002-07-18 18:26:12', 'M', 9);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Inness', 'Fedder', '301-689-9472', '1998-01-26 06:14:09', 'F', 222);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karie', 'Brockwell', '474-726-7417', '1983-02-09 14:53:55', 'F', 420);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Myrtle', 'Gold', '815-604-6337', '1985-08-14 07:50:09', 'F', 347);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Waldon', 'Curnucke', '833-749-9542', '1978-04-19 01:42:30', 'F', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fredra', 'Chicchetto', '914-743-6460', '1996-02-23 23:21:34', 'M', 173);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alastair', 'Vian', '416-476-5095', '2011-05-15 20:10:08', 'F', 17);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Iolanthe', 'Wharram', '724-429-2535', '1999-11-02 08:48:46', 'M', 356);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marji', 'Karlolczak', '923-558-6662', '1989-01-22 16:19:11', 'M', 71);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nona', 'Madden', '275-723-1539', '1978-07-15 03:41:21', 'M', 209);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ryan', 'Ferreira', '490-298-6776', '1976-03-22 14:38:26', 'F', 129);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wat', 'Aughtie', '765-160-2141', '1977-12-20 18:19:38', 'M', 129);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tracie', 'Maharg', '507-739-7827', '1981-04-16 08:38:50', 'M', 267);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sherlock', 'Knowller', '184-661-6407', '1984-07-02 12:05:32', 'M', 367);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Amii', 'Sowden', '324-763-0923', '2004-07-23 20:38:09', 'F', 465);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Germayne', 'Ranyell', '707-471-3590', '1988-04-10 06:01:52', 'M', 163);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pandora', 'Miko', '219-103-1243', '2003-06-09 01:55:05', 'F', 381);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ciro', 'Pergens', '746-951-8800', '1980-04-08 00:54:37', 'F', 376);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cosmo', 'Cancellario', '819-807-7591', '1990-02-18 16:29:52', 'F', 439);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Harman', 'Scholer', '128-248-6645', '1981-09-22 06:42:00', 'F', 398);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jeth', 'Monteaux', '669-306-3145', '2011-01-12 18:22:16', 'M', 487);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nikoletta', 'Di Franceschi', '134-975-4284', '1981-07-31 01:14:45', 'F', 386);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Torrey', 'Insoll', '144-367-3302', '2000-08-05 22:12:14', 'F', 56);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Danice', 'Kinder', '931-778-0285', '1983-10-28 12:02:59', 'M', 185);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dyanne', 'Whate', '451-141-3311', '2011-06-07 19:07:04', 'M', 104);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Caye', 'Robertet', '774-954-4659', '1986-03-12 10:33:28', 'M', 140);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vidovik', 'Shuxsmith', '686-978-0540', '2003-11-12 09:59:13', 'M', 95);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gamaliel', 'Kestell', '576-102-9307', '2007-10-05 05:34:13', 'M', 498);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Millie', 'Bartot', '561-299-1625', '1985-10-18 12:35:21', 'M', 371);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jorrie', 'Radage', '676-192-7517', '2000-12-02 14:59:23', 'M', 104);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Drugi', 'Ebbetts', '787-887-5754', '1998-07-26 12:40:21', 'M', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kristen', 'Breach', '138-925-6662', '2010-01-12 08:57:19', 'M', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nell', 'Coolican', '771-995-8325', '2008-02-04 07:25:24', 'M', 340);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Doralynn', 'Kinton', '524-821-9640', '1999-12-25 15:54:41', 'F', 112);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Laurel', 'Wyse', '785-615-4269', '1979-03-13 08:53:14', 'M', 164);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Liza', 'Pietrzak', '198-770-5005', '1996-05-29 14:18:15', 'M', 170);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Donica', 'Balsdon', '222-378-8456', '1978-03-05 17:21:54', 'M', 421);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kele', 'Aulds', '937-647-6527', '1977-02-09 06:11:00', 'M', 405);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maximilianus', 'Rennick', '392-869-6431', '1980-12-11 19:44:09', 'F', 220);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vanya', 'Oganesian', '905-372-8996', '1986-08-10 18:53:27', 'F', 480);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Althea', 'Lemerle', '306-645-3660', '1984-09-15 20:23:38', 'M', 18);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Belinda', 'Hadny', '568-662-8107', '1985-01-07 01:11:13', 'F', 94);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fawn', 'Medcalfe', '347-530-3042', '1998-08-11 13:11:27', 'F', 110);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mirilla', 'Dunkley', '280-903-8493', '1981-04-20 16:08:22', 'M', 273);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hermine', 'Sysland', '120-180-2313', '2009-04-26 15:01:44', 'M', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Noland', 'Derycot', '617-326-1456', '1982-06-29 16:31:21', 'F', 212);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lucille', 'Paeckmeyer', '419-487-7686', '1989-06-01 01:51:50', 'F', 246);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wright', 'Salack', '150-407-3923', '2003-11-27 03:54:20', 'F', 344);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Irma', 'Curm', '283-967-0322', '1998-12-03 04:10:20', 'F', 354);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Margy', 'Clemes', '818-136-8507', '1994-10-28 00:24:37', 'M', 212);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kathleen', 'Haselup', '886-857-2574', '1989-12-10 02:02:52', 'F', 423);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rona', 'Stoneham', '845-607-3465', '2011-02-18 00:56:45', 'F', 197);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clark', 'Frisby', '202-216-2264', '1979-06-15 01:41:03', 'F', 86);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kinna', 'Barzen', '853-113-3003', '2004-07-19 05:52:59', 'F', 486);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wiatt', 'Melloi', '498-522-3075', '1997-05-26 16:19:57', 'F', 106);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marie-ann', 'Loreit', '851-470-2116', '2000-12-06 02:49:25', 'F', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Audry', 'Guye', '859-674-6138', '1994-06-08 06:58:12', 'M', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alysa', 'Sowten', '743-677-7151', '1987-02-16 15:32:52', 'F', 334);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sammy', 'Lavalle', '502-464-6436', '1999-09-22 06:37:10', 'M', 469);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vale', 'Ackland', '997-140-6066', '1975-11-03 16:33:43', 'M', 376);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Babbie', 'Chrstine', '499-909-2182', '1983-04-01 05:50:00', 'F', 407);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Roma', 'Hamson', '927-678-0061', '1982-09-03 15:08:44', 'F', 105);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elysia', 'de Keyser', '316-847-2280', '1976-12-08 23:02:37', 'F', 182);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Stanford', 'Boxe', '957-193-5063', '1988-05-30 17:52:23', 'M', 123);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Iseabal', 'Greves', '179-976-7492', '2008-04-26 07:32:02', 'F', 160);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Blanca', 'Sprowles', '124-396-8543', '1998-04-14 08:27:53', 'M', 386);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sherlock', 'Ferrant', '350-733-2320', '1989-07-25 16:14:22', 'F', 496);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Greer', 'Bandt', '462-340-7327', '1976-11-26 22:52:18', 'M', 299);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jody', 'Champe', '960-422-8689', '2004-10-27 05:35:26', 'M', 279);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Issie', 'Eastham', '393-451-3734', '1975-01-07 05:08:04', 'M', 129);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ron', 'Mortimer', '417-164-8947', '1981-08-26 02:25:25', 'M', 270);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nicko', 'Tremellier', '488-535-5087', '2009-12-20 00:19:03', 'M', 197);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karlotta', 'Iianon', '378-509-3184', '1999-05-16 14:27:24', 'F', 137);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Timmi', 'Pryce', '757-281-9396', '1993-09-24 03:29:51', 'F', 25);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Anthia', 'Haddrill', '274-600-8972', '2006-03-14 00:29:19', 'M', 7);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joyous', 'Dumphry', '811-595-0094', '1982-02-06 03:26:44', 'M', 196);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Arden', 'MacAnespie', '950-269-7358', '1981-07-14 17:37:00', 'F', 169);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dollie', 'Maliphant', '939-971-0102', '2009-09-07 16:23:37', 'F', 453);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aida', 'Dinnis', '873-487-1303', '2009-07-13 02:19:18', 'F', 466);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wald', 'Jealous', '186-531-0539', '1996-03-25 13:11:31', 'F', 113);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shela', 'Rantoul', '945-996-7713', '1986-12-22 07:09:37', 'M', 99);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Michele', 'Reford', '640-482-0606', '1977-12-04 07:04:06', 'M', 375);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Penelopa', 'Daltry', '115-891-0660', '2000-04-01 16:29:05', 'M', 295);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Constantino', 'Coch', '407-617-2381', '1999-02-24 03:43:07', 'M', 108);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Helenka', 'Brackenridge', '934-613-0256', '1996-05-26 23:21:28', 'F', 91);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karlens', 'Foukx', '563-218-2554', '2003-04-09 00:24:15', 'F', 474);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Doug', 'Debrett', '115-723-5413', '1975-06-28 07:06:53', 'M', 213);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('West', 'Pilpovic', '976-758-2045', '1984-02-12 11:01:27', 'F', 107);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bertha', 'Harold', '977-207-0759', '1997-07-27 15:58:30', 'F', 241);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dyan', 'Blades', '470-607-2289', '1994-11-07 07:05:47', 'F', 219);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Christen', 'Coleshill', '525-597-0763', '1980-09-11 08:19:27', 'M', 274);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Boycey', 'McGaffey', '115-786-8237', '1979-06-09 18:12:25', 'F', 142);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orson', 'Furnival', '665-947-5466', '1999-11-12 13:43:47', 'F', 123);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elbertina', 'Beecker', '294-406-3166', '2004-07-09 07:37:34', 'F', 390);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Darell', 'Treweke', '683-706-7641', '2008-10-22 06:16:12', 'M', 194);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corbett', 'Trickey', '103-945-9164', '1981-10-23 02:52:57', 'M', 292);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Saba', 'Beevis', '536-207-7932', '1975-09-23 05:28:11', 'M', 74);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marylin', 'Baumaier', '702-476-4132', '1977-09-11 20:08:16', 'M', 405);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gelya', 'Kolodziej', '818-654-7155', '1986-12-17 18:40:43', 'M', 249);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Salvatore', 'Kellogg', '223-842-4162', '2005-11-02 19:07:07', 'M', 132);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mina', 'Barsam', '379-446-7497', '1998-06-06 07:43:20', 'M', 154);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sheba', 'Purvess', '586-281-5806', '2010-04-22 16:17:45', 'M', 425);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Caroljean', 'Flux', '777-306-0763', '1997-01-30 07:27:51', 'F', 134);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sophia', 'Buckhurst', '795-194-3078', '2008-09-17 22:25:24', 'M', 246);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hedvige', 'Jefferies', '115-372-6660', '1989-09-22 10:59:04', 'F', 300);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Madelon', 'Ropp', '652-834-8106', '2002-08-13 06:12:15', 'F', 384);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Smitty', 'Allchin', '301-825-7225', '1978-08-26 09:59:42', 'M', 450);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olin', 'Davidovicz', '230-388-6892', '1996-07-15 22:52:17', 'F', 213);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bibbie', 'Pentony', '610-543-3759', '2012-07-29 01:47:38', 'M', 483);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Samaria', 'Jekel', '714-390-4425', '1991-12-25 11:22:22', 'M', 14);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Udell', 'Sleigh', '909-242-2631', '2007-11-01 15:34:22', 'F', 479);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Isabelita', 'MacCurtain', '313-874-5594', '2007-02-25 10:02:43', 'M', 160);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wolfie', 'Ivkovic', '935-616-8877', '1998-05-22 16:29:08', 'F', 187);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carling', 'Idle', '625-898-5293', '2002-07-29 14:12:40', 'M', 135);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Domingo', 'Surcomb', '640-704-8485', '2001-04-19 23:21:42', 'F', 67);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rickie', 'Kerwood', '811-914-9555', '1996-06-25 11:19:21', 'F', 176);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Greta', 'Mathieson', '329-342-1228', '1999-02-20 21:38:34', 'M', 319);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ashlen', 'Escott', '974-518-4864', '2008-04-11 10:22:14', 'F', 40);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fransisco', 'Grono', '120-121-2205', '1999-11-03 11:54:06', 'M', 307);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vivian', 'Treweek', '695-823-6006', '1995-10-18 08:50:45', 'F', 261);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Patrizio', 'Watson-Brown', '797-132-3904', '1982-11-05 21:17:06', 'F', 361);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('De', 'Wapol', '628-389-4111', '1977-11-27 11:09:31', 'M', 486);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Donal', 'Erni', '144-636-4129', '1991-02-07 09:45:12', 'F', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aubert', 'Nodes', '260-158-7116', '1994-07-04 19:39:50', 'M', 415);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fayth', 'Knatt', '325-658-1237', '1991-12-11 19:52:22', 'M', 317);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bonnibelle', 'Baudoux', '409-453-2230', '2011-07-08 15:24:30', 'M', 420);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alvan', 'Angove', '974-748-4419', '1982-02-17 19:51:02', 'M', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Zelma', 'Broughton', '661-755-3431', '1985-01-21 18:10:07', 'M', 348);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Danice', 'Ashley', '506-468-7108', '1975-06-04 09:06:51', 'M', 439);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Manolo', 'Clemenza', '835-543-3686', '1996-01-15 17:19:55', 'M', 459);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Arabella', 'Cuesta', '568-397-7664', '2003-08-12 14:23:55', 'F', 318);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlye', 'Audry', '555-386-2510', '1977-03-29 08:33:46', 'M', 136);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vincenty', 'Bruckenthal', '864-669-6564', '2001-07-07 15:22:32', 'F', 270);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lorrayne', 'Bromige', '360-441-3415', '1979-11-14 19:52:37', 'M', 368);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Janos', 'Keig', '650-910-3386', '1981-12-31 16:34:38', 'M', 280);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Correy', 'Krauss', '711-856-0075', '1998-05-05 05:44:13', 'F', 451);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Borg', 'Cargon', '482-301-3834', '2009-04-12 17:01:35', 'M', 349);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wynn', 'Sellan', '354-254-3292', '2008-11-19 04:07:56', 'F', 78);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Anny', 'Cussins', '229-503-0182', '2002-08-22 07:09:24', 'F', 277);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ethelda', 'Tanser', '287-349-4170', '1977-12-10 06:18:49', 'M', 192);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Benedick', 'Laetham', '622-443-4485', '1986-07-24 09:35:38', 'M', 373);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Glennie', 'Moughtin', '258-611-3399', '2005-05-19 20:47:09', 'M', 342);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leonora', 'Lemonby', '445-864-3394', '1996-05-15 23:23:11', 'M', 164);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sissy', 'Bickerstasse', '104-694-8990', '2011-05-31 22:32:31', 'M', 262);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlita', 'Nolan', '386-870-0391', '2008-11-14 09:57:21', 'F', 257);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Andros', 'Ferreres', '810-317-8889', '1998-05-23 10:01:21', 'F', 372);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Christy', 'Ricker', '728-628-8104', '1989-08-25 09:12:10', 'M', 314);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Skippy', 'Ferrone', '356-621-9233', '1991-02-22 20:18:04', 'M', 225);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cyrillus', 'Budcock', '171-719-5829', '1984-11-06 00:02:59', 'M', 66);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Murielle', 'Cottle', '267-590-1118', '2002-11-12 19:12:27', 'M', 59);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Umberto', 'Ciccetti', '323-510-7718', '1985-11-06 18:32:26', 'F', 380);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Berte', 'Krienke', '797-318-7713', '1982-05-04 11:34:16', 'M', 431);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rose', 'Fryett', '431-650-5977', '2003-05-01 03:20:38', 'M', 474);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sophie', 'Tousy', '894-985-6679', '2001-09-01 15:49:05', 'F', 122);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Herbert', 'Inkpen', '949-131-1822', '1989-04-04 01:56:03', 'F', 16);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kenneth', 'Paunton', '153-782-2922', '1981-01-06 03:02:10', 'F', 350);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nil', 'Lonnon', '530-929-8672', '2007-08-05 21:42:22', 'F', 46);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Barny', 'Worms', '985-158-2518', '1978-05-05 13:32:14', 'M', 341);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Artemas', 'Durno', '711-797-6266', '1992-01-04 20:30:58', 'M', 343);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Filberto', 'Willars', '568-924-1718', '1995-08-29 16:51:26', 'F', 141);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hettie', 'Sisselot', '731-755-3522', '1991-01-31 22:21:48', 'F', 244);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Zachary', 'Tampling', '807-578-1808', '1988-10-06 20:11:49', 'F', 73);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brooks', 'Hardware', '375-586-9712', '1976-12-06 23:11:34', 'F', 172);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Creigh', 'Dedrick', '763-266-9172', '2000-09-13 22:03:25', 'M', 95);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ebonee', 'Thickin', '652-570-7947', '2001-08-31 09:49:53', 'F', 102);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Reid', 'Domoney', '502-297-9704', '2004-05-17 22:37:10', 'M', 484);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cirilo', 'Dimnage', '488-214-9781', '1979-04-21 21:01:07', 'F', 93);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tristam', 'Baumadier', '965-813-5037', '2004-08-30 08:05:21', 'M', 179);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kippy', 'Wolfinger', '624-339-0227', '2000-03-17 14:59:37', 'M', 432);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Micheal', 'Karchowski', '215-755-8905', '2007-09-28 14:51:16', 'M', 131);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('De', 'Ebi', '976-388-6406', '2005-10-27 22:15:57', 'M', 339);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lynnell', 'Gerger', '972-219-6811', '1978-06-29 06:12:15', 'F', 86);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Luther', 'Sally', '919-590-7230', '1977-01-14 05:46:18', 'M', 79);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ainslee', 'McInility', '177-154-8078', '2010-08-20 09:56:49', 'F', 380);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tripp', 'Chamley', '783-473-9960', '1976-05-22 14:42:33', 'F', 69);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lina', 'Dykas', '415-657-0854', '1985-05-21 14:57:40', 'M', 421);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bobine', 'Marriage', '567-326-8893', '1979-07-06 09:34:04', 'M', 245);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Siana', 'Matteoni', '527-768-9271', '1981-06-02 20:07:21', 'F', 332);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Beckie', 'Doubrava', '700-986-3946', '1990-03-30 01:50:15', 'F', 196);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jedediah', 'Lightwing', '446-564-2043', '1977-03-20 00:46:11', 'F', 313);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kane', 'Izod', '460-773-9650', '1986-02-13 20:13:37', 'M', 226);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lori', 'Tattersill', '242-851-5700', '2005-08-02 13:48:10', 'M', 361);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olympie', 'Presser', '818-908-9282', '1987-11-27 11:36:44', 'M', 308);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dedie', 'Villaret', '585-375-7555', '1992-03-03 23:00:27', 'M', 466);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Keely', 'Roubottom', '585-239-0030', '1985-05-01 15:54:42', 'M', 65);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Anjela', 'Bacop', '105-130-9197', '1994-09-30 01:05:20', 'M', 303);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Roanne', 'Bascombe', '130-805-5238', '1983-08-30 16:27:03', 'F', 79);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brittani', 'Pigney', '835-351-5854', '2004-11-19 21:48:53', 'M', 481);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fredrick', 'McClaren', '906-252-0192', '2000-11-20 15:53:09', 'M', 194);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Astrix', 'Burnall', '367-109-7763', '2007-11-13 10:16:31', 'M', 393);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corbie', 'Heino', '562-307-9262', '1983-03-18 11:21:41', 'F', 299);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vaughan', 'Wynett', '839-248-4264', '2007-10-22 12:23:17', 'F', 386);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Betsey', 'Josipovitz', '856-292-4293', '2012-07-11 04:31:29', 'F', 281);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Steve', 'Fernando', '977-107-0740', '2011-02-12 23:16:06', 'M', 172);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Webster', 'Rack', '417-172-0499', '2002-02-11 11:37:20', 'M', 65);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Inger', 'Defrain', '399-729-4513', '1979-03-01 20:16:25', 'F', 430);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tommy', 'Mickleburgh', '388-357-0381', '1981-12-12 19:47:09', 'F', 117);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Loni', 'Pennrington', '488-686-6615', '2006-04-12 10:30:28', 'M', 458);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Roanna', 'Kinnen', '873-481-5240', '1996-10-17 03:10:52', 'F', 344);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Godiva', 'Portsmouth', '277-713-8311', '2006-03-28 01:04:15', 'F', 178);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Faber', 'Glynn', '296-343-8960', '1980-09-04 11:24:48', 'F', 242);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Emmy', 'Adolfsen', '317-873-2854', '1986-04-16 19:26:13', 'F', 116);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Towney', 'Kipping', '621-235-4825', '2002-06-18 21:03:03', 'F', 423);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Phebe', 'Antic', '204-690-7666', '1995-12-24 11:54:56', 'F', 97);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Barrie', 'Rodenborch', '898-535-5189', '1994-12-11 22:25:47', 'F', 282);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Deeanne', 'Conibeer', '485-232-0629', '2007-12-16 20:28:02', 'M', 269);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corny', 'Drewes', '768-451-7309', '2005-06-29 12:08:35', 'M', 309);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sophia', 'Pope', '566-933-2723', '1978-09-12 09:29:45', 'M', 327);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ambros', 'Demelt', '229-805-2890', '2001-01-27 02:07:22', 'F', 347);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shayna', 'Gullan', '590-173-8436', '1997-06-19 08:23:23', 'F', 26);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Christy', 'Twelve', '478-333-0021', '2006-11-27 18:32:00', 'M', 402);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paulo', 'Theakston', '395-598-9385', '1979-10-05 07:12:20', 'F', 82);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alix', 'Dibdale', '238-429-2048', '1981-09-01 01:31:21', 'F', 450);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Casper', 'Osler', '460-763-2943', '2002-11-18 23:59:00', 'F', 168);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Skipton', 'Smissen', '267-947-0405', '1986-01-26 06:33:09', 'F', 132);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Humfrey', 'McGonigle', '314-781-8409', '1982-01-01 03:47:47', 'F', 138);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hetti', 'MacKellar', '818-104-2108', '2008-10-24 13:25:19', 'M', 280);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nessi', 'Badsey', '396-171-6067', '1984-09-18 11:39:58', 'M', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tish', 'Scoates', '861-222-0762', '2011-01-02 13:35:35', 'M', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cary', 'Loughton', '243-544-2630', '2010-09-22 11:53:20', 'M', 40);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Babara', 'Karby', '392-354-1748', '1985-07-22 22:46:09', 'M', 471);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Julie', 'Fogden', '655-880-7408', '1975-02-14 11:24:50', 'M', 284);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cora', 'McAlpin', '454-775-8281', '2007-08-01 05:05:10', 'F', 45);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ange', 'Lipson', '301-572-2068', '1997-11-02 22:53:28', 'M', 294);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rosene', 'Ducastel', '766-831-8559', '2004-11-30 07:41:04', 'M', 310);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Evy', 'Zmitruk', '549-589-7076', '2007-12-24 00:18:44', 'F', 40);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Candace', 'Just', '794-438-8145', '2003-07-16 09:14:20', 'F', 359);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Justinian', 'Rosenbloom', '810-588-3766', '2002-03-20 01:55:51', 'M', 100);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Reeva', 'Kernaghan', '400-463-6914', '1975-12-30 02:37:29', 'M', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Eilis', 'Murrigan', '724-431-3107', '1987-10-09 08:57:55', 'M', 20);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jacobo', 'Mattholie', '674-752-5331', '1988-06-09 20:08:48', 'F', 121);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Barbey', 'Fowle', '141-479-2647', '1987-03-13 22:46:35', 'M', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gretta', 'Usher', '456-862-5881', '1988-11-30 16:48:10', 'M', 66);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Torin', 'Deshorts', '313-758-4570', '2007-03-26 10:42:55', 'F', 86);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Doroteya', 'Dunabie', '188-197-4707', '1986-05-05 07:01:28', 'M', 483);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Stafani', 'Jahns', '551-203-8833', '1994-01-22 06:00:41', 'F', 286);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rubetta', 'Lovick', '205-721-4663', '1981-10-25 04:55:40', 'M', 447);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Britte', 'Traviss', '225-150-2879', '1989-09-14 15:48:55', 'F', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tildi', 'Tabor', '699-247-9757', '1988-09-10 16:26:43', 'M', 5);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dorie', 'Martineau', '955-928-7752', '2004-02-04 03:10:02', 'F', 300);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maybelle', 'Fawlo', '976-437-5848', '1989-04-23 15:49:35', 'M', 395);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ciel', 'Raiman', '542-315-8832', '1989-03-20 15:18:41', 'F', 160);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Desirae', 'Steinham', '516-789-0164', '2004-10-05 10:51:24', 'F', 252);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Phaedra', 'Twopenny', '819-377-6056', '1999-08-23 16:53:10', 'F', 23);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joly', 'Jzak', '925-568-0198', '1981-07-28 04:26:39', 'M', 123);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Andriette', 'Croney', '322-129-7658', '1976-01-19 15:07:22', 'F', 156);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marc', 'Atyea', '967-344-2062', '1984-04-18 17:53:01', 'F', 471);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Killian', 'Fatharly', '772-926-8306', '1988-07-08 18:50:18', 'M', 351);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nil', 'Halwell', '431-567-7706', '1992-05-29 17:01:28', 'F', 420);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Eadmund', 'Raund', '355-387-6386', '1978-10-19 08:14:58', 'M', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corrie', 'Chazerand', '567-923-7336', '1991-04-14 12:56:01', 'M', 174);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Travers', 'Chartre', '391-428-2052', '2003-09-28 13:43:51', 'M', 197);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orsa', 'Yoxen', '315-639-2830', '1999-04-03 10:22:21', 'M', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Celesta', 'Scoular', '279-771-1556', '1997-03-08 23:02:34', 'M', 181);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Werner', 'Message', '400-138-2646', '2001-02-27 04:58:35', 'M', 404);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Eddy', 'Castellaccio', '450-203-0155', '2010-02-25 17:04:43', 'M', 279);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leeann', 'Villaret', '404-634-1097', '2001-12-02 09:21:39', 'F', 14);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tuesday', 'Scranney', '437-539-9504', '2005-05-29 13:21:04', 'M', 15);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Roi', 'Tebbit', '114-281-9259', '2001-05-06 11:09:20', 'F', 316);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jamie', 'Tidmarsh', '752-505-5241', '1978-12-20 02:19:26', 'F', 172);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elita', 'O''Mullally', '595-501-1110', '2002-04-30 20:38:11', 'M', 149);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alecia', 'Jardine', '339-469-3139', '2005-03-13 22:48:35', 'F', 259);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hayward', 'Goosey', '432-343-4021', '1984-10-13 02:57:08', 'M', 65);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gan', 'Sprowson', '701-895-8663', '1978-03-24 21:33:56', 'M', 161);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Staci', 'Vanyutin', '109-726-9922', '1985-10-31 12:30:02', 'F', 183);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marven', 'Rimmington', '247-102-8624', '2001-10-17 23:54:55', 'F', 414);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Margarete', 'Yea', '488-365-5793', '1979-11-13 17:03:22', 'M', 64);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Flo', 'Huntingford', '708-579-9979', '1994-03-25 11:10:39', 'F', 268);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Oona', 'Watson-Brown', '794-694-2582', '1987-07-14 10:53:58', 'M', 126);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alford', 'Birley', '474-969-1368', '1980-06-26 00:25:16', 'M', 349);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Matthus', 'McGillacoell', '978-163-8326', '1987-08-01 00:46:47', 'F', 465);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ichabod', 'Enders', '642-463-2274', '1990-02-28 20:22:55', 'F', 265);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Risa', 'Treadger', '597-511-5226', '2008-12-14 16:10:47', 'M', 466);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tisha', 'Sommerfeld', '185-852-2763', '1999-12-13 19:32:11', 'F', 345);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Parke', 'Broschke', '206-556-4916', '2000-09-08 02:31:05', 'F', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jackquelin', 'Spight', '727-560-3770', '1977-03-04 04:37:32', 'F', 56);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dalenna', 'Palfreeman', '335-605-8950', '1980-07-20 11:17:03', 'F', 163);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Stavros', 'Rosebotham', '143-476-1104', '2000-01-10 05:26:55', 'M', 154);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Anatol', 'Alps', '532-242-5600', '1989-07-27 07:48:34', 'M', 281);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nev', 'Roscher', '951-662-6753', '2006-05-28 03:53:41', 'M', 1);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sonia', 'Epperson', '119-460-6863', '1990-03-27 06:55:25', 'M', 345);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gil', 'Marguerite', '740-913-2701', '1997-01-31 13:02:05', 'M', 393);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lucio', 'Cadwaladr', '932-506-0432', '1976-04-14 03:58:15', 'F', 224);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sallyann', 'Faers', '162-952-6850', '2001-06-25 13:40:30', 'M', 399);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tamarra', 'Licciardello', '900-155-3786', '1991-03-01 18:05:23', 'F', 45);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gene', 'Bruhnke', '187-894-4516', '2007-03-21 20:07:31', 'M', 498);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Purcell', 'Bernaert', '851-881-4149', '1984-11-12 21:13:30', 'M', 113);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Osgood', 'Jantzen', '268-914-0182', '1982-08-29 18:55:13', 'M', 319);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Trixy', 'Treace', '337-736-9929', '2010-06-11 12:32:07', 'F', 51);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jenifer', 'Brommage', '683-569-1998', '1978-11-01 10:20:05', 'F', 398);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ximenez', 'Eaglesham', '657-789-8570', '1975-06-01 05:34:00', 'M', 500);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Evangeline', 'Shenton', '125-518-5706', '2012-04-27 05:49:05', 'M', 332);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nerita', 'Cowen', '784-882-0118', '1987-11-20 12:59:21', 'F', 440);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jarred', 'Feldheim', '168-717-4667', '2001-03-28 09:39:38', 'M', 391);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Odelle', 'Espina', '293-570-7081', '2000-08-23 02:48:03', 'M', 3);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Priscilla', 'Grew', '224-302-0931', '1984-10-04 01:37:07', 'M', 131);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orion', 'Wintour', '308-646-3477', '1997-02-09 00:29:38', 'F', 202);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kati', 'Adolthine', '975-135-4198', '1980-09-23 07:13:13', 'M', 136);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jabez', 'Romain', '929-605-8251', '1994-03-01 02:40:38', 'F', 104);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elizabeth', 'O''Curneen', '612-676-2342', '1991-10-02 08:10:57', 'F', 273);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Noreen', 'Kirstein', '348-664-8525', '1993-10-18 00:33:50', 'M', 291);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Serena', 'Cottee', '597-234-5863', '1985-02-25 05:18:27', 'M', 254);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Moshe', 'Kilcullen', '434-317-4151', '2001-03-11 05:54:45', 'M', 269);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brannon', 'Remon', '428-760-6944', '2002-11-12 02:59:39', 'F', 381);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Agnella', 'Bruntje', '876-362-8047', '2007-09-01 05:43:51', 'F', 436);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shanna', 'Robe', '490-710-2121', '2002-11-04 07:22:11', 'M', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Celene', 'Savage', '664-426-9034', '1998-08-16 20:01:31', 'F', 19);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Willis', 'Shemelt', '243-761-4424', '1986-05-18 21:43:13', 'F', 403);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bastien', 'Mulhall', '368-677-8618', '2012-07-26 19:55:57', 'F', 264);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ardene', 'Deeming', '460-392-2856', '1990-03-01 21:44:33', 'F', 69);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sharla', 'Fontel', '983-417-3720', '1987-12-20 13:06:34', 'F', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joellyn', 'Buckell', '997-239-8230', '1979-03-14 20:11:23', 'F', 43);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kirstin', 'Cowling', '548-275-0360', '2001-12-07 00:47:12', 'F', 481);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rozanna', 'L''Hommeau', '513-218-9629', '2003-08-18 02:44:39', 'F', 383);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Phil', 'Hadkins', '674-816-2405', '2008-09-06 07:17:39', 'M', 199);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lucio', 'Maltman', '326-545-3076', '2008-10-27 21:58:09', 'M', 23);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Milli', 'Sings', '657-949-8129', '2002-07-11 20:25:49', 'M', 183);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rosana', 'Dicey', '476-463-0115', '2006-08-21 14:40:46', 'M', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ernesto', 'Connerry', '632-386-5474', '1988-08-12 04:41:46', 'M', 270);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Foster', 'Palley', '774-261-3746', '1986-05-17 06:15:18', 'F', 448);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tom', 'Benedyktowicz', '737-170-0762', '1999-02-07 17:42:16', 'M', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chariot', 'Kelling', '191-974-5455', '1988-02-27 19:26:31', 'F', 340);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pierette', 'Darree', '712-970-3094', '1994-10-26 14:21:39', 'M', 201);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alexandre', 'Barrowcliff', '941-111-2319', '1992-02-18 06:15:13', 'M', 240);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Connor', 'Karpenko', '966-615-5928', '1982-12-02 22:49:37', 'M', 94);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Meriel', 'Grummitt', '532-101-8254', '1980-01-07 02:56:59', 'M', 21);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Edd', 'Stonman', '916-452-5725', '1991-07-24 08:51:41', 'F', 317);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Susie', 'Willford', '918-613-9577', '2011-01-02 18:47:46', 'M', 408);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Heidie', 'Scolland', '981-850-4098', '1979-11-28 02:40:43', 'M', 165);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Whitney', 'Gustus', '783-620-8755', '1982-06-28 21:51:57', 'M', 6);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marwin', 'Loudiane', '239-667-4147', '1998-08-04 03:42:30', 'M', 250);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bucky', 'Shann', '597-286-1507', '1982-09-19 11:00:56', 'F', 178);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jonah', 'Finicj', '978-785-7902', '1995-09-12 21:16:00', 'M', 85);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rosemarie', 'Haggata', '945-108-1419', '2004-08-10 18:11:27', 'M', 370);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fiorenze', 'Sherborn', '371-975-9303', '2011-03-26 22:14:08', 'M', 187);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Junie', 'Cordell', '845-768-3973', '1989-03-23 05:19:50', 'F', 247);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tallie', 'Richardes', '424-328-3148', '1998-12-28 19:01:38', 'F', 162);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Augustus', 'Sculpher', '688-475-9745', '1987-09-26 16:52:34', 'M', 187);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nady', 'Sharland', '953-133-6656', '1989-05-26 10:43:49', 'F', 469);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Harwilll', 'Cabena', '509-671-8541', '1997-09-11 09:36:33', 'F', 242);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fernando', 'Donoghue', '946-678-2506', '2012-06-27 12:20:58', 'F', 446);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elly', 'Leeuwerink', '162-778-3964', '1997-11-06 09:26:50', 'M', 442);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tiff', 'Duffill', '200-387-4891', '1989-07-29 04:34:40', 'F', 56);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paulie', 'Dahl', '140-277-1544', '1988-11-01 23:29:11', 'F', 109);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Stace', 'Wellesley', '741-665-3331', '2004-12-26 09:40:56', 'F', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ase', 'Matantsev', '744-380-9840', '1986-12-11 14:58:03', 'M', 119);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Irvin', 'Dubery', '333-969-6337', '1979-03-19 13:00:26', 'M', 309);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maegan', 'Crasford', '506-144-0825', '2006-01-16 05:37:19', 'F', 252);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kori', 'Klazenga', '940-379-7625', '1996-08-24 21:18:24', 'M', 138);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clayborn', 'Getcliff', '902-946-3385', '1983-02-06 23:39:03', 'M', 434);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vernon', 'Padbury', '429-120-3488', '1985-01-12 22:18:34', 'M', 63);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dottie', 'Code', '753-600-9125', '1994-11-11 02:10:12', 'F', 360);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Venita', 'Dayes', '422-481-6716', '2009-12-18 05:00:36', 'M', 337);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aylmer', 'Digg', '917-580-8341', '2006-08-23 15:10:39', 'F', 143);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bertine', 'Patullo', '391-930-2445', '1996-08-29 11:53:42', 'M', 111);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Charla', 'Garioch', '345-456-3323', '1984-05-23 21:58:33', 'F', 343);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Curtis', 'Mealing', '484-406-3207', '2002-08-14 06:32:45', 'F', 402);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Linette', 'Senett', '916-736-1187', '1980-11-25 08:44:11', 'M', 161);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Curry', 'Chainey', '340-409-5839', '2010-10-20 17:48:41', 'M', 440);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Madel', 'Jacobsen', '579-380-9191', '1992-11-30 16:35:09', 'M', 29);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Davis', 'Gorries', '803-289-9721', '1989-02-18 08:49:24', 'M', 433);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Keith', 'Hanwell', '572-776-8159', '2002-07-17 00:28:24', 'F', 431);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hildagarde', 'Ritzman', '266-701-8614', '1997-12-31 16:21:07', 'F', 305);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Morgen', 'Scrimshaw', '562-173-0361', '2011-05-29 20:31:03', 'M', 226);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sigfried', 'Hurn', '133-348-6845', '2011-02-05 21:44:14', 'M', 402);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ermengarde', 'Latus', '782-138-6761', '1990-12-05 15:42:25', 'F', 250);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jenn', 'Tilio', '184-277-0781', '2011-05-19 05:06:38', 'M', 351);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gerome', 'Hasser', '952-506-0294', '2001-08-05 04:18:30', 'F', 356);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Claude', 'Wallbank', '347-623-7081', '2009-06-02 23:43:26', 'F', 456);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Willy', 'Herculeson', '490-690-1895', '1992-05-28 05:21:54', 'M', 229);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Terrel', 'Moorfield', '608-830-1293', '2005-07-22 01:52:08', 'M', 424);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Viki', 'Exton', '623-178-0395', '2005-05-02 14:50:30', 'M', 159);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Trude', 'Davis', '265-124-8960', '1999-08-09 02:58:55', 'F', 341);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Beverley', 'Nani', '854-860-0956', '1986-06-23 19:46:17', 'M', 84);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nananne', 'Twentyman', '605-231-4676', '2009-11-21 19:21:08', 'M', 411);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ilsa', 'Crosskill', '896-147-7383', '1991-01-07 02:33:49', 'M', 481);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mata', 'Antoniottii', '391-431-4485', '1989-10-07 04:21:18', 'M', 226);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rance', 'Durtnall', '647-352-0424', '1997-05-14 00:26:58', 'M', 18);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lexie', 'Jerman', '690-368-2025', '2000-05-10 23:13:35', 'M', 393);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Philippe', 'Murdoch', '425-460-1493', '1979-02-18 01:14:37', 'M', 388);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hunter', 'Pomphrey', '465-780-6365', '1998-04-20 09:11:41', 'M', 77);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Luigi', 'Corten', '281-139-9643', '1983-06-30 01:08:51', 'F', 133);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Katerina', 'Larmouth', '288-855-3110', '1980-05-23 20:00:50', 'F', 301);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Averil', 'Pennicard', '589-327-9736', '1991-04-04 05:15:49', 'M', 419);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gerry', 'Dinsdale', '145-758-4422', '1987-06-29 03:55:17', 'F', 143);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jennifer', 'Di Francecshi', '919-950-9988', '1976-06-29 15:50:28', 'M', 100);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Waiter', 'Yousef', '479-572-2974', '1975-08-04 21:13:36', 'M', 178);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Min', 'Whitsun', '710-317-9083', '2002-09-10 17:43:32', 'M', 207);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Yorgo', 'Beardow', '773-904-9253', '2005-09-16 20:48:04', 'F', 34);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tobi', 'Goodfellowe', '922-274-6775', '1994-04-11 09:13:20', 'F', 281);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jarrod', 'Reddish', '109-491-7679', '1992-03-17 20:08:36', 'F', 316);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aguste', 'Morison', '758-916-8602', '2002-08-18 14:44:02', 'F', 239);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mariana', 'Manuello', '685-760-1168', '1996-06-23 01:00:14', 'M', 28);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ralf', 'O''Tierney', '458-200-3899', '2009-12-24 05:13:40', 'F', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Celestyna', 'Laxton', '345-852-0311', '1981-03-12 03:26:37', 'F', 188);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Keen', 'Lamshead', '495-420-7193', '1985-03-18 12:31:59', 'F', 361);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Antonia', 'Satteford', '474-959-4910', '2004-06-12 10:39:02', 'M', 68);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cedric', 'Whitemarsh', '195-747-7341', '2004-12-27 03:27:28', 'F', 216);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Charline', 'Orrocks', '204-597-4554', '1982-01-15 11:06:15', 'F', 448);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Diane', 'Fallens', '488-363-8048', '1990-02-25 08:23:21', 'M', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karim', 'Dafter', '988-470-7459', '2006-12-15 05:45:09', 'M', 178);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Georges', 'Caldairou', '487-769-4315', '1985-03-12 09:22:25', 'F', 457);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kelsey', 'Briamo', '938-533-3770', '1993-02-21 15:01:34', 'F', 252);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sondra', 'Goodchild', '928-555-3562', '1975-12-12 10:41:44', 'M', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hyacinthie', 'Keneford', '502-204-0033', '1994-09-29 17:05:43', 'F', 298);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mirna', 'Kleinschmidt', '968-123-3096', '1999-08-08 09:16:13', 'F', 70);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Conn', 'Marikhin', '119-372-7904', '1988-06-05 13:00:19', 'F', 194);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ruben', 'Lodge', '337-615-1073', '2007-12-20 02:45:46', 'M', 15);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elisabeth', 'Barnard', '206-629-4698', '1988-07-18 08:48:31', 'M', 350);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Josefa', 'Pennoni', '434-433-0821', '2010-12-08 03:15:15', 'M', 68);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Susanna', 'Grover', '257-961-9234', '1977-04-04 15:15:40', 'F', 332);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dredi', 'Goodliff', '649-283-5849', '1988-08-22 16:45:38', 'F', 421);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hartwell', 'Lundon', '970-138-8425', '2006-06-04 03:45:10', 'F', 153);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clarinda', 'Kincade', '547-491-0522', '2010-10-15 03:04:46', 'M', 341);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sheba', 'Simonel', '917-743-4820', '2011-06-30 18:35:04', 'M', 148);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Baird', 'Mengue', '502-677-5285', '1994-07-08 00:45:54', 'M', 141);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marieann', 'Leyman', '118-148-5894', '1999-08-09 13:27:40', 'M', 389);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hatty', 'Heyworth', '862-800-2507', '2011-08-27 08:01:11', 'M', 445);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sheri', 'Higgoe', '511-424-4784', '1977-09-01 10:35:12', 'M', 119);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joye', 'Falco', '980-752-7661', '1980-11-27 20:06:01', 'M', 277);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kimberlyn', 'O''Hollegan', '600-186-8666', '2010-11-15 18:20:30', 'F', 103);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jewell', 'Kilner', '794-629-9227', '1977-09-28 10:06:54', 'F', 70);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mala', 'Goldis', '529-870-0544', '1977-11-30 15:41:54', 'M', 416);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Caldwell', 'Tydd', '466-301-3101', '1980-02-27 13:19:38', 'M', 158);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kay', 'Evill', '120-669-9293', '1997-11-19 20:10:49', 'M', 49);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brigham', 'Cescot', '915-830-0942', '1994-02-03 14:27:17', 'F', 154);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bernhard', 'Childers', '581-709-8596', '2004-07-01 18:47:05', 'M', 132);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Valerye', 'Housley', '631-674-8942', '2006-07-18 02:04:59', 'F', 58);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Else', 'Newis', '759-359-3229', '2008-06-24 00:50:21', 'M', 118);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Othello', 'Coulter', '459-587-5426', '1994-11-24 13:24:43', 'F', 494);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Angil', 'Blankau', '157-153-4212', '1996-05-06 17:44:15', 'F', 161);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rafaelia', 'Squirrell', '995-396-9204', '1990-05-12 02:31:19', 'F', 498);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sandye', 'Cruxton', '725-576-6901', '1978-04-23 06:37:44', 'M', 445);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Natalee', 'Rallin', '437-634-0670', '2010-09-09 18:03:18', 'F', 13);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Emilia', 'Killcross', '303-724-3537', '1999-01-15 09:20:59', 'M', 164);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chas', 'Shyre', '173-713-7751', '2008-11-20 22:19:18', 'F', 224);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Eleanor', 'Aykroyd', '336-601-0977', '1987-12-19 00:49:34', 'M', 80);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Spenser', 'Hindmore', '310-723-9412', '2008-09-07 21:39:42', 'M', 26);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dode', 'Martinson', '844-196-4397', '1991-05-24 16:23:32', 'F', 182);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rosalynd', 'Fairburn', '280-619-7066', '1991-08-27 22:03:00', 'M', 378);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karissa', 'Weond', '738-981-7385', '2001-03-13 18:28:22', 'M', 288);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fenelia', 'Steggals', '386-919-3665', '1985-09-24 20:08:23', 'F', 348);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lea', 'Harwin', '400-750-2764', '1986-06-14 05:08:12', 'F', 20);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Randene', 'Caveill', '962-980-0871', '2005-08-08 20:13:05', 'F', 221);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Art', 'McCuaig', '305-646-8162', '2002-06-24 15:02:40', 'M', 277);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bennett', 'Edgehill', '579-337-2848', '1987-09-29 17:06:33', 'M', 248);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vasili', 'Issatt', '483-200-5680', '1996-03-05 21:40:42', 'M', 462);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Merrielle', 'Fearne', '130-822-6434', '1992-08-17 00:29:55', 'M', 17);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wilhelm', 'Marmion', '764-465-1797', '1982-02-17 04:47:25', 'M', 1);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ferdy', 'Hullah', '311-646-1620', '1995-05-06 08:41:21', 'F', 220);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Duffy', 'Woolmer', '732-900-4762', '2007-09-21 19:38:12', 'M', 405);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Teodor', 'Nelligan', '601-490-1914', '2005-02-21 15:11:27', 'F', 39);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pen', 'Kupker', '991-616-1245', '1986-05-10 12:20:16', 'M', 111);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jessie', 'Divis', '862-452-1068', '2012-06-14 09:55:40', 'F', 216);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corrie', 'Razzell', '937-931-9102', '1987-09-20 15:32:22', 'M', 407);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dorolisa', 'Middlebrook', '313-342-0876', '2012-05-12 14:15:29', 'F', 190);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Averill', 'Forsdyke', '270-398-0906', '2003-01-16 13:44:05', 'F', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Alejoa', 'Brameld', '412-221-4127', '1981-12-12 11:41:44', 'F', 350);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cristie', 'Orton', '740-633-4060', '2011-07-16 12:48:40', 'M', 311);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lauren', 'Oram', '659-207-5362', '1995-01-15 23:39:40', 'F', 30);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gleda', 'Travers', '786-249-8852', '1991-11-29 00:11:56', 'F', 429);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Abram', 'Duffit', '516-770-6079', '1989-10-22 01:55:56', 'F', 332);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pavia', 'Harly', '988-956-8122', '1996-08-30 18:04:56', 'F', 54);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corbett', 'Eustice', '694-480-2277', '1980-05-16 14:31:58', 'M', 210);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Darice', 'Gellion', '828-621-3652', '1976-09-03 15:17:06', 'M', 309);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Celisse', 'Pods', '616-199-2825', '1989-10-12 09:30:39', 'F', 72);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elston', 'Esp', '936-408-5527', '1984-06-05 00:30:50', 'F', 36);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Otho', 'Coulsen', '726-280-6664', '1997-03-04 02:02:18', 'F', 500);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hale', 'Anderson', '795-779-8706', '1995-06-26 01:32:10', 'F', 149);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dodi', 'Presnall', '580-554-5155', '2006-08-25 04:10:00', 'F', 315);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Manfred', 'Nobriga', '811-710-7262', '1980-07-08 15:29:51', 'M', 60);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Vasili', 'Ruddoch', '532-235-0409', '1986-10-02 09:10:06', 'F', 455);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Emmott', 'Lemonby', '858-797-0575', '2012-08-04 22:28:16', 'M', 308);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paxon', 'Fairweather', '717-675-4361', '1991-04-20 10:12:17', 'F', 388);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bran', 'Sherlaw', '771-758-4399', '1987-09-18 08:12:23', 'M', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Corney', 'Hakewell', '802-899-5324', '1995-06-24 14:47:35', 'M', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hammad', 'Stiger', '838-474-4846', '1983-04-25 04:14:17', 'M', 291);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karissa', 'Korejs', '473-112-0518', '1978-05-28 01:43:41', 'F', 359);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Julita', 'Headey', '835-420-4129', '1981-04-03 00:43:26', 'F', 5);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kelli', 'Velte', '911-668-9838', '1995-11-22 22:57:07', 'F', 143);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jessie', 'Holsey', '245-372-0190', '1976-11-29 17:54:03', 'F', 135);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ardys', 'Cripwell', '166-435-7261', '1989-02-02 10:37:43', 'M', 171);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Angil', 'Benedict', '960-489-5110', '1975-04-14 03:01:17', 'M', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ryon', 'Muschette', '808-832-6713', '1981-08-13 12:32:41', 'F', 374);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Josepha', 'Kenforth', '377-190-1244', '1990-11-05 17:03:45', 'F', 291);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rip', 'Glader', '176-729-6084', '1990-10-09 18:59:42', 'M', 308);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Candice', 'Dyzart', '482-778-5064', '1988-08-28 04:21:31', 'M', 24);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Keene', 'Dunkerk', '291-194-9474', '2000-02-21 16:48:21', 'M', 38);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Riley', 'Pendlebery', '553-194-8166', '1996-09-13 18:08:20', 'M', 292);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Veradis', 'De Courtney', '348-426-7491', '2009-03-25 10:47:49', 'F', 271);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Randi', 'McColm', '566-426-4692', '1988-05-06 04:07:08', 'F', 1);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kelcy', 'Sokale', '721-676-9254', '2008-04-17 19:43:00', 'F', 38);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Donny', 'Matushevich', '364-578-0742', '1981-11-02 04:41:48', 'F', 38);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Halsey', 'Breton', '141-187-3655', '1986-07-06 02:07:11', 'F', 193);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Denise', 'Farlowe', '346-237-1096', '1978-05-26 03:35:03', 'F', 67);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bryce', 'Goldstein', '113-201-8338', '2001-06-30 15:39:32', 'F', 182);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Modestine', 'Barme', '138-999-7794', '1977-12-15 07:57:31', 'M', 154);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Welby', 'McCutheon', '442-116-4428', '1984-07-16 23:38:52', 'F', 3);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Myrtice', 'Paulet', '293-717-6460', '1988-09-28 11:09:42', 'M', 173);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Christie', 'McGarrity', '565-671-8438', '1987-09-14 00:18:53', 'F', 287);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Devina', 'Beckitt', '283-205-5249', '1993-02-04 01:03:14', 'F', 310);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Anthia', 'Peeke-Vout', '186-424-6537', '2010-09-28 00:30:55', 'F', 209);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Korella', 'Steadman', '815-248-8530', '1978-08-04 02:33:25', 'M', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Billie', 'Kleeman', '545-494-0715', '2008-10-25 18:26:40', 'F', 489);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Garth', 'McGeever', '230-823-5786', '1981-03-10 11:08:54', 'M', 23);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dorey', 'Winch', '814-401-1807', '2006-08-08 19:03:38', 'F', 228);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pauly', 'Reihill', '140-492-5783', '2005-12-02 17:13:36', 'F', 337);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Launce', 'Clack', '178-147-7202', '2004-12-18 02:20:24', 'M', 261);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Issy', 'Quayle', '275-836-4772', '1982-07-01 14:20:28', 'M', 466);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Griffie', 'Dawidsohn', '683-348-6016', '1992-06-19 10:53:18', 'F', 453);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Starlene', 'Duesberry', '435-320-6040', '2008-08-03 04:01:44', 'F', 205);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Teodor', 'Cicconettii', '156-821-0281', '2007-03-24 11:51:25', 'F', 391);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kasey', 'Barca', '565-963-3722', '1975-02-28 07:58:06', 'F', 147);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gerrilee', 'Wissbey', '420-182-0806', '1984-09-18 20:00:15', 'F', 136);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tris', 'Giraldon', '263-481-9692', '1976-08-05 13:31:48', 'M', 275);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Revkah', 'Brito', '926-327-0457', '1987-03-11 12:42:49', 'F', 210);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Laurice', 'Felten', '946-228-1318', '2009-08-16 21:43:36', 'F', 103);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Laurella', 'Janek', '627-351-9087', '2006-04-21 04:09:32', 'M', 130);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gerome', 'Waterfield', '134-302-2979', '1993-02-03 21:14:01', 'F', 414);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shawn', 'Guerrieri', '905-889-7140', '1985-09-07 14:11:03', 'M', 172);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Edythe', 'MacCoveney', '756-665-3668', '1986-02-08 14:35:29', 'M', 340);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Janeen', 'Viall', '491-850-4293', '1978-05-03 10:32:04', 'F', 206);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marley', 'Struan', '645-328-0253', '2001-05-11 08:39:06', 'M', 357);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Collie', 'Ffrench', '636-353-9342', '1981-12-26 10:40:46', 'F', 113);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gisella', 'Nears', '126-909-9798', '1998-11-24 13:19:59', 'M', 478);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gianna', 'Lias', '945-502-3916', '1980-07-07 18:52:55', 'F', 79);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Annabella', 'Willox', '284-851-0618', '1992-01-17 10:29:46', 'M', 226);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nellie', 'Deeley', '233-226-4957', '1992-03-13 19:36:21', 'F', 63);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Somerset', 'Whitecross', '768-644-9837', '2005-05-28 21:27:28', 'F', 493);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Taite', 'Boyce', '787-623-8554', '1988-07-20 05:20:29', 'F', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ulrick', 'MacKimm', '266-366-2159', '2002-04-10 19:04:37', 'F', 170);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mollie', 'Membry', '493-469-2163', '1980-10-15 23:02:16', 'M', 267);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ag', 'Guitte', '643-871-0342', '1982-06-10 04:29:44', 'F', 299);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jasun', 'Pittson', '142-739-2079', '1999-05-07 16:20:43', 'M', 150);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Willdon', 'Desseine', '532-627-1396', '2004-07-18 20:20:12', 'F', 140);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Iorgos', 'Primmer', '348-165-4928', '1976-04-11 04:42:24', 'M', 500);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Federico', 'Witherop', '451-719-8916', '1988-08-12 14:30:51', 'M', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clyde', 'O''Rudden', '381-250-1385', '1999-04-10 23:12:04', 'F', 47);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Garner', 'Burgne', '419-821-4483', '1990-03-11 10:36:25', 'M', 181);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tani', 'Callery', '209-580-1471', '1992-07-09 00:46:49', 'M', 195);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Curcio', 'Simenot', '296-524-0507', '2005-11-25 10:30:23', 'M', 121);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Emera', 'Suche', '707-692-2005', '1984-01-20 21:47:47', 'M', 41);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Noble', 'McKeon', '821-991-1870', '1995-11-10 07:13:18', 'M', 192);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Simmonds', 'Gatchel', '257-304-3817', '1998-08-19 20:56:30', 'M', 349);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gifford', 'Eastmead', '100-770-5448', '1997-10-01 17:15:26', 'M', 478);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kathrine', 'Deere', '877-733-7352', '2012-04-25 22:43:11', 'M', 21);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Aurel', 'O''Glessane', '671-331-6528', '2000-07-16 08:31:23', 'M', 291);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marjy', 'Maryott', '594-141-4566', '1991-06-20 05:58:58', 'F', 7);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rois', 'Phoenix', '543-914-8248', '1992-12-12 01:32:49', 'M', 110);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Caz', 'Jeroch', '382-347-6800', '2009-07-29 05:11:18', 'F', 112);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dyna', 'Searle', '892-683-7424', '2011-06-26 12:07:16', 'M', 186);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jamie', 'Fowlestone', '178-163-9777', '1997-06-21 01:05:42', 'F', 155);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maegan', 'Clemmensen', '380-712-8202', '1989-02-28 07:29:30', 'F', 212);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Yancy', 'Stiling', '641-142-6380', '2006-09-20 02:30:11', 'M', 309);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dore', 'Belhome', '691-285-0829', '2006-11-18 22:19:15', 'M', 494);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Barbara', 'Skahill', '166-423-4354', '1980-04-24 09:48:56', 'F', 205);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jan', 'Farran', '519-421-8653', '1996-04-27 12:29:46', 'F', 392);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olympia', 'Giacometti', '529-386-9072', '2003-10-21 18:56:49', 'F', 153);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kellina', 'Spillard', '466-737-3255', '1985-06-08 21:56:15', 'M', 150);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Reinwald', 'Crosoer', '724-169-1883', '1990-10-07 07:40:25', 'M', 427);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jandy', 'Gosswell', '529-717-9327', '1975-08-28 00:25:04', 'F', 157);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Addy', 'Brecknock', '670-343-6882', '1984-03-19 22:22:59', 'M', 269);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Malinda', 'Buncombe', '133-315-4788', '2009-07-21 11:04:15', 'M', 93);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tawnya', 'Catonnet', '861-946-9740', '1987-09-17 14:51:13', 'F', 119);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tabbie', 'Kubczak', '724-229-2090', '1991-07-26 08:24:12', 'F', 460);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bathsheba', 'Waugh', '727-547-8555', '2003-06-13 22:17:52', 'F', 285);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shauna', 'Shippam', '158-718-3205', '1987-02-19 01:55:31', 'M', 88);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Iain', 'Kelly', '953-727-3239', '2006-12-15 17:33:15', 'M', 226);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Leyla', 'Bleue', '862-903-1583', '1984-12-24 12:32:11', 'M', 375);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sunshine', 'Kehoe', '680-825-1799', '1989-05-17 06:03:54', 'F', 196);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Goldarina', 'Lawrance', '854-428-7927', '1990-06-28 15:42:19', 'M', 310);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Julissa', 'Pimerick', '122-728-4893', '2000-03-15 09:37:20', 'F', 278);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Giana', 'Count', '914-878-7062', '1977-07-29 16:05:14', 'M', 179);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mellisa', 'Illing', '808-583-8488', '1987-01-12 20:46:12', 'F', 386);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Claresta', 'Wormald', '853-246-7697', '1980-05-21 14:21:12', 'F', 480);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Margaretta', 'Eborn', '588-209-2997', '1985-03-01 22:02:20', 'F', 222);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kimbra', 'Briance', '351-424-1073', '1992-06-19 18:55:14', 'F', 158);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Courtenay', 'Duckwith', '116-330-7231', '2003-02-12 07:42:56', 'M', 305);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dorolisa', 'Eastmond', '860-882-3308', '1976-06-16 04:06:02', 'F', 227);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Maureen', 'Lafflina', '220-696-3924', '2009-05-17 05:58:49', 'F', 334);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Northrup', 'Matteau', '537-588-4855', '1977-04-06 07:36:04', 'M', 66);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hobey', 'Tuddall', '236-191-8401', '1998-12-12 21:07:06', 'M', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kippie', 'Solman', '100-801-6005', '2004-08-03 04:12:30', 'F', 271);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nikoletta', 'Filip', '321-883-9627', '1990-08-04 17:29:52', 'F', 56);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mellie', 'Gillmor', '543-963-8084', '1989-02-04 13:08:07', 'M', 221);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Camila', 'Spacey', '479-781-4605', '2007-01-13 06:56:24', 'M', 487);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Berti', 'Ratledge', '138-318-2873', '1981-06-20 14:26:56', 'F', 209);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Godfry', 'Mauger', '862-740-5870', '2000-09-06 06:30:10', 'F', 343);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dulcine', 'Sultan', '506-573-3571', '1997-03-25 09:47:25', 'F', 442);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cyrus', 'Woolliams', '210-634-2955', '2011-04-20 20:30:33', 'M', 490);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rickert', 'Longford', '639-493-1407', '1977-01-16 15:18:35', 'M', 262);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Meridel', 'Michelmore', '232-398-6956', '2009-09-10 17:44:02', 'F', 307);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cecil', 'Lambarton', '278-315-7949', '1976-08-19 04:37:54', 'F', 256);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tessa', 'Wones', '607-870-4418', '1982-06-22 06:08:51', 'F', 213);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tarrance', 'Pressman', '571-895-4186', '1987-06-29 23:51:01', 'M', 207);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rurik', 'Mumby', '463-644-1809', '1994-02-27 06:33:22', 'M', 380);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marci', 'Cawthra', '182-719-2404', '1981-04-29 00:09:48', 'M', 407);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Deny', 'Moncreiff', '168-372-0624', '2010-03-28 22:09:03', 'M', 5);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lyssa', 'Shaplin', '751-947-8147', '2002-11-02 15:29:25', 'F', 200);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paulo', 'O'' Molan', '733-990-0377', '2012-05-08 15:11:29', 'F', 261);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ermina', 'Plank', '673-579-7991', '1992-02-03 14:49:28', 'M', 420);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Arielle', 'Roubay', '531-700-0904', '1977-06-27 16:46:27', 'F', 205);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Misha', 'Nancekivell', '887-811-5923', '1998-12-25 06:26:32', 'M', 491);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marcelia', 'Soff', '659-884-3520', '1997-02-15 00:22:39', 'M', 192);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Adolpho', 'Leebeter', '387-629-2432', '1981-12-19 12:19:20', 'F', 92);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tomlin', 'Colombier', '569-125-3539', '2012-05-23 15:40:15', 'F', 465);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Barris', 'Chastenet', '245-179-8560', '1999-06-08 09:56:35', 'F', 107);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nev', 'Jowle', '272-827-9193', '2005-12-02 14:32:42', 'M', 282);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kelsey', 'Dunkley', '927-877-3965', '1999-12-10 07:27:57', 'M', 61);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Berny', 'Cockill', '589-194-3606', '1995-03-08 14:18:20', 'F', 376);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Katuscha', 'Daber', '420-552-4776', '2001-01-31 03:00:49', 'M', 23);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Drake', 'Roubeix', '892-862-9905', '2005-02-22 00:35:48', 'M', 172);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wait', 'Dureden', '173-267-2998', '1987-03-26 07:01:20', 'M', 319);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Harry', 'Yegorovnin', '126-967-6236', '1999-01-20 05:22:52', 'F', 265);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Camel', 'Szimon', '115-810-8415', '2004-11-09 02:47:16', 'M', 301);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gamaliel', 'Branchflower', '471-154-3152', '2001-05-10 08:56:46', 'F', 324);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Herbie', 'Costerd', '231-719-8338', '2010-09-05 07:11:57', 'M', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('My', 'Myrkus', '427-306-9386', '2004-03-29 08:58:23', 'M', 265);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jo ann', 'Magnar', '326-443-5416', '1976-07-08 22:11:19', 'F', 251);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jerry', 'Surphliss', '588-959-0232', '1980-07-22 20:48:24', 'M', 203);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orsa', 'Theseira', '804-882-0539', '1980-10-03 04:57:53', 'M', 337);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bevon', 'Manifold', '785-102-9273', '1975-09-15 16:15:23', 'F', 42);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gav', 'Tureville', '286-877-4673', '1995-07-15 14:27:12', 'F', 99);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fionnula', 'Leadbitter', '823-975-9285', '2003-07-20 15:44:27', 'F', 324);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Otes', 'Brunone', '813-670-7256', '2007-04-21 15:21:34', 'M', 494);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Agathe', 'Blincko', '172-725-1985', '2006-12-17 00:07:56', 'M', 312);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Joycelin', 'MacTeggart', '112-198-1845', '1983-12-27 15:31:12', 'F', 190);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ravid', 'Brookbank', '309-412-9287', '1992-07-17 09:36:49', 'F', 449);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carole', 'Comsty', '417-794-1458', '1990-11-12 14:34:17', 'M', 163);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lissie', 'Mallall', '798-792-6467', '1986-12-19 06:54:25', 'M', 306);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Matty', 'Andreichik', '769-529-1535', '1976-12-08 09:16:24', 'F', 98);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Enrika', 'Quinney', '643-524-6253', '2001-04-03 20:20:43', 'F', 451);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Breena', 'Lisamore', '854-594-1998', '1980-03-14 09:44:56', 'F', 252);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fenelia', 'Felce', '711-212-7069', '2000-12-24 01:50:14', 'F', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ernesto', 'Yegorchenkov', '951-610-3356', '1996-11-15 22:28:01', 'M', 261);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hilario', 'Altham', '775-954-3252', '1986-01-30 09:34:21', 'F', 196);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Pamella', 'Fenlon', '739-826-2151', '1986-02-28 16:48:14', 'F', 367);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Luella', 'Pashenkov', '334-968-9560', '1975-07-17 01:32:50', 'F', 409);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hildagard', 'Schoenfisch', '898-763-5453', '1976-02-18 16:04:26', 'M', 389);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jsandye', 'McLucas', '775-976-6027', '2001-01-24 03:35:51', 'F', 50);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Daven', 'Mowen', '957-951-2264', '1994-04-13 00:49:06', 'F', 19);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Yoko', 'Avramovsky', '970-405-5801', '1987-02-28 13:35:43', 'F', 264);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Durante', 'Kondratovich', '556-746-9009', '1997-06-14 14:38:50', 'F', 106);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Drake', 'Scrancher', '441-476-8315', '1982-07-17 03:10:01', 'M', 131);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlee', 'Terbeck', '424-339-6872', '1977-07-16 14:15:49', 'M', 458);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Myrta', 'Ateridge', '101-214-6369', '1984-04-13 04:09:51', 'M', 327);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sada', 'Raisher', '327-777-8623', '1992-05-26 09:35:30', 'F', 434);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Madelena', 'Charlton', '914-349-8219', '1985-12-18 02:34:42', 'M', 224);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlos', 'Vecard', '185-933-4385', '1983-06-30 04:52:59', 'F', 139);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jeanelle', 'Carlow', '711-874-7450', '1997-12-23 17:58:21', 'M', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brynna', 'McGorman', '942-391-4367', '1990-06-16 07:44:37', 'F', 84);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sarena', 'Tewkesberry', '735-937-7152', '1987-02-06 14:03:22', 'M', 456);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ailyn', 'Prebble', '817-236-3103', '2000-09-11 03:30:35', 'M', 134);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Darbee', 'Roubeix', '937-413-3434', '2000-11-16 12:56:06', 'M', 182);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bailie', 'Antalffy', '363-717-0414', '1993-07-03 04:00:15', 'F', 200);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dyann', 'Shirlaw', '857-757-0736', '2005-12-07 07:52:00', 'M', 73);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Robbert', 'Towne', '129-441-9721', '1988-08-19 09:45:59', 'F', 301);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jase', 'Janiszewski', '604-544-0620', '2011-02-26 07:11:03', 'F', 500);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Susette', 'Konertz', '741-653-1098', '1977-02-19 21:20:33', 'M', 100);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cyb', 'Wannell', '678-905-8225', '2002-08-17 20:42:27', 'M', 453);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Terencio', 'Muzzullo', '967-435-7759', '1990-01-02 05:17:15', 'F', 378);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Grethel', 'Mathan', '406-117-0866', '1996-03-07 11:49:28', 'M', 181);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hammad', 'Euplate', '791-342-1465', '1991-09-21 14:45:58', 'M', 496);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Spense', 'Mayor', '160-760-4823', '1994-01-24 05:12:53', 'M', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tatiania', 'Bailess', '289-364-3063', '2009-11-05 18:48:18', 'F', 449);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marya', 'De Carolis', '216-178-9111', '1992-12-10 00:44:39', 'M', 315);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Agnola', 'Coakley', '980-369-4971', '1979-04-27 09:26:31', 'F', 121);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kinnie', 'Perrott', '865-254-8434', '1994-12-29 19:53:12', 'F', 442);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Gloria', 'Glasman', '869-949-6939', '1999-10-04 10:51:06', 'F', 300);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Binnie', 'Filipczak', '289-621-7954', '2008-05-27 23:03:22', 'F', 310);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Denney', 'Stent', '897-417-5931', '1996-05-10 16:39:16', 'M', 357);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Horatio', 'Phripp', '627-479-7241', '1985-05-22 05:46:02', 'F', 251);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lydie', 'Moulster', '986-952-2819', '1980-04-17 04:44:09', 'M', 46);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nannie', 'Moule', '983-231-2520', '1990-11-05 04:41:56', 'F', 12);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bonita', 'Rego', '127-783-9112', '2005-04-18 22:26:29', 'M', 493);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ilyse', 'Sidney', '475-837-4128', '2003-10-31 01:09:45', 'F', 217);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chucho', 'Whanstall', '530-374-7285', '2011-08-30 03:38:38', 'M', 348);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ora', 'Bum', '707-557-9936', '1987-05-03 08:35:04', 'M', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bibby', 'Alpe', '536-607-8372', '1993-03-09 18:11:23', 'F', 79);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ceciley', 'Bolte', '544-616-4710', '1996-01-29 16:38:08', 'F', 488);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Noelle', 'Headington', '412-558-5177', '1994-06-20 01:00:35', 'M', 173);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Adolph', 'Daymond', '369-702-8973', '1998-01-28 11:03:01', 'F', 248);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Klarika', 'Sutherington', '918-793-1037', '1978-01-15 13:05:07', 'F', 406);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carny', 'Jacox', '177-470-8378', '2005-10-28 03:30:24', 'M', 33);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Merrill', 'Brayson', '824-942-2592', '1981-09-04 12:55:24', 'F', 265);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kathleen', 'Shottin', '351-890-8971', '2009-05-28 17:53:02', 'F', 8);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Moll', 'Waldocke', '179-308-4028', '1998-01-13 07:06:08', 'F', 315);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Annadiana', 'Ehlerding', '350-169-8735', '1978-09-07 10:46:13', 'F', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Illa', 'O''Hoolahan', '681-861-9612', '2002-09-05 11:50:08', 'M', 386);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Steve', 'Cocke', '183-106-3011', '1985-01-12 10:28:58', 'F', 330);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Irwin', 'Biggans', '293-900-2069', '2003-12-21 07:15:30', 'M', 461);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Rickard', 'Gostling', '714-687-6525', '2002-10-31 08:06:09', 'M', 193);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Earlie', 'Servante', '932-940-6099', '1999-12-15 22:00:26', 'F', 285);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tasha', 'Penrose', '680-964-8030', '1990-10-23 23:50:28', 'M', 296);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Annemarie', 'Emslie', '271-286-9241', '2010-09-20 03:13:04', 'F', 269);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Faythe', 'Prawle', '961-219-3940', '1979-08-28 18:03:36', 'F', 188);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Orly', 'Sickamore', '577-884-2774', '2005-01-09 18:43:40', 'F', 147);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Neysa', 'Hodinton', '279-107-8215', '2008-06-12 14:09:55', 'M', 281);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paten', 'Kochl', '432-529-2379', '1976-09-03 07:44:00', 'F', 437);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Grayce', 'Meadmore', '824-835-7513', '2000-09-05 01:10:50', 'F', 441);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Haskell', 'Dubble', '975-628-1206', '1986-03-15 21:53:58', 'F', 410);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Timotheus', 'Brinson', '703-682-9866', '1998-10-12 01:05:44', 'M', 286);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kristoffer', 'Luetkemeyer', '267-704-8087', '2003-03-30 05:24:02', 'F', 43);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Angelika', 'Tiebe', '498-391-5685', '2010-09-04 04:55:37', 'M', 121);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Delmar', 'Sellner', '584-940-1194', '2011-02-21 04:22:58', 'M', 479);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Madelle', 'Wragg', '639-693-0804', '2001-03-15 04:17:41', 'M', 27);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Trisha', 'Ebbrell', '214-724-1279', '1990-09-25 13:51:46', 'M', 429);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Urbano', 'Squelch', '923-718-1042', '1998-08-29 07:23:30', 'M', 49);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Winnah', 'Nathon', '862-192-0247', '2003-12-20 11:21:16', 'F', 181);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('North', 'Dowrey', '222-877-5914', '2001-05-04 15:44:31', 'M', 371);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fin', 'Ajsik', '915-993-8586', '2003-08-07 08:38:55', 'F', 166);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lyndsie', 'Calver', '718-647-0288', '2008-05-04 12:29:27', 'F', 49);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sargent', 'Gormally', '200-881-9950', '2008-09-20 18:08:16', 'F', 301);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brunhilda', 'Esley', '900-715-1955', '2004-07-04 13:24:35', 'M', 448);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Paige', 'Antonellini', '256-864-4082', '1975-01-19 06:05:35', 'F', 218);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jerome', 'Bartoszewicz', '477-493-7649', '1978-12-29 06:36:48', 'M', 126);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Betteann', 'Kobpal', '537-940-0375', '1984-10-19 01:02:06', 'F', 351);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ulberto', 'Gregr', '923-340-1063', '1994-09-29 23:56:31', 'F', 173);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Isa', 'Blumer', '795-240-1361', '1976-11-30 22:17:35', 'M', 238);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elicia', 'Lurner', '787-533-7532', '1981-09-01 01:43:54', 'M', 362);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Guenevere', 'Thynn', '405-799-6313', '1999-03-03 13:06:57', 'M', 246);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dorolisa', 'Reast', '819-523-1231', '1980-01-09 05:03:35', 'M', 253);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Bernita', 'Goggen', '956-238-5051', '2009-09-21 07:23:55', 'M', 203);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Saree', 'Frew', '534-411-8817', '1996-10-23 01:30:04', 'F', 339);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brod', 'Burhill', '923-528-6055', '2002-04-11 05:18:42', 'F', 446);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Livvyy', 'Bullus', '358-961-5414', '1977-01-24 03:38:00', 'F', 138);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Domini', 'Stovell', '882-643-2747', '1983-01-22 07:18:43', 'F', 93);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Dosi', 'Tytterton', '482-182-2475', '2009-12-15 21:04:16', 'F', 420);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Quintilla', 'Reddie', '220-793-1931', '2008-11-20 05:48:01', 'F', 428);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Luelle', 'Burfitt', '543-112-8373', '1996-10-17 22:39:42', 'M', 224);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Marcela', 'Czajkowski', '408-446-0877', '1975-05-20 20:14:22', 'F', 364);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Talyah', 'Pittford', '207-899-7715', '2009-12-23 03:30:44', 'M', 451);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Abra', 'Brewett', '364-861-6941', '1982-01-20 00:20:00', 'F', 44);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Sibyl', 'Bonds', '262-986-6429', '1983-08-29 18:46:07', 'M', 49);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tonie', 'Cicero', '983-226-3420', '2007-06-27 01:30:52', 'M', 22);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hart', 'MacCaffery', '276-230-5581', '1995-10-30 02:49:48', 'F', 133);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Eveline', 'Burdell', '239-583-1088', '1993-08-07 20:43:06', 'F', 62);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Isak', 'Sellstrom', '701-291-1746', '2006-05-12 22:11:01', 'F', 57);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Shelia', 'Menicomb', '189-103-5214', '1998-05-28 09:04:07', 'M', 236);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Carlynn', 'Greggs', '618-330-1628', '1993-04-08 21:23:43', 'F', 354);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jeannie', 'Dosdill', '333-268-1477', '2002-04-08 19:10:28', 'M', 438);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Kristin', 'Mannooch', '488-579-5009', '2008-08-11 21:50:23', 'M', 161);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Fitzgerald', 'Soigoux', '194-864-0096', '1980-03-07 21:08:15', 'M', 397);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Michail', 'Pauncefort', '868-737-4791', '1995-05-10 20:06:51', 'F', 174);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Angil', 'Ridd', '460-282-9511', '1987-02-13 22:44:23', 'M', 313);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olin', 'Tireman', '255-477-8327', '1976-08-09 21:52:45', 'F', 238);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Denney', 'Petrolli', '601-215-2072', '1981-07-05 01:53:16', 'M', 391);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Diarmid', 'Kersting', '122-219-9593', '1998-09-12 19:06:42', 'M', 41);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Briny', 'Ridgwell', '231-754-1360', '1981-08-22 09:51:21', 'F', 353);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Chick', 'Emmanuel', '422-598-1607', '1987-12-18 19:38:34', 'M', 219);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Delilah', 'Hirtz', '926-567-8996', '2012-01-03 00:06:02', 'M', 299);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Benedict', 'Pittaway', '108-844-8093', '2009-03-03 13:38:27', 'F', 438);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cammi', 'Dennitts', '320-470-7461', '1976-12-20 15:10:44', 'M', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Guss', 'Geram', '143-553-9918', '1990-12-10 14:11:36', 'F', 276);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Stacia', 'Trace', '930-824-2929', '1989-02-16 22:08:26', 'M', 482);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Erik', 'Dicks', '221-755-6463', '2007-09-24 04:11:18', 'M', 204);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Libby', 'Weagener', '594-109-8436', '1990-07-16 17:32:15', 'F', 127);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elna', 'Jeffers', '202-171-5587', '2004-03-30 20:05:23', 'M', 279);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Olenolin', 'Derrick', '728-767-9030', '2005-05-20 07:45:31', 'M', 223);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mallorie', 'Ludlem', '937-870-9206', '2006-05-07 10:15:15', 'F', 365);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Britni', 'Knath', '791-996-7456', '1987-02-05 08:18:23', 'M', 457);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Trumann', 'Niave', '876-142-0006', '2002-08-11 03:34:32', 'M', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Noel', 'Hotchkin', '723-153-0182', '1976-12-21 01:35:29', 'M', 257);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Minny', 'Simmons', '639-271-5166', '1994-05-03 23:37:58', 'M', 400);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Agace', 'Jedras', '309-910-7434', '1989-10-11 12:48:39', 'M', 310);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Blaine', 'Wilkins', '365-731-5923', '1982-10-27 07:05:51', 'M', 430);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jeno', 'Bickerton', '330-488-2566', '2011-05-07 08:01:44', 'F', 345);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Veradis', 'Piddington', '393-805-0949', '1998-07-03 00:15:34', 'F', 456);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ermina', 'Borzone', '717-598-1107', '1987-08-12 00:34:04', 'F', 299);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Mar', 'Kill', '879-997-8903', '2010-04-29 06:46:59', 'M', 207);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Clerissa', 'Greggor', '828-903-8713', '1997-08-04 12:14:35', 'M', 204);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Tallie', 'Pecha', '964-999-8398', '1997-11-25 16:17:10', 'M', 33);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Elliot', 'Bondley', '292-540-4261', '1999-06-07 04:20:43', 'F', 451);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Catlee', 'Slaymaker', '484-237-8871', '1999-02-08 22:47:27', 'F', 21);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Brad', 'Tanton', '180-461-2862', '2003-09-21 19:22:25', 'F', 378);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Beatrisa', 'Dohrmann', '851-722-8146', '2005-02-18 23:53:24', 'F', 48);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Oliy', 'Powlett', '227-685-5432', '1976-10-15 21:24:04', 'M', 213);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Hatti', 'Cocker', '198-828-1080', '1987-05-08 18:37:12', 'M', 414);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lorain', 'Melley', '127-475-8571', '1978-08-29 15:25:11', 'F', 219);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Seth', 'Gaither', '563-711-0318', '1990-01-04 23:05:52', 'M', 32);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ashlee', 'Spearing', '503-387-2164', '1989-11-27 07:16:45', 'F', 82);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ara', 'Chaloner', '511-952-5801', '1981-10-30 12:56:19', 'M', 165);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Lindsay', 'Rhyme', '217-273-9824', '2003-08-31 13:19:09', 'M', 53);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Nahum', 'Bugs', '438-512-5637', '1981-08-02 15:08:10', 'F', 61);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Waylin', 'Aughtie', '830-777-3118', '1992-05-02 10:45:20', 'M', 328);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jeffry', 'MacChaell', '590-321-2818', '1976-12-19 06:53:34', 'M', 401);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Jackelyn', 'Gavigan', '528-419-1804', '1997-02-05 23:51:27', 'F', 475);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Daveta', 'De Pietri', '338-969-3756', '1998-04-01 22:31:24', 'M', 417);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Win', 'Brayshay', '675-594-2489', '1984-10-04 15:51:46', 'F', 272);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Adolpho', 'Early', '506-248-0270', '1988-10-17 00:28:15', 'M', 24);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Wylie', 'Fine', '855-389-5227', '1988-09-25 18:28:59', 'M', 238);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Cliff', 'Calderon', '565-246-3905', '2009-01-15 08:33:39', 'F', 378);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Abie', 'Woolner', '969-906-7808', '1999-09-12 22:41:17', 'M', 452);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Saunders', 'Schimon', '162-437-9428', '2008-07-03 12:31:59', 'F', 286);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Karl', 'Blain', '594-256-5755', '1978-12-11 06:27:35', 'M', 4);
insert into Customer
  (FirstName, LastName, Phone, Birthdate, Gender, LocationId)
values
  ('Ky', 'Corroyer', '959-189-2154', '1990-03-27 20:06:45', 'F', 133);



-- *** 1000x Service***
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Audio', 'On Hold', '87.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Internet', 'New', '978.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'VOIP', 'Done', '1004.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'VOIP', 'Cancelled', '760.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'Cancelled', '890.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Mobile', 'Done', '766.36');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'TV', 'Progress', '746.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Leasing', 'Progress', '350.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'TV', 'Progress', '863.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Internet', 'Done', '1151.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Audio', 'New', '1223.85');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Fullstack', 'On Hold', '1147.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Assurance', 'Done', '1318.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'Mobile', 'New', '296.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'VOIP', 'On Hold', '33.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Audio', 'Progress', '12.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Internet', 'On Hold', '572.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Leasing', 'On Hold', '599.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Leasing', 'Done', '875.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'Assurance', 'Cancelled', '1058.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'VOIP', 'On Hold', '745.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Internet', 'New', '1304.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'TV', 'Cancelled', '950.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Leasing', 'New', '744.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Mobile', 'On Hold', '297.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'TV', 'Cancelled', '1366.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Selling', 'Done', '101.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Assurance', 'Progress', '228.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Fullstack', 'Cancelled', '1365.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Audio', 'Done', '1373.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Fullstack', 'Cancelled', '402.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'VOIP', 'Progress', '1401.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Assurance', 'Progress', '311.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'VOIP', 'On Hold', '1229.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Selling', 'New', '1282.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'TV', 'Cancelled', '1250.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Fullstack', 'Cancelled', '246.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Internet', 'Cancelled', '1084.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Leasing', 'Cancelled', '637.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Audio', 'New', '122.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'VOIP', 'Cancelled', '1181.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Mobile', 'Done', '975.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Assurance', 'Progress', '404.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Leasing', 'Progress', '478.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Mobile', 'Done', '540.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'VOIP', 'New', '218.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'VOIP', 'Progress', '1200.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'Fullstack', 'Cancelled', '650.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'TV', 'Cancelled', '10.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'TV', 'Progress', '653.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'TV', 'On Hold', '180.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'VOIP', 'On Hold', '174.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'VOIP', 'On Hold', '934.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Audio', 'On Hold', '377.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Fullstack', 'Done', '216.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Fullstack', 'Cancelled', '1319.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'TV', 'New', '513.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Selling', 'Done', '542.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Assurance', 'Progress', '647.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Internet', 'On Hold', '267.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Leasing', 'On Hold', '967.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Assurance', 'Cancelled', '1233.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Internet', 'Done', '1208.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'TV', 'On Hold', '517.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Assurance', 'Progress', '684.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Fullstack', 'On Hold', '1164.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Assurance', 'New', '333.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Assurance', 'Cancelled', '913.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'VOIP', 'On Hold', '792.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Leasing', 'Cancelled', '1250.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'Progress', '1218.73');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Fullstack', 'Done', '747.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Leasing', 'New', '953.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'TV', 'On Hold', '407.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Audio', 'Cancelled', '1420.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Selling', 'Cancelled', '523.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'VOIP', 'Done', '250.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Fullstack', 'New', '672.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Fullstack', 'New', '277.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'TV', 'Progress', '677.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'TV', 'New', '633.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Internet', 'Done', '439.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Selling', 'On Hold', '254.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'VOIP', 'Done', '1382.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Mobile', 'Done', '401.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Assurance', 'On Hold', '784.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Leasing', 'Done', '753.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Leasing', 'Progress', '71.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'TV', 'Done', '1199.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Internet', 'New', '1321.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Audio', 'Cancelled', '1221.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'Internet', 'New', '1163.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Mobile', 'On Hold', '1349.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Fullstack', 'On Hold', '434.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Leasing', 'Done', '279.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'TV', 'New', '755.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Assurance', 'On Hold', '844.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Mobile', 'Cancelled', '822.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'TV', 'On Hold', '1117.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Gembucket', 'Assurance', 'On Hold', '812.12');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Selling', 'Progress', '429.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Audio', 'Done', '308.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Mobile', 'Progress', '1308.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Selling', 'Cancelled', '1298.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'VOIP', 'Cancelled', '355.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Fullstack', 'On Hold', '790.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'Internet', 'On Hold', '1078.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'VOIP', 'New', '988.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'VOIP', 'Cancelled', '735.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Fullstack', 'New', '114.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Assurance', 'On Hold', '687.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Assurance', 'Done', '717.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Mobile', 'New', '1180.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Audio', 'New', '129.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'TV', 'Cancelled', '1249.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Assurance', 'Done', '1186.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Assurance', 'New', '1170.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'TV', 'Done', '330.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Fullstack', 'Cancelled', '1118.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Assurance', 'On Hold', '439.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Selling', 'On Hold', '780.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Audio', 'Progress', '1420.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'TV', 'New', '681.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Selling', 'New', '74.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Internet', 'On Hold', '380.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'VOIP', 'New', '141.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'VOIP', 'Cancelled', '1336.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Assurance', 'Done', '1117.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Leasing', 'New', '131.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Mobile', 'On Hold', '294.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Fullstack', 'Done', '1172.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Internet', 'Cancelled', '80.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'VOIP', 'Cancelled', '695.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Audio', 'Cancelled', '1303.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'TV', 'Cancelled', '1144.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Mobile', 'On Hold', '130.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Leasing', 'Cancelled', '539.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'VOIP', 'New', '1392.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Assurance', 'Done', '607.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'Done', '796.40');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Internet', 'Progress', '694.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Fullstack', 'Done', '531.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Mobile', 'Cancelled', '199.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Mobile', 'On Hold', '358.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Audio', 'Cancelled', '1170.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Assurance', 'Progress', '488.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'TV', 'On Hold', '576.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'VOIP', 'On Hold', '536.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Leasing', 'On Hold', '124.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'TV', 'Cancelled', '88.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'TV', 'Cancelled', '598.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Audio', 'Cancelled', '637.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Fullstack', 'New', '1277.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'TV', 'Cancelled', '968.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Internet', 'New', '1112.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Mobile', 'Cancelled', '742.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Audio', 'New', '49.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Selling', 'On Hold', '1419.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'TV', 'Done', '1197.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Assurance', 'On Hold', '1116.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Leasing', 'New', '1033.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Fullstack', 'Progress', '765.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'TV', 'Cancelled', '94.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Internet', 'New', '1375.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Zamit', 'Selling', 'Cancelled', '633.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Fullstack', 'New', '90.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Leasing', 'Progress', '86.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'TV', 'Cancelled', '1144.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'VOIP', 'Done', '1095.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Fullstack', 'Progress', '598.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'VOIP', 'New', '1155.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'VOIP', 'Cancelled', '496.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Fullstack', 'New', '474.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Selling', 'New', '1383.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Internet', 'Cancelled', '1122.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Mobile', 'Progress', '295.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Internet', 'New', '1291.34');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Leasing', 'On Hold', '1095.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'TV', 'New', '850.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Assurance', 'Cancelled', '1281.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Fullstack', 'Progress', '1075.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'TV', 'On Hold', '679.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Internet', 'New', '236.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Internet', 'New', '445.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Internet', 'New', '711.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Internet', 'Done', '1332.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Internet', 'Cancelled', '711.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'New', '818.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Leasing', 'Progress', '524.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Audio', 'Progress', '959.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Selling', 'Done', '1400.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Selling', 'Progress', '1355.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'TV', 'On Hold', '1303.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Mobile', 'Done', '588.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'TV', 'Progress', '592.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'TV', 'Progress', '663.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Selling', 'On Hold', '264.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Internet', 'Progress', '643.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Leasing', 'Progress', '234.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Selling', 'New', '364.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Assurance', 'Progress', '1177.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Audio', 'Cancelled', '971.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Leasing', 'Progress', '633.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'TV', 'Done', '75.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Leasing', 'Cancelled', '1204.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'TV', 'On Hold', '412.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Leasing', 'On Hold', '95.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'VOIP', 'Done', '928.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'VOIP', 'Progress', '968.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'VOIP', 'On Hold', '944.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Mobile', 'Done', '743.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'VOIP', 'Cancelled', '1004.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Selling', 'Done', '259.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Assurance', 'On Hold', '1382.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Selling', 'Progress', '775.06');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Fullstack', 'Cancelled', '776.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Fullstack', 'New', '893.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Fullstack', 'New', '1416.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Mobile', 'New', '829.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Fullstack', 'Cancelled', '601.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'VOIP', 'Done', '1036.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Mobile', 'New', '488.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Mobile', 'New', '363.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'TV', 'Done', '653.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'VOIP', 'On Hold', '65.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Internet', 'Cancelled', '1405.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Fullstack', 'New', '1274.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Internet', 'Progress', '1096.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Selling', 'Progress', '1153.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Mobile', 'Cancelled', '602.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Mobile', 'On Hold', '609.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Mobile', 'Progress', '644.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Assurance', 'Cancelled', '347.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Selling', 'On Hold', '1016.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'Fullstack', 'New', '564.12');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Mobile', 'New', '409.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Audio', 'New', '359.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Zamit', 'VOIP', 'Cancelled', '15.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'Internet', 'Progress', '180.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'Selling', 'Done', '1353.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Gembucket', 'VOIP', 'New', '101.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'TV', 'Progress', '701.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Selling', 'Progress', '1407.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Selling', 'Progress', '1353.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Assurance', 'New', '362.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Mobile', 'New', '288.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'VOIP', 'On Hold', '95.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Assurance', 'Progress', '401.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Mobile', 'New', '1371.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Fullstack', 'Progress', '668.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Internet', 'On Hold', '688.22');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'TV', 'On Hold', '1016.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Selling', 'Done', '677.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Internet', 'Cancelled', '447.42');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Audio', 'New', '1292.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'VOIP', 'On Hold', '1382.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Assurance', 'Progress', '143.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Audio', 'Done', '578.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Fullstack', 'Done', '554.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Leasing', 'Progress', '55.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'VOIP', 'Done', '1005.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'TV', 'On Hold', '1128.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Internet', 'On Hold', '575.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Leasing', 'On Hold', '794.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Leasing', 'Progress', '1203.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'VOIP', 'On Hold', '1106.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'TV', 'Cancelled', '651.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Selling', 'On Hold', '1196.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'TV', 'Cancelled', '1287.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Mobile', 'On Hold', '1097.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'VOIP', 'On Hold', '781.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Leasing', 'Done', '1135.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'Audio', 'Progress', '420.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Leasing', 'New', '504.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Internet', 'Progress', '1048.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'VOIP', 'New', '17.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Selling', 'New', '1064.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'TV', 'Cancelled', '30.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Internet', 'Done', '755.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Leasing', 'On Hold', '37.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Fullstack', 'On Hold', '1002.10');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Audio', 'New', '663.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'VOIP', 'Cancelled', '44.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Internet', 'On Hold', '990.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Internet', 'Cancelled', '1322.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Fullstack', 'On Hold', '907.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Audio', 'Done', '566.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Assurance', 'New', '264.35');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Internet', 'New', '605.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'TV', 'Done', '215.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Assurance', 'Done', '190.68');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'VOIP', 'New', '1271.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'TV', 'Done', '1224.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'TV', 'Cancelled', '467.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Assurance', 'On Hold', '1423.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Internet', 'Progress', '220.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Selling', 'Progress', '236.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Leasing', 'Cancelled', '961.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Fullstack', 'On Hold', '1139.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Leasing', 'New', '996.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Mobile', 'Progress', '1169.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Internet', 'Cancelled', '505.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Assurance', 'New', '380.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Assurance', 'On Hold', '903.12');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Assurance', 'Done', '948.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Assurance', 'Cancelled', '1285.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Audio', 'Cancelled', '303.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Assurance', 'New', '836.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Internet', 'Done', '69.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Leasing', 'On Hold', '1176.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Internet', 'Progress', '26.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Selling', 'New', '1307.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Selling', 'Progress', '868.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Fullstack', 'Cancelled', '775.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'TV', 'Cancelled', '849.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Audio', 'New', '1201.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'TV', 'New', '1132.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Selling', 'Progress', '329.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Audio', 'Progress', '1346.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Assurance', 'New', '617.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Internet', 'Cancelled', '345.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Audio', 'On Hold', '549.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Mobile', 'Progress', '737.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'TV', 'On Hold', '448.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'Done', '1383.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'VOIP', 'Done', '68.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Zamit', 'Assurance', 'On Hold', '796.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Leasing', 'New', '127.92');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Assurance', 'Cancelled', '1366.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Internet', 'New', '1246.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Internet', 'Cancelled', '518.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'TV', 'Cancelled', '975.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Mobile', 'New', '803.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Fullstack', 'New', '938.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Assurance', 'On Hold', '376.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'TV', 'Done', '222.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Fullstack', 'On Hold', '1269.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Audio', 'Progress', '296.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Internet', 'New', '1100.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'TV', 'Done', '976.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Hatity', 'Audio', 'New', '86.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Internet', 'Cancelled', '571.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Internet', 'Cancelled', '1273.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Audio', 'Cancelled', '602.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Mobile', 'New', '1337.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Assurance', 'Progress', '1309.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Leasing', 'Cancelled', '1209.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Assurance', 'On Hold', '121.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'TV', 'Done', '271.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Assurance', 'Progress', '1025.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Mobile', 'New', '663.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Assurance', 'On Hold', '1069.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'TV', 'Cancelled', '784.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Assurance', 'Cancelled', '893.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Assurance', 'New', '1152.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Selling', 'Cancelled', '1311.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'TV', 'Cancelled', '412.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Audio', 'On Hold', '1131.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'VOIP', 'Progress', '1040.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Internet', 'Progress', '1378.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Assurance', 'Progress', '242.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Leasing', 'Progress', '248.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Internet', 'New', '718.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Internet', 'Done', '276.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'Done', '146.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Mobile', 'Progress', '468.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'TV', 'On Hold', '558.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'TV', 'Done', '232.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Audio', 'Done', '528.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Internet', 'Cancelled', '142.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'TV', 'Done', '62.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Internet', 'Cancelled', '284.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'VOIP', 'New', '94.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Selling', 'On Hold', '1375.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Audio', 'Done', '976.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Hatity', 'Leasing', 'Done', '735.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Internet', 'Done', '50.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'Assurance', 'Done', '905.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Internet', 'Progress', '121.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Leasing', 'Cancelled', '1188.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'TV', 'Progress', '1326.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Internet', 'Done', '1256.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'TV', 'Done', '174.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'VOIP', 'New', '924.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Mobile', 'New', '1056.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Fullstack', 'New', '1209.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Selling', 'Progress', '820.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Assurance', 'Progress', '62.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Internet', 'Progress', '47.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'TV', 'Done', '1063.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Mobile', 'Progress', '1370.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Fullstack', 'Done', '1055.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Internet', 'Done', '1128.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Leasing', 'Done', '1151.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Mobile', 'New', '318.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Internet', 'Cancelled', '1244.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Assurance', 'Progress', '1137.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Fullstack', 'Cancelled', '1250.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Selling', 'Done', '795.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Leasing', 'On Hold', '52.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Leasing', 'Done', '1004.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Leasing', 'New', '1071.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Selling', 'Cancelled', '882.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Gembucket', 'Leasing', 'Cancelled', '277.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'TV', 'On Hold', '710.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'VOIP', 'Cancelled', '790.92');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'Selling', 'Progress', '991.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Audio', 'Cancelled', '393.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Fullstack', 'New', '171.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Assurance', 'New', '640.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'VOIP', 'On Hold', '848.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'VOIP', 'New', '255.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Audio', 'Progress', '181.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'TV', 'Cancelled', '692.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'Assurance', 'Cancelled', '691.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Internet', 'Cancelled', '789.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'TV', 'On Hold', '1105.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Selling', 'Cancelled', '800.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Fullstack', 'New', '255.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Assurance', 'New', '1342.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Leasing', 'On Hold', '872.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Leasing', 'On Hold', '381.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Audio', 'Done', '156.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Internet', 'Progress', '1013.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Audio', 'Cancelled', '897.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'TV', 'Progress', '573.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Fullstack', 'Done', '97.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'VOIP', 'Done', '890.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'Internet', 'Done', '401.12');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Internet', 'Progress', '658.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'TV', 'New', '1144.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'Cancelled', '721.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Fullstack', 'Cancelled', '509.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'VOIP', 'Progress', '279.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'VOIP', 'Cancelled', '1103.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'TV', 'Done', '670.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Mobile', 'On Hold', '830.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Assurance', 'On Hold', '1366.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'VOIP', 'On Hold', '563.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Audio', 'Cancelled', '1065.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Mobile', 'Done', '409.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'TV', 'On Hold', '1412.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Leasing', 'On Hold', '458.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Audio', 'Done', '1175.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'VOIP', 'On Hold', '938.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'VOIP', 'Progress', '207.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Assurance', 'Cancelled', '380.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'TV', 'Progress', '126.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Leasing', 'On Hold', '1004.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Mobile', 'Done', '138.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Audio', 'Progress', '74.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Fullstack', 'Progress', '1235.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Audio', 'On Hold', '1141.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Audio', 'Progress', '433.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Assurance', 'Cancelled', '508.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Audio', 'Progress', '430.35');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Fullstack', 'Done', '1101.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'VOIP', 'New', '828.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'Internet', 'New', '468.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Fullstack', 'On Hold', '626.68');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Leasing', 'Done', '666.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'VOIP', 'Cancelled', '1043.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Internet', 'New', '1233.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Audio', 'Progress', '1365.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Mobile', 'Cancelled', '314.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Internet', 'On Hold', '1260.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'VOIP', 'Progress', '181.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Mobile', 'On Hold', '732.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Assurance', 'Done', '930.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Mobile', 'Cancelled', '36.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'TV', 'Done', '926.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Mobile', 'New', '1226.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Internet', 'Progress', '1041.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'VOIP', 'On Hold', '394.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Internet', 'On Hold', '626.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'TV', 'Progress', '1228.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Audio', 'Cancelled', '442.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'On Hold', '698.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Hatity', 'Assurance', 'On Hold', '287.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'VOIP', 'Done', '129.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Mobile', 'Progress', '441.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Internet', 'Cancelled', '925.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'TV', 'Done', '904.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Audio', 'On Hold', '1190.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'TV', 'On Hold', '1159.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'VOIP', 'Cancelled', '969.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'TV', 'Progress', '1312.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Selling', 'New', '1131.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Assurance', 'Cancelled', '310.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Selling', 'On Hold', '920.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Mobile', 'Cancelled', '733.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'Fullstack', 'New', '101.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'VOIP', 'Progress', '1248.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Fullstack', 'Cancelled', '1368.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'TV', 'Cancelled', '290.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Selling', 'Cancelled', '1266.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'Audio', 'Progress', '951.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'Internet', 'On Hold', '1254.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Audio', 'Cancelled', '907.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'VOIP', 'Done', '46.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'Assurance', 'Progress', '74.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Mobile', 'Done', '771.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Leasing', 'Cancelled', '730.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'TV', 'Cancelled', '569.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Internet', 'New', '981.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Audio', 'Progress', '1411.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Audio', 'Done', '1375.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'TV', 'Progress', '749.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'VOIP', 'Cancelled', '377.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Selling', 'New', '279.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Internet', 'On Hold', '626.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Assurance', 'Done', '1149.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Assurance', 'Progress', '86.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Assurance', 'Progress', '681.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Selling', 'On Hold', '1209.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'TV', 'New', '1353.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Fullstack', 'New', '258.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Leasing', 'Cancelled', '1369.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Leasing', 'Done', '1359.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Mobile', 'On Hold', '181.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Leasing', 'Done', '486.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Fullstack', 'New', '655.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Selling', 'Done', '1243.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Fullstack', 'Done', '581.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Leasing', 'Cancelled', '242.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Audio', 'Done', '228.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Leasing', 'On Hold', '912.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Mobile', 'Done', '1242.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Internet', 'Progress', '1040.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Leasing', 'New', '1350.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Fullstack', 'On Hold', '1285.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Selling', 'On Hold', '1076.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Internet', 'Progress', '1183.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Assurance', 'Progress', '129.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'TV', 'Done', '372.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'VOIP', 'On Hold', '299.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Selling', 'Done', '1132.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Fullstack', 'On Hold', '188.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Audio', 'Progress', '39.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'VOIP', 'Progress', '354.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Assurance', 'On Hold', '271.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Audio', 'Cancelled', '770.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Mobile', 'New', '802.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'New', '786.14');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'VOIP', 'On Hold', '282.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'Fullstack', 'Done', '334.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'VOIP', 'Done', '161.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Fullstack', 'Done', '1108.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Assurance', 'New', '136.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'TV', 'Progress', '106.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Fullstack', 'Cancelled', '57.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Mobile', 'Progress', '1230.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Fullstack', 'Cancelled', '571.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Assurance', 'Done', '960.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Mobile', 'On Hold', '775.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Assurance', 'Progress', '1079.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Fullstack', 'On Hold', '1029.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Assurance', 'On Hold', '1335.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Selling', 'Cancelled', '1005.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Audio', 'Done', '102.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Internet', 'Cancelled', '890.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Audio', 'Cancelled', '402.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Fullstack', 'New', '1174.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Internet', 'Cancelled', '1210.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'Assurance', 'Done', '792.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Internet', 'Done', '1119.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Leasing', 'Progress', '980.48');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Assurance', 'On Hold', '392.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'TV', 'Progress', '1071.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Mobile', 'New', '161.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Assurance', 'New', '825.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Leasing', 'Progress', '499.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Assurance', 'New', '133.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'TV', 'New', '972.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Fullstack', 'Done', '323.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'TV', 'Done', '1219.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Mobile', 'Progress', '41.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Internet', 'New', '930.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Internet', 'Done', '468.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Assurance', 'Done', '362.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Leasing', 'Progress', '1047.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'TV', 'On Hold', '1186.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'Assurance', 'Progress', '633.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Leasing', 'Cancelled', '241.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Leasing', 'New', '535.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Leasing', 'Progress', '836.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Audio', 'Done', '611.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'TV', 'Done', '100.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Mobile', 'On Hold', '1361.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Selling', 'Done', '1029.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Fullstack', 'Done', '250.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Internet', 'New', '1353.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Internet', 'On Hold', '297.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Fullstack', 'New', '589.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Assurance', 'Done', '1324.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Assurance', 'Cancelled', '654.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Zamit', 'Fullstack', 'Cancelled', '1103.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Leasing', 'New', '831.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Leasing', 'Done', '228.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'VOIP', 'Progress', '287.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'TV', 'Progress', '204.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Leasing', 'New', '770.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Fullstack', 'New', '1137.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'TV', 'Done', '615.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Assurance', 'Progress', '401.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Selling', 'Done', '412.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Mobile', 'On Hold', '451.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Leasing', 'Cancelled', '1141.41');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Audio', 'On Hold', '784.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Selling', 'Cancelled', '753.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Internet', 'On Hold', '775.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Leasing', 'Progress', '137.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Selling', 'Cancelled', '524.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Leasing', 'New', '873.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Assurance', 'Done', '267.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Selling', 'Done', '200.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'TV', 'Cancelled', '370.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Internet', 'Cancelled', '145.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'Leasing', 'Progress', '600.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Leasing', 'Done', '1365.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Internet', 'On Hold', '1316.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Mobile', 'Done', '963.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'TV', 'Progress', '380.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'VOIP', 'Progress', '1067.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'TV', 'Done', '1328.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Internet', 'New', '120.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Fullstack', 'New', '201.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Assurance', 'Cancelled', '1169.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'VOIP', 'Progress', '873.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Assurance', 'On Hold', '133.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'VOIP', 'On Hold', '219.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'Leasing', 'Progress', '780.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Leasing', 'Cancelled', '1227.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Internet', 'Progress', '616.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Mobile', 'Cancelled', '757.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Leasing', 'Done', '1227.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Assurance', 'New', '863.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'VOIP', 'Done', '1214.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Assurance', 'On Hold', '1211.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Internet', 'On Hold', '419.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Assurance', 'Cancelled', '179.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Fullstack', 'Done', '1165.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Fullstack', 'New', '938.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Audio', 'New', '1380.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Mobile', 'New', '425.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Leasing', 'On Hold', '919.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Internet', 'Done', '1043.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'TV', 'Cancelled', '1188.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Internet', 'Cancelled', '1143.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Mobile', 'Progress', '1101.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'VOIP', 'Cancelled', '888.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Internet', 'On Hold', '184.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Leasing', 'On Hold', '1120.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Mobile', 'Done', '1282.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Assurance', 'Done', '1040.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'VOIP', 'Done', '1345.68');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Mobile', 'New', '879.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Assurance', 'Cancelled', '96.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Fullstack', 'Done', '1032.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'Assurance', 'Cancelled', '926.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Selling', 'Cancelled', '1338.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'TV', 'Cancelled', '278.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Assurance', 'Progress', '1098.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Audio', 'Cancelled', '737.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Fullstack', 'Cancelled', '929.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Leasing', 'New', '71.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Assurance', 'Progress', '117.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Audio', 'Progress', '87.73');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Assurance', 'Progress', '1052.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Fullstack', 'New', '1377.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Assurance', 'New', '373.45');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Assurance', 'Done', '902.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Internet', 'Cancelled', '11.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'TV', 'Cancelled', '888.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Fullstack', 'New', '1134.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Internet', 'Cancelled', '986.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Selling', 'New', '652.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Fullstack', 'On Hold', '1178.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Fullstack', 'Progress', '631.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'TV', 'Progress', '809.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Mobile', 'On Hold', '612.68');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Mobile', 'Done', '875.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Audio', 'Done', '790.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Assurance', 'Cancelled', '937.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Assurance', 'New', '910.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Assurance', 'Done', '1322.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Fullstack', 'New', '512.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Mobile', 'Cancelled', '939.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'TV', 'Cancelled', '794.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Leasing', 'On Hold', '972.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Audio', 'Cancelled', '492.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Selling', 'Cancelled', '47.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'Leasing', 'Done', '588.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'VOIP', 'On Hold', '1352.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Fullstack', 'Done', '774.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'TV', 'Cancelled', '924.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Mobile', 'New', '42.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'Leasing', 'Done', '111.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Mobile', 'Progress', '524.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Mobile', 'Done', '928.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Fullstack', 'Cancelled', '1005.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Assurance', 'On Hold', '570.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Fullstack', 'Cancelled', '118.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'TV', 'Done', '1169.81');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'TV', 'Progress', '1235.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Audio', 'Done', '615.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'Internet', 'Progress', '1421.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'TV', 'New', '1067.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Audio', 'Progress', '400.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Selling', 'New', '1389.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Fullstack', 'Cancelled', '1282.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Leasing', 'Cancelled', '510.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Mobile', 'Done', '757.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Assurance', 'On Hold', '73.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'Leasing', 'On Hold', '331.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Assurance', 'Cancelled', '787.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'Leasing', 'Progress', '456.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Internet', 'New', '680.40');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'Leasing', 'New', '1175.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Selling', 'On Hold', '333.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Mobile', 'Done', '893.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'VOIP', 'New', '567.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'Fullstack', 'Done', '1229.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Assurance', 'Cancelled', '371.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Tampflex', 'Audio', 'Cancelled', '201.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'Audio', 'Done', '946.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Assurance', 'Progress', '354.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Assurance', 'Done', '1036.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'VOIP', 'Cancelled', '802.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Mobile', 'Done', '1417.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Fullstack', 'Progress', '1318.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Assurance', 'Done', '158.40');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Leasing', 'New', '1354.01');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'VOIP', 'Cancelled', '1035.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'VOIP', 'On Hold', '692.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'VOIP', 'New', '478.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Audio', 'New', '106.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Selling', 'Cancelled', '1401.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Mobile', 'New', '1353.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Fullstack', 'Cancelled', '298.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Selling', 'Cancelled', '790.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'Audio', 'Cancelled', '717.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'New', '1114.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'Mobile', 'New', '232.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Mobile', 'Cancelled', '14.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Tres-Zap', 'Leasing', 'New', '507.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'TV', 'Progress', '145.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Selling', 'Progress', '959.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Fullstack', 'On Hold', '1246.79');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Leasing', 'On Hold', '471.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Assurance', 'Cancelled', '156.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Fullstack', 'New', '424.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Assurance', 'New', '62.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Selling', 'Cancelled', '1302.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'VOIP', 'Progress', '1212.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Selling', 'Cancelled', '426.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'Mobile', 'New', '809.19');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Internet', 'Cancelled', '463.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'VOIP', 'Progress', '131.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Assurance', 'Done', '459.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Audio', 'New', '617.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Selling', 'New', '536.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Audio', 'Done', '1228.83');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'Selling', 'On Hold', '455.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Selling', 'Cancelled', '209.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Selling', 'Progress', '440.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Selling', 'On Hold', '290.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Duobam', 'Internet', 'Progress', '569.96');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'Mobile', 'Cancelled', '66.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'TV', 'Cancelled', '387.92');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Audio', 'New', '1110.62');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Leasing', 'On Hold', '1414.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Assurance', 'New', '1051.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Mobile', 'New', '1181.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Assurance', 'New', '1382.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'TV', 'Cancelled', '90.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'VOIP', 'On Hold', '954.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Assurance', 'On Hold', '938.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Audio', 'Cancelled', '793.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Mobile', 'Done', '1134.24');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'VOIP', 'New', '499.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'VOIP', 'On Hold', '1240.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Zathin', 'Leasing', 'Done', '253.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'VOIP', 'Cancelled', '490.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Leasing', 'On Hold', '1307.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Fullstack', 'Cancelled', '169.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Fullstack', 'Cancelled', '462.90');
insert into Service
  (Name, Type, State, Price)
values
  ('Biodex', 'TV', 'New', '1347.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Audio', 'Cancelled', '534.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Fullstack', 'Progress', '699.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Assurance', 'Done', '458.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'TV', 'Cancelled', '400.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'VOIP', 'Done', '566.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Assurance', 'New', '806.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Selling', 'Cancelled', '103.52');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Internet', 'Progress', '63.85');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Audio', 'Done', '1290.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Audio', 'New', '872.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Assurance', 'On Hold', '57.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'Fullstack', 'Cancelled', '1348.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Mobile', 'Cancelled', '257.29');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Mobile', 'Done', '759.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'Fullstack', 'Progress', '1188.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Zoolab', 'TV', 'New', '981.68');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Internet', 'Progress', '1017.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Solarbreeze', 'Fullstack', 'Cancelled', '477.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'VOIP', 'On Hold', '1368.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'TV', 'New', '677.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Sub-Ex', 'Internet', 'Done', '613.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Audio', 'Cancelled', '882.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Audio', 'New', '1315.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Fullstack', 'On Hold', '894.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'VOIP', 'Progress', '1327.07');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Assurance', 'Progress', '1393.40');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Internet', 'Progress', '1028.51');
insert into Service
  (Name, Type, State, Price)
values
  ('Otcom', 'Fullstack', 'Done', '1010.39');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'TV', 'New', '386.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Fullstack', 'Cancelled', '612.38');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Audio', 'Cancelled', '181.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'TV', 'Progress', '732.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Mobile', 'New', '767.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Selling', 'New', '1372.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Mobile', 'Progress', '763.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Internet', 'On Hold', '1345.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotlux', 'Selling', 'On Hold', '1378.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Audio', 'Done', '1407.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Gembucket', 'Internet', 'New', '916.42');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'VOIP', 'Done', '681.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Assurance', 'New', '106.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Audio', 'On Hold', '1304.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Tresom', 'Internet', 'Done', '838.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'Fullstack', 'Cancelled', '537.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Leasing', 'Done', '796.57');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'Leasing', 'Done', '175.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Leasing', 'New', '425.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'VOIP', 'Progress', '918.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Fullstack', 'Progress', '328.08');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'TV', 'Progress', '1116.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Regrant', 'Internet', 'On Hold', '1230.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Audio', 'Progress', '1272.12');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Leasing', 'On Hold', '616.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Assurance', 'New', '209.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Selling', 'Cancelled', '470.27');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Audio', 'Done', '331.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Ronstring', 'Leasing', 'On Hold', '990.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Leasing', 'New', '1378.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'TV', 'Cancelled', '1241.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Fullstack', 'Done', '829.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Leasing', 'Done', '1054.32');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Audio', 'New', '979.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'Leasing', 'Cancelled', '1416.03');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Assurance', 'Done', '1136.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Internet', 'New', '265.04');
insert into Service
  (Name, Type, State, Price)
values
  ('Vagram', 'Audio', 'On Hold', '597.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'TV', 'New', '798.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Selling', 'On Hold', '391.58');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'VOIP', 'On Hold', '746.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Leasing', 'On Hold', '902.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Fullstack', 'Progress', '670.22');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'TV', 'New', '330.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Mobile', 'Cancelled', '576.36');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Selling', 'Cancelled', '415.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Leasing', 'New', '1145.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Selling', 'Cancelled', '764.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Internet', 'Progress', '53.70');
insert into Service
  (Name, Type, State, Price)
values
  ('Bamity', 'Internet', 'Cancelled', '1045.09');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Internet', 'New', '562.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Leasing', 'Cancelled', '61.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Greenlam', 'Fullstack', 'New', '491.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Alpha', 'Selling', 'New', '1363.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Internet', 'Cancelled', '566.35');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'TV', 'On Hold', '162.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Fullstack', 'Done', '1409.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'TV', 'Cancelled', '392.95');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-find', 'Mobile', 'On Hold', '1071.48');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Assurance', 'Progress', '186.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Fullstack', 'Progress', '1240.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'Fullstack', 'Progress', '905.46');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Fullstack', 'On Hold', '317.82');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Leasing', 'Cancelled', '255.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Mobile', 'Cancelled', '253.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Assurance', 'Cancelled', '412.92');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Fullstack', 'On Hold', '1031.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Internet', 'On Hold', '372.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Internet', 'On Hold', '696.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Leasing', 'On Hold', '1242.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Subin', 'Mobile', 'Done', '1127.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Fullstack', 'Done', '606.99');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'Audio', 'Done', '643.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Kanlam', 'TV', 'Progress', '1296.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Leasing', 'Done', '228.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Selling', 'On Hold', '1114.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'TV', 'Cancelled', '775.67');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Internet', 'Cancelled', '663.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'Assurance', 'New', '604.92');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Selling', 'Done', '1231.76');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Selling', 'New', '1182.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Hatity', 'Selling', 'Done', '78.49');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Fullstack', 'New', '615.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'VOIP', 'Done', '878.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Selling', 'Progress', '388.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Tin', 'Internet', 'Cancelled', '40.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Mobile', 'On Hold', '955.93');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Audio', 'Cancelled', '950.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Daltfresh', 'Selling', 'Progress', '355.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Assurance', 'Cancelled', '618.59');
insert into Service
  (Name, Type, State, Price)
values
  ('Zamit', 'Fullstack', 'On Hold', '382.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'Mobile', 'New', '387.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Voyatouch', 'Internet', 'Done', '531.54');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Mobile', 'Cancelled', '390.45');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Internet', 'Done', '883.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Assurance', 'New', '1268.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Pannier', 'Internet', 'Progress', '1370.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Toughjoyfax', 'Leasing', 'Progress', '658.89');
insert into Service
  (Name, Type, State, Price)
values
  ('Trippledex', 'Assurance', 'Progress', '568.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Holdlamis', 'Selling', 'On Hold', '1128.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'VOIP', 'Progress', '731.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Andalax', 'Audio', 'Progress', '1412.28');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardguard', 'Audio', 'Done', '1219.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'TV', 'New', '1104.53');
insert into Service
  (Name, Type, State, Price)
values
  ('Aerified', 'TV', 'Progress', '510.72');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Audio', 'New', '831.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Mobile', 'On Hold', '749.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'TV', 'On Hold', '31.71');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'TV', 'New', '1185.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Selling', 'Cancelled', '641.14');
insert into Service
  (Name, Type, State, Price)
values
  ('Opela', 'Internet', 'Done', '103.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'VOIP', 'Progress', '826.91');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Leasing', 'Progress', '1058.26');
insert into Service
  (Name, Type, State, Price)
values
  ('Fix San', 'Mobile', 'New', '559.05');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'VOIP', 'Progress', '915.06');
insert into Service
  (Name, Type, State, Price)
values
  ('Gembucket', 'Fullstack', 'New', '410.77');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'VOIP', 'On Hold', '1106.09');
insert into Service
  (Name, Type, State, Price)
values
  ('Mat Lam Tam', 'Leasing', 'Progress', '1008.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Lotstring', 'Mobile', 'Cancelled', '1108.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'Leasing', 'Cancelled', '810.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Viva', 'Assurance', 'Done', '1421.18');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Audio', 'Cancelled', '1075.73');
insert into Service
  (Name, Type, State, Price)
values
  ('Zaam-Dox', 'Audio', 'Cancelled', '1247.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Temp', 'Internet', 'New', '81.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'Mobile', 'Done', '561.43');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Assurance', 'Done', '828.13');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'TV', 'New', '599.97');
insert into Service
  (Name, Type, State, Price)
values
  ('Veribet', 'Mobile', 'New', '1093.64');
insert into Service
  (Name, Type, State, Price)
values
  ('Voltsillam', 'TV', 'Done', '597.06');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Fullstack', 'On Hold', '211.44');
insert into Service
  (Name, Type, State, Price)
values
  ('Home Ing', 'TV', 'New', '300.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Internet', 'New', '24.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Flexidy', 'TV', 'Cancelled', '1042.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Audio', 'On Hold', '673.23');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Assurance', 'New', '358.55');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklab', 'Internet', 'Done', '1116.25');
insert into Service
  (Name, Type, State, Price)
values
  ('Bytecard', 'Fullstack', 'Cancelled', '613.63');
insert into Service
  (Name, Type, State, Price)
values
  ('Asoka', 'Fullstack', 'Progress', '1317.34');
insert into Service
  (Name, Type, State, Price)
values
  ('Bigtax', 'Fullstack', 'New', '909.81');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitchip', 'VOIP', 'New', '955.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Audio', 'Done', '1105.47');
insert into Service
  (Name, Type, State, Price)
values
  ('Rank', 'Assurance', 'Progress', '1074.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Stim', 'VOIP', 'Done', '553.50');
insert into Service
  (Name, Type, State, Price)
values
  ('Matsoft', 'Audio', 'New', '538.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'TV', 'Cancelled', '166.11');
insert into Service
  (Name, Type, State, Price)
values
  ('Treeflex', 'Leasing', 'Done', '864.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Quo Lux', 'Audio', 'Cancelled', '701.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Tempsoft', 'Audio', 'Cancelled', '881.94');
insert into Service
  (Name, Type, State, Price)
values
  ('Job', 'VOIP', 'Done', '343.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Assurance', 'Cancelled', '1224.05');
insert into Service
  (Name, Type, State, Price)
values
  ('It', 'Selling', 'Progress', '1012.56');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Mobile', 'Progress', '788.66');
insert into Service
  (Name, Type, State, Price)
values
  ('Overhold', 'Leasing', 'New', '391.00');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonair', 'Selling', 'Cancelled', '1277.37');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Audio', 'Cancelled', '157.02');
insert into Service
  (Name, Type, State, Price)
values
  ('Stronghold', 'Assurance', 'Progress', '973.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Ventosanzap', 'Mobile', 'New', '1423.75');
insert into Service
  (Name, Type, State, Price)
values
  ('Zontrax', 'Mobile', 'Done', '1114.88');
insert into Service
  (Name, Type, State, Price)
values
  ('Flowdesk', 'Internet', 'Cancelled', '48.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'TV', 'Progress', '1043.21');
insert into Service
  (Name, Type, State, Price)
values
  ('Keylex', 'Selling', 'Progress', '1281.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Redhold', 'Leasing', 'New', '1184.60');
insert into Service
  (Name, Type, State, Price)
values
  ('Y-Solowarm', 'TV', 'Cancelled', '1230.33');
insert into Service
  (Name, Type, State, Price)
values
  ('Konklux', 'Leasing', 'Done', '937.10');
insert into Service
  (Name, Type, State, Price)
values
  ('Wrapsafe', 'Internet', 'New', '1409.84');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Selling', 'New', '217.20');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'TV', 'Done', '1014.86');
insert into Service
  (Name, Type, State, Price)
values
  ('Span', 'Leasing', 'New', '1345.80');
insert into Service
  (Name, Type, State, Price)
values
  ('Prodder', 'Internet', 'New', '397.98');
insert into Service
  (Name, Type, State, Price)
values
  ('Namfix', 'Mobile', 'On Hold', '1315.17');
insert into Service
  (Name, Type, State, Price)
values
  ('Stringtough', 'TV', 'New', '472.31');
insert into Service
  (Name, Type, State, Price)
values
  ('Latlux', 'Fullstack', 'On Hold', '813.61');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Selling', 'Done', '1198.74');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'Fullstack', 'On Hold', '1227.78');
insert into Service
  (Name, Type, State, Price)
values
  ('Fintone', 'Mobile', 'Done', '1279.16');
insert into Service
  (Name, Type, State, Price)
values
  ('Transcof', 'Selling', 'Done', '1090.69');
insert into Service
  (Name, Type, State, Price)
values
  ('Cookley', 'Assurance', 'New', '552.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Bitwolf', 'TV', 'On Hold', '1068.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Fixflex', 'TV', 'Cancelled', '213.30');
insert into Service
  (Name, Type, State, Price)
values
  ('Sonsing', 'Assurance', 'New', '44.87');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'Assurance', 'Cancelled', '1388.15');
insert into Service
  (Name, Type, State, Price)
values
  ('Domainer', 'VOIP', 'Cancelled', '1144.65');
insert into Service
  (Name, Type, State, Price)
values
  ('Alphazap', 'TV', 'Progress', '902.29');
insert into Service
  (Name, Type, State, Price)
values
  ('Cardify', 'TV', 'Done', '410.82');



-- *** approximately 1500x Contracts from 2005 up to 2021 ***
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (955, 30, 14, 52, '2005-08-15 02:58:02', '2005-01-18 10:20:55', '2008-07-27 09:16:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 68, 2, 65, '2005-01-24 01:54:07', '2005-02-16 11:32:13', '2006-04-05 23:17:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (160, 724, 21, 72, '2005-11-15 07:45:42', '2005-05-13 06:47:21', '2007-06-13 23:16:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (573, 147, 36, 96, '2005-04-25 04:47:30', '2005-05-15 03:35:36', '2007-10-15 00:23:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (153, 880, 33, 50, '2005-05-19 08:02:22', '2005-02-06 10:11:17', '2006-10-05 12:36:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (411, 291, 27, 47, '2005-01-14 02:19:57', '2005-07-16 06:43:00', '2007-04-29 01:13:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (462, 265, 12, 76, '2005-04-29 01:22:21', '2005-07-02 21:02:25', '2006-08-25 10:21:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (238, 280, 28, 7, '2005-06-03 21:04:31', '2005-05-17 05:37:42', '2006-08-24 09:50:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (876, 210, 25, 97, '2005-10-04 17:02:05', '2005-03-25 16:52:35', '2006-08-26 18:21:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (306, 138, 7, 65, '2005-12-11 12:05:48', '2005-05-29 13:22:13', '2006-10-01 14:06:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (949, 512, 18, 70, '2005-12-18 01:27:50', '2005-03-18 09:52:29', '2006-05-28 16:38:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (789, 395, 40, 56, '2005-05-23 05:41:35', '2005-04-29 12:18:59', '2008-01-30 06:41:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (937, 13, 25, 3, '2005-10-09 10:19:38', '2005-07-08 12:48:30', '2006-11-13 20:36:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (723, 183, 17, 7, '2005-05-04 10:25:30', '2005-07-11 02:20:59', '2007-08-25 03:38:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (105, 728, 14, 28, '2005-08-06 00:23:30', '2005-02-10 06:08:48', '2006-04-28 08:59:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (732, 860, 6, 3, '2005-11-19 00:09:16', '2005-01-05 09:42:30', '2006-11-06 06:47:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (999, 284, 2, 90, '2005-02-06 09:06:10', '2005-06-15 19:41:27', '2007-05-24 05:25:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (820, 249, 39, 1, '2005-05-22 09:51:49', '2005-03-26 00:04:57', '2008-02-10 04:25:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (162, 503, 20, 61, '2005-07-22 21:44:47', '2005-02-06 17:28:34', '2007-07-10 05:00:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (861, 280, 3, 67, '2005-03-29 16:50:37', '2005-02-22 06:03:03', '2008-02-06 00:33:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (502, 711, 39, 82, '2005-04-02 08:42:32', '2005-05-07 14:51:43', '2006-10-25 20:45:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (92, 936, 27, 10, '2005-06-01 03:58:44', '2005-05-02 23:31:11', '2007-08-14 07:42:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (282, 779, 36, 35, '2005-10-08 03:22:36', '2005-05-01 21:04:14', '2008-01-02 12:01:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (297, 154, 1, 14, '2005-03-30 14:45:13', '2005-02-12 13:56:29', '2007-03-22 18:07:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (953, 477, 26, 42, '2005-01-18 03:08:57', '2005-04-17 11:35:53', '2006-10-19 17:50:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (706, 321, 13, 29, '2005-04-23 03:43:57', '2005-07-11 14:41:00', '2007-04-26 09:01:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (479, 949, 29, 74, '2005-06-23 01:01:47', '2005-05-29 01:40:00', '2006-11-26 17:47:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (589, 230, 32, 57, '2005-06-06 00:16:26', '2005-02-27 04:38:10', '2006-10-27 02:00:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (825, 938, 9, 51, '2005-05-20 16:25:06', '2005-05-14 05:03:06', '2007-01-13 06:47:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (613, 38, 2, 99, '2005-10-30 20:52:43', '2005-05-13 11:27:07', '2007-02-14 21:29:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (181, 400, 40, 41, '2005-02-25 00:04:11', '2005-04-04 15:52:29', '2007-04-09 07:31:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (89, 90, 17, 80, '2005-12-19 21:43:17', '2005-05-28 14:00:10', '2007-02-14 23:01:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (168, 351, 10, 54, '2005-10-28 22:14:39', '2005-01-08 01:59:44', '2006-09-01 07:32:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (214, 974, 4, 32, '2005-04-29 09:50:32', '2005-07-24 00:09:56', '2008-03-27 22:38:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (869, 636, 16, 48, '2005-01-20 10:38:17', '2005-01-12 23:37:21', '2006-04-17 15:19:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (389, 321, 22, 48, '2005-07-25 04:27:04', '2005-07-03 23:45:01', '2007-06-01 17:43:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (67, 700, 34, 2, '2005-09-19 14:03:35', '2005-03-26 06:13:09', '2006-11-08 15:57:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (316, 911, 19, 3, '2005-04-09 20:52:36', '2005-07-08 21:58:21', '2007-07-22 23:18:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (184, 846, 10, 54, '2005-09-25 19:26:48', '2005-04-01 07:59:58', '2007-01-28 02:45:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (620, 489, 36, 22, '2005-08-23 01:48:09', '2005-06-26 08:57:02', '2007-04-07 16:15:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (340, 598, 12, 78, '2005-03-18 10:55:02', '2005-07-31 10:52:35', '2006-05-14 04:44:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (902, 478, 20, 17, '2005-06-23 03:00:22', '2005-03-06 10:43:24', '2007-06-19 01:50:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (399, 409, 6, 90, '2005-03-13 12:45:43', '2005-07-22 08:39:21', '2007-10-31 23:00:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (573, 804, 40, 60, '2005-01-01 16:08:40', '2005-02-12 17:24:41', '2008-04-20 14:29:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (164, 447, 12, 33, '2005-09-04 10:42:06', '2005-04-30 19:28:42', '2007-04-08 09:59:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (113, 612, 34, 11, '2005-08-28 04:56:12', '2005-02-16 17:03:13', '2006-10-01 01:40:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (420, 537, 31, 5, '2005-12-10 03:33:17', '2005-05-09 11:43:40', '2006-10-07 17:52:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (148, 253, 34, 83, '2005-10-18 13:02:15', '2005-03-04 04:43:48', '2007-10-26 22:36:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (26, 368, 13, 59, '2005-01-26 02:15:12', '2005-06-16 13:02:54', '2007-07-06 02:58:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (93, 833, 22, 83, '2005-02-18 18:16:14', '2005-04-22 21:15:03', '2008-02-08 23:22:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (774, 432, 19, 12, '2005-09-20 05:43:50', '2005-06-10 09:19:58', '2008-02-10 17:53:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (402, 754, 27, 58, '2005-01-09 18:27:01', '2005-01-19 07:38:35', '2006-08-18 01:43:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (20, 836, 28, 71, '2005-12-16 06:37:35', '2005-03-17 19:54:34', '2007-07-24 22:10:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (131, 116, 18, 48, '2005-01-12 15:37:02', '2005-04-04 04:59:48', '2008-01-24 13:36:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (994, 252, 14, 12, '2005-06-17 09:52:01', '2005-02-27 22:44:40', '2007-01-12 20:59:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (67, 65, 14, 40, '2005-05-16 08:14:31', '2005-02-25 23:07:36', '2006-11-10 05:53:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (723, 514, 17, 13, '2005-08-24 04:45:30', '2005-02-04 10:22:25', '2006-08-27 11:30:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (330, 998, 34, 32, '2005-10-14 21:05:57', '2005-06-18 09:39:43', '2006-10-12 23:59:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (762, 973, 38, 23, '2005-02-18 02:07:22', '2005-06-29 22:47:16', '2007-10-26 19:21:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (815, 875, 30, 96, '2005-08-26 06:37:06', '2005-05-09 11:34:55', '2006-04-27 16:12:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (123, 696, 26, 69, '2005-01-07 14:37:08', '2005-03-31 23:49:19', '2008-08-05 03:05:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (214, 579, 29, 72, '2005-03-31 06:56:10', '2005-01-13 12:11:09', '2006-06-22 07:59:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (504, 320, 25, 97, '2005-02-18 20:38:17', '2005-04-17 00:38:48', '2007-03-30 07:24:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (681, 604, 2, 71, '2005-05-18 06:08:50', '2005-04-02 18:01:10', '2007-02-12 12:56:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (382, 703, 36, 44, '2005-05-29 11:06:14', '2005-04-03 15:47:45', '2006-12-26 22:32:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (236, 378, 11, 67, '2005-12-14 11:39:33', '2005-01-02 05:57:01', '2007-05-21 17:07:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (212, 539, 19, 71, '2005-08-26 13:45:29', '2005-05-02 05:44:54', '2007-06-09 04:43:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (570, 327, 38, 69, '2005-04-11 08:08:03', '2005-07-23 06:09:17', '2006-11-30 18:42:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (780, 302, 31, 97, '2005-05-21 15:20:35', '2005-02-21 23:40:12', '2008-03-26 23:04:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (692, 715, 7, 48, '2005-09-13 19:01:51', '2005-03-28 09:08:14', '2008-01-07 23:16:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (785, 263, 20, 88, '2005-02-23 07:31:38', '2005-03-14 09:02:46', '2006-11-10 20:27:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (710, 707, 18, 3, '2005-08-12 16:25:00', '2005-03-29 12:43:56', '2008-02-07 10:42:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (103, 993, 15, 74, '2005-04-21 09:25:46', '2005-06-14 03:33:49', '2006-04-23 22:32:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 13, 5, 46, '2005-09-24 04:45:05', '2005-06-03 18:16:56', '2007-07-29 08:24:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (121, 610, 39, 7, '2005-03-27 01:38:04', '2005-01-05 00:18:51', '2008-02-02 16:26:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (896, 582, 9, 98, '2005-03-19 18:51:06', '2005-06-02 07:56:17', '2007-04-15 02:59:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (415, 671, 25, 1, '2005-12-01 17:55:31', '2005-07-30 16:39:16', '2006-05-26 16:19:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (959, 443, 34, 94, '2005-03-05 20:19:48', '2005-01-08 11:58:32', '2008-06-24 09:21:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (847, 847, 19, 24, '2005-08-22 22:16:41', '2005-03-15 05:11:51', '2006-12-16 11:02:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (751, 838, 25, 82, '2005-09-23 10:12:23', '2005-04-16 22:27:54', '2007-08-28 23:22:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (973, 684, 25, 9, '2005-05-25 05:25:37', '2005-05-04 06:52:24', '2007-05-25 04:40:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (315, 109, 21, 54, '2005-06-07 10:20:34', '2005-05-16 11:59:19', '2008-08-10 01:56:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (978, 632, 12, 56, '2005-02-11 02:06:13', '2005-02-07 05:17:15', '2006-11-28 12:01:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (219, 915, 6, 23, '2005-05-06 13:31:36', '2005-02-01 03:15:23', '2006-11-01 03:27:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (478, 98, 27, 12, '2005-03-18 22:42:38', '2005-01-24 06:57:33', '2006-12-30 15:16:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (159, 494, 31, 21, '2005-09-17 00:00:44', '2005-06-04 04:18:25', '2007-08-23 08:29:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (439, 573, 30, 63, '2005-12-05 03:16:26', '2005-03-27 15:41:45', '2008-06-05 03:59:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (57, 183, 36, 20, '2005-01-12 03:23:03', '2005-02-20 06:19:32', '2006-12-04 19:04:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (391, 871, 1, 95, '2005-07-31 12:44:44', '2005-03-07 18:24:50', '2006-07-28 09:07:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (20, 483, 24, 51, '2005-05-16 12:23:40', '2005-01-14 12:36:53', '2006-03-25 10:00:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (662, 545, 10, 87, '2005-11-08 21:28:02', '2005-05-19 19:11:42', '2007-12-05 04:36:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (716, 668, 17, 31, '2005-07-01 12:58:32', '2005-02-14 23:14:14', '2007-06-14 11:24:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (23, 988, 1, 17, '2005-06-29 14:24:03', '2005-01-18 08:22:25', '2007-04-16 16:47:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (350, 966, 40, 28, '2005-08-07 14:00:31', '2005-04-30 21:54:00', '2007-03-13 02:49:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (960, 584, 2, 85, '2005-03-06 12:33:58', '2005-07-07 20:14:01', '2006-08-16 07:54:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (646, 300, 40, 95, '2005-01-22 15:09:42', '2005-07-20 16:17:13', '2008-03-17 03:34:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (295, 301, 4, 46, '2005-01-05 03:11:03', '2005-01-22 22:52:40', '2006-09-30 09:14:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (846, 551, 30, 37, '2005-07-23 08:41:16', '2005-07-09 13:08:22', '2006-08-09 04:39:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (998, 276, 19, 88, '2005-07-03 17:35:59', '2005-07-03 08:04:52', '2006-06-27 23:13:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (404, 324, 32, 40, '2005-05-20 21:48:34', '2005-04-05 10:02:57', '2008-03-22 08:55:10');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (620, 647, 1, 8, '2006-01-26 09:50:49', '2006-07-21 19:36:48', '2007-07-13 09:24:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (91, 99, 18, 63, '2006-12-13 15:29:24', '2006-07-13 17:11:06', '2009-06-18 16:24:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (283, 321, 21, 79, '2006-08-01 05:31:40', '2006-04-16 14:38:49', '2007-09-07 15:08:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (637, 417, 12, 43, '2006-12-04 20:11:07', '2006-05-26 01:00:01', '2007-11-15 05:19:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (664, 145, 9, 38, '2006-01-23 18:03:49', '2006-05-10 12:17:09', '2008-05-02 16:27:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (999, 254, 27, 16, '2006-12-05 22:49:00', '2006-06-20 23:23:09', '2008-11-04 05:46:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (339, 316, 34, 39, '2006-01-24 09:25:40', '2006-01-15 04:17:31', '2008-05-09 13:47:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (667, 285, 25, 30, '2006-01-30 22:11:00', '2006-05-02 11:52:53', '2008-09-24 23:42:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (410, 626, 19, 99, '2006-10-01 11:56:19', '2006-05-10 21:50:04', '2007-11-19 20:42:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (805, 696, 34, 17, '2006-07-06 17:11:18', '2006-07-23 14:31:24', '2008-04-29 07:30:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (490, 223, 27, 29, '2006-09-06 00:45:59', '2006-02-03 21:07:26', '2007-12-01 01:32:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (934, 551, 3, 15, '2006-02-09 17:33:04', '2006-07-24 06:51:03', '2008-07-06 07:50:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (234, 386, 38, 28, '2006-12-10 08:22:07', '2006-04-15 01:01:53', '2008-04-16 22:05:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (773, 872, 8, 9, '2006-09-20 13:58:19', '2006-07-21 22:47:43', '2007-06-08 14:59:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (512, 858, 28, 84, '2006-03-27 23:14:04', '2006-06-22 07:16:38', '2008-02-04 09:40:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (630, 59, 7, 97, '2006-01-23 07:32:36', '2006-07-11 04:30:25', '2007-10-21 01:20:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (687, 103, 32, 85, '2006-08-20 03:35:15', '2006-07-27 00:18:34', '2009-02-18 15:38:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (936, 317, 13, 50, '2006-07-17 14:30:05', '2006-05-19 04:16:49', '2008-08-10 03:27:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (643, 365, 3, 43, '2006-03-19 06:26:20', '2006-05-18 16:26:56', '2007-02-10 08:51:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (627, 777, 38, 11, '2006-11-24 22:29:18', '2006-02-04 14:38:16', '2008-05-10 17:14:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (275, 990, 16, 5, '2006-08-15 23:08:23', '2006-05-01 01:33:51', '2008-12-17 06:29:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 246, 16, 21, '2006-01-04 21:24:39', '2006-03-15 03:43:35', '2008-09-10 20:46:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (566, 206, 31, 25, '2006-03-08 10:27:56', '2006-01-24 23:27:55', '2007-06-19 21:49:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (360, 713, 40, 95, '2006-07-13 12:25:04', '2006-02-05 17:23:51', '2008-01-28 19:50:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (719, 946, 3, 12, '2006-12-21 19:31:48', '2006-06-23 00:34:42', '2007-03-01 03:00:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (283, 852, 5, 85, '2006-10-05 10:45:00', '2006-07-09 18:58:31', '2007-05-18 13:11:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (795, 937, 15, 99, '2006-08-01 12:27:36', '2006-05-27 04:47:35', '2008-05-07 17:42:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (591, 582, 27, 16, '2006-11-22 09:32:52', '2006-04-22 10:19:48', '2008-09-11 04:02:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (377, 583, 18, 13, '2006-01-16 01:17:08', '2006-02-20 16:11:13', '2007-07-12 13:09:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (390, 721, 10, 94, '2006-08-02 21:04:47', '2006-06-10 19:16:02', '2008-10-28 12:46:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (60, 479, 39, 75, '2006-09-27 12:20:38', '2006-04-17 14:31:21', '2008-12-21 23:22:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (378, 233, 1, 29, '2006-07-28 16:43:39', '2006-01-09 22:38:43', '2008-12-30 16:28:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (669, 773, 13, 43, '2006-04-08 02:37:13', '2006-07-31 21:56:25', '2008-02-26 23:12:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (288, 887, 26, 65, '2006-07-23 08:26:19', '2006-01-08 08:26:20', '2009-07-08 10:00:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (352, 605, 29, 70, '2006-08-20 07:40:53', '2006-03-26 07:22:34', '2007-02-22 00:22:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 772, 14, 84, '2006-10-13 14:59:21', '2006-01-21 06:19:55', '2008-09-24 15:07:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (816, 540, 2, 98, '2006-06-05 17:34:48', '2006-02-16 14:52:50', '2007-06-08 23:07:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (201, 194, 9, 53, '2006-01-31 09:24:18', '2006-07-17 09:36:26', '2009-05-18 07:34:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (226, 937, 38, 3, '2006-02-06 04:25:28', '2006-03-07 00:42:38', '2008-05-05 13:58:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (792, 692, 31, 30, '2006-11-30 08:30:31', '2006-02-27 04:37:53', '2007-12-21 05:48:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (7, 336, 33, 16, '2006-08-06 08:16:27', '2006-07-22 06:08:05', '2009-06-10 20:24:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (656, 231, 17, 17, '2006-12-18 01:37:12', '2006-01-14 04:53:51', '2009-01-12 04:22:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (586, 214, 30, 76, '2006-03-24 10:29:54', '2006-06-27 01:34:46', '2007-09-05 03:01:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (672, 901, 34, 91, '2006-07-24 14:22:12', '2006-02-28 07:42:42', '2008-07-12 14:42:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (586, 714, 8, 69, '2006-12-30 06:14:34', '2006-06-08 03:45:28', '2008-04-12 03:36:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (73, 23, 4, 72, '2006-12-01 02:19:07', '2006-06-18 13:00:53', '2007-11-16 12:30:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 182, 31, 52, '2006-12-26 11:23:51', '2006-04-10 11:31:09', '2009-07-01 18:33:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 618, 1, 14, '2006-03-09 03:00:19', '2006-04-17 20:28:43', '2007-11-30 07:25:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (282, 179, 27, 10, '2006-01-23 01:23:48', '2006-04-24 02:28:17', '2008-06-21 07:16:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (85, 916, 23, 35, '2006-02-21 09:24:11', '2006-07-26 05:04:41', '2007-09-30 18:12:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (698, 535, 36, 64, '2006-05-06 09:47:25', '2006-07-23 20:32:50', '2007-08-11 10:39:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (398, 742, 16, 84, '2006-12-10 18:23:40', '2006-02-25 07:19:06', '2009-05-17 20:37:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (310, 967, 13, 76, '2006-07-10 18:23:53', '2006-05-19 07:19:05', '2009-02-07 15:07:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 128, 39, 36, '2006-04-24 08:39:39', '2006-05-15 06:45:23', '2008-02-13 06:10:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (244, 898, 20, 16, '2006-03-18 12:46:03', '2006-06-21 15:48:16', '2007-06-03 08:50:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (908, 65, 13, 82, '2006-07-17 04:50:35', '2006-02-06 16:22:18', '2008-12-03 21:10:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (725, 498, 25, 64, '2006-10-13 11:52:48', '2006-05-20 09:52:08', '2007-07-01 12:26:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (470, 930, 16, 55, '2006-05-17 15:29:28', '2006-05-16 12:34:58', '2008-01-31 13:35:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (369, 862, 28, 7, '2006-07-01 19:17:15', '2006-05-14 02:27:22', '2008-03-06 18:32:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (64, 985, 6, 54, '2006-08-17 19:21:40', '2006-07-23 09:06:43', '2007-02-02 01:31:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (616, 316, 37, 11, '2006-12-27 05:40:42', '2006-07-30 00:34:04', '2009-05-13 05:53:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (632, 129, 20, 49, '2006-11-08 23:11:40', '2006-07-20 15:38:39', '2008-04-05 17:56:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (766, 957, 7, 6, '2006-04-26 16:27:46', '2006-03-03 08:21:58', '2007-09-27 09:11:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (375, 218, 32, 59, '2006-06-16 08:07:15', '2006-04-19 06:59:16', '2008-11-19 23:40:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (295, 373, 5, 96, '2006-01-31 07:35:56', '2006-06-09 23:56:07', '2008-02-25 21:36:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (457, 728, 23, 19, '2006-10-04 07:18:54', '2006-03-25 22:46:34', '2009-08-10 10:56:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (906, 159, 8, 2, '2006-05-09 10:34:54', '2006-03-28 05:22:34', '2008-05-15 08:07:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (390, 771, 27, 4, '2006-10-26 00:31:22', '2006-05-08 11:07:54', '2008-12-03 22:37:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (707, 236, 36, 79, '2006-05-02 17:37:52', '2006-05-29 04:53:27', '2008-10-18 04:46:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (259, 289, 7, 64, '2006-03-19 23:20:01', '2006-03-30 01:38:31', '2008-10-18 17:31:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (13, 51, 19, 16, '2006-07-04 06:31:28', '2006-01-29 01:37:36', '2007-11-13 03:39:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (938, 393, 8, 46, '2006-08-12 18:55:59', '2006-03-03 02:09:09', '2008-05-14 19:46:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (567, 669, 19, 63, '2006-01-28 22:33:38', '2006-03-23 05:00:47', '2009-05-31 04:40:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (579, 757, 9, 52, '2006-05-20 06:49:09', '2006-02-01 17:33:21', '2007-07-03 23:36:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (297, 608, 32, 57, '2006-07-29 17:13:35', '2006-02-06 08:03:53', '2009-03-29 02:33:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (667, 784, 40, 40, '2006-06-16 15:53:33', '2006-01-22 21:19:23', '2008-04-26 12:31:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (987, 361, 6, 2, '2006-07-12 20:58:29', '2006-06-01 10:41:30', '2008-11-28 12:44:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (998, 636, 37, 87, '2006-12-23 21:55:46', '2006-06-20 12:47:00', '2007-05-27 05:40:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (574, 169, 21, 40, '2006-09-24 22:57:01', '2006-06-11 13:18:40', '2008-01-16 09:25:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (839, 88, 5, 9, '2006-02-15 11:09:22', '2006-03-28 08:54:14', '2009-01-22 04:13:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (575, 695, 14, 45, '2006-09-30 15:53:31', '2006-01-27 09:22:26', '2009-07-24 19:00:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (629, 331, 15, 96, '2006-09-16 03:21:15', '2006-07-16 16:34:29', '2007-08-11 09:50:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (274, 176, 34, 61, '2006-11-16 02:21:17', '2006-06-11 02:32:25', '2008-03-28 03:31:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (722, 587, 2, 97, '2006-11-11 02:03:56', '2006-07-19 15:41:04', '2008-12-10 03:02:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (833, 162, 21, 96, '2006-01-17 18:25:11', '2006-03-13 12:39:24', '2007-02-04 11:04:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (533, 167, 34, 78, '2006-10-01 09:36:05', '2006-01-10 23:48:36', '2007-07-23 15:03:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (498, 707, 24, 11, '2006-08-21 20:48:30', '2006-02-11 13:45:01', '2008-08-30 21:13:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (463, 508, 11, 38, '2006-07-26 23:44:59', '2006-04-24 02:20:37', '2009-05-13 21:18:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (370, 776, 16, 1, '2006-11-16 01:36:46', '2006-05-31 13:30:15', '2008-01-14 06:10:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (101, 187, 40, 52, '2006-09-27 04:39:50', '2006-07-08 21:06:50', '2008-02-29 12:22:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (896, 595, 23, 100, '2006-02-05 13:15:16', '2006-04-06 16:34:01', '2008-10-28 20:03:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (178, 273, 29, 57, '2006-01-14 15:30:19', '2006-05-01 05:29:10', '2008-06-08 17:14:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (216, 662, 26, 47, '2006-09-30 17:35:06', '2006-01-30 05:10:08', '2009-06-28 08:06:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (100, 992, 15, 39, '2006-07-23 15:19:26', '2006-03-20 19:37:51', '2009-03-15 19:18:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (223, 103, 19, 87, '2006-06-27 08:14:16', '2006-04-04 05:30:25', '2007-06-12 20:54:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (241, 342, 23, 67, '2006-03-25 22:43:43', '2006-06-12 01:15:52', '2007-06-10 21:02:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (523, 178, 1, 17, '2006-01-10 13:43:21', '2006-07-13 23:41:45', '2008-04-14 06:14:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (163, 741, 36, 43, '2006-12-06 00:18:04', '2006-03-31 12:59:52', '2008-03-25 14:11:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (475, 582, 3, 27, '2006-08-31 17:06:33', '2006-05-31 16:42:01', '2008-02-21 05:42:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (434, 595, 1, 85, '2006-08-08 21:29:50', '2006-03-17 09:16:45', '2007-03-03 23:00:30');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (346, 15, 5, 51, '2007-04-28 05:06:42', '2007-04-17 00:43:29', '2008-03-23 09:10:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (105, 793, 36, 72, '2007-03-09 21:02:43', '2007-06-15 16:59:06', '2010-03-14 16:23:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (335, 774, 35, 33, '2007-06-03 07:08:16', '2007-04-11 21:57:33', '2010-02-12 02:22:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (225, 998, 30, 3, '2007-03-20 11:58:18', '2007-01-19 13:07:07', '2009-05-13 14:49:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (954, 400, 22, 15, '2007-12-12 01:40:56', '2007-02-01 09:06:34', '2008-04-28 05:02:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (464, 408, 18, 49, '2007-10-16 08:15:05', '2007-03-30 22:27:44', '2010-06-05 11:02:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (982, 240, 12, 24, '2007-04-22 02:26:00', '2007-05-17 05:31:20', '2009-03-02 10:26:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (293, 118, 17, 78, '2007-01-09 07:25:42', '2007-07-19 02:51:21', '2008-03-07 15:26:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (206, 125, 27, 22, '2007-12-18 00:56:10', '2007-01-22 07:48:52', '2009-11-23 14:07:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (172, 857, 14, 45, '2007-01-27 18:47:34', '2007-05-02 21:44:34', '2008-04-13 11:25:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (77, 965, 36, 87, '2007-07-09 21:58:18', '2007-03-21 15:00:02', '2009-02-16 19:38:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (202, 646, 37, 93, '2007-01-04 09:52:18', '2007-01-04 02:48:46', '2010-04-26 20:34:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (435, 294, 32, 84, '2007-06-12 20:29:47', '2007-05-13 22:16:13', '2009-07-08 10:12:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (133, 713, 34, 40, '2007-12-21 13:10:16', '2007-05-04 11:02:51', '2010-03-07 18:13:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (121, 716, 1, 42, '2007-05-31 13:35:24', '2007-01-11 11:42:58', '2010-04-11 00:43:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (51, 772, 28, 87, '2007-01-30 23:22:43', '2007-01-08 16:11:22', '2009-09-18 20:19:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (801, 606, 1, 8, '2007-08-31 13:16:54', '2007-02-04 07:12:14', '2008-03-21 11:59:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (948, 212, 22, 82, '2007-11-11 04:31:36', '2007-02-24 09:39:49', '2010-03-30 21:57:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (449, 658, 35, 28, '2007-08-22 12:03:16', '2007-05-29 11:13:23', '2010-02-16 09:29:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (877, 910, 12, 92, '2007-03-22 08:02:25', '2007-07-06 08:33:26', '2008-12-26 05:57:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (741, 650, 40, 20, '2007-04-22 11:27:57', '2007-07-10 02:27:26', '2009-04-01 23:33:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (360, 938, 11, 40, '2007-05-11 12:04:39', '2007-06-20 05:42:34', '2010-01-11 06:58:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (180, 280, 32, 75, '2007-03-05 00:38:32', '2007-04-30 03:27:31', '2009-06-19 15:24:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (921, 699, 37, 47, '2007-04-15 13:20:27', '2007-05-18 03:26:58', '2009-09-08 21:00:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (731, 652, 8, 87, '2007-05-27 15:59:33', '2007-02-07 21:14:41', '2008-10-11 11:12:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (228, 770, 20, 14, '2007-04-07 09:01:26', '2007-03-05 22:08:51', '2008-11-07 01:49:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (561, 196, 18, 96, '2007-12-25 19:07:00', '2007-02-22 21:09:02', '2008-05-31 10:29:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (725, 678, 39, 60, '2007-02-13 11:28:05', '2007-07-03 13:34:26', '2010-01-24 03:05:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (249, 41, 31, 6, '2007-08-16 13:37:10', '2007-07-31 19:54:15', '2009-12-18 10:47:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (914, 534, 11, 43, '2007-01-01 00:23:49', '2007-06-17 21:13:26', '2009-09-10 05:37:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (839, 682, 36, 56, '2007-11-06 16:54:57', '2007-03-14 00:46:01', '2010-01-27 23:55:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (306, 448, 40, 93, '2007-01-02 19:00:26', '2007-06-21 15:28:11', '2008-08-19 08:22:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (665, 861, 19, 34, '2007-07-07 03:00:15', '2007-07-13 23:26:08', '2009-01-03 18:33:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (723, 696, 30, 98, '2007-10-04 23:16:13', '2007-04-01 03:17:46', '2009-05-13 19:17:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (639, 286, 11, 99, '2007-05-05 03:48:45', '2007-02-19 22:09:26', '2008-12-31 13:25:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (784, 208, 32, 86, '2007-05-29 03:51:17', '2007-07-04 09:00:31', '2009-11-05 12:43:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (537, 927, 4, 19, '2007-11-09 08:26:38', '2007-03-23 15:18:15', '2010-02-17 09:05:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (510, 690, 29, 58, '2007-09-20 09:50:17', '2007-06-05 06:20:37', '2008-02-04 05:27:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (542, 650, 25, 11, '2007-01-17 19:14:48', '2007-03-15 01:35:31', '2008-08-23 01:21:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (657, 539, 39, 27, '2007-12-24 18:29:51', '2007-03-08 09:05:33', '2008-10-29 20:28:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (767, 892, 18, 20, '2007-04-07 22:28:12', '2007-02-14 08:25:51', '2010-06-29 11:49:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (770, 556, 12, 74, '2007-07-01 09:06:12', '2007-04-08 07:16:46', '2009-07-17 00:34:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (924, 897, 31, 64, '2007-04-26 01:17:52', '2007-05-27 16:01:18', '2010-06-05 12:31:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (214, 657, 23, 16, '2007-05-07 10:50:50', '2007-01-17 06:10:59', '2008-07-20 23:21:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (695, 760, 2, 25, '2007-06-11 07:57:25', '2007-07-13 00:03:41', '2009-09-03 07:26:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 887, 22, 47, '2007-12-04 16:04:56', '2007-03-27 17:53:36', '2008-02-09 03:30:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (271, 796, 23, 56, '2007-06-18 07:24:53', '2007-05-12 06:01:09', '2008-11-11 22:50:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (753, 151, 39, 18, '2007-02-01 18:54:13', '2007-06-05 08:12:00', '2010-07-18 05:02:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (898, 194, 12, 98, '2007-09-24 00:32:13', '2007-05-20 06:55:19', '2009-01-21 10:42:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (287, 465, 15, 89, '2007-08-03 01:22:48', '2007-07-20 20:42:02', '2008-07-06 23:45:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (273, 286, 28, 22, '2007-06-23 12:35:23', '2007-06-04 04:54:45', '2009-01-12 00:22:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 50, 13, 59, '2007-12-15 00:21:34', '2007-04-22 10:37:19', '2008-10-30 04:31:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (597, 486, 27, 75, '2007-02-21 01:55:45', '2007-05-29 13:54:08', '2008-10-18 09:07:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (768, 554, 16, 1, '2007-02-04 09:37:31', '2007-05-10 03:31:37', '2009-01-09 15:38:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (23, 551, 11, 81, '2007-02-23 00:51:04', '2007-01-17 12:32:44', '2010-07-08 02:17:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (202, 540, 23, 32, '2007-02-05 02:57:53', '2007-01-30 00:14:32', '2010-02-24 04:07:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (802, 111, 5, 92, '2007-08-30 04:03:29', '2007-02-01 17:15:47', '2009-03-31 12:23:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (137, 632, 40, 88, '2007-10-28 05:51:55', '2007-05-03 13:33:21', '2009-12-15 06:09:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (904, 146, 19, 57, '2007-11-04 21:57:05', '2007-07-04 11:00:39', '2008-06-13 11:06:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (751, 898, 18, 20, '2007-01-20 13:51:57', '2007-04-25 02:04:13', '2010-06-09 16:16:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (751, 907, 9, 40, '2007-10-24 19:29:25', '2007-02-01 13:00:27', '2010-01-09 06:30:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (971, 7, 31, 98, '2007-09-15 19:05:57', '2007-01-28 13:24:14', '2009-07-25 14:36:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (798, 445, 40, 49, '2007-04-22 00:21:41', '2007-07-20 19:55:43', '2009-04-18 19:44:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (831, 287, 25, 39, '2007-02-28 05:32:41', '2007-01-21 04:04:58', '2008-06-23 05:34:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (156, 253, 15, 90, '2007-01-21 19:38:15', '2007-07-01 03:24:10', '2009-04-18 04:11:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (327, 909, 31, 27, '2007-06-01 03:40:41', '2007-05-27 13:37:00', '2009-05-21 23:11:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (309, 547, 2, 87, '2007-03-27 00:38:57', '2007-07-14 05:01:20', '2010-06-20 06:40:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (581, 366, 28, 4, '2007-04-29 20:14:49', '2007-07-25 16:13:21', '2009-03-27 14:36:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (509, 449, 12, 39, '2007-07-06 08:57:27', '2007-01-31 03:26:29', '2009-04-18 13:18:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (517, 640, 39, 98, '2007-05-27 07:48:51', '2007-04-13 17:16:26', '2008-11-12 13:34:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (51, 703, 39, 58, '2007-10-14 18:55:29', '2007-07-07 11:01:44', '2008-06-15 11:34:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (831, 156, 30, 69, '2007-07-11 19:36:07', '2007-01-22 17:31:17', '2008-09-28 05:25:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (515, 901, 16, 85, '2007-11-29 13:34:04', '2007-03-05 17:01:49', '2009-12-05 13:35:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (724, 593, 37, 59, '2007-10-08 23:26:13', '2007-02-10 22:47:33', '2009-04-20 19:15:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (338, 557, 32, 33, '2007-07-23 18:42:26', '2007-02-05 03:24:22', '2008-03-11 04:33:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (145, 560, 26, 56, '2007-07-20 12:49:11', '2007-07-26 07:53:59', '2010-04-23 18:20:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (368, 981, 12, 90, '2007-09-12 12:17:18', '2007-01-31 15:22:38', '2008-04-29 20:59:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (828, 207, 34, 24, '2007-01-10 11:18:42', '2007-05-19 21:43:36', '2008-10-19 08:36:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (628, 989, 1, 37, '2007-12-22 21:16:11', '2007-02-11 13:20:38', '2008-05-06 02:19:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (643, 227, 6, 86, '2007-01-29 11:05:49', '2007-01-20 08:01:38', '2010-03-26 04:28:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (270, 793, 29, 100, '2007-09-03 03:18:04', '2007-06-23 22:59:08', '2008-05-18 17:01:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 207, 22, 78, '2007-08-12 05:20:07', '2007-04-17 06:00:35', '2009-09-30 16:32:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (429, 734, 23, 4, '2007-11-03 21:38:44', '2007-03-01 05:10:58', '2010-07-08 19:30:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (557, 205, 31, 41, '2007-04-13 21:13:27', '2007-04-25 04:30:42', '2009-12-10 06:28:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (383, 329, 2, 16, '2007-08-09 16:25:32', '2007-01-28 16:20:36', '2008-09-05 16:49:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (483, 284, 28, 49, '2007-06-23 18:23:02', '2007-03-23 19:32:33', '2010-07-13 16:03:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (874, 157, 10, 6, '2007-10-22 17:16:58', '2007-01-28 09:18:32', '2010-07-06 20:35:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (905, 825, 32, 78, '2007-03-16 04:31:56', '2007-03-22 23:35:43', '2009-11-24 23:16:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (986, 242, 30, 1, '2007-06-02 23:33:13', '2007-03-21 05:39:56', '2010-06-15 03:11:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (237, 232, 32, 71, '2007-04-22 08:05:29', '2007-04-04 00:36:43', '2008-05-29 21:56:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (655, 773, 38, 99, '2007-12-26 16:38:28', '2007-03-23 15:02:32', '2008-04-09 22:09:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (498, 954, 11, 58, '2007-04-27 14:15:44', '2007-06-27 17:27:56', '2009-07-24 12:42:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (264, 753, 29, 50, '2007-01-19 06:15:55', '2007-02-24 17:01:11', '2010-04-27 04:22:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (334, 376, 12, 100, '2007-07-16 23:00:10', '2007-04-07 22:07:12', '2008-04-08 21:11:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (653, 818, 29, 63, '2007-12-07 12:47:51', '2007-02-12 12:38:17', '2010-03-30 16:44:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (404, 558, 35, 52, '2007-02-04 16:28:06', '2007-05-20 18:26:09', '2009-05-08 12:33:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 216, 17, 78, '2007-03-05 12:50:16', '2007-02-14 21:25:53', '2010-03-18 18:01:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (736, 299, 30, 81, '2007-01-18 11:40:08', '2007-05-13 09:38:00', '2009-01-25 06:35:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (331, 80, 38, 15, '2007-09-06 15:52:51', '2007-04-14 15:16:19', '2009-04-13 17:00:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (605, 90, 7, 13, '2007-12-10 12:29:56', '2007-05-18 13:17:17', '2010-01-07 05:32:11');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (770, 884, 40, 28, '2008-04-21 11:19:42', '2008-02-21 23:05:55', '2009-08-09 16:12:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (194, 927, 34, 81, '2008-11-27 18:52:04', '2008-06-29 15:56:19', '2010-03-31 23:19:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (52, 548, 2, 99, '2008-12-12 08:13:04', '2008-03-01 02:01:38', '2011-07-04 15:23:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (345, 675, 7, 94, '2008-08-24 19:36:42', '2008-02-29 09:55:02', '2011-07-20 02:21:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (329, 224, 31, 52, '2008-02-15 09:48:57', '2008-02-06 01:36:51', '2010-09-18 14:44:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (702, 494, 14, 83, '2008-01-31 12:09:04', '2008-05-18 16:25:54', '2011-02-05 02:28:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (141, 608, 36, 61, '2008-09-12 07:08:24', '2008-04-12 22:41:02', '2010-11-30 19:03:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (553, 941, 7, 49, '2008-05-18 08:48:47', '2008-02-09 09:10:16', '2010-06-26 12:30:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (473, 318, 27, 43, '2008-12-16 12:35:31', '2008-05-21 12:13:39', '2010-03-29 06:46:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (552, 147, 23, 8, '2008-01-28 11:20:48', '2008-07-20 10:40:12', '2011-07-26 01:24:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (823, 326, 19, 9, '2008-02-28 22:28:00', '2008-02-03 13:12:29', '2009-11-04 17:17:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (846, 788, 15, 76, '2008-08-22 20:15:30', '2008-01-22 00:34:37', '2010-07-27 13:28:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (422, 978, 3, 56, '2008-05-14 21:43:16', '2008-04-04 11:03:22', '2010-06-24 02:36:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (287, 801, 23, 85, '2008-02-22 05:56:42', '2008-02-12 11:17:16', '2010-09-07 19:47:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (359, 430, 31, 9, '2008-04-28 07:02:22', '2008-05-25 17:15:06', '2009-11-02 08:02:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (120, 362, 16, 100, '2008-10-06 00:27:53', '2008-03-23 05:34:28', '2010-05-25 03:31:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (714, 698, 17, 19, '2008-02-14 12:16:02', '2008-05-01 05:45:11', '2010-01-29 09:23:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (286, 721, 40, 5, '2008-03-28 18:22:31', '2008-07-02 18:37:49', '2010-08-04 19:27:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (850, 586, 6, 48, '2008-05-12 03:46:44', '2008-07-10 07:45:52', '2010-05-06 17:50:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (205, 329, 20, 38, '2008-04-01 19:03:06', '2008-02-13 08:21:42', '2011-02-20 00:49:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (750, 98, 25, 1, '2008-11-15 01:12:34', '2008-03-13 12:17:14', '2009-10-08 13:39:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (633, 416, 11, 77, '2008-03-24 00:54:25', '2008-02-07 22:33:06', '2011-06-28 19:00:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (179, 786, 16, 93, '2008-06-09 00:50:41', '2008-02-12 22:00:19', '2011-05-07 09:53:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (371, 954, 13, 42, '2008-02-10 11:48:59', '2008-01-01 17:32:31', '2010-10-18 17:13:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (854, 825, 13, 41, '2008-05-20 20:04:50', '2008-07-02 23:32:44', '2010-09-30 20:53:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (894, 440, 12, 47, '2008-02-03 19:03:44', '2008-06-09 01:06:06', '2010-10-05 11:07:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (798, 263, 11, 43, '2008-05-14 21:54:07', '2008-02-16 15:17:39', '2009-04-06 20:55:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (352, 451, 4, 6, '2008-09-09 09:43:16', '2008-02-15 03:32:30', '2010-01-28 07:49:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (33, 973, 17, 30, '2008-12-07 11:14:00', '2008-01-04 15:34:14', '2010-12-04 17:38:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (221, 77, 35, 74, '2008-07-14 19:17:52', '2008-04-23 03:00:22', '2011-07-08 16:58:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (21, 27, 33, 54, '2008-01-19 00:09:58', '2008-02-11 09:06:49', '2010-01-02 11:52:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (882, 141, 6, 38, '2008-12-31 11:56:32', '2008-06-18 17:51:54', '2010-06-01 05:10:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (751, 197, 19, 82, '2008-01-07 23:14:08', '2008-02-02 06:26:20', '2010-05-15 10:38:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (83, 838, 8, 84, '2008-03-07 15:41:23', '2008-04-09 20:12:38', '2010-12-22 21:55:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (908, 107, 16, 72, '2008-10-16 11:07:01', '2008-03-16 02:21:33', '2010-05-16 05:20:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (171, 406, 1, 85, '2008-03-22 04:02:36', '2008-01-19 09:54:19', '2011-01-13 13:35:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (397, 430, 16, 41, '2008-08-16 03:36:31', '2008-06-12 06:49:39', '2009-03-07 03:47:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (472, 841, 7, 52, '2008-05-17 00:21:27', '2008-03-22 11:54:18', '2011-03-08 07:31:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (549, 600, 35, 64, '2008-03-08 10:12:35', '2008-01-11 23:36:25', '2010-05-26 21:06:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (15, 835, 26, 39, '2008-05-11 20:13:40', '2008-03-17 01:24:10', '2010-10-29 07:09:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (462, 812, 34, 78, '2008-06-11 23:30:26', '2008-05-27 13:43:25', '2010-05-29 09:30:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (898, 815, 16, 61, '2008-03-09 15:28:37', '2008-02-03 23:29:11', '2010-04-08 08:43:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (752, 459, 20, 55, '2008-12-03 03:01:22', '2008-07-28 19:02:11', '2010-08-14 19:14:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (479, 569, 16, 26, '2008-02-12 15:55:22', '2008-07-27 17:24:25', '2010-12-25 06:57:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (727, 354, 40, 62, '2008-09-23 09:47:40', '2008-05-25 17:50:27', '2010-01-21 16:16:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (982, 184, 19, 88, '2008-09-16 14:44:46', '2008-05-02 03:17:50', '2009-02-20 14:53:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (333, 514, 35, 76, '2008-08-26 10:37:24', '2008-03-19 05:06:06', '2010-06-02 06:14:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (459, 163, 6, 39, '2008-04-06 11:35:41', '2008-05-25 05:45:21', '2009-07-26 07:00:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (870, 187, 4, 26, '2008-06-10 07:26:57', '2008-04-12 02:20:18', '2010-12-14 15:29:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (148, 974, 17, 69, '2008-06-13 12:35:33', '2008-01-31 21:11:51', '2011-07-12 16:58:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (497, 263, 40, 22, '2008-07-04 05:38:25', '2008-06-27 13:54:34', '2011-06-01 03:26:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (293, 423, 14, 94, '2008-01-03 10:43:30', '2008-05-13 07:05:34', '2011-05-10 15:32:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (247, 666, 29, 37, '2008-05-28 23:29:37', '2008-04-01 01:57:27', '2009-09-11 08:05:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (317, 721, 4, 61, '2008-09-12 21:46:33', '2008-05-06 06:58:50', '2010-06-16 06:15:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (163, 399, 24, 89, '2008-07-27 02:04:59', '2008-07-08 12:00:00', '2011-02-25 13:25:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (604, 803, 16, 37, '2008-04-29 11:16:31', '2008-06-25 08:28:09', '2009-10-31 17:04:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (571, 668, 33, 59, '2008-10-11 10:27:12', '2008-03-23 14:24:08', '2010-05-13 12:12:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (705, 902, 2, 55, '2008-07-07 20:24:15', '2008-01-10 05:03:19', '2011-04-09 02:49:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (925, 272, 7, 9, '2008-09-05 19:42:00', '2008-05-28 11:38:14', '2010-05-02 06:38:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (907, 667, 35, 84, '2008-05-06 19:49:33', '2008-05-30 11:20:25', '2011-02-22 20:04:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (482, 559, 8, 91, '2008-08-03 21:31:19', '2008-04-22 10:55:22', '2010-11-10 23:15:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (897, 306, 13, 54, '2008-07-27 14:46:30', '2008-04-02 01:58:31', '2010-02-04 00:13:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (950, 387, 23, 64, '2008-08-16 03:05:11', '2008-03-24 00:29:44', '2010-03-12 17:02:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (815, 313, 15, 23, '2008-11-12 04:13:31', '2008-03-21 05:28:05', '2009-07-14 14:21:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (655, 851, 21, 67, '2008-08-08 09:13:12', '2008-06-30 05:55:57', '2010-09-06 12:21:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (462, 258, 35, 92, '2008-06-20 23:38:48', '2008-05-12 08:24:36', '2011-03-13 15:42:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (959, 369, 11, 78, '2008-03-15 01:56:59', '2008-03-17 04:17:09', '2009-02-17 22:40:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (473, 774, 28, 79, '2008-03-14 03:08:40', '2008-03-03 10:11:56', '2009-05-26 23:11:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (252, 644, 34, 2, '2008-08-06 12:11:33', '2008-02-09 23:32:08', '2009-08-04 05:39:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (504, 131, 8, 56, '2008-05-01 06:59:23', '2008-06-05 17:07:06', '2009-05-23 19:58:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (966, 847, 11, 68, '2008-04-23 06:52:09', '2008-05-07 19:50:44', '2011-06-14 00:50:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (873, 47, 28, 44, '2008-06-26 07:24:05', '2008-06-15 18:58:48', '2011-07-30 17:18:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (785, 139, 30, 11, '2008-09-13 06:23:47', '2008-04-11 12:20:37', '2011-03-02 12:29:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (537, 53, 11, 18, '2008-06-02 22:54:17', '2008-03-15 03:29:48', '2011-08-12 09:41:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (957, 844, 39, 20, '2008-12-13 06:47:03', '2008-03-10 09:14:30', '2010-05-16 14:23:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (442, 82, 26, 31, '2008-12-06 05:50:30', '2008-02-09 08:24:26', '2010-12-09 17:24:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (759, 896, 33, 17, '2008-12-17 18:37:42', '2008-07-05 14:49:14', '2009-02-10 14:53:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (80, 12, 24, 91, '2008-06-16 07:00:22', '2008-04-16 13:04:13', '2009-09-19 03:14:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (121, 200, 37, 78, '2008-05-12 03:29:51', '2008-01-18 21:54:57', '2009-04-29 09:58:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (374, 268, 26, 35, '2008-09-10 02:05:33', '2008-07-02 00:01:07', '2010-07-29 03:58:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (900, 467, 18, 84, '2008-07-16 09:26:27', '2008-04-28 13:42:23', '2011-07-15 03:30:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (567, 187, 25, 63, '2008-04-05 11:47:51', '2008-04-07 17:26:00', '2009-03-19 09:25:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (123, 5, 37, 50, '2008-10-27 23:59:24', '2008-07-14 00:36:19', '2009-11-29 21:42:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (685, 141, 39, 12, '2008-10-17 22:50:40', '2008-07-06 14:54:28', '2010-02-27 11:59:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (41, 671, 39, 16, '2008-07-05 15:53:54', '2008-07-05 00:53:37', '2010-11-30 20:55:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (935, 582, 21, 2, '2008-10-29 12:58:18', '2008-03-04 02:13:14', '2009-05-09 09:26:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (877, 663, 28, 42, '2008-11-10 13:02:29', '2008-02-01 18:52:35', '2010-05-05 10:48:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 177, 23, 11, '2008-05-26 18:02:38', '2008-02-27 19:56:59', '2010-03-25 19:57:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (458, 175, 22, 60, '2008-12-23 07:29:55', '2008-03-27 19:09:46', '2010-09-21 10:12:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (852, 620, 2, 68, '2008-08-02 03:47:44', '2008-03-21 12:03:54', '2009-10-10 16:59:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (149, 839, 30, 77, '2008-12-13 14:43:51', '2008-06-23 16:36:09', '2009-09-07 15:14:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (425, 723, 40, 86, '2008-12-03 18:11:30', '2008-05-16 04:13:57', '2010-04-25 00:03:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (728, 368, 13, 47, '2008-02-09 08:07:14', '2008-05-11 12:48:47', '2009-04-04 15:21:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (269, 867, 20, 3, '2008-09-07 04:44:51', '2008-07-24 19:47:11', '2009-06-19 20:11:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (840, 291, 34, 34, '2008-02-28 00:16:23', '2008-04-11 01:47:40', '2010-06-10 22:11:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (224, 755, 19, 29, '2008-04-24 18:54:56', '2008-05-16 16:54:19', '2010-05-21 18:14:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (1000, 141, 37, 31, '2008-11-28 22:34:16', '2008-03-23 15:47:21', '2009-08-04 11:57:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (505, 60, 17, 6, '2008-08-25 08:27:26', '2008-06-13 09:07:04', '2009-08-23 19:30:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (704, 130, 23, 40, '2008-10-04 05:22:02', '2008-04-03 06:55:25', '2011-05-30 22:05:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (401, 857, 5, 44, '2008-08-14 17:05:24', '2008-03-21 04:12:39', '2010-09-19 02:29:31');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (989, 67, 39, 33, '2009-10-01 23:57:09', '2009-01-14 01:05:37', '2010-02-02 22:55:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (71, 69, 16, 17, '2009-11-07 22:28:46', '2009-02-01 03:26:42', '2010-06-29 17:15:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (576, 641, 11, 87, '2009-11-10 04:24:15', '2009-05-27 23:32:26', '2010-07-24 03:33:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (446, 8, 24, 93, '2009-08-06 23:53:59', '2009-05-01 06:20:55', '2010-07-18 06:31:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 214, 16, 89, '2009-09-14 04:49:20', '2009-07-21 22:35:42', '2010-07-03 23:46:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (25, 685, 1, 90, '2009-02-11 19:44:09', '2009-03-26 19:33:24', '2011-01-24 20:06:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (651, 726, 26, 21, '2009-02-03 12:29:06', '2009-04-05 21:56:29', '2010-08-26 06:51:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (11, 492, 27, 43, '2009-05-15 04:58:59', '2009-04-12 05:02:59', '2010-09-14 19:28:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (451, 689, 22, 34, '2009-11-08 20:54:25', '2009-01-29 10:35:21', '2010-06-30 01:44:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (921, 649, 31, 18, '2009-11-23 08:52:05', '2009-02-24 05:52:01', '2012-03-14 03:57:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (450, 684, 19, 57, '2009-06-25 02:38:19', '2009-07-19 22:57:29', '2011-04-08 11:13:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (915, 791, 20, 19, '2009-08-05 04:12:02', '2009-06-13 04:32:39', '2012-04-26 11:34:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (679, 226, 28, 66, '2009-08-07 04:13:10', '2009-04-24 13:04:58', '2012-06-15 14:39:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (862, 311, 33, 98, '2009-08-16 03:10:00', '2009-06-14 08:49:56', '2011-07-21 05:23:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (920, 586, 1, 6, '2009-03-29 13:29:24', '2009-03-03 08:17:01', '2012-01-27 22:53:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (344, 449, 17, 90, '2009-12-21 14:06:25', '2009-03-05 16:13:45', '2011-12-14 15:08:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (785, 570, 1, 75, '2009-10-23 13:40:16', '2009-03-18 19:12:46', '2012-08-09 06:39:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (445, 620, 39, 41, '2009-07-09 21:07:51', '2009-06-23 07:13:37', '2011-09-28 13:26:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (859, 492, 1, 9, '2009-08-09 20:47:12', '2009-04-23 17:15:33', '2010-08-04 10:14:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (88, 920, 27, 48, '2009-05-19 03:40:35', '2009-06-13 02:54:03', '2011-01-06 12:00:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (654, 349, 20, 5, '2009-08-26 23:29:09', '2009-02-22 00:43:21', '2012-05-17 17:05:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (666, 810, 14, 85, '2009-07-28 12:16:01', '2009-03-01 02:11:48', '2010-08-02 16:25:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (65, 425, 29, 16, '2009-03-04 12:57:42', '2009-03-10 20:03:10', '2011-01-22 23:36:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (61, 512, 16, 70, '2009-02-08 06:03:48', '2009-07-04 20:11:22', '2011-07-29 21:12:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (108, 596, 8, 79, '2009-11-13 13:56:24', '2009-07-05 17:56:52', '2012-07-15 14:54:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (821, 511, 7, 80, '2009-05-27 18:51:04', '2009-04-14 23:30:07', '2011-06-16 14:07:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (244, 689, 36, 55, '2009-01-04 05:04:54', '2009-05-26 05:08:59', '2010-10-31 09:08:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (35, 115, 14, 52, '2009-08-29 00:46:42', '2009-06-29 07:40:40', '2010-05-31 04:31:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (968, 537, 27, 95, '2009-03-25 02:58:31', '2009-03-06 05:16:53', '2010-11-07 23:22:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 455, 9, 65, '2009-04-25 01:43:48', '2009-02-13 14:44:17', '2011-08-17 14:26:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (364, 809, 1, 96, '2009-01-08 18:43:15', '2009-07-17 21:44:33', '2012-04-22 21:36:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (836, 508, 21, 47, '2009-06-12 22:49:23', '2009-06-17 23:19:24', '2010-04-17 08:27:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (106, 148, 21, 25, '2009-12-04 13:01:46', '2009-06-01 23:57:11', '2012-02-05 19:56:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (650, 628, 17, 18, '2009-12-03 15:53:58', '2009-04-19 14:24:08', '2011-08-09 02:21:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (450, 577, 7, 2, '2009-05-11 04:01:49', '2009-02-08 06:04:43', '2010-02-08 01:14:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (473, 114, 39, 48, '2009-03-07 23:23:44', '2009-03-15 21:38:06', '2011-08-19 06:51:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (924, 639, 37, 76, '2009-02-21 19:48:30', '2009-04-11 05:26:58', '2011-07-07 21:06:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (953, 546, 23, 50, '2009-08-20 22:03:43', '2009-06-22 05:12:50', '2011-09-12 05:54:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (431, 911, 22, 62, '2009-03-12 08:04:19', '2009-03-17 10:24:48', '2012-07-12 02:13:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (610, 718, 28, 10, '2009-09-21 19:41:02', '2009-05-02 19:57:46', '2011-02-26 21:04:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (133, 948, 28, 68, '2009-03-01 13:56:22', '2009-04-15 07:43:48', '2012-01-06 18:45:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (125, 919, 10, 13, '2009-04-02 07:03:21', '2009-02-05 12:19:54', '2011-01-03 18:55:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (719, 800, 26, 88, '2009-09-01 21:38:47', '2009-04-09 08:21:53', '2011-02-06 23:10:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (163, 42, 31, 99, '2009-09-16 19:04:30', '2009-03-04 18:18:08', '2010-09-12 09:46:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (334, 122, 33, 96, '2009-12-04 16:39:20', '2009-04-21 00:13:23', '2012-02-10 21:09:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (498, 522, 39, 89, '2009-06-16 06:30:31', '2009-06-22 04:10:54', '2010-03-08 05:21:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (515, 742, 17, 29, '2009-09-14 13:06:08', '2009-03-06 01:40:27', '2010-09-09 07:28:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (746, 130, 40, 92, '2009-04-02 02:38:53', '2009-03-22 01:32:13', '2010-06-23 15:11:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (150, 998, 34, 28, '2009-03-12 07:21:16', '2009-05-02 13:59:00', '2012-01-27 02:33:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (889, 344, 9, 78, '2009-02-01 06:35:28', '2009-05-12 12:13:48', '2011-12-23 17:28:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (930, 863, 9, 28, '2009-12-17 19:40:15', '2009-03-30 11:44:15', '2011-07-10 23:16:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (314, 8, 20, 62, '2009-08-20 18:03:33', '2009-03-04 09:23:07', '2010-09-26 00:06:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (31, 493, 31, 11, '2009-04-29 11:51:47', '2009-04-19 19:01:35', '2011-02-28 18:21:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (813, 473, 29, 23, '2009-11-06 13:45:32', '2009-01-02 00:11:28', '2010-10-15 03:46:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (277, 608, 25, 88, '2009-07-28 18:50:21', '2009-02-28 18:55:32', '2010-11-28 01:18:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (403, 998, 32, 51, '2009-04-11 22:06:26', '2009-06-28 21:10:13', '2011-09-03 13:25:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (99, 170, 15, 25, '2009-01-07 01:05:35', '2009-07-30 05:47:45', '2011-08-30 09:58:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (617, 767, 30, 5, '2009-04-27 09:06:48', '2009-03-29 16:04:25', '2010-06-20 16:36:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (104, 214, 28, 45, '2009-08-30 12:28:31', '2009-05-23 14:31:56', '2010-04-28 22:20:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (103, 412, 17, 48, '2009-09-10 02:11:32', '2009-03-20 07:27:44', '2010-09-19 05:48:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (700, 29, 2, 48, '2009-05-22 10:33:09', '2009-06-21 01:48:15', '2011-08-13 23:36:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (497, 866, 27, 66, '2009-07-11 05:44:11', '2009-07-01 17:44:32', '2012-07-28 01:56:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (509, 247, 7, 91, '2009-03-31 20:50:05', '2009-03-11 15:01:43', '2011-07-04 00:29:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (193, 185, 11, 21, '2009-05-29 08:00:48', '2009-07-27 19:38:35', '2011-07-27 14:30:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (744, 555, 24, 71, '2009-11-09 12:27:57', '2009-02-21 13:24:48', '2012-01-20 20:09:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (1, 506, 8, 14, '2009-03-12 00:16:52', '2009-06-27 16:46:47', '2011-01-28 19:31:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (454, 20, 18, 70, '2009-05-05 16:16:42', '2009-06-27 22:30:01', '2010-04-16 08:33:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (627, 493, 25, 8, '2009-06-25 18:42:17', '2009-06-11 17:19:59', '2011-12-29 13:31:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (45, 984, 10, 69, '2009-10-23 07:11:13', '2009-03-09 08:44:14', '2011-08-20 23:24:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (14, 958, 14, 44, '2009-10-09 09:36:08', '2009-03-24 00:18:18', '2010-02-09 14:26:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (30, 880, 39, 59, '2009-06-26 16:59:59', '2009-07-26 13:09:06', '2010-08-28 18:23:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (699, 584, 39, 2, '2009-07-14 08:19:36', '2009-03-05 07:59:50', '2011-04-18 04:16:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (394, 267, 30, 3, '2009-03-29 19:30:49', '2009-02-18 20:46:16', '2011-04-03 00:47:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (489, 86, 39, 28, '2009-05-30 06:18:28', '2009-04-17 21:42:35', '2011-11-04 18:48:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (355, 978, 36, 21, '2009-11-01 10:55:22', '2009-06-04 11:01:24', '2011-10-01 22:01:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (97, 236, 27, 88, '2009-06-01 05:05:08', '2009-03-08 17:34:18', '2010-05-05 07:52:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (514, 641, 26, 5, '2009-03-07 01:49:45', '2009-06-24 17:44:46', '2010-03-09 03:27:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (681, 770, 20, 35, '2009-09-03 17:06:38', '2009-03-04 03:28:27', '2012-02-27 22:42:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (253, 555, 26, 77, '2009-04-25 21:08:23', '2009-05-07 19:58:16', '2011-08-15 19:48:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (564, 805, 31, 40, '2009-10-15 01:47:49', '2009-07-10 00:45:51', '2012-05-24 00:06:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (678, 737, 21, 77, '2009-06-02 23:29:28', '2009-04-25 00:06:31', '2011-11-25 13:56:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (75, 484, 36, 60, '2009-08-03 23:44:40', '2009-05-26 02:01:11', '2010-05-11 13:33:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (285, 141, 13, 88, '2009-05-29 17:13:28', '2009-01-22 16:31:00', '2010-02-21 03:58:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (25, 65, 26, 38, '2009-01-04 19:35:49', '2009-06-09 21:13:44', '2011-07-04 21:28:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 316, 23, 55, '2009-06-02 05:33:30', '2009-05-20 04:19:26', '2012-07-15 22:03:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (567, 793, 26, 74, '2009-07-01 09:50:25', '2009-07-23 09:16:05', '2010-07-21 14:33:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (214, 350, 6, 49, '2009-10-14 12:03:00', '2009-01-21 14:52:17', '2010-04-17 11:06:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (820, 586, 10, 90, '2009-08-08 01:27:34', '2009-01-31 17:46:21', '2010-02-24 01:01:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (850, 99, 26, 53, '2009-12-07 16:38:32', '2009-07-25 03:48:51', '2011-08-06 02:48:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (468, 785, 36, 95, '2009-06-06 02:06:10', '2009-01-16 07:37:41', '2010-07-21 11:22:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (365, 499, 13, 50, '2009-05-16 07:10:24', '2009-01-10 21:33:12', '2011-12-30 04:50:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (437, 225, 18, 3, '2009-12-01 20:14:07', '2009-07-12 10:39:34', '2012-06-12 13:03:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (113, 461, 4, 29, '2009-08-07 06:34:21', '2009-07-13 12:14:37', '2012-02-02 22:57:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (410, 391, 11, 78, '2009-08-22 14:07:18', '2009-01-10 05:27:24', '2011-11-25 08:33:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (121, 513, 10, 57, '2009-10-09 20:18:43', '2009-04-09 12:22:21', '2011-10-17 02:10:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (883, 291, 37, 22, '2009-06-28 14:07:40', '2009-04-07 13:04:42', '2010-02-21 00:18:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (64, 215, 39, 50, '2009-05-17 13:47:36', '2009-01-07 06:51:24', '2011-09-18 20:58:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (745, 470, 17, 48, '2009-09-11 02:13:53', '2009-01-30 05:13:46', '2011-10-21 15:59:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (846, 216, 2, 27, '2009-03-07 03:04:39', '2009-07-21 05:47:04', '2012-07-27 06:50:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (576, 280, 27, 1, '2009-02-17 09:35:39', '2009-03-03 02:34:53', '2011-01-23 15:11:58');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (223, 707, 37, 17, '2010-03-01 09:32:35', '2010-05-13 18:08:47', '2013-04-12 10:20:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (861, 673, 37, 3, '2010-11-11 02:34:26', '2010-04-20 04:12:11', '2011-02-27 17:39:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (776, 518, 10, 56, '2010-01-04 14:41:14', '2010-07-09 03:35:17', '2013-06-02 07:08:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (5, 781, 12, 75, '2010-11-26 17:53:01', '2010-03-03 20:44:17', '2011-06-26 04:45:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (547, 76, 9, 23, '2010-09-20 16:18:12', '2010-07-06 05:48:46', '2012-02-12 22:44:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (242, 736, 2, 30, '2010-01-30 23:47:28', '2010-06-04 00:13:29', '2011-08-28 17:03:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (707, 878, 15, 16, '2010-08-05 13:55:34', '2010-05-23 01:40:05', '2011-11-06 11:50:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (564, 805, 31, 24, '2010-12-05 17:37:40', '2010-06-22 20:11:03', '2013-03-08 22:44:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (225, 708, 15, 26, '2010-06-25 17:13:41', '2010-01-15 00:47:40', '2011-02-11 02:57:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (362, 243, 4, 6, '2010-05-19 18:51:16', '2010-05-20 17:02:38', '2013-04-27 03:38:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (558, 230, 10, 1, '2010-02-26 20:57:44', '2010-05-07 09:19:22', '2012-10-01 04:53:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (414, 615, 29, 91, '2010-05-03 23:34:57', '2010-01-07 13:41:44', '2012-01-11 07:25:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (720, 923, 29, 99, '2010-11-22 01:52:57', '2010-07-15 22:04:42', '2012-06-26 09:26:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (905, 282, 18, 35, '2010-06-23 02:34:30', '2010-03-14 17:59:35', '2012-05-07 16:43:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (766, 306, 23, 78, '2010-10-01 15:01:13', '2010-02-01 14:42:02', '2012-03-08 06:56:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (1, 517, 21, 58, '2010-05-19 10:54:40', '2010-03-23 00:55:04', '2011-11-10 00:41:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (495, 599, 16, 44, '2010-04-14 09:46:51', '2010-02-06 03:09:00', '2012-11-25 01:56:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (139, 478, 27, 38, '2010-08-14 20:53:25', '2010-01-31 02:30:54', '2011-02-24 19:23:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (507, 480, 31, 30, '2010-12-07 19:21:11', '2010-04-22 07:54:04', '2011-04-09 20:43:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (296, 107, 23, 79, '2010-01-28 19:34:01', '2010-02-05 01:26:22', '2013-05-13 00:03:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (712, 622, 27, 98, '2010-09-27 20:54:11', '2010-04-04 21:44:24', '2011-06-18 19:53:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (380, 675, 37, 29, '2010-10-05 10:47:07', '2010-07-31 17:23:20', '2012-12-21 11:09:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 68, 16, 82, '2010-05-29 06:22:55', '2010-04-09 15:36:25', '2012-09-28 13:02:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (216, 800, 36, 2, '2010-07-20 20:06:58', '2010-07-21 13:50:56', '2012-09-30 03:13:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (208, 921, 25, 73, '2010-02-27 04:13:15', '2010-03-19 12:27:34', '2011-05-06 15:55:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (951, 261, 6, 16, '2010-09-26 05:16:21', '2010-04-27 02:43:41', '2011-07-30 20:40:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (919, 198, 24, 30, '2010-05-28 15:39:26', '2010-01-14 23:09:01', '2013-03-20 04:15:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (985, 657, 4, 57, '2010-02-15 03:09:35', '2010-04-25 05:36:53', '2012-10-10 21:00:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (462, 640, 17, 100, '2010-09-03 09:42:01', '2010-07-25 00:19:37', '2012-02-28 04:28:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (446, 629, 26, 29, '2010-12-18 00:51:32', '2010-05-28 19:53:01', '2011-11-30 15:08:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (170, 707, 7, 6, '2010-12-19 13:00:42', '2010-02-09 14:02:15', '2012-05-08 03:39:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (693, 895, 37, 63, '2010-04-06 14:47:15', '2010-04-30 02:09:34', '2012-09-12 08:40:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (113, 273, 14, 13, '2010-10-31 17:58:25', '2010-04-08 06:07:39', '2013-07-31 08:48:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (544, 168, 21, 21, '2010-06-05 10:52:33', '2010-07-20 15:39:36', '2012-02-15 16:57:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (66, 271, 8, 88, '2010-06-07 14:21:05', '2010-05-15 03:45:21', '2012-12-20 11:23:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (301, 176, 16, 38, '2010-10-23 02:05:13', '2010-07-11 02:12:40', '2011-11-02 01:45:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (499, 547, 34, 60, '2010-06-08 02:52:36', '2010-03-16 21:51:19', '2013-06-11 17:28:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (696, 912, 40, 12, '2010-09-06 07:46:48', '2010-03-13 15:50:34', '2012-08-15 16:28:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (677, 495, 6, 48, '2010-09-25 08:01:40', '2010-01-28 11:27:48', '2011-02-09 10:05:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (523, 163, 30, 67, '2010-10-26 04:03:57', '2010-07-23 07:29:39', '2013-03-15 21:02:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (632, 219, 38, 12, '2010-08-21 05:52:47', '2010-01-22 17:50:52', '2012-07-23 07:33:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (91, 191, 39, 3, '2010-05-07 00:14:43', '2010-05-26 07:16:44', '2011-02-13 12:18:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (841, 945, 30, 92, '2010-01-04 08:46:22', '2010-05-11 02:39:10', '2013-05-04 00:59:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (835, 636, 36, 100, '2010-09-20 03:40:28', '2010-02-12 14:15:41', '2013-01-18 21:27:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (321, 768, 13, 44, '2010-03-24 22:15:01', '2010-03-25 17:50:14', '2012-01-16 10:24:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (732, 212, 21, 56, '2010-01-29 12:35:16', '2010-04-14 16:04:29', '2012-06-28 08:30:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (452, 276, 8, 94, '2010-04-04 16:20:15', '2010-04-23 08:13:15', '2011-11-02 06:04:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (107, 653, 13, 90, '2010-11-10 14:12:05', '2010-05-06 08:51:14', '2011-04-19 00:55:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (92, 668, 25, 43, '2010-07-21 02:00:27', '2010-06-27 11:23:46', '2013-04-18 20:05:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (674, 752, 17, 72, '2010-08-28 19:24:39', '2010-04-20 16:47:50', '2011-04-03 17:09:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (510, 552, 35, 55, '2010-10-30 23:25:19', '2010-03-31 05:06:14', '2012-11-15 13:14:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (633, 711, 4, 25, '2010-12-23 19:19:44', '2010-03-13 09:35:31', '2011-10-06 15:14:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (386, 801, 31, 17, '2010-03-30 06:08:45', '2010-01-16 11:26:12', '2011-11-23 11:27:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (270, 251, 33, 87, '2010-09-12 15:25:37', '2010-06-21 15:08:50', '2012-11-07 23:22:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (617, 453, 9, 70, '2010-11-03 13:47:22', '2010-06-22 08:38:59', '2013-06-15 10:52:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (494, 756, 12, 15, '2010-02-16 04:14:02', '2010-01-03 01:44:37', '2012-08-05 23:34:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (303, 723, 34, 20, '2010-05-03 19:35:53', '2010-03-01 09:10:32', '2012-05-31 02:26:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (154, 538, 11, 47, '2010-02-20 06:10:54', '2010-05-09 07:54:46', '2012-09-21 04:55:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (65, 683, 36, 10, '2010-05-13 08:14:46', '2010-07-22 14:06:39', '2011-08-31 12:56:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (940, 743, 30, 13, '2010-12-31 22:02:13', '2010-04-12 19:32:45', '2013-03-16 02:41:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (296, 63, 36, 37, '2010-02-19 09:25:16', '2010-04-26 14:46:56', '2013-03-26 06:00:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (180, 239, 38, 87, '2010-09-21 20:23:42', '2010-03-21 00:02:30', '2013-02-09 07:12:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (377, 174, 31, 89, '2010-12-07 14:58:09', '2010-06-06 17:43:36', '2012-08-15 09:06:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (219, 226, 31, 93, '2010-06-17 21:45:59', '2010-07-27 06:23:43', '2012-06-03 04:33:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (350, 434, 12, 18, '2010-11-11 19:16:43', '2010-03-07 09:12:11', '2012-04-19 00:41:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (724, 982, 27, 91, '2010-11-14 17:52:30', '2010-04-25 10:22:57', '2011-12-25 10:02:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (527, 674, 8, 94, '2010-04-04 11:41:18', '2010-07-17 01:47:15', '2013-03-05 07:11:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (5, 503, 32, 28, '2010-09-13 08:10:03', '2010-01-23 22:31:14', '2012-01-10 21:14:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (41, 625, 22, 75, '2010-07-21 06:22:58', '2010-05-17 22:05:09', '2012-09-15 17:02:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (204, 718, 16, 26, '2010-12-13 18:00:41', '2010-03-03 23:49:25', '2011-12-03 07:34:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (754, 356, 14, 30, '2010-11-20 22:49:15', '2010-06-11 13:49:05', '2011-11-06 00:09:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (180, 111, 21, 10, '2010-06-25 18:32:33', '2010-04-18 07:03:25', '2013-04-03 13:15:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (180, 254, 14, 36, '2010-07-14 12:22:54', '2010-05-16 22:42:42', '2011-03-24 06:27:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (815, 689, 32, 22, '2010-06-18 15:29:37', '2010-07-18 07:27:47', '2011-02-27 16:39:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (270, 528, 5, 49, '2010-06-30 14:33:49', '2010-03-19 17:35:25', '2011-12-04 01:21:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (398, 166, 36, 27, '2010-12-30 01:26:31', '2010-06-22 22:54:29', '2013-03-06 04:21:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (814, 801, 5, 54, '2010-02-08 19:16:51', '2010-06-09 20:21:30', '2011-05-05 06:26:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (185, 672, 16, 45, '2010-11-03 09:13:10', '2010-04-16 13:01:09', '2012-12-01 04:13:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (608, 649, 20, 61, '2010-08-30 05:09:13', '2010-03-20 19:15:42', '2011-06-10 03:31:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (826, 966, 26, 34, '2010-09-12 05:55:36', '2010-01-27 13:07:00', '2013-03-29 18:06:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (405, 507, 31, 6, '2010-05-18 12:58:00', '2010-06-08 18:46:14', '2011-06-28 21:40:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (949, 242, 29, 77, '2010-06-21 00:03:15', '2010-02-07 18:44:10', '2011-08-23 06:06:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (972, 50, 9, 69, '2010-08-27 21:54:08', '2010-07-14 00:48:06', '2011-08-26 07:49:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (733, 130, 22, 54, '2010-06-22 05:19:31', '2010-06-07 09:04:22', '2013-02-17 23:57:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (596, 774, 23, 58, '2010-11-19 13:25:15', '2010-05-04 14:45:21', '2013-06-20 12:55:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (106, 496, 10, 49, '2010-07-06 21:50:22', '2010-03-01 17:41:39', '2011-08-10 09:25:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (884, 312, 7, 8, '2010-06-16 19:08:02', '2010-07-31 09:58:39', '2012-03-02 12:02:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (769, 145, 32, 97, '2010-12-06 14:27:18', '2010-07-05 17:58:55', '2013-04-29 05:35:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (59, 611, 14, 10, '2010-08-17 19:15:12', '2010-06-29 19:53:51', '2011-12-12 09:08:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (648, 448, 16, 4, '2010-03-01 19:20:41', '2010-03-23 03:46:26', '2011-08-09 18:01:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (845, 786, 24, 18, '2010-12-14 17:05:28', '2010-04-12 00:39:37', '2011-02-06 11:23:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (457, 792, 25, 1, '2010-09-27 12:12:38', '2010-05-19 19:22:43', '2012-05-19 20:01:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (397, 567, 32, 68, '2010-02-08 07:02:12', '2010-02-16 20:36:07', '2012-04-07 05:32:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (319, 716, 40, 78, '2010-11-17 05:32:37', '2010-01-27 07:44:00', '2011-12-18 06:39:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (233, 558, 19, 85, '2010-05-23 11:58:25', '2010-06-16 06:58:37', '2012-01-21 11:56:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (474, 756, 23, 63, '2010-10-17 12:23:20', '2010-03-17 21:48:07', '2012-10-28 04:35:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (707, 80, 37, 97, '2010-04-09 10:51:17', '2010-05-11 05:19:28', '2011-08-31 09:39:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (250, 357, 23, 52, '2010-12-23 22:40:53', '2010-02-23 18:24:57', '2012-01-05 23:04:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (799, 463, 19, 28, '2010-04-07 20:54:50', '2010-07-27 09:56:14', '2011-12-19 22:13:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (538, 574, 3, 79, '2010-03-18 08:44:12', '2010-07-10 12:11:06', '2011-11-25 03:35:40');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (836, 264, 22, 63, '2011-02-17 13:08:44', '2011-04-12 05:04:17', '2012-05-16 13:58:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (718, 375, 15, 10, '2011-08-13 16:04:01', '2011-01-23 13:48:19', '2013-05-02 16:25:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (405, 851, 28, 49, '2011-11-19 18:17:28', '2011-02-11 15:56:46', '2012-03-25 14:18:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (758, 345, 13, 59, '2011-09-12 16:09:50', '2011-01-12 23:09:18', '2014-05-12 14:56:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (52, 645, 25, 97, '2011-09-09 20:21:29', '2011-04-21 13:44:55', '2013-08-07 19:27:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 803, 7, 96, '2011-09-21 10:43:46', '2011-03-03 08:12:45', '2012-04-17 15:26:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (640, 196, 20, 51, '2011-12-17 23:26:36', '2011-02-21 21:25:23', '2013-05-11 01:47:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (399, 289, 5, 41, '2011-02-13 01:19:41', '2011-07-31 07:41:13', '2014-03-21 07:43:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (835, 167, 23, 3, '2011-06-03 10:41:09', '2011-05-27 21:48:45', '2012-06-26 18:27:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (937, 602, 17, 20, '2011-04-03 12:42:49', '2011-04-25 00:07:35', '2012-05-03 02:48:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (837, 743, 24, 99, '2011-06-27 19:06:25', '2011-01-01 01:48:58', '2013-03-13 14:13:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (322, 129, 2, 27, '2011-10-22 15:36:51', '2011-03-16 13:54:51', '2013-08-06 05:27:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (809, 678, 1, 31, '2011-04-20 04:41:28', '2011-07-31 21:26:43', '2012-06-27 11:28:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (580, 885, 19, 15, '2011-02-21 12:42:00', '2011-07-24 02:08:16', '2013-04-07 01:01:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (327, 834, 1, 55, '2011-05-08 17:25:23', '2011-06-18 08:31:44', '2013-08-17 07:58:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (872, 241, 14, 75, '2011-12-09 15:17:03', '2011-07-28 09:08:49', '2012-11-25 08:48:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (482, 566, 39, 24, '2011-03-02 17:31:36', '2011-04-06 15:09:56', '2014-01-04 04:36:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (812, 456, 7, 10, '2011-12-10 06:15:23', '2011-06-15 19:57:00', '2014-06-14 03:39:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (27, 98, 12, 99, '2011-04-28 03:09:18', '2011-05-05 23:41:33', '2012-03-26 16:29:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (495, 508, 15, 15, '2011-11-07 04:31:55', '2011-02-03 06:52:43', '2013-04-23 20:15:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (683, 35, 11, 100, '2011-06-24 11:56:24', '2011-06-10 05:06:04', '2013-10-22 22:15:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (963, 220, 39, 63, '2011-06-19 06:13:52', '2011-03-11 04:11:14', '2013-02-11 15:00:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (384, 745, 31, 28, '2011-05-29 01:32:48', '2011-02-01 23:44:02', '2013-07-12 20:08:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (470, 523, 39, 40, '2011-07-11 05:14:59', '2011-04-11 19:37:33', '2014-04-12 17:41:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (990, 786, 12, 81, '2011-05-17 09:23:02', '2011-01-28 14:17:01', '2013-04-14 05:03:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (992, 331, 26, 75, '2011-04-12 20:48:28', '2011-04-30 06:37:18', '2012-05-28 01:40:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (175, 681, 28, 36, '2011-08-21 10:11:55', '2011-07-13 12:36:25', '2013-01-22 10:16:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (950, 804, 32, 13, '2011-02-12 19:37:06', '2011-06-20 07:04:03', '2013-12-22 17:46:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (680, 461, 36, 56, '2011-03-23 12:42:30', '2011-04-12 12:24:55', '2012-09-28 19:16:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (352, 94, 18, 78, '2011-01-05 12:42:40', '2011-02-17 23:25:26', '2012-10-26 15:19:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (839, 199, 34, 60, '2011-12-04 02:44:45', '2011-01-12 09:28:02', '2014-07-03 13:53:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (234, 249, 3, 45, '2011-01-02 01:52:33', '2011-02-23 15:28:26', '2014-01-22 23:20:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (972, 451, 40, 45, '2011-03-11 04:19:29', '2011-03-22 00:50:39', '2014-05-25 05:38:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (478, 927, 28, 36, '2011-11-07 01:33:06', '2011-07-18 00:55:19', '2012-12-02 13:21:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (24, 284, 37, 14, '2011-06-19 02:18:05', '2011-06-08 23:03:40', '2013-10-16 20:10:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (608, 257, 38, 91, '2011-07-03 22:23:33', '2011-03-28 21:21:35', '2013-11-03 08:55:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (410, 677, 28, 14, '2011-07-21 06:59:43', '2011-02-19 11:44:04', '2012-08-10 15:52:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (272, 124, 39, 3, '2011-04-24 22:29:53', '2011-02-21 16:23:16', '2013-04-29 04:39:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (108, 27, 39, 32, '2011-09-30 13:18:59', '2011-04-21 03:50:51', '2013-10-16 14:19:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (703, 280, 34, 88, '2011-03-14 06:33:45', '2011-07-25 02:25:52', '2014-03-16 06:11:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (35, 440, 6, 72, '2011-07-27 02:01:03', '2011-06-22 20:16:08', '2014-01-18 03:10:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (945, 702, 19, 77, '2011-10-24 20:24:09', '2011-05-05 12:19:25', '2012-10-27 11:23:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (217, 241, 29, 23, '2011-09-13 10:02:32', '2011-06-27 04:06:14', '2012-08-04 04:59:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (405, 181, 4, 75, '2011-08-21 23:18:41', '2011-05-30 08:18:32', '2012-10-24 18:44:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (156, 943, 16, 10, '2011-12-17 00:19:59', '2011-01-08 10:32:03', '2012-03-11 03:02:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (365, 384, 21, 88, '2011-11-09 01:55:56', '2011-03-30 05:00:34', '2014-03-22 02:43:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (947, 914, 10, 61, '2011-12-08 11:54:09', '2011-04-01 02:07:20', '2012-06-11 06:26:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (977, 703, 30, 54, '2011-07-04 23:20:41', '2011-02-21 22:14:53', '2014-01-08 05:31:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (601, 792, 14, 46, '2011-09-21 22:59:17', '2011-04-08 21:05:20', '2012-02-20 12:13:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (212, 801, 27, 97, '2011-06-16 04:50:33', '2011-03-23 22:49:39', '2013-06-28 09:07:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (254, 134, 33, 59, '2011-07-27 20:09:48', '2011-01-29 09:40:39', '2013-08-13 20:15:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (591, 523, 30, 9, '2011-09-01 09:49:26', '2011-01-14 18:58:04', '2014-01-10 14:20:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (267, 132, 34, 52, '2011-08-15 23:22:04', '2011-02-09 13:12:19', '2014-01-11 22:18:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (559, 735, 11, 30, '2011-12-01 02:10:51', '2011-02-09 02:27:21', '2012-04-26 15:56:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (57, 39, 14, 16, '2011-12-27 05:25:20', '2011-05-21 11:22:30', '2012-06-10 01:25:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (265, 26, 13, 27, '2011-01-10 15:56:51', '2011-06-12 07:52:59', '2012-11-18 00:03:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (530, 749, 6, 2, '2011-03-18 01:32:50', '2011-02-26 17:58:23', '2012-09-09 01:03:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (326, 202, 31, 96, '2011-06-30 05:40:34', '2011-07-25 20:44:10', '2013-08-21 11:36:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (138, 196, 19, 87, '2011-08-22 23:22:42', '2011-04-22 17:17:15', '2012-09-07 09:34:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (812, 767, 19, 25, '2011-04-11 14:40:45', '2011-01-13 12:49:56', '2012-12-14 18:38:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (830, 944, 2, 62, '2011-11-18 07:30:00', '2011-04-23 18:56:23', '2012-11-21 08:38:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (919, 653, 3, 21, '2011-10-27 00:42:24', '2011-06-09 18:01:47', '2012-05-13 11:25:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (137, 248, 31, 61, '2011-10-04 17:44:33', '2011-05-13 12:58:11', '2014-04-04 06:29:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (692, 7, 29, 42, '2011-10-27 09:09:31', '2011-06-06 07:55:24', '2012-12-06 23:15:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (867, 781, 18, 84, '2011-11-14 20:43:35', '2011-04-24 21:32:03', '2012-07-02 08:22:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (763, 311, 36, 60, '2011-08-21 21:27:15', '2011-06-13 08:09:10', '2013-02-03 10:48:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (309, 239, 22, 15, '2011-01-02 22:40:19', '2011-03-03 07:52:31', '2014-03-09 08:15:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (372, 689, 12, 29, '2011-02-03 22:49:02', '2011-07-29 14:25:27', '2012-11-30 05:45:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (368, 139, 20, 91, '2011-04-26 18:48:06', '2011-07-22 06:43:20', '2013-10-06 19:09:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (57, 962, 18, 86, '2011-12-16 17:23:18', '2011-03-11 01:05:20', '2012-07-29 14:02:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (102, 524, 32, 94, '2011-06-11 06:06:36', '2011-02-15 11:16:16', '2014-04-07 20:56:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (713, 851, 21, 35, '2011-02-12 07:22:06', '2011-03-04 04:50:55', '2014-03-17 14:18:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (75, 126, 3, 95, '2011-12-29 05:00:22', '2011-05-30 04:52:11', '2012-07-11 18:33:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (670, 662, 29, 38, '2011-06-18 08:19:44', '2011-05-11 17:53:59', '2012-08-14 02:17:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (519, 833, 22, 45, '2011-11-26 13:43:12', '2011-02-13 11:03:50', '2014-02-04 07:05:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (630, 521, 23, 63, '2011-04-04 14:10:53', '2011-05-27 06:47:25', '2014-01-30 23:54:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (229, 757, 25, 92, '2011-04-11 10:23:58', '2011-04-23 04:14:40', '2012-07-26 18:01:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (280, 610, 1, 42, '2011-01-28 12:33:07', '2011-05-30 15:09:44', '2013-08-23 08:20:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (56, 708, 28, 14, '2011-07-10 17:55:26', '2011-02-03 11:57:23', '2012-10-05 18:32:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (561, 730, 31, 7, '2011-10-21 02:18:38', '2011-05-01 09:35:51', '2013-11-22 20:09:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (473, 863, 38, 35, '2011-12-17 22:17:07', '2011-01-13 08:04:48', '2013-06-13 04:35:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (272, 876, 13, 66, '2011-12-23 16:59:54', '2011-06-24 15:21:57', '2013-09-05 16:31:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (384, 595, 17, 78, '2011-05-10 03:43:39', '2011-04-13 07:20:13', '2013-03-10 11:18:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (902, 168, 36, 65, '2011-07-13 11:57:54', '2011-03-15 18:50:11', '2013-09-03 15:26:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (226, 657, 34, 28, '2011-08-30 02:14:06', '2011-06-16 11:54:32', '2013-05-22 12:45:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (550, 131, 3, 34, '2011-06-03 02:35:07', '2011-06-19 09:31:26', '2013-07-12 04:04:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (700, 622, 4, 100, '2011-02-08 10:09:38', '2011-04-05 12:15:40', '2013-03-21 03:07:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (982, 72, 2, 82, '2011-02-26 01:04:23', '2011-04-22 02:38:09', '2012-07-12 16:54:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (31, 408, 33, 30, '2011-10-18 04:24:23', '2011-03-12 02:26:56', '2013-01-12 17:57:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (675, 695, 19, 58, '2011-03-16 08:24:24', '2011-05-19 04:24:44', '2012-05-23 11:06:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (290, 20, 17, 29, '2011-05-27 08:04:01', '2011-07-11 21:12:20', '2013-11-14 01:45:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (379, 818, 36, 87, '2011-02-26 21:10:41', '2011-04-17 20:51:33', '2013-09-03 07:15:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (411, 252, 36, 100, '2011-05-14 22:51:43', '2011-04-06 11:18:26', '2012-06-09 21:00:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (534, 354, 40, 21, '2011-04-25 17:34:25', '2011-07-26 19:14:17', '2012-06-15 01:06:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (266, 69, 10, 79, '2011-01-18 17:43:21', '2011-04-25 13:23:31', '2014-02-22 12:33:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (273, 132, 9, 6, '2011-11-04 02:25:58', '2011-02-26 14:22:19', '2013-11-21 00:39:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (321, 889, 29, 72, '2011-06-11 01:59:56', '2011-06-07 20:24:29', '2013-11-21 09:20:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (564, 805, 3, 84, '2011-03-07 17:43:00', '2011-04-07 09:12:12', '2014-07-25 18:21:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (3, 824, 31, 62, '2011-10-31 15:29:45', '2011-01-25 05:09:10', '2014-02-25 09:15:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 564, 35, 11, '2011-09-05 06:13:26', '2011-04-18 16:18:33', '2013-02-09 16:13:35');

insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (655, 573, 15, 23, '2012-12-28 08:56:51', '2012-05-29 03:24:20', '2014-08-10 01:40:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (278, 290, 26, 62, '2012-10-21 13:13:37', '2012-04-22 23:29:39', '2014-05-31 09:55:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (869, 85, 6, 57, '2012-10-29 13:21:02', '2012-02-20 17:14:41', '2014-07-06 03:02:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (508, 240, 1, 13, '2012-10-13 21:32:12', '2012-02-23 02:29:24', '2013-11-20 03:07:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (64, 518, 34, 8, '2012-08-06 01:29:03', '2012-05-04 19:16:30', '2015-01-31 13:12:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (668, 787, 17, 43, '2012-10-05 02:48:10', '2012-03-19 12:28:41', '2013-07-05 23:55:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (707, 819, 8, 77, '2012-05-16 11:42:44', '2012-04-30 07:31:19', '2014-08-14 19:34:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (816, 245, 2, 20, '2012-06-01 11:15:44', '2012-03-23 02:56:18', '2014-11-25 03:52:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (164, 137, 11, 49, '2012-06-08 21:25:47', '2012-01-21 04:45:49', '2014-11-14 13:49:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (969, 501, 34, 49, '2012-02-17 11:59:39', '2012-01-27 04:35:20', '2015-05-09 21:31:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (604, 796, 30, 11, '2012-02-22 05:46:19', '2012-02-01 20:14:24', '2013-06-27 11:30:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 780, 5, 85, '2012-11-06 08:36:30', '2012-02-28 15:08:50', '2014-06-25 21:31:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (36, 677, 25, 15, '2012-08-04 20:32:34', '2012-02-12 05:48:39', '2013-03-12 04:24:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (956, 603, 27, 87, '2012-06-22 08:43:44', '2012-02-05 12:29:47', '2015-05-14 18:33:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (415, 541, 19, 30, '2012-03-23 04:14:15', '2012-05-24 23:01:12', '2014-04-24 23:16:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (632, 760, 3, 24, '2012-12-06 19:35:02', '2012-03-20 05:55:52', '2013-09-14 07:21:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (905, 60, 10, 68, '2012-04-03 12:48:29', '2012-01-01 14:53:49', '2014-12-13 23:20:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (871, 546, 2, 89, '2012-11-17 04:27:49', '2012-04-18 21:11:49', '2014-06-17 00:29:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (999, 343, 16, 30, '2012-04-09 01:33:22', '2012-04-05 16:57:29', '2013-09-29 10:42:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (690, 177, 31, 78, '2012-06-06 22:54:18', '2012-04-10 01:12:22', '2014-10-04 04:44:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (13, 71, 20, 23, '2012-04-23 17:20:19', '2012-05-22 17:32:27', '2014-05-12 11:16:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (247, 217, 20, 63, '2012-10-06 06:27:16', '2012-01-05 00:15:23', '2015-01-21 05:14:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (532, 981, 37, 61, '2012-02-01 19:14:27', '2012-05-24 07:38:52', '2015-06-25 09:13:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (803, 26, 21, 17, '2012-07-18 07:48:31', '2012-05-22 14:15:41', '2013-12-26 09:39:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (787, 509, 20, 67, '2012-06-09 14:21:11', '2012-04-25 09:58:22', '2013-11-29 08:57:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (28, 411, 27, 79, '2012-06-07 22:44:17', '2012-03-06 01:04:04', '2013-02-10 18:09:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (899, 38, 18, 65, '2012-08-09 03:52:57', '2012-03-20 20:38:39', '2014-02-10 09:12:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 936, 3, 16, '2012-03-07 19:36:10', '2012-01-23 23:12:42', '2014-04-14 04:32:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (197, 330, 8, 82, '2012-12-09 06:16:30', '2012-04-28 10:03:22', '2014-01-18 14:03:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (203, 655, 29, 72, '2012-01-27 17:47:09', '2012-03-20 02:46:37', '2013-05-09 05:42:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (120, 744, 18, 88, '2012-07-23 15:57:33', '2012-03-31 21:01:38', '2013-07-26 09:27:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (612, 479, 19, 88, '2012-02-20 00:31:52', '2012-02-15 08:10:54', '2013-09-11 20:52:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (190, 202, 39, 96, '2012-10-24 06:03:45', '2012-02-18 09:45:12', '2015-02-22 08:18:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (313, 140, 19, 34, '2012-06-08 00:29:05', '2012-01-06 15:05:40', '2014-07-02 07:46:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (577, 98, 31, 76, '2012-09-25 04:12:00', '2012-01-10 01:22:39', '2014-11-11 10:10:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (887, 823, 12, 50, '2012-12-15 18:50:15', '2012-03-26 13:20:22', '2013-12-16 13:51:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (571, 63, 3, 16, '2012-10-22 16:07:01', '2012-01-19 10:11:02', '2015-03-09 01:15:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (965, 533, 27, 95, '2012-04-03 10:17:08', '2012-03-05 14:40:28', '2015-06-03 05:01:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (991, 436, 39, 20, '2012-01-20 21:56:11', '2012-02-19 08:07:24', '2013-07-19 04:04:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (124, 750, 34, 30, '2012-03-02 09:43:38', '2012-02-14 16:38:08', '2015-02-12 00:07:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (120, 98, 29, 32, '2012-04-25 22:10:15', '2012-03-10 08:59:35', '2015-06-03 09:39:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (28, 22, 27, 47, '2012-03-09 21:42:36', '2012-04-18 10:34:57', '2013-05-01 02:44:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (165, 255, 31, 61, '2012-06-18 16:46:15', '2012-05-14 06:36:29', '2014-10-20 07:32:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (704, 201, 21, 80, '2012-05-20 06:54:42', '2012-01-17 08:17:12', '2014-02-22 03:46:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (598, 597, 30, 18, '2012-12-17 18:01:53', '2012-04-30 20:39:05', '2014-03-17 13:03:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (682, 427, 38, 98, '2012-05-06 16:24:55', '2012-04-13 12:14:29', '2014-12-12 23:09:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (184, 34, 31, 6, '2012-03-03 04:41:48', '2012-05-08 00:15:26', '2013-04-01 16:49:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (72, 506, 1, 100, '2012-08-02 09:21:34', '2012-03-12 23:57:54', '2015-02-18 15:13:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (728, 70, 25, 62, '2012-03-26 14:42:19', '2012-03-19 05:14:11', '2015-03-05 02:37:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (769, 46, 5, 64, '2012-09-01 08:15:45', '2012-03-04 00:37:17', '2015-05-07 08:35:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (930, 943, 35, 63, '2012-07-15 17:56:17', '2012-02-16 16:36:38', '2013-06-29 16:49:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (385, 206, 12, 27, '2012-07-14 16:55:30', '2012-02-27 02:40:16', '2014-06-24 06:47:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (130, 392, 6, 52, '2012-04-10 05:44:40', '2012-02-24 17:00:46', '2015-03-28 12:37:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (291, 915, 25, 53, '2012-11-26 11:46:16', '2012-04-20 17:46:33', '2014-02-10 06:34:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (38, 753, 12, 63, '2012-09-27 17:13:50', '2012-01-21 23:51:44', '2013-06-18 03:24:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (903, 811, 6, 62, '2012-07-02 09:03:23', '2012-01-07 06:11:17', '2013-03-22 06:20:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 366, 16, 3, '2012-03-31 04:12:49', '2012-05-03 12:35:20', '2014-04-02 14:05:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (147, 221, 23, 76, '2012-01-10 16:38:27', '2012-05-13 02:42:28', '2015-07-31 04:22:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (29, 901, 3, 68, '2012-10-17 04:18:42', '2012-05-19 18:15:54', '2015-04-23 09:20:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (500, 420, 4, 54, '2012-01-31 09:25:05', '2012-05-18 04:59:48', '2014-08-02 08:08:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (626, 914, 8, 68, '2012-04-04 10:04:50', '2012-01-15 17:18:58', '2014-04-13 20:07:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (259, 79, 26, 62, '2012-07-20 12:06:13', '2012-02-06 10:19:49', '2014-04-24 10:55:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (748, 42, 26, 17, '2012-01-22 20:47:16', '2012-01-27 11:51:07', '2014-09-22 10:08:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (977, 779, 12, 99, '2012-03-10 19:40:06', '2012-05-07 12:11:33', '2014-12-03 01:09:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (945, 600, 23, 39, '2012-11-20 22:03:50', '2012-03-29 19:46:13', '2015-04-21 03:50:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (582, 535, 11, 36, '2012-12-28 23:54:49', '2012-02-01 05:17:29', '2014-06-29 01:43:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (943, 411, 23, 73, '2012-08-21 17:55:30', '2012-03-17 08:18:26', '2015-02-12 02:04:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (67, 301, 19, 10, '2012-10-02 16:36:22', '2012-05-09 22:40:07', '2013-07-26 07:09:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (550, 622, 30, 51, '2012-10-05 10:21:47', '2012-03-04 15:35:23', '2014-08-22 02:38:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (147, 176, 36, 46, '2012-08-12 23:44:01', '2012-04-30 19:18:03', '2013-02-04 02:18:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (311, 698, 21, 39, '2012-02-13 05:13:59', '2012-04-30 05:59:10', '2013-11-25 16:58:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (422, 409, 4, 39, '2012-11-18 14:17:48', '2012-01-04 16:28:01', '2014-05-25 06:38:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (4, 790, 37, 20, '2012-08-24 07:55:48', '2012-03-31 02:36:03', '2013-12-26 05:03:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (798, 203, 11, 63, '2012-01-16 00:36:26', '2012-04-18 16:56:21', '2014-03-26 04:51:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (600, 895, 26, 75, '2012-08-13 05:47:29', '2012-05-23 21:41:01', '2015-07-03 23:43:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (183, 90, 10, 54, '2012-05-07 02:09:30', '2012-01-24 06:17:46', '2014-10-13 13:07:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (241, 513, 28, 47, '2012-03-19 01:57:18', '2012-05-17 04:33:54', '2015-06-17 01:56:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (634, 740, 11, 97, '2012-01-25 12:40:28', '2012-02-16 08:48:13', '2015-06-06 00:54:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (219, 872, 4, 81, '2012-07-15 20:03:42', '2012-04-03 19:58:09', '2015-02-22 22:25:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (122, 225, 9, 66, '2012-03-08 16:48:44', '2012-03-24 00:17:38', '2014-05-02 15:15:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (87, 79, 11, 13, '2012-10-06 23:11:40', '2012-05-15 01:06:15', '2014-10-29 23:48:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (754, 184, 31, 51, '2012-12-13 04:36:28', '2012-02-27 11:41:19', '2014-11-02 02:34:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (1000, 151, 30, 60, '2012-03-03 07:43:22', '2012-04-10 10:32:28', '2013-10-14 13:13:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (176, 852, 27, 66, '2012-12-07 15:22:04', '2012-01-28 12:15:23', '2013-07-02 05:25:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (169, 210, 22, 3, '2012-06-14 05:28:03', '2012-04-03 01:46:26', '2013-05-17 22:41:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 432, 23, 50, '2012-03-22 08:59:28', '2012-03-22 13:36:48', '2013-06-08 12:15:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (597, 227, 35, 95, '2012-02-14 02:02:02', '2012-01-15 11:34:53', '2014-11-12 11:24:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (962, 159, 28, 84, '2012-11-21 17:17:38', '2012-01-04 07:35:32', '2014-12-09 19:26:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (316, 265, 18, 61, '2012-01-04 05:59:48', '2012-03-20 11:33:31', '2013-09-06 01:16:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (417, 290, 8, 21, '2012-09-08 05:28:44', '2012-04-28 18:26:30', '2014-09-28 23:46:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (469, 353, 6, 25, '2012-09-21 14:34:31', '2012-05-13 01:51:00', '2013-07-10 12:53:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (972, 245, 15, 12, '2012-05-11 04:33:35', '2012-02-22 04:42:53', '2015-04-26 01:19:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (430, 789, 24, 93, '2012-04-18 17:05:02', '2012-03-11 17:08:15', '2014-10-30 06:13:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (124, 703, 24, 41, '2012-08-16 00:52:15', '2012-04-07 01:57:00', '2014-10-27 12:49:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (913, 256, 32, 58, '2012-08-22 21:04:12', '2012-02-10 20:30:06', '2015-06-25 20:48:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 89, 10, 67, '2012-04-30 05:38:59', '2012-04-05 20:25:01', '2015-03-11 12:02:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (106, 282, 20, 97, '2012-12-11 04:55:10', '2012-01-15 13:01:02', '2014-04-12 03:12:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (828, 63, 6, 75, '2012-05-08 11:07:07', '2012-05-21 06:20:27', '2015-05-23 07:14:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (273, 556, 31, 15, '2012-02-29 10:10:41', '2012-01-08 15:42:38', '2014-06-12 04:09:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (702, 17, 5, 89, '2012-06-30 06:21:51', '2012-01-24 20:56:07', '2014-01-14 04:40:26');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (635, 939, 1, 69, '2013-05-02 14:59:34', '2013-01-20 19:19:24', '2016-05-20 21:32:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (558, 355, 36, 24, '2013-10-22 08:49:57', '2013-02-09 19:11:58', '2015-09-04 08:13:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (519, 585, 7, 19, '2013-09-22 10:54:18', '2013-04-24 21:16:31', '2016-03-28 09:46:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (300, 207, 5, 94, '2013-11-20 14:28:03', '2013-01-29 18:54:56', '2015-01-23 05:47:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (387, 16, 40, 50, '2013-02-26 04:03:53', '2013-01-08 04:58:49', '2014-02-23 08:57:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (975, 66, 7, 24, '2013-12-26 20:34:24', '2013-02-03 20:56:49', '2016-06-03 00:06:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (372, 738, 32, 41, '2013-10-12 20:27:48', '2013-04-15 17:21:05', '2014-12-27 19:26:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (990, 792, 21, 32, '2013-04-15 09:30:06', '2013-03-05 18:08:12', '2015-01-24 20:41:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (30, 671, 7, 42, '2013-09-15 12:13:51', '2013-03-22 16:13:03', '2014-02-18 03:06:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (271, 140, 27, 62, '2013-06-16 15:21:54', '2013-02-27 15:37:29', '2014-05-25 17:28:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (726, 478, 12, 38, '2013-02-15 22:09:57', '2013-01-14 04:41:48', '2016-04-05 16:17:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (432, 630, 2, 97, '2013-07-17 19:16:14', '2013-05-11 15:03:44', '2015-07-02 03:47:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (456, 608, 27, 85, '2013-09-19 07:20:57', '2013-04-13 22:03:45', '2014-06-11 11:52:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 370, 40, 25, '2013-04-08 21:28:11', '2013-04-26 15:47:29', '2014-11-05 07:58:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (486, 799, 13, 37, '2013-09-12 09:58:37', '2013-01-16 11:42:48', '2016-03-29 19:58:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (84, 346, 20, 95, '2013-10-17 01:21:09', '2013-01-29 14:52:46', '2016-01-08 09:50:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (875, 77, 5, 12, '2013-02-22 20:18:19', '2013-02-22 14:19:48', '2014-04-07 03:59:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (559, 21, 6, 68, '2013-05-14 03:37:44', '2013-05-08 12:06:44', '2015-09-12 23:03:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (513, 327, 33, 82, '2013-12-11 23:01:52', '2013-01-05 11:11:36', '2014-02-21 08:02:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (219, 316, 25, 45, '2013-09-17 13:11:03', '2013-04-10 20:31:27', '2016-01-19 21:34:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (831, 601, 14, 35, '2013-08-15 02:27:42', '2013-02-09 04:53:45', '2014-04-19 13:02:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (199, 90, 36, 38, '2013-09-25 14:36:13', '2013-04-19 11:45:04', '2015-01-03 07:04:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (680, 519, 3, 88, '2013-01-19 11:47:10', '2013-04-03 23:34:17', '2014-03-31 06:36:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (650, 828, 18, 3, '2013-06-11 21:47:54', '2013-04-03 20:05:48', '2014-12-30 05:06:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (345, 164, 25, 31, '2013-09-06 04:08:40', '2013-01-18 20:12:13', '2014-08-09 15:22:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (580, 415, 5, 22, '2013-12-16 21:53:06', '2013-04-07 15:10:01', '2014-07-14 18:02:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (231, 234, 30, 23, '2013-04-15 10:03:46', '2013-04-15 05:39:07', '2015-09-29 00:12:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (775, 125, 31, 55, '2013-03-05 08:17:45', '2013-03-12 16:27:15', '2015-05-01 10:06:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (686, 503, 32, 61, '2013-07-02 22:01:02', '2013-04-04 02:22:01', '2015-10-28 04:24:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (828, 230, 4, 85, '2013-04-28 06:13:09', '2013-04-13 20:26:47', '2015-04-18 09:29:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (906, 832, 16, 87, '2013-09-01 00:37:19', '2013-02-25 20:32:03', '2014-08-30 15:05:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (222, 842, 4, 6, '2013-12-08 08:01:06', '2013-01-17 10:56:46', '2015-07-06 13:23:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (601, 610, 7, 49, '2013-06-10 11:04:38', '2013-02-16 02:49:15', '2016-03-18 07:22:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (33, 501, 22, 92, '2013-06-30 11:06:40', '2013-05-23 08:24:58', '2015-05-14 19:14:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (448, 920, 37, 2, '2013-02-27 11:28:18', '2013-05-17 15:54:29', '2014-07-31 00:25:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (256, 499, 36, 11, '2013-10-10 22:06:47', '2013-03-01 07:06:00', '2016-01-25 06:57:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (980, 498, 15, 90, '2013-08-15 02:44:45', '2013-04-12 11:47:09', '2016-01-20 07:55:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (432, 395, 14, 72, '2013-09-12 10:42:51', '2013-01-24 11:52:07', '2015-01-07 02:59:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (215, 572, 28, 75, '2013-06-27 17:13:02', '2013-04-18 21:25:19', '2015-01-01 08:12:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (594, 128, 27, 56, '2013-12-11 06:59:21', '2013-02-21 10:26:35', '2014-08-05 00:16:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (115, 151, 18, 45, '2013-08-23 21:48:33', '2013-02-12 05:56:34', '2015-10-13 20:09:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 406, 18, 83, '2013-05-15 10:09:08', '2013-03-14 23:38:02', '2015-03-11 09:04:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (282, 773, 15, 70, '2013-04-21 20:41:55', '2013-04-02 16:05:33', '2016-03-26 13:28:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (363, 859, 25, 49, '2013-02-03 10:45:43', '2013-02-15 07:57:15', '2014-05-12 11:17:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (700, 393, 40, 15, '2013-12-13 20:46:15', '2013-02-14 12:49:48', '2016-02-14 07:43:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (944, 450, 8, 96, '2013-06-18 05:40:05', '2013-03-30 20:24:24', '2014-08-20 14:16:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (368, 244, 33, 65, '2013-03-19 16:28:44', '2013-03-23 09:09:21', '2015-10-03 12:22:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (313, 279, 21, 10, '2013-08-27 23:50:09', '2013-04-30 01:42:52', '2015-04-01 20:23:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (21, 964, 38, 48, '2013-06-06 14:55:57', '2013-04-18 19:48:22', '2016-05-09 00:52:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (221, 735, 7, 58, '2013-12-23 23:50:57', '2013-04-11 17:51:46', '2015-12-14 16:53:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (75, 617, 37, 67, '2013-06-20 08:11:11', '2013-02-08 11:15:22', '2015-04-22 23:46:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (371, 372, 19, 62, '2013-04-15 23:01:09', '2013-05-18 07:03:27', '2016-03-06 15:55:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (799, 340, 35, 45, '2013-02-22 18:09:26', '2013-01-31 03:39:00', '2014-07-05 13:28:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (909, 429, 3, 75, '2013-03-19 17:03:29', '2013-01-25 23:07:36', '2015-05-28 17:21:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (51, 323, 28, 23, '2013-03-24 10:02:33', '2013-05-15 16:38:22', '2015-01-26 14:40:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (782, 853, 31, 84, '2013-07-27 14:30:37', '2013-04-22 16:38:25', '2015-12-09 12:46:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (20, 798, 9, 75, '2013-07-07 01:15:26', '2013-04-24 02:21:27', '2014-12-18 08:19:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (61, 826, 4, 99, '2013-05-28 02:49:10', '2013-03-02 03:14:45', '2015-04-08 08:17:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (994, 928, 39, 27, '2013-04-27 21:17:27', '2013-04-02 14:49:55', '2014-12-23 12:52:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (764, 44, 33, 79, '2013-11-29 03:59:43', '2013-04-09 14:59:32', '2015-06-23 18:28:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (498, 41, 29, 66, '2013-05-31 13:30:00', '2013-01-14 01:02:28', '2015-03-27 19:41:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (561, 13, 2, 13, '2013-04-05 03:37:57', '2013-01-18 07:05:36', '2014-06-13 17:47:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (918, 511, 13, 27, '2013-09-29 10:46:42', '2013-01-28 06:55:30', '2014-10-08 11:44:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (299, 468, 27, 14, '2013-09-12 08:34:20', '2013-03-30 20:22:24', '2015-10-20 08:22:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 197, 20, 58, '2013-12-14 10:21:01', '2013-03-01 14:36:53', '2015-07-24 17:24:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (270, 393, 30, 11, '2013-09-09 13:24:52', '2013-04-18 16:37:56', '2015-02-10 14:05:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (396, 712, 9, 93, '2013-05-24 15:15:00', '2013-01-15 16:30:45', '2015-07-12 07:59:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (289, 981, 29, 96, '2013-12-31 20:08:39', '2013-05-29 21:09:49', '2014-09-21 09:05:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (672, 342, 17, 88, '2013-02-03 22:00:05', '2013-01-05 04:45:37', '2016-02-04 03:10:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (355, 760, 36, 22, '2013-07-14 18:28:21', '2013-05-22 05:50:50', '2016-02-21 00:20:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (814, 453, 6, 48, '2013-09-02 00:48:59', '2013-04-30 06:14:26', '2015-10-19 17:33:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (331, 627, 17, 71, '2013-07-10 23:57:01', '2013-05-08 13:54:15', '2014-10-23 10:57:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (859, 155, 30, 29, '2013-01-29 12:47:04', '2013-05-27 04:52:24', '2015-11-03 23:44:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (320, 336, 39, 80, '2013-11-25 11:15:37', '2013-05-19 10:04:56', '2014-04-18 07:13:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (372, 882, 8, 51, '2013-03-18 21:27:15', '2013-01-16 11:26:25', '2014-10-26 10:13:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (541, 674, 30, 61, '2013-09-14 17:44:51', '2013-01-06 08:13:17', '2014-12-15 15:59:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (816, 935, 16, 15, '2013-07-01 15:40:49', '2013-02-04 23:15:18', '2014-09-28 07:39:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (568, 299, 37, 9, '2013-05-07 19:17:58', '2013-05-09 18:13:34', '2015-07-28 01:24:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (512, 318, 36, 12, '2013-08-10 14:57:13', '2013-03-23 01:35:01', '2014-09-28 14:24:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (618, 435, 13, 83, '2013-01-09 01:00:31', '2013-01-11 08:28:44', '2014-06-19 11:21:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 895, 39, 89, '2013-06-25 08:27:01', '2013-03-26 04:53:26', '2016-05-04 19:38:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (790, 313, 37, 9, '2013-02-10 17:29:35', '2013-01-31 01:05:10', '2014-09-22 08:31:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (327, 450, 36, 35, '2013-10-30 02:40:41', '2013-01-07 12:25:01', '2015-05-13 04:11:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (379, 596, 14, 58, '2013-07-23 21:28:42', '2013-04-17 22:49:29', '2016-05-28 10:25:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (656, 175, 16, 76, '2013-12-29 17:28:14', '2013-05-13 21:16:10', '2015-10-01 20:18:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 106, 33, 36, '2013-12-29 08:16:27', '2013-05-15 10:10:19', '2015-12-25 07:32:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (310, 13, 8, 94, '2013-03-16 08:06:30', '2013-02-19 17:46:55', '2015-10-28 16:16:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (4, 499, 32, 66, '2013-10-24 08:21:37', '2013-05-07 10:32:08', '2014-06-11 01:47:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (612, 179, 34, 61, '2013-05-23 00:51:25', '2013-02-12 09:06:56', '2015-10-20 07:19:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (527, 556, 4, 58, '2013-07-29 14:48:33', '2013-01-17 15:50:49', '2015-07-06 07:09:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (432, 231, 28, 84, '2013-06-10 06:32:02', '2013-03-04 17:18:26', '2015-12-05 03:18:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (119, 462, 37, 30, '2013-10-15 04:30:43', '2013-02-15 00:44:41', '2015-11-15 23:23:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (904, 824, 24, 58, '2013-06-02 15:15:06', '2013-05-18 11:45:42', '2015-09-20 16:45:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (850, 335, 5, 23, '2013-06-11 13:20:44', '2013-01-26 09:57:22', '2015-12-29 18:16:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (465, 819, 27, 32, '2013-02-13 02:09:31', '2013-05-21 22:19:02', '2016-03-18 09:10:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (725, 461, 37, 45, '2013-02-03 09:43:17', '2013-03-02 10:35:54', '2014-08-10 12:08:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (505, 363, 33, 47, '2013-12-12 15:52:01', '2013-05-20 23:26:49', '2015-04-18 22:16:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (885, 899, 26, 99, '2013-03-07 05:42:38', '2013-03-25 19:11:02', '2014-06-06 08:04:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (574, 565, 24, 2, '2013-04-25 19:43:59', '2013-02-02 21:51:11', '2014-05-09 23:59:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (949, 588, 26, 50, '2013-05-29 09:29:26', '2013-04-19 18:38:07', '2014-05-18 16:59:09');

insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (187, 92, 32, 46, '2014-05-11 13:43:41', '2014-03-14 17:11:58', '2016-05-12 15:59:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (486, 744, 15, 23, '2014-03-09 10:22:21', '2014-04-19 17:18:59', '2016-11-05 14:24:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (360, 898, 38, 15, '2014-07-25 12:55:56', '2014-03-25 22:21:57', '2015-08-22 05:15:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (160, 266, 28, 94, '2014-08-04 11:41:03', '2014-05-09 05:53:50', '2016-04-25 22:58:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (263, 250, 37, 4, '2014-12-23 20:35:31', '2014-03-24 02:54:56', '2016-02-04 00:26:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (424, 959, 40, 64, '2014-11-28 12:18:14', '2014-03-08 13:23:35', '2017-05-28 16:40:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (509, 991, 35, 47, '2014-11-07 22:13:48', '2014-01-15 05:18:20', '2015-08-20 16:30:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (224, 41, 27, 60, '2014-11-28 09:43:51', '2014-04-11 12:17:42', '2015-11-17 13:21:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (668, 338, 35, 31, '2014-01-24 01:05:14', '2014-02-06 09:04:16', '2016-11-14 04:19:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (462, 565, 18, 79, '2014-11-15 20:21:10', '2014-01-13 06:38:48', '2015-06-11 10:52:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (581, 226, 25, 93, '2014-08-29 12:56:29', '2014-04-27 15:05:22', '2017-01-22 20:59:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (612, 529, 26, 16, '2014-03-25 18:55:38', '2014-04-24 18:07:44', '2016-10-08 02:53:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (110, 743, 36, 10, '2014-05-12 14:39:53', '2014-04-12 04:38:38', '2015-09-13 12:04:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (624, 984, 16, 90, '2014-06-16 01:57:21', '2014-02-06 21:26:53', '2015-09-27 19:56:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (718, 353, 37, 5, '2014-07-02 07:16:05', '2014-05-10 10:13:22', '2016-04-27 13:35:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (226, 846, 10, 41, '2014-12-26 09:05:24', '2014-05-01 10:19:03', '2016-03-21 20:06:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (289, 41, 3, 42, '2014-04-26 06:42:52', '2014-04-13 13:25:24', '2015-12-25 16:38:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (341, 65, 2, 1, '2014-05-08 19:05:57', '2014-02-27 09:49:11', '2017-03-30 16:32:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (563, 825, 18, 81, '2014-05-15 05:01:34', '2014-02-23 08:44:59', '2016-10-20 17:05:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (543, 813, 29, 57, '2014-11-03 17:32:08', '2014-02-18 07:26:58', '2015-12-15 20:26:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (771, 328, 6, 79, '2014-11-10 06:13:33', '2014-02-19 19:34:56', '2015-08-19 18:01:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (651, 912, 30, 8, '2014-04-27 21:31:09', '2014-04-24 18:17:50', '2015-05-10 06:48:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (802, 69, 28, 60, '2014-02-07 01:51:31', '2014-05-14 01:16:33', '2016-06-03 23:53:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (683, 450, 20, 85, '2014-01-07 08:57:35', '2014-05-04 10:38:47', '2015-12-26 19:00:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 328, 23, 66, '2014-11-21 07:02:59', '2014-03-08 05:38:07', '2015-04-11 20:28:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (308, 545, 29, 38, '2014-07-29 14:10:48', '2014-02-23 07:05:36', '2015-05-10 04:10:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (366, 686, 16, 81, '2014-06-05 10:43:09', '2014-05-01 16:26:44', '2017-03-30 04:59:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (441, 915, 38, 86, '2014-12-03 02:56:23', '2014-05-03 23:23:22', '2016-08-24 12:12:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (442, 485, 39, 73, '2014-06-29 16:10:20', '2014-03-17 08:28:43', '2015-04-30 14:10:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (653, 782, 40, 43, '2014-03-21 11:42:08', '2014-02-10 18:28:10', '2015-11-27 14:53:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (800, 64, 8, 86, '2014-10-23 03:35:16', '2014-01-04 23:06:05', '2017-05-27 18:25:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (993, 303, 15, 62, '2014-10-09 19:25:11', '2014-02-27 22:06:36', '2015-08-30 07:49:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (94, 744, 23, 4, '2014-12-25 14:53:55', '2014-02-21 14:48:43', '2016-05-10 05:21:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 128, 17, 49, '2014-10-20 05:39:21', '2014-01-29 13:56:15', '2015-03-18 04:55:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (706, 896, 3, 25, '2014-09-19 19:22:11', '2014-03-03 13:02:53', '2017-02-15 10:17:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (178, 977, 11, 73, '2014-08-23 12:49:33', '2014-02-25 14:32:19', '2016-09-08 06:53:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (9, 190, 21, 95, '2014-01-13 08:21:21', '2014-03-09 08:35:53', '2016-06-03 01:43:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (392, 925, 3, 65, '2014-11-23 14:06:14', '2014-02-03 03:12:19', '2015-03-06 09:52:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (683, 228, 40, 55, '2014-08-05 12:08:24', '2014-05-12 12:40:28', '2017-03-06 12:21:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (566, 999, 4, 48, '2014-09-23 23:59:07', '2014-01-27 23:01:53', '2015-11-15 15:26:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (281, 412, 30, 66, '2014-05-07 00:58:55', '2014-02-06 10:36:56', '2015-06-15 03:41:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (856, 534, 15, 46, '2014-08-01 04:59:00', '2014-05-13 05:25:56', '2017-03-05 04:03:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (225, 499, 12, 43, '2014-02-02 18:52:01', '2014-02-02 13:11:14', '2015-04-14 17:22:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (137, 477, 33, 35, '2014-02-16 21:17:08', '2014-04-06 03:21:27', '2016-07-10 13:29:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (73, 841, 7, 54, '2014-06-07 07:32:39', '2014-03-10 09:12:34', '2015-09-26 16:57:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (126, 231, 9, 9, '2014-02-01 15:39:49', '2014-04-18 14:52:41', '2016-07-22 18:13:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (13, 223, 31, 53, '2014-11-21 07:22:30', '2014-02-16 18:56:39', '2016-03-26 08:35:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (600, 847, 35, 22, '2014-08-04 15:47:48', '2014-01-03 14:40:21', '2016-02-23 21:07:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (981, 893, 25, 56, '2014-08-27 02:44:19', '2014-03-02 13:36:14', '2015-06-13 04:12:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (394, 76, 25, 39, '2014-11-21 20:28:24', '2014-03-09 22:25:04', '2015-02-16 18:10:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (292, 166, 2, 60, '2014-12-30 03:31:54', '2014-04-30 21:01:42', '2016-12-05 18:41:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (814, 342, 4, 78, '2014-06-08 21:45:20', '2014-05-05 06:53:25', '2016-05-31 16:13:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (987, 593, 14, 34, '2014-03-08 12:42:05', '2014-04-09 11:05:27', '2016-01-18 13:50:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (251, 3, 1, 92, '2014-06-26 00:49:09', '2014-01-17 07:52:17', '2017-03-08 01:38:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (580, 257, 29, 21, '2014-11-14 07:00:11', '2014-04-16 06:08:55', '2016-11-13 06:27:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (124, 824, 38, 100, '2014-02-21 22:11:48', '2014-03-13 01:38:38', '2015-10-06 05:19:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (183, 741, 36, 67, '2014-06-21 18:31:39', '2014-04-30 17:10:40', '2017-03-09 07:49:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (862, 908, 3, 66, '2014-10-14 11:06:13', '2014-02-02 14:01:10', '2016-01-14 08:19:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (347, 502, 2, 8, '2014-06-18 02:44:31', '2014-04-30 17:39:42', '2016-01-13 05:41:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (861, 157, 27, 96, '2014-05-15 04:48:54', '2014-01-14 09:40:09', '2016-03-24 21:27:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (60, 992, 10, 52, '2014-06-01 02:20:22', '2014-01-19 05:56:09', '2015-06-26 20:27:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (380, 63, 38, 81, '2014-03-09 10:37:20', '2014-05-07 17:12:57', '2017-06-07 05:52:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (540, 146, 7, 41, '2014-02-26 09:21:56', '2014-05-21 11:29:59', '2017-04-13 09:16:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (525, 700, 30, 49, '2014-07-31 05:14:57', '2014-05-30 01:24:16', '2015-05-10 21:04:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (95, 358, 7, 38, '2014-12-10 02:43:11', '2014-03-06 10:43:00', '2017-01-28 05:50:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (263, 722, 16, 35, '2014-06-02 08:16:56', '2014-02-21 15:34:02', '2016-12-26 07:43:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (665, 822, 15, 42, '2014-11-06 22:08:20', '2014-02-20 15:17:05', '2016-01-20 13:42:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (984, 502, 31, 25, '2014-11-22 09:26:24', '2014-05-26 12:21:36', '2016-02-01 09:35:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (620, 377, 9, 67, '2014-04-10 22:00:33', '2014-01-18 07:34:49', '2016-11-13 17:46:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (439, 964, 5, 28, '2014-02-03 20:32:31', '2014-05-29 23:30:53', '2016-12-20 19:37:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (988, 319, 15, 75, '2014-09-18 21:12:13', '2014-01-29 18:51:40', '2017-02-18 22:40:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (188, 554, 38, 64, '2014-11-22 00:37:20', '2014-01-06 22:24:58', '2015-08-19 13:54:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (28, 173, 7, 31, '2014-06-18 06:23:38', '2014-03-21 16:48:32', '2015-04-26 17:01:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (166, 160, 26, 91, '2014-02-03 03:39:35', '2014-02-18 22:32:13', '2016-05-22 04:30:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (149, 334, 36, 77, '2014-08-11 07:56:47', '2014-01-14 15:57:50', '2015-04-24 19:01:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (767, 874, 8, 44, '2014-03-06 16:42:14', '2014-05-18 23:19:44', '2017-05-04 14:01:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (621, 469, 10, 75, '2014-01-14 20:44:31', '2014-05-22 12:02:50', '2015-12-21 08:28:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (429, 677, 5, 43, '2014-03-31 16:47:54', '2014-05-14 22:46:31', '2016-10-15 00:50:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (950, 417, 23, 28, '2014-11-23 20:50:45', '2014-02-08 23:32:57', '2016-04-01 13:57:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (203, 628, 11, 7, '2014-06-22 05:35:12', '2014-05-31 01:57:24', '2016-05-15 07:02:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (128, 999, 9, 60, '2014-12-02 02:26:10', '2014-02-03 08:03:22', '2017-03-27 00:25:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (382, 955, 33, 12, '2014-08-31 23:32:07', '2014-05-03 08:05:50', '2015-09-08 16:45:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (668, 870, 4, 70, '2014-05-19 07:42:57', '2014-03-30 11:01:53', '2016-12-14 04:58:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (273, 177, 3, 6, '2014-08-04 02:55:30', '2014-02-04 19:07:32', '2015-03-30 03:05:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (869, 629, 30, 22, '2014-11-19 03:37:34', '2014-04-11 00:12:09', '2017-05-05 03:32:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (185, 569, 20, 19, '2014-06-08 08:14:29', '2014-04-19 22:46:26', '2017-05-05 17:39:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (987, 52, 23, 36, '2014-01-04 23:34:50', '2014-03-14 13:32:27', '2016-07-28 07:00:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (969, 879, 21, 87, '2014-07-16 02:53:23', '2014-04-11 14:50:40', '2017-02-22 19:58:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (711, 572, 27, 63, '2014-11-17 04:51:13', '2014-03-20 22:57:42', '2016-01-03 21:22:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (636, 631, 7, 65, '2014-09-13 18:48:40', '2014-01-03 05:21:32', '2015-02-11 01:29:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (63, 29, 4, 41, '2014-04-03 01:16:19', '2014-02-03 01:31:08', '2016-06-08 03:52:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (854, 419, 17, 71, '2014-08-30 23:38:38', '2014-02-26 16:04:36', '2015-03-17 22:39:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (869, 678, 40, 1, '2014-03-26 04:40:40', '2014-01-06 01:39:20', '2015-11-28 23:06:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (710, 976, 13, 43, '2014-02-16 14:45:33', '2014-04-03 07:19:49', '2016-10-24 12:14:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (769, 773, 17, 67, '2014-10-12 04:25:02', '2014-01-23 06:12:44', '2017-04-03 20:21:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (344, 126, 11, 42, '2014-03-27 11:53:50', '2014-03-17 01:51:35', '2015-04-11 09:29:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (694, 893, 15, 76, '2014-03-02 17:23:42', '2014-02-15 17:45:02', '2015-02-28 14:57:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (191, 669, 17, 53, '2014-01-29 04:34:12', '2014-03-15 03:52:24', '2016-02-27 02:24:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (265, 673, 25, 73, '2014-12-03 12:56:39', '2014-04-24 14:14:55', '2015-06-09 16:28:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (951, 166, 32, 67, '2014-05-29 16:55:32', '2014-02-17 05:28:34', '2017-05-18 17:54:31');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (791, 424, 32, 78, '2015-05-03 22:02:50', '2015-04-15 14:00:01', '2016-04-26 17:44:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (497, 942, 31, 91, '2015-05-01 01:47:09', '2015-02-19 04:55:46', '2016-06-25 00:32:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (367, 757, 27, 20, '2015-08-03 06:14:55', '2015-05-16 00:06:19', '2017-10-01 09:30:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (172, 872, 1, 61, '2015-01-02 11:55:52', '2015-04-27 14:42:05', '2016-08-03 06:06:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (964, 417, 5, 14, '2015-07-03 03:04:25', '2015-04-12 07:44:59', '2017-08-09 22:55:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (491, 192, 20, 46, '2015-08-19 22:57:29', '2015-04-22 23:17:30', '2018-02-22 10:29:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (190, 737, 23, 93, '2015-06-24 01:43:55', '2015-05-15 16:26:30', '2016-11-10 23:39:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (498, 847, 21, 80, '2015-03-05 19:33:39', '2015-03-31 17:55:47', '2016-12-19 19:56:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 260, 30, 21, '2015-11-15 05:09:02', '2015-03-14 11:29:16', '2017-11-29 00:09:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (2, 290, 8, 95, '2015-05-22 05:43:26', '2015-01-17 12:51:10', '2017-10-15 02:48:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (621, 140, 22, 53, '2015-02-12 13:02:27', '2015-05-15 04:14:03', '2018-04-10 03:18:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (265, 872, 7, 30, '2015-06-29 13:04:01', '2015-01-07 08:25:19', '2017-11-05 01:50:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (595, 145, 6, 58, '2015-07-21 05:47:41', '2015-05-17 01:44:26', '2016-12-02 12:57:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (900, 520, 27, 25, '2015-01-07 12:32:44', '2015-02-01 07:02:16', '2016-04-29 11:51:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (102, 355, 23, 17, '2015-03-28 02:56:35', '2015-01-02 20:24:18', '2017-12-04 04:12:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (148, 9, 16, 98, '2015-02-06 05:22:39', '2015-02-10 13:32:16', '2016-05-05 04:20:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (596, 153, 14, 85, '2015-04-16 01:53:52', '2015-01-07 07:41:39', '2017-06-17 09:44:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (244, 759, 17, 96, '2015-01-16 02:38:31', '2015-05-11 13:04:12', '2017-04-20 15:06:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (479, 694, 38, 14, '2015-06-27 23:14:44', '2015-02-17 10:50:23', '2016-05-20 08:04:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (700, 740, 36, 37, '2015-08-11 23:09:01', '2015-01-09 07:55:33', '2017-11-23 22:51:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (48, 510, 8, 74, '2015-06-10 06:07:47', '2015-04-06 23:04:54', '2016-03-01 20:39:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (554, 913, 28, 83, '2015-01-25 02:28:26', '2015-01-11 20:05:03', '2018-06-11 13:09:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (238, 451, 21, 56, '2015-07-31 19:39:01', '2015-03-02 15:01:50', '2016-05-17 22:58:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (173, 149, 9, 1, '2015-12-19 16:59:34', '2015-03-23 16:14:19', '2017-11-11 20:13:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 236, 19, 51, '2015-07-02 08:25:03', '2015-03-23 23:43:50', '2016-08-20 02:15:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (330, 31, 37, 55, '2015-11-27 03:28:13', '2015-03-24 06:13:42', '2016-09-19 16:02:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (350, 238, 32, 43, '2015-12-04 04:39:43', '2015-02-08 12:04:38', '2017-10-30 18:37:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (238, 606, 24, 63, '2015-07-09 19:34:57', '2015-04-16 23:39:05', '2017-05-16 13:19:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (420, 628, 10, 8, '2015-06-13 07:40:24', '2015-03-31 03:56:29', '2017-02-12 15:16:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (179, 966, 20, 86, '2015-11-10 01:06:46', '2015-02-26 08:12:56', '2017-02-03 01:48:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (951, 343, 25, 64, '2015-05-02 07:30:41', '2015-02-14 02:46:45', '2017-06-23 15:31:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (208, 161, 25, 73, '2015-12-10 14:12:31', '2015-04-01 17:36:42', '2017-05-15 18:08:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (101, 780, 26, 15, '2015-12-07 05:46:53', '2015-05-04 19:04:46', '2016-12-05 19:31:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (585, 379, 31, 59, '2015-04-04 11:44:43', '2015-01-20 06:45:14', '2017-01-04 07:04:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (187, 264, 7, 97, '2015-01-16 04:04:02', '2015-05-14 20:02:48', '2018-05-01 12:38:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (33, 748, 37, 51, '2015-07-20 15:42:52', '2015-05-13 12:08:33', '2017-10-21 21:31:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (352, 409, 30, 100, '2015-04-16 04:14:51', '2015-05-16 12:48:59', '2017-08-10 13:00:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (206, 507, 21, 73, '2015-12-01 20:29:29', '2015-04-23 08:43:29', '2016-11-21 00:47:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (264, 440, 20, 15, '2015-09-16 21:55:54', '2015-03-07 19:20:24', '2016-11-29 13:21:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (136, 823, 5, 25, '2015-10-27 22:28:37', '2015-01-30 06:13:59', '2016-09-09 00:41:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (555, 26, 10, 91, '2015-12-03 02:24:31', '2015-04-03 13:18:22', '2017-09-03 21:00:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (97, 482, 37, 29, '2015-05-23 21:27:33', '2015-02-16 06:27:18', '2016-09-10 12:45:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (93, 563, 11, 66, '2015-10-21 13:52:25', '2015-01-13 12:41:01', '2017-09-24 07:43:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (764, 269, 20, 17, '2015-03-08 00:20:28', '2015-01-05 03:20:48', '2018-05-29 16:12:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (958, 986, 14, 100, '2015-07-04 06:07:47', '2015-01-08 21:25:48', '2017-06-02 08:08:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (915, 109, 6, 84, '2015-11-04 18:11:32', '2015-01-21 11:19:40', '2018-01-08 03:51:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (662, 81, 32, 65, '2015-10-06 11:58:02', '2015-01-17 07:27:44', '2018-02-03 06:49:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (837, 218, 36, 4, '2015-04-09 13:03:27', '2015-05-29 02:26:00', '2017-10-17 02:08:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (268, 83, 40, 24, '2015-07-16 10:18:03', '2015-04-12 21:04:01', '2016-11-23 13:46:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (401, 659, 35, 91, '2015-10-02 19:32:58', '2015-03-31 16:09:07', '2017-11-04 14:12:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (724, 306, 19, 63, '2015-12-13 19:48:24', '2015-02-09 04:38:12', '2016-10-16 18:00:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (613, 732, 23, 37, '2015-06-22 05:05:25', '2015-02-04 22:45:13', '2016-06-08 15:28:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (886, 994, 17, 53, '2015-04-24 14:54:17', '2015-04-21 14:04:10', '2017-08-11 16:32:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (231, 216, 26, 53, '2015-03-25 00:27:27', '2015-05-23 17:58:08', '2018-01-29 04:19:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (528, 778, 4, 14, '2015-12-12 03:53:04', '2015-05-28 14:21:27', '2016-09-02 22:26:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (50, 961, 38, 90, '2015-07-24 12:12:25', '2015-02-20 12:08:32', '2018-03-09 23:36:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (644, 388, 27, 77, '2015-07-11 16:26:36', '2015-02-06 08:54:30', '2016-04-30 05:28:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (210, 398, 6, 45, '2015-06-01 12:54:21', '2015-03-19 21:59:50', '2016-03-20 08:25:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (739, 961, 39, 58, '2015-03-13 10:27:36', '2015-01-05 11:39:12', '2016-06-20 03:47:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (820, 110, 18, 20, '2015-04-09 21:03:17', '2015-05-09 01:23:02', '2017-12-14 18:52:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (860, 447, 12, 94, '2015-09-15 03:53:48', '2015-03-19 09:55:34', '2016-08-23 22:29:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (595, 60, 12, 46, '2015-03-04 04:22:50', '2015-04-17 00:48:58', '2016-07-05 17:47:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (616, 432, 22, 13, '2015-12-04 04:27:15', '2015-01-24 13:41:24', '2018-01-03 07:53:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (826, 522, 13, 22, '2015-07-19 19:16:08', '2015-04-07 19:50:49', '2018-03-26 19:36:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (395, 756, 16, 40, '2015-05-29 17:33:17', '2015-04-18 04:36:24', '2016-09-08 09:25:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 332, 10, 1, '2015-11-27 17:51:47', '2015-05-27 15:16:15', '2016-03-07 20:33:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (367, 594, 24, 38, '2015-04-27 22:11:46', '2015-04-26 00:36:31', '2016-04-28 01:23:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (999, 196, 19, 2, '2015-05-12 04:23:28', '2015-01-31 07:47:03', '2018-05-17 13:14:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (818, 536, 14, 79, '2015-12-23 04:08:37', '2015-03-04 14:39:24', '2017-01-25 16:14:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (614, 839, 20, 51, '2015-07-19 20:29:44', '2015-05-17 12:19:18', '2016-05-03 09:13:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (625, 934, 10, 68, '2015-06-28 13:54:23', '2015-05-23 21:52:26', '2017-01-19 00:41:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (308, 77, 33, 26, '2015-10-19 05:00:47', '2015-03-05 05:05:29', '2016-05-31 08:39:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 6, 21, 59, '2015-12-30 18:49:24', '2015-04-07 18:11:08', '2016-11-04 01:09:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (597, 373, 11, 78, '2015-05-10 11:21:01', '2015-04-07 01:19:08', '2016-12-06 06:59:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (328, 2, 25, 11, '2015-04-10 07:02:11', '2015-03-21 04:45:53', '2017-08-15 00:57:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (235, 17, 21, 91, '2015-08-11 13:14:32', '2015-02-03 03:10:17', '2017-05-21 14:13:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (836, 673, 30, 52, '2015-11-14 02:25:25', '2015-04-08 06:12:41', '2016-07-27 07:03:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (638, 462, 22, 33, '2015-09-18 15:32:17', '2015-04-28 19:34:53', '2017-01-18 00:44:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (339, 176, 28, 94, '2015-04-23 08:56:37', '2015-01-23 05:48:10', '2016-08-23 16:19:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (130, 202, 3, 29, '2015-08-01 11:00:59', '2015-01-01 19:08:53', '2018-04-06 05:40:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (864, 159, 24, 88, '2015-05-04 03:35:44', '2015-03-06 02:13:21', '2017-04-23 03:47:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (576, 553, 27, 66, '2015-02-14 12:12:01', '2015-04-21 21:08:18', '2016-03-27 23:41:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (339, 214, 14, 63, '2015-12-23 14:15:34', '2015-03-25 08:40:20', '2017-01-25 17:14:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 464, 29, 95, '2015-01-20 12:55:13', '2015-05-20 21:40:08', '2018-02-28 13:01:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (463, 108, 3, 55, '2015-01-22 04:45:32', '2015-05-05 02:38:16', '2017-10-20 16:01:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (142, 519, 1, 11, '2015-09-19 22:42:19', '2015-05-05 05:06:18', '2016-07-12 03:41:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (986, 783, 35, 39, '2015-05-29 08:24:50', '2015-04-20 22:13:09', '2017-10-28 06:30:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (31, 970, 18, 67, '2015-12-22 12:50:55', '2015-03-08 07:45:36', '2016-10-16 08:13:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (541, 347, 16, 62, '2015-06-19 06:42:20', '2015-04-15 20:08:07', '2016-10-10 22:11:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (613, 514, 33, 75, '2015-12-16 20:56:09', '2015-02-24 19:17:43', '2017-04-19 12:15:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (77, 353, 8, 85, '2015-12-17 08:52:36', '2015-04-05 09:56:11', '2017-01-26 23:02:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (323, 227, 1, 47, '2015-07-14 09:17:54', '2015-03-18 10:05:40', '2016-02-10 17:35:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (127, 94, 1, 8, '2015-06-05 05:13:16', '2015-03-26 04:09:04', '2018-04-01 22:08:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (164, 666, 5, 52, '2015-03-30 11:59:14', '2015-02-06 12:33:26', '2016-10-21 18:13:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (970, 972, 3, 66, '2015-07-20 06:14:32', '2015-01-27 17:38:00', '2018-01-11 02:04:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (501, 273, 19, 80, '2015-04-29 04:22:43', '2015-04-13 06:31:27', '2017-03-06 16:21:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (364, 152, 19, 57, '2015-02-27 15:05:18', '2015-02-25 00:04:46', '2017-01-13 21:10:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (142, 487, 6, 30, '2015-03-23 04:07:10', '2015-01-21 19:55:16', '2016-09-20 07:41:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (949, 8, 33, 38, '2015-06-08 07:23:41', '2015-04-22 12:35:09', '2016-09-10 00:46:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (486, 551, 28, 30, '2015-02-05 09:20:15', '2015-03-14 02:58:54', '2016-07-19 21:47:01');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (465, 292, 40, 42, '2016-01-28 23:52:49', '2016-01-25 17:23:29', '2018-06-12 01:17:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (675, 483, 23, 30, '2016-08-16 06:19:00', '2016-02-22 05:51:48', '2017-11-14 10:42:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (17, 387, 39, 94, '2016-11-23 19:10:23', '2016-02-11 20:46:05', '2019-03-16 14:12:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (31, 241, 6, 43, '2016-01-31 09:23:02', '2016-03-02 22:28:52', '2018-06-27 19:31:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (852, 512, 26, 45, '2016-01-11 23:58:29', '2016-02-27 03:43:28', '2017-05-19 15:28:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (480, 505, 14, 78, '2016-02-28 18:55:35', '2016-02-13 06:13:16', '2017-03-08 10:01:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (729, 889, 14, 49, '2016-05-27 20:46:41', '2016-03-12 09:39:14', '2017-11-15 16:26:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (797, 251, 7, 40, '2016-07-02 22:29:14', '2016-03-23 05:59:54', '2018-11-10 11:10:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (442, 135, 18, 4, '2016-11-15 17:27:32', '2016-04-06 09:52:05', '2017-11-23 17:16:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (285, 956, 23, 95, '2016-12-16 18:48:33', '2016-05-09 03:30:01', '2018-08-10 10:21:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (983, 774, 10, 37, '2016-08-31 17:12:43', '2016-04-14 14:19:26', '2018-12-13 21:23:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (220, 404, 27, 60, '2016-08-13 14:55:03', '2016-01-01 19:47:25', '2017-03-31 17:24:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (566, 26, 13, 18, '2016-03-05 02:41:27', '2016-03-26 15:40:41', '2019-01-06 16:15:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (2, 546, 40, 28, '2016-06-10 23:01:45', '2016-04-18 00:03:51', '2018-11-01 10:12:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (91, 159, 2, 11, '2016-02-26 01:33:54', '2016-01-12 19:55:04', '2017-05-31 06:17:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (568, 251, 40, 53, '2016-10-19 14:04:34', '2016-05-15 08:20:04', '2019-03-27 16:52:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (253, 306, 25, 62, '2016-12-20 07:35:24', '2016-05-21 14:39:25', '2017-11-28 12:30:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (67, 612, 13, 62, '2016-11-01 12:17:56', '2016-01-17 12:10:55', '2019-05-25 16:38:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (575, 868, 33, 85, '2016-11-30 10:44:53', '2016-03-26 18:24:48', '2017-02-17 17:35:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (93, 424, 17, 40, '2016-06-28 14:51:14', '2016-04-15 23:11:12', '2018-12-09 05:20:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (88, 524, 32, 14, '2016-08-17 22:37:28', '2016-02-27 09:53:17', '2017-02-27 13:20:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (608, 422, 27, 67, '2016-07-27 10:54:02', '2016-01-09 01:44:20', '2019-04-01 11:54:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (658, 606, 31, 58, '2016-10-21 19:43:52', '2016-02-18 13:30:35', '2019-02-07 06:30:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (547, 485, 4, 56, '2016-12-15 18:19:08', '2016-05-27 18:12:43', '2019-05-20 03:19:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (48, 513, 29, 77, '2016-11-05 15:19:48', '2016-03-06 16:28:24', '2018-07-10 10:02:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (488, 200, 39, 51, '2016-11-12 20:28:03', '2016-02-09 04:55:05', '2017-09-07 01:50:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (549, 729, 27, 60, '2016-03-06 14:09:22', '2016-01-20 19:03:25', '2018-09-08 20:20:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (190, 49, 19, 47, '2016-01-13 13:36:12', '2016-05-02 07:53:11', '2018-05-20 03:57:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (767, 502, 26, 72, '2016-02-17 15:54:28', '2016-02-21 18:22:23', '2017-03-08 14:28:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (685, 756, 21, 90, '2016-12-27 11:27:01', '2016-03-29 08:11:03', '2018-07-31 11:56:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (553, 448, 31, 92, '2016-08-18 10:56:58', '2016-02-21 04:06:10', '2017-11-05 04:38:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (721, 512, 37, 4, '2016-08-22 20:34:56', '2016-03-11 21:42:12', '2017-11-05 23:32:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (735, 8, 15, 28, '2016-08-22 09:41:34', '2016-03-31 10:38:32', '2017-11-29 07:09:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (456, 854, 37, 63, '2016-12-29 13:01:59', '2016-05-19 05:19:12', '2017-08-20 23:35:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (525, 118, 33, 17, '2016-02-20 05:59:44', '2016-02-07 13:55:48', '2017-03-25 19:46:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (823, 122, 27, 83, '2016-05-31 08:56:07', '2016-04-30 00:48:36', '2018-12-28 15:33:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (898, 2, 24, 89, '2016-06-03 17:15:10', '2016-03-31 19:31:42', '2019-01-11 16:09:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (632, 45, 30, 66, '2016-05-15 04:02:46', '2016-05-18 11:55:43', '2017-08-15 13:14:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (650, 950, 10, 3, '2016-12-01 03:59:52', '2016-01-17 05:02:00', '2019-01-19 17:50:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (920, 373, 28, 35, '2016-03-05 22:06:24', '2016-02-19 02:05:03', '2018-06-02 23:26:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (36, 867, 13, 89, '2016-06-21 10:05:45', '2016-02-25 17:06:31', '2019-04-11 18:25:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (169, 985, 1, 3, '2016-10-30 13:46:02', '2016-02-11 09:41:08', '2017-04-20 14:08:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (101, 494, 31, 25, '2016-02-11 21:38:18', '2016-02-15 23:18:16', '2017-05-28 11:51:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (232, 164, 16, 26, '2016-03-09 06:55:17', '2016-05-01 04:19:30', '2018-03-26 12:40:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (653, 409, 14, 96, '2016-11-04 15:44:40', '2016-05-28 14:38:32', '2019-02-14 10:32:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (340, 364, 33, 71, '2016-01-21 20:02:29', '2016-05-14 15:16:46', '2017-09-15 02:35:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (629, 510, 8, 79, '2016-08-08 14:42:38', '2016-01-12 13:29:22', '2017-04-23 14:00:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (972, 200, 11, 98, '2016-05-11 23:19:56', '2016-02-25 20:51:57', '2018-05-20 11:04:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (167, 293, 2, 40, '2016-05-30 05:55:55', '2016-03-20 11:14:26', '2018-03-08 14:42:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (601, 95, 38, 34, '2016-06-21 19:51:04', '2016-03-27 10:31:08', '2017-09-25 22:19:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 488, 23, 18, '2016-11-20 03:28:34', '2016-04-01 00:41:45', '2019-01-30 17:19:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 823, 9, 6, '2016-04-30 03:41:21', '2016-05-16 14:51:01', '2017-07-18 13:54:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (444, 598, 1, 64, '2016-08-03 17:42:28', '2016-02-09 20:09:50', '2017-06-30 10:12:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (632, 670, 3, 65, '2016-11-03 14:40:29', '2016-04-21 17:18:40', '2017-04-23 19:09:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (635, 182, 34, 7, '2016-07-25 15:39:24', '2016-03-18 12:58:13', '2019-02-23 19:37:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (838, 450, 30, 22, '2016-01-17 17:04:59', '2016-01-16 15:38:42', '2018-07-01 13:56:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (418, 355, 11, 25, '2016-01-26 02:56:51', '2016-03-31 22:18:27', '2017-09-02 00:20:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (315, 774, 12, 36, '2016-05-01 00:25:16', '2016-05-25 18:33:22', '2018-04-21 14:07:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (106, 48, 19, 27, '2016-08-15 06:31:56', '2016-04-23 05:28:18', '2018-12-23 08:55:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (740, 92, 34, 77, '2016-11-04 19:23:09', '2016-02-23 07:47:18', '2017-09-11 18:27:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (664, 166, 39, 75, '2016-12-15 19:30:21', '2016-02-15 07:59:12', '2018-12-04 21:50:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (923, 504, 31, 70, '2016-05-11 03:29:06', '2016-04-18 00:38:59', '2018-09-24 11:13:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (635, 198, 15, 70, '2016-02-14 02:18:47', '2016-01-14 06:25:10', '2017-12-30 06:06:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (303, 27, 36, 68, '2016-04-22 23:47:23', '2016-01-04 02:54:48', '2019-01-08 19:20:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (195, 886, 21, 53, '2016-08-08 10:15:06', '2016-03-06 04:11:13', '2017-04-29 11:44:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (690, 289, 39, 78, '2016-05-15 04:44:45', '2016-04-29 21:10:27', '2018-03-12 23:03:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (25, 681, 22, 59, '2016-05-26 11:33:05', '2016-02-11 08:25:35', '2019-03-31 23:28:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (116, 88, 33, 62, '2016-11-09 05:43:51', '2016-05-23 23:00:45', '2018-02-01 06:55:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (855, 479, 37, 99, '2016-02-06 00:08:50', '2016-04-24 02:45:21', '2017-03-14 01:30:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (7, 437, 15, 78, '2016-08-12 11:18:39', '2016-02-18 16:50:56', '2019-04-03 20:48:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (52, 669, 15, 46, '2016-12-05 20:19:11', '2016-01-17 23:54:50', '2018-02-28 12:46:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (275, 632, 36, 27, '2016-07-21 02:02:12', '2016-02-29 03:58:37', '2019-05-01 12:10:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (245, 172, 32, 41, '2016-01-12 20:23:24', '2016-02-23 07:43:10', '2019-02-23 06:14:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (27, 473, 26, 43, '2016-12-24 03:45:17', '2016-03-25 12:18:01', '2018-03-07 00:46:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (17, 86, 26, 40, '2016-08-08 19:49:53', '2016-03-13 08:04:22', '2019-01-06 23:40:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (809, 666, 28, 57, '2016-02-05 02:36:21', '2016-05-20 04:11:20', '2018-09-24 04:23:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (325, 160, 37, 57, '2016-05-03 05:46:07', '2016-01-17 06:18:05', '2018-07-28 10:22:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (147, 694, 31, 98, '2016-02-10 17:41:15', '2016-02-11 14:51:54', '2019-02-21 21:08:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (661, 924, 8, 55, '2016-01-17 10:54:48', '2016-05-13 10:02:57', '2018-01-20 12:24:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (507, 862, 35, 94, '2016-02-03 15:29:57', '2016-01-17 11:16:52', '2019-02-17 00:52:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (637, 447, 36, 54, '2016-06-28 16:49:50', '2016-01-29 23:41:05', '2017-02-25 22:54:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (596, 445, 33, 79, '2016-08-15 08:58:35', '2016-02-29 22:48:14', '2017-05-17 09:38:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (435, 390, 34, 61, '2016-04-18 05:14:04', '2016-02-19 19:07:33', '2018-09-25 02:06:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (49, 548, 10, 69, '2016-03-22 01:12:41', '2016-03-08 13:06:21', '2017-05-02 14:37:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (61, 26, 37, 71, '2016-05-12 13:32:29', '2016-03-19 19:52:44', '2018-09-25 04:20:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (902, 12, 39, 9, '2016-09-15 04:57:23', '2016-01-18 23:43:06', '2017-08-05 15:11:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (802, 495, 2, 43, '2016-06-25 08:25:11', '2016-03-17 01:44:10', '2018-06-22 15:39:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (308, 23, 6, 58, '2016-03-22 10:19:15', '2016-03-07 03:39:47', '2018-04-12 07:25:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (801, 293, 33, 33, '2016-11-02 22:31:55', '2016-01-26 08:47:57', '2018-04-21 06:01:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (574, 528, 14, 80, '2016-01-03 16:36:51', '2016-03-18 05:52:48', '2017-12-22 16:11:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (830, 401, 14, 54, '2016-10-13 02:29:52', '2016-02-24 20:55:22', '2017-08-29 07:18:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (233, 205, 1, 95, '2016-02-18 18:21:00', '2016-05-18 03:05:52', '2019-04-25 06:22:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (887, 311, 9, 25, '2016-09-22 23:59:08', '2016-01-31 19:30:43', '2017-03-12 05:03:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (694, 960, 39, 5, '2016-08-03 08:57:19', '2016-05-12 20:15:32', '2017-03-08 00:03:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (807, 878, 26, 40, '2016-01-21 10:46:28', '2016-04-20 17:31:13', '2017-06-02 12:41:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (912, 379, 27, 73, '2016-01-08 20:37:31', '2016-04-05 00:40:22', '2018-03-04 17:46:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 857, 10, 84, '2016-01-13 22:23:14', '2016-02-15 08:16:38', '2017-07-22 17:14:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (145, 821, 16, 72, '2016-09-16 02:38:14', '2016-03-04 16:35:08', '2018-07-17 12:37:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (456, 999, 22, 94, '2016-04-28 18:00:04', '2016-01-17 05:13:06', '2017-11-26 18:26:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (521, 517, 3, 7, '2016-07-01 06:01:24', '2016-01-09 23:21:20', '2017-08-16 04:27:47');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (353, 149, 28, 4, '2017-05-18 02:08:06', '2017-05-15 04:44:40', '2019-12-20 04:47:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (837, 248, 25, 35, '2017-06-25 15:26:11', '2017-01-05 07:27:44', '2019-08-27 21:36:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (13, 647, 13, 78, '2017-08-31 18:06:44', '2017-04-26 12:18:54', '2018-06-14 03:17:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (905, 178, 30, 75, '2017-08-15 12:54:24', '2017-03-22 22:19:42', '2019-08-27 09:46:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (357, 6, 2, 97, '2017-12-07 01:37:48', '2017-05-08 15:09:31', '2019-01-29 00:32:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (334, 399, 5, 31, '2017-12-09 14:02:12', '2017-01-21 20:58:11', '2018-09-28 03:47:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (581, 348, 26, 37, '2017-05-12 23:55:58', '2017-01-18 23:07:16', '2019-12-19 08:14:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (200, 582, 17, 17, '2017-06-03 06:25:46', '2017-02-08 11:06:47', '2019-02-08 17:32:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (344, 848, 39, 19, '2017-09-15 08:45:11', '2017-05-06 22:28:07', '2018-07-29 17:11:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (128, 651, 7, 69, '2017-08-25 13:43:54', '2017-03-20 16:17:37', '2019-07-16 02:31:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (604, 324, 25, 79, '2017-03-29 13:16:20', '2017-01-21 16:06:57', '2018-04-29 08:21:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (564, 223, 29, 71, '2017-03-27 15:07:34', '2017-03-20 05:14:01', '2019-09-28 17:58:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (704, 844, 24, 45, '2017-03-28 12:36:50', '2017-01-04 07:53:03', '2019-10-22 13:41:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (2, 848, 22, 26, '2017-01-16 01:46:59', '2017-02-20 13:30:47', '2018-03-02 19:06:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (455, 264, 10, 24, '2017-02-17 20:48:11', '2017-05-28 05:10:02', '2018-02-02 10:16:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (163, 92, 24, 83, '2017-06-11 04:50:57', '2017-04-24 05:07:16', '2018-08-24 16:23:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (33, 574, 20, 21, '2017-01-20 18:48:24', '2017-01-05 19:51:12', '2019-10-15 00:28:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (742, 644, 27, 71, '2017-09-05 17:10:58', '2017-05-09 14:34:05', '2018-05-01 06:53:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (634, 773, 35, 77, '2017-12-04 15:27:27', '2017-01-06 17:48:21', '2019-05-31 08:45:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (943, 563, 4, 67, '2017-10-18 16:52:17', '2017-02-25 15:33:01', '2018-07-14 08:56:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (940, 513, 6, 24, '2017-10-23 10:55:41', '2017-01-09 09:40:02', '2018-10-06 21:06:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (378, 171, 17, 28, '2017-01-07 21:39:19', '2017-02-02 10:50:59', '2019-10-15 21:13:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 854, 17, 24, '2017-04-18 04:25:49', '2017-01-07 03:06:24', '2019-12-22 06:00:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (132, 309, 30, 78, '2017-08-02 10:13:31', '2017-01-22 11:02:14', '2018-09-29 00:03:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (766, 365, 14, 27, '2017-06-04 12:05:06', '2017-02-12 05:10:59', '2018-04-08 22:50:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (976, 601, 36, 47, '2017-11-15 07:57:53', '2017-02-25 09:05:53', '2018-05-19 19:12:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (572, 828, 13, 22, '2017-10-16 02:20:27', '2017-03-13 14:59:25', '2018-10-19 19:54:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (81, 217, 11, 42, '2017-06-22 23:59:44', '2017-04-10 01:46:42', '2018-08-23 05:55:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 273, 2, 66, '2017-11-04 22:45:12', '2017-02-26 15:39:28', '2018-03-17 08:26:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (386, 278, 5, 96, '2017-09-17 22:26:03', '2017-05-30 22:58:47', '2019-12-16 08:55:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (523, 462, 4, 61, '2017-03-05 01:53:55', '2017-03-09 17:24:07', '2020-06-08 15:21:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (620, 17, 18, 35, '2017-09-09 12:54:02', '2017-05-18 11:23:01', '2019-10-06 16:59:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (475, 965, 5, 43, '2017-11-07 02:38:20', '2017-02-28 16:59:43', '2019-10-05 03:43:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 810, 35, 44, '2017-03-14 04:04:48', '2017-04-30 01:42:32', '2018-03-04 08:55:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (773, 891, 29, 79, '2017-02-14 04:03:15', '2017-02-23 15:27:45', '2018-04-07 08:18:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (686, 68, 36, 96, '2017-04-19 21:22:05', '2017-05-09 06:40:28', '2019-05-10 15:27:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (113, 660, 12, 5, '2017-01-15 10:27:31', '2017-05-27 13:40:36', '2018-11-28 03:54:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (738, 632, 25, 46, '2017-01-07 18:54:36', '2017-01-09 19:55:31', '2019-01-07 13:30:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (717, 599, 37, 27, '2017-10-17 09:14:50', '2017-03-20 21:35:43', '2019-04-06 17:46:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (274, 316, 4, 10, '2017-11-11 18:40:58', '2017-04-27 07:10:32', '2019-09-01 02:19:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (121, 457, 14, 35, '2017-05-15 23:11:11', '2017-05-24 17:22:40', '2018-12-02 21:04:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (342, 915, 34, 53, '2017-08-14 16:17:16', '2017-01-27 17:32:22', '2019-12-31 01:08:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (327, 647, 8, 11, '2017-12-15 23:34:36', '2017-01-20 02:11:30', '2018-06-08 08:00:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (241, 885, 35, 4, '2017-04-02 05:45:46', '2017-04-05 09:09:58', '2018-10-05 19:11:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (366, 370, 36, 56, '2017-11-05 15:40:51', '2017-02-18 01:59:43', '2018-03-20 19:20:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (421, 651, 32, 14, '2017-10-07 19:10:38', '2017-05-05 09:17:53', '2019-02-16 13:29:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (12, 955, 16, 55, '2017-08-16 18:41:37', '2017-05-19 05:09:33', '2019-05-10 06:47:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (489, 935, 24, 68, '2017-01-22 12:13:24', '2017-04-20 21:58:41', '2020-02-23 09:27:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (900, 180, 33, 74, '2017-01-05 20:19:16', '2017-05-09 00:31:31', '2019-06-06 07:44:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (874, 199, 37, 42, '2017-10-16 04:58:45', '2017-04-28 06:24:35', '2018-11-13 18:40:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (376, 272, 17, 24, '2017-02-10 23:19:16', '2017-01-31 00:13:25', '2019-08-23 13:19:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (514, 596, 31, 17, '2017-07-03 16:36:47', '2017-05-01 06:46:09', '2018-11-01 07:44:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (441, 948, 9, 45, '2017-03-04 02:02:29', '2017-04-15 18:39:23', '2018-08-25 10:31:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (716, 507, 38, 100, '2017-03-01 15:12:09', '2017-05-02 08:02:39', '2020-03-16 22:24:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (57, 815, 2, 54, '2017-02-18 17:03:32', '2017-01-22 09:23:30', '2019-04-04 16:04:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (532, 632, 17, 68, '2017-06-02 12:57:51', '2017-05-17 08:54:07', '2019-01-07 18:33:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (112, 434, 26, 10, '2017-01-30 14:02:01', '2017-04-24 21:44:15', '2018-08-03 03:53:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (775, 975, 24, 99, '2017-09-12 07:22:26', '2017-04-24 01:28:21', '2019-10-07 22:46:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (996, 989, 31, 69, '2017-01-11 08:21:45', '2017-05-14 23:49:12', '2018-08-24 17:18:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (785, 181, 14, 45, '2017-05-01 09:19:16', '2017-02-15 23:45:42', '2019-10-02 07:41:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (605, 592, 24, 33, '2017-01-10 13:01:38', '2017-04-02 09:26:49', '2019-03-13 23:26:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (354, 996, 38, 18, '2017-12-30 06:16:10', '2017-05-09 04:30:37', '2019-08-14 19:24:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (520, 667, 25, 50, '2017-12-28 14:19:07', '2017-04-03 19:02:02', '2018-06-20 21:13:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (718, 242, 30, 68, '2017-11-09 23:28:22', '2017-01-22 20:50:48', '2019-04-02 16:25:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (616, 481, 10, 9, '2017-04-14 08:08:21', '2017-03-18 03:09:01', '2020-01-26 01:07:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (55, 633, 5, 68, '2017-05-28 21:05:16', '2017-05-16 08:35:54', '2020-03-27 19:26:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (833, 488, 34, 90, '2017-06-10 00:14:42', '2017-01-18 08:40:47', '2019-08-20 19:08:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (727, 109, 24, 18, '2017-11-17 16:06:37', '2017-04-26 13:47:20', '2019-11-30 18:36:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (875, 807, 36, 77, '2017-07-08 21:35:09', '2017-02-10 21:26:09', '2018-05-26 22:52:47');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (690, 910, 40, 54, '2017-05-01 14:52:15', '2017-03-08 18:14:05', '2018-11-23 13:19:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (499, 655, 26, 20, '2017-09-24 04:52:55', '2017-04-13 01:10:47', '2018-11-30 18:00:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (693, 330, 38, 34, '2017-05-10 02:30:11', '2017-01-21 08:04:40', '2019-02-20 19:48:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (442, 263, 39, 69, '2017-03-31 20:01:24', '2017-02-04 22:33:01', '2018-11-26 09:03:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (676, 156, 27, 13, '2017-01-08 23:05:19', '2017-05-22 16:46:06', '2020-04-30 20:42:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (475, 90, 24, 24, '2017-12-13 13:49:27', '2017-02-11 04:22:23', '2018-02-04 22:28:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (644, 612, 37, 93, '2017-11-21 20:08:20', '2017-01-03 01:32:04', '2018-02-02 13:15:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (759, 744, 34, 54, '2017-06-13 18:32:10', '2017-04-29 13:44:28', '2018-09-15 02:42:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (332, 2, 1, 39, '2017-08-14 20:56:56', '2017-04-24 04:25:47', '2018-08-09 01:38:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (501, 154, 17, 82, '2017-12-27 02:36:30', '2017-03-22 22:48:50', '2019-09-18 15:59:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (847, 329, 35, 88, '2017-07-22 18:12:21', '2017-02-24 11:55:29', '2019-06-02 23:56:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (271, 111, 35, 95, '2017-09-11 19:21:01', '2017-05-13 12:47:44', '2019-07-08 10:22:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (374, 205, 18, 27, '2017-09-15 15:26:24', '2017-02-28 12:47:17', '2018-08-23 20:10:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (43, 267, 29, 19, '2017-07-05 05:01:28', '2017-05-14 06:22:12', '2018-08-31 02:16:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (113, 518, 39, 62, '2017-10-04 06:33:40', '2017-02-03 15:52:49', '2019-10-23 11:46:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 818, 32, 26, '2017-02-11 15:42:28', '2017-04-08 21:12:34', '2018-02-16 11:54:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (301, 901, 28, 99, '2017-07-24 18:24:45', '2017-05-14 00:48:03', '2018-08-08 21:19:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (545, 72, 2, 99, '2017-05-17 00:31:31', '2017-05-29 19:36:57', '2019-09-24 00:02:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (692, 598, 36, 10, '2017-05-27 11:25:49', '2017-04-27 12:28:50', '2020-03-15 03:15:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (976, 586, 30, 34, '2017-02-19 03:59:49', '2017-01-06 00:28:34', '2019-08-15 16:06:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (546, 469, 12, 82, '2017-07-30 20:18:17', '2017-05-23 02:04:04', '2019-04-19 07:34:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (258, 199, 10, 49, '2017-01-01 19:01:26', '2017-05-12 02:29:01', '2020-06-07 22:26:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (421, 155, 35, 49, '2017-10-23 01:50:01', '2017-05-26 14:32:06', '2019-04-26 18:45:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (925, 538, 13, 24, '2017-01-22 06:18:03', '2017-05-15 15:54:47', '2019-12-03 01:49:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (684, 917, 2, 45, '2017-03-25 11:09:56', '2017-03-27 14:28:48', '2019-04-24 19:19:25');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (557, 435, 7, 13, '2017-02-14 16:49:10', '2017-02-21 17:51:14', '2019-08-17 12:31:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (551, 7, 18, 88, '2017-09-08 06:25:15', '2017-05-24 03:36:48', '2019-12-02 20:16:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (770, 43, 15, 75, '2017-05-20 11:09:55', '2017-02-25 14:04:38', '2019-10-15 14:16:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (809, 940, 4, 90, '2017-11-22 04:45:53', '2017-05-30 19:28:07', '2020-01-31 12:28:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (112, 808, 25, 72, '2017-01-14 20:52:34', '2017-05-02 01:24:49', '2019-09-22 15:43:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (876, 288, 10, 18, '2017-12-12 07:52:44', '2017-02-20 03:51:46', '2019-08-02 14:23:52');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (946, 828, 27, 26, '2018-10-02 22:39:12', '2018-04-30 13:26:28', '2020-02-13 16:36:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (161, 42, 22, 83, '2018-09-01 00:32:11', '2018-02-17 14:12:27', '2020-08-01 05:10:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (252, 125, 2, 50, '2018-05-10 03:05:50', '2018-02-27 19:17:52', '2019-09-03 20:26:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (166, 116, 15, 18, '2018-06-01 11:43:20', '2018-05-29 12:37:52', '2019-10-11 21:10:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (569, 399, 1, 69, '2018-07-28 22:38:34', '2018-03-27 05:53:19', '2020-07-13 08:59:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (989, 487, 15, 35, '2018-03-29 23:30:50', '2018-04-15 23:43:10', '2019-03-04 23:36:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (508, 960, 20, 97, '2018-05-17 10:09:48', '2018-02-03 21:06:49', '2019-12-11 23:22:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (105, 453, 38, 29, '2018-02-21 12:56:43', '2018-03-08 11:53:50', '2019-04-17 05:02:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (219, 988, 32, 41, '2018-02-25 01:55:48', '2018-01-05 01:51:33', '2019-10-23 00:49:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (494, 977, 26, 83, '2018-10-26 08:22:16', '2018-05-13 01:13:48', '2019-08-09 02:50:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (966, 771, 40, 16, '2018-08-18 18:51:42', '2018-03-23 22:00:15', '2020-10-30 19:52:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (769, 185, 20, 74, '2018-11-06 16:05:56', '2018-01-13 00:18:24', '2020-03-28 06:07:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 942, 12, 81, '2018-04-06 20:46:18', '2018-04-27 02:59:55', '2020-01-18 14:24:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (252, 416, 17, 4, '2018-09-20 01:34:55', '2018-03-25 18:34:41', '2019-06-11 18:46:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (996, 725, 25, 38, '2018-05-11 23:10:05', '2018-05-06 00:40:14', '2020-09-02 14:30:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (167, 251, 32, 57, '2018-10-18 16:46:43', '2018-02-27 04:05:12', '2020-02-27 02:42:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (530, 828, 33, 83, '2018-11-26 06:56:39', '2018-05-28 15:30:46', '2020-12-18 11:02:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (969, 774, 31, 9, '2018-12-25 13:43:42', '2018-05-30 01:44:36', '2020-12-14 09:57:51');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (140, 54, 32, 45, '2018-05-28 03:50:48', '2018-01-09 12:36:10', '2020-03-18 16:26:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (383, 595, 33, 39, '2018-07-03 05:48:04', '2018-01-06 15:22:41', '2019-02-12 06:21:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (381, 431, 17, 85, '2018-01-06 20:19:37', '2018-04-16 09:36:54', '2020-03-15 00:10:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (226, 60, 40, 12, '2018-01-20 11:11:32', '2018-04-08 22:51:51', '2019-05-26 20:23:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (166, 922, 22, 88, '2018-08-01 00:10:23', '2018-04-21 21:39:59', '2019-04-18 23:54:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (16, 570, 1, 60, '2018-01-27 18:58:32', '2018-04-29 05:57:25', '2020-08-21 11:17:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (743, 847, 35, 79, '2018-10-03 02:38:00', '2018-02-25 00:26:09', '2019-11-09 22:15:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (922, 484, 13, 92, '2018-02-01 03:40:33', '2018-01-23 06:46:29', '2021-01-20 20:08:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (343, 402, 3, 22, '2018-01-21 03:04:47', '2018-01-23 19:46:48', '2021-01-30 03:29:46');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (913, 554, 12, 57, '2018-12-19 05:17:48', '2018-01-05 23:41:09', '2020-04-20 15:02:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (321, 504, 23, 30, '2018-09-04 08:34:38', '2018-02-14 20:10:14', '2019-11-02 23:34:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (420, 201, 39, 2, '2018-01-07 06:25:28', '2018-04-26 16:06:05', '2019-04-18 20:32:35');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (637, 463, 23, 29, '2018-10-28 03:20:06', '2018-04-19 06:32:14', '2020-06-01 11:39:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (977, 485, 38, 61, '2018-03-07 02:12:27', '2018-04-20 02:12:40', '2020-03-28 00:44:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 984, 5, 77, '2018-10-01 16:33:44', '2018-05-23 21:45:36', '2020-04-04 04:10:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (244, 896, 5, 56, '2018-05-06 03:39:30', '2018-03-12 05:29:15', '2019-12-19 00:29:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (537, 738, 13, 15, '2018-10-07 08:08:27', '2018-03-08 16:45:31', '2020-05-03 17:27:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (305, 26, 15, 12, '2018-07-03 23:27:14', '2018-03-25 21:33:39', '2021-06-05 03:03:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (823, 856, 3, 48, '2018-02-20 08:04:48', '2018-01-01 02:35:18', '2019-11-11 19:14:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 424, 39, 82, '2018-06-27 08:28:28', '2018-01-09 15:42:14', '2021-03-14 15:30:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (850, 630, 19, 69, '2018-02-22 11:06:03', '2018-04-19 10:13:31', '2020-11-07 21:09:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (706, 624, 35, 4, '2018-05-11 15:10:27', '2018-01-03 02:32:46', '2019-12-24 06:33:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (592, 42, 37, 15, '2018-07-16 00:05:40', '2018-03-16 09:36:24', '2019-07-31 07:17:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (740, 390, 19, 7, '2018-02-19 07:10:00', '2018-03-16 22:03:40', '2019-10-23 06:41:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (666, 644, 7, 24, '2018-06-08 19:35:48', '2018-04-18 17:50:46', '2020-01-10 02:39:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (815, 328, 34, 11, '2018-05-12 01:52:22', '2018-01-20 10:14:52', '2020-06-11 06:10:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (864, 677, 34, 18, '2018-07-24 07:47:47', '2018-02-13 16:24:04', '2019-05-30 03:27:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (621, 503, 27, 36, '2018-06-20 21:55:12', '2018-03-23 08:18:06', '2019-07-30 00:35:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (163, 159, 11, 67, '2018-12-13 12:50:26', '2018-05-28 08:40:13', '2020-08-06 13:11:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (949, 58, 12, 41, '2018-03-03 02:37:09', '2018-02-16 20:06:28', '2020-03-27 01:51:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (89, 196, 37, 88, '2018-06-10 07:26:15', '2018-04-11 03:36:22', '2020-07-17 10:00:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (772, 581, 29, 86, '2018-12-22 21:46:52', '2018-04-02 18:34:36', '2020-06-24 15:33:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (980, 359, 34, 7, '2018-02-02 04:56:21', '2018-03-20 17:18:04', '2019-02-08 11:01:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 46, 6, 2, '2018-04-28 08:38:41', '2018-01-14 00:40:25', '2021-04-27 06:43:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 932, 14, 27, '2018-11-16 12:22:52', '2018-03-16 09:04:47', '2020-12-01 10:14:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (639, 609, 11, 30, '2018-11-13 07:30:06', '2018-05-13 17:25:42', '2020-07-09 00:05:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (241, 249, 8, 34, '2018-05-17 02:05:44', '2018-03-17 17:42:45', '2019-02-07 22:43:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (180, 93, 9, 99, '2018-10-23 06:45:37', '2018-01-12 10:18:54', '2019-03-23 19:39:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (100, 48, 22, 85, '2018-09-25 03:50:27', '2018-02-27 19:26:38', '2019-06-15 01:16:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 337, 30, 61, '2018-02-07 14:44:40', '2018-01-12 08:25:06', '2019-08-05 14:55:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (641, 6, 4, 98, '2018-12-09 03:43:11', '2018-01-24 17:28:22', '2019-10-31 16:03:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (999, 835, 17, 77, '2018-07-02 06:03:25', '2018-01-02 13:55:11', '2019-04-28 19:51:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (28, 584, 17, 25, '2018-10-22 18:40:11', '2018-05-24 14:02:46', '2019-08-11 12:03:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (479, 657, 20, 10, '2018-09-16 16:02:46', '2018-04-10 22:49:05', '2020-05-13 21:34:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (674, 439, 35, 57, '2018-12-09 23:00:35', '2018-01-06 03:25:43', '2019-11-30 16:41:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (364, 938, 32, 100, '2018-07-17 04:30:36', '2018-03-27 00:58:25', '2020-12-28 00:00:43');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (541, 409, 1, 56, '2018-12-21 17:39:50', '2018-02-26 18:42:59', '2019-05-23 01:37:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (651, 664, 17, 83, '2018-09-03 19:26:04', '2018-04-02 06:03:50', '2020-06-05 05:36:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (228, 8, 24, 56, '2018-03-29 21:52:12', '2018-03-24 13:23:15', '2021-02-09 23:20:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (962, 573, 38, 53, '2018-01-17 06:28:35', '2018-04-15 14:45:08', '2021-02-06 20:03:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (352, 40, 40, 84, '2018-10-25 17:18:24', '2018-04-03 13:26:18', '2021-03-18 23:20:45');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (10, 797, 25, 33, '2018-09-19 08:29:01', '2018-01-11 10:34:33', '2021-03-31 08:48:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (53, 93, 27, 83, '2018-11-02 17:22:27', '2018-03-19 07:55:04', '2020-03-15 01:43:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (806, 95, 24, 15, '2018-09-21 14:33:25', '2018-01-15 08:26:48', '2019-08-13 06:38:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (356, 838, 2, 21, '2018-06-14 03:58:06', '2018-04-15 11:32:13', '2021-04-03 10:32:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (855, 120, 40, 89, '2018-10-07 08:50:31', '2018-03-05 14:58:40', '2020-09-16 11:32:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (952, 790, 40, 65, '2018-06-15 10:24:53', '2018-04-01 12:10:12', '2019-12-10 02:30:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (370, 62, 10, 1, '2018-07-10 06:12:41', '2018-04-17 16:28:57', '2019-12-25 20:46:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (892, 670, 25, 86, '2018-10-27 05:39:20', '2018-03-08 21:50:48', '2019-09-05 16:44:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (383, 996, 12, 76, '2018-04-14 21:06:01', '2018-04-11 19:21:18', '2019-05-26 09:07:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (30, 883, 3, 95, '2018-09-29 06:07:39', '2018-03-21 18:18:48', '2019-04-21 08:15:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (719, 113, 26, 70, '2018-09-09 04:42:17', '2018-05-07 22:42:55', '2020-01-31 09:27:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (99, 65, 19, 30, '2018-10-01 21:05:55', '2018-01-25 16:27:14', '2019-03-24 06:38:37');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (247, 680, 29, 62, '2018-04-22 13:04:58', '2018-02-23 05:40:53', '2019-04-18 21:18:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (334, 460, 8, 3, '2018-03-08 20:51:14', '2018-04-01 20:20:56', '2020-12-18 00:29:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (770, 512, 35, 73, '2018-05-14 05:19:40', '2018-05-25 07:36:15', '2020-09-01 11:33:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (748, 55, 29, 26, '2018-01-15 14:30:13', '2018-04-21 01:40:06', '2019-02-25 23:26:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (888, 408, 37, 83, '2018-06-03 19:38:04', '2018-05-14 21:22:33', '2020-05-02 08:54:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (111, 625, 26, 66, '2018-02-03 08:26:30', '2018-03-01 02:12:06', '2020-03-28 20:13:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (157, 676, 10, 7, '2018-07-30 07:52:12', '2018-04-20 13:01:25', '2019-05-19 02:00:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (189, 671, 16, 18, '2018-08-09 21:53:02', '2018-05-07 00:32:15', '2019-03-22 07:37:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (193, 392, 34, 60, '2018-05-04 06:12:52', '2018-01-08 23:04:58', '2019-07-30 17:15:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (900, 803, 7, 20, '2018-02-27 11:35:03', '2018-03-01 06:23:48', '2020-04-28 14:36:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (928, 480, 11, 80, '2018-03-16 19:55:31', '2018-03-03 00:03:33', '2019-10-05 08:09:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (993, 155, 29, 79, '2018-10-19 15:54:50', '2018-03-17 09:00:12', '2020-08-19 08:37:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (849, 233, 2, 17, '2018-10-15 20:49:32', '2018-05-29 12:11:16', '2019-08-22 00:21:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (723, 475, 16, 95, '2018-12-25 09:59:36', '2018-05-15 07:51:25', '2019-11-24 06:29:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (192, 877, 16, 99, '2018-04-10 15:27:27', '2018-02-08 19:49:28', '2019-08-24 15:19:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (210, 757, 26, 18, '2018-10-02 06:03:55', '2018-03-28 02:39:36', '2019-10-22 09:41:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (87, 863, 13, 65, '2018-10-14 10:02:25', '2018-04-22 03:59:42', '2021-02-06 08:25:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (428, 193, 6, 31, '2018-04-10 00:09:21', '2018-03-04 14:02:47', '2020-04-28 03:50:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (711, 383, 22, 52, '2018-12-04 00:15:43', '2018-01-08 10:53:01', '2020-01-06 22:19:29');


insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (869, 314, 28, 67, '2019-05-12 13:36:26', '2019-02-09 01:04:40', '2021-03-10 20:51:06');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (571, 662, 25, 65, '2019-07-24 11:31:09', '2019-05-06 11:17:42', '2020-02-11 13:32:50');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (980, 810, 18, 26, '2019-11-21 21:30:30', '2019-03-05 11:37:53', '2021-02-26 23:42:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (709, 959, 19, 14, '2019-07-14 13:09:04', '2019-02-18 22:03:14', '2020-08-27 22:05:24');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (76, 919, 10, 28, '2019-10-20 02:12:30', '2019-03-25 13:55:22', '2021-11-25 04:38:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (170, 965, 17, 44, '2019-04-27 17:00:26', '2019-02-20 02:53:25', '2021-11-20 19:40:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (451, 530, 25, 71, '2019-03-30 17:45:15', '2019-05-20 12:47:06', '2020-11-18 03:00:19');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (188, 152, 29, 20, '2019-04-14 14:25:09', '2019-05-19 15:52:06', '2022-04-17 01:27:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (953, 231, 10, 61, '2019-02-21 14:19:13', '2019-03-11 23:21:49', '2021-03-14 23:34:54');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (708, 542, 13, 32, '2019-05-19 18:58:46', '2019-05-17 13:16:19', '2020-08-12 03:04:23');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (115, 768, 22, 29, '2019-02-01 00:55:23', '2019-04-26 23:17:46', '2021-03-01 03:36:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (728, 134, 12, 31, '2019-02-27 19:47:21', '2019-02-02 04:46:14', '2021-10-05 22:11:04');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (362, 599, 18, 61, '2019-03-15 06:08:25', '2019-04-22 16:33:33', '2022-03-21 15:17:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (83, 333, 32, 25, '2019-08-16 09:45:23', '2019-03-08 22:38:49', '2021-06-25 20:47:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (417, 843, 3, 16, '2019-11-17 00:41:49', '2019-04-27 02:13:59', '2020-04-12 08:54:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (241, 107, 7, 66, '2019-07-17 16:02:07', '2019-05-06 19:17:37', '2021-07-04 15:32:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (857, 156, 31, 57, '2019-01-17 16:46:07', '2019-03-12 10:53:38', '2020-05-04 20:08:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (328, 531, 4, 92, '2019-06-06 21:48:13', '2019-01-24 02:57:48', '2020-12-13 05:16:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (107, 913, 24, 82, '2019-11-29 07:00:11', '2019-01-26 20:07:46', '2021-04-27 19:04:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (906, 28, 30, 80, '2019-03-04 11:54:20', '2019-01-14 12:42:08', '2021-11-21 00:36:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (325, 68, 35, 67, '2019-11-17 23:31:59', '2019-01-10 13:51:15', '2022-04-15 04:02:12');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (936, 844, 4, 23, '2019-07-18 20:40:36', '2019-01-01 08:17:37', '2020-05-28 23:37:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (336, 736, 30, 7, '2019-04-02 16:53:48', '2019-03-23 17:33:54', '2021-11-30 01:15:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (144, 799, 40, 18, '2019-06-04 09:41:20', '2019-05-31 06:04:53', '2020-04-16 04:12:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (277, 241, 5, 62, '2019-05-11 22:26:37', '2019-02-09 18:26:07', '2021-11-02 18:52:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (829, 856, 2, 50, '2019-10-03 00:05:10', '2019-02-20 08:37:51', '2021-07-03 05:55:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (917, 312, 19, 17, '2019-05-22 17:52:27', '2019-05-09 13:30:41', '2020-08-04 07:47:22');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (459, 770, 14, 52, '2019-02-21 05:45:16', '2019-04-27 18:22:39', '2021-07-11 13:15:41');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (797, 450, 5, 59, '2019-06-13 15:04:14', '2019-02-19 17:36:40', '2022-04-04 06:31:18');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (122, 771, 19, 81, '2019-04-10 16:13:35', '2019-02-19 04:52:04', '2021-03-06 05:06:09');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (809, 400, 27, 96, '2019-11-09 11:02:38', '2019-03-15 15:13:11', '2021-06-21 07:02:16');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (481, 610, 26, 7, '2019-07-07 07:56:28', '2019-04-17 04:05:32', '2022-03-01 06:54:15');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (400, 185, 22, 7, '2019-08-26 05:20:35', '2019-03-08 11:41:19', '2020-05-26 00:17:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (447, 996, 39, 18, '2019-10-02 18:51:55', '2019-03-04 14:29:04', '2020-09-19 10:27:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (567, 388, 31, 98, '2019-06-21 05:06:49', '2019-04-26 22:00:09', '2020-04-14 02:12:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (665, 498, 37, 42, '2019-04-02 00:38:32', '2019-05-16 17:27:57', '2021-04-19 12:30:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (72, 282, 7, 92, '2019-04-05 01:09:24', '2019-03-21 15:38:18', '2020-10-05 16:19:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (685, 591, 30, 82, '2019-04-19 03:07:16', '2019-01-26 14:55:30', '2022-01-03 02:06:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (525, 218, 23, 88, '2019-08-11 15:04:38', '2019-01-15 03:04:57', '2021-02-16 15:27:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (961, 934, 18, 1, '2019-11-23 18:58:18', '2019-03-25 23:12:25', '2020-09-24 13:58:30');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (274, 678, 14, 56, '2019-08-07 15:13:27', '2019-02-09 11:59:18', '2022-06-08 09:51:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (715, 50, 31, 29, '2019-05-21 18:46:03', '2019-05-07 10:19:39', '2021-12-20 17:22:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (209, 284, 18, 34, '2019-02-21 04:46:21', '2019-04-18 17:45:45', '2020-11-05 08:38:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (343, 848, 32, 51, '2019-11-22 10:36:05', '2019-03-22 06:04:47', '2020-10-04 07:14:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (329, 294, 7, 60, '2019-01-03 05:01:15', '2019-03-27 22:14:48', '2021-05-06 14:23:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (665, 890, 2, 37, '2019-08-29 16:17:39', '2019-01-24 06:54:00', '2022-04-06 06:43:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (178, 273, 33, 10, '2019-06-15 07:30:59', '2019-03-27 18:55:09', '2021-04-06 09:47:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (233, 434, 21, 88, '2019-07-24 04:09:24', '2019-04-17 15:21:06', '2021-06-18 10:31:17');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (84, 328, 32, 20, '2019-12-25 03:11:20', '2019-01-31 13:04:29', '2021-08-24 16:02:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (99, 820, 6, 91, '2019-06-17 08:19:17', '2019-02-08 06:00:21', '2020-11-06 05:44:20');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (553, 13, 25, 44, '2019-06-22 21:05:56', '2019-02-18 04:13:55', '2020-09-03 12:55:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (693, 25, 25, 10, '2019-10-08 23:38:57', '2019-05-02 12:15:36', '2022-05-02 14:58:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (737, 171, 4, 85, '2019-06-05 17:28:38', '2019-02-14 11:08:55', '2020-11-27 08:09:34');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (141, 548, 22, 55, '2019-03-01 12:41:33', '2019-04-01 12:27:05', '2021-07-29 16:27:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (79, 844, 30, 74, '2019-08-29 18:44:47', '2019-03-27 20:49:01', '2022-01-19 13:20:52');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (483, 754, 40, 10, '2019-05-05 08:47:17', '2019-02-09 17:19:27', '2020-09-13 13:25:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (408, 431, 18, 4, '2019-05-24 23:39:05', '2019-04-18 04:35:41', '2021-12-31 07:32:08');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (536, 724, 22, 17, '2019-02-27 08:41:57', '2019-04-04 21:57:30', '2021-01-23 16:21:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (951, 396, 4, 72, '2019-07-18 13:07:49', '2019-04-06 11:05:49', '2021-08-08 01:12:59');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (870, 262, 25, 59, '2019-01-04 23:08:13', '2019-04-18 15:31:50', '2020-04-23 14:53:57');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (538, 418, 32, 80, '2019-02-25 04:05:22', '2019-05-03 04:57:16', '2020-07-10 12:52:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (760, 808, 35, 67, '2019-10-23 06:11:08', '2019-02-15 10:15:30', '2020-05-29 17:54:58');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (691, 257, 34, 8, '2019-09-15 01:15:11', '2019-03-18 23:48:21', '2021-12-30 17:42:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (287, 623, 18, 51, '2019-08-06 14:49:30', '2019-04-26 17:05:17', '2020-02-12 16:06:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (204, 402, 24, 18, '2019-09-08 12:19:38', '2019-02-11 02:35:34', '2022-04-28 19:37:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (43, 234, 9, 58, '2019-08-05 04:39:01', '2019-01-31 05:11:36', '2020-02-15 12:41:55');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (561, 508, 13, 98, '2019-10-09 16:46:39', '2019-04-27 08:36:00', '2020-04-26 19:26:36');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (38, 300, 24, 29, '2019-12-31 08:35:41', '2019-03-29 18:48:27', '2020-06-29 02:54:53');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (480, 310, 6, 21, '2019-04-13 08:49:22', '2019-04-30 09:38:21', '2021-03-07 08:26:31');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (207, 948, 14, 32, '2019-10-13 11:33:11', '2019-03-16 03:24:27', '2020-12-11 04:42:07');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (485, 772, 27, 71, '2019-03-16 05:17:36', '2019-02-10 17:08:10', '2021-03-09 00:36:56');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (406, 806, 17, 1, '2019-09-24 01:48:44', '2019-03-11 23:20:35', '2021-03-02 17:35:39');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (957, 587, 3, 39, '2019-01-19 19:23:00', '2019-02-14 14:20:21', '2020-03-24 17:57:29');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (76, 430, 28, 23, '2019-10-14 09:31:37', '2019-02-03 16:19:49', '2022-01-11 22:43:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (652, 295, 12, 14, '2019-05-23 08:42:39', '2019-03-27 05:27:46', '2020-09-18 05:46:14');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (449, 81, 22, 91, '2019-11-30 22:48:17', '2019-02-10 02:14:08', '2021-05-11 18:31:11');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (99, 674, 36, 44, '2019-05-22 09:13:17', '2019-02-20 05:38:32', '2021-04-07 11:55:26');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (15, 665, 1, 58, '2019-10-30 09:15:32', '2019-03-03 17:41:39', '2021-11-08 16:53:05');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (729, 263, 32, 54, '2019-05-28 00:54:46', '2019-03-06 06:33:14', '2021-05-17 18:19:00');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (901, 610, 28, 27, '2019-01-16 21:27:11', '2019-04-08 09:42:54', '2020-10-29 21:30:21');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (509, 117, 9, 3, '2019-06-12 11:15:16', '2019-01-21 17:59:47', '2021-08-03 23:25:10');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (637, 632, 35, 26, '2019-09-23 08:37:35', '2019-03-07 15:19:49', '2021-12-06 10:40:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (172, 585, 21, 95, '2019-12-21 11:30:30', '2019-04-28 21:33:02', '2021-01-12 04:37:42');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (782, 596, 16, 51, '2019-11-03 20:22:54', '2019-02-09 20:40:15', '2020-03-10 06:46:40');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (174, 770, 29, 88, '2019-07-20 08:36:47', '2019-03-17 03:44:41', '2020-02-08 12:12:03');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (499, 12, 17, 48, '2019-04-14 16:33:09', '2019-01-15 06:24:34', '2020-04-08 04:16:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (882, 573, 30, 4, '2019-08-20 05:22:33', '2019-03-06 08:49:06', '2021-08-22 20:37:48');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (68, 153, 9, 87, '2019-11-26 05:11:21', '2019-03-16 08:42:14', '2022-01-19 06:48:32');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (361, 804, 23, 62, '2019-12-30 01:10:40', '2019-03-02 06:04:53', '2021-01-20 03:13:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (384, 590, 12, 99, '2019-08-21 05:45:02', '2019-02-20 02:23:59', '2021-01-06 01:10:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (655, 46, 10, 5, '2019-10-30 23:11:06', '2019-01-04 05:22:40', '2021-03-27 17:04:38');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (5, 196, 24, 79, '2019-06-08 16:52:39', '2019-03-07 01:39:05', '2021-01-05 17:49:13');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (703, 314, 36, 23, '2019-11-04 17:08:49', '2019-03-23 17:00:54', '2021-12-01 14:27:02');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (127, 653, 15, 87, '2019-08-20 05:09:30', '2019-02-02 23:56:13', '2020-12-19 19:52:44');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (86, 524, 21, 92, '2019-05-10 22:06:51', '2019-02-28 12:20:00', '2022-02-13 00:27:33');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (171, 363, 25, 40, '2019-11-04 16:57:07', '2019-01-20 20:34:45', '2021-12-05 09:02:27');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (284, 133, 19, 15, '2019-10-27 16:38:47', '2019-02-25 05:51:37', '2022-04-29 19:55:49');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (149, 233, 16, 42, '2019-06-10 09:58:40', '2019-01-14 01:16:35', '2021-10-16 05:37:28');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (835, 358, 16, 12, '2019-03-13 07:29:33', '2019-03-10 05:12:56', '2021-12-31 23:59:01');
insert into Contract
  (CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo)
values
  (552, 366, 18, 93, '2019-05-25 22:16:20', '2019-04-19 06:34:31', '2020-04-10 09:21:38');
