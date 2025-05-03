-- Liste des tables dans la base de données
SELECT name FROM sqlite_master WHERE type='table';

-- Table customers
SELECT * FROM customers LIMIT 5; 
-- Nombre total de lignes: 99 441
SELECT COUNT(*) FROM customers; 

-- Table geoloc
SELECT * FROM geoloc LIMIT 5;
-- Nombre total de lignes: 1 000 163
SELECT COUNT(*) FROM geoloc;

-- Table order_items
SELECT * FROM order_items LIMIT 5;
-- Nombre total de lignes: 112 650
SELECT COUNT(*) FROM order_items;

-- Table order_pymts
SELECT * FROM order_pymts LIMIT 5;
-- Nombre total de lignes: 103 886
SELECT COUNT(*) FROM order_pymts;

-- Table order_reviews
SELECT * FROM order_reviews LIMIT 5;
-- Nombre total de lignes: 99 224
SELECT COUNT(*) FROM order_reviews;

-- Table orders
SELECT * FROM orders LIMIT 5;
-- Nombre total de lignes: 99 441
SELECT COUNT(*) FROM orders;

-- Table products
SELECT * FROM products LIMIT 5;
-- Nombre total de lignes: 32 951
SELECT COUNT(*) FROM products;

-- Table sellers
SELECT * FROM sellers LIMIT 5;
-- Nombre total de lignes: 3 095
SELECT COUNT(*) FROM sellers;

-- Table translation
SELECT * FROM translation LIMIT 5;
-- Nombre total de lignes: 71
SELECT COUNT(*) FROM translation;

-- Sélectionner la date d'achat la plus récente dans la table orders: 2018-10-17
SELECT MAX(order_purchase_timestamp) AS max_date
FROM orders;

-- Sélectionner les statuts distincts (uniques) des commandes dans la table order
SELECT DISTINCT order_status FROM orders;

-- En excluant les commandes annulées, quelles sont les commandes
-- récentes de moins de 3 mois que les clients ont reçues avec au moins 3
-- jours de retard ? 322

-- Création d'une sous-requête pour filtrer les commandes récentes et non annulées
WITH recent_orders AS (
    SELECT * 
    FROM orders
    -- Exclure les commandes annulées
    WHERE order_status != 'canceled'
    -- Garder uniquement les commandes livrées dans les 3 derniers mois avant la dernière commande
    AND order_purchase_timestamp >= DATE('2018-10-17', '-3 months')
    -- Garder uniquement les commandes livrées
    AND order_delivered_customer_date IS NOT NULL 
)
-- Sélectionner les commandes qui ont été livrées avec au moins 3 jours de retard
SELECT DISTINCT *
FROM recent_orders
-- Calcul du retard en jours (date de livraison réelle - date de livraison estimée)
WHERE julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) >= 3;


-- Qui sont les vendeurs ayant généré un chiffre d'affaires de plus de 100 000 Real 
-- sur des commandes livrées via Olist ? 17 vendeurs

-- Commandes expédiées (non annulées)
WITH delivered_orders AS (
    SELECT 
        order_id -- Sélectionne uniquement l'id de la commande
    FROM orders
    WHERE order_status = 'delivered'  -- Filtre les commandes avec le statut 'delivered'
),
-- Détails des articles vendus pour ces commandes
order_details AS (
    SELECT 
        oi.order_id, -- Sélectionne l'id de la commande
        oi.seller_id, -- Sélectionne l'id du vendeur
        oi.price -- Sélectionne le prix de l'article
    FROM order_items oi
    INNER JOIN delivered_orders do -- Joint la table 'order_items' avec 'delivered_order'
        ON oi.order_id = do.order_id -- Assure que les articles correspondent aux commandes livrées
),
-- Calcul du chiffre d'affaires par vendeur
seller_revenue AS (
    SELECT 
        seller_id,
        SUM(price) AS total_sales, -- Calcule la somme des prix pour chaque vendeur
        COUNT(DISTINCT order_id) AS orders_count -- Compte le nombre de commandes distinctes par vendeur
    FROM order_details
    GROUP BY seller_id -- Regroupe les résultats par vendeur
)
-- Résultat final : vendeurs avec plus de 100000 Real de CA
SELECT 
    seller_id,
    total_sales, -- Chiffre d'affaires total du vendeur
    orders_count -- Nombre de commandes traitées par le vendeur
FROM seller_revenue
WHERE total_sales > 100000 -- Sélectionne seulement les vendeurs ayant généré plus de 100000 Real
ORDER BY total_sales DESC; 

-- Qui sont les nouveaux vendeurs (moins de 3 mois d'ancienneté) qui
-- sont déjà très engagés avec la plateforme (ayant déjà vendu plus de 30 produits) ? 3

-- Trouver la première vente de chaque vendeur
WITH first_sales AS (
    SELECT 
        seller_id, 
        MIN(order_purchase_timestamp) AS first_sale_date  -- Date de la première vente
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    GROUP BY seller_id
), 
-- Sélectionner les vendeurs dont la première vente a eu lieu il y a moins de 3 mois
recent_sellers AS (
    SELECT seller_id, first_sale_date
    FROM first_sales
    WHERE first_sale_date >= DATE('2018-10-17', '-3 months')  -- On soustrait 3 mois à la dernière date de commande connue
)
-- Compter le nombre total de produits vendus par ces vendeurs récents
SELECT 
    rs.seller_id, 
    rs.first_sale_date,
    COUNT(oi.order_id) AS total_products_sold  -- Nombre total de produits vendus
FROM recent_sellers rs
JOIN order_items oi ON rs.seller_id = oi.seller_id
GROUP BY rs.seller_id, rs.first_sale_date
HAVING COUNT(oi.order_id) > 30  -- Filtrer les vendeurs ayant vendu plus de 30 produits
ORDER BY total_products_sold DESC;


-- Quels sont les 5 codes postaux, enregistrant plus de 30
-- reviews, avec le pire review score moyen sur les 12 derniers mois ?

-- Filtrer les avis des 12 derniers mois
WITH recent_reviews AS (
    SELECT 
        c.customer_zip_code_prefix,   -- Code postal du client
        r.review_score,               -- Score de l'avis donné par le client
        r.order_id                    -- Identifiant de la commande associée à l'avis
    FROM order_reviews r
    JOIN orders o ON r.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    -- Filtrer uniquement les avis des 12 derniers mois
    WHERE o.order_purchase_timestamp >= DATE('2018-10-17', '-12 months')
)
-- Agrégation des avis par code postal du client
SELECT 
    rr.customer_zip_code_prefix,        -- Code postal du client
    COUNT(rr.review_score) AS total_reviews,  -- Nombre total d'avis pour ce code postal
    AVG(rr.review_score) AS avg_review_score  -- Score moyen des avis pour ce code postal
FROM recent_reviews rr
GROUP BY rr.customer_zip_code_prefix  -- Groupement par code postal du client
HAVING COUNT(rr.review_score) > 30         -- Ne garder que les codes postaux avec plus de 30 avis
ORDER BY avg_review_score ASC       -- Trier par score moyen croissant (du pire au meilleur)
LIMIT 5;