--1. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer 
--toutes les lignes et colonnes de la table des employ�s dans la base de donn�es Adventureworks. 
--Triez l�ensemble des r�sultats par ordre croissant sur le titre du poste.

--Exemple de tableau : HumanResources.Employee

SELECT * 
FROM HumanResources.Employee
ORDER BY JobTitle ASC;

--2. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer toutes les lignes et colonnes 
--de la table des employ�s � l'aide de l'alias de table dans la base de donn�es Adventureworks. 
--Triez la sortie par ordre croissant sur le nom de famille.

--Exemple de tableau : Person.Person

SELECT * 
FROM Person.Person AS p
ORDER BY p.LastName ASC;

--3. � partir du tableau suivant, �crivez une requ�te en SQL pour renvoyer toutes les lignes et un sous-ensemble 
--de colonnes (FirstName, LastName, businessentityid) de la table person dans la base de donn�es AdventureWorks. 
--Le titre de la troisi�me colonne est renomm� Employee_id. Organis� la sortie par ordre croissant par nom de famille.

--Exemple de tableau : Person.Person

SELECT FirstName, LastName, BusinessEntityID AS Employee_id
FROM Person.Person AS p
ORDER BY LastName ASC;


--4. � partir du tableau suivant, �crivez une requ�te en SQL pour renvoyer uniquement les lignes 
--des produits dont la date de d�but de vente n'est pas NULL et la ligne de produits � T �. Renvoie l'ID du produit, 
--le num�ro du produit et le nom. Organis� la sortie par ordre croissant de nom.

--Exemple de tableau : Production.Product


SELECT ProductID, ProductNumber, Name
FROM Production.Product
WHERE SellStartDate IS NOT NULL AND ProductLine = 'T'
ORDER BY Name ASC;


--5. � partir du tableau suivant, �crivez une requ�te en SQL pour renvoyer toutes les lignes de la table salesorderheader 
--dans la base de donn�es Adventureworks et calculez le pourcentage de taxe sur le sous-total d�cid�.
--Renvoyez l'ID de commande, l'ID client, la date de commande, le sous-total, le pourcentage de la colonne de taxe. 
--Organis� l'ensemble des r�sultats par ordre croissant sur le sous-total.

--Exemple de tableau : sales.salesorderheader

SELECT SalesOrderID, CustomerID, OrderDate, SubTotal, 
(TaxAmt / SubTotal) * 100 AS TaxPercentage
FROM Sales.SalesOrderHeader
ORDER BY SubTotal ASC;