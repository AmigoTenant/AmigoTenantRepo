IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAmigoTenantTService]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwAmigoTenantTService]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwAmigoTenantTService]
AS 
SELECT --ISNULL(COSTC.Code, '')  AS CostCenterCode, 
             USR.UserName,
             EQPSIZE.Code AS EquipmentSizeCode,
             EQPTYPE.Code AS EquipmentTypeCode,
             EQPTYPE.Name AS EquipmentTypeName,
             SVC.Code AS ServiceCode              ,
             SVC.Name AS ServiceName              ,
             EQPSTATUS.Code AS EquipmentStatusCode,
             EQPSTATUS.Name AS EquipmentStatusName,
             LOCORI.Code as OriginLocationCode,
             LOCORI.Name as OriginLocationName,
             LOCDST.Code as DestinationLocationCode,
             LOCDST.Name as DestinationLocationName,
             PROD.Code AS ProductCode      ,
             DISP.Code AS DispatchingPartyCode,
             STSVC.AmigoTenantTServiceId        ,
             --STSVC.ServiceOrderNo           ,
             STSVC.ServiceStartDate         ,
			 STSVC.ServiceStartDateLocal    ,
             --STSVC.ServiceStartDateTZ       ,
             STSVC.ServiceFinishDate        ,
             --STSVC.ServiceFinishDateTZ      ,
             --STSVC.ServiceStartDateUTC      ,
             --STSVC.ServiceFinishDateUTC     ,
             STSVC.EquipmentNumber          ,
             STSVC.EquipmentTestDate25Year  ,
             STSVC.EquipmentTestDate5Year   ,
             STSVC.ChassisNumber            ,
             --STSVC.ChargeType               ,
             --STSVC.ShipmentID               ,
             STSVC.AuthorizationCode        ,
             STSVC.HasH34                   ,
             --STSVC.DetentionInMinutesReal   ,
             --STSVC.DetentionInMinutesRounded,
             STSVC.AcknowledgeBy            ,
             --STSVC.ServiceAcknowledgeDate   ,
             --STSVC.ServiceAcknowledgeDateTZ ,
             --STSVC.ServiceAcknowledgeDateUTC,
             --STSVC.IsAknowledged            ,
             STSVC.ApprovedBy               ,
             --STSVC.ApprovalDate             ,
             STSVC.ServiceStatus            ,
             --STSVC.ApprovalModified         ,
             STSVC.OriginLocationId         ,
             STSVC.DestinationLocationId    ,
             STSVC.DispatchingPartyId       ,
             STSVC.EquipmentSizeId          ,
             --STSVC.EquipmentTypeId          ,
             STSVC.EquipmentStatusId        ,
             --STSVC.CostCenterId                     ,
             STSVC.ProductId                ,
             PROD.Name                                      as ProductName,
             STSVC.ServiceId                                ,
             STSVC.AmigoTenantTUserId              ,           
             --STSVC.RowStatus                ,
             STSVC.CreatedBy                ,
             STSVC.CreationDate             ,
             STSVC.UpdatedBy                ,
             STSVC.UpdatedDate              ,
             STSVC.EquipmentTypeId,
             --'' as Approve                                ,
             STSVC.ChargeType                         ,
             STSVC.PayBy,
			 SVT.Code AS ServiceTypeCode,
             --CASE WHEN ISNULL(STSVC.PayBy, 'H') = 'H' THEN 'Y' ELSE 'N' END AS PayByDesc
			 STSVC.ChargeNo,
			 STSVC.DriverComments,
			 STSVC.ApprovalComments
FROM   AmigoTenantTService STSVC
             --LEFT JOIN CostCenter COSTC ON COSTC.CostCenterId = STSVC.CostCenterId
             LEFT JOIN EquipmentSize EQPSIZE ON EQPSIZE.EquipmentSizeId = STSVC.EquipmentSizeId
             LEFT JOIN Service SVC ON SVC.ServiceId = STSVC.ServiceId
			 LEFT JOIN dbo.ServiceType SVT ON SVT.ServiceTypeId = SVC.ServiceTypeId
             LEFT JOIN EquipmentStatus EQPSTATUS ON EQPSTATUS.EquipmentStatusId = STSVC.EquipmentStatusId
             LEFT JOIN Location LOCORI ON LOCORI.LocationId = STSVC.OriginLocationId
             LEFT JOIN Location LOCDST ON LOCDST.LocationId = STSVC.DestinationLocationId
             LEFT JOIN Product PROD ON PROD.ProductId = STSVC.ProductId
             LEFT JOIN DispatchingParty DISP ON DISP.DispatchingPartyId = STSVC.DispatchingPartyId
             LEFT JOIN AmigoTenantTUser USR ON USR.AmigoTenantTUserId = STSVC.AmigoTenantTUserId
             LEFT JOIN EquipmentType EQPTYPE ON EQPTYPE.EquipmentTypeId = STSVC.EquipmentTypeId
WHERE		STSVC.RowStatus = 1
GO
