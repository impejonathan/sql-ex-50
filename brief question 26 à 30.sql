--26. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver 
--la somme, la moyenne et le nombre de quantit�s command�es pour les commandes d
--ont les identifiants sont 43659 et 43664 et l'identifiant du produit commen�ant par � 71 �. 
--Renvoyez SalesOrderID, OrderNumber, ProductID, OrderQty, la somme, la moyenne et le nombre de quantit�s command�es.

SELECT SalesOrderID, SalesOrderDetailID AS OrderNumber, ProductID, OrderQty,
       SUM(OrderQty) AS SumOrderQty,
       AVG(OrderQty) AS AvgOrderQty,
       COUNT(OrderQty) AS CountOrderQty
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664) AND ProductID LIKE '71%'
GROUP BY SalesOrderID, SalesOrderDetailID, ProductID, OrderQty;


------------------------------------------------

--27. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer le co�t total de chaque salesorderID qui d�passe 100 000. 
--Renvoyez SalesOrderID, co�t total.

SELECT SalesOrderID, SUM(OrderQty * UnitPrice) AS TotalCost
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(OrderQty * UnitPrice) > 100000;

--28. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer les produits dont les noms commencent par � Lock Washing �.
--Renvoie l'ID du produit, puis nomme et classe l'ensemble de r�sultats par ordre croissant dans la colonne ID du produit.

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID ASC;

-----------------------------------

--29. �crivez une requ�te en SQL pour r�cup�rer les lignes de la table des produits et
--classer l'ensemble de r�sultats sur une colonne de prix non sp�cifi�e. Renvoyez l�ID du produit, le nom et la couleur du produit.

SELECT ProductID, Name, Color 
FROM Production.Product
ORDER by ListPrice

-----------------------------------

--30. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer les enregistrements des employ�s. 
--Classez la production par ann�e (ordre croissant par d�faut) de l'employ�. Renvoyez BusinessEntityID, JobTitle et HireDate

SELECT BusinessEntityID, JobTitle,  HireDate
FROM HumanResources.Employee
ORDER BY HireDate

--autre 

SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY YEAR(HireDate);