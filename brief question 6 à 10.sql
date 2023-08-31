--6. À partir du tableau suivant, écrivez une requête en SQL pour créer une liste de titres de poste uniques 
--dans la table des employés de la base de données Adventureworks. Renvoie la colonne titre du poste et organise 
--l'ensemble des résultats par ordre croissant.

--Exemple de tableau : HumanResources.Employee

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC;

--7. À partir du tableau suivant, écrivez une requête en SQL pour calculer le fret total payé par chaque client. 
--Retourner l'ID client et le fret total. Triez la sortie par ordre croissant sur l'ID client.

--Exemple de tableau : sales.salesorderheader

SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID ASC;

--8. À partir du tableau suivant, écrivez une requête en SQL pour trouver la moyenne et la somme du sous-total pour chaque client.
--Renvoie l'identifiant client, la moyenne et la somme du sous-total. Regroupé le résultat sur customerid et salespersonid. 
--Triez le résultat sur la colonne customerid par ordre décroissant.

--Exemple de tableau : sales.salesorderheader

SELECT CustomerID,SalesPersonID,   AVG(SubTotal) AS AverageSubTotal, SUM(SubTotal) AS TotalSubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC;


--9. À partir du tableau suivant, écrivez une requête en SQL pour récupérer la quantité totale de chaque ID de produit 
--qui se trouve dans l'étagère « A », « C » ou « H ». Filtrez les résultats pour que la quantité totale soit supérieure à 500. 
--Renvoyez l'ID de produit et la somme de la quantité. Triez les résultats selon le productid par ordre croissant.

--Exemple de tableau : production.productinventory

SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
WHERE Shelf IN ('A', 'C', 'H') AND Quantity > 500
GROUP BY ProductID
ORDER BY ProductID ASC;

-- Exemple de solution :
SELECT productid, sum(quantity) AS total_quantity
FROM production.productinventory
WHERE shelf IN ('A','C','H')
GROUP BY productid
HAVING SUM(quantity)>500
ORDER BY productid;

--10. À partir du tableau suivant, écrivez une requête en SQL pour trouver 
--la quantité totale d'un groupe d'ID de localisation multipliée par 10.

--Exemple de tableau : production.productinventory


SELECT SUM(quantity) AS total_quantity
FROM production.productinventory
GROUP BY (locationid*10);