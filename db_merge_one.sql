-- Merge Data from production system to staging system
MERGE TIAE6_DT_Staging.dbo.Supplier AS TARGET
  USING TIAE6_DT_Production.dbo.Supplier AS SOURCE 
    ON (TARGET.SupplierId = SOURCE.SupplierId)
  WHEN MATCHED AND TARGET.SupplierId <> SOURCE.SupplierId OR TARGET.CompanyName <> SOURCE.CompanyName OR TARGET.Phone <> SOURCE.Phone OR TARGET.IsPrivateLabel <> SOURCE.IsPrivateLabel 
    THEN UPDATE SET TARGET.SupplierId = SOURCE.SupplierId, TARGET.CompanyName = SOURCE.CompanyName , TARGET.Phone = SOURCE.Phone, TARGET.IsPrivateLabel = SOURCE.IsPrivateLabel
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (SupplierId, CompanyName, Phone, IsPrivateLabel) VALUES (SOURCE.SupplierId, SOURCE.CompanyName, SOURCE.Phone, SOURCE.IsPrivateLabel)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Service AS TARGET
  USING TIAE6_DT_Production.dbo.Service AS SOURCE 
    ON (TARGET.ServiceId = SOURCE.ServiceId)
  WHEN MATCHED AND TARGET.ServiceId <> SOURCE.ServiceId OR TARGET.Name <> SOURCE.Name OR TARGET.Type <> SOURCE.Type OR TARGET.State <> SOURCE.State OR TARGET.Price <> SOURCE.Price 
    THEN UPDATE SET TARGET.ServiceId = SOURCE.ServiceId, TARGET.Name = SOURCE.Name , TARGET.Type = SOURCE.Type, TARGET.State = SOURCE.State, TARGET.Price = SOURCE.Price
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ServiceId, Name, Type, State, Price) VALUES (SOURCE.ServiceId, SOURCE.Name, SOURCE.Type, SOURCE.State, SOURCE.Price)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Location AS TARGET
  USING TIAE6_DT_Production.dbo.Location AS SOURCE 
    ON (TARGET.LocationId = SOURCE.LocationId)
  WHEN MATCHED AND TARGET.LocationId <> SOURCE.LocationId OR TARGET.Street <> SOURCE.Street OR TARGET.City <> SOURCE.City OR TARGET.Region <> SOURCE.Region OR TARGET.ZipCode <> SOURCE.ZipCode OR TARGET.Country <> SOURCE.Country 
    THEN UPDATE SET TARGET.LocationId = SOURCE.LocationId, TARGET.Street = SOURCE.Street , TARGET.City = SOURCE.City, TARGET.Region = SOURCE.Region, TARGET.ZipCode = SOURCE.ZipCode, TARGET.Country = SOURCE.Country
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (LocationId, Street, City, Region, ZipCode, Country) VALUES (SOURCE.LocationId, SOURCE.Street, SOURCE.City, SOURCE.Region, SOURCE.ZipCode, SOURCE.Country)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Device AS TARGET
  USING TIAE6_DT_Production.dbo.Device AS SOURCE 
    ON (TARGET.DeviceId = SOURCE.DeviceId)
  WHEN MATCHED AND TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.Name <> SOURCE.Name OR TARGET.Brand <> SOURCE.Brand OR TARGET.Type <> SOURCE.Type OR TARGET.Price <> SOURCE.Price 
    THEN UPDATE SET TARGET.DeviceId = SOURCE.DeviceId, TARGET.Name = SOURCE.Name , TARGET.Brand = SOURCE.Brand, TARGET.Type = SOURCE.Type, TARGET.Price = SOURCE.Price
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (DeviceId, Name, Brand, Type, Price) VALUES (SOURCE.DeviceId, SOURCE.Name, SOURCE.Brand, SOURCE.Type, SOURCE.Price)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.WareHouse AS TARGET
  USING TIAE6_DT_Production.dbo.WareHouse AS SOURCE 
    ON (TARGET.WareHouseId = SOURCE.WareHouseId)
  WHEN MATCHED AND TARGET.WareHouseId <> SOURCE.WareHouseId OR TARGET.Name <> SOURCE.Name OR TARGET.Phone <> SOURCE.Phone OR TARGET.Capacity <> SOURCE.Capacity OR TARGET.LocationId <> SOURCE.LocationId 
    THEN UPDATE SET TARGET.WareHouseId = SOURCE.WareHouseId, TARGET.Name = SOURCE.Name , TARGET.Phone = SOURCE.Phone, TARGET.Capacity = SOURCE.Capacity, TARGET.LocationId = SOURCE.LocationId
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (WareHouseId, Name, Phone, Capacity, LocationId) VALUES (SOURCE.WareHouseId, SOURCE.Name, SOURCE.Phone, SOURCE.Capacity, SOURCE.LocationId)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.SupplierDevice AS TARGET
  USING TIAE6_DT_Production.dbo.SupplierDevice AS SOURCE 
    ON (TARGET.SupplierDeviceId = SOURCE.SupplierDeviceId)
  WHEN MATCHED AND TARGET.SupplierDeviceId <> SOURCE.SupplierDeviceId OR TARGET.SupplierId <> SOURCE.SupplierId OR TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.PurchasePrice <> SOURCE.PurchasePrice 
    THEN UPDATE SET TARGET.SupplierDeviceId = SOURCE.SupplierDeviceId, TARGET.SupplierId = SOURCE.SupplierId , TARGET.DeviceId = SOURCE.DeviceId, TARGET.PurchasePrice = SOURCE.PurchasePrice
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (SupplierDeviceId, SupplierId, DeviceId, PurchasePrice) VALUES (SOURCE.SupplierDeviceId, SOURCE.SupplierId, SOURCE.DeviceId, SOURCE.PurchasePrice)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Store AS TARGET
  USING TIAE6_DT_Production.dbo.Store AS SOURCE 
    ON (TARGET.StoreId = SOURCE.StoreId)
  WHEN MATCHED AND TARGET.StoreId <> SOURCE.StoreId OR TARGET.Name <> SOURCE.Name OR TARGET.Phone <> SOURCE.Phone OR TARGET.LocationId <> SOURCE.LocationId 
    THEN UPDATE SET TARGET.StoreId = SOURCE.StoreId, TARGET.Name = SOURCE.Name , TARGET.Phone = SOURCE.Phone, TARGET.LocationId = SOURCE.LocationId
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (StoreId, Name, Phone, LocationId) VALUES (SOURCE.StoreId, SOURCE.Name, SOURCE.Phone, SOURCE.LocationId)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Customer AS TARGET
  USING TIAE6_DT_Production.dbo.Customer AS SOURCE 
    ON (TARGET.CustomerId = SOURCE.CustomerId)
  WHEN MATCHED AND TARGET.CustomerId <> SOURCE.CustomerId OR TARGET.FirstName <> SOURCE.FirstName OR TARGET.LastName <> SOURCE.LastName OR TARGET.Phone <> SOURCE.Phone OR TARGET.Birthdate <> SOURCE.Birthdate OR TARGET.Gender <> SOURCE.Gender OR TARGET.LocationId <> SOURCE.LocationId 
    THEN UPDATE SET TARGET.CustomerId = SOURCE.CustomerId, TARGET.FirstName = SOURCE.FirstName , TARGET.LastName = SOURCE.LastName, TARGET.Phone = SOURCE.Phone, TARGET.Birthdate = SOURCE.Birthdate, TARGET.Gender = SOURCE.Gender, TARGET.LocationId = SOURCE.LocationId
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (CustomerId, FirstName, LastName, Phone, Birthdate, Gender, LocationId) VALUES (SOURCE.CustomerId, SOURCE.FirstName, SOURCE.LastName, SOURCE.Phone, SOURCE.Birthdate, SOURCE.Gender, SOURCE.LocationId)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

MERGE TIAE6_DT_Staging.dbo.Contract AS TARGET
  USING TIAE6_DT_Production.dbo.Contract AS SOURCE 
    ON (TARGET.ContractId = SOURCE.ContractId)
  WHEN MATCHED AND TARGET.ContractId <> SOURCE.ContractId OR TARGET.CustomerId <> SOURCE.CustomerId OR TARGET.ServiceId <> SOURCE.ServiceId OR TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.StoreId <> SOURCE.StoreId OR TARGET.ContractSignDate <> SOURCE.ContractSignDate OR TARGET.ContractValidFrom <> SOURCE.ContractValidFrom OR TARGET.ContractValidTo <> SOURCE.ContractValidTo      
    THEN UPDATE SET TARGET.ContractId = SOURCE.ContractId, TARGET.CustomerId = SOURCE.CustomerId, TARGET.ServiceId = SOURCE.ServiceId, TARGET.DeviceId = SOURCE.DeviceId, TARGET.StoreId = SOURCE.StoreId, TARGET.ContractSignDate = SOURCE.ContractSignDate, TARGET.ContractValidFrom = SOURCE.ContractValidFrom, TARGET.ContractValidTo = SOURCE.ContractValidTo       
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (ContractId, CustomerId, ServiceId, DeviceId, StoreId, ContractSignDate, ContractValidFrom, ContractValidTo) VALUES (SOURCE.ContractId, SOURCE.CustomerId, SOURCE.ServiceId, SOURCE.DeviceId, SOURCE.StoreId, SOURCE.ContractSignDate, SOURCE.ContractValidFrom, SOURCE.ContractValidTo)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;


MERGE TIAE6_DT_Staging.dbo.DeviceWareHouse AS TARGET
  USING TIAE6_DT_Production.dbo.DeviceWareHouse AS SOURCE 
    ON (TARGET.DeviceWareHouseId = SOURCE.DeviceWareHouseId)
  WHEN MATCHED AND TARGET.DeviceWareHouseId <> SOURCE.DeviceWareHouseId OR TARGET.DeviceId <> SOURCE.DeviceId OR TARGET.WareHouseId <> SOURCE.WareHouseId OR TARGET.Amount <> SOURCE.Amount
    THEN UPDATE SET TARGET.DeviceWareHouseId = SOURCE.DeviceWareHouseId, TARGET.DeviceId = SOURCE.DeviceId, TARGET.WareHouseId = SOURCE.WareHouseId, TARGET.Amount = SOURCE.Amount
  WHEN NOT MATCHED BY TARGET 
    THEN INSERT (DeviceWareHouseId, DeviceId, WareHouseId, Amount) VALUES (SOURCE.DeviceWareHouseId, SOURCE.DeviceId, SOURCE.WareHouseId, SOURCE.Amount)
  WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;
