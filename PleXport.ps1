<#
.Description
Script to allow exporting playlists from plex, for import into another app.
#>

# Parameters
param (
    $Server = "127.0.0.1",
    $Port = 32400,
    $TokenFile = ".\token",
    $Token = $null,
    $Path = $null
)

# 
Import-Module -Name "$PSScriptRoot\lib\get-playlists.psm1"
Import-Module -Name "$PSScriptRoot\lib\validate.psm1"


# Start timer
$timer = [Diagnostics.Stopwatch]::StartNew()


# Check if a Destination path was provided
if ($null -eq $Path) {
    # No path provided, use current path and (create/use existsing) playlist dir
    # Check if playlists folder already exists
    if (get-childItem -path  $PWD -Filter playlists) {
        # Already exists
        $Path = "$PWD/playlists"
    }
    # attempt to create a dir - if it returns, the folder was created successfully.
    elseif (New-Item -Name playlists -ItemType Directory -ErrorAction SilentlyContinue) {
        # Folder should be created
        $Path = "$PWD/playlists"
    }
    # All else failed - kill proc
    else {
        Write-Error "Failed to create the playlists output folder. Please check for FS level permission issues."
        exit
    }
}


# Set/Check Token Input
try {
    $Token = Set-Token $Token $TokenFile
}
catch {
    Write-Error "Script requires a token to connect to Plex. Either use the '-Token' or '-TokenFile' parameters."
    exit
}


# Create server sock
$ServerSock = "${Server}:${Port}"


# test connection to Plex
Write-Host "Connecting to Server @(${ServerSock})"
try {
    $FriendlyName = Test-PlexConnection -ServerSock $ServerSock -Token $Token | Find-PlexFriendlyname
    Write-Host "Successfully Connected to Server ${FriendlyName} @(${ServerSock})"
}
catch {
    Write-Error "Failed to connect to Plex Server @(${ServerSock}). Please check network connectivity to the server." 
    exit
}


# Get playlist
$Playlists = Get-PlexPlaylist -ServerSock $ServerSock -Token $Token -ErrorAction SilentlyContinue | Find-Playlists
Write-Host ("[{0}] playlist(s) found." -f $Playlists.Count)


# Commit playlists to .txt
foreach ($Pl in $Playlists) {
    # info dump
    Write-Host ("# Playlist: {0}" -f $Pl.title)

    # Get Playlist items
    $PlaylistItems = Get-PlexPlaylistItems -ServerSock $ServerSock -Token $Token -Playlist $Pl.ratingKey
    $MediaPaths = $PlaylistItems | Find-PlaylistTrackDataPaths
    Write-Host ("--> {0} Songs" -f $MediaPaths.Count)
    Set-TrackDataPaths -Paths $MediaPaths | Out-File -Encoding utf8 ("${Path}\{0}.m3u8" -f $Pl.title)
}


# Stop timer
$timer.stop()


# Done
Write-Host ("Done. Operation took {0} Seconds.`nPlaylists can be found at: ${Path}" -f $timer.Elapsed.TotalSeconds)