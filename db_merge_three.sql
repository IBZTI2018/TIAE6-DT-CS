-- Merge Data from staging system to dwh system
-- MERGE TIAE6_DT_Staging.dbo.Supplier AS TARGET
--   USING TIAE6_DT_Production.dbo.Supplier AS SOURCE 
--     ON (TARGET.SupplierId = SOURCE.SupplierId)
--   WHEN MATCHED AND TARGET.SupplierId <> SOURCE.SupplierId OR TARGET.CompanyName <> SOURCE.CompanyName OR TARGET.Phone <> SOURCE.Phone OR TARGET.IsPrivateLabel <> SOURCE.IsPrivateLabel 
--     THEN UPDATE SET TARGET.SupplierId = SOURCE.SupplierId, TARGET.CompanyName = SOURCE.CompanyName , TARGET.Phone = SOURCE.Phone, TARGET.IsPrivateLabel = SOURCE.IsPrivateLabel
--   WHEN NOT MATCHED BY TARGET 
--     THEN INSERT (SupplierId, CompanyName, Phone, IsPrivateLabel) VALUES (SOURCE.SupplierId, SOURCE.CompanyName, SOURCE.Phone, SOURCE.IsPrivateLabel)
--   WHEN NOT MATCHED BY SOURCE 
--     THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimContractSignDate AS TARGET
  USING TIAE6_DT_Staging.dbo.DimContractSignDate AS SOURCE 
    ON (TARGET.ContractSignDateId = SOURCE.ContractSignDateId)
  WHEN MATCHED AND TARGET.ContractSignDateId <> SOURCE.ContractSignDateId OR TARGET.Year <> SOURCE.Year OR TARGET.Month <> SOURCE.Month OR TARGET.Week <> SOURCE.Week OR TARGET.Day <> SOURCE.Day 
    THEN UPDATE SET TARGET.ContractSignDateId = SOURCE.ContractSignDateId, TARGET.Year = SOURCE.Year , TARGET.Month = SOURCE.Month, TARGET.Week = SOURCE.Week, TARGET.Day = SOURCE.Day
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ContractSignDateId, Year, Month, Week, Day) VALUES (SOURCE.ContractSignDateId, SOURCE.Year, SOURCE.Month, SOURCE.Week, SOURCE.Day)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimContractValidFrom AS TARGET
  USING TIAE6_DT_Staging.dbo.DimContractValidFrom AS SOURCE 
    ON (TARGET.ContractValidFromId = SOURCE.ContractValidFromId)
  WHEN MATCHED AND TARGET.ContractValidFromId <> SOURCE.ContractValidFromId OR TARGET.Year <> SOURCE.Year OR TARGET.Month <> SOURCE.Month OR TARGET.Week <> SOURCE.Week OR TARGET.Day <> SOURCE.Day 
    THEN UPDATE SET TARGET.ContractValidFromId = SOURCE.ContractValidFromId, TARGET.Year = SOURCE.Year , TARGET.Month = SOURCE.Month, TARGET.Week = SOURCE.Week, TARGET.Day = SOURCE.Day
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ContractValidFromId, Year, Month, Week, Day) VALUES (SOURCE.ContractValidFromId, SOURCE.Year, SOURCE.Month, SOURCE.Week, SOURCE.Day)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimContractValidTo AS TARGET
  USING TIAE6_DT_Staging.dbo.DimContractValidTo AS SOURCE 
    ON (TARGET.ContractValidToId = SOURCE.ContractValidToId)
  WHEN MATCHED AND TARGET.ContractValidToId <> SOURCE.ContractValidToId OR TARGET.Year <> SOURCE.Year OR TARGET.Month <> SOURCE.Month OR TARGET.Week <> SOURCE.Week OR TARGET.Day <> SOURCE.Day 
    THEN UPDATE SET TARGET.ContractValidToId = SOURCE.ContractValidToId, TARGET.Year = SOURCE.Year , TARGET.Month = SOURCE.Month, TARGET.Week = SOURCE.Week, TARGET.Day = SOURCE.Day
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ContractValidToId, Year, Month, Week, Day) VALUES (SOURCE.ContractValidToId, SOURCE.Year, SOURCE.Month, SOURCE.Week, SOURCE.Day)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimCustomer AS TARGET
  USING TIAE6_DT_Staging.dbo.DimCustomer AS SOURCE 
    ON (TARGET.CustomerId = SOURCE.CustomerId)
  WHEN MATCHED AND TARGET.CustomerId <> SOURCE.CustomerId OR TARGET.FirstName <> SOURCE.FirstName OR TARGET.LastName <> SOURCE.LastName OR TARGET.Phone <> SOURCE.Phone OR TARGET.BirthDate <> SOURCE.BirthDate  OR TARGET.Gender <> SOURCE.Gender 
    THEN UPDATE SET TARGET.CustomerId = SOURCE.CustomerId, TARGET.FirstName = SOURCE.FirstName , TARGET.LastName = SOURCE.LastName, TARGET.Phone = SOURCE.Phone, TARGET.BirthDate = SOURCE.BirthDate, TARGET.Gender = SOURCE.Gender
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (CustomerId, FirstName, LastName, Phone, BirthDate, Gender) VALUES (SOURCE.CustomerId, SOURCE.FirstName, SOURCE.LastName, SOURCE.Phone, SOURCE.BirthDate, SOURCE.Gender)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimDevice AS TARGET
  USING TIAE6_DT_Staging.dbo.DimDevice AS SOURCE 
    ON (TARGET.DeviceId = SOURCE.DeviceId)
  WHEN MATCHED AND TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.DeviceName <> SOURCE.DeviceName OR TARGET.DeviceBrand <> SOURCE.DeviceBrand OR TARGET.DeviceType <> SOURCE.DeviceType OR TARGET.DevicePrice <> SOURCE.DevicePrice OR TARGET.PurchasePrice <> SOURCE.PurchasePrice OR TARGET.CompanyName <> SOURCE.CompanyName OR TARGET.Phone <> SOURCE.Phone OR TARGET.IsPrivateLabel <> SOURCE.IsPrivateLabel OR TARGET.DeviceWareHouseAmount <> SOURCE.DeviceWareHouseAmount OR TARGET.WareHouseName <> SOURCE.WareHouseName OR TARGET.WareHousePhone <> SOURCE.WareHousePhone OR TARGET.WareHouseCapacity <> SOURCE.WareHouseCapacity 
    THEN UPDATE SET TARGET.DeviceId = SOURCE.DeviceId, TARGET.DeviceName = SOURCE.DeviceName , TARGET.DeviceBrand = SOURCE.DeviceBrand, TARGET.DeviceType = SOURCE.DeviceType, TARGET.DevicePrice = SOURCE.DevicePrice, TARGET.PurchasePrice = SOURCE.PurchasePrice, TARGET.CompanyName = SOURCE.CompanyName, TARGET.Phone = SOURCE.Phone, TARGET.IsPrivateLabel = SOURCE.IsPrivateLabel, TARGET.DeviceWareHouseAmount = SOURCE.DeviceWareHouseAmount, TARGET.WareHouseName = SOURCE.WareHouseName, TARGET.WareHousePhone = SOURCE.WareHousePhone, TARGET.WareHouseCapacity = SOURCE.WareHouseCapacity
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (DeviceId, DeviceName, DeviceBrand, DeviceType, DevicePrice, PurchasePrice, CompanyName, Phone, IsPrivateLabel, DeviceWareHouseAmount, WareHouseName, WareHousePhone, WareHouseCapacity) VALUES (SOURCE.DeviceId, SOURCE.DeviceName, SOURCE.DeviceBrand, SOURCE.DeviceType, SOURCE.DevicePrice, SOURCE.PurchasePrice, SOURCE.CompanyName, SOURCE.Phone, SOURCE.IsPrivateLabel, SOURCE.DeviceWareHouseAmount, SOURCE.WareHouseName, SOURCE.WareHousePhone, SOURCE.WareHouseCapacity)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimLocation AS TARGET
  USING TIAE6_DT_Staging.dbo.DimLocation AS SOURCE 
    ON (TARGET.LocationId = SOURCE.LocationId)
  WHEN MATCHED AND TARGET.LocationId <> SOURCE.LocationId OR TARGET.Street <> SOURCE.Street OR TARGET.City <> SOURCE.City OR TARGET.Region <> SOURCE.Region OR TARGET.ZipCode <> SOURCE.ZipCode  OR TARGET.Country <> SOURCE.Country 
    THEN UPDATE SET TARGET.LocationId = SOURCE.LocationId, TARGET.Street = SOURCE.Street , TARGET.City = SOURCE.City, TARGET.Region = SOURCE.Region, TARGET.ZipCode = SOURCE.ZipCode, TARGET.Country = SOURCE.Country
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (LocationId, Street, City, Region, ZipCode, Country) VALUES (SOURCE.LocationId, SOURCE.Street, SOURCE.City, SOURCE.Region, SOURCE.ZipCode, SOURCE.Country)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.DimStore AS TARGET
  USING TIAE6_DT_Staging.dbo.DimStore AS SOURCE 
    ON (TARGET.StoreId = SOURCE.StoreId)
  WHEN MATCHED AND TARGET.StoreId <> SOURCE.StoreId OR TARGET.StoreName <> SOURCE.StoreName OR TARGET.StorePhone <> SOURCE.StorePhone
    THEN UPDATE SET TARGET.StoreId = SOURCE.StoreId, TARGET.StoreName = SOURCE.StoreName , TARGET.StorePhone = SOURCE.StorePhone
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (StoreId, StoreName, StorePhone) VALUES (SOURCE.StoreId, SOURCE.StoreName, SOURCE.StorePhone)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_DWH.dbo.FactSales AS TARGET
  USING TIAE6_DT_Staging.dbo.FactSales AS SOURCE 
    ON (TARGET.ContractId = SOURCE.ContractId AND TARGET.CustomerId = SOURCE.CustomerId AND TARGET.DeviceId = SOURCE.DeviceId AND TARGET.StoreId = SOURCE.StoreId AND TARGET.LocationId = SOURCE.LocationId AND TARGET.ContractSignDateId = SOURCE.ContractSignDateId AND TARGET.ContractValidFromId = SOURCE.ContractValidFromId AND TARGET.ContractValidToId = SOURCE.ContractValidToId)
  WHEN MATCHED AND TARGET.ContractId <> SOURCE.ContractId OR TARGET.CustomerId <> SOURCE.CustomerId OR TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.StoreId <> SOURCE.StoreId OR TARGET.LocationId <> SOURCE.LocationId OR TARGET.ContractSignDateId <> SOURCE.ContractSignDateId OR TARGET.ContractValidFromId <> SOURCE.ContractValidFromId OR TARGET.ContractValidToId <> SOURCE.ContractValidToId OR TARGET.ContractName <> SOURCE.ContractName OR TARGET.ContractType <> SOURCE.ContractType OR TARGET.ContractState <> SOURCE.ContractState OR TARGET.ContractPrice <> SOURCE.ContractPrice 
    THEN UPDATE SET TARGET.ContractId = SOURCE.ContractId, TARGET.CustomerId = SOURCE.CustomerId, TARGET.DeviceId = SOURCE.DeviceId , TARGET.StoreId = SOURCE.StoreId, TARGET.LocationId = SOURCE.LocationId, TARGET.ContractSignDateId = SOURCE.ContractSignDateId, TARGET.ContractValidFromId = SOURCE.ContractValidFromId, TARGET.ContractValidToId = SOURCE.ContractValidToId, TARGET.ContractName = SOURCE.ContractName, TARGET.ContractType = SOURCE.ContractType, TARGET.ContractState = SOURCE.ContractState, TARGET.ContractPrice = SOURCE.ContractPrice
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ContractId, CustomerId, DeviceId, StoreId, LocationId, ContractSignDateId, ContractValidFromId, ContractValidToId, ContractName, ContractType, ContractState, ContractPrice) VALUES (SOURCE.ContractId, SOURCE.CustomerId, SOURCE.DeviceId, SOURCE.StoreId, SOURCE.LocationId, SOURCE.ContractSignDateId, SOURCE.ContractValidFromId, SOURCE.ContractValidToId, SOURCE.ContractName, SOURCE.ContractType, SOURCE.ContractState, SOURCE.ContractPrice)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;
