--11. À partir des tableaux suivants, écrivez une requête en SQL pour trouver les personnes dont le nom de famille
--commence par la lettre « L ». Renvoie BusinessEntityID, FirstName, LastName et PhoneNumber. 
--Triez le résultat par nom et prénom.

--Exemple de tableau : Personne.PersonPhone

SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp
ON p.BusinessEntityID = pp.BusinessEntityID
WHERE p.LastName LIKE 'L%'
ORDER BY p.LastName, p.FirstName;

--12. À partir du tableau suivant, écrivez une requête en SQL pour trouver la somme de la colonne du sous-total. 
--Regroupez la somme sur un identifiant de vendeur et un identifiant de client distincts. Regroupe les résultats en sous-total et total cumulé. 
--Renvoie l'ID du vendeur, l'ID du client et la somme de la colonne du sous-total, c'est-à-dire sum_subtotal.

--Exemple de tableau : sales.salesorderheader

SELECT salespersonid, customerid, SUM(subtotal) AS sum_subtotal
FROM sales.salesorderheader
GROUP BY ROLLUP(salespersonid, customerid)

--13.À partir du tableau suivant, écrivez une requête en SQL pour trouver la somme de la quantité de toutes 
--les combinaisons de groupes d'ID d'emplacement distincts et de colonnes d'étagère. 
--Renvoie l'ID d'emplacement, l'étagère et la somme de la quantité sous la forme TotalQuantity.

--Exemple de tableau : production.productinventory

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY locationid, shelf

-- ## la solution

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY CUBE (locationid, shelf)
ORDER BY TotalQuantity DESC;

-- L’opérateur CUBE génère un jeu de résultats avec des sous-totaux pour toutes les combinaisons possibles 
-- des colonnes spécifiées dans l’instruction GROUP BY. Dans ce cas, il générera des sous-totaux pour toutes 
-- les combinaisons de locationid et shelf. L’instruction ORDER BY TotalQuantity DESC trie les résultats en 
-- ordre décroissant en fonction de la colonne TotalQuantity. Ainsi, les lignes avec les valeurs les plus 
-- élevées de TotalQuantity apparaîtront en premier dans les résultats.

----------------------------------------------------------------

--14. À partir du tableau suivant, écrivez une requête en SQL pour trouver la somme de la quantité avec le sous-total pour chaque ID d'emplacement. 
--Regroupez les résultats pour toutes les combinaisons d’identifiant d’emplacement et de colonne d’étagère distincts. 
--Regroupe les résultats en sous-total et total cumulé. Renvoie l'ID d'emplacement, l'étagère et la somme de la quantité sous la forme TotalQuantity.

--Exemple de tableau : production.productinventory

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) )
ORDER BY TotalQuantity DESC;


-- L’opérateur GROUPING SETS permet de spécifier plusieurs groupes de colonnes à regrouper dans une seule instruction GROUP BY. 
-- Dans ce cas, nous utilisons les opérateurs ROLLUP et CUBE pour générer des sous-totaux pour toutes les combinaisons de locationid et shelf, 
-- ainsi que des sous-totaux pour chaque combinaison de locationid et shelf et un grand total pour tous les emplacements.

----------------------------------------------------------------

--15. À partir du tableau suivant, écrivez une requête en SQL pour trouver la quantité totale pour chaque ID d'emplacement et calculez le total général pour tous les emplacements.
--Retourner l'identifiant de localisation et la quantité totale. Regroupez les résultats sur locationid.

--Exemple de tableau : production.productinventory

SELECT locationid, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( locationid, () )

-- L’opérateur GROUPING SETS permet de spécifier plusieurs groupes de colonnes à regrouper dans une seule instruction GROUP BY. 
-- Dans ce cas, nous utilisons GROUPING SETS ( locationid, () ) pour générer des sous-totaux pour chaque locationid, 
-- ainsi qu’un grand total pour tous les emplacements. L’instruction ORDER BY TotalQuantity DESC 
-- trie les résultats en ordre décroissant en fonction de la colonne TotalQuantity. 
-- Ainsi, les lignes avec les valeurs les plus élevées de TotalQuantity apparaîtront en premier dans les résultats.