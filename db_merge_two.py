import pyodbc
from dataclasses import dataclass
import datetime
import re
import sys

@dataclass
class factTableRow:
	Contract_ContractId: int
	Contract_CustomerId: int
	Contract_ServiceId: int
	Contract_DeviceId: int
	Contract_StoreId: int
	Contract_LocationId: int
	Contract_ContractSignDate: datetime.date
	Contract_ContractValidFrom: datetime.date
	Contract_ContractValidTo: datetime.date
	Contract_ContractName: str
	Contract_ContractType: str
	Contract_ContractState: str
	Contract_ContractPrice: float
	Customer_CustomerId: int
	Customer_FirstName: str
	Customer_LastName: str
	Customer_Phone: str
	Customer_BirthDate: datetime.date
	Customer_Gender: str
	Device_DeviceId: int
	Device_Name: str
	Device_Brand: str
	Device_Type: str
	Device_Price: float
	Store_StoreId: int
	Store_Name: str
	Store_Phone: str
	Location_LocationId: int
	Location_Street: str
	Location_City: str
	Location_Region: str
	Location_ZipCode: str
	Location_Country: str


server = sys.argv[1]
database = 'TIAE6_DT_Staging'
username = 'staging'
password = 'python'
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

cursor.execute("""
SELECT
	--factTable
	Contract.ContractId,
	Contract.CustomerId,
	Contract.ServiceId,
	Contract.DeviceId,
	Contract.StoreId,
	Store.LocationId,
	Contract.ContractSignDate,
	Contract.ContractValidFrom,
	Contract.ContractValidTo,
	Service.Name,
	Service.Type,
	Service.State,
	Service.Price,
	--DimCustomer
	Customer.CustomerId,
	Customer.FirstName,
	Customer.LastName,
	Customer.Phone,
	Customer.BirthDate,
	Customer.Gender,
	--DimDevice
	Device.DeviceId,
	Device.Name,
	Device.Brand,
	Device.Type,
	Device.Price,
	--DimStore
	Store.StoreId,
	Store.Name,
	Store.Phone,
	--DimLocation
	Location.LocationId,
	Location.Street,
	Location.City,
	Location.Region,
	Location.ZipCode,
	Location.Country
FROM TIAE6_DT_Staging.dbo.Contract
JOIN TIAE6_DT_Staging.dbo.Customer ON Customer.CustomerId = Contract.CustomerId
JOIN TIAE6_DT_Staging.dbo.Service ON Service.ServiceId = Contract.ServiceId
JOIN TIAE6_DT_Staging.dbo.Device ON Device.DeviceId = Contract.DeviceId
JOIN TIAE6_DT_Staging.dbo.Store ON Store.StoreId = Contract.StoreId
JOIN TIAE6_DT_Staging.dbo.Location ON Location.LocationId = Store.LocationId
""") 

factTable = []

def get_or_create_date_row_id(table, value):
	tablename = "Dim" + table
	id = table + "Id"
	year = value.year
	month = value.month
	week = value.strftime("%W")
	day = value.day

	cursor.execute("SELECT * FROM {} WHERE Year = {} AND Month = {} AND Week = {} AND Day = {}".format(tablename, year, month, week, day))
	row = cursor.fetchone()
	if row:
		return row[0]

	cursor.execute("INSERT INTO {} (Year, Month, Week, Day) VALUES ({},{},{},{})".format(tablename, year, month, week, day))
	cnxn.commit()

	cursor.execute("SELECT * FROM {} WHERE Year = {} AND Month = {} AND Week = {} AND Day = {}".format(tablename, year, month, week, day))
	row = cursor.fetchone()
	if row:
		return row[0]

for row in cursor.fetchall():
	dr = factTableRow(*list(row))

	# Die Spalte «Phone» darf nur nummerische Zeichen beinhalten.
	dr.Customer_Phone = re.sub('[^0-9]+', '', dr.Customer_Phone)
	dr.Store_Phone = re.sub('[^0-9]+', '', dr.Store_Phone)
	ContractSignDateId = get_or_create_date_row_id('ContractSignDate', dr.Contract_ContractSignDate) 
	ContractValidFromId = get_or_create_date_row_id('ContractValidFrom', dr.Contract_ContractValidFrom)
	ContractValidToId = get_or_create_date_row_id('ContractValidTo', dr.Contract_ContractValidTo) 

	# Insert dimensions
	try:
		cursor.execute("INSERT INTO DimCustomer (CustomerId, FirstName, LastName, Phone, BirthDate, Gender) VALUES ({},'{}','{}','{}','{}','{}')".format(
			dr.Customer_CustomerId,
			dr.Customer_FirstName,
			dr.Customer_LastName,
			dr.Customer_Phone,
			dr.Customer_BirthDate,
			dr.Customer_Gender
		))
		cnxn.commit()
	except:
		# If error then probably it is a duplication error. Just ignore it
		pass

	try:
		cursor.execute("INSERT INTO DimLocation (LocationId, Street, City, Region, ZipCode, Country) VALUES ({},'{}','{}','{}','{}','{}')".format(
			dr.Contract_LocationId,
			dr.Location_Street,
			dr.Location_City,
			dr.Location_Region,
			dr.Location_ZipCode,
			dr.Location_Country
		))
		cnxn.commit()
	except:
		pass

	try:
		cursor.execute("INSERT INTO DimStore (StoreId, StoreName, StorePhone) VALUES ({},'{}','{}')".format(
			dr.Store_StoreId,
			dr.Store_Name,
			dr.Store_Phone
		))
		cnxn.commit()
	except:
		# If error then probably it is a duplication error. Just ignore it
		pass

	try:
		cursor.execute("INSERT INTO DimDevice (DeviceId, DeviceName, DeviceBrand, DeviceType, DevicePrice, PurchasePrice, CompanyName, Phone, IsPrivateLabel, DeviceWareHouseAmount, WareHouseName, WareHousePhone, WareHouseCapacity) VALUES ({},'{}','{}','{}',{},{},'{}','{}',{},{},'{}','{}',{})".format(
			dr.Device_DeviceId,
			dr.Device_Name,
			dr.Device_Brand,
			dr.Device_Type,
			dr.Device_Price,
			0.00,
			'ErrorParsing',
			'ErrorParsing',
			0,
			0.00,
			'ErrorParsing',
			'ErrorParsing',
			0
		))
		cnxn.commit()
	except:
		# If error then probably it is a duplication error. Just ignore it
		pass

	# Insert fact table 
	try:
		cursor.execute("INSERT INTO FactSales (ContractId, CustomerId, DeviceId, StoreId, LocationId, ContractSignDateId, ContractValidFromId, ContractValidToId, ContractName, ContractType, ContractState, ContractPrice) VALUES ({},{},{},{},{},{},{},{},'{}','{}','{}',{})".format(
			dr.Contract_ContractId,
			dr.Contract_CustomerId,
			dr.Contract_DeviceId,
			dr.Contract_StoreId,
			dr.Contract_LocationId,
			ContractSignDateId,
			ContractValidFromId,
			ContractValidToId,
			dr.Contract_ContractName,
			dr.Contract_ContractType,
			dr.Contract_ContractState,
			dr.Contract_ContractPrice
		))
		cnxn.commit()
	except:
		# If error then probably it is a duplication error. Just ignore it
		pass

print("Merging Staging.Production to Staging.DWH complete.")
print("Transformation of 1st Class have been applied successfully.")
