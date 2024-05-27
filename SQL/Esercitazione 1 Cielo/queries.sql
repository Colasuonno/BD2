--- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?

SELECT codice, comp FROM Volo WHERE durataMinuti > 60*3


--- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?

SELECT distinct comp FROM Volo WHERE durataMinuti > 60*3

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con codice ‘CIA’?

SELECT v.codice, v.comp, ap.codice
    FROM Volo AS v, ArrPart AS ap
    WHERE ap.codice = v.codice AND ap.partenza = 'CIA'


-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice ‘FCO’?

SELECT distinct v.comp FROM Volo AS v, ArrPart as ap WHERE v.comp = ap.comp AND ap.arrivo = 'FCO'

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’ e arrivano all’aeroporto ‘JFK’?

SELECT v.codice, v.comp FROM Volo AS v, ArrPart as ap WHERE v.codice = ap.codice AND ap.arrivo = 'JFK' AND ap.partenza = 'FCO'

--- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atterrano all’aeroporto ‘JFK’?

SELECT distinct v.comp FROM Volo AS v, ArrPart as ap WHERE v.codice = ap.codice AND ap.arrivo = 'JFK' AND ap.partenza = 'FCO'

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla città di ‘New York’?

SELECT distinct v.comp FROM Volo as v, ArrPart as ap, LuogoAeroporto as lp, LuogoAeroporto as lp2
	WHERE v.codice = ap.codice AND
	(ap.arrivo = lp.aeroporto AND lp.citta = 'New York') AND
	(ap.partenza = lp2.aeroporto AND lp2.citta = 'Roma')


-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli della compagnia di nome ‘MagicFly’?

SELECT distinct a.codice, a.nome, lp.citta FROM Aeroporto AS a, LuogoAeroporto AS lp, Volo as v, ArrPart as ap
	WHERE v.comp = 'MagicFly' AND
		v.codice = ap.codice AND
		ap.partenza = a.codice AND
		ap.partenza = lp.aeroporto

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e atterrano ad un qualunque aeroporto della città di ‘New York’? Restituire: codice del volo, nome della compagnia, e aeroporti di partenza e arrivo.

SELECT v.codice, v.comp, ap.partenza, ap.arrivo FROM Volo AS v, LuogoAeroporto as lp_part, LuogoAeroporto AS lp_arr, ArrPart as ap WHERE
	lp_part.citta = 'Roma' AND
	ap.codice = v.codice AND
	lp_arr.citta = 'New York' AND
	ap.partenza = lp_part.aeroporto AND
	ap.arrivo = lp_arr.aeroporto

-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un qualunque aeroporto della città di ‘New York’? Restituire: nome della compagnia, codici dei voli, e aeroporti di partenza, scalo e arrivo.

SELECT DISTINCT ap_scalo.comp AS Compagnia, ap_scalo.partenza AS partenza, ap_scalo.codice AS partenza_codice, ap_scalo.arrivo AS scalo_aeroporto, ap_arrivo.arrivo AS arrivo_aeroporto
	FROM ArrPart ap_scalo, ArrPart ap_arrivo, LuogoAeroporto AS lp_part, LuogoAeroporto AS lp_arr WHERE
		lp_part.citta = 'Roma' AND
		lp_arr.citta = 'New York' AND
		ap_scalo.partenza = lp_part.aeroporto AND
		ap_arrivo.arrivo = lp_arr.aeroporto AND
		ap_scalo.arrivo != lp_arr.aeroporto AND
		ap_scalo.codice != ap_arrivo.codice



-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?

SELECT DISTINCT ap.comp FROM ArrPart as ap, Compagnia AS c WHERE
	ap.partenza = 'FCO' AND
	ap.arrivo = 'JFK' AND
	ap.comp = c.nome AND
	c.annoFondaz IS NOT NULL
