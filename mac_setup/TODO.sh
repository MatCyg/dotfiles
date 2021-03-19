TODO should prepare system update scripts

echo "Updating Homebrew"
brew update && brew upgrade && brew cleanup && brew cask cleanup; brew bundle; brew doctor

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"


alias badge="tput bel"


install maven
#look into
# curlrc
# hisotry ignore


# brews:
# possibly:
# the_silver_searcher
# terminal-notifier   // check https://stackoverflow.com/questions/30016716/how-do-i-make-iterm-terminal-notify-me-when-a-job-process-is-complete
# keycastr

# iterm2 integration!!

###############################################################################
# FSNotes
###############################################################################
# use Cmd+Delete for "delete text to beginning of line" you can change the "delete note" hotkey to Cmd+Shift+Delete
defaults write co.fluder.FSNotes NSUserKeyEquivalents -dict-add 'Delete' '@$\U0008';

#TODO DOESNT WORK
#https://apple.stackexchange.com/questions/306867/can-defaults-write-command-line-configure-the-menu-bar-on-macos
#defaults write com.apple.systemuiserver NSStatusItem Visible Siri -int 0
#defaults write com.apple.systemuiserver NSStatusItem Visible com.apple.menuextra.airport -int 1
#defaults write com.apple.systemuiserver NSStatusItem Visible com.apple.menuextra.battery -int 1
#defaults write com.apple.systemuiserver NSStatusItem Visible com.apple.menuextra.bluetooth -int 1
#defaults write com.apple.systemuiserver NSStatusItem Visible com.apple.menuextra.clock -int 1
#defaults write com.apple.systemuiserver NSStatusItem Visible com.apple.menuextra.volume -int 1



#com.apple.systempreferences DisableAutoLoginButtonIsHidden -bool false

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

###############################################################################
# Safari & WebKit                                                             #
###############################################################################
# TODO not working anymore
# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

## Prevent Safari from opening ‘safe’ files automatically after downloading
#defaults write com.apple.Safari AutoOpenSafeDownloads -bool false



# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# stop show adds for websites on safari open
defaults write com.apple.Safari HomePage -string "about:blank" # Empty
defaults write com.apple.Safari NewTabBehavior -int 1 # Empty
defaults write com.apple.Safari NewWindowBehavior -int 1 # Empty



# leftovers

#
#            "com.apple.Accessibility" =     {
#        AXSClassicInvertColorsPreference = 0;
#        AccessibilityEnabled = 1;
#        ApplicationAccessibilityEnabled = 1;
#        AutomationEnabled = 0;
#        BrailleInputDeviceConnected = 0;
#        CommandAndControlEnabled = 0;
#        DarkenSystemColors = 0;
#        DifferentiateWithoutColor = 0;
#        EnhancedBackgroundContrastEnabled = 1;
#        FullKeyboardAccessEnabled = 0;
#        FullKeyboardAccessFocusRingEnabled = 1;
#        GenericAccessibilityClientEnabled = 1;
#        GrayscaleDisplay = 0;
#        InvertColorsEnabled = 0;
#        KeyRepeatDelay = "0.416666666";
#        KeyRepeatEnabled = 1;
#        KeyRepeatInterval = "0.03333333299999999";
#        ReduceMotionEnabled = 0;
#        SpeakThisEnabled = 0;
#        VoiceOverTouchEnabled = 0;
#    };
#
#
#
  #  "com.apple.keyboard.fnState" = 1;
#        "com.apple.mouse.scaling" = 5;
#        "com.apple.scrollwheel.scaling" = 5;
#        "com.apple.sound.beep.flash" = 0;
#        "com.apple.sound.beep.volume" = 0;
#        "com.apple.sound.uiaudio.enabled" = 0;
#        "com.apple.springing.delay" = "0.5";
#        "com.apple.springing.enabled" = 1;
#        "com.apple.swipescrolldirection" = 0;
#        "com.apple.trackpad.forceClick" = 1;
#        "com.apple.trackpad.scaling" = 3;
#
#
#        "com.apple.keyboard.fnState" = 1;
#        "com.apple.scrollwheel.scaling" = 5;
#        "com.apple.sound.beep.volume" = 0;
#        "com.apple.sound.uiaudio.enabled" = 0;
#
#
#
# com.apple.systemuiserver" =     {
#        "NSStatusItem Visible Siri" = 0;
#        "NSStatusItem Visible com.apple.menuextra.airport" = 1;
#        "NSStatusItem Visible com.apple.menuextra.battery" = 1;
#        "NSStatusItem Visible com.apple.menuextra.bluetooth" = 1;
#        "NSStatusItem Visible com.apple.menuextra.clock" = 1;
#        "NSStatusItem Visible com.apple.menuextra.volume" = 1;
#        "__NSEnableTSMDocumentWindowLevel" = 1;
#        "last-analytics-stamp" = "635665569.6819431";
#        "last-messagetrace-stamp" = "609888625.659532";
#        menuExtras =         (
#            "/System/Library/CoreServices/Menu Extras/Clock.menu",
#            "/System/Library/CoreServices/Menu Extras/Battery.menu",
#            "/System/Library/CoreServices/Menu Extras/AirPort.menu",
#            "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
#            "/System/Library/CoreServices/Menu Extras/Volume.menu"
#        );
#    };




