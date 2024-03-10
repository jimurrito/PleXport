<#
.Description
Functions to handle input validation
#>

function Set-Token {
    param (
        $Token = $1,
        $TokenFile = $2
    )
    
    if (($null -eq $Token) -and ($null -ne $TokenFile)) {
        # Token entry blank -> pull from file
        # Check file path
        if (!(Get-ChildItem $TokenFile -ErrorAction SilentlyContinue)) {
            # not valid
            throw "BadTokenPath"
        }
        # try and pull Token from path
        return Get-Content $TokenFile -ErrorAction SilentlyContinue
    }
    elseif ($null -ne $Token) {
        # Use token value
        return $Token
    }
    else {
        throw "NoTokensFound"
    }
}
