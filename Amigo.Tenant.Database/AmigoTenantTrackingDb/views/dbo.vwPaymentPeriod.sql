ALTER VIEW [dbo].[vwPaymentPeriod]    
    
AS    
    
     
 SELECT PaymentPeriodId      ,    
   --PP.ConceptId            ,    
   PP.ContractId           ,    
   PP.TenantId             ,    
   PP.PeriodId             ,    
   P.Code as PeriodCode             ,    
   PaymentAmount        ,    
   PP.DueDate              ,    
   PP.PaymentDate,  
   --PP.RowStatus            ,    
   --PP.CreatedBy            ,    
   --PP.CreationDate         ,    
   --PP.UpdatedBy            ,    
   --PP.UpdatedDate          ,    
   PaymentPeriodStatusId,    
   C.ContractCode,    
   H.Name as HouseName,    
   C.HouseId,    
   --H.Address as HouseAddress,    
   T.FullName as TenantFullName,    
   --ES.Code as EntityStatusCode,    
   ES.Code as PaymentPeriodStatusCode,    
   ES.Name as PaymentPeriodStatusName,    
   --PP.PaymentTypeId,    
   ISNULL(PaymentPending.ServicesPending, 0) AS ServicesPending,    
   ISNULL(PaymentPending.FinesPending, 0) AS FinesPending,    
   CASE     
    WHEN ISNULL(PaymentPending.LateFeesPending, 0) > 0 THEN PaymentPending.LateFeesPending      
    WHEN DATEDIFF(DD, P.DueDate, GETDATE()) > 0 AND ES.Code = 'PPPENDING' THEN  1 ELSE 0       
      END AS LateFeesPending,     
   ISNULL(PaymentPending.DepositPending, 0) AS DepositPending,    
    
   PaymentAmountPending.DepositAmountPending,    
   PaymentAmountPending.ServicesAmountPending,    
   PaymentAmountPending.FinesAmountPending,    
         
   CASE 
	WHEN ES.Code = 'PPPENDING' AND DATEDIFF(DD, P.DueDate, GETDATE()) > 0
		 THEN  DATEDIFF(DD, P.DueDate, GETDATE()) * 25
	WHEN ES.Code = 'PPPAYED' AND PP.PaymentDate > P.DueDate AND ISNULL(LateFeePayed.LateFeePayedCount, 0) = 0
		 THEN DATEDIFF(DD, P.DueDate, GETDATE()) * 25
	WHEN ISNULL(PaymentPending.LateFeesPending, 0) > 0
		 THEN PaymentAmountPending.LateFeesAmountPending
	ELSE 0 END LateFeesAmountPending,
   
   PaymentAmountPending.OnAccountAmountPending  
    
 FROM PaymentPeriod PP    
   INNER JOIN Contract C ON C.ContractId = PP.ContractId    
   INNER JOIN House H ON h.HouseId = C.HouseId    
   INNER JOIN Tenant T ON T.TenantId = C.TenantId    
   INNER JOIN EntityStatus ES ON ES.EntityStatusId = PP.PaymentPeriodStatusId    
   INNER JOIN GeneralTable GT ON GT.GeneralTableId = PP.PaymentTypeId AND GT.Code = 'RENT'    
   INNER JOIN Period P ON P.PeriodId = PP.PeriodId     
    
    
    
   CROSS APPLY    
   (    
    SELECT   
   SUM(ISNULL(CASE WHEN GT1.Code = 'SERVICE' THEN 1 ELSE 0 END, 0)) AS ServicesPending,    
      SUM(ISNULL(CASE WHEN GT1.Code = 'FINE' THEN 1 ELSE 0 END, 0)) AS FinesPending,    
      SUM(ISNULL(CASE WHEN GT1.Code = 'LATEFEE' THEN 1 ELSE 0 END, 0)) AS LateFeesPending,    
      SUM(ISNULL(CASE WHEN GT1.Code = 'DEPOSIT' THEN 1 ELSE 0 END, 0)) AS DepositPending,  
	  SUM(ISNULL(CASE WHEN GT1.Code = 'ONACCOUNT' THEN 1 ELSE 0 END, 0)) AS OnAccountPending  
    FROM PaymentPeriod PP1    
      INNER JOIN GENERALTABLE GT1 ON GT1.GeneralTableId = PP1.PaymentTypeId    
   INNER JOIN EntityStatus ES1 ON ES1.EntityStatusId = PP1.PaymentPeriodStatusId    
    WHERE PP1.ContractId = PP.ContractId  AND     
      PP1.PeriodId = PP.PeriodId  AND     
      GT1.Code not in ('RENT') AND    
      ES1.Code = 'PPPENDING'    
   ) AS PaymentPending    
    
   CROSS APPLY      
   (      
    SELECT     COUNT(1) AS LateFeePayedCount
    FROM PaymentPeriod PP1      
      INNER JOIN GENERALTABLE GT1 ON GT1.GeneralTableId = PP1.PaymentTypeId      
      INNER JOIN EntityStatus ES1 ON ES1.EntityStatusId = PP1.PaymentPeriodStatusId      
    WHERE PP1.ContractId = PP.ContractId  AND       
      PP1.PeriodId = PP.PeriodId  AND       
      GT1.Code = 'LATEFEE' AND      
      ES1.Code = 'PPPAYED'      
   ) AS LateFeePayed  
   
   
   CROSS APPLY        
   (        
    SELECT   
   SUM(ISNULL(CASE WHEN GT1.Code = 'SERVICE' THEN PaymentAmount ELSE 0 END, 0)) AS ServicesAmountPending,      
      SUM(ISNULL(CASE WHEN GT1.Code = 'FINE' THEN PaymentAmount ELSE 0 END, 0)) AS FinesAmountPending,      
      SUM(ISNULL(CASE WHEN GT1.Code = 'LATEFEE' THEN PaymentAmount ELSE 0 END, 0)) AS LateFeesAmountPending,      
      SUM(ISNULL(CASE WHEN GT1.Code = 'DEPOSIT' THEN PaymentAmount ELSE 0 END, 0)) AS DepositAmountPending,    
	  SUM(ISNULL(CASE WHEN GT1.Code = 'ONACCOUNT' THEN PaymentAmount ELSE 0 END, 0)) AS OnAccountAmountPending    
    FROM PaymentPeriod PP1      
      INNER JOIN GENERALTABLE GT1 ON GT1.GeneralTableId = PP1.PaymentTypeId      
   INNER JOIN EntityStatus ES1 ON ES1.EntityStatusId = PP1.PaymentPeriodStatusId    
    WHERE PP1.ContractId = PP.ContractId  AND       
      PP1.PeriodId = PP.PeriodId  AND       
      GT1.Code not in ('RENT') AND      
      ES1.Code = 'PPPENDING'      
   ) AS PaymentAmountPending      
   
   