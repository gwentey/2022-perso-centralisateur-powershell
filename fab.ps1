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

           
            } elseif ($choice -eq "2") {
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
            }
        }
    }
}


