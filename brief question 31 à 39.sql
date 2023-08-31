--31. À partir du tableau suivant, écrivez une requête en SQL pour récupérer les personnes dont le nom de famille
--commence par la lettre « R ». 
--Renvoie le nom et le prénom et affiche le résultat par ordre croissant sur le prénom et par ordre décroissant sur les colonnes du nom.

SELECT LastName, FirstName
  FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC ,LastName DESC

--32. À partir du tableau suivant, écrivez une requête en SQL pour classer la colonne BusinessEntityID par ordre décroissant 
--lorsque SalariedFlag est défini sur « true » et BusinessEntityID par ordre croissant 
--lorsque SalariedFlag est défini sur « false ». Renvoie les colonnes BusinessEntityID et SalariedFlag.

SELECT BusinessEntityID, 
       CASE WHEN SalariedFlag = 1 THEN 'true' ELSE 'false' END AS SalariedFlag
FROM HumanResources.Employee
ORDER BY 
    CASE WHEN SalariedFlag = 1 THEN BusinessEntityID END ASC,
    CASE WHEN SalariedFlag = 0 THEN BusinessEntityID END ASC;


--33. À partir du tableau suivant, écrivez une requête en SQL pour définir le résultat dans l'ordre par la colonne TerritoryName 
--lorsque la colonne CountryRegionName est égale à « États-Unis » et par CountryRegionName pour toutes les autres lignes.

SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName  
FROM Sales.vSalesPerson  
WHERE TerritoryName IS NOT NULL  
ORDER BY CASE CountryRegionName WHEN 'United States' THEN TerritoryName  
         ELSE CountryRegionName END;

--Cette requête sélectionne les colonnes BusinessEntityID, LastName, TerritoryName et CountryRegionName de la vue Sales.vSalesPerson.
--La clause WHERE filtre les lignes pour ne conserver que celles où la colonne TerritoryName n’est pas nulle. 
--La clause ORDER BY utilise une instruction CASE pour trier les lignes en fonction de la valeur de CountryRegionName: 
--si CountryRegionName est égal à 'United States', les lignes sont triées par ordre croissant de TerritoryName; 
--pour toutes les autres lignes, elles sont triées par ordre croissant de CountryRegionName.

--En ce qui concerne votre question sur la vue Sales.vSalesPerson, il s’agit d’une vue dans la base de données AdventureWorks. 
--Une vue est un objet de base de données qui renvoie un ensemble de résultats basé sur une ou plusieurs tables ou vues. 
--Dans ce cas, la vue Sales.vSalesPerson renvoie des informations sur les employés des ventes en combinant des données provenant de plusieurs tables. 
--Si vous utilisez la base de données AdventureWorks, cette vue devrait exister. 
--Sinon, vous devrez peut-être ajuster le code pour utiliser les tables appropriées dans votre base de données

----------------------------------------------------------------

--34. À partir du tableau suivant, écrivez une requête en SQL pour trouver les personnes qui vivent dans un territoire et la valeur de salesytd sauf 0. 
--Renvoyez le prénom, le nom et le numéro de ligne sous la forme « Numéro de ligne », « Rang », « Rang dense ' et NTILE comme 'Quartile', salesytd et postalcode. 
--Commandez la sortie sur la colonne du code postal.

SELECT p.FirstName, p.LastName, s.SalesYTD, a.PostalCode,
       ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS 'Row Number',
       RANK() OVER (ORDER BY a.PostalCode) AS 'Rank',
       DENSE_RANK() OVER (ORDER BY a.PostalCode) AS 'Dense Rank',
       NTILE(4) OVER (ORDER BY a.PostalCode) AS 'Quartile'
FROM Sales.SalesPerson s
    JOIN Person.Person p 
        ON s.BusinessEntityID = p.BusinessEntityID
    JOIN Person.Address a 
        ON p.BusinessEntityID = a.AddressID
WHERE s.TerritoryID IS NOT NULL AND s.SalesYTD <> 0
ORDER BY PostalCode;

--Cette requête calcule directement les fonctions de fenêtre ROW_NUMBER, RANK, DENSE_RANK et NTILE sur les données de la table Sales.
--SalesPerson jointe aux tables Person.Person et Person.Address. 
--La clause WHERE filtre les lignes pour ne conserver que celles où la colonne TerritoryID n’est pas nulle et la colonne SalesYTD est différente de 0.
--La requête sélectionne les colonnes calculées ainsi que les colonnes FirstName, LastName, SalesYTD et PostalCode, 
--et trie les résultats par ordre croissant de la colonne PostalCode
-- ########################################
--ROW_NUMBER: Attribue un numéro d’ordre unique à chaque ligne.
--RANK: Attribue un rang à chaque ligne, en sautant des rangs en cas d’égalité.
--DENSE_RANK: Attribue un rang à chaque ligne, sans sauter de rangs en cas d’égalité.
--NTILE: Divise les lignes en groupes de taille approximativement égale.
-- ########################################


--------------------------------------------

--35. À partir du tableau suivant, écrivez une requête en SQL pour ignorer les 10 premières lignes 
--de l'ensemble de résultats triés et renvoyer toutes les lignes restantes.

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS;

--------------------------------------------
--36. À partir du tableau suivant, écrivez une requête en SQL pour ignorer les 5 premières lignes 
--et renvoyer les 5 lignes suivantes de l'ensemble de résultats triés.

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
    OFFSET 5 ROWS
    FETCH NEXT 5 ROWS ONLY;

--------------------------------------------
--37. À partir du tableau suivant, écrivez une requête en SQL pour répertorier tous les produits de couleur rouge ou bleue. 
--Renvoie le nom, la couleur et le prix de liste. Trie ce résultat par prix de liste de colonne.

SELECT Name , Color , ListPrice
FROM Production.Product
WHERE Color = 'Red' or Color = 'blue'
ORDER BY ListPrice 

--------------------------------------------
--38. Créez une requête SQL à partir de la table SalesOrderDetail pour récupérer le nom du produit et toutes les commandes client associées. 
--De plus, il renvoie toutes les commandes client qui ne comportent aucun article mentionné dans la table Produit ainsi que tous les produits 
--qui ont des commandes client autres que celles qui y sont répertoriées. 
--Renvoyez le nom du produit, l'identifiant de la commande. Triez le jeu de résultats dans la colonne du nom du produit.

SELECT Name , SalesOrderID
FROM Sales.SalesOrderDetail AS S
    FULL OUTER JOIN Production.Product AS p 
    on S.ProductID = p.ProductID
ORDER BY Name

--39. À partir du tableau suivant, écrivez une requête SQL pour récupérer le nom du produit et
--l'ID de la commande. Les produits commandés et non commandés sont inclus dans l’ensemble de résultats.

SELECT Name , SalesOrderID
FROM  Production.Product AS p
    LEFT JOIN  Sales.SalesOrderDetail AS S
    on p.ProductID = S.ProductID
ORDER BY Name