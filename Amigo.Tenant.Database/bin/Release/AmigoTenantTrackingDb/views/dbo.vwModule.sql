IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwModule]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwModule]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwModule]
AS

       select  m.ModuleId,
                    m.Code, 
                    m.Name, 
                    m.URL, 
                    p.Code as 'ParentModuleCode', 
                    p.Name as 'ParentModuleName', 
                    m.SortOrder
       from dbo.Module m
             left join dbo.Module p on (m.ParentModuleId = p.moduleid and p.rowstatus = 1)
       where m.rowstatus = 1


GO

