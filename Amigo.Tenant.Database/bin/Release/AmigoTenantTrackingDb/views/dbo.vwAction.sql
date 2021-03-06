IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwAction]'))
exec sp_executesql N'CREATE VIEW [dbo].[vwAction]  AS 
SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwAction]
AS

      select
      a.ActionId,
       a.Code, 
                  a.Name, 
                  a.[Description], 
                  a.[type], 
                  m.Code as 'ModuleCode'
      from [Action] a
            inner join Module m on (m.ModuleId = a.ModuleId)
      where a.rowstatus = 1


GO
