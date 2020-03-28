# Proj TimeMachine
If you edit on Premiere Pro, or use any adobe products for that matter, you've probably heard that you should wait a month or more after an update is release to actually update your software, to prevent bugs and crashes. Or maybe you simply doesn't have time to update. But we all have that co-worker who updates their adobe suite at the very first seconds of the release to get in touch with the new features. Unfortunately, if this guy sends you a .prproj file you would have no option but to update your suite if you want to open the file. No more.
Proj TimeMachine is a PC app that makes premiere projects compatible with older versions of the program. Just drag and drop as many files as you want, and it should do the trick in seconds. Yes, it's that easy.


# Installing
If you want to support me AND get a pre-compiled, ready to run version of the app, you can get it, for $1,99 with [![paypal](https://www.paypalobjects.com/webstatic/en_US/i/buttons/pp-acceptance-small.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=YAJSCD6JK8BN6) .
If you're a bit more advanced and my eternal gratitude is not valuable enouth for you, you can get it for free by compiling it yourself, following the instructions below (it's not that hard):


# Compilation
First, download the repo with all it's files, and keep them in a folder. Then you can either <a href="https://www.autohotkey.com/docs/Scripts.htm#ahk2exe">compile it yourself</a> or run the .ahk file with <a href="https://www.autohotkey.com/">AutoHotkey</a> installed in your machine. You're gonna have to install AHK anyway, but if you compile the ahk file to an exe you can uninstall ahk later (if you want to carry it on a usb stick, for example).


# Software utilization
This uses AutoHotkey and 7za to do the trick. It extracts the file inside the .prproj package, and edits it's texts to trick Premiere into thinking it was created in version 1. Then it puts it back inside the package.
