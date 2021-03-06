
IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwContractHouseDetail]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwContractHouseDetail]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwContractHouseDetail]
AS
SELECT	ContractHouseDetailId,
		ContractId,
		CHD.HouseFeatureId,
		CHD.RowStatus,
		CHD.CreatedBy,
		CHD.CreationDate,
		CHD.UpdatedBy,
		CHD.UpdatedDate,
		F.Code AS FeatureCode,
		F.Description AS FeatureDescription
FROM	ContractHouseDetail CHD
		LEFT JOIN HouseFeature HF ON HF.HouseFeatureId = CHD.HouseFeatureId
		LEFT JOIN Feature F ON F.FeatureId = HF.FeatureId


GO
