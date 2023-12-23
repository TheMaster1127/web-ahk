;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Name:
; web ahk
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#Persistent
#singleinstance force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;;;;;;;;;;;;;;;;;;;;;
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

CoordMode, Mouse, Screen  ; Set coordinates to be relative to the screen


#Include AHKhttp.ahk
#Include AHKsock.ahk
#Include JSON.ahk

FileReadLine, imageTag1, imageTag.txt, 1
FileReadLine, imageTag2, imageTag.txt, 2

global imageTag1, imageTag2, Base64ImageData

paths := {}
paths["/"] := Func("HelloWorld")
paths["404"] := Func("NotFound")
paths["/web"] := Func("web")
paths["/button"] := Func("button")
paths["/button2"] := Func("button2")
paths["/mousepos"] := Func("mousepos")
paths["/copy"] := Func("copy")
paths["/paste"] := Func("paste")
paths["/clickl"] := Func("clickl")
paths["/clickr"] := Func("clickr")
paths["/holdl"] := Func("holdl")
paths["/holdr"] := Func("holdr")
paths["/releasel"] := Func("releasel")
paths["/releaser"] := Func("releaser")
paths["/custom"] := Func("custom")
paths["/moveup"] := Func("moveup")
paths["/movedown"] := Func("movedown")
paths["/moveleft"] := Func("moveleft")
paths["/moveright"] := Func("moveright")



server := new HttpServer()
server.LoadMimes(A_ScriptDir . "/mime.types")
server.SetPaths(paths)
server.Serve(8000)
Return

web(ByRef req, ByRef res, ByRef server) {
    server.ServeFile(res, A_ScriptDir . "/index.html")
    res.status := 200
}

NotFound(ByRef req, ByRef res) {
    res.SetBodyText("Page not found")
}

HelloWorld(ByRef req, ByRef res) {
    res.SetBodyText("Hello World")
    res.status := 200
}


















; Function for /mousepos endpoint
mousepos(ByRef req, ByRef res, ByRef server) {

    ; Get X and Y coordinates from the request
    if (req.method = "POST") {
        ; Check if the request has a body
        if (req.body != "") {
            ; Read the AHK code from the request body
            ahkPos := req.body

            FileDelete, receivedCode2.json
            FileAppend, %ahkPos%, receivedCode2.json

Run mJsonAhk.ahk
    res.status := 200
        } else {
            res.SetBodyText("No AHK code provided in the request body")
            res.status := 400 ; Bad Request
        }
    } else {
        res.SetBodyText("Invalid request method. Use POST.")
        res.status := 405 ; Method Not Allowed
    }
    ; Do something with X and Y, e.g., move the mouse



} ; end of func mousepos

; Function for /copy endpoint
copy(ByRef req, ByRef res, ByRef server) {
    ; Simulate Ctrl+C to copy
    Send, ^c

    res.status := 200
} ; end of func copy

; Function for /paste endpoint
paste(ByRef req, ByRef res, ByRef server) {
    ; Simulate Ctrl+V to paste
    Send, ^v

    res.status := 200
} ; end of func paste

; Function for /clickl endpoint
clickl(ByRef req, ByRef res, ByRef server) {
    ; Simulate a left mouse click
    Click

    res.status := 200
} ; end of func clickl

; Function for /clickr endpoint
clickr(ByRef req, ByRef res, ByRef server) {
    ; Simulate a right mouse click
    Click right

    res.status := 200
} ; end of func clickr

; Function for /holdl endpoint
holdl(ByRef req, ByRef res, ByRef server) {
    ; Simulate holding down the left mouse button
   Click, Down

    res.status := 200
} ; end of func holdl

; Function for /holdr endpoint
holdr(ByRef req, ByRef res, ByRef server) {
    ; Simulate holding down the right mouse button
    MouseClick, right, , , , D

    res.status := 200
} ; end of func holdr

; Function for /releasel endpoint
releasel(ByRef req, ByRef res, ByRef server) {
    ; Simulate releasing the left mouse button
   Click, Up

    res.status := 200
} ; end of func releasel

; Function for /releaser endpoint
releaser(ByRef req, ByRef res, ByRef server) {
    ; Simulate releasing the right mouse button
    MouseClick, right, , , , U

    res.status := 200
} ; end of func releaser




; Function for /moveup endpoint
moveup(ByRef req, ByRef res, ByRef server) {
    MouseMoveDirection(0, -10)
    res.status := 200
}

; Function for /movedown endpoint
movedown(ByRef req, ByRef res, ByRef server) {
    MouseMoveDirection(0, 10)
    res.status := 200
}

; Function for /moveleft endpoint
moveleft(ByRef req, ByRef res, ByRef server) {
    MouseMoveDirection(-10, 0)
    res.status := 200
}

; Function for /moveright endpoint
moveright(ByRef req, ByRef res, ByRef server) {
    MouseMoveDirection(10, 0)
    res.status := 200
}

; Generic function to move the mouse in a specified direction
MouseMoveDirection(dx, dy) {
    ; Get current mouse position
    MouseGetPos, mouseX, mouseY

    ; Calculate new mouse position
    newX := mouseX + dx
    newY := mouseY + dy

    ; Move the mouse to the new position
    MouseMove, % newX, % newY
}


; Function for /custom endpoint
custom(ByRef req, ByRef res, ByRef server) {
    ; Get custom input from the request

    if (req.method = "POST") {
        ; Check if the request has a body
        if (req.body != "") {
            ; Read the AHK code from the request body
            ahkCustom := req.body

            FileDelete, receivedCode3.json
            FileAppend, %ahkCustom%, receivedCode3.json

Run mJsonAhk2.ahk
    res.status := 200
        } else {
            res.SetBodyText("No AHK code provided in the request body")
            res.status := 400 ; Bad Request
        }
    } else {
        res.SetBodyText("Invalid request method. Use POST.")
        res.status := 405 ; Method Not Allowed
    }
    ; Do something with X and Y, e.g., move the mouse



    res.status := 200
} ; end of func



















button(ByRef req, ByRef res, ByRef server)
{


    if (req.method = "POST") {
        ; Check if the request has a body
        if (req.body != "") {
            ; Read the AHK code from the request body
            ahkCode := req.body
            FileDelete, %A_ScriptDir%\receivedCode.json
            FileAppend, %ahkCode%, %A_ScriptDir%\receivedCode.json
            run setAhk.ahk
            res.status := 200
        } else {
            res.SetBodyText("No AHK code provided in the request body")
            res.status := 400 ; Bad Request
        }
    } else {
        res.SetBodyText("Invalid request method. Use POST.")
        res.status := 405 ; Method Not Allowed
    }
}



button2(ByRef req, ByRef res, ByRef server)
{
File := "screen.png"
RunWait, decreaseQuality.py, , Hide
Sleep, 10
FileGetSize, nBytes, %File%
FileRead, Bin, *c %File%
ImageData := Base64Enc(Bin, nBytes, 100, 2 )


; Encode the image data to base64
Base64ImageData := StrReplace(ImageData, "`n", "") ; Remove line breaks
Base64ImageData := StrReplace(Base64ImageData, "`r", "") ; Remove carriage returns
Base64ImageData := StrReplace(Base64ImageData, "`t", "") ; Remove tabs
Base64ImageData := StrReplace(Base64ImageData, " ", "") ; Remove spaces
global Base64ImageData := imageTag1 . Base64ImageData . imageTag2

res.SetBodyText(Base64ImageData)



    res.status := 200
} ; end of func button





Base64Enc( ByRef Bin, nBytes, LineLength := 64, LeadingSpaces := 0 ) { ; By SKAN / 18-Aug-2017
    Local Rqd := 0, B64, B := "", N := 0 - LineLength + 1  ; CRYPT_STRING_BASE64 := 0x1
      DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin ,"UInt",nBytes, "UInt",0x1, "Ptr",0,   "UIntP",Rqd )
      VarSetCapacity( B64, Rqd * ( A_Isunicode ? 2 : 1 ), 0 )
      DllCall( "Crypt32.dll\CryptBinaryToString", "Ptr",&Bin, "UInt",nBytes, "UInt",0x1, "Str",B64, "UIntP",Rqd )
      If ( LineLength = 64 and ! LeadingSpaces )
        Return B64
      B64 := StrReplace( B64, "`r`n" )
      Loop % Ceil( StrLen(B64) / LineLength )
        B .= Format("{1:" LeadingSpaces "s}","" ) . SubStr( B64, N += LineLength, LineLength )
    Return RTrim( B,"`n" )
    }

