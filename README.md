# Proj TimeMachine
If you edit on Premiere Pro, or use any adobe products for that matter, you've probably heard that you should wait a month or more after an update is release to actually update your software, to prevent bugs and crashes. Or maybe you simply doesn't have time to update. But we all have that co-worker who updates their adobe suite at the very first seconds of the release to get in touch with the new features. Unfortunately, if this guy sends you a .prproj file you would have no option but to update your suite if you want to open the file. No more.
Proj TimeMachine is a PC app that makes premiere projects compatible with older versions of the program. Just drag and drop as many files as you want, and it should do the trick in seconds. Yes, it's that easy.



# Compilation
Right now, the only way to get it is by either compiling it yourself or running it with <a href="https://www.autohotkey.com/">AutoHotkey</a> installed. Luckly, it is easy to do. Just install AHK from it's website and download the repo. If you want to support me, I'll be selling an easy to use, pre-compiled EXE of it for $1.99.




# Software utilization
This uses AutoHotkey and 7za to do the trick. It extracts the file inside the .prproj package, and edits it's texts to trick Premiere into thinking it was created in version 1. Then it puts it back inside the package.
