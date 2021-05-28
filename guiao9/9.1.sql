-- 9.1

--DBCC FREEPROCCACHE;
--DBCC DROPCLEANBUFFERS;

-- #1

--select * from Production.WorkOrder

-- #2

--select * from Production.WorkOrder where WorkOrderID=1234

-- #3
--SELECT * FROM Production.WorkOrder
--WHERE WorkOrderID between 10000 and 10010

--SELECT * FROM Production.WorkOrder
--WHERE WorkOrderID between 1 and 72591

-- #4

--SELECT * FROM Production.WorkOrder
--WHERE StartDate = '2007-06-25'
-- #5

--CREATE INDEX ProductID ON Production.WorkOrder(ProductID)

--SELECT * FROM Production.WorkOrder WHERE ProductID = 757

-- #6

--DROP INDEX ProductID on Production.WorkOrder

--CREATE INDEX ProductID ON Production.WorkOrder(ProductID) INCLUDE(StartDate)

--SELECT WorkOrderID, StartDate FROM Production.WorkOrder
--WHERE ProductID = 757

--SELECT WorkOrderID, StartDate FROM Production.WorkOrder
--WHERE ProductID = 945

--SELECT WorkOrderID FROM Production.WorkOrder
--WHERE ProductID = 945 AND StartDate = '2006-01-04'

-- #7

--DROP INDEX ProductID on Production.WorkOrder

--CREATE INDEX ProductID ON Production.WorkOrder(ProductID)
--CREATE INDEX StartDate ON Production.WorkOrder(StartDate)

--SELECT WorkOrderID, StartDate FROM Production.WorkOrder
--WHERE ProductID = 945 AND StartDate = '2006-01-04'

-- #8

--DROP INDEX ProductID ON Production.WorkOrder
--DROP INDEX StartDate ON Production.WorkOrder 
--CREATE INDEX Composite ON Production.WorkOrder(ProductID, StartDate)

--SELECT WorkOrderID, StartDate FROM Production.WorkOrder
--WHERE ProductID = 945 AND StartDate = '2006-01-04'
