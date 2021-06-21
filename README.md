# AutoHotkey
A list of my AutoHotKey scripts

I use a primary script that handles everything with the help of a few function script files.
The exception to this rule are scripts made for games, which are set to automatically close once the game closes, and the IFTTT Script, which is constantly running (though is called from the master script).

## Scripts an Functions
### Scripts
- Master Script
  - This is the master script for my primary Desktop, though could be used on other systems. This script include a multitude of different macros, functions, timers, and other scripts. When the Master Script starts, it displays a small logo splash screen in the top center of the monitor. 
- IFTTTComputerCommands
  - Watches for a file, reads the contents (single word, no white spaces) and executes an action/macro. 
  - Adds a log entry every time a command is executed. 
  - The "fileToWatch" is generated from an IFTTT recipe connected to Google Home and Dropbox. Google command triggers the creation of a file named "ComputerCommands.txt" and fills it with a single STRING on the first line. 
  - List of Scripts:
    - Put computer to Sleep
    - Reboot PC
    - Turn off Monitors 
    - Change Audio (Hits the key assigned to 'Change Audio' to cycle audio devices)
    - Multiple Change Audio to a specific device
    - Script to launch Kodi, change audio to speakers, switch to TV (Projector) and fullscreen application
    - Script to launch Plex, change audio to speakers, switch to TV (Projector) and fullscreen application
    - Focus Kodi - Focus the Kodi window so it's in the foreground
    - Pause Kodi (Literally hits the space bar)
    - Fullscreen Kodi
    - Kill Kodi
    - F.lux: Toggle
    - F.lux: Dim
    - F.lux: Brighten
    - F.lux: Normal
    - Change Monitors: Primary, Duplicate, Extend, Projector
    - Launch Zelda BOTW
    - Reload (this) Script
    - TEST (For testing other scripts)

### Functions
- Change Audio Devices - SetDefaultAudioDevice(AudDev, MicDev, audiosplashfile)
  - Assigns new Default Audio and Recording devices with a single key press. 
  - Uses NirCMD to avoid popup windows (which take focus from other applications)
  - Transparent Splashimages centered on every monitor to display which device is now active

   ![image](https://user-images.githubusercontent.com/16886667/122694945-dd00b000-d1f3-11eb-8922-4db066a887c8.png)


- Custom Program Volume - ChangeCurProgramVolume(UpOrDown:="Up")
  - Includes functions to Raise/Lower volume, Mute Volume, Max Volume and Last known volume.
  - Each function is applied to the currently active window. 
  - Displays Progress Bar to show program name, and current volume.
   
     ![image](https://user-images.githubusercontent.com/16886667/122694468-497aaf80-d1f2-11eb-942f-1e3f50941cf1.png)
- Project Monitor - ProjectMonitor(Screen)
  - Change Monitors: Primary, Duplicate, Extend, Projector
- ProgressBarTheme - ProgressBarThemed(yCoord:=75, bGroundColor:=212121, textColor:="DAE6EA", mainText:="", subText:="")
  - Used for any scripts that can use a progress bar. Such as the volume function. 
  - Progress bar is made Semi-Transparent, darker background, whiter text, and minimalist borders.  
- Save All Open Window Locations - SaveAllWindowLocations(LayoutType:="") | RestoreAllWindowLocations(LayoutType:="")
  - Saves the location of all open windows to a .ini file. 
  - Restore Window locations from a .ini file
  - I have a GUI I used with this to create both keybindings to save/restore default window layouts, and a gui for saving additional window layouts (for example specific work configurations)
  - Sometimes doesn't work well with programs that have multiple windows, and or programs who's "Window Title" changes as you move from page to page. 
- Pushbullet Move - AdjustPushbullet() | HideAdjustPushBullet()
  - Was used to show/hide pushbullet Bubbles. Haven't used or touched since 2018
