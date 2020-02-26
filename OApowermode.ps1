Import-Module -Name HPEOACmdlets
#autorization
$Cred = Get-Credential
$oaipaddr="0"
#paths to CSV
$csvpath='c:\temp\oainput1.csv'
$csvpathresult='c:\temp\result1.csv'

# Data array for results
$oaresult= @()
$oaresult+='Name;Serial;IP address;Power Mode'

#Import OA IP addresses
$oaip=Import-Csv -Path $csvpath
foreach($oaipaddr in $oaip.ip)
{
    # Get session key
    $Session = Connect-HPEOA -OA 192.168.143.71 -Credential $cred

    # Get enclosure serial for report
    $enc=Get-HPEOAEnclosureInfo -Connection $Session
    

    # Get data
    $enc1=Get-HPEOAEnclosureStatus -Connection $Session

            
    $oaresult+=$enc1.Hostname + ";" + $enc.SerialNumber + ";" + $enc1.IP + ";" + $enc1.PowerSubsystem.PowerMode
            
}
return $oaresult | Out-File $csvpathresult
$Cred='0'
