--21. � partir des tableaux suivants, �crivez une requ�te en SQL pour r�cup�rer le vendeur pour chaque 
--code postal qui appartient � un territoire et SalesYTD n'est pas nul. 
--Renvoie les num�ros de ligne de chaque groupe de colonne PostalCode, nom de famille, salesytd, postalcode. 
--Triez le service de vente de chaque groupe de codes postaux par ordre d�croissant. Short le code postal par ordre croissant.

--Exemple de tableau : Sales.SalesPerson -- Sample table: Person.Person -- Sample table: Person.Address


SELECT ROW_NUMBER() OVER(PARTITION BY A.PostalCode ORDER BY SP.SalesYTD DESC) AS RowNumber, P.LastName, SP.SalesYTD, A.PostalCode
FROM Sales.SalesPerson AS SP
    JOIN Person.Person AS P
        ON SP.BusinessEntityID = P.BusinessEntityID
    JOIN Person.Address AS A
        ON P.BusinessEntityID = A.AddressID
WHERE SP.TerritoryID IS NOT NULL AND SP.SalesYTD != 0
ORDER BY A.PostalCode ASC;

--Cette requ�te utilise la fonction ROW_NUMBER avec la clause PARTITION BY pour diviser les donn�es en partitions en 
--fonction du champ SalesPersonID. Dans chaque partition, les lignes sont num�rot�es en ordre d�croissant en fonction du champ SalesAmount.
--Le r�sultat renverra un num�ro de rang unique pour chaque vente pour chaque vendeur.

 ------------------------------------------------------------

-- 22. � partir du tableau suivant, �crivez une requ�te en SQL pour compter le nombre de contacts 
-- pour la combinaison de chaque type et nom. Filtrez la sortie pour ceux qui ont 100 contacts ou plus.
-- Renvoyez ContactTypeID, ContactTypeName et BusinessEntityContact. 
-- Triez le r�sultat d�fini par ordre d�croissant selon le nombre de contacts.

--Exemple de table : Person.BusinessEntityContact

SELECT CT.ContactTypeID, CT.Name AS ContactTypeName, COUNT(*) AS BusinessEntityContact
FROM Person.BusinessEntityContact AS BEC
    JOIN Person.ContactType AS CT
        ON BEC.ContactTypeID = CT.ContactTypeID
GROUP BY CT.ContactTypeID, CT.Name
    HAVING COUNT(*) >= 100
ORDER BY BusinessEntityContact DESC;

---------------------------------------------------------------

--23. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer 
--le RateChangeDate, le nom complet (pr�nom, deuxi�me pr�nom et nom de famille) et le salaire hebdomadaire (40 heures par semaine) des employ�s.
--Dans la sortie, le RateChangeDate doit appara�tre au format date. Triez la sortie par ordre croissant sur NameInFull.

--Exemple de tableau : HumanResources.EmployeePayHistory

SELECT EPH.RateChangeDate,		
		CONCAT(P.LastName, ' ', P.FirstName, ' ', P.MiddleName) AS NameInFull, 
		EPH.Rate * 40 AS WeeklySalary
FROM HumanResources.EmployeePayHistory AS EPH
	JOIN Person.Person AS P
		ON EPH.BusinessEntityID = P.BusinessEntityID
ORDER BY NameInFull ASC;

--la fonction CONCAT pour concat�ner les champs FirstName, MiddleName et LastName en un seul champ nomm� NameInFull.

----------------------------------------------

--24. � partir des tableaux suivants, �crivez une requ�te en SQL pour calculer et afficher 
--le dernier salaire hebdomadaire de chaque employ�. Renvoie RateChangeDate, 
--nom complet (pr�nom, deuxi�me pr�nom et nom de famille) et 
--salaire hebdomadaire (40 heures par semaine) des employ�s 
--Triez la sortie par ordre croissant sur NameInFull.

SELECT MAX(EPH.RateChangeDate) AS LatestRateChangeDate, 
		CONCAT(P.LastName, ' ', P.FirstName, ' ', P.MiddleName) AS NameInFull, 
		EPH.Rate * 40 AS WeeklySalary
FROM HumanResources.EmployeePayHistory AS EPH
	JOIN Person.Person AS P
		ON EPH.BusinessEntityID = P.BusinessEntityID
GROUP BY EPH.BusinessEntityID, P.FirstName, P.MiddleName, P.LastName, EPH.Rate
ORDER BY NameInFull ASC;


--la solution

--SELECT CAST(hur.RateChangeDate as VARCHAR(10) ) AS FromDate
--        , CONCAT(LastName, ', ', FirstName, ' ', MiddleName) AS NameInFull
--        , (40 * hur.Rate) AS SalaryInAWeek
--    FROM Person.Person AS pp
--        INNER JOIN HumanResources.EmployeePayHistory AS hur
--            ON hur.BusinessEntityID = pp.BusinessEntityID
--             WHERE hur.RateChangeDate = (SELECT MAX(RateChangeDate)
--                                FROM HumanResources.EmployeePayHistory 
--                                WHERE BusinessEntityID = hur.BusinessEntityID)
--    ORDER BY NameInFull;


----------------------------------------------
--25. � partir du tableau suivant, �crivez une requ�te en SQL 
--pour trouver la somme, la moyenne, le nombre, la quantit� minimale et maximale de commande pour les commandes dont les identifiants sont 43659 et 43664.
--Renvoyez SalesOrderID, ProductID, OrderQty, sum, moyenne, nombre, max. , et la quantit� minimum de commande.

SELECT SalesOrderID, ProductID, OrderQty,
       SUM(OrderQty) AS SumOrderQty,
       AVG(OrderQty) AS AvgOrderQty,
       COUNT(OrderQty) AS CountOrderQty,
       MAX(OrderQty) AS MaxOrderQty,
       MIN(OrderQty) AS MinOrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)
GROUP BY SalesOrderID, ProductID, OrderQty;