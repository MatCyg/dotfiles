-- based on https://github.com/vitorgalvao/custom-alfred-iterm-scripts

on has_windows()
  tell application "iTerm"
    if windows is {} then return false
    if tabs of current window is {} then return false
    if sessions of current tab of current window is {} then return false

    set session_text to contents of current session of current tab of current window
    if words of session_text is {} then return false
  end tell

  return true
end has_windows

on new_window()
  tell application "iTerm" to create window with default profile
end new_window

on new_tab()
  tell application "iTerm" to tell the first window to create tab with default profile
end new_tab

on send_text(custom_text)
  tell application "iTerm" to tell the first window to tell current session to write text custom_text
end send_text

-- set printString to ""       
-- set printString to printString & tabPath & "\n"
-- copy printString to stdout
-- copy "new window" to stdout
on run argv
    set expectedPath to item 1 of argv    
    -- set expectedPath to "/Users/mateuszcygert/Projects/finastra/app-management"
    set cmd to "cd " & expectedPath & "; clear;"
    copy expectedPath to stdout
    tell application "iTerm"
        activate
        if my has_windows() then
            tell current window
                set foundTab to false
                repeat with aTab in tabs
                    tell current session of aTab
                        set tabPath to (variable named "session.path")
        
                        if tabPath is expectedPath then
                                set isAtPrompt to is at shell prompt
                                if isAtPrompt then
                                    select aTab
                                    set foundTab to true
                                    exit repeat
                                end if
                        end if
                    end tell
                end repeat
            end tell
            if not foundTab then
                my new_tab()
                my send_text(cmd)
            end if
        else    
            my new_window()

            repeat 500 times
                if my has_windows() then
                    my send_text(cmd)
                    exit repeat
                end if
            delay 0.01
            end repeat
        end if
    end tell

end run