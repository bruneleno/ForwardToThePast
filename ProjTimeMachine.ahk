;This file is part of ProjTimeMachine.
;ProjTimeMachine is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
;ProjTimeMachine is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;You should have received a copy of the GNU General Public License along with ProjTimeMachine.  If not, see <https://www.gnu.org/licenses/>.

;Language variables
DropHere = Arraste os arquivos aqui`n`n`n`n`n
Copy =  `n`n`n<a href="%A_ScriptDir%\License.txt"> © Copyright 2020 Bruno Heleno.</a>`nVeja meu <a href="https://www.vimeo.com/bruneleno">portifólio</a> ou entre em <a href="mailto:brunohelenob@gmail.com">contato</a>.
FreeSoft =   Este programa é um software livre. <a href="%A_ScriptDir%\License.txt">Leia os termos.</a>
NoFile =   Nenhum arquivo ".prproj" detectado. <a href="">Tentar novamente?</a>  `n`n`n
UnsupportedNotice =   Algumas funções do projeto não estarão disponíveis, caso sua versão do Premiere não as suporte.
NonDestructive =   Este programa não afeta os arquivos originais.  Ele cria cópias, com o sufixo "_retrocompativel".  `nSe você já tiver arquivos com esse sufixo, eles podem ser substituídos.  `n
SingFiles = Arquivo detectado. <a href="">Converter agora?</a>  `n
PluFiles = Arquivos detectados. <a href="">Converter todos?</a>  `n
TheWordFile = Arquivo ; this is literally the word "file" since i already use "file" as a variable in this program
FileReady = pronto. Você pode 
OpenFolder = abrir a pasta</a> ou 
OpenFile = abrir o arquivo</a>.  `n
Done = Tudo pronto!
FileInfo = O arquivo está salvo ao lado do original, com o sufixo "_retrocompativel".`nAo abrí-lo, o Premiere te pedirá para convertê-lo para a versão que você está usando.  `n
FilesInfo = Os arquivos estão salvos ao lado dos originais, com o sufixo "_retrocompativel".`nAo abrí-los, o Premiere te pedirá para convertê-lo para a versão que você está usando.  `n
7z_Error = ERRO: 7za.exe não encontrado. Confira se extraiu todos os aquivos adicionais na mesma pasta deste EXE.
Restart = <a href="">Reiniciar</a>
suffix = retrocompativelson
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
Gui, Main:Add, Link, gReset,% NoFile
}
else
{
Gui, Main:Add, Text, cRed ,% UnsupportedNotice
Gui, Main:Add, Text, ,% NonDestructive
}
If Nn = 1
Gui, Main:Add, Link, gConvert,%  Nn " "SingFiles
If Nn > 1
Gui, Main:Add, Link, gConvert,%  Nn " "PluFiles
}
Else
{
}
Gui, Main:Show, AutoSize
Return

Convert:
{
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
	Gui, Main:Add, Link,, %TheWordFile%  %A_Index%  %FileReady% <a href="%Path%">%OpenFolder%<a href="%File%">%OpenFile%
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
GuiControl, Move, Text1, % "x" (A_GuiWidth / 2 - 80) "y" (A_GuiHeight / 2 - 10)
GuiControl, Move, creditos, % "x" (A_GuiWidth - 200) "y" (A_GuiHeight - 75)
}
else
{
GuiControl, Hide, Text1
GuiControl, Move, creditos, % "x" (A_GuiWidth - 200) "y" (A_GuiHeight - 65)
Gui, Main:Show, AutoSize
}
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



