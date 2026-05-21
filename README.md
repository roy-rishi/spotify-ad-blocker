# Spotify Ad Blocker

## Setup
### Compile
Run `osacompile -o out/compiled.scpt spotify-ad-blocker.applescript`. Move `compiled.scpt` to your desired (persistent) directory.

### Configure Launch Agent
Rename `com.EXAMPLE.spotifyadblocker.plist`, and find-and-replace all instances of the following:
- {DOMAIN}: Any string that uniquely identifies this launch agent
- {USERNAME}: The name of your home directory (full paths are required, and tilde [~] expansion is not supported)
- {PATH}: The full path to the respective file
- {SPOTIFY_USER}: Copy the name of the folder in `~/Library/Application Support/Spotify/Users`

Copy the completed file to `~/Library/LaunchAgents`

### Enable
Run `launchctl load ~/Library/LaunchAgents/com.EXAMPLE.spotifyadblocker.plist`
