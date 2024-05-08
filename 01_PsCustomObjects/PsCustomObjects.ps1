# 1 The PowerShell 3.x Way
function Get-AdAndSfBUserInfo {
    $allAdUsers = get-aduser -Filter 'UserPrincipalName -like "*"' -Properties *
    $MyBigList = @()

    foreach ($AdUser in $AllAdUsers) {
        $noError = $false #defensive programming / Dont use $error, this is a built in $error variable
        $csuser = $null

        try {
            $csuser = get-csuser $aduser.UserPrincipalName -ErrorAction stop
            $noError = $true
        }
        catch {}
        finally {}

        $ListEntry = new-Object -TypeName PSObject;
        if ($noError) {            
            $ListEntry | Add-Member -MemberType NoteProperty -Name UserPrincipalName -Value $aduser.UserPrincipalName
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdIpPhone -Value $aduser.IpPhone
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdTelephonenumber -Value $aduser.telephoneNumber
            $ListEntry | Add-Member -MemberType NoteProperty -Name csLineUri -Value $csUser.Lineuri
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdMail -Value $AdUser.mail
            $ListEntry | Add-Member -MemberType NoteProperty -Name csSipAddress -Value $csUser.SipAddress
            
        }
        else {
            $ListEntry | Add-Member -MemberType NoteProperty -Name UserPrincipalName -Value $aduser.UserPrincipalName
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdIpPhone -Value "-"
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdTelephonenumber -Value "-"
            $ListEntry | Add-Member -MemberType NoteProperty -Name csLineUri -Value "-"
            $ListEntry | Add-Member -MemberType NoteProperty -Name AdMail -Value "-"
            $ListEntry | Add-Member -MemberType NoteProperty -Name csSipAddress -Value "NOT SFB ENABLED"
        }
        
        $MyBigList += $ListEntry  # $MyBigList = $MyBigList + $ListEntry

    }

    $myBigList
}

# 2 The PowerShell 5.1 / 6 / 7 way
function Get-AdAndSfBUserInfoV2 {

    $allAdUsers = get-aduser -Filter 'UserPrincipalName -like "*"' -Properties *
    [collections.arraylist]$myBigList = @()

    foreach ($AdUser in $AllAdUsers) {
        $noError = $false
        $csuser = $null

        try {
            $csuser = get-csuser $aduser.UserPrincipalName -ErrorAction stop
            $noError = $true
        }
        catch {}
        finally {}

        
        if ($noError) {
            $ListEntry = [psCustomObject]@{
                UserPrincipalName = $aduser.UserPrincipalName
                AdIpPhone         = $aduser.IpPhone
                AdTelephonenumber = $aduser.telephoneNumber
                csLineUri         = $csuser.Lineuri
                AdMail            = $aduser.mail
                csSipAddress      = $csuser.Sipaddress
            } 
            $myBigList.add($ListEntry) | out-null     
        }
        else {
            $ListEntry = [psCustomObject]@{
                UserPrincipalName = $aduser.UserPrincipalName
            #    AdIpPhone         = $aduser.IpPhone
            #    AdTelephonenumber = $aduser.telephoneNumber
            #    csLineUri         = "UserNotSfBEnabled"
            #    AdMail            = $aduser.mail
                csSipAddress      = "UserNotSfBEnabled"
            } 
            $myBigList.add($ListEntry) | out-null           

        }

        
    }

    $myBigList
}
# 2B The PowerShell 5.1 / 6 / 7 way - less redundant code
function Get-AdAndSfBUserInfoV2B {
    $allAdUsers = get-aduser -Filter 'UserPrincipalName -like "*"' -Properties *
    [collections.arraylist]$myBigList = @()

    foreach ($AdUser in $AllAdUsers) {
        $noError = $false
        $csuser = $null

        try {
            $csuser = get-csuser $aduser.UserPrincipalName -ErrorAction stop
            $noError = $true
        }
        catch {}
        finally {}

        $UserPrincipalName = $aduser.UserPrincipalName
        $AdIpPhone         = $aduser.IpPhone
        $AdTelephonenumber = $aduser.telephoneNumber
        $csLineUri         = "UserNotSfBEnabled"
        $AdMail            = $aduser.mail
        $csSipAddress      = "UserNotSfBEnabled"
        
        if ($noError) {
            $csLineUri         = $csuser.Lineuri
            $csSipAddress      = $csuser.Sipaddress
        }        #Best practice: avoid 'else'

        $ListEntry = [psCustomObject]@{
            UserPrincipalName = $UserPrincipalName
            AdIpPhone         = $AdIpPhone
            AdTelephonenumber = $AdTelephonenumber
            csLineUri         = $csLineUri
            AdMail            = $AdMail
            csSipAddress      = $csSipAddress
        } 
        $myBigList.add($ListEntry) | out-null   

    }

    $myBigList
}





# 2 C get ad user / csUser one time and check against table

function Get-AdAndSfBUserInfoV2C {

    $allAdUsers = get-aduser -Filter 'UserPrincipalName -like "*"' -Properties *
    $allCsUsers = Get-CsUser
    [collections.arraylist]$myBigList = @()

    foreach ($AdUser in $AllAdUsers) {
        $csuser = $null

        $UserPrincipalName = $aduser.UserPrincipalName
        $AdIpPhone         = $aduser.IpPhone
        $AdTelephonenumber = $aduser.telephoneNumber
        $csLineUri         = "UserNotSfBEnabled"
        $AdMail            = $aduser.mail
        $csSipAddress      = "UserNotSfBEnabled"

        if($AdUser.UserPrincipalName -in $allCsUsers.UserPrincipalName){
            $csLineUri         = $csuser.Lineuri
            $csSipAddress      = $csuser.Sipaddress
        }   #Best practice: avoid 'else'
   
        $ListEntry = [psCustomObject]@{
            UserPrincipalName = $UserPrincipalName
            AdIpPhone         = $AdIpPhone
            AdTelephonenumber = $AdTelephonenumber
            csLineUri         = $csLineUri
            AdMail            = $AdMail
            csSipAddress      = $csSipAddress
        } 
        $myBigList.add($ListEntry) | out-null   

    }

    $myBigList
}





