;This file is part of ProjTimeMachine.
;ProjTimeMachine is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;ProjTimeMachine is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;You should have received a copy of the GNU General Public License along with ProjTimeMachine.  If not, see <https://www.gnu.org/licenses/>.

;Language variables
suffix = retrocompatible
DropHereX = 50
CopyX = 165
DropHere = Drop files here`n`n`n`n`n
Copy =  `n`n`n<a href="%A_ScriptDir%\License.txt"> © Copyright 2020 Bruno Heleno.</a>`nSee my <a href="https://www.vimeo.com/bruneleno">portfolio</a> or <a href="mailto:brunohelenob@gmail.com">contact me</a>.
FreeSoft =   This program is free software. <a href="%A_ScriptDir%\License.txt">Read more.</a>
NoFile =   No ".prproj" file detected. <a href="">Try again?</a>  `n`n`n
UnsupportedNotice =   In case your version of Premiere doesn't support a feature used in this project, it might be ignored by the program.
NonDestructive =   This app does not affect the original project files.  It creates copies, under the "_%suffix%" suffix.  `nIf you already have files with this suffix, then they will be replaced.  `n
SingFile = File found.
ConvNow = Convert now?`n
PluFiles = Files found. 
ConvAll = Convert all?`n
TheWordFile = File ; this is literally the word "file" since i already use "file" as a variable in this program
FileReady = ready. You can 
OpenFolder = open it's folder</a> or  
OpenFile = open the file</a>.  `n
Done = All done!
FileInfo = The file is saved alongside the original, with the "_%suffix%" suffix.`nUpon opening it, Premiere will prompt you to convert it to the version you're currently using.  `n
FilesInfo = The files are saved alongside the original, with the "_%suffix%" suffix.`nUpon opening them, Premiere will prompt you to convert it to the version you're currently using.  `n
7z_Error = ERROR: 7za.exe not found. Make shure you extracted all additional files in the same folder as this EXE.
Restart = <a href="">Try Again/convert more files</a>
;;;;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Off
#NoTrayIcon


7z_path = %A_ScriptDir%\7z\7za.exe
7z_Found := FileExist(7z_path)

if !7z_Found
{
Msgbox,% 7z_Error
Goto TheEnd
}

Gui, Main:New
Gui, Main:Color , 232323
Gui, Main:Show, w600 h200, Máquina do Tempo
Gui, Main:+AlwaysOnTop -MaximizeBox -MinimizeBox +MinSize600x200
Gui, Main:Font, s12 q5 c8A8A8A
Gui, Main:Add, Text, y-80 vText1,% DropHere
Gui, Main:Font, s9 q5 c8A8A8A
Gui, Main:Add, Link, vcreditos -Tabstop +Right,% Copy
Gui, Main:Font, s12 q5 c8A8A8A
Return


MainGuiDropFiles:
If !NotFirstTime
{
Gui, Main:Font, s11 q5 c8A8A8A
Gui, Main:Add, Link,y40 x20,% FreeSoft
Gui, Main:Font, s12 q5 c8A8A8A
;DroppedFile:=A_GuiEvent

NotFirstTime .= 1
Nn = 0
FileList := A_GuiEvent
Loop, Parse, A_GuiEvent, `n
{
	Field := A_LoopField
	StringRight, NewStr, A_LoopField, 7
	If (NewStr = ".prproj")
	{
	Nn := ++Nn
	}
	continue
} 
Sleep, 1
if Nn < 1
{
Gui, Main:Add, Link, w%A_GuiWidth% gReset,% NoFile
}
else
{
Gui, Main:Add, Text, cRed ,% UnsupportedNotice
Gui, Main:Add, Text, ,% NonDestructive
}
If Nn = 1
Gui, Main:Add, Link, vConvSingLink gConvert,  %Nn%  %SingFile% <a href="">%ConvNow%</a>
If Nn > 1
Gui, Main:Add, Link, vConvAllLink gConvert,  %Nn%  %PluFiles% <a href="">%ConvAll%</a>
}
Else
{
}
Gui, Main:Show, AutoSize
Return

Convert:
If !NotFirstConversion
{
NotFirstConversion .= 1
Gui, Main:-AlwaysOnTop +MinimizeBox
Loop, Parse, FileList, `n
{
	Field := A_LoopField
	Loop, Parse, Field, \
	{
	Length := StrLen(A_LoopField)
	FLength := - Length
	File := SubStr(Field, FLength + 1, Length)
	Path := SubStr(Field, 1 , FLength -1)
	}
	StringRight, NewStr, A_LoopField, 7
	If (NewStr = ".prproj")
	{
	OGfile = %A_LoopField%
	OGProj := SubStr(OGfile, 1 , -7)
	Proj = %OGProj%_%suffix%
	file = %Proj%.prproj
	FileCopy, %OGfile%, %file%
	RunWait, "%7z_path%" e "%file%" -aou, %Path%, Hide
	FileRead, heading, *m177 %Proj%
	NewStr := SubStr(heading, 1 , -6)
	heading2 = %NewStr%"1">
	FileRead, giant, %Proj%
	NewGStr := SubStr(giant, 177)
	FinalStr = %heading2%%NewGStr%
	FileDelete, %Proj%
	FileAppend , %FinalStr%, %Proj%
	RunWait, "%7z_path%" a "%file%" "%Proj%" , %Path%, Hide
	FileDelete, %Proj%
	Gui, Main:Add, Link,, %TheWordFile%  %A_Index%  %FileReady% <a href="%Path%">%OpenFolder% <a href="%File%">%OpenFile%
	Gui, Main:Show, AutoSize
	Winset, redraw
	}
	continue
} 
Sleep, 1
Gui, Main:Font, w600
Gui, Main:Add, Text, c38ff9b,% Done
Gui, Main:Font, w400
if Nn = 1
{
Gui, Main:Add, Text,,% FileInfo
}
else
{
Gui, Main:Add, Text,,% FilesInfo
}
Gui, Main:Add, Link, gReset,% Restart
Gui, Main:Show, AutoSize
Winset, redraw
Gui, Main:Show, AutoSize
}
Return

MainGuiSize:
if !Nn
{
GuiControl, Move, Text1, % "x" (A_GuiWidth / 2 - DropHereX) "y" (A_GuiHeight / 2 - 10)
GuiControl, Move, creditos, % "x" (A_GuiWidth - CopyX) "y" (A_GuiHeight - 75)
}
else
{
GuiControl, Move, Text1, x-100 y-100
GuiControl, Move, creditos, % "x" (A_GuiWidth - CopyX) "y" (A_GuiHeight - 65)
sleep,10
Gui, Main:Show, AutoSize
}
If NotFirstConversion = 1
{
GuiControl, Text, ConvSingLink,  %Nn%  %SingFile% %ConvNow%
GuiControl, Text, ConvAllLink,  %Nn%  %PluFiles% %ConvAll%
}
Winset, Redraw
Return

Reset:
reload
return

TheEnd:
MainGuiEscape:
MainGuiClose:
ButtonCancel:
ExitApp  ; All of the above labels will do this.
return



