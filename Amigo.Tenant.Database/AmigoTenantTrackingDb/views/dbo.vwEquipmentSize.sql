IF not  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwEquipmentSize]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwEquipmentSize]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwEquipmentSize]
AS
      select      s.EquipmentSizeId, 
                s.Code, 
                s.Name, 
                s.EquipmentTypeId, 
                s.RowStatus,
                t.Code as 'EquipmentTypeCode'
      from EquipmentSize s
            inner join EquipmentType t on (s.EquipmentTypeId = t.EquipmentTypeId and t.RowStatus = 1)
      where s.RowStatus = 1

GO
