IF not EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwPermission]'))
    exec sp_executesql N'CREATE VIEW [dbo].[vwPermission]  AS SELECT 1 AS X'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwPermission]
AS

SELECT  P.PermissionId, P.AmigoTenantTRoleId, P.ActionId, A.Code
FROM	Permission P
RIGHT JOIN [Action] A ON P.ActionId = A.ActionId


GO
