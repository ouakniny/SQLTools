--Shows the trace table when the first column is runtime in seconds (change the datediff to minutes if more convinient)
SELECT datediff(minute,StartTime,EndTime),*
FROM [Monitor].[dbo].[Trace_PROD_20191205]
where StartTime between '2019-12-05 05:45:00.000' and '2019-12-05 11:18:00.000'
order by 1 desc

--show currently running queries 
select * from sys.dm_exec_requests r
where session_id in (69,76)
or blocking_session_id in (69,76)

--insert error log to table (change\delete the filter - last parameter)
create table SQL_Error_Log (LogDate DATETIME, SessionID VARCHAR(15), TextMessage VARCHAR(4000));
insert into SQL_Error_Log (LogDate,SessionID,TextMessage)
exec sp_readerrorlog 0,1,'I/O is frozen on database' --'SQL Server has encountered' --'I/O is frozen on database'


--demo for creating In-Memory Tables
CREATE TABLE [dbo].[HR_439NSM_0000](
	[DUMP] [nvarchar](125) NULL,
	[PERSA] [varchar](4) NULL,
	[FLAG] [varchar](4) NULL,
	[FILEDATE] [datetime] NULL,
	[FILENAME] [nvarchar](100) NULL,
	[INSERTDATE] [datetime] NULL
) WITH (MEMORY_OPTIMIZED = ON, DURABILITY=SCHEMA_ONLY)
GO