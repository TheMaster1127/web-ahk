#singleinstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ;setting the Windows Timer Resolution to 0.5ms, THIS IS A GLOBAL CHANGE
;OPTIMIZATIONS END
exitNum := 0
SetTimer, exit, 1000

FileAppend, %A_Hour%:%A_Min%:%A_Sec%, file.txt

sleep, 2
FileRead, file, file.txt
Gui 99: Color, 121212
Gui 99: -DPIScale
Gui 99: +AlwaysOnTop
Gui 99: Font, s14
Gui 99: Add, Text, cWhite x10 y10, %file%
Gui 99: Show, w1920 h1080
Gui 99: Maximize
Sleep, 3000
ExitApp
Return

exit:
exitNum++
if (exitNum >= 10)
{
ExitApp
}
Return