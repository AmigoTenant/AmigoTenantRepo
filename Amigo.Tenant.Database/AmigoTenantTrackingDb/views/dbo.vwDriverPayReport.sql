IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwDriverPayReport]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwDriverPayReport]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwDriverPayReport]

AS
SELECT	ISNULL(USR.Username, '') AS Driver,
		DRVRPT.DriverUserId, 
		ISNULL(USR.DedicatedLocationId, '') AS DedicatedLocationId,
		ISNULL(LOC.Code, '') AS DedicatedLocationCode,
		DRVRPT.ReportDate,
		SUM(ISNULL(DRVRPT.DayPayDriverTotal,0)) AS DayPayDriverTotal
FROM	DriverReport DRVRPT
		LEFT JOIN AmigoTenantTUser USR ON DRVRPT.DriverUserId = usr.AmigoTenantTUserId
		LEFT JOIN Location LOC ON LOC.LocationId = usr.DedicatedLocationId
GROUP BY ISNULL(USR.Username, ''),
		DRVRPT.DriverUserId, 
		ISNULL(USR.DedicatedLocationId, ''),
		ISNULL(LOC.Code, ''),
		DRVRPT.ReportDate

GO
