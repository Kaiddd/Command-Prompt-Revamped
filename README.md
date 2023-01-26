# Command-Prompt-In-Batch
For use on systems that disable command prompt via reg/gp edit

Functions nearly the same as simply running cmd.exe

# Additional Settings!
Additional settings, not found in even the real command prompt, may be found at the top of the source. Feel free to change them to your liking!

Settings may also be changed during run by simply setting the correct variables, for example, the command:
```
set autoCls=true
```
Will enable autoCls for the rest of the session, or until it is set back to false.

Current Additional Settings:
1. Auto CLS : Automatically clears the console after every command for you.
2. Clean Start : Skips the Microsoft Windows [Version.........] etc at startup.
3. Skip Custom Warning : Removes the warning about the CTRL-C bug, and the notifier of the settings existence that is echo'd at startup.
4. Color : Allows you to change cmd's start color

More to come... (Probably)

# Warning
Although it *should* work, I do **NOT** recommend running any sensitive actions this way, as there may be some bugs I do not know about. ***I am not liable for the program not doing exactly what you want!!***, those are ***your own*** risks.

# Use
Simply download and run the .cmd file, you can rename it to .bat if you wish for whatever reason.

# Issues
CTRL-C cannot be hooked/blocked, so CTRL-C will cause a pause, pressing it twice will skip this warning, but may close the prompt at times, recommended solution is responding "n".
