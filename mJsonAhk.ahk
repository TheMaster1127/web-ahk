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
CoordMode, Mouse, Screen
; Load the JSON file
JsonFile := "receivedCode2.json"
FileRead, JsonText, %JsonFile%

Json := JSON.Load(JsonText, ErrorMsg)

; Check if the JSON file is loaded successfully
if !IsObject(Json) {
    MsgBox, JSON file could not be loaded!`nError: %ErrorMsg%
    ExitApp
}

; Extract values of "x" and "y"
x := Json.x
y := Json.y

; Display the values
;MsgBox, %x%|%y%
    MouseMove, %x%, %y%
ExitApp