--1. À partir du tableau suivant, écrivez une requête en SQL pour récupérer 
--toutes les lignes et colonnes de la table des employés dans la base de données Adventureworks. 
--Triez l’ensemble des résultats par ordre croissant sur le titre du poste.

--Exemple de tableau : HumanResources.Employee

SELECT * 
FROM HumanResources.Employee
ORDER BY JobTitle ASC;

--2. À partir du tableau suivant, écrivez une requête en SQL pour récupérer toutes les lignes et colonnes 
--de la table des employés à l'aide de l'alias de table dans la base de données Adventureworks. 
--Triez la sortie par ordre croissant sur le nom de famille.

--Exemple de tableau : Person.Person

SELECT * 
FROM Person.Person AS p
ORDER BY p.LastName ASC;

--3. À partir du tableau suivant, écrivez une requête en SQL pour renvoyer toutes les lignes et un sous-ensemble 
--de colonnes (FirstName, LastName, businessentityid) de la table person dans la base de données AdventureWorks. 
--Le titre de la troisième colonne est renommé Employee_id. Organisé la sortie par ordre croissant par nom de famille.

--Exemple de tableau : Person.Person

SELECT FirstName, LastName, BusinessEntityID AS Employee_id
FROM Person.Person AS p
ORDER BY LastName ASC;


--4. À partir du tableau suivant, écrivez une requête en SQL pour renvoyer uniquement les lignes 
--des produits dont la date de début de vente n'est pas NULL et la ligne de produits « T ». Renvoie l'ID du produit, 
--le numéro du produit et le nom. Organisé la sortie par ordre croissant de nom.

--Exemple de tableau : Production.Product


SELECT ProductID, ProductNumber, Name
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name ASC;


--5. À partir du tableau suivant, écrivez une requête en SQL pour renvoyer toutes les lignes de la table salesorderheader 
--dans la base de données Adventureworks et calculez le pourcentage de taxe sur le sous-total décidé.
--Renvoyez l'ID de commande, l'ID client, la date de commande, le sous-total, le pourcentage de la colonne de taxe. 
--Organisé l'ensemble des résultats par ordre croissant sur le sous-total.

--Exemple de tableau : sales.salesorderheader

SELECT SalesOrderID, CustomerID, OrderDate, SubTotal, 
(TaxAmt / SubTotal) * 100 AS TaxPercentage
FROM Sales.SalesOrderHeader
ORDER BY SubTotal ASC;