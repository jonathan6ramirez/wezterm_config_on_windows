Set-Alias cd z -Option AllScope # This is the command that binds cd to z and adds the allscope option

# INFO: this is so i can call :Neotree filesystem reveal dir=X:\ and show the files on the network share
function nvim
{
    # Check if EWEB: is already mapped -- INFO: comal server
    if (-not (Get-PSDrive -Name E -ErrorAction SilentlyContinue))
    {
        Write-Host "Adding the E: drive"
        net use E: \\eweb\c$\
    }

    # Check if X: is already mapped -- INFO: comal server
    if (-not (Get-PSDrive -Name X -ErrorAction SilentlyContinue))
    {
        Write-Host "Adding the X: drive"
        net use X: \\comal\c$\
    }

    # Check if Y: is already mapped -- INFO: jzntc-sql server
    if (-not (Get-PSDrive -Name Y -ErrorAction SilentlyContinue))
    {
        Write-Host "Adding the Y: drive"
        net use Y: \\jzntc-sql\c$\
    }

    # Check if Z: is already mapped -- INFO: fannin server
    if (-not (Get-PSDrive -Name Z -ErrorAction SilentlyContinue))
    {
        Write-Host "Adding the Z: drive"
        net use Z: \\fannin\c$\
    }

    # Start neovim
    & "C:\tools\neovim\nvim-win64\bin\nvim.exe" @args
}

#function cd {
#    param (
#        [string]$path
#    )
#
#    if (-not $path) {
#        # If no path is provided, call `z` without arguments
#        Write-Host "Running: z" -ForegroundColor Green
#        z
#    }
#    else {
#        # Call `z` with the provided path
#        Write-Host "Running: z $path" -ForegroundColor Green
#        z $path
#    }
#}

# INFO: Terminal icons
Import-Module -Name Terminal-Icons

# INFO: This initializes oh my posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/kali.omp.json" | Invoke-Expression

# INFO: setup direnv
#$env:HOME = $HOME
#$env:DIRENV_CONFIG="$HOME\.direnv\config"
#$env:XDG_CACHE_HOME="$HOME\.direnv\cache"
#$env:XDG_DATA_HOME="$HOME\.direnv\data"
#Invoke-Expression "$(direnv hook pwsh)"

# WARNING: THIS NEEDS TO BE AT THE END OF THE FILE TO WORK
Invoke-Expression (& { (zoxide init powershell | Out-String) })
