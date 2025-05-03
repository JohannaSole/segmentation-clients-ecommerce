# Projet 5 - Segmentation client pour Olist

## Contexte

Vous avez rejoint Olist dans un contexte de recrutement intensif afin de monter leur équipe Data. Avant de réaliser une segmentation client, on vous a attribué une mission urgente pour aider Fernanda, Lead Data Analyst chez Olist, à intégrer certaines requêtes SQL au Dashboard Customer Experience de l’entreprise. Ce Dashboard expose des KPIs essentiels pour le service client et il est alimenté par des requêtes SQL sur la base de données à laquelle vous avez accès.

Une fois cette tâche résolue, votre mission principale est d’aider Olist à réaliser une segmentation des clients qui sera utilisée au quotidien par l’équipe marketing pour leurs campagnes de communication.

### Objectifs

1. **Analyse exploratoire des données** : Comprendre les données à disposition pour pouvoir réaliser la segmentation.
2. **Modélisation de la segmentation client** : Appliquer des méthodes non supervisées pour regrouper les clients en fonction de leur comportement et données personnelles.
3. **Proposition d’une fréquence de mise à jour** : Déterminer la fréquence à laquelle la segmentation doit être mise à jour pour rester pertinente.
4. **Préparation des livrables** : Fournir les documents nécessaires pour la validation et la présentation des résultats à l’équipe.

## Données

Les données fournies par Olist sont anonymisées et contiennent des informations sur l’historique des commandes, les produits achetés, les commentaires de satisfaction et la localisation des clients depuis janvier 2017. Vous devez utiliser ces données pour créer une segmentation des clients qui sera ensuite utilisée par l’équipe Marketing.

Le jeu de données peut être téléchargé depuis [Kaggle - Brazilian E-commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

## Méthodes utilisées

- **Analyse exploratoire des données** : Vous utiliserez des méthodes statistiques pour comprendre la répartition des clients, l’identification des anomalies, et la préparation des données pour la modélisation.
- **Clustering non supervisé** : Vous appliquerez des méthodes telles que le K-Means ou DBSCAN pour segmenter les clients.
- **Analyse de la stabilité des segments** : Vous effectuerez une simulation pour estimer la fréquence à laquelle le modèle de segmentation doit être mis à jour.

## Structure du projet

1. **1. Script des requêtes SQL** : Ce script contient les requêtes nécessaires pour alimenter le Dashboard Customer Experience.
   - `Sole_Johanna_1_script_032025.sql`
   
2. **2. Notebook d’analyse exploratoire** : Ce notebook contient l’analyse des données, le nettoyage des données et les premières visualisations pour mieux comprendre les segments de clients.
   - `Sole_Johanna_2_notebook_exploration_032025.ipynb`

3. **3. Notebook d’essais des différentes approches de modélisation** : Ce notebook contient les tests des différentes méthodes de clustering pour déterminer la meilleure approche pour la segmentation des clients.
   - `Sole_Johanna_3_notebook_essais_032025.ipynb`
   
4. **4. Notebook de simulation pour la fréquence de mise à jour** : Ce notebook contient les simulations permettant de déterminer à quelle fréquence la segmentation des clients doit être mise à jour pour rester pertinente.
   - `Sole_Johanna_4_notebook_simulation_032025.ipynb`

5. **5. Présentation** : Une présentation pour expliquer votre approche et obtenir des retours d’un collègue sur votre travail.
   - `Sole_Johanna_5_presentation_032025.pdf`

## Résultats attendus

- Une segmentation claire et actionable des clients d’Olist, avec une description de la logique sous-jacente.
- Une analyse sur la fréquence de mise à jour nécessaire pour que la segmentation reste pertinente au fil du temps.
- Une présentation et des livrables exploitables pour l’équipe Marketing d’Olist.
