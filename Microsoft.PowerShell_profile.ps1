New-Alias vim nvim
New-Alias v nvim
New-Alias ll Get-ChildItem

function cdc { set-location "C:\" }

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Invoke-Expression (&scoop-search --hook)
