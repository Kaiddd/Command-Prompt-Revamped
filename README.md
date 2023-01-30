# Command-Prompt-Revamped
For use on systems that disable command prompt via reg/gp edit, with the goal of being better than the original.

By default functions nearly the same as simply running cmd.exe

# Why use this over cmd.exe directly?
1. Use it anywhere! | cmd.exe can be disabled via a regkey, organizations tend to do this a LOT, this will bypass that. (The command prompt has been disabled by your administrator.)
2. Configuration! | bCmd has settings that can be configured at the top of the .cmd file!
3. Features! | bCmd has custom settings such as auto clearing the console, built in Chocolatey, git, and programming languages! (Currently just git, chocolatety, and curl)

# Additional Settings!
Additional settings, not found in even the real command prompt, may be found at the top of the source. Feel free to change them to your liking!

Settings may also be changed during run by simply setting the correct variables, for example, the command:
```
set autoCls=true
rem (There will later be a command to automatically do this too (: )
```
Will enable autoCls for the rest of the session, or until it is set back to false.

Current Additional Settings:
1. Auto CLS : Automatically clears the console after every command for you.
2. Clean Start : Skips the Microsoft Windows [Version.........] etc at startup.
3. Skip Custom Warning : Removes the warning about the CTRL-C bug, and the notifier of the settings existence that is echo'd at startup.
4. Color : Allows you to change cmd's start color
5. Install Chocolatety : Installs Chocolatety, a Windows package manager! Has options for an admin and a nonadmin installation.
6. Install Git : Installs git!

More to come... (Probably)

# Warning
Although it *should* work, I do **NOT** recommend running any sensitive actions this way, as there may be some bugs I do not know about. ***I am not liable for the program not doing exactly what you want!!***, those are ***your own*** risks.

# Use
Simply download and run the .cmd file, you can rename it to .bat if you wish for whatever reason.

# Issues
CTRL-C cannot be hooked/blocked, so CTRL-C will cause a pause, pressing it twice will skip this warning, but may close the prompt at times, recommended solution is responding "n".
/? for usage only shows the usage of the call command.

# bCmd Minimal?
Minimal is bCmd without settings options and such, still fully functioning as a cmd replacement. Nothing extra.

Minimal_Smaller is Minimal but without the Microsoft watermark, etc, fully functions.

Minimal_Smallest is completely butchered. Variables do not work in commands (You cannot for example pass %cd% into a command), and the console is spammed as @echo off is not ran. Loads of issues! But fits in just 26 bytes.
