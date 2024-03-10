![PlExport_Logo](./.assets/PleXport.png 'PlExport_Logo Provided by Dalle3')


# PleXport

A blazingly fast way to export audio playlists from Plex. Supports any x86_64 platform that supports .NET Core.

Exports audio playlists for use in other applications. For example Airsonic.

Playlists are exported as a [.m3u8](https://en.wikipedia.org/wiki/M3U) file. Script written in Powershell; supports both Legacy Powershell and Powershell Core.


## Requirements
- [Plex Token](https://www.plexopedia.com/plex-media-server/general/plex-token/)

## Examples

#### 1.A Minimal run
``` Powershell
./PleXport.ps1 -Token 'agf-3ExxxxxxxxxxJ8rN'
```

#### 1.B Minimalist run - With local Token file
``` Powershell
./PleXport.ps1
```


#### 2. Using a Custom Token file. `-TokenFile`
``` Powershell
./PleXport.ps1 -TokenFile 'C:\...\token'
```
A Token file is a plain-text file that contains the Plex Token. No special syntax required. **Recommended to ensure the token is secure.**

> NOTE: that without the `-TokenFile` parameter, the script will still attempt to import a local file for the token. If there is a file in the current directory called `token`, then it will be imported. The `-Token` parameter takes priority over any Token files.


#### 3. Custom Server IP & Port
``` Powershell
./PleXport.ps1 -Server 192.168.1.5 -Port 8080
```
*This example uses a local Token file.*

#### 4. Custom Output Path
``` Powershell
./PleXport.ps1 -Path C:\...\playlists
```
By default, the script will use the current directory. In doing so, will create a directory called `playlists`; which will hold the script output. However, the path provided with the `-Path` parameter will be the output directory when used. No additional directories will be created.


## Parameters

| Param   | Description | Default |
|-------  |-------------|---------|
| -Server | IPv4 address of the server. | 127.0.0.1 |
| -Port   | TCP Port for the server.    | 32400 |
| -Token  | Token used to access the Plex APIs. |   |
| -TokenFile | File containing Plex token. | .\token |
| -Path | Output directory for playlists | Current Dir |


## Airsonic Support
You can use the custom path functionality to automatically move all the playlists into Airsonic's Playlist Directory. The output playlists are 'drag-and-drop' compatible with Airsonic, Subsonic, and any other applications that uses [.m3u8](https://en.wikipedia.org/wiki/M3U) files. 


## Known Issues/Behaviors

### Successfully connects to Plex, but unable to find any playlists.
- Check the token used is from a user with playlists.
- Ensure the token used is valid. 

> NOTE: Tokens gathered from app.Plex.tv will not work when connecting via IP.


<br>

Open a bug request if you run into any issues!

