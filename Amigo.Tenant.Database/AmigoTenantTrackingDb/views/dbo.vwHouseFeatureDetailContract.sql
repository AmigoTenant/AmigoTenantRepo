IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwHouseFeatureDetailContract]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwHouseFeatureDetailContract]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     
              
ALTER VIEW vwHouseFeatureDetailContract  
AS                
                
SELECT ContractHouseDetailId,  
  C.ContractId,  
  C.HouseId,  
  CHD.HouseFeatureId,  
  CONVERT(Date, C.BeginDate) as BeginDate,  
  CONVERT(Date, C.EndDate) as EndDate  
FROM ContractHouseDetail CHD  
  LEFT JOIN Contract C ON C.ContractId = CHD.ContractId  and C.RowStatus = 1
    
  
  