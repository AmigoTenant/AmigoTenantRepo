IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwContract]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwContract]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwContract]    
AS    
SELECT ContractId,    
  C.BeginDate,    
  C.EndDate, 
  DATEDIFF(mm, C.BeginDate, C.EndDate) AS monthsNumber,
  C.RentDeposit,    
  C.RentPrice,    
  ContractDate,    
  PaymentModeId,    
  ContractStatusId,    
  C.PeriodId,    
  ContractCode,    
  ReferencedBy,    
  C.HouseId,    
  C.RowStatus,    
  C.CreatedBy,    
  C.CreationDate,    
  C.UpdatedBy,    
  C.UpdatedDate,    
  FrecuencyTypeId,    
  C.TenantId,    
  T.Code AS TenantCode,    
  T.FullName AS FullName,  
  H.Code AS HouseCode,  
  H.Name AS HouseName,
  ES.Code AS ContractStatusCode,  
  P.Code AS PeriodCode  
FROM Contract C    
  LEFT JOIN Tenant T ON T.TenantId = C.TenantId    
  LEFT JOIN House H ON H.HouseId = C.HouseId    
  LEFT JOIN EntityStatus ES ON C.ContractStatusId = ES.EntityStatusId    
  LEFT JOIN Period P ON P.PeriodId = C.PeriodId 

  go