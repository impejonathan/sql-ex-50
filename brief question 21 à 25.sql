--21. À partir des tableaux suivants, écrivez une requête en SQL pour récupérer le vendeur pour chaque 
--code postal qui appartient à un territoire et SalesYTD n'est pas nul. 
--Renvoie les numéros de ligne de chaque groupe de colonne PostalCode, nom de famille, salesytd, postalcode. 
--Triez le service de vente de chaque groupe de codes postaux par ordre décroissant. Short le code postal par ordre croissant.

--Exemple de tableau : Sales.SalesPerson -- Sample table: Person.Person -- Sample table: Person.Address


SELECT ROW_NUMBER() OVER(PARTITION BY A.PostalCode ORDER BY SP.SalesYTD DESC) AS RowNumber, P.LastName, SP.SalesYTD, A.PostalCode
FROM Sales.SalesPerson AS SP
    JOIN Person.Person AS P
        ON SP.BusinessEntityID = P.BusinessEntityID
    JOIN Person.Address AS A
        ON P.BusinessEntityID = A.AddressID
WHERE SP.TerritoryID IS NOT NULL AND SP.SalesYTD != 0
ORDER BY A.PostalCode ASC;

--Cette requête utilise la fonction ROW_NUMBER avec la clause PARTITION BY pour diviser les données en partitions en 
--fonction du champ SalesPersonID. Dans chaque partition, les lignes sont numérotées en ordre décroissant en fonction du champ SalesAmount.
--Le résultat renverra un numéro de rang unique pour chaque vente pour chaque vendeur.

 ------------------------------------------------------------

-- 22. À partir du tableau suivant, écrivez une requête en SQL pour compter le nombre de contacts 
-- pour la combinaison de chaque type et nom. Filtrez la sortie pour ceux qui ont 100 contacts ou plus.
-- Renvoyez ContactTypeID, ContactTypeName et BusinessEntityContact. 
-- Triez le résultat défini par ordre décroissant selon le nombre de contacts.

--Exemple de table : Person.BusinessEntityContact

SELECT CT.ContactTypeID, CT.Name AS ContactTypeName, COUNT(*) AS BusinessEntityContact
FROM Person.BusinessEntityContact AS BEC
    JOIN Person.ContactType AS CT
        ON BEC.ContactTypeID = CT.ContactTypeID
GROUP BY CT.ContactTypeID, CT.Name
    HAVING COUNT(*) >= 100
ORDER BY BusinessEntityContact DESC;

---------------------------------------------------------------

--23. À partir du tableau suivant, écrivez une requête en SQL pour récupérer 
--le RateChangeDate, le nom complet (prénom, deuxième prénom et nom de famille) et le salaire hebdomadaire (40 heures par semaine) des employés.
--Dans la sortie, le RateChangeDate doit apparaître au format date. Triez la sortie par ordre croissant sur NameInFull.

--Exemple de tableau : HumanResources.EmployeePayHistory

SELECT EPH.RateChangeDate,		
		CONCAT(P.LastName, ' ', P.FirstName, ' ', P.MiddleName) AS NameInFull, 
		EPH.Rate * 40 AS WeeklySalary
FROM HumanResources.EmployeePayHistory AS EPH
	JOIN Person.Person AS P
		ON EPH.BusinessEntityID = P.BusinessEntityID
ORDER BY NameInFull ASC;

--la fonction CONCAT pour concaténer les champs FirstName, MiddleName et LastName en un seul champ nommé NameInFull.

----------------------------------------------

--24. À partir des tableaux suivants, écrivez une requête en SQL pour calculer et afficher 
--le dernier salaire hebdomadaire de chaque employé. Renvoie RateChangeDate, 
--nom complet (prénom, deuxième prénom et nom de famille) et 
--salaire hebdomadaire (40 heures par semaine) des employés 
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
--25. À partir du tableau suivant, écrivez une requête en SQL 
--pour trouver la somme, la moyenne, le nombre, la quantité minimale et maximale de commande pour les commandes dont les identifiants sont 43659 et 43664.
--Renvoyez SalesOrderID, ProductID, OrderQty, sum, moyenne, nombre, max. , et la quantité minimum de commande.

SELECT SalesOrderID, ProductID, OrderQty,
       SUM(OrderQty) AS SumOrderQty,
       AVG(OrderQty) AS AvgOrderQty,
       COUNT(OrderQty) AS CountOrderQty,
       MAX(OrderQty) AS MaxOrderQty,
       MIN(OrderQty) AS MinOrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664)
GROUP BY SalesOrderID, ProductID, OrderQty;