# Methodes-non-parametrique-en-analyse-de-survie
Un projet académique permettant de mettre en application (programmation et analyse de données) les méthodes d'estimations de survie : kaplan Meyer, Harrington-Flemming, tests de log-rank

Dans une première partie on écris une fonction prenant en argument un vecteur de `dates` (non ordonnées), un vecteur de `status` (0 ou 1) et qui renvoie l’estimateur de Kaplan Meyer de la courbe de survie. La fonction écrite contient une option `show.plot` définit par défaut sur `FALSE` qui permet d'afficher la courbe de survie si l'option est mise à  `TRUE`. La fonction est aussi capable de donner l'estimateur en tenant compte des dates ex-aequos. 

Une fois la fonction écrite, elle est testée sur des données simulées. Ainsi on compare l'estimation de la courbe de survie faite par notre fonction à la courbe théorique utilisée pour la simulation

Ensuite on a décider de comparer l'estimation faite par notre fonction et celle faite par R. On utilise les données `diabetic` du package `survival` pour la comparaison.  

Par finir on étudie le jeu de donnée précédent afin d'analyser la survie (durée entre la prise du traitement au laser et l'apparition de cécité) en fonction de différentes covariables. On utilise les tests de log-rank a cet effet.
