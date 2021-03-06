IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwPaymentPeriodByContract]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwPaymentPeriodByContract]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwPaymentPeriodByContract]  
AS  
   
SELECT PP.PaymentPeriodId      ,  
   PP.PeriodId             ,    
   P.Code as PeriodCode,    
   H.Name as HouseName,    
   T.FullName as TenantFullName,    
   GT.Value as PaymentTypeValue,    
   GT.Code as PaymentTypeCode,      
   CPTO.Description as PaymentDescription,    
   PaymentAmount        ,    
   ES.Name as PaymentPeriodStatusName,    
   ES.Code as PaymentPeriodStatusCode,    
    
   PP.ConceptId,    
   PP.ContractId,    
   PP.TenantId,    
   PP.PaymentTypeId,    
   PP.DueDate,    
   PP.RowStatus,    
   PP.CreatedBy,    
   PP.CreationDate,    
   PP.UpdatedBy,    
   PP.UpdatedDate,    
   PP.PaymentPeriodStatusId,    
   PATINDEX('%'+CPTO.Code+'%', (SELECT AppSettingValue FROM AppSetting WHERE Code = 'CPTSREQPAY' AND RowStatus = 1)) AS IsRequired,    
   P.DueDate as periodDueDate,    
   GT.Sequence as PaymentTypeSequence,    
   PP.PaymentDate,    
   INVDET.InvoiceId,  
   INVDET.InvoiceDetailId,  
   INV.InvoiceNo,  
   INV.InvoiceDate , 
   T.Email
 FROM PaymentPeriod PP    
   INNER JOIN Contract C ON C.ContractId = PP.ContractId    
   INNER JOIN House H ON h.HouseId = C.HouseId    
   INNER JOIN Tenant T ON T.TenantId = C.TenantId    
   INNER JOIN EntityStatus ES ON ES.EntityStatusId = PP.PaymentPeriodStatusId    
   INNER JOIN GeneralTable GT ON GT.GeneralTableId = PP.PaymentTypeId     
   INNER JOIN Period P ON P.PeriodId = PP.PeriodId     
   INNER JOIN Concept CPTO ON CPTO.ConceptId = PP.ConceptId     
   LEFT JOIN InvoiceDetail INVDET ON INVDET.PaymentPeriodId = PP.PaymentPeriodId  
   LEFT JOIN Invoice INV ON INV.InvoiceId = INVDET.InvoiceId  
   
GO
