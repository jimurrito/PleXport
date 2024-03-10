<#

#>

function Set-Token {
    param (
        $Token = $1,
        $TokenFile = $2
    )
    
    if (($null -eq $Token) -and ($null -ne $TokenFile)) {
        # Token entry blank
        # try and pull Token from path
        return Get-Content $TokenFile -ErrorAction SilentlyContinue
    }
    elseif ($null -ne $Token) {
        # Use token value
        return $Token
    }
    else {
        throw "No tokens provided."
    }
}