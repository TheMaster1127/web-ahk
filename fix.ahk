;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Name:
; new dhfckf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#singleinstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;;;;;;;;;;;;;;;;;;;;

num := 0
SetTimer, check, 1000



;;;;;;;;;;;;;;;;;;;;;;;;
site := "http://127.0.0.1:8000/web"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Load the website
ie := ComObjCreate("InternetExplorer.Application")
ie.Visible := false
ie.Navigate(site)
While ie.ReadyState != 4 || ie.Busy
    Sleep 10


; Get the page contents
doc := ie.Document
pageText := doc.documentElement.innerText

; Clean up
ie.Quit()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fileContents123 := pageText

;;;;;;;;;;;;;;;;;;;;;;;;

if (InStr(fileContents123, "This website could not be found"))
{
SetTimer, check, Off
MsgBox,,, BrokenKKK, 1
gosub closeScripts
Sleep, 200
run web ahk.ahk
Sleep, 1000
run %A_ScriptFullPath%
ExitApp
}

Sleep, 50000
run %A_ScriptFullPath%
ExitApp

Return

check:
num++
if (num > 60)
{
SetTimer, check, Off
MsgBox,,, Broken, 1
gosub closeScripts
run web ahk.ahk
Sleep, 1000
run %A_ScriptFullPath%
ExitApp
}
Return

closeScripts:
fullScriptPath := "setAhk.ahk" ; Replace with your full script path

DetectHiddenWindows, On
WinClose, %fullScriptPath% ahk_class AutoHotkey

fullScriptPath := "mJsomAhk.ahk" ; Replace with your full script path

DetectHiddenWindows, On
WinClose, %fullScriptPath% ahk_class AutoHotkey

fullScriptPath := "mJsomAhk2.ahk" ; Replace with your full script path

DetectHiddenWindows, On
WinClose, %fullScriptPath% ahk_class AutoHotkey


fullScriptPath := "web ahk.ahk" ; Replace with your full script path

DetectHiddenWindows, On
WinClose, %fullScriptPath% ahk_class AutoHotkey


Return

