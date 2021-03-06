IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwActivityEventLog]'))
exec sp_executesql N'CREATE VIEW [dbo].[vwActivityEventLog]  AS 
SELECT 1 AS X'

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwActivityEventLog]
AS 
SELECT   
      STLOG.AmigoTenantTEventLogId,  
      STLOG.ActivityTypeId,   
      ACTTYPE.Name AS ActivityName,  
      STLOG.Username,  
      STLOG.Latitude,  
      STLOG.Longitude,  
      STLOG.ReportedActivityDate,  
      --STLOG.CostCenterId,  
      --COSTCENT.Name AS CostCenterName,  
      STLOG.LocationProvider,  
      STLOG.RowStatus,  
	  STLOG.CreatedBy             ,  
	  STLOG.CreationDate          ,  
	  STLOG.UpdatedBy             ,  
	  STLOG.UpdatedDate           ,  
	  --STLOG.ShipmentID                  ,  
	  --COSTCENT.Code AS CostCenterCode,  
	  --(CASE WHEN ISNULL(STLOG.ShipmentID, '') = '' THEN COSTCENT.Code ELSE STLOG.ShipmentID END) 'ChargeNumber',  
	  STSER.OriginLocationId,  
	  ORILOC.Name AS 'OriginLocationName',  
	  STSER.DestinationLocationId,  
	  DESLOC.Name AS 'DestinationLocationName',  
	  STSER.EquipmentNumber,
	  PRD.Name AS 'ProductName',           
	  STLOG.ChargeNo,
	  STLOG.Parameters,
	  STLOG.LogType
FROM AmigoTenantTEventLog STLOG  
      INNER JOIN ActivityType ACTTYPE ON STLOG.ActivityTypeId = ACTTYPE.ActivityTypeId  
      --LEFT JOIN CostCenter COSTCENT ON STLOG.CostCenterId = COSTCENT.CostCenterId  
      LEFT JOIN AmigoTenantTService STSER ON STLOG.AmigoTenantTServiceId = STSER.AmigoTenantTServiceId  
      LEFT JOIN Location ORILOC ON STSER.OriginLocationId = ORILOC.LocationId  
      LEFT JOIN Location DESLOC ON STSER.DestinationLocationId = DESLOC.LocationId  
	  LEFT JOIN dbo.Product PRD ON PRD.ProductId = STSER.ProductId


GO
