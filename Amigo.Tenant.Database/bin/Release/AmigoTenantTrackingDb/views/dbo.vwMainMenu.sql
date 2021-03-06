IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwMainMenu]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwMainMenu]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwMainMenu]
AS 
SELECT 
      STUSER.AmigoTenantTUserId AS 'UserId'        , 
      STROLE.AmigoTenantTRoleId AS 'RoleId'        , 
      ACT.ActionId                                         , 
      PER.PermissionId                               ,
      MOD.ModuleId                                         , 
      MOD.Name AS 'ModuleName'                       , 
      MOD.ParentModuleId                                   ,
      PARENTMOD.Name AS 'ParentModuleName'                            ,
      MOD.URL AS Url,
      ACT.Code AS ActionCode,
      MOD.SortOrder,
      PARENTMOD.SortOrder AS ParentSortOrder,
      MOD.Code as ModuleCode,
      PARENTMOD.Code as ParentModuleCode      
FROM AmigoTenantTUser STUSER
INNER JOIN AmigoTenantTRole STROLE ON STUSER.AmigoTenantTRoleId = STROLE.AmigoTenantTRoleId
INNER JOIN Permission PER ON STUSER.AmigoTenantTRoleId = PER.AmigoTenantTRoleId
INNER JOIN Action ACT ON PER.ActionId = ACT.ActionId
INNER JOIN Module MOD ON ACT.ModuleId = MOD.ModuleId
LEFT JOIN Module PARENTMOD ON MOD.ParentModuleId = PARENTMOD.ModuleId

WHERE STROLE.RowStatus = 1

GO

