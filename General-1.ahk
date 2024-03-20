;                 AAA               HHHHHHHHH     HHHHHHHHHKKKKKKKKK    KKKKKKK          ((((((   1111111                  ///////222222222222222     ))))))     
;                A:::A              H:::::::H     H:::::::HK:::::::K    K:::::K        ((::::::( 1::::::1                 /:::::/2:::::::::::::::22  )::::::))   
;               A:::::A             H:::::::H     H:::::::HK:::::::K    K:::::K      ((:::::::( 1:::::::1                /:::::/ 2::::::222222:::::2  ):::::::)) 
;              A:::::::A            HH::::::H     H::::::HHK:::::::K   K::::::K     (:::::::((  111:::::1               /:::::/  2222222     2:::::2   )):::::::)
;             A:::::::::A             H:::::H     H:::::H  KK::::::K  K:::::KKK     (::::::(       1::::1              /:::::/               2:::::2     )::::::)
;            A:::::A:::::A            H:::::H     H:::::H    K:::::K K:::::K        (:::::(        1::::1             /:::::/                2:::::2      ):::::)
;           A:::::A A:::::A           H::::::HHHHH::::::H    K::::::K:::::K         (:::::(        1::::1            /:::::/              2222::::2       ):::::)
;          A:::::A   A:::::A          H:::::::::::::::::H    K:::::::::::K          (:::::(        1::::l           /:::::/          22222::::::22        ):::::)
;         A:::::A     A:::::A         H:::::::::::::::::H    K:::::::::::K          (:::::(        1::::l          /:::::/         22::::::::222          ):::::)
;        A:::::AAAAAAAAA:::::A        H::::::HHHHH::::::H    K::::::K:::::K         (:::::(        1::::l         /:::::/         2:::::22222             ):::::)
;       A:::::::::::::::::::::A       H:::::H     H:::::H    K:::::K K:::::K        (:::::(        1::::l        /:::::/         2:::::2                  ):::::)
;      A:::::AAAAAAAAAAAAA:::::A      H:::::H     H:::::H  KK::::::K  K:::::KKK     (::::::(       1::::l       /:::::/          2:::::2                 )::::::)
;     A:::::A             A:::::A   HH::::::H     H::::::HHK:::::::K   K::::::K     (:::::::((  111::::::111   /:::::/           2:::::2       222222  )):::::::)
;    A:::::A               A:::::A  H:::::::H     H:::::::HK:::::::K    K:::::K      ((:::::::( 1::::::::::1  /:::::/            2::::::2222222:::::2 ):::::::)) 
;   A:::::A                 A:::::A H:::::::H     H:::::::HK:::::::K    K:::::K        ((::::::(1::::::::::1 /:::::/             2::::::::::::::::::2)::::::)    
;  AAAAAAA                   AAAAAAAHHHHHHHHH     HHHHHHHHHKKKKKKKKK    KKKKKKK          (((((( 111111111111///////              22222222222222222222 ))))))     



#NoEnv  ; Recommended for performance and compatibility with furectory.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting di


;=============================================================================1
/*
   This script maps the Ctrl key combined with the number keys on the keyboard
   to their respective Numpad keys. This allows you to use the Ctrl key as a
   modifier to input numbers quickly using the Numpad.

   Usage:
   - Press Ctrl + 1 to input Numpad 1
   - Press Ctrl + 2 to input Numpad 2
   - Press Ctrl + 3 to input Numpad 3
   - ...
   - Press Ctrl + 0 to input Numpad 0
*/

^1::Numpad1
^2::Numpad2
^3::Numpad3
^4::Numpad4
^5::Numpad5
^6::Numpad6
^7::Numpad7
^8::Numpad8
^9::Numpad9
^0::Numpad0

return

;=============================================================================2

/*
   Opens the Documents folder associated with the current user's name.
   Pressing the Shift + ` keys triggers this action.
*/

+`::Run, %A_MyDocuments%


;=============================================================================3
; Default state of lock keys

SetNumlockState, AlwaysOn
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
return

;=============================================================================4
; Suspend AutoHotKey 

#Del::Suspend ; Win + Del
return

;=============================================================================5
;Run process_hacker.exe
;F10::run, procexp64.exe, E:\Apps\ProcessExplorer
; return


;=============================================================================6

; This script remaps the Alt key combined with the H, J, K, and L keys to arrow key movements.
!h::Send {Left}  ; Pressing Alt + H will send the Left arrow key command.
!j::Send {Down}  ; Pressing Alt + J will send the Down arrow key command.
!k::Send {Up}    ; Pressing Alt + K will send the Up arrow key command.
!l::Send {Right} ; Pressing Alt + L will send the Right arrow key command.

; Shift + Alt + J and H used to highlight text in browser. 


;=============================================================================7

; alt+g : open highlighted text in browser and do google search / visit site (if it's url)


; run script as admin (reload if not as admin) 
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
SetTitleMatchMode 2


!g::
MyClip := ClipboardAll
Clipboard = ; empty the clipboard
Send, ^c
ClipWait, 2
if ErrorLevel  ; ClipWait timed out.
{
   return
}
; This code checks if the content of the clipboard matches a file path pattern and if so, it opens the file using Microsoft Edge.
; If the clipboard contains a valid file path (i.e., starts with a non-space character, followed by a dot, and ends with non-space characters),
; the code runs the Microsoft Edge application and passes the file path as a command-line argument to open the file.

if RegExMatch(Clipboard, "^[^ ]*\.[^ ]*$")
{
   Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" %Clipboard%
}
else  
{
   ; Modify some characters that screw up the URL
   ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
   StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
   StringReplace, Clipboard, Clipboard, #, `%23, All
   StringReplace, Clipboard, Clipboard, &, `%26, All
   StringReplace, Clipboard, Clipboard, +, `%2b, All
   StringReplace, Clipboard, Clipboard, ", `%22, All
   Run % "https://www.google.com/search?hl=en&q=" . clipboard ; uriEncode(clipboard)
}
Clipboard := MyClip
return

/*
   This script is designed to handle a hotkey (Alt + D) that performs a specific action based on the contents of the clipboard.
   If the clipboard contains a file path, it will open the file using Microsoft Edge.
   If the clipboard does not contain a file path, it will perform a search on DuckDuckGo using the clipboard contents as the search query.
   The script also handles some character replacements to ensure proper URL encoding.
*/

!d::
MyClip := ClipboardAll
Clipboard = ; empty the clipboard
Send, ^c
ClipWait, 2
if ErrorLevel  ; ClipWait timed out.
{
   return
}
if RegExMatch(Clipboard, "^[^ ]*\.[^ ]*$")
{
   Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" %Clipboard%
}
else  
{
   ; Modify some characters that screw up the URL
   ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
   StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
   StringReplace, Clipboard, Clipboard, #, `%23, All
   StringReplace, Clipboard, Clipboard, &, `%26, All
   StringReplace, Clipboard, Clipboard, +, `%2b, All
   StringReplace, Clipboard, Clipboard, ", `%22, All
   Run % "https://duckduckgo.com/?q=" . clipboard ; uriEncode(clipboard)
}
Clipboard := MyClip
return

; Handy function.
; Copies the selected text to a variable while preserving the clipboard.
GetText(ByRef MyText = "")
{
   SavedClip := ClipboardAll
   Clipboard =
   Send ^c
   ClipWait 0.5
   If ERRORLEVEL
   {
      Clipboard := SavedClip
      MyText =
      Return
   }
   MyText := Clipboard
   Clipboard := SavedClip
   Return MyText
}

; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard =              ; For better compatability
   Sleep 20                 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
   Return
}



