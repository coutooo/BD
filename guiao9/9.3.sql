-- Problema 9.3
-- a)
-- i
CREATE UNIQUE CLUSTERED INDEX employeeSSN ON Employee(Ssn);

-- ii
CREATE CLUSTERED INDEX employeebyName ON Employee(FName, LName);

-- iii
CREATE INDEX employeeDno Employee(Dno);
CREATE UNIQUE CLUSTERED INDEX departNumb Department(Dnumber);

-- iv
CREATE INDEX worksPno Works_On(Pno);
CREATE UNIQUE CLUSTERED INDEX projectNum Project(Pnumber);

-- v
CREATE CLUSTERED INDEX dependentEssn Dependent(Essn);

-- vi
CREATE CLUSTERED INDEX projectDnum On Project(Dnum);