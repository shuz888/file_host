$psexe = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
$verifyadmin = $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
if($verifyadmin)
{
    $psfullname = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process $psexe -Verb runAs -ArgumentList $psfullname,"-ExecutionPolicy UnRestricted","-noLogo","-NoProfile"
    [Environment]::Exit(0)
}
else
{
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)";
    Clear-Host
}
