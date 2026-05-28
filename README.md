# Spotify Ad Blocker

## Architecture
A LaunchAgent watches a file in the Spotify desktop application's `Application Support` directory for changes. This file updates when a new track or ad plays, providing a reliable and efficient way to trigger CPU utilization only when absolutely necessary. A small Applescript handles restarting the Spotify application if an ad has indeed started, effectively blocking ads. Between track changes, the primary system overhead is that of `launchd`, which is negligible by any reasonable metric. However, the watched file updates infrequently when interacting with the Spotify application, which will unnecessarily start the LaunchAgent.

## Setup
### Compile
Run `osacompile -o out/compiled.scpt spotify-ad-blocker.applescript`. Move `compiled.scpt` to your desired (persistent) directory.

### Configure the LaunchAgent
Rename `com.EXAMPLE.spotifyadblocker.plist`, and find-and-replace all instances of the following:
- {DOMAIN}: Any string that uniquely identifies this launch agent
- {USERNAME}: The name of your home directory (full paths are required, and tilde [~] expansion is not supported)
- {PATH}: The full path to the respective file
- {SPOTIFY_USER}: Copy the name of the folder in `~/Library/Application Support/Spotify/Users`

Copy the completed file to `~/Library/LaunchAgents`

### Enable
Run `launchctl load ~/Library/LaunchAgents/com.EXAMPLE.spotifyadblocker.plist`
