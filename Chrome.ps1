$ErrorActionPreference = 'SilentlyContinue'
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

md -Path $env:temp\chromeinstall -erroraction SilentlyContinue | Out-Null
$Download = join-path $env:temp\chromeinstall chrome_installer.exe

Invoke-WebRequest 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe'  -OutFile $Download

Invoke-Expression "$Download"

Invoke-Expression "$Download /silent /install"

md -Path $env:temp\chromeinstall -erroraction SilentlyContinue | Out-Null
$Download = join-path $env:temp\chromeinstall chrome_installer.exe
Invoke-WebRequest 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe'  -OutFile $Download
Invoke-Expression "$Download /silent /install"

$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
$INSTALLED | ?{ $_.DisplayName -match 'chrome' } | sort-object -Property DisplayName -Unique | Format-Table -AutoSize