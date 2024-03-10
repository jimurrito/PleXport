<#
.Description
Functions to connect to Plex and get playlists.
#>


function Test-PlexConnection {
    param (
        $ServerSock,
        $Token
    )
    [xml]((Invoke-WebRequest "http://${ServerSock}/?X-Plex-Token=${token}").content)
}

function Find-PlexFriendlyname {
    param (
        [Parameter(ValueFromPipeline = $true)]$xml
    )
    $xml.MediaContainer.FriendlyName
}



function Get-PlexPlaylist {
    param (
        $ServerSock,
        $Token
    )
    [xml]((Invoke-WebRequest "http://${ServerSock}/playlists/?X-Plex-Token=${token}").content)
}

function Find-Playlists {
    param (
        [Parameter(ValueFromPipeline = $true)]$xml
    )
    $xml.MediaContainer.Playlist | Where-Object { $_.playlistType -eq "audio" }
}



function Get-PlexPlaylistItems {
    param (
        $ServerSock,
        $Token,
        $Playlist
    )
    [xml]((Invoke-WebRequest "http://${ServerSock}/playlists/${Playlist}/items?X-Plex-Token=${token}").content)
}

function Find-PlaylistTracks {
    param (
        [Parameter(ValueFromPipeline = $true)]$xml
    )
    $xml.MediaContainer.Track
}

function Find-PlaylistTrackDataPaths {
    param (
        [Parameter(ValueFromPipeline = $true)]$xml
    )
    $xml.MediaContainer.Track.Media.Part.file
}

function Set-TrackDataPaths {
    param (
        [Parameter(ValueFromPipeline = $true)]$Paths
    )
    foreach ($Path in $Paths) { $Path -replace "/data/Music", "/music" }    
}
