﻿;This file is part of ForwardToThePast.
;ForwardToThePast is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;ForwardToThePast is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;You should have received a copy of the GNU General Public License along with ForwardToThePast.  If not, see <https://www.gnu.org/licenses/>.


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Off
#NoTrayIcon

lang =

;Language variables
if lang = PT
{
;Portuguese Translation
DropTitle = Máquina do Tempo
suffix = retrocompativel
DropHereX = 80
CopyX = 200
DropHere = Arraste os arquivos aqui`n`n`n`n`n
Copy =  `n`n`n<a href="%A_ScriptDir%\License.txt"> © Copyright 2020 Bruno Heleno.</a>`nVeja meu <a href="https://linktr.ee/bruneleno">portifólio</a> ou entre em <a href="mailto:brunohelenob@gmail.com">contato</a>.`nConsidere <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EEQ5C56XVNBAN&source=url">apoiar meu trabalho</a>.
FreeSoft =   Este programa é um software livre. <a href="%A_ScriptDir%\License.txt">Leia os termos.</a>
NoFile =   Nenhum arquivo ".prproj" detectado. <a href="">Tentar novamente?</a>  `n`n`n
UnsupportedNotice =   Algumas funções do projeto não estarão disponíveis, caso sua versão do Premiere não as suporte.
NonDestructive =   Este programa não afeta os arquivos originais.  Ele cria cópias, com o sufixo "_%suffix%".  `nSe você já tiver arquivos com esse sufixo, eles podem ser substituídos.  `n
SingFile = Arquivo detectado. 
ConvNow = Converter agora?`n
PluFiles = Arquivos detectados.
ConvAll = Converter todos?`n
TheWordFile = Arquivo ; this is literally the word "file" since i already use "file" as a variable in this program
FileReady = Arquivo pronto. Você pode 
FilesReady = Arquivos prontos. Você pode
OpenFolder = abrir a pasta</a> 
OpenFile = ou abrir o arquivo</a>.  `n
Done = Tudo pronto!
FileInfo = O arquivo está salvo ao lado do original, com o sufixo "_%suffix%".`nAo abrí-lo, o Premiere te pedirá para convertê-lo para a versão que você está usando.  `n
FilesInfo = Os arquivos estão salvos ao lado dos originais, com o sufixo "_%suffix%".`nAo abrí-los, o Premiere te pedirá para convertê-lo para a versão que você está usando.  `n
7z_Error = ERRO: 7za.exe não encontrado. Confira se extraiu todos os aquivos adicionais na mesma pasta deste EXE.
Restart = <a href="">Reiniciar</a>
;;;;
}
Else
{
;English
DropTitle = Time Machine
suffix = retrocompatible
DropHereX = 50
CopyX = 165
DropHere = Drop files here`n`n`n`n`n
Copy =  `n`n`n<a href="%A_ScriptDir%\License.txt"> © Copyright 2020 Bruno Heleno.</a>`nSee my <a href="https://linktr.ee/bruneleno">portfolio</a> or <a href="mailto:brunohelenob@gmail.com">contact me</a>.`nAlso consider <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=EEQ5C56XVNBAN&source=url"> supporting my work</a>.
FreeSoft =   This program is free software. <a href="%A_ScriptDir%\License.txt">Read more.</a>
NoFile =   No ".prproj" file detected. <a href="">Try again?</a>  `n`n`n
UnsupportedNotice =   In case your version of Premiere doesn't support a feature used in this project, it might be ignored by the program.
NonDestructive =   This app does not affect the original project files.  It creates copies, under the "_%suffix%" suffix.  `nIf you already have files with this suffix, then they will be replaced.  `n
SingFile = File found.
ConvNow = Convert now?`n
PluFiles = Files found. 
ConvAll = Convert all?`n
TheWordFile = File ; this is literally the word "file" since i already use "file" as a variable in this program
FileReady = File ready. You can 
FilesReady = Files ready. You can 
OpenFolder = open it's folder</a>   
OpenFile = or open the file</a>.  `n
Done = All done!
FileInfo = The file is saved alongside the original, with the "_%suffix%" suffix.`nUpon opening it, Premiere will prompt you to convert it to the version you're currently using.  `n
FilesInfo = The files are saved alongside the original, with the "_%suffix%" suffix.`nUpon opening them, Premiere will prompt you to convert it to the version you're currently using.  `n
7z_Error = ERROR: 7za.exe not found. Make shure you extracted all additional files in the same folder as this EXE.
Restart = <a href="">Try Again/convert more files</a>
;;;;
}


7z_path = %A_ScriptDir%\7z\7za.exe
7z_Found := FileExist(7z_path)

if !7z_Found
{
Msgbox,% 7z_Error
Goto TheEnd
}

Gui, Main:New
Gui, Main:Color , 232323
Gui, Main:Show, w600 h200, % DropTitle
Gui, Main:+AlwaysOnTop -MaximizeBox +MinSize600x200
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
Gui, Main:Show, NA AutoSize 
Return

Convert:
If !NotFirstConversion
{
NotFirstConversion .= 1
Gui, Main:-AlwaysOnTop +MinimizeBox
Count := 0
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
	Count := Count+1
	}
}
ProgUnit := 100/Count
Gui, Add, Progress, w800 h20 c38ff9b vProgressb +Background232323, 0
Gui, Add, Text, vParagrath , `n`n
Gui, Main:Show, NA AutoSize 
if Count = 1
GuiControl,, Progressb, 50
else
GuiControl,, Progressb,% "+"ProgUnit
sleep, 10
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
	Gui, Main:Show, NA AutoSize 
	Winset, redraw
	LastPath := Path
	LastFile := File
	GuiControl,, Progressb,% "+"ProgUnit
	}
	continue
} 
SoundPlay, *48
if Nn = 1
Gui, Main:Add, Link, yp10, %FileReady% <a href="%Path%">%OpenFolder% <a href="%File%">%OpenFile%
else
Gui, Main:Add, Link, yp10, %Count% %FilesReady% <a href="%Path%">%OpenFolder%.
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
Gui, Main:Show, NA AutoSize 
Winset, redraw
Gui, Main:Show, NA AutoSize 
}
Return

MainGuiSize:
if !Nn
{
GuiControl, Move, Text1, % "x" (A_GuiWidth / 2 - DropHereX) "y" (A_GuiHeight / 2 - 10)
GuiControl, Move, creditos, % "x" (A_GuiWidth - CopyX) "y" (A_GuiHeight - 80)
}
else
{
GuiControl, Move, Text1, x-100 y-100
GuiControl, Move, creditos, % "x" (A_GuiWidth - CopyX) "y" (A_GuiHeight - 70)
sleep,10
Gui, Main:Show, NA AutoSize 
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



