--6. � partir du tableau suivant, �crivez une requ�te en SQL pour cr�er une liste de titres de poste uniques 
--dans la table des employ�s de la base de donn�es Adventureworks. Renvoie la colonne titre du poste et organise 
--l'ensemble des r�sultats par ordre croissant.

--Exemple de tableau : HumanResources.Employee

SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle ASC;

--7. � partir du tableau suivant, �crivez une requ�te en SQL pour calculer le fret total pay� par chaque client. 
--Retourner l'ID client et le fret total. Triez la sortie par ordre croissant sur l'ID client.

--Exemple de tableau : sales.salesorderheader

SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID ASC;

--8. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver la moyenne et la somme du sous-total pour chaque client.
--Renvoie l'identifiant client, la moyenne et la somme du sous-total. Regroup� le r�sultat sur customerid et salespersonid. 
--Triez le r�sultat sur la colonne customerid par ordre d�croissant.

--Exemple de tableau : sales.salesorderheader

SELECT CustomerID,SalesPersonID,   AVG(SubTotal) AS AverageSubTotal, SUM(SubTotal) AS TotalSubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC;


--9. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer la quantit� totale de chaque ID de produit 
--qui se trouve dans l'�tag�re � A �, � C � ou � H �. Filtrez les r�sultats pour que la quantit� totale soit sup�rieure � 500. 
--Renvoyez l'ID de produit et la somme de la quantit�. Triez les r�sultats selon le productid par ordre croissant.

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

--10. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver 
--la quantit� totale d'un groupe d'ID de localisation multipli�e par 10.

--Exemple de tableau : production.productinventory


SELECT SUM(quantity) AS total_quantity
FROM production.productinventory
GROUP BY (locationid*10);