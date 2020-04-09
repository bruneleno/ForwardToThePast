# Proj TimeMachine
If you edit on Premiere Pro, or use any adobe products for that matter, you've probably heard that you should wait a month or more after an update is release to actually update your software, to prevent bugs and crashes. Or maybe you simply doesn't have time to update. But we all have that co-worker who updates their adobe suite at the very first seconds of the release to get in touch with the new features. Unfortunately, if this guy sends you a .prproj file you would have no option but to update your suite if you want to open the file. No more.
Proj TimeMachine is a PC app that makes premiere projects compatible with older versions of the program. Just drag and drop as many files as you want, and it should do the trick in seconds. Yes, it's that easy.



# Support my work
Please, consider helping me with any amount to help me update the software and create new tools. </br></br>
[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EEQ5C56XVNBAN&source=url)


# Installing
Get the compiled release on the [releases](https://github.com/bruneleno/ProjTimeMachine/releases) page. Just run the EXE file in a folder that also contarins the Support_Files folder.


# Compilation
First, download the repo with all it's files, and keep them in a folder. Then you can either <a href="https://www.autohotkey.com/docs/Scripts.htm#ahk2exe">compile it yourself</a> or run the .ahk file with <a href="https://www.autohotkey.com/">AutoHotkey</a> installed in your machine. You're gonna have to install AHK anyway, but if you compile the ahk file to an exe you can uninstall ahk later (if you want to carry it on a usb stick, for example).


# Software utilization
This uses AutoHotkey and 7za to do the trick. It extracts the file inside the .prproj package, and edits it's texts to trick Premiere into thinking it was created in version 1. Then it puts it back inside the package.
