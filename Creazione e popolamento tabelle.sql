-- creiamo il database
CREATE SCHEMA vendicose_spa_perplexity;

-- creiamo le tabelle categoria_prodotto, anagrafica_prodotto, magazzini, negozi, giacenze, soglie restock, vendite, dettaglio vendite.
CREATE TABLE categoria_prodotto (
    id_categoria INT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE anagrafica_prodotto (
    id_prodotto INT PRIMARY KEY,
    nome_prodotto VARCHAR(100) NOT NULL,
    descrizione TEXT,
    prezzo_unitario DECIMAL(10,2) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria_prodotto(id_categoria)
);

CREATE TABLE magazzini (
    id_magazzino INT PRIMARY KEY,
    nome_magazzino VARCHAR(100) NOT NULL,
    indirizzo VARCHAR(200) NOT NULL,
    citta VARCHAR(100) NOT NULL,
    capacita_massima INT NOT NULL
);

CREATE TABLE negozi (
    id_negozio INT PRIMARY KEY,
    nome_negozio VARCHAR(100) NOT NULL,
    indirizzo VARCHAR(200) NOT NULL,
    citta VARCHAR(100) NOT NULL,
    id_magazzino INT NOT NULL,
    FOREIGN KEY (id_magazzino) REFERENCES magazzini(id_magazzino)
);

CREATE TABLE giacenze (
    id_magazzino INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita_disponibile INT NOT NULL,
    PRIMARY KEY (id_magazzino, id_prodotto),
    FOREIGN KEY (id_magazzino) REFERENCES magazzini(id_magazzino),
    FOREIGN KEY (id_prodotto) REFERENCES anagrafica_prodotto(id_prodotto)
);

CREATE TABLE soglie_restock (
    id_magazzino INT NOT NULL,
    id_categoria INT NOT NULL,
    livello_restock INT NOT NULL,
    PRIMARY KEY (id_magazzino, id_categoria),
    FOREIGN KEY (id_magazzino) REFERENCES magazzini(id_magazzino),
    FOREIGN KEY (id_categoria) REFERENCES categoria_prodotto(id_categoria)
);

CREATE TABLE vendite (
    id_vendita INT PRIMARY KEY,
    data_transazione DATE NOT NULL,
    id_negozio INT NOT NULL,
    FOREIGN KEY (id_negozio) REFERENCES negozi(id_negozio)
);

CREATE TABLE dettaglio_vendita (
    id_vendita INT NOT NULL,
    id_prodotto INT NOT NULL,
    quantita INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_vendita, id_prodotto),
    FOREIGN KEY (id_vendita) REFERENCES vendite(id_vendita),
    FOREIGN KEY (id_prodotto) REFERENCES anagrafica_prodotto(id_prodotto)
);

-- inseriamo valori dentro le tabelle
INSERT INTO categoria_prodotto
    VALUES  (1, 'Elettronica'),
            (2, 'Abbigliamento'),
            (3, 'Alimentari'),
            (4, 'Giocattoli'),
            (5, 'Sport');

-- prodotti
INSERT INTO anagrafica_prodotto
    VALUES  (1, 'Smartphone X1', 'Smartphone di ultima generazione', 699.99, 1),
            (2, 'Tablet Plus', 'Tablet da 10 pollici', 399.99, 1),
            (3, 'Giacca Invernale', 'Giacca impermeabile da uomo', 129.99, 2),
            (4, 'T-shirt Basic', 'Maglietta in cotone', 19.99, 2),
            (5, 'Pasta Barilla', 'Pasta di semola 500g', 1.99, 3),
            (6, 'Latte Intero', 'Latte fresco 1L', 1.59, 3),
            (7, 'LEGO City', 'Set LEGO 500 pezzi', 49.99, 4),
            (8, 'Puzzle 1000 pezzi', 'Puzzle paesaggio', 14.99, 4),
            (9, 'Scarpe Running', 'Scarpe da corsa professionali', 89.99, 5),
            (10, 'Tappetino Yoga', 'Tappetino antiscivolo', 24.99, 5);

-- magazzini
INSERT INTO magazzini
    VALUES  (1, 'Magazzino Nord', 'Via Roma 1', 'Milano', 5000),
            (2, 'Magazzino Sud', 'Via Napoli 5', 'Napoli', 4000),
            (3, 'Magazzino Centro', 'Via Firenze 2', 'Firenze', 4500);

-- negozi
INSERT INTO negozi
    VALUES  (1, 'Negozio Milano Centro', 'Corso Buenos Aires 10', 'Milano', 1),
            (2, 'Negozio Monza', 'Via Italia 22', 'Monza', 1),
            (3, 'Negozio Napoli Centro', 'Via Toledo 25', 'Napoli', 2),
            (4, 'Negozio Salerno', 'Corso Vittorio Emanuele 8', 'Salerno', 2),
            (5, 'Negozio Firenze Centro', 'Via Dante 8', 'Firenze', 3),
            (6, 'Negozio Prato', 'Piazza Mercatale 4', 'Prato', 3);

-- soglie restock
INSERT INTO soglie_restock
    VALUES  (1, 1, 40),(1, 2, 60),(1, 3, 120),(1, 4, 30),(1, 5, 35),
            (2, 1, 30),(2, 2, 50),(2, 3, 150),(2, 4, 25),(2, 5, 40),
            (3, 1, 35),(3, 2, 45),(3, 3, 100),(3, 4, 20),(3, 5, 30);

-- giacenze
INSERT INTO giacenze
    VALUES  (1, 1, 50),(1, 2, 45),(1, 3, 80),(1, 4, 120),(1, 5, 200),
            (1, 6, 180),(1, 7, 35),(1, 8, 40),(1, 9, 60),(1, 10, 55),
            (2, 1, 28),(2, 2, 40),(2, 3, 70),(2, 4, 90),(2, 5, 160),
            (2, 6, 140),(2, 7, 20),(2, 8, 22),(2, 9, 45),(2, 10, 38),
            (3, 1, 36),(3, 2, 50),(3, 3, 65),(3, 4, 85),(3, 5, 110),
            (3, 6, 95),(3, 7, 18),(3, 8, 25),(3, 9, 28),(3, 10, 32);

-- vendite
INSERT INTO vendite
    VALUES  (1, '2026-04-01', 1),
            (2, '2026-04-02', 3),
            (3, '2026-04-03', 5),
            (4, '2026-04-04', 2),
            (5, '2026-04-05', 4);

-- dettaglio vendite
INSERT INTO dettaglio_vendita
    VALUES  (1, 1, 3, 699.99),(1, 5, 10, 1.99),(1, 7, 2, 49.99),
            (2, 3, 4, 129.99),(2, 6, 12, 1.59),
            (3, 9, 3, 89.99),(3, 10, 5, 24.99),
            (4, 2, 2, 399.99),(4, 4, 6, 19.99),
            (5, 5, 15, 1.99),(5, 8, 3, 14.99);
