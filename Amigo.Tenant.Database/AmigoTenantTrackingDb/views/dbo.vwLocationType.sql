IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLocationType]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwLocationType]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwLocationType]  
AS  
  
SELECT Code, Name
FROM dbo.LocationType  
where RowStatus = 1  
  
  


GO
