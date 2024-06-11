$RootFolder = "C:\temp"
Set-Location -Path $RootFolder

$allServices = Get-Service | select -First 10




foreach($service in $allServices){

    if(-not (Test-Path $service.name)){
        New-Item -Name $service.name -ItemType Directory    
    }

    #$filepath = "$($service.name)\status-$($service.name).txt"

    if(-not (Test-Path "$($service.name)\status-$($service.name).txt")){
        $item = New-Item -Path $service.name -Name "status-$($service.name).txt" -ItemType File
    }else{
        $item = Get-Item -Path "$($service.name)\status-$($service.name).txt"
    }
    
    $content = ($service | select *) | ConvertTo-Csv -Delimiter ";" -NoTypeInformation -Verbose
    Set-Content -Path $item.FullName -Value ($content)


}