$RootFolder = "C:\temp"
Set-Location -Path $RootFolder

[collections.arraylist]$myBigList = @()


#$allServices = (Get-Service | select -First 10).name

$allServices = @(
    "AarSvc_1d7cf4",
    "AdobeARMservice",
    "AdtAgent",
    "AJRouter",
    "ALG",
    "AppIDSvc",
    "Appinfo",
    "AppMgmt",
    "appprotectionsvc",
    "AppReadiness"
)


foreach($service in $allServices){
    $data = Get-content -Path ".\$($service)\status-$($service).txt"
    $data

    $ListEntry = [psCustomObject]@{
        Servicename = $service
        Data         = $data | ConvertFrom-Csv -Delimiter ";"
        DataRaw         = $data
    } 
    $myBigList.add($ListEntry) | out-null   
}