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
    tell application "System Events"
        set windowVisibility to (visible of process "Spotify")
        set windowFocus      to (frontmost of process "Spotify")
    end tell

    -- if an ad is playing, or the test flag is set:
    if spotifyUrl begins with "spotify:ad" or testMode then
        -- quit Spotify
        tell application "Spotify" to quit

        -- wait for Spotify to quit
        repeat until application "Spotify" is not running
            delay 0.1
        end repeat

        -- restart Spotify, without making its window frontmost
        tell application "Spotify" to launch

        -- wait for Spotify to restart
        repeat until application "Spotify" is running
            delay 0.1
        end repeat

        -- restore Spotify window visibility (hidden/visible, frontmost/unfocussed)
        tell application "System Events"
            repeat until visible of process "Spotify" is windowVisibility and frontmost of process "Spotify" is windowFocus
                set visible   of process "Spotify" to windowVisibility
                set frontmost of process "Spotify" to windowFocus
                delay 0.1
            end repeat
        end tell

        -- start/resume playback
        tell application "Spotify"
            repeat until (get player state) is playing
                play
                delay 0.1
            end repeat
        end tell
    end if
end run
