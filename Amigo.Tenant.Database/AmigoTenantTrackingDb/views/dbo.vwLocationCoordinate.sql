IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLocationCoordinate]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwLocationCoordinate]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwLocationCoordinate]
AS


select		lc.LocationCoordinateId, 
			lc.latitude,
            lc.longitude,
            l.code as 'LocationCode',
            l.locationid as 'LocationId'
from dbo.LocationCoordinate lc
      inner join dbo.Location l on (lc.locationid = l.locationid)

GO
