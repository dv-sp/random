DECLARE @APOIO TABLE (
[JOB_ID] VARCHAR (100),[JOB_NAME] VARCHAR (100),[RUN_STATUS] INT,[RUN_DATE] VARCHAR (100),
[RUN_TIME] VARCHAR (100),[RUN_DURATION] VARCHAR (100),[OPERATOR_EMAILED] VARCHAR (100),
[OPERATOR_NETSENT] VARCHAR (100),[OPERATOR_PAGED] VARCHAR (100),[RETRIES_ATTEMPTED] VARCHAR (100),
[SERVER] VARCHAR (100))


INSERT INTO @APOIO EXEC MSDB.DBO.SP_HELP_JOBHISTORY @JOB_NAME='JOB_EXECUTA_PACOTES_SSIS'

SELECT
TOP 1
CONVERT(DATETIME,
CASE
	WHEN LEN([RUN_TIME]) = 6 THEN CONCAT(LEFT([RUN_DATE],4),'-', RIGHT(LEFT([RUN_DATE],6),2),'-',RIGHT([RUN_DATE],2),' ',LEFT([RUN_TIME],2),':', LEFT(RIGHT([RUN_TIME],4),2),':',RIGHT([RUN_TIME],2) )
	WHEN LEN([RUN_TIME]) = 5 THEN CONCAT(LEFT([RUN_DATE],4),'-', RIGHT(LEFT([RUN_DATE],6),2),'-',RIGHT([RUN_DATE],2),' ',LEFT([RUN_TIME],1),':', LEFT(RIGHT([RUN_TIME],4),2),':',RIGHT([RUN_TIME],2) )
END) AS DATETIME,
[JOB_NAME],
[RUN_DURATION],
[RUN_STATUS]
FROM @APOIO
ORDER BY DATETIME DESC