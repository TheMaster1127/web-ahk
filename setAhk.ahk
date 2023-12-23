#Persistent
#singleinstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Include the JSON library
#Include JSON.ahk
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
Sleep, 10


; Load the JSON file
JsonFile := "receivedCode.json"
FileRead, JsonText, %JsonFile%

Json := JSON.Load(JsonText, ErrorMsg) ; Use Load instead of LoadFile

; Check if the JSON file is loaded successfully
if !IsObject(Json) {
    MsgBox, JSON file could not be loaded!`nError: %ErrorMsg%
    ExitApp
}



; Function to format the provided time string into a readable date and time format
FormatTime(timeString) {
    ; Extract individual components from the time string
    year := SubStr(timeString, 1, 4)
    month := SubStr(timeString, 5, 2)
    day := SubStr(timeString, 7, 2)
    hour := SubStr(timeString, 9, 2)
    minute := SubStr(timeString, 11, 2)
    second := SubStr(timeString, 13, 2)

    ; Build the formatted time string
    formattedTime := "Date-" . day . "-" . month . "-" . year . " Time-" . hour . "-" . minute . "-" . second
    return formattedTime
}


inputTime := A_Now
formattedTime := FormatTime(inputTime)


; Extract words from the JSON object
code := Json.ahkCode
FileAppend,
(
======================================================
=======[Log from %formattedTime%]=======
======================================================
`n%code%`n
), log.txt



FileDelete, file.txt
FileDelete, run.ahk
FileAppend,
(
#singleinstance force
SetWorkingDir `%A_ScriptDir`%  ; Ensures a consistent starting directory.
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

%code%

sleep, 2
FileRead, file, file.txt
Gui 99: Color, 121212
Gui 99: -DPIScale
Gui 99: +AlwaysOnTop
Gui 99: Font, s14
Gui 99: Add, Text, cWhite x10 y10, `%file`%
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
), run.ahk
Sleep, 1
CoordMode, Mouse, Screen
MouseMove, 0, 0
Sleep, 1
Run run.ahk
Sleep, 4000
fullScriptPath := "run.ahk" ; Replace with your full script path
DetectHiddenWindows, On
WinClose, %fullScriptPath% ahk_class AutoHotkey
WinClose, run.ahk
ExitApp