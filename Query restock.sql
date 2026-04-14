SELECT 
    g.id_magazzino,
    m.nome_magazzino,
    g.id_prodotto,
    p.nome_prodotto,
    g.quantita_disponibile,
    s.livello_restock,
    IF(s.livello_restock < g.quantita_disponibile, 'IN STOCK', 'FARE RESTOCK') AS giacenza_magazzino
FROM giacenze g
JOIN magazzini m 
    ON g.id_magazzino = m.id_magazzino
JOIN anagrafica_prodotto p 
    ON g.id_prodotto = p.id_prodotto
JOIN soglie_restock s
	ON g.id_magazzino = s.id_magazzino
GROUP BY g.id_prodotto, g.id_magazzino, s.livello_restock;





