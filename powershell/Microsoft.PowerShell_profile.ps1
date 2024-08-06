# To reload: & $profile
New-Alias ll Get-ChildItem
New-Alias which Get-Command
New-Alias v nvim
New-Alias vg nvim-qt

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Invoke-Expression (&scoop-search --hook)
