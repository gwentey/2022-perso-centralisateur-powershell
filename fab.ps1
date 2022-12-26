# Message de copyright
Write-Host "Copyright (c) 2022 Anthony. Tous droits réservés." -ForegroundColor Yellow

# Demander à l'utilisateur de choisir une action
$choice = Read-Host "Veuillez choisir une action : 1) Copier les éléments, 2) Déplacer les éléments"

# Demander à l'utilisateur de saisir les chemins des dossiers sources
$sources = Read-Host "Veuillez entrer les chemins des dossiers sources (séparés par des virgules) " 

# Demander à l'utilisateur de saisir les chemins des dossiers sources à exclure
$excluded = Read-Host "Veuillez entrer les chemins des dossiers sources à exclure (séparés par des virgules) " 

# Demander à l'utilisateur de saisir le chemin du dossier de destination
$destination = Read-Host "Veuillez entrer le chemin du dossier de destination "

$path = $destination;

# Convertir la chaîne en tableau
$sources = $sources -split ","

# Si l'utilisateur n'a pas spécifié de dossiers sources à exclure, initialiser la variable $excluded à un tableau vide
$excluded = $excluded -split ","

# Ajouter le chemin du dossier de destination aux dossiers sources à exclure
$excluded += $destination

# Vérifie si le dossier de destination existe, et le crée s'il n'existe pas
if (!(Test-Path $destination)) { New-Item -ItemType Directory -Path $destination | Out-Null }

# Crée des dossiers de destination pour chaque type de fichier
"JPG", "PNG", "BMP", "HEIC" | ForEach-Object { New-Item -ItemType Directory -Path "$destination\$_" | Out-Null }

# Parcours l'arborescence de l'ordinateur à la recherche de fichiers et effectue l'opération choisie
foreach ($source in $sources) {
    # Vérifier si le dossier source doit être exclu
    if ($excluded -notcontains $source) {
        "jpg", "png", "bmp", "heic" | ForEach-Object {
            $files = Get-ChildItem -Recurse $source -Filter "*.$_" | Where-Object {$excluded -notcontains $_.DirectoryName}

            if ($choice -eq "1") {
    # Copier les fichiers
    foreach ($file in $files) {
        # Vérifier si le nom du fichier existe déjà dans le dossier de destination
        $target = "$destination\$($_.ToUpper())\$($file.Name)"
        if (Test-Path $target) {
            # Générer un nouveau nom de fichier en ajoutant un numéro d'index à la fin du nom
            $i = 1
            while (Test-Path $target) {
                $target = "$destination\$($_.ToUpper())\$($file.BaseName)_$i.$($file.Extension)"
                $i++
            }
        }
        # Copier le fichier
        $file | Copy-Item -Destination $target -Force | Out-Null
    }

    # Demander à l'utilisateur s'il souhaite déplacer les éléments
    $moveChoice = Read-Host "Voulez-vous déplacer les éléments maintenant ? (O/N)"
    if ($moveChoice -eq "O") {
        # Déplacer les fichiers
        foreach ($file in $files) {
            # Vérifier si le nom du fichier existe déjà dans le dossier de destination
            $target = "$destination\$($_.ToUpper())\$($file.Name)"
            if (Test-Path $target) {
                # Générer un nouveau nom de fichier en ajoutant un numéro d'index à la fin du nom
                $i = 1
                while (Test-Path $target) {
                    $target = "$destination\$($_.ToUpper())\$($file.BaseName)_$i.$($file.Extension)"
                    $i++
                }
            }
            # Déplacer le fichier
            $file | Move-Item -Destination $target -Force | Out-Null
        }

# Vérifier si le chemin est valide
if (!(Test-Path $path)) {
    Write-Host "Le chemin est invalide. Veuillez réessayer." -ForegroundColor Red
    return
}

# Récupérer tous les fichiers image dans le répertoire et ses sous-répertoires
$files = Get-ChildItem -Recurse -Filter "*.jpg","*.png","*.bmp","*.heic" -Path $path

# Créer un dictionnaire pour stocker les empreintes numériques des fichiers
$hashDict = @{}

# Parcourir tous les fichiers
foreach ($file in $files) {
    # Calculer l'empreinte numérique du fichier
    $hash = (Get-FileHash -Algorithm MD5 $file.FullName).Hash

    # Vérifier si l'empreinte numérique existe déjà dans le dictionnaire
    if ($hashDict.ContainsKey($hash)) {
        # Si oui, supprimer le fichier
        $file | Remove-Item
    } else {
        # Si non, ajouter l'empreinte numérique au dictionnaire
        $hashDict.Add($hash, $file.FullName)
    }
}

Write-Host "Suppression des doublons terminée." -ForegroundColor Green

    }
}