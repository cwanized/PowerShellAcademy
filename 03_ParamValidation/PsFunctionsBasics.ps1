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
                throw "File or folder does not exist"
            }
            return $true
        })]
        [System.IO.FileInfo]$Path,
        $date

    )
    $path
    $date

}