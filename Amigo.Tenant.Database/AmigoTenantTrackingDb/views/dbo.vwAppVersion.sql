IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAppVersion]'))
exec sp_executesql N'CREATE VIEW [dbo].[vwAppVersion]  AS 
SELECT 1 AS X'
GO

ALTER VIEW [dbo].[vwAppVersion]
AS

      select v.AppVersionId, 
                  v.[Version] as 'VersionNumber', 
                  v.Name 
      from AppVersion v
      where v.RowStatus = 1

GO
