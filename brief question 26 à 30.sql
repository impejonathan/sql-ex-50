--26. À partir du tableau suivant, écrivez une requête en SQL pour trouver 
--la somme, la moyenne et le nombre de quantités commandées pour les commandes d
--ont les identifiants sont 43659 et 43664 et l'identifiant du produit commençant par « 71 ». 
--Renvoyez SalesOrderID, OrderNumber, ProductID, OrderQty, la somme, la moyenne et le nombre de quantités commandées.

SELECT SalesOrderID, SalesOrderDetailID AS OrderNumber, ProductID, OrderQty,
       SUM(OrderQty) AS SumOrderQty,
       AVG(OrderQty) AS AvgOrderQty,
       COUNT(OrderQty) AS CountOrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664) AND ProductID LIKE '71%'
GROUP BY SalesOrderID, SalesOrderDetailID, ProductID, OrderQty;


------------------------------------------------

--27. À partir du tableau suivant, écrivez une requête en SQL pour récupérer le coût total de chaque salesorderID qui dépasse 100 000. 
--Renvoyez SalesOrderID, coût total.

SELECT SalesOrderID, SUM(OrderQty * UnitPrice) AS TotalCost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty * UnitPrice) > 100000;

--28. À partir du tableau suivant, écrivez une requête en SQL pour récupérer les produits dont les noms commencent par « Lock Washing ».
--Renvoie l'ID du produit, puis nomme et classe l'ensemble de résultats par ordre croissant dans la colonne ID du produit.

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID ASC;

-----------------------------------

--29. Écrivez une requête en SQL pour récupérer les lignes de la table des produits et
--classer l'ensemble de résultats sur une colonne de prix non spécifiée. Renvoyez l’ID du produit, le nom et la couleur du produit.

SELECT ProductID, Name, Color 
FROM Production.Product
ORDER by ListPrice

-----------------------------------

--30. À partir du tableau suivant, écrivez une requête en SQL pour récupérer les enregistrements des employés. 
--Classez la production par année (ordre croissant par défaut) de l'employé. Renvoyez BusinessEntityID, JobTitle et HireDate

SELECT BusinessEntityID, JobTitle,  HireDate
FROM HumanResources.Employee
ORDER BY HireDate

--autre 

SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY YEAR(HireDate);