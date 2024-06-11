

#Create simple array with 
$array = @("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday")

#Shoe Types and Members/properties
$array.GetType()

$array | Get-Member 

#Loop through array
foreach($day in $array)
{
    Write-Output "Today is $($day)."
}

#Access array element by index
$day = 5
Write-Output "Day '$($day)' is $($array[$day])"