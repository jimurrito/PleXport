<#
.Description
Gets playlists from plex
#>

function Get-PlexPlaylist {
    param (
        $Server,
        $Token
    )
    [xml]((Invoke-WebRequest "http://${server}:32400/playlists/?X-Plex-Token=${token}").content)
}

function Find-Playlists {
    param (
        [Parameter(ValueFromPipeline = $true)]$xml
    )
    $xml.MediaContainer.Playlist
}


function Get-PlexPlaylistItems {
    param (
        $Server,
        $Token,
        $Playlist
    )
    [xml]((Invoke-WebRequest "http://${server}:32400/playlists/${Playlist}/items?X-Plex-Token=${token}").content)
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
    foreach ($Path in $Paths) {$Path -replace "/data/Music","/music"}    
}
