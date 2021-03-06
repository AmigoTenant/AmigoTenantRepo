IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwFeature]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwFeature]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwFeature]
AS

SELECT	
	FeatureId
	,F.Code
	,F.Description
	,Measure
	,F.RowStatus
	,F.CreatedBy
	,F.CreationDate
	,F.UpdatedBy
	,F.UpdatedDate
	,F.Sequence
	,IsAllHouse
	,HouseTypeId
	,g.Code as HouseTypeCode
FROM dbo.[Feature]  F
	INNER JOIN dbo.GeneralTable g on (g.GeneralTableId = F.HouseTypeId )
where f.rowstatus = 1
GO

