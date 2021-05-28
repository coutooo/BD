-- 9.2

--CREATE TABLE mytemp (
	--rid BIGINT /*IDENTITY (1, 1)*/ NOT NULL,
	--at1 INT NULL,
	--at2 INT NULL,
	--at3 INT NULL,
	--lixo varchar(100) NULL
--);

-- a)
--CREATE CLUSTERED INDEX Rid ON mytemp(rid);

-- b)

-- Record the Start Time
--DECLARE @start_time DATETIME, @end_time DATETIME;
--SET @start_time = GETDATE();
--PRINT @start_time

-- Generate random records
--DECLARE @val as int = 1;
--DECLARE @nelem as int = 50000;
--SET nocount ON

--WHILE @val <= @nelem
--BEGIN
	--DBCC DROPCLEANBUFFERS; -- need to be sysadmin
	--INSERT mytemp (rid, at1, at2, at3, lixo)
	--SELECT cast((RAND()*@nelem*40000) as int), cast((RAND()*@nelem) as int),
		--cast((RAND()*@nelem) as int), cast((RAND()*@nelem) as int),
		--'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
	--SET @val = @val + 1;
--END

--PRINT 'Inserted ' + str(@nelem) + ' total records'

-- Duration of Insertion Process
--SET @end_time = GETDATE();
--PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND, @start_time, @end_time));

-- Inserted 50000 total records
-- Milliseconds used: 139643

-- Index Rid: Total Fragmentation - 98,95 %; Page Fullness - 68,29 %

-- c)

--DROP INDEX Rid on mytemp;
--CREATE CLUSTERED INDEX Rid ON mytemp(rid) WITH (FILLFACTOR = 65, PAD_INDEX = ON);

--Inserted 50000 total records
--Milliseconds used: 213510

--DROP INDEX Rid on mytemp;
--CREATE CLUSTERED INDEX Rid ON mytemp(rid) WITH (FILLFACTOR = 80, PAD_INDEX = ON);

--Inserted 50000 total records
--Milliseconds used: 209843

--DROP INDEX Rid on mytemp;
--CREATE CLUSTERED INDEX Rid ON mytemp(rid) WITH (FILLFACTOR = 90, PAD_INDEX = ON);

--Inserted 50000 total records
--Milliseconds used: 192846

-- d)

--CREATE TABLE mytemp2 (
	--rid BIGINT IDENTITY (1, 1) NOT NULL,
	--at1 INT NULL,
	--at2 INT NULL,
	--at3 INT NULL,
	--lixo varchar(100) NULL
--);

-- Record the Start Time
--DECLARE @start_time2 DATETIME, @end_time2 DATETIME;
--SET @start_time2 = GETDATE();
--PRINT @start_time2

-- Generate random records
--DECLARE @val2 as int = 1;
--DECLARE @nelem2 as int = 50000;
--SET nocount ON

--WHILE @val2 <= @nelem2
--BEGIN
	--DBCC DROPCLEANBUFFERS; -- need to be sysadmin
	--INSERT mytemp2 (rid, at1, at2, at3, lixo)
	--SELECT cast((RAND()*@nelem2*40000) as int), cast((RAND()*@nelem2) as int),
		--cast((RAND()*@nelem2) as int), cast((RAND()*@nelem2) as int),
		--'lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo...lixo';
	--SET @val2 = @val2 + 1;
--END

--PRINT 'Inserted ' + str(@nelem2) + ' total records'

-- Duration of Insertion Process
--SET @end_time2 = GETDATE();
--PRINT 'Milliseconds used: ' + CONVERT(VARCHAR(20), DATEDIFF(MILLISECOND, @start_time2, @end_time2));

--Inserted 50000 total records
--Milliseconds used: 150943

-- e)

--DROP INDEX Rid on mytemp;

-- No index:
--Inserted 50000 total records
--Milliseconds used: 152960

--CREATE CLUSTERED INDEX Rid ON mytemp(rid);
--CREATE INDEX At1 ON mytemp(at1);
--CREATE INDEX At2 ON mytemp(at2);
--CREATE INDEX At3 ON mytemp(at3);
--CREATE INDEX Lixo ON mytemp(lixo);

-- All indexes
--Inserted 50000 total records
--Milliseconds used: 1210140

-- Conclusions
-- More time is spent on reading pages on disk since there are more indexes that change during the insertions