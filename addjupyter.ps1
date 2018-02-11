$jpcommand = Get-Command jupytedr.exe | Select-Object -ExpandProperty Definition

Write-Output $jpcommand

New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT

function createRegedit([string]$registryPath, [string]$value)
{
    $name = "(Default)"

    If(!(Test-Path $registryPath)){
        New-Item -Path $registryPath -Force | Out-Null    
    }
    
    New-ItemProperty -Path $registryPath -Name $name -Value $value `
        -PropertyType String -Force | Out-Null    
}

$openText = "Open Jupyter Notebook server here"

createRegedit "HKCR:\Directory\Background\shell\jupyter" $openText
createRegedit "HKCR:\Directory\shell\jupyter" $openText

$commandText = "`"" + $jpcommand + "`" `"notebook`" `"%V`""

createRegedit "HKCR:\Directory\Background\shell\jupyter\command" $commandText
createRegedit "HKCR:\Directory\shell\jupyter\command" $commandText

