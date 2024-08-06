#NoEnv
#SingleInstance, Force

SetBatchLines, 11
SetMouseDelay, 0

global x:=0, y:=0, title=""

getCurrentWindowSpec()
{
   WinSet, Bottom,,A
   MouseGetPos,x,y,WindowUnderMouse
   WinGetTitle, title, ahk_id %WindowUnderMouse%
   return
}

^!+y::
   getCurrentWindowSpec()
   SetTimer, Check, 1
   gosub, Check
return

Check:
   ; ControlClick 'X' x ' Y' y, title,,Left
   PostClick(x, y, title)
return

PostClick(x,y,win="A") {
   lParam := x & 0xFFFF | (y & 0xFFFF) << 16
   PostMessage, 0x201, , %lParam%, , %win% ;WM_LBUTTONDOWN 
   PostMessage, 0x202, , %lParam%, , %win% ;WM_LBUTTONUP 
}

^!+u::
   SetTimer, Check, Off
return