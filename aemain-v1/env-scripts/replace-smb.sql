UPDATE
    arabe.dbo.DeployedArtifactFile
SET
    FileUrl = REPLACE(FileUrl, '10.142.0.7','aejenkins-v1.internal.aedemo-private.net')
WHERE
   FileUrl like '%10.142.0.7%';
UPDATE
     arabe.dbo.DeployedArtifactFile
SET
   FileUrl = REPLACE(FileUrl, 'AESRV1','aejenkins-v1.internal.aedemo-private.net')
WHERE
   FileUrl like '%AESRV1%'

UPDATE
       [arabe].[dbo].[DynPropVal]
   SET
       ExpressionValue = REPLACE(ExpressionValue, 'AESRV1','aejenkins-v1.internal.aedemo-private.net')
   WHERE
      ExpressionValue like '%AESRV1%';
