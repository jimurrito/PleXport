<#
.Description
Script to allow exporting playlists from plex, for import into another app.
#>

# Parameters
param (
    $Server,
    $Port = 32400,
    $TokenFile = ".\token",
    $Token 
)

# 
Import-Module -Name "$PSScriptRoot\lib\*.psm1"

# Start timer
$timer = [Diagnostics.Stopwatch]::StartNew()

# Set Token
if ($null -eq $Token) {
    $Token = Get-Content $TokenFile -ErrorAction SilentlyContinue
}

# Input validation
if ($null -eq $Server) {
    Write-Error "Script requires the '-Server' Parameter containing the IP address of the Server."
    exit
}
elseif ($null -eq $Token) {
    Write-Error "Script requires a token to connect to Plex. Either use the '-Token' or '-TokenFile' parameters"
    exit
}

#
Write-Host ("Connecting to Server @{0}:{1}" -f $Server, $Port)

# Get playlist
$Playlists = Get-PlexPlaylist -Server 10.2.3.10 -Token $Token | Find-Playlists
Write-Host ("[{0}] playlist(s) found." -f $Playlists.Count)

# make dir for playlists
$null = New-Item -Name playlists -ItemType Directory -ErrorAction SilentlyContinue

# Commit playlists to .txt
foreach ($Pl in $Playlists) {
    # info dump
    Write-Host ("# Playlist: {0}" -f $Pl.title)

    # Get Playlist items
    $PlaylistItems = Get-PlexPlaylistItems -Server 10.2.3.10 -Token $Token -Playlist $Pl.ratingKey
    $Paths = $PlaylistItems | Find-PlaylistTrackDataPaths
    Write-Host ("--> {0} Songs" -f $Paths.Count)
    Set-TrackDataPaths -Paths $Paths | Out-File -Encoding utf8 ("$PWD\playlists\{0}.m3u8" -f $Pl.title)
}

# Stop timer
$timer.stop()

# Done
Write-Host ("Done. Operation took {0} Seconds.`nPlaylists can be found at: $PWD\playlists" -f $timer.Elapsed.TotalSeconds)