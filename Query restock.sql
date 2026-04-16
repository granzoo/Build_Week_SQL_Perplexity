/*
Query per il restock:
Qui non c'è nessu input manuale da dare, semplicemente usiamo la DML per controllare la
merce in magazzino che è sotto la soglia della propria categoria, in modo da facilitare
il processo di acquisto agli addetti al restock.
*/

SELECT 
    g.id_magazzino,				-- 	\
    m.nome_magazzino,			-- 	-\
    g.id_prodotto,				-- 	--> informazioni di base
    p.nome_prodotto,			--  -/
    g.quantita_disponibile,		-- -/
    s.livello_restock,			-- /
    IF(s.livello_restock < g.quantita_disponibile, 'IN STOCK', 'FARE RESTOCK') AS giacenza_magazzino	-- "suddivide" la merce sufficientemente stoccata da quella che necessita restock, restituendo un valore "binario"
FROM giacenze g
JOIN magazzini m 
    ON g.id_magazzino = m.id_magazzino
JOIN anagrafica_prodotto p 
    ON g.id_prodotto = p.id_prodotto
JOIN soglie_restock s
	ON g.id_magazzino = s.id_magazzino
GROUP BY g.id_prodotto, g.id_magazzino, s.livello_restock	-- l'addetto al restock visualizza solamente la merce che necessita la sua attenzione per procedere con l'operazione di acquisto dai fornitori
HAVING giacenza_magazzino = 'FARE RESTOCK';
