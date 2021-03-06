IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwParentLocation]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwParentLocation]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwParentLocation]
AS

      -- the following records are parents
      SELECT 
                  p.code,
                  p.name
      FROM dbo.Location l
            inner join dbo.Location p on ( l.ParentLocationId = p.LocationId  and p.RowStatus = 1)
      where l.RowStatus = 1
                  and l.ParentLocationId is not null
      union
      -- the following records are not children (they are parents or potential parents)
      SELECT      l.Code,
                  l.Name 
      FROM dbo.Location l
      where l.RowStatus = 1
                  and l.ParentLocationId is null

GO
