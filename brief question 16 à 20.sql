--16. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer le nombre d'employ�s pour chaque ville.
--Ville de retour et nombre d�employ�s. Triez le r�sultat par ordre croissant par ville.

--Exemple de table : Person.BusinessEntityAddress

SELECT a.City, COUNT(b.AddressID) AS NoOfEmployees 
FROM Person.BusinessEntityAddress AS b   
    INNER JOIN Person.Address AS a  
        ON b.AddressID = a.AddressID  
GROUP BY a.City  
ORDER BY a.City;

-- Cette requ�te utilise l�instruction SELECT pour sp�cifier les colonnes � renvoyer dans les r�sultats,
-- ainsi que l�agr�gat COUNT pour calculer le nombre d�employ�s pour chaque ville. L�instruction FROM sp�cifie la table principale 
-- � partir de laquelle les donn�es doivent �tre r�cup�r�es, et l�instruction INNER JOIN joint cette table avec la table Person.Address 
-- en utilisant la condition ON b.AddressID = a.AddressID. L�instruction GROUP BY a.City regroupe les r�sultats par ville, et l�instruction 
-- ORDER BY a.City trie les r�sultats en ordre croissant en fonction de la colonne city.

----------------------------------------------

--17. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer le total des ventes pour chaque ann�e. 
--Renvoyez l�ann�e de la date de commande et le montant total d�. 
--Triez le r�sultat par ordre croissant sur la partie ann�e de la date de commande.

--Exemple de tableau : Sales.SalesOrderHeader


SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

----------------------------------------------


--18. � partir du tableau suivant, �crivez une requ�te en SQL pour r�cup�rer le total des ventes pour chaque ann�e.
--Filtrez l'ensemble de r�sultats pour les commandes dont l'ann�e de commande est �gale ou ant�rieure � 2016. <--- ne pas oublier 2016
--Renvoie la partie ann�e de la date de commande et le montant total d�. 
--Triez le r�sultat par ordre croissant sur la partie ann�e de la date de commande.

--Exemple de tableau : Sales.SalesOrderHeader

SELECT YEAR(OrderDate) AS OrderYear, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= 2016
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear ASC;

----------------------------------------------

--19. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver les contacts d�sign�s comme responsables dans diff�rents d�partements. 
--Renvoie ContactTypeID, nom. 
--Triez l�ensemble de r�sultats par ordre d�croissant.

--Exemple de tableau : Personne.ContactType

SELECT ContactTypeID, Name
FROM Person.ContactType
WHERE Name LIKE '%Manager%'
ORDER BY ContactTypeID DESC;

--Cette requ�te utilise la fonction -- LIKE --  pour filtrer les r�sultats pour les contacts dont le nom contient le mot �Manager�

----------------------------------------------

--20. � partir des tableaux suivants, �crivez une requ�te en SQL pour cr�er une liste de contacts d�sign�s 
--comme � responsable des achats �. Renvoie les colonnes BusinessEntityID, LastName et FirstName. T
--riez le jeu de r�sultats par ordre croissant de LastName et FirstName.

--Exemple de table : Person.BusinessEntityContact

SELECT P.BusinessEntityID, P.LastName, P.FirstName
FROM Person.BusinessEntityContact AS BEC
	JOIN Person.ContactType AS CT
		ON BEC.ContactTypeID = CT.ContactTypeID
	JOIN Person.Person AS P
		ON BEC.PersonID = P.BusinessEntityID
WHERE CT.Name = 'Purchasing Manager'
ORDER BY P.LastName ASC, P.FirstName ASC;