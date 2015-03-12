Func _GoogleVoice($phoneNumber)
   $googleVoiceURL = "https://www.google.com/voice"
   $oIE = _IECreate($googleVoiceURL)
   IE_ClickDivButtonByClassName($oIE, "jfk-button-primary")
   IE_SetValueInputTextByName($oIE, "gc-quickcall-number", $phoneNumber)
   IE_ClickDivButtonByClassName($oIE, "goog-button-base-content")
   _IEQuit($oIE)
   tooltipSleep(500, "Waiting for Google+ Hangouts - Internet Explorer")
   $oIE = _IEAttach ("Free calls to US and Canadian phone numbers. For other countries, rates may vary. No Emergency Calls. Calls to emergency services are not supported.", "text")
   IE_ClickDivButtonByInnerText($oIE, "Call")
   MsgBox(1, "What should we do?", "Is the call finishd?")
   _IEQuit($oIE)
EndFunc

Func IE_SetValueInputSelectByName($oIE, $elementName, $selectText)
   $Obj = _IEGetObjByName($oIE, $elementName)
   _IEFormElementOptionSelect($Obj, $selectText, 1, "byText")
EndFunc

Func IE_SetValueInputTextByName($oIE, $elementName, $value)
   $Obj = _IEGetObjByName($oIE, $elementName)
   _IEFormElementSetValue($Obj, $value)
EndFunc

Func IE_SetValueInputTextById($oIE, $elementId, $value)
   $oIE.document.getElementById($elementId).value = $value
EndFunc

Func IE_ClickInputButtonByValue($oIE, $value, $pageSleep)
   $oInputs = _IETagNameGetCollection($oIE, "input")
   For $oInput In $oInputs
	  If $oInput.value == $value Then
		 _IEAction($oInput, "click")
		 tooltipSleep($pageSleep, "Waiting for page to load")
		 ExitLoop
	  EndIf
   Next
EndFunc

Func IE_ClickDivButtonByClassName($oIE, $className)
   $windowTitle = _IEPropertyGet($oIE, "title")
   $oLinks = _IETagNameGetCollection($oIE, 'div')
   For $oLink In $oLinks
	  If StringInStr($oLink.className, $className) Then
		 $x = _IEPropertyGet($oLink, 'screenx')
		 $y = _IEPropertyGet($oLink, 'screeny')
		 $pos = ControlGetPos($windowTitle, '', '[CLASS:Internet Explorer_Server; INSTANCE:1]')
		 $posWin = WinGetPos($windowTitle)
		 ControlClick($windowTitle, '', '[CLASS:Internet Explorer_Server; INSTANCE:1]', 'left', 1, $x - ($posWin[0] + $pos[0]), $y - ($posWin[1] + $pos[1]))
	  EndIf
   Next
EndFunc

Func IE_ClickDivButtonByInnerText($oIE, $innerText)
   $windowTitle = _IEPropertyGet($oIE, "title")
   $oLinks = _IETagNameGetCollection($oIE, 'div')
   For $oLink In $oLinks
	  If StringInStr($oLink.innerText, $innerText) Then
		 $x = _IEPropertyGet($oLink, 'screenx')
		 $y = _IEPropertyGet($oLink, 'screeny')
		 $pos = ControlGetPos($windowTitle, '', '[CLASS:Internet Explorer_Server; INSTANCE:1]')
		 $posWin = WinGetPos($windowTitle)
		 ControlClick($windowTitle, '', '[CLASS:Internet Explorer_Server; INSTANCE:1]', 'left', 1, $x - ($posWin[0] + $pos[0]), $y - ($posWin[1] + $pos[1]))
	  EndIf
   Next
EndFunc

Func tooltipSleep($sleep, $desc)
   $count = 0
   Do
	  Sleep(1)
	  ToolTip($desc & ": " & $count, 0, 0)
	  $count = $count + 1
   Until $count >= $sleep
EndFunc