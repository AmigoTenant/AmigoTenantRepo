IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwLatestPosition]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwLatestPosition]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwLatestPosition]
AS

      select      el.AmigoTenantTEventLogId,
				  at.Name as 'ActivityTypeName',
                  at.Code as 'ActivityTypeCode',
                  el.Username,
                  u.AmigoTenantTUserId, 
                  u.TractorNumber,
                  el.reportedActivityDate,
                  el.ReportedActivityTimeZone,
                  el.Latitude,
                  el.Longitude,
                  --el.ShipmentID,
                  --el.CostCenterCode,
                  u.FirstName,
                  u.LastName,
				  el.ChargeNo
      from dbo.AmigoTenantTEventLog el
            inner join dbo.ActivityType at on ( el.activitytypeid = at.activitytypeid and at.rowstatus = 1)
            left join dbo.AmigoTenantTUser u on (el.username = u.username and u.rowstatus = 1)
      where el.rowstatus = 1
                  and el.Latitude <> 0 and el.Latitude <> -1
                  and el.Longitude <> 0 and el.Longitude <> -1



GO
