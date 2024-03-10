<#
.Description
Synchonizes Playlists hosted in Airsonic/Subsonic, using the Airsonic API.
https://www.subsonic.org/pages/api.jsp
#>


<#
.Synopsis

1> Get API token via upn+pwd auth.
2> Get current Playlists.
3> Match to an existing folder of .m3u8 files.
4> Enumerate Playlists to see which local files names match those from the server.
5> Matching Playlists are deleted from the server.
6> Matching Playlists are reuploaded to the server from the local copies.
7> Profit.

NOTE:
Eventually this will be apart of a larger automation pipeline where playlists are exported from Plex, and imported to Airsonic.

#>