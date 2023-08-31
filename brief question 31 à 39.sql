--31. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer les personnes dont le nom de famille
--commence par la lettre � R �. 
--Renvoie le nom et le pr�nom et affiche le r�sultat par ordre croissant sur le pr�nom et par ordre d�croissant sur les colonnes du nom.

SELECT LastName, FirstName
  FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC ,LastName DESC

--32. � partir du tableau suivant, �crivez une requ�te en SQL pour classer la colonne BusinessEntityID par ordre d�croissant 
--lorsque SalariedFlag est d�fini sur � true � et BusinessEntityID par ordre croissant 
--lorsque SalariedFlag est d�fini sur � false �. Renvoie les colonnes BusinessEntityID et SalariedFlag.

SELECT BusinessEntityID, 
       CASE WHEN SalariedFlag = 1 THEN 'true' ELSE 'false' END AS SalariedFlag
FROM HumanResources.Employee
ORDER BY 
    CASE WHEN SalariedFlag = 1 THEN BusinessEntityID END ASC,
    CASE WHEN SalariedFlag = 0 THEN BusinessEntityID END ASC;


--33. � partir du tableau suivant, �crivez une requ�te en SQL pour d�finir le r�sultat dans l'ordre par la colonne TerritoryName 
--lorsque la colonne CountryRegionName est �gale � � �tats-Unis � et par CountryRegionName pour toutes les autres lignes.

SELECT BusinessEntityID, LastName, TerritoryName, CountryRegionName  
FROM Sales.vSalesPerson  
WHERE TerritoryName IS NOT NULL  
ORDER BY CASE CountryRegionName WHEN 'United States' THEN TerritoryName  
         ELSE CountryRegionName END;

--Cette requ�te s�lectionne les colonnes BusinessEntityID, LastName, TerritoryName et CountryRegionName de la vue Sales.vSalesPerson.
--La clause WHERE filtre les lignes pour ne conserver que celles o� la colonne TerritoryName n�est pas nulle. 
--La clause ORDER BY utilise une instruction CASE pour trier les lignes en fonction de la valeur de CountryRegionName: 
--si CountryRegionName est �gal � 'United States', les lignes sont tri�es par ordre croissant de TerritoryName; 
--pour toutes les autres lignes, elles sont tri�es par ordre croissant de CountryRegionName.

--En ce qui concerne votre question sur la vue Sales.vSalesPerson, il s�agit d�une vue dans la base de donn�es AdventureWorks. 
--Une vue est un objet de base de donn�es qui renvoie un ensemble de r�sultats bas� sur une ou plusieurs tables ou vues. 
--Dans ce cas, la vue Sales.vSalesPerson renvoie des informations sur les employ�s des ventes en combinant des donn�es provenant de plusieurs tables. 
--Si vous utilisez la base de donn�es AdventureWorks, cette vue devrait exister. 
--Sinon, vous devrez peut-�tre ajuster le code pour utiliser les tables appropri�es dans votre base de donn�es

----------------------------------------------------------------

--34. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver les personnes qui vivent dans un territoire et la valeur de salesytd sauf 0. 
--Renvoyez le pr�nom, le nom et le num�ro de ligne sous la forme � Num�ro de ligne �, � Rang �, � Rang dense ' et NTILE comme 'Quartile', salesytd et postalcode. 
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

--Cette requ�te calcule directement les fonctions de fen�tre ROW_NUMBER, RANK, DENSE_RANK et NTILE sur les donn�es de la table Sales.
--SalesPerson jointe aux tables Person.Person et Person.Address. 
--La clause WHERE filtre les lignes pour ne conserver que celles o� la colonne TerritoryID n�est pas nulle et la colonne SalesYTD est diff�rente de 0.
--La requ�te s�lectionne les colonnes calcul�es ainsi que les colonnes FirstName, LastName, SalesYTD et PostalCode, 
--et trie les r�sultats par ordre croissant de la colonne PostalCode
-- ########################################
--ROW_NUMBER: Attribue un num�ro d�ordre unique � chaque ligne.
--RANK: Attribue un rang � chaque ligne, en sautant des rangs en cas d��galit�.
--DENSE_RANK: Attribue un rang � chaque ligne, sans sauter de rangs en cas d��galit�.
--NTILE: Divise les lignes en groupes de taille approximativement �gale.
-- ########################################


--------------------------------------------

--35. � partir du tableau suivant, �crivez une requ�te en SQL pour ignorer les 10 premi�res lignes 
--de l'ensemble de r�sultats tri�s et renvoyer toutes les lignes restantes.

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 10 ROWS;

--------------------------------------------
--36. � partir du tableau suivant, �crivez une requ�te en SQL pour ignorer les 5 premi�res lignes 
--et renvoyer les 5 lignes suivantes de l'ensemble de r�sultats tri�s.

SELECT *
FROM HumanResources.Department
ORDER BY DepartmentID
    OFFSET 5 ROWS
    FETCH NEXT 5 ROWS ONLY;

--------------------------------------------
--37. � partir du tableau suivant, �crivez une requ�te en SQL pour r�pertorier tous les produits de couleur rouge ou bleue. 
--Renvoie le nom, la couleur et le prix de liste. Trie ce r�sultat par prix de liste de colonne.

SELECT Name , Color , ListPrice
FROM Production.Product
WHERE Color = 'Red' or Color = 'blue'
ORDER BY ListPrice 

--------------------------------------------
--38. Cr�ez une requ�te SQL � partir de la table SalesOrderDetail pour r�cup�rer le nom du produit et toutes les commandes client associ�es. 
--De plus, il renvoie toutes les commandes client qui ne comportent aucun article mentionn� dans la table Produit ainsi que tous les produits 
--qui ont des commandes client autres que celles qui y sont r�pertori�es. 
--Renvoyez le nom du produit, l'identifiant de la commande. Triez le jeu de r�sultats dans la colonne du nom du produit.

SELECT Name , SalesOrderID
FROM Sales.SalesOrderDetail AS S
    FULL OUTER JOIN Production.Product AS p 
    on S.ProductID = p.ProductID
ORDER BY Name

--39. � partir du tableau suivant, �crivez une requ�te SQL pour r�cup�rer le nom du produit et
--l'ID de la commande. Les produits command�s et non command�s sont inclus dans l�ensemble de r�sultats.

SELECT Name , SalesOrderID
FROM  Production.Product AS p
    LEFT JOIN  Sales.SalesOrderDetail AS S
    on p.ProductID = S.ProductID
ORDER BY Name