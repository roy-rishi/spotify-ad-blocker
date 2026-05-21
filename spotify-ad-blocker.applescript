on run argv
    log "\nRunning..."

    if application "Spotify" is not running then
        return  -- nothing to do
    end if

    -- determine if running with test flag
    set testMode to (count of argv > 0) and (item 1 of argv is "-test")

    -- get the URL of the current track/ad
    tell application "Spotify" to set spotifyUrl to (get spotify url of current track)

    -- get the visibility of the Spotify window
    tell application "System Events" to set windowVisible to (visible of process "Spotify") 

    -- if an ad is playing, or the test flag is set:
    if spotifyUrl begins with "spotify:ad" or testMode then
        -- quit Spotify
        tell application "Spotify" to quit

        -- wait for Spotify to quit
        repeat until application "Spotify" is not running
            delay 0.1
        end repeat

        -- restart Spotify, without focussing its window
        tell application "Spotify" to launch

        -- wait for Spotify to restart
        repeat until application "Spotify" is running
            delay 0.1
        end repeat
        delay 0.2

        -- hide Spotify window if it was hidden prior to this script's execution
        tell application "System Events" to set visible of process "Spotify" to windowVisible

        -- start/resume playback
        delay 0.5
        tell application "Spotify" to play
    end if
end run
