#!/usr/bin/env bash


# based on https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#General:
# Set sidebar icons to Large
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 3
# Show scroll bars when scrolling
defaults write -g AppleShowScrollBars -string WhenScrolling
# Prefer tabs -> always (only for big sur)
defaults write -g AppleWindowTabbingMode -string always
# Automatic switching oof interface
defaults write -g AppleInterfaceStyleSwitchesAutomatically -int 1
# Show all extensions
defaults write -g AppleShowAllExtensions -bool true

#Dock:
# Set dock to size 84
defaults write com.apple.dock tilesize -int 84

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
defaults write com.apple.dock expose-animation-duration -int 0
defaults write -g NSWindowResizeTime -float 0.003
defaults write com.apple.dock expose-group-by-app -bool false

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Disable dock zoom on hover
defaults write com.apple.dock magnification -bool false
# Set minimize windows to application icon
defaults write com.apple.dock minimize-to-application -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Set menu bar date format
defaults write com.apple.menuextra.clock "DateFormat" "EEE d MMM  HH:mm"

defaults write -g ApplePressAndHoldEnabled -bool false

# Disable automatic corrections
defaults write -g NSAutomaticCapitalizationEnabled -int 0
defaults write -g NSAutomaticDashSubstitutionEnabled -int 0
defaults write -g NSAutomaticPeriodSubstitutionEnabled -int 0
defaults write -g NSAutomaticQuoteSubstitutionEnabled -int 0
defaults write -g NSAutomaticSpellingCorrectionEnabled -int 0
defaults write -g NSAutomaticTextCompletionCollapsed -int 0
defaults write -g NSAutomaticTextCompletionEnabled -int 0
defaults write -g WebAutomaticSpellingCorrectionEnabled -int 0

# Automatically hide and show menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Don't automatically rearrange spaces based od most recent use
defaults write com.apple.dock mru-spaces -bool false

#Language & Region
# Declare my locale
defaults write NSGlobalDomain AppleLocale -string "en_PL"

# Date string formats
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "1" "yyyy/MM/dd"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "2" "dd MMM y"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "3" "dd MMMM y"
defaults write NSGlobalDomain AppleICUDateFormatStrings -dict-add "4" "EEEE, dd MMMM y"

# 24-hour time is the only way to roll
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "1" "HH:mm"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "2" "HH:mm:ss"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "3" "HH:mm:ss z"
defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict-add "4" "HH:mm:ss zzzz"

# Set date and time formats for the system preference
defaults write com.apple.systempreferences AppleIntlCustomFormat -dict-add "AppleIntlCustomICUDictionary" "{'AppleICUDateFormatStrings'={'1'='yyyy/MM/dd';'2'='dd MMM y';'3'='dd MMMM y';'4'='EEEE, dd MMMM y';};'AppleICUTimeFormatStrings'={'1'='HH:mm';'2'='HH:mm:ss';'3'='HH:mm:ss z';'4'='HH:mm:ss zzzz';};}"

# Number and currency dot separators
defaults write -g AppleICUNumberSymbols -dict 0 '.' 1 ' ' 10 '.' 17 ' '

# Accessibility:
# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Security and privacy:
# require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Bluetooth:
# Set show bluetooth in menu bar to true
# TODO
# Volume:
# Show volume in menu bar
  TODO
# Alert volume set to 0
defaults write -g com.apple.sound.beep.volume -int 0

# Keyboard:
# Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Set a fast delay until repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Trackpad:
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set higher tracking speed
defaults write -g com.apple.trackpad.scaling -float 5.0

# Set trackpad response intensity
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
# Disable 'natural' scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Mouse:
defaults write -g com.apple.mouse.scaling -float 5.0
defaults write -g com.apple.scrollwheel.scaling -float 5.0

# Battery:
# Sleep the display after 15 minutes
sudo pmset -a displaysleep 10

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
sudo pmset -b sleep 10

# Disable power nap
sudo pmset -a powernap 0

# FINDER
# disable file extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

# RANDOM:
# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

chflags nohidden ~/Library

# allow touch id instead of password for sudo:
l="auth       sufficient     pam_tid.so"
f="/etc/pam.d/sudo"
t="/tmp/sudo"
## Add the following as the first line
#auth sufficient pam_tid.so
grep -q pam_tid.so $f || (  echo "$l" > $t && cat "$f" >> $t && sudo mv $t $f  )

killall Dock
killall Finder
killall Safari
killall SystemUIServer
killall Terminal