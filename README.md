# Centralisateur : Organiser les fichiers 
    
Ce script permet d e copier ou de déplacer les fichiers  image (jpg, png, bmp et heic) à partir de dossiers sources spécifiés par l'utilisateur vers un dossier de de stination spécifié également par l'utilisateur. L'utilisateur peut également spécifier des dossiers sources à exclure du traitement. Si le nom d'un fichier existe déjà dans le dossier de destination, un numéro d'index sera ajouté à la fin du nom  du fichier afin de l'éviter. 
    
## Utilisation  
 
1. Ouvrez le script dans PowerShell 
2. Suivez les instructions affichées à l'écran pour choisir une action (copier ou déplacer les fichiers), saisir les chemins des dossiers sources, les chemins des dossiers sources à exclure (facult atif) et le chemin  du dossier de destination.
3. Le script parcourra l'arborescence de l'ordinateur à la recherche de fichiers image et effectuera l'opération choisie. Les fichiers seront classés par type dans des dossiers de destination respectifs (jpg, png, bmp et heic) dans le dossier de destination spécifié.
  
## Note 
  
Le script utilise la cmdlet PowerShell `Get-ChildItem` pour parcourir l'arborescence de l'ordinateur à la recherche de fichiers. Si vous rencontrez des problèmes d'autorisations lors de l'exécution du script, assurez-vous d'avoir les autorisations nécessaires pour accéder aux dossiers et aux fichiers ciblés. 

## Copyright 

Tous droits réservés. Copyright (c) 2022 Anthony.

## Licence

Ce script est fourni tel quel, sans aucune garantie. L'utilisation de ce script est à vos propres risques. Nous ne sommes pas responsables de tout dommage causé par l'utilisation de ce script.

  
## Contact
 
Si vous avez des questions ou des commentaires sur ce script, n'hésitez pas à me contacter via mon portefolio https://anthony-rodrigues.fr/
