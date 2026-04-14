-- vendite

START TRANSACTION;

INSERT INTO vendite (id_vendita, data_transazione, id_negozio)
  VALUES   (15, CURDATE(), 1);

INSERT INTO dettaglio_vendita (id_vendita, id_prodotto, quantita, unit_price)
  VALUES   (15, 6, 3, 699.99);

UPDATE giacenze g
  JOIN negozi n
  ON g.id_magazzino = n.id_magazzino
  SET g.quantita_disponibile = g.quantita_disponibile - 3
WHERE n.id_negozio = 1
  AND g.id_prodotto = 6;

COMMIT;
