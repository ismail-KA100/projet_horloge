
Ce projet  a pour but de décrire le fonctionnement d'un chronomètre simple. L'architecture repose sur deux compteurs : l'un pour les millisecondes et l'autre pour les secondes. 

Ainsi, le compteur **TIMER_MS** s'incrémente chaque milliseconde, tandis que **TIMER_S** s'incrémente à chaque seconde. Un signal, nommé **eoc**, passe à 1 lorsque **TIMER_MS** atteint la fin de son comptage, permettant ainsi l'incrémentation de **TIMER_S**. Les registres **REGISTRE_MS** et **REGISTRE_S** stockent l'état des deux compteurs.

Le séquenceur **ME_CHRONO** contrôle l'ensemble du fonctionnement. L'utilisateur peut interagir avec le chronomètre à l'aide des commandes suivantes :
- **Start** : Démarre le comptage.
- **Pause** : Suspend le comptage sans réinitialiser les compteurs.
- **Rec** : Enregistre l'état actuel des compteurs dans **REGISTRE_MS** et **REGISTRE_S**.
- **Raz** : Réinitialise les deux compteurs.

La taille des compteurs et des registres doit être définie de manière à ce que **TIMER_MS** puisse s'incrémenter jusqu'à 999 et **TIMER_S** jusqu'à 59.
