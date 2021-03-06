IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAmigoTenantTServiceApproveRates]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwAmigoTenantTServiceApproveRates]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwAmigoTenantTServiceApproveRates]
AS 
SELECT STSVC.AmigoTenantTServiceId        ,
             RATE.RateId,
             ISNULL(RATE.PayDriver, 0) AS PayDriver,
             ISNULL(RATE.BillCustomer, 0) AS BillCustomer,
             RATE.PaidBy,
             ISNULL(STSVC.PayBy, 0) AS PayBy,
             SVC.Code as ServiceCode,
             SVC.Name as ServiceName,
             SVC.IsPerHour,
             SVC.IsPerMove,
             SVCTYPE.Code as ServiceTypeCode, 
             SVCTYPE.Name as ServiceTypeName,
             STSVC.ServiceStartDate AS ServiceStartDate, 
             STSVC.ServiceFinishDate AS ServiceFinishDate,
             CONVERT(DECIMAL(5,2), ISNULL(DATEDIFF(MI,STSVC.ServiceStartDate, STSVC.ServiceFinishDate), 0)/60.00) as TotalHours  
FROM   AmigoTenantTService STSVC
             INNER JOIN Rate RATE ON RATE.ServiceId = STSVC.ServiceId and RATE.RowStatus = 1
             LEFT JOIN Service SVC ON SVC.ServiceId = STSVC.ServiceId and SVC.RowStatus = 1
             LEFT JOIN ServiceType SVCTYPE ON SVCTYPE.ServiceTypeId = SVC.ServiceTypeId and SVCTYPE.RowStatus = 1
WHERE		STSVC.RowStatus = 1



GO
