
-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?

SELECT a.codice, a.nome, COUNT(distinct ap.comp) FROM ArrPart as ap, Aeroporto as a WHERE
	ap.partenza = a.codice OR
	ap.arrivo = a.codice
	GROUP BY a.codice, a.nome

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?

SELECT COUNT(*) FROM Volo v, ArrPart as ap WHERE v.codice = ap.codice AND ap.partenza = 'HTR' AND v.durataMinuti >= 100
	GROUP BY v.codice

-- 3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella quale opera?
-- Nazione, nAeroporti

SELECT DISTINCT lp.nazione, COUNT(DISTINCT lp.aeroporto) AS n_aeroporti FROM ArrPart ap, LuogoAeroporto lp WHERE
	ap.comp = 'Apitalia' AND
	(ap.arrivo = lp.aeroporto OR ap.partenza = lp.aeroporto)
	GROUP BY lp.nazione

-- 4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla compagnia ‘MagicFly’?

SELECT AVG(durataMinuti), MAX(durataMinuti), MIN(durataMinuti) FROM Volo
	WHERE comp = 'MagicFly' GROUP BY comp

--5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?

SELECT MIN(c.annoFondaz), a.codice, a.nome FROM Compagnia c, ArrPart ap, Aeroporto a WHERE
	(ap.partenza = a.codice OR ap.arrivo = a.codice) AND
	c.annoFondaz IS NOT NULL AND
	ap.comp = c.nome
	GROUP BY a.codice, a.nome

-- 6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?

SELECT DISTINCT COUNT(DISTINCT lp.nazione), lp2.nazione AS nazione_partenza FROM ArrPart ap, LuogoAeroporto lp, LuogoAeroporto lp2 WHERE
	ap.arrivo = lp.aeroporto AND
	ap.partenza = lp2.aeroporto AND
	lp2.nazione != lp.nazione
	GROUP BY lp2.nazione

-- 7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?

SELECT a.codice, a.nome, AVG(v.durataMinuti) FROM Volo v, Aeroporto a, ArrPart ap WHERE
	ap.partenza = a.codice AND
	v.codice = ap.codice
	GROUP BY a.codice, a.nome

-- 8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?

SELECT DISTINCT v.comp, SUM(v.durataMinuti) FROM Volo v, Compagnia c WHERE
	v.comp = c.nome AND
	c.annoFondaz IS NOT NULL AND
	c.annoFondaz >= 1950
	GROUP BY v.comp


-- 9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?

SELECT DISTINCT a.codice, a.nome FROM Aeroporto a, ArrPart ap WHERE
	(ap.partenza = a.codice OR ap.arrivo = a.codice)
	GROUP BY a.codice, a.nome
	HAVING COUNT(DISTINCT ap.comp) = 2

-- 10. Quali sono le città con almeno due aeroporti?

SELECT DISTINCT lp.citta FROM LuogoAeroporto lp
	GROUP BY lp.citta
	HAVING COUNT(DISTINCT lp.aeroporto) >= 2

-- 11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6 ore?

SELECT DISTINCT v.comp FROM Volo v
	GROUP BY v.comp
	HAVING AVG(v.durataMinuti) > 60*6

-- 12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100 minuti?

SELECT DISTINCT v.comp FROM Volo v
	GROUP BY v.comp
	HAVING MIN(v.durataMinuti) > 100

