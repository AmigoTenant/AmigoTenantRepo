IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwService]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwService]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwService]
AS

SELECT	
	serv.ServiceId
	,serv.Code
	,serv.Name
	,serv.IsPerMove
	,serv.IsPerHour
	,serv.ServiceTypeId
	,serv.RowStatus
	,servT.Code as 'ServiceTypeCode'
	,BlockRequiredCode
	,ProductRequiredCode
	,EquipmentRequiredCode
	,ChassisRequiredCode
	,DispatchingPartyRequiredCode
	,EquipmentStatusRequiredCode
	,BobtailAuthRequiredCode
	,HasH34RequiredCode
FROM dbo.[Service]  serv
	INNER JOIN dbo.ServiceType servT on (serv.ServiceTypeId = servT.ServiceTypeId and servT.rowstatus = 1)
where serv.rowstatus = 1
GO
