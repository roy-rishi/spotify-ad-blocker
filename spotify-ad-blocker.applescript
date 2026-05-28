on run argv
    log "running..."

    if application "Spotify" is not running then
        log "spotify is not running"
        return  -- nothing to do
    end if

    -- determine if running with test flag
    set testMode to (count of argv > 0) and (item 1 of argv is "-test")

    -- get the URL of the current track/ad
    log "getting url..."
    tell application "Spotify" to set spotifyUrl to (get spotify url of current track)

    -- if an ad is playing, or the test flag is set:
    if spotifyUrl begins with "spotify:ad" or testMode then
        -- get the visibility of the Spotify window
        log "recording visibility of Spotify window..."
        tell application "System Events"
            set windowVisibility to (visible of process "Spotify")
            set windowFocus      to (frontmost of process "Spotify")
        end tell

        -- quit Spotify
        log "quitting Spotify..."
        tell application "System Events"
            repeat while (exists (process "Spotify"))
                try
                    do shell script "killall Spotify"
                end try
                log "  attempted"
                delay 0.2
            end repeat
        end tell

        -- restart Spotify, without making its window frontmost
        log "launching Spotify..."
        repeat until application "Spotify" is running
            try
                tell application "Spotify" to launch
            end try
            log "  attempted"
            delay 0.2
        end repeat

        -- restore Spotify window visibility (hidden/visible, frontmost/unfocussed)
        log "restoring Spotify window visibility..."
        tell application "System Events"
            repeat until visible of process "Spotify" is windowVisibility and frontmost of process "Spotify" is windowFocus
                set visible   of process "Spotify" to windowVisibility
                set frontmost of process "Spotify" to windowFocus
                log "  attempted"
                delay 0.1
            end repeat
        end tell

        -- start/resume playback
        log "resuming playback..."
        tell application "Spotify"
            repeat until (get player state) is playing
                play
                log "  attempted"
                delay 0.2
            end repeat
        end tell
    end if
end run
