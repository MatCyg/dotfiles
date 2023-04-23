
Some things are not yet automated:

# Apps to install manually:
- [TickTick](https://apps.apple.com/us/app/ticktick-to-do-list-remind/id966085870)
- [Alfred 4](https://www.alfredapp.com)
- [Little Snitch](https://www.obdev.at/)
- [IntelliJ](https://www.jetbrains.com)

# System preferences:

### Keyboard:
[comment]: <> (google for AppleSymbolicHotKeys)
1. Launchpad & Dock -> disable all shortcuts
2. Keyboard -> disable all beside `Move focus to next window`
3. Services -> disable `Open and search man Page in Terminal`
4. Spotlight -> change spotlight shortcut to ⌘⌥Space
5. Accessibility -> disable all
6. Dictation -> turn off shortcut
7. Keyboard -> Select `Turn off keyboard backlight after 5 seconds`
8. Change `Caps Lock` modifier to `Control`

### Screen:
1. Night Shift -> sunset to sunrise
2. Color temperature -> max warm

### Battery:
1. Battery:
   - Select `Optimize video streaming while on battery`
   - Show batter in menu bar true

2. Power Adapter
   - Disable power nap
   - Somewhere should be an option to show current charge in percentage

### Accessibility
1. Zoom  
   - Select `Use scroll gesture with modifier keys to zoom` 
   - Advanced select `Only when the pointer reaches an edge`
2. Display
   - `Reduce motion`
   - `Reduce transparency`

### Sharing
1. Verify sharing option and disable remote login
2. Check details of installed profiles by running `sudo /usr/bin/profiles show`
3. Check defaults preferences for third parties by verifying `sudo defaults read`

# Applications preference:

### Alfred
Features -> Clipboard History -> Select:
   - Keep Plain Text
   - Keep Images
   - Keep File Lists

### Firefox
- Set defaults:
```
accessibility.typeaheadfind.prefillwithselection true
browser.compactmode.show true
toolkit.legacyUserProfileCustomizations.stylesheets true
```
- Change monospace font.