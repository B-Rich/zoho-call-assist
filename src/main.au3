#include <IE.au3>
#include <String.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include "func.au3"

_Call()

Func _PlaceCall()
   $oIE = _IEAttach ("", "instance", 1)
   $oDocHTML = _IEDocReadHTML($oIE)
   $strings = _StringBetween($oDocHTML, '<span class="phoneRtl" id="subvalue1_Phone">', '</span>')
   If Not @error Then
	  $phone = $strings[0]
	  _GoogleVoice($phone)
   Else
	  MsgBox(1, "Error", "No phone number found")
   EndIf
EndFunc

Func _Call()
   ; Create a GUI with various controls.
   Local $hGUI = GUICreate("Zoho Call Assist", 225, 60, -1, -1, "", $WS_EX_TOPMOST)
   Local $idCall = GUICtrlCreateButton("Call", 20, 3, 85, 25)
   Local $idClose = GUICtrlCreateButton("Close", 120, 3, 85, 25)

   GUISetState(@SW_SHOW, $hGUI)

   While 1
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE, $idClose
			ExitLoop
		 Case $idCall
			_PlaceCall()
	  EndSwitch
   WEnd

   GUIDelete($hGUI)
EndFunc