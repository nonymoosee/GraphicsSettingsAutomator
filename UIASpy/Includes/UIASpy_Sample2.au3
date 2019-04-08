#include-once

Func UIASpy_CreateUIAObjects()
	Local Static $aUIAObjects = [ _
		[ "UI Automation objects",  "",                                                                 0xFFFFE0, ""  ], _
		[ "UI Automation object",   "$oUIAutomation on Windows 7, Windows Vista and Windows XP",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation",              "" ], _
		[ "UI Automation2 object",  "$oUIAutomation2 on Windows 8",                                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation2",             "" ], _
		[ "UI Automation3 object",  "$oUIAutomation3 on Windows 8.1",                                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation3",             "" ], _
		[ "UI Automation4 object",  "$oUIAutomation4 on Windows 10, version 1607",                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation4",             "" ], _
		[ "UI Automation5 object",  "$oUIAutomation5 on Windows 10, version 1607",                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation5",             "" ], _
		[ "" ], _
		[ "UI Element objects",     "",                                                                 0xFFFFE0, ""  ], _
		[ "UI Element object",      "$oUIElement on Windows 7, Windows Vista and Windows XP",           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement",       "" ], _
		[ "UI Element2 object",     "$oUIElement2 on Windows 8",                                        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement2",             "" ], _
		[ "UI Element3 object",     "$oUIElement3 on Windows 8.1",                                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement3",             "" ], _
		[ "UI Element4 object",     "$oUIElement4 on Windows 10",                                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement4",             "" ], _
		[ "UI Element5 object",     "$oUIElement5 on Windows 10, version 1703",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement5",             "" ], _
		[ "UI Element6 object",     "$oUIElement6 on Windows 10, version 1703",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement6",             "" ], _
		[ "UI Element7 object",     "$oUIElement7 on Windows 10, version 1703",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement7",             "" ], _
		[ "UI Element8 object",     "$oUIElement8 on Windows 10, version 1803",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelement8",             "" ], _
		[ "" ], _
		[ "Create other objects",   "",                                                                  0xFFFFE0, ""  ], _
		[ "Element array object",   "$oUIElementArray (supports various methods, see Code snippets...)", "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelementarray",  "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1422603" ], _
		[ "TextRange object",       "$oTextRange (supports TextPattern)",                                "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange"      ], _
		[ "TextRange array object", "$oTextRangeArray (supports TextPattern)",                           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrangearray" ] ]

	Local Static $iUIAObjects, $aUIAObjectsIndex[UBound($aUIAObjects)]
	If Not $iUIAObjects Then
		$iUIAObjects = UBound( $aUIAObjects )
		For $i = 0 To $iUIAObjects - 1
			$aUIAObjectsIndex[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUIAObjectsIndex
	$iElemDetails = $iUIAObjects
	$aElemDetails = $aUIAObjects
	UIASpy_FillListView( "Object groups", "Objects", 150 )
EndFunc

Func UIASpy_CreateUIAObjectsCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu1 = $aPopupMenuHandles[1], $hLVItemPopupMenu2 = $aPopupMenuHandles[2], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $iLVItem = 0, $iLVItem = 6, $iLVItem = 7, _   ; Group header
		     $iLVItem = 16, $iLVItem = 17
			Return
		Case $iLVItem = 18                                 ; Group line, no code
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu2 : $hLVItemPopupMenu1
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> "" ; Group line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Automation method code
			UIASpy_GetCreateUIAObjectsCode( $iSel, $aSel )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idOpenExample ; Open Forum example
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][5] )

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageSample()
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, True, False )
EndFunc

Func UIASpy_GetCreateUIAObjectsCode( $iSel, $aSel )
	Local Static $aUIAObjects = [ _
		[ "" ], _
		[ "$sCLSID_CUIAutomation",  "$sIID_IUIAutomation",  "$dtag_IUIAutomation"  ], _
		[ "$sCLSID_CUIAutomation8", "$sIID_IUIAutomation2", "$dtag_IUIAutomation2" ], _
		[ "$sCLSID_CUIAutomation8", "$sIID_IUIAutomation3", "$dtag_IUIAutomation3" ], _
		[ "$sCLSID_CUIAutomation8", "$sIID_IUIAutomation4", "$dtag_IUIAutomation4" ], _
		[ "$sCLSID_CUIAutomation8", "$sIID_IUIAutomation5", "$dtag_IUIAutomation5" ], _
		[ "" ], _
		[ "" ], _
		[ "$sIID_IUIAutomationElement",  "$dtag_IUIAutomationElement"  ], _
		[ "$sIID_IUIAutomationElement2", "$dtag_IUIAutomationElement2" ], _
		[ "$sIID_IUIAutomationElement3", "$dtag_IUIAutomationElement3" ], _
		[ "$sIID_IUIAutomationElement4", "$dtag_IUIAutomationElement4" ], _
		[ "$sIID_IUIAutomationElement5", "$dtag_IUIAutomationElement5" ], _
		[ "$sIID_IUIAutomationElement6", "$dtag_IUIAutomationElement6" ], _
		[ "$sIID_IUIAutomationElement7", "$dtag_IUIAutomationElement7" ], _
		[ "$sIID_IUIAutomationElement8", "$dtag_IUIAutomationElement8" ], _
		[ "" ], _
		[ "" ], _
		[ "" ], _
		[ "$sIID_IUIAutomationTextRange",      "$dtag_IUIAutomationTextRange"      ], _
		[ "$sIID_IUIAutomationTextRangeArray", "$dtag_IUIAutomationTextRangeArray" ] ]

	Local $sObject, $iComment
	Local $bComment1, $bComment2, $bComment3
	For $i = 0 To $iSel - 1
		If Not $aElemDetails[$aElemIndex[$aSel[$i]]][1] Then ContinueLoop
		Switch True
			Case $aSel[$i] < 6
				If Not $bComment1 Then UIASpy_Comment( "UI Automation objects" )
				If $bComment1 Then UIASpy_AddCode( "" )
				$sObject = "$oUIAutomation" & ( $aSel[$i] > 1 ? $aSel[$i] : "" )
				UIASpy_AddCode( "Local " & $sObject & " = ObjCreateInterFace( " & $aUIAObjects[$aSel[$i]][0] & ", " & $aUIAObjects[$aSel[$i]][1] & ", " & $aUIAObjects[$aSel[$i]][2] & " )" )
				If $bErrorCode Then
					UIASpy_AddCode( "If Not IsObj( " & $sObject & " ) Then Return ConsoleWrite( """ & $sObject & " ERR"" & @CRLF )" )
					UIASpy_AddCode( "ConsoleWrite( """ & $sObject & " OK"" & @CRLF )" )
				EndIf
				$bComment1 = 1
			Case $aSel[$i] < 16
				If Not $bComment2 Then UIASpy_Comment( "UI Element objects" )
				If $bComment2 Then UIASpy_AddCode( "" )
				$sObject = "UIElement" & ( $aSel[$i] > 8 ? $aSel[$i] - 7 : "" )
				UIASpy_AddCode( "Local $o" & $sObject & " ; $p" & $sObject & " is a pointer to create the object" )
				UIASpy_AddCode( "$o" & $sObject & " = ObjCreateInterFace( $p" & $sObject & ", " & $aUIAObjects[$aSel[$i]][0] & ", " & $aUIAObjects[$aSel[$i]][1] & " )" )
				If $bErrorCode Then
					UIASpy_AddCode( "If Not IsObj( $o" & $sObject & " ) Then Return ConsoleWrite( ""$o" & $sObject & " ERR"" & @CRLF )" )
					UIASpy_AddCode( "ConsoleWrite( ""$o" & $sObject & " OK"" & @CRLF )" )
				EndIf
				$bComment2 = 1
			Case $aSel[$i] > 18
				If Not $bComment3 Then UIASpy_Comment( "Create other objects" )
				If $bComment3 Then UIASpy_AddCode( "" )
				$sObject = $aElemDetails[$aElemIndex[$aSel[$i]]][1]
				$sObject = StringRight( $sObject, StringLen( $sObject ) - 2 )
				$iComment = StringInStr( $sObject, " (" )
				If $iComment Then $sObject = StringLeft( $sObject, $iComment-1 )
				UIASpy_AddCode( "Local $o" & $sObject & " ; $p" & $sObject & " is a pointer to create the object" )
				UIASpy_AddCode( "$o" & $sObject & " = ObjCreateInterFace( $p" & $sObject & ", " & $aUIAObjects[$aSel[$i]][0] & ", " & $aUIAObjects[$aSel[$i]][1] & " )" )
				If $bErrorCode Then
					UIASpy_AddCode( "If Not IsObj( $o" & $sObject & " ) Then Return ConsoleWrite( ""$o" & $sObject & " ERR"" & @CRLF )" )
					UIASpy_AddCode( "ConsoleWrite( ""$o" & $sObject & " OK"" & @CRLF )" )
				EndIf
				$bComment3 = 1
		EndSwitch
	Next
EndFunc

Func UIASpy_AutomationMethods()
	Local Static $aUIAutomation = [ _
		[ "UI Automation object",  "$oUIAutomation",                                   0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation"                                   ], _
		[ "Compare methods",       "CompareElements(ptr,ptr,long*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareelements"                   ], _
		[ "",                      "CompareRuntimeIds(ptr,ptr,long*)",                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-compareruntimeids"                 ], _
		[ "Condition methods",     "CreateTrueCondition(ptr*)",                        "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createtruecondition",              "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1422603" ], _
		[ "",                      "CreateFalseCondition(ptr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createfalsecondition"              ], _
		[ "",                      "CreatePropertyCondition(int,variant,ptr*)",        "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertycondition",          "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
		[ "",                      "CreatePropertyConditionEx(int,variant,long,ptr*)", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertyconditionex"         ], _
		[ "",                      "CreateAndConditionFromArray(ptr,ptr*)",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromarray"       ], _
		[ "",                      "CreateAndConditionFromNativeArray(ptr,int,ptr*)",  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandconditionfromnativearray" ], _
		[ "",                      "CreateOrConditionFromArray(ptr,ptr*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromarray"        ], _
		[ "",                      "CreateOrConditionFromNativeArray(ptr,int,ptr*)",   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorconditionfromnativearray"  ], _
		[ "",                      "CreateNotCondition(ptr,ptr*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createnotcondition"                ], _
		[ "Element methods",       "ElementFromHandle(hwnd,ptr*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromhandle"                 ], _
		[ "",                      "ElementFromPoint(struct,ptr*)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfrompoint"                  ], _
		[ "",                      "ElementFromIAccessible(idispatch,int,ptr*)",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-elementfromiaccessible"            ], _
		[ "",                      "GetFocusedElement(ptr*)",                          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getfocusedelement"                 ], _
		[ "",                      "GetRootElement(ptr*)",                             "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-getrootelement",                   "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
		[ "" ], _
		[ "UI Automation2 object", "$oUIAutomation2",                                  0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomation2"                                  ], _
		[ "",                      "get_AutoSetFocus(bool*)",                          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_autosetfocus"                 ], _
		[ "",                      "put_AutoSetFocus(bool)",                           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_autosetfocus"                 ], _
		[ "",                      "get_ConnectionTimeout(dword*)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_connectiontimeout"            ], _
		[ "",                      "put_ConnectionTimeout(dword)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_connectiontimeout"            ], _
		[ "",                      "get_TransactionTimeout(dword*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-get_transactiontimeout"           ], _
		[ "",                      "put_TransactionTimeout(dword)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation2-put_transactiontimeout"           ] ]

	Local Static $iUIAutomation, $aUIAutomationIndex[UBound($aUIAutomation)]
	If Not $iUIAutomation Then
		$iUIAutomation = UBound( $aUIAutomation )
		For $i = 0 To $iUIAutomation - 1
			$aUIAutomationIndex[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUIAutomationIndex
	$iElemDetails = $iUIAutomation
	$aElemDetails = $aUIAutomation
	UIASpy_FillListView( "Objects/groups", "Methods", 200 )
EndFunc

Func UIASpy_AutomationMethodsCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $iLVItem = 0, $iLVItem = 18                   ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> "" ; Group line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Automation method code
			UIASpy_GetAutomationMethodCode( $iSel, $aSel )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idOpenExample ; Open Forum example
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][5] )

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageSample()
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, True, False )
EndFunc

Func UIASpy_GetAutomationMethodCode( $iSel, $aSel )
	Local $sObject, $bComment1 = 0, $bComment2 = 0
	For $i = 0 To $iSel - 1
		Switch True
			Case $aSel[$i] > 0 And $aSel[$i] < 17
				$sObject = "$oUIAutomation."
				If Not $bComment1 Then
					UIASpy_Comment( "$oUIAutomation methods" )
					$bComment1 = 1
				EndIf
			Case $aSel[$i] > 18 And $aSel[$i] < 25
				$sObject = "$oUIAutomation2."
				If Not $bComment2 Then
					UIASpy_Comment( "$oUIAutomation2 methods" )
					$bComment2 = 1
				EndIf
			Case Else
				ContinueLoop
		EndSwitch
		UIASpy_AddCode( $sObject & $aElemDetails[$aElemIndex[$aSel[$i]]][1] )
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & StringRegExp( $sObject & $aElemDetails[$aElemIndex[$aSel[$i]]][1], "^(.*)\(.*\)$", 1 )[0] & "()" & """ & @CRLF )" )
	Next
EndFunc

Func UIASpy_ElementMethods()
	Local Static $aUIElement = [ _
		[ "UI Element object",           "$oUIElement",                                  0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement"                                      ], _
		[ "Current properties",          "CurrentAcceleratorKey(bstr*)",                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationelement-get_currentacceleratorkey"            ], _
		[ "",                            "CurrentAccessKey(bstr*)",                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentaccesskey"                 ], _
		[ "",                            "CurrentAriaProperties(bstr*)",                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariaproperties"            ], _
		[ "",                            "CurrentAriaRole(bstr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentariarole"                  ], _
		[ "",                            "CurrentAutomationId(bstr*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentautomationid"              ], _
		[ "",                            "CurrentBoundingRectangle(struct*)",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentboundingrectangle"         ], _
		[ "",                            "CurrentClassName(bstr*)",                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentclassname"                 ], _
		[ "",                            "CurrentControllerFor(ptr*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontrollerfor"             ], _
		[ "",                            "CurrentControlType(int*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentcontroltype"               ], _
		[ "",                            "CurrentCulture(int*)",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentculture"                   ], _
		[ "",                            "CurrentDescribedBy(ptr*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentdescribedby"               ], _
		[ "",                            "CurrentFlowsTo(ptr*)",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentflowsto"                   ], _
		[ "",                            "CurrentFrameworkId(bstr*)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentframeworkid"               ], _
		[ "",                            "CurrentHelpText(bstr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthelptext"                  ], _
		[ "",                            "CurrentItemStatus(bstr*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemstatus"                ], _
		[ "",                            "CurrentItemType(bstr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentitemtype"                  ], _
		[ "",                            "CurrentLabeledBy(ptr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlabeledby"                 ], _
		[ "",                            "CurrentLocalizedControlType(bstr*)",           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentlocalizedcontroltype"      ], _
		[ "",                            "CurrentName(bstr*)",                           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentname"                      ], _
		[ "",                            "CurrentNativeWindowHandle(hwnd*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentnativewindowhandle"        ], _
		[ "",                            "CurrentOrientation(long*)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentorientation"               ], _
		[ "",                            "CurrentProcessId(int*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentprocessid"                 ], _
		[ "",                            "CurrentProviderDescription(bstr*)",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentproviderdescription"       ], _
		[ "Current has/is properties",   "CurrentHasKeyboardFocus(long*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currenthaskeyboardfocus"          ], _
		[ "",                            "CurrentIsContentElement(long*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontentelement"          ], _
		[ "",                            "CurrentIsControlElement(long*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiscontrolelement"          ], _
		[ "",                            "CurrentIsDataValidForForm(long*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisdatavalidforform"        ], _
		[ "",                            "CurrentIsEnabled(long*)",                      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisenabled"                 ], _
		[ "",                            "CurrentIsKeyboardFocusable(long*)",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentiskeyboardfocusable"       ], _
		[ "",                            "CurrentIsOffscreen(long*)",                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisoffscreen"               ], _
		[ "",                            "CurrentIsPassword(long*)",                     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentispassword"                ], _
		[ "",                            "CurrentIsRequiredForForm(long*)",              "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-get_currentisrequiredforform"         ], _
		[ "Get properties and patterns", "GetCurrentPropertyValue(int,variant*)",        "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalue",             "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
		[ "",                            "GetCurrentPropertyValueEx(int,long,variant*)", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpropertyvalueex"            ], _
		[ "",                            "GetCurrentPattern(int,ptr*)",                  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpattern"                    ], _
		[ "",                            "GetCurrentPatternAs(int,none,none*)",          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-getcurrentpatternas"                  ], _
		[ "Other get properties",        "GetClickablePoint(struct*,long*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationelement-getclickablepoint"                    ], _
		[ "",                            "GetRuntimeId(ptr*)",                           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationelement-getruntimeid"                         ], _
		[ "Find methods",                "FindAll(long,ptr,ptr*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findall"                              ], _
		[ "",                            "FindFirst(long,ptr,ptr*)",                     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-findfirst",                           "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
		[ "SetFocus method",             "SetFocus()",                                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement-setfocus"                             ], _
		[ "" ], _
		[ "UI Element2 object",          "$oUIElement2",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement2"                                     ], _
		[ "",                            "get_CurrentOptimizeForVisualContent(bool*)",   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentoptimizeforvisualcontent" ], _
		[ "",                            "get_CurrentLiveSetting(long*)",                "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentlivesetting"              ], _
		[ "",                            "get_CurrentFlowsFrom(ptr*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement2-get_currentflowsfrom"                ], _
		[ "" ], _
		[ "UI Element3 object",          "$oUIElement3",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement3"                                     ], _
		[ "",                            "ShowContextMenu()",                            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-showcontextmenu"                     ], _
		[ "",                            "get_CurrentIsPeripheral(bool*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement3-get_currentisperipheral"             ], _
		[ "" ], _
		[ "UI Element4 object",          "$oUIElement4",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement4"                                     ], _
		[ "",                            "get_CurrentPositionInSet(int*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentpositioninset"            ], _
		[ "",                            "get_CurrentSizeOfSet(int*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentsizeofset"                ], _
		[ "",                            "get_CurrentLevel(int*)",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentlevel"                    ], _
		[ "",                            "get_CurrentAnnotationTypes(ptr*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationtypes"          ], _
		[ "",                            "get_CurrentAnnotationObjects(ptr*)",           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement4-get_currentannotationobjects"        ], _
		[ "" ], _
		[ "UI Element5 object",          "$oUIElement5",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement5"                                     ], _
		[ "",                            "get_CurrentLandmarkType(long*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlandmarktype"             ], _
		[ "",                            "get_CurrentLocalizedLandmarkType(bstr*)",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement5-get_currentlocalizedlandmarktype"    ], _
		[ "" ], _
		[ "UI Element6 object",          "$oUIElement6",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement6"                                     ], _
		[ "",                            "get_CurrentFullDescription(bstr*)",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement6-get_currentfulldescription"          ], _
		[ "" ], _
		[ "UI Element7 object",          "$oUIElement7",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement7"                                     ], _
		[ "",                            "FindFirstWithOptions(long,ptr,long,ptr,ptr*)", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findfirstwithoptions"                ], _
		[ "",                            "FindAllWithOptions(long,ptr,long,ptr,ptr*)",   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement7-findallwithoptions"                  ], _
		[ "" ], _
		[ "UI Element8 object",          "$oUIElement8",                                 0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement8"                                     ], _
		[ "",                            "get_CurrentHeadingLevel(long*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationelement8-get_currentheadinglevel"             ] ]

	Local Static $iUIElement, $aUIElementIndex[UBound($aUIElement)]
	If Not $iUIElement Then
		$iUIElement = UBound( $aUIElement )
		For $i = 0 To $iUIElement - 1
			$aUIElementIndex[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUIElementIndex
	$iElemDetails = $iUIElement
	$aElemDetails = $aUIElement
	UIASpy_FillListView( "Objects/groups", "Methods", 200 )
EndFunc

Func UIASpy_ElementMethodsCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $iLVItem = 0, $iLVItem = 43, $iLVItem = 48, _ ; Group header with Microsoft docu
		     $iLVItem = 52, $iLVItem = 59, $iLVItem = 63, _
		     $iLVItem = 66, $iLVItem = 70
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> "" ; Group line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Element method code
			UIASpy_GetElementMethodCode( $iSel, $aSel )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idOpenExample ; Open Forum example
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][5] )

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageSample()
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, True, False )
EndFunc

Func UIASpy_GetElementMethodCode( $iSel, $aSel )
	; Get window/control
	Local $sElement = UIASpy_GetLastWinOrCtrl()
	Local $sObject, $bComment1 = 0, $bComment2 = 0, $bComment3 = 0
	Local $bComment4 = 0, $bComment5 = 0, $bComment6 = 0, $bComment7 = 0, $bComment8 = 0
	For $i = 0 To $iSel - 1
		Switch True
			Case $aSel[$i] > 0 And $aSel[$i] < 42
				$sObject = $sElement & "."
				If Not $bComment1 Then
					UIASpy_Comment( "$oUIElement methods" )
					$bComment1 = 1
				EndIf
			Case $aSel[$i] > 43 And $aSel[$i] < 47
				$sObject = $sElement & "2."
				If Not $bComment2 Then
					UIASpy_Comment( "$oUIElement2 methods" )
					$bComment2 = 1
				EndIf
			Case $aSel[$i] > 48 And $aSel[$i] < 51
				$sObject = $sElement & "3."
				If Not $bComment3 Then
					UIASpy_Comment( "$oUIElement3 methods" )
					$bComment3 = 1
				EndIf
			Case $aSel[$i] > 52 And $aSel[$i] < 58
				$sObject = $sElement & "4."
				If Not $bComment4 Then
					UIASpy_Comment( "$oUIElement4 methods" )
					$bComment4 = 1
				EndIf
			Case $aSel[$i] > 59 And $aSel[$i] < 62
				$sObject = $sElement & "5."
				If Not $bComment5 Then
					UIASpy_Comment( "$oUIElement5 methods" )
					$bComment5 = 1
				EndIf
			Case $aSel[$i] > 63 And $aSel[$i] < 65
				$sObject = $sElement & "6."
				If Not $bComment6 Then
					UIASpy_Comment( "$oUIElement6 methods" )
					$bComment6 = 1
				EndIf
			Case $aSel[$i] > 66 And $aSel[$i] < 69
				$sObject = $sElement & "7."
				If Not $bComment7 Then
					UIASpy_Comment( "$oUIElement7 methods" )
					$bComment7 = 1
				EndIf
			Case $aSel[$i] > 70 And $aSel[$i] < 72
				$sObject = $sElement & "8."
				If Not $bComment8 Then
					UIASpy_Comment( "$oUIElement8 methods" )
					$bComment8 = 1
				EndIf
			Case Else
				ContinueLoop
		EndSwitch
		UIASpy_AddCode( $sObject & $aElemDetails[$aElemIndex[$aSel[$i]]][1] )
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & StringRegExp( $sObject & $aElemDetails[$aElemIndex[$aSel[$i]]][1], "^(.*)\(.*\)$", 1 )[0] & "()" & """ & @CRLF )" )
	Next
EndFunc

Func UIASpy_OtherObjMethods()
	Local Static $aUIOther = [ _
		[ "TextRange",            "$oTextRange (supports TextPattern)",          0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrange"                            ], _
		[ "",                     "Clone(ptr*)",                                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-clone"                      ], _
		[ "",                     "Compare(ptr,long*)",                          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compare"                    ], _
		[ "",                     "CompareEndpoints(long,ptr,long,int*)",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-compareendpoints"           ], _
		[ "",                     "ExpandToEnclosingUnit(long)",                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-expandtoenclosingunit"      ], _
		[ "",                     "FindAttribute(int,variant,long,ptr*)",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findattribute"              ], _
		[ "",                     "FindText(bstr,long,long,ptr*)",               "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-findtext"                   ], _
		[ "",                     "GetAttributeValue(int,variant*)",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getattributevalue"          ], _
		[ "",                     "GetBoundingRectangles(ptr*)",                 "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getboundingrectangles"      ], _
		[ "",                     "GetEnclosingElement(ptr*)",                   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getenclosingelement"        ], _
		[ "",                     "GetText(int,bstr*)",                          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-gettext"                    ], _
		[ "",                     "Move(long,int,int*)",                         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-move"                       ], _
		[ "",                     "MoveEndpointByUnit(long,long,int,int*)",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyunit"         ], _
		[ "",                     "MoveEndpointByRange(long,ptr,long)",          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-moveendpointbyrange"        ], _
		[ "",                     "Select()",                                    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-select"                     ], _
		[ "",                     "AddToSelection()",                            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-addtoselection"             ], _
		[ "",                     "RemoveFromSelection()",                       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-removefromselection"        ], _
		[ "",                     "ScrollIntoView(long)",                        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-scrollintoview"             ], _
		[ "",                     "GetChildren(ptr*)",                           "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrange-getchildren"                 ], _
		[ "",                     "" ], _
		[ "TextRange array",      "$oTextRangeArray (supports TextPattern)",     0xFFFFE0, "", "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextrangearray"                       ], _
		[ "",                     "Length(int*)",                                "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-get_length"            ], _
		[ "",                     "GetElement(int,ptr*)",                        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextrangearray-getelement"            ] ]

	Local Static $iUIOther, $aUIOtherIndex[UBound($aUIOther)]
	If Not $iUIOther Then
		$iUIOther = UBound( $aUIOther )
		For $i = 0 To $iUIOther - 1
			$aUIOtherIndex[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUIOtherIndex
	$iElemDetails = $iUIOther
	$aElemDetails = $aUIOther
	UIASpy_FillListView( "Objects/groups", "Methods", 200 )
EndFunc

Func UIASpy_OtherObjMethodsCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $iLVItem = 0, $iLVItem = 4, $iLVItem = 24, _  ; Group header with Microsoft docu
		     $iLVItem = 28
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> "" ; Group line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
		Case Else                                          ; Empty line
			Return
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Automation method code
			UIASpy_GetOtherMethodCode( $iSel, $aSel )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idOpenExample ; Open Forum example
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][5] )

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageSample()
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, True, False )
EndFunc

Func UIASpy_GetOtherMethodCode( $iSel, $aSel )
	Local $sObject, $sObjectName, $sObjectPrev, $iComment
	For $i = 0 To $iSel - 1
		If StringRight( $aElemDetails[$aElemIndex[$aSel[$i]]][1], 1 ) <> ")" Then ContinueLoop
		$sObject = $aElemDetails[$aElemIndex[$aSel[$i]]][0]
		If Not $sObject Then
			For $j = $aSel[$i] To 0 Step -1
				If $aElemDetails[$aElemIndex[$j]][0] Then ExitLoop
			Next
			$sObjectName = $aElemDetails[$aElemIndex[$j]][0]
			$sObject = $aElemDetails[$aElemIndex[$j]][1]
			$iComment = StringInStr( $sObject, " (" )
			If $iComment Then $sObject = StringLeft( $sObject, $iComment-1 )
		EndIf
		If Not $sObjectPrev Then
			$sObjectPrev = $sObject
			UIASpy_Comment( $sObjectName & " Object Methods" )
		EndIf
		If $sObjectPrev <> $sObject Then
			$sObjectPrev = $sObject
			UIASpy_Comment( $sObjectName & " Object Methods" )
		EndIf
		UIASpy_AddCode( $sObject & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1], $iCode ? @CRLF & $sObject & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1] : $sObject & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1] )
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & StringRegExp( $sObject & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1], "^(.*)\(.*\)$", 1 )[0] & "()" & """ & @CRLF )" )
	Next
EndFunc
