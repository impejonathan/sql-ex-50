--40. À partir des tableaux suivants, écrivez une requête SQL pour obtenir 
--tous les noms de produits et identifiants de commande client.
--Commandez l'ensemble de résultats dans la colonne du nom du produit.

SELECT Name , SalesOrderID
FROM  Production.Product AS p
    INNER JOIN  Sales.SalesOrderDetail AS S
    on p.ProductID = S.ProductID
ORDER BY Name


-------------------------------------------------
--41. À partir des tableaux suivants, écrivez une requête SQL pour récupérer le nom du territoire et BusinessEntityID. 
--L'ensemble de résultats inclut tous les vendeurs, qu'un territoire leur soit attribué ou non.

SELECT st.Name as  territory , BusinessEntityID
FROM  Sales.SalesTerritory AS ST
    RIGHT outer JOIN Sales.SalesPerson AS SP
    ON st.TerritoryID = SP.TerritoryID
ORDER BY BusinessEntityID

---------------------------------------------------
--42. Écrivez une requête en SQL pour trouver le nom complet (prénom et nom) et la ville de l'employé dans les tableaux suivants.
--Classez le résultat défini par nom puis par prénom.

SELECT CONCAT(PP.FirstName, ' ', PP.LastName) as Name,PA.City 
FROM  Person.Person AS PP
    JOIN HumanResources.Employee AS HRE
        ON PP.BusinessEntityID = HRE.BusinessEntityID
    JOIN Person.Address AS PA
        ON PA.AddressID = PP.BusinessEntityID
    JOIN Person.BusinessEntityAddress as PBEA
        ON PBEA.BusinessEntityID = PA.AddressID
ORDER by  PP.LastName , PP.FirstName 

--GPT BONNE REPONSE INVERSER DES LIAISON 

SELECT CONCAT(PP.FirstName, ' ', PP.LastName) as Name,A.City 
FROM  Person.Person AS PP
    JOIN HumanResources.Employee e 
		ON PP.BusinessEntityID = e.BusinessEntityID
    JOIN Person.BusinessEntityAddress bea 
		ON e.BusinessEntityID = bea.BusinessEntityID
    JOIN Person.Address a 
		ON bea.AddressID = a.AddressID
ORDER by  PP.LastName , PP.FirstName 


-------------------------------------------------------
--43. Écrivez une requête SQL pour renvoyer les colonnes businessentityid, firstname et lastname de toutes les personnes 
--dans la table des personnes (table dérivée) avec le type de personne « IN » et le nom de famille est « Adams ». 
--Triez le résultat défini par ordre croissant sur le prénom. 
--Une instruction SELECT après la clause FROM est une table dérivée.

SELECT BusinessEntityID,FirstName,  LastName , PersonType
FROM  Person.Person 
WHERE LastName = 'Adams' AND persontype = 'IN'
ORDER BY FirstName

-- gpt meme resultat 
SELECT businessentityid, firstname, lastname
FROM (SELECT * FROM Person.Person WHERE persontype = 'IN') AS derived_table
WHERE lastname = 'Adams'
ORDER BY firstname;

---------------------------------------------------
--44. Créez une requête SQL pour récupérer les individus de la table suivante 
--avec un businessentityid compris entre 1 500, un nom commençant par « Al » et un prénom commençant par « M ».

SELECT BusinessEntityID,FirstName,  LastName 
FROM  Person.Person 
WHERE BusinessEntityID < 1500 AND LastName LIKE 'Al%' AND FirstName LIKE'M%'

-----------------------------------------------------------------
--45. Écrivez une requête SQL pour trouver l'ID de produit, le nom et la couleur des éléments « Blade », 
--« Crown Race » et « AWC Logo Cap » à l'aide d'une table dérivée avec plusieurs valeurs.

SELECT ProductID , Name, Color
FROM  Production.Product
WHERE Name = 'Blade'or Name = 'Crown Race' or Name = 'AWC Logo Cap'
ORDER BY ProductID


--solution meme resultat

--SELECT ProductID, a.Name, Color  
--FROM Production.Product AS a  
--INNER JOIN (VALUES ('Blade'), ('Crown Race'), ('AWC Logo Cap')) AS b(Name)   
--ON a.Name = b.Name;

--gpt

--SELECT productid, name, color
--FROM Production.Product
--WHERE name IN ('Blade', 'Crown Race', 'AWC Logo Cap');

----------------------------------------------------------
--46. ​​Créez une requête SQL pour afficher le nombre total de commandes client que chaque représentant commercial reçoit chaque année. 
--Triez le résultat défini par SalesPersonID, puis par le composant date de la date de commande par ordre croissant. 
--Renvoie le composant année de OrderDate, SalesPersonID et SalesOrderID.


----------------------------------------------------------
SELECT SalesPersonID , COUNT(SalesOrderID) as vente, YEAR(OrderDate) as year
FROM  Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL

GROUP BY  YEAR(OrderDate) ,SalesPersonID
ORDER BY YEAR(OrderDate), SalesPersonID ASC  

----------------------------------------------------------
--47. À partir du tableau suivant, écrivez une requête en SQL pour trouver le nombre moyen de commandes client 
--pour toutes les années des représentants commerciaux.


WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS
(
    SELECT SalesPersonID, COUNT(*)
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
)
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;

----------------------------------------------------------
--48. Écrivez une requête SQL sur la table suivante pour récupérer les enregistrements avec les caractères green_ dans le champ LargePhotoFileName.
--Les colonnes du tableau suivant doivent toutes être renvoyées.

SELECT *
FROM Production.ProductPhoto
where LargePhotoFileName LIKE('%green_%')

----------------------------------------------------------
--49. Écrivez une requête SQL pour récupérer l'adresse postale de toute entreprise située en dehors des États-Unis (US) 
--et dans une ville dont le nom commence par Pa.
--Renvoyez les colonnes Addressline1, Addressline2, city, postalcode, countryregioncode.

SELECT Addressline1, Addressline2, city, postalcode, countryregioncode 
FROM Person.Address as A
    JOIN Person.StateProvince as SP 
        on A.StateProvinceID = sp.StateProvinceID
WHERE CountryRegionCode !='US' and city LIKE('Pa%')


------------------------------------------------------------
--50. À partir du tableau suivant, écrivez une requête en SQL pour récupérer les vingt premières lignes. 
--Retourner le titre du poste, embauché. Classez les résultats définis dans la colonne Embauché par ordre décroissant.

SELECT top 20 JobTitle , HireDate
FROM HumanResources.Employee
ORDER by HireDate DESC


