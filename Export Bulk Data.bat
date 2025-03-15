set BCP_EXPORT_SERVER=LIN-JZJS7G3
set BCP_EXPORT_DB=AdventureWorksDW2022
set BCP_EXPORT_TABLE=FactResellerSales

BCP "DECLARE @colnames VARCHAR(max);SELECT @colnames = COALESCE(@colnames + '|', '') + column_name from %BCP_EXPORT_DB%.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='%BCP_EXPORT_TABLE%'; select @colnames;" queryout HEADER_Sample.CSV -c -T -S%BCP_EXPORT_SERVER%

BCP "SELECT * FROM %BCP_EXPORT_DB%.dbo.%BCP_EXPORT_TABLE%" queryout DATA_Sample.CSV -c -t "|" -T -S%BCP_EXPORT_SERVER%

set BCP_EXPORT_SERVER=
set BCP_EXPORT_DB=
set BCP_EXPORT_TABLE=

copy /b HEADER_Sample.CSV+DATA_Sample.CSV C:\Users\GBASAK\Downloads\Data_Export_Jobs\Exported_Files\ResellerSales.CSV

del HEADER_Sample.CSV
del DATA_Sample.CSV