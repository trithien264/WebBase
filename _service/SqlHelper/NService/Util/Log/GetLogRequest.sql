DB:DatabaseApp

SELECT [RequestID]
      ,[LogTime]
      ,[LogType]
	  ,[TotalTime]
      ,[RequestIP]
      ,[UserID]
      ,[Path]
      ,[RefUrl]
      ,[QueryString]
      ,[InputStream]
  FROM [dbo].[Meta_LogRequest]