IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwExpenseSearch]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwExpenseSearch]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
SELECT   
   E.ExpenseId  
  ,E.ExpenseDate  
  ,E.PaymentTypeId  
  ,E.HouseId  
  ,E.PeriodId  
  ,E.ReferenceNo  
  ,E.Remark  
  ,E.SubTotalAmount  
  ,E.Tax  
  ,E.TotalAmount  
  ,E.RowStatus  
  ,E.CreatedBy  
  ,E.CreationDate  
  ,E.UpdatedBy  
  ,E.UpdatedDate   
  ,ED.ExpenseDetailStatusId  
  ,ED.TenantId
  ,T.FullName as TenantFullName  
  ,H.Name as HouseName  
  ,H.HouseTypeId
  ,ES.Name as ExpenseDetailStatusName  
  ,C.ConceptId  
  ,C.Description as ConceptName  
  ,PaymentType.Value as PaymentTypeName
  ,HouseType.Value as HouseTypeName
FROM Expense E      
  LEFT JOIN ExpenseDetail ED on E.ExpenseId = ED.ExpenseId  
  LEFT JOIN Tenant T ON T.TenantId = ED.TenantId      
  LEFT JOIN House H ON H.HouseId = E.HouseId      
  LEFT JOIN EntityStatus ES ON ED.ExpenseDetailStatusId = ES.EntityStatusId      
  LEFT JOIN Concept C ON C.ConceptId = ED.ConceptId  
  LEFT JOIN GeneralTable PaymentType ON PaymentType.GeneralTableId = E.PaymentTypeId  
  LEFT JOIN GeneralTable HouseType ON HouseType.GeneralTableId = H.HouseTypeId  

  
go