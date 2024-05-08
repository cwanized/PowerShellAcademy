

#Create simple arrays
$array = @("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")

$array.GetType()

$array | Get-Member 

#Loop through array
foreach($day in $array)
{
    Write-Output "Today is $($day)."
}

Write-Output $array[3]





############################


#Create persona hashtable record
$hashtable = @{
    "Name" = "Mustermann"
    "Status" = "Active"
    "Mail" = "MusterMman@Domain.tld"    
}

#Add new key to persona
$hashtable.add("Phone","+41581230000")
$hashtable.Location = "GR"


#Create User list with age
$ageList = @{}
$key = 'Kevin'
$value = 36
$ageList.add( $key, $value )

$ageList.add( 'Alex', 9 )

$ageList['Kevin']
$ageList['Alex']


#Lookup table variant 1
$CurrentLanguage = "DE"
$User = whoami

$DIR_WelcomeText = @{
    "EN" = "Welcome"
    "DE" = "Willkommen"
    "IT" = "Buongiorno"    
    "FR" = "Bonjour"
}


Write-Host "$($DIR_WelcomeText.$CurrentLanguage) $(whoami)"


#Lookup table variant 2
$ENV = "Prod"

$DIR_AdDomain = @{
    Prod = 'swisscom-mcc.local'
    Int   = 'swisscom-mccint.local'
    Dev  = 'swisscom-mccdev.local'
}

$domain = $DIR_AdDomain[$ENV]
Write-host "Current Domain is: $($domain)"


# Looping through hashtables Variant 1
$DIR_AdDomain.GetEnumerator() | ForEach-Object{
    Write-Output "ENV is: '$($_.key)'"
    $message = '{0} AdDomain is: {1}' -f $_.key, $_.value
    Write-Output $message
    Write-Output ""
   
}

# Looping through hashtables Variant 2
foreach($environment in $DIR_AdDomain.GetEnumerator()){
    Write-Output "ENV is: '$($environment.key)' with '$($environment.value)'"

    Write-Output ""
   
}

