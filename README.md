# Segmentation client pour Olist

## Contexte

Ce projet s’inscrit dans un contexte d’intégration à l’équipe Data d’Olist. Avant de réaliser une segmentation client, une mission urgente a consisté à intégrer des requêtes SQL dans le Dashboard Customer Experience, essentiel pour le suivi des KPIs du service client.

La mission principale est ensuite de réaliser une segmentation client utilisée par l’équipe marketing pour cibler leurs campagnes.

## Objectifs

- Analyse exploratoire des données pour comprendre les informations disponibles  
- Modélisation de la segmentation client avec des méthodes non supervisées  
- Proposition d’une fréquence de mise à jour de la segmentation pour garantir sa pertinence  
- Préparation des livrables pour validation et présentation auprès de l’équipe  

## 📂 Données

Les données anonymisées fournies par Olist contiennent l’historique des commandes, les produits achetés, les commentaires de satisfaction, et la localisation des clients depuis janvier 2017.

Elles sont disponibles librement sur Kaggle :  
👉 [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Méthodes utilisées

- Analyse statistique et exploration des données pour détecter anomalies et préparer la modélisation  
- Application de méthodes de clustering non supervisé (K-Means, DBSCAN) pour segmenter les clients  
- Simulation pour estimer la stabilité des segments et la fréquence de mise à jour nécessaire  

## Structure du projet

1. **Script SQL** : requêtes pour alimenter le Dashboard Customer Experience  
   `Sole_Johanna_1_script_032025.sql`  
2. **Notebook d’analyse exploratoire** : nettoyage et visualisations des données clients  
   `Sole_Johanna_2_notebook_exploration_032025.ipynb`  
3. **Notebook d’essais de modélisation** : tests de différentes approches de clustering  
   `Sole_Johanna_3_notebook_essais_032025.ipynb`  
4. **Notebook de simulation** : détermination de la fréquence optimale de mise à jour  
   `Sole_Johanna_4_notebook_simulation_032025.ipynb`  
5. **Présentation** : synthèse et retours sur la segmentation  
   `Sole_Johanna_5_presentation_032025.pdf`  

## Résultats attendus

- Une segmentation claire, exploitable et compréhensible des clients d’Olist  
- Une analyse rigoureuse de la fréquence de mise à jour nécessaire pour garder la segmentation pertinente  
- Des livrables prêts à être utilisés par l’équipe Marketing  

## Auteur

Johanna Solé  
Projet réalisé dans le cadre d’une formation Data Scientist.
