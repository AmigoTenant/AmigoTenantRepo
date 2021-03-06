IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAmigoTenantTServiceReport]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwAmigoTenantTServiceReport]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
 
ALTER VIEW [dbo].[vwAmigoTenantTServiceReport]
AS



select s.AmigoTenantTUserId,
		u.username,
		s.EquipmentNumber,
		ez.Code as 'EquipmentSizeCode',
		ez.Name as 'EquipmentSize',
		et.Code as 'EquipmentTypeCode',
		et.Name as 'EquipmentType',
		sv.Code as 'ServiceCode',
		sv.Name as 'Service',
		p.ShortName as 'Product',
		p.IsHazardous,
		s.ChargeType,
		lo.Code as 'OriginBlockCode',
		lo.Name as 'OriginBlock',
		ld.Code as 'DestinationBlockCode',
		ld.Name as 'DestinationBlock',
		s.ApprovedBy as 'Approver', 
		s.ServiceStatus, 
		dp.Name as 'DispatchingParty',
		s.servicestartdate,
		s.servicefinishdate,
		sc.CustomerBill,
		sc.DriverPay,
		es.Name AS 'EquipmentStatusName',
		ISNULL(s.ChargeNo,'') AS ChargeNo,
		s.DriverComments,
		s.servicestartdateLocal,
		s.EquipmentStatusId,
		p.ProductId,
		u.FirstName + ' ' + u.LastName AS Drivername,
		'' AS ChassisNo
from	dbo.AmigoTenantTService s
		left join dbo.AmigoTenantTUser u on (s.AmigoTenantTUserId = u.AmigoTenantTUserId and u.rowstatus = 1)
		left join dbo.EquipmentSize ez on (s.EquipmentSizeId = ez.EquipmentSizeId and ez.rowstatus = 1)
		left join dbo.EquipmentType et on (s.EquipmentTypeId = et.EquipmentTypeId and et.rowstatus = 1)
		left join dbo.[Service] sv on (s.ServiceId = sv.ServiceId and sv.rowstatus = 1)
		left join dbo.Product p on (s.ProductId = p.ProductId and p.rowstatus = 1)
		left join dbo.Location lo on (s.OriginLocationId = lo.LocationId and lo.rowstatus = 1)
		left join dbo.Location ld on (s.DestinationLocationId = ld.LocationId and ld.rowstatus = 1)
		left join dbo.DispatchingParty dp on  (s.DispatchingPartyId = dp.DispatchingPartyId and dp.rowstatus = 1)
		left join dbo.AmigoTenantTServiceCharge sc on (s.AmigoTenantTServiceId = sc.AmigoTenantTServiceId and sc.rowstatus = 1)
		LEFT JOIN dbo.EquipmentStatus es ON es.EquipmentStatusId = s.EquipmentStatusId
where	s.rowstatus = 1
UNION				 
select  dr.DriverUserId as AmigoTenantTUserId,  
		u.username,  
		'' as EquipmentNumber,  
		'' as 'EquipmentSizeCode',  
		'' as 'EquipmentSize',  
		'' as 'EquipmentTypeCode',  
		'' as 'EquipmentType',  
		Serv.Code as 'ServiceCode',  
		Serv.Name as 'Service',  
		'' as 'Product',  
		'' as 'IsHazardous',  
		'' as 'ChargeType',  
		'' as 'OriginBlockCode',  
		'' as 'OriginBlock',  
		'' as 'DestinationBlockCode',  
		'' as 'DestinationBlock',  
		dr.ApproverSignature as 'Approver',   
		1 as ServiceStatus,   
		'' as 'DispatchingParty',  
		CONVERT(DateTimeOffSet,DR.StartTime) as servicestartdate,  
		CONVERT(DateTimeOffSet,DR.FinishTime) as servicefinishdate,  
		sc.CustomerBill,
		sc.DriverPay, 
		'' as 'EquipmentStatusName',  
		'' as ChargeNo,  
		'Total Hours: ' + LTRIM(dr.TotalHours) as DriverComments,  
		DR.ReportDate as ServiceStartDateLocal ,
		0 AS 'EquipmentStatusId',
		0 AS 'ProductId',
		u.FirstName + ' ' + u.LastName AS Drivername,
		'' AS 'ChassisNo'
from	DriverReport dr 
		inner join dbo.AmigoTenantTServiceCharge sc on (dr.DriverReportId = sc.DriverReportId and dr.RowStatus = 1)
		left join dbo.AmigoTenantTUser u on (	dr.DriverUserId = u.AmigoTenantTUserId and u.rowstatus = 1)  
		cross apply (Select ServiceId, Code, Name FROM Service WHERE Code='HOU') as Serv
where	sc.AmigoTenantTServiceId is null

GO
