--16. À partir du tableau suivant, écrivez une requête en SQL pour récupérer le nombre d'employés pour chaque ville.
--Ville de retour et nombre d’employés. Triez le résultat par ordre croissant par ville.

--Exemple de table : Person.BusinessEntityAddress

SELECT a.City, COUNT(b.AddressID) AS NoOfEmployees 
FROM Person.BusinessEntityAddress AS b   
    INNER JOIN Person.Address AS a  
        ON b.AddressID = a.AddressID  
GROUP BY a.City  
ORDER BY a.City;

-- Cette requête utilise l’instruction SELECT pour spécifier les colonnes à renvoyer dans les résultats,
-- ainsi que l’agrégat COUNT pour calculer le nombre d’employés pour chaque ville. L’instruction FROM spécifie la table principale 
-- à partir de laquelle les données doivent être récupérées, et l’instruction INNER JOIN joint cette table avec la table Person.Address 
-- en utilisant la condition ON b.AddressID = a.AddressID. L’instruction GROUP BY a.City regroupe les résultats par ville, et l’instruction 
-- ORDER BY a.City trie les résultats en ordre croissant en fonction de la colonne city.

----------------------------------------------

--17. À partir du tableau suivant, écrivez une requête en SQL pour récupérer le total des ventes pour chaque année. 
--Renvoyez l’année de la date de commande et le montant total dû. 
--Triez le résultat par ordre croissant sur la partie année de la date de commande.

--Exemple de tableau : Sales.SalesOrderHeader


SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

----------------------------------------------


--18. À partir du tableau suivant, écrivez une requête en SQL pour récupérer le total des ventes pour chaque année.
--Filtrez l'ensemble de résultats pour les commandes dont l'année de commande est égale ou antérieure à 2016. <--- ne pas oublier 2016
--Renvoie la partie année de la date de commande et le montant total dû. 
--Triez le résultat par ordre croissant sur la partie année de la date de commande.

--Exemple de tableau : Sales.SalesOrderHeader

SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= 2016
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

----------------------------------------------

--19. À partir du tableau suivant, écrivez une requête en SQL pour trouver les contacts désignés comme responsables dans différents départements. 
--Renvoie ContactTypeID, nom. 
--Triez l’ensemble de résultats par ordre décroissant.

--Exemple de tableau : Personne.ContactType

SELECT ContactTypeID, Name
FROM Person.ContactType
WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID DESC;

--Cette requête utilise la fonction -- LIKE --  pour filtrer les résultats pour les contacts dont le nom contient le mot “Manager”

----------------------------------------------

--20. À partir des tableaux suivants, écrivez une requête en SQL pour créer une liste de contacts désignés 
--comme « responsable des achats ». Renvoie les colonnes BusinessEntityID, LastName et FirstName. T
--riez le jeu de résultats par ordre croissant de LastName et FirstName.

--Exemple de table : Person.BusinessEntityContact

SELECT P.BusinessEntityID, P.LastName, P.FirstName
FROM Person.BusinessEntityContact AS BEC
	JOIN Person.ContactType AS CT
		ON BEC.ContactTypeID = CT.ContactTypeID
	JOIN Person.Person AS P
		ON BEC.PersonID = P.BusinessEntityID
WHERE CT.Name = 'Purchasing Manager'
ORDER BY P.LastName ASC, P.FirstName ASC;