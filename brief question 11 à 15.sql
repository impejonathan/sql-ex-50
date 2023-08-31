--11. � partir des tableaux suivants, �crivez une requ�te en SQL pour trouver les personnes dont le nom de famille
--commence par la lettre � L �. Renvoie BusinessEntityID, FirstName, LastName et PhoneNumber. 
--Triez le r�sultat par nom et pr�nom.

--Exemple de tableau : Personne.PersonPhone

SELECT p.BusinessEntityID, p.FirstName, p.LastName, pp.PhoneNumber
FROM Person.Person AS p
JOIN Person.PersonPhone AS pp
ON p.BusinessEntityID = pp.BusinessEntityID
WHERE p.LastName LIKE 'L%'
ORDER BY p.LastName, p.FirstName;

--12. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver la somme de la colonne du sous-total. 
--Regroupez la somme sur un identifiant de vendeur et un identifiant de client distincts. Regroupe les r�sultats en sous-total et total cumul�. 
--Renvoie l'ID du vendeur, l'ID du client et la somme de la colonne du sous-total, c'est-�-dire sum_subtotal.

--Exemple de tableau : sales.salesorderheader

SELECT salespersonid, customerid, SUM(subtotal) AS sum_subtotal
FROM sales.salesorderheader
GROUP BY ROLLUP(salespersonid, customerid)

--13.� partir du tableau suivant, �crivez une requ�te en SQL pour trouver la somme de la quantit� de toutes 
--les combinaisons de groupes d'ID d'emplacement distincts et de colonnes d'�tag�re. 
--Renvoie l'ID d'emplacement, l'�tag�re et la somme de la quantit� sous la forme TotalQuantity.

--Exemple de tableau : production.productinventory

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY locationid, shelf

-- ## la solution

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY CUBE (locationid, shelf)
ORDER BY TotalQuantity DESC;

-- L�op�rateur CUBE g�n�re un jeu de r�sultats avec des sous-totaux pour toutes les combinaisons possibles 
-- des colonnes sp�cifi�es dans l�instruction GROUP BY. Dans ce cas, il g�n�rera des sous-totaux pour toutes 
-- les combinaisons de locationid et shelf. L�instruction ORDER BY TotalQuantity DESC trie les r�sultats en 
-- ordre d�croissant en fonction de la colonne TotalQuantity. Ainsi, les lignes avec les valeurs les plus 
-- �lev�es de TotalQuantity appara�tront en premier dans les r�sultats.

----------------------------------------------------------------

--14. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver la somme de la quantit� avec le sous-total pour chaque ID d'emplacement. 
--Regroupez les r�sultats pour toutes les combinaisons d�identifiant d�emplacement et de colonne d��tag�re distincts. 
--Regroupe les r�sultats en sous-total et total cumul�. Renvoie l'ID d'emplacement, l'�tag�re et la somme de la quantit� sous la forme TotalQuantity.

--Exemple de tableau : production.productinventory

SELECT locationid, shelf, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( ROLLUP (locationid, shelf), CUBE (locationid, shelf) )
ORDER BY TotalQuantity DESC;


-- L�op�rateur GROUPING SETS permet de sp�cifier plusieurs groupes de colonnes � regrouper dans une seule instruction GROUP BY. 
-- Dans ce cas, nous utilisons les op�rateurs ROLLUP et CUBE pour g�n�rer des sous-totaux pour toutes les combinaisons de locationid et shelf, 
-- ainsi que des sous-totaux pour chaque combinaison de locationid et shelf et un grand total pour tous les emplacements.

----------------------------------------------------------------

--15. � partir du tableau suivant, �crivez une requ�te en SQL pour trouver la quantit� totale pour chaque ID d'emplacement et calculez le total g�n�ral pour tous les emplacements.
--Retourner l'identifiant de localisation et la quantit� totale. Regroupez les r�sultats sur locationid.

--Exemple de tableau : production.productinventory

SELECT locationid, SUM(quantity) AS TotalQuantity
FROM production.productinventory
GROUP BY GROUPING SETS ( locationid, () )

-- L�op�rateur GROUPING SETS permet de sp�cifier plusieurs groupes de colonnes � regrouper dans une seule instruction GROUP BY. 
-- Dans ce cas, nous utilisons GROUPING SETS ( locationid, () ) pour g�n�rer des sous-totaux pour chaque locationid, 
-- ainsi qu�un grand total pour tous les emplacements. L�instruction ORDER BY TotalQuantity DESC 
-- trie les r�sultats en ordre d�croissant en fonction de la colonne TotalQuantity. 
-- Ainsi, les lignes avec les valeurs les plus �lev�es de TotalQuantity appara�tront en premier dans les r�sultats.