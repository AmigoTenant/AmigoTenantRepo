IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwOSVersion]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwOSVersion]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwOSVersion]
AS

      select p.PlatformId,
                  p.Name as 'PlatformName',
                  v.OSVersionId,
                  v.[Version] as 'VersionNumber',
                  v.Name as 'VersionName'
                  
      from [Platform] p
            inner join OSVersion v on (p.PlatformId = v.PlatformId and v.RowStatus = 1)
      where p.RowStatus = 1

GO
