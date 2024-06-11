# Pfade zu den Hauptordnern mit PowerShell-Skripten
$mainFolders = Get-ChildItem -Directory

foreach ($folder in $mainFolders) {
    # Erstelle ein neues Notebook für den aktuellen Ordner
    $notebookName = "$($folder.Name).ipynb"
    jupyter nbconvert --to notebook --output $notebookName --stdout | Out-Null

    # Durchsuche den aktuellen Ordner nach PowerShell-Skripten
    $psScripts = Get-ChildItem -Path $folder.FullName -Filter *.ps1

    # Füge jedes PowerShell-Skript als Snippet zum Notebook hinzu
    foreach ($script in $psScripts) {
        $snippetName = $script.BaseName
        $snippetContent = Get-Content $script.FullName -Raw

        # Füge das Snippet zum Notebook hinzu
        jupyter nbconvert --to notebook --output $notebookName --stdin --stdout | Out-Null
        Add-Content -Path $notebookName -Value "### $snippetName"
        Add-Content -Path $notebookName -Value "```powershell"
        Add-Content -Path $notebookName -Value $snippetContent
        Add-Content -Path $notebookName -Value "```---"
    }
}