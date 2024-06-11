[int]12

[string]12




[System.IO.FileInfo]$FilePathToCsv

[datetime]"12.01.2024"
[datetime]"12.13.2024"


#you could


function Do-Something($File){
    $File

}




#but you should
function Do-Somethingbetter{
    param(
        [System.IO.FileInfo]$File,
        $date

    )
    $path
    $date

}




function Do-SomethingbetterV2{
    param(
        [ValidateScript({
            if( -Not ($_ | Test-Path) ){
            write-host "noFile"
                throw "File or folder does not exist"
            }else{
                $false
            }
            
        })]
        [System.IO.FileInfo]$Path,
        $date

    )
    $path
    $date

}