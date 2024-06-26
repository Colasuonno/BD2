-- 1. Quanti sono gli strutturati di ogni fascia?


SELECT posizione, COUNT(*) AS nstrutturati FROM Persona GROUP BY posizione;

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

SELECT COUNT(*) AS numero FROM Persona p WHERE p.stipendio >= 40000;

--- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

SELECT COUNT(*) FROM Progetto p WHERE p.fine IS NOT NULL AND p.budget > 50000;

--4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto ‘Pegasus’?

SELECT AVG(oreDurata), MAX(oreDurata), MIN(oreDurata)
	FROM AttivitaProgetto ap, Progetto p WHERE p.nome = 'Pegasus' AND ap.progetto = p.id;

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?


6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?
7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?
8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
associati e dei professori ordinari?
9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?
10. Qual è il nome dei progetti su cui lavorano più di due strutturati?
11. Quali sono i professori associati che hanno lavorato su più di un progetto?
