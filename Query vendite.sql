/*
Query per le vendite:
L'operatore di vendita segue il processo di vendita dei singoli prodotti in ogni negozio,
aggiornando immediatamente la giacenza disponibile in magazzino (supponendo che il refill
della merce venduta, cioè il passaggio della merce da magazzino a negozio avvenga
in maniera istantanea). Il triplo "SELECT" a fine query funge da ulteriore verifica della
corretta transazione, restituendo ad ogni fine transazione la nuova vendita inserita
e la nuova giacenza aggiornata.
*/

START TRANSACTION;

INSERT INTO vendite (id_vendita, data_transazione, id_negozio)
VALUES (17, CURDATE(), 1);								                     	-- supponendo che ogni negozio (id_negozio) abbia un addetto all'inserimento di ordini eseguiri, l'unico input manuale qui è id_vendita.

INSERT INTO dettaglio_vendita (id_vendita, id_prodotto, quantita, unit_price)
SELECT
	(SELECT MAX(id_vendita) FROM vendite),
    p.id_prodotto,
    3,															                            -- input manuale
    p.prezzo_unitario
FROM anagrafica_prodotto p
WHERE p.id_prodotto = 6;										                    -- input manuale

UPDATE giacenze g
JOIN negozi n ON g.id_magazzino = n.id_magazzino
JOIN dettaglio_vendita dv ON dv.id_prodotto = g.id_prodotto
SET g.quantita_disponibile = g.quantita_disponibile - dv.quantita
WHERE n.id_negozio = 1											                      -- numero fisso del negozio, verrà fornita ad ogni negozio una query con il codice corrispondente al negozio
  AND dv.id_vendita = (SELECT MAX(id_vendita) FROM vendite);	    -- nessun input manuale

COMMIT;

SELECT * FROM giacenze;
SELECT * FROM dettaglio_vendita;
SELECT * FROM vendite;
