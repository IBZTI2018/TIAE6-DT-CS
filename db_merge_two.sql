USE TIAE6_DT_Staging;

DECLARE @factTable TABLE (
	[Contract_ContractId] int NOT NULL ,
	[Contract_CustomerId] int NOT NULL ,
	[Contract_ServiceId] int NOT NULL ,
	[Contract_DeviceId] int NOT NULL ,
	[Contract_StoreId] int NOT NULL ,
	[Contract_ContractSignDate] date NOT NULL ,
	[Contract_ContractValidFrom] date NOT NULL ,
	[Contract_ContractValidTo] date NOT NULL ,
	[Customer_CustomerId] int NOT NULL ,
	[Customer_FirstName] varchar(50) NOT NULL ,
	[Customer_LastName] varchar(50) NOT NULL ,
	[Customer_Phone] varchar(50) NOT NULL ,
	[Customer_Birthdate] date NOT NULL ,
	[Customer_Gender] char(1) NOT NULL ,
	[Customer_LocationId] int NOT NULL ,
	[Service_ServiceId] int NOT NULL ,
	[Service_Name] varchar(50) NOT NULL ,
	[Service_Type] varchar(50) NOT NULL ,
	[Service_State] varchar(50) NOT NULL ,
	[Service_Price] money NOT NULL ,
	[Device_DeviceId] int NOT NULL ,
	[Device_Name] varchar(50) NOT NULL ,
	[Device_Brand] varchar(50) NOT NULL ,
	[Device_Type] varchar(50) NOT NULL ,
	[Device_Price] money NOT NULL ,
	[Store_StoreId] int NOT NULL ,
	[Store_Name] varchar(50) NOT NULL ,
	[Store_Phone] varchar(50) NOT NULL ,
	[Store_LocationId] int NOT NULL
);

INSERT INTO @factTable
SELECT * FROM TIAE6_DT_Staging.dbo.Contract
JOIN TIAE6_DT_Staging.dbo.Customer ON Customer.CustomerId = Contract.CustomerId
JOIN TIAE6_DT_Staging.dbo.Service ON Service.ServiceId = Contract.ServiceId
JOIN TIAE6_DT_Staging.dbo.Device ON Device.DeviceId = Contract.DeviceId
JOIN TIAE6_DT_Staging.dbo.Store ON Store.StoreId = Contract.StoreId;

DECLARE @factTableID INT = 1;
DECLARE @RunningTotal BIGINT = 0;
DECLARE @RowCnt BIGINT = 0;

-- get a count of total rows to process 
SELECT @RowCnt = COUNT(0) FROM @factTable;
 
WHILE @factTableID <= @RowCnt
BEGIN

    -- WORK TO DO HERE

   SET @factTableID = @factTableID + 1 
 
END