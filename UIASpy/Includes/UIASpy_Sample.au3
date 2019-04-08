#include-once

Global $aCode[1000][2], $aCodeIdx[1000], $iCode = 0, $sCode = "", $iCon = 0, $sLastCon = "", $bIgnoreCase = False, $bErrorCode = True, $bPatternError = False, $oRegVars = ObjCreate( "Scripting.Dictionary" )

Global $aUndo[100], $iUndo = 0, $aRedo[100], $iRedo = 0, $aUndoRedo[100][6] = [ [ $iCode, $sCode, $iCon, $sLastCon ] ], $iUndoRedo = 1

Global $sCLSIDCUIAutomationName, $sIIDIUIAutomationName, $dtagIUIAutomationName
Global $sIIDIUIAutomationElementName, $dtagIUIAutomationElementName
UIASpy_SampleMode()

#include "UIASpy_Sample2.au3"

Func UIASpy_SampleMode()
	Switch True
		Case $bW10
			$sCLSIDCUIAutomationName = "$sCLSID_CUIAutomation8"
			$sIIDIUIAutomationName = "$sIID_IUIAutomation5"
			$dtagIUIAutomationName = "$dtag_IUIAutomation5"
			$sIIDIUIAutomationElementName = "$sIID_IUIAutomationElement8"
			$dtagIUIAutomationElementName = "$dtag_IUIAutomationElement8"
		Case $bW81
			$sCLSIDCUIAutomationName = "$sCLSID_CUIAutomation8"
			$sIIDIUIAutomationName = "$sIID_IUIAutomation3"
			$dtagIUIAutomationName = "$dtag_IUIAutomation3"
			$sIIDIUIAutomationElementName = "$sIID_IUIAutomationElement3"
			$dtagIUIAutomationElementName = "$dtag_IUIAutomationElement3"
		Case $bW8
			$sCLSIDCUIAutomationName = "$sCLSID_CUIAutomation8"
			$sIIDIUIAutomationName = "$sIID_IUIAutomation2"
			$dtagIUIAutomationName = "$dtag_IUIAutomation2"
			$sIIDIUIAutomationElementName = "$sIID_IUIAutomationElement2"
			$dtagIUIAutomationElementName = "$dtag_IUIAutomationElement2"
		Case Else
			$sCLSIDCUIAutomationName = "$sCLSID_CUIAutomation"
			$sIIDIUIAutomationName = "$sIID_IUIAutomation"
			$dtagIUIAutomationName = "$dtag_IUIAutomation"
			$sIIDIUIAutomationElementName = "$sIID_IUIAutomationElement"
			$dtagIUIAutomationElementName = "$dtag_IUIAutomationElement"
	EndSwitch
EndFunc

; Detail info ListView page
Func UIASpy_LVRightClick( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu0 = $aPopupMenuHandles[0], $hLVItemPopupMenu1 = $aPopupMenuHandles[1], $hLVItemPopupMenu2 = $aPopupMenuHandles[2], $hLVItemPopupMenu3 = $aPopupMenuHandles[3], $hLVItemPopupMenu4 = $aPopupMenuHandles[4], $hLVItemPopupMenu5 = $aPopupMenuHandles[5], _
	             $hLVItemPopupMenu10 = $aPopupMenuHandles[10], $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu13 = $aPopupMenuHandles[13], $hLVItemPopupMenu14 = $aPopupMenuHandles[14], $hLVItemPopupMenu15 = $aPopupMenuHandles[15]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7], $idTopicVisible = $aPopupMenuIds[8], $idThreadDocu = $aPopupMenuIds[9], $idHelpPage = $aPopupMenuIds[10]

	If Not ( $aElemDetails[$aElemIndex[$iLVItem]][0] Or $aElemDetails[$aElemIndex[$iLVItem]][1] ) Then Return ; Blank line

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch $aElemDetails[$aElemIndex[0]][0]
		Case "0"                                    ; Tree, Code
			$hLVItemPopupMenu = $hLVItemPopupMenu0
		Case "Detect element", "Left pane", _       ; Use of UIASpy
		     "Right pane", "Sample code"
			Switch True
				Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xE8E8E8 And _ ; Gray
				     ( $iLVItem < 4 Or $iLVItem > 13 ) And _
				     ( StringInStr( $aElemDetails[$aElemIndex[$iLVItem]][4], "Right pane" ) = 1 Or _ ; Help
				       StringInStr( $aElemDetails[$aElemIndex[$iLVItem]][4], "Sample code" ) = 1 )   ; Help
					$hLVItemPopupMenu = $hLVItemPopupMenu5
				Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xE8E8E8 And _ ; Gray
				     ( $iLVItem < 4 Or $iLVItem > 13 )                        ; Docu
					$hLVItemPopupMenu = $hLVItemPopupMenu4
				Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xE8E8E8       ; Gray
					$hLVItemPopupMenu = $hLVItemPopupMenu3
				Case Else
					$hLVItemPopupMenu = $hLVItemPopupMenu0
			EndSwitch
		Case "UI Automation Controls (elements)", _ ; Help pages
		     "UI Automation Patterns (actions)", _
		     "UI Automation object", _
		     "UI Element object"
			Switch True
				Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 Or _  ; Cyan
				     $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 Or _  ; Red
				     $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xE8E8E8       ; Gray
					$hLVItemPopupMenu = $hLVItemPopupMenu1
				Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF       ; Yellow
					$hLVItemPopupMenu = $hLVItemPopupMenu2
				Case Else
					$hLVItemPopupMenu = $hLVItemPopupMenu0
			EndSwitch
	EndSwitch

	If Not $hLVItemPopupMenu Then
		; Detail info page
		; Calculate start index for ListView groups
		Local Static $iTVSelIdx0 = -1, $bElemDetailsAll0, $aGroups[13], $iGroups
		If $iTVSelIdx0 <> $iTVSelIdx Or $bElemDetailsAll0 <> $bElemDetailsAll Then
			Local $aElemIndexes = ($aElems[$iTVSelIdx][7])[1], $iStart = 2, $iIndex
			$iGroups = 0
			For $i = 0 To 7
				$iIndex = $aElemIndexes[$i][1] - 1 * ( $i = 0 )
				$aGroups[$iGroups] = $iStart
				$iStart += $iIndex
				$iGroups += 1
				If $bElemDetailsAll And $i > 2 And $i < 7 Then
					$iIndex = $aElemIndexes[$i][3]
					$aGroups[$iGroups] = $iStart
					$iStart += $iIndex
					$iGroups += 1
				EndIf
			Next
			$aGroups[$iGroups] = $iStart
			$iGroups += 1
			$iTVSelIdx0 = $iTVSelIdx
			$bElemDetailsAll0 = $bElemDetailsAll
		EndIf

		; Calculate group number for right clicked ListView item
		For $i = 0 To $iGroups - 1
			If $aGroups[$i] > $iLVItem Then ExitLoop
		Next
		Local $iGroup = $i - 1

		; Index within the group for right clicked ListView item
		Local $iGrpIdx = $iGroup <> -1 ? $iLVItem - $aGroups[$iGroup] : -1

		; Detail info page
		; Determine Popup Menu
		Switch True
			Case $iGroup = -1 And $iGrpIdx = -1                     ; Top group
				$hLVItemPopupMenu = $hLVItemPopupMenu11
			Case $iGroups - $iGroup = 2                             ; Bottom groups
				$hLVItemPopupMenu = $hLVItemPopupMenu10
			Case $iGrpIdx = 0                                       ; Group header with Microsoft docu
				$hLVItemPopupMenu = $hLVItemPopupMenu11
			Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xE8E8E8 ; Subgroup header with Microsoft docu
				$hLVItemPopupMenu = _ ; Exclude gray rows caused by alternating group colors
				  ( $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0] = "Control Pattern Properties" Or _
				    $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0] = "Control Pattern Properties (unavailable patterns)" ) _
				  ? $hLVItemPopupMenu13 : $hLVItemPopupMenu11
			Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> ""      ; Group line with Microsoft docu
				$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
				                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
				_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
				Switch $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0]
					Case "Control Pattern Methods", "Control Pattern Methods (unavailable patterns)"
						_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
				EndSwitch
			Case Else                                               ; Group line without Microsoft docu
				$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
				                  ? $hLVItemPopupMenu15 : $hLVItemPopupMenu13
				_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
		EndSwitch
	EndIf

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items within the group
			Local $aSel = _GUICtrlListView_GetSelectedIndices( $idLV, True ), $iSelGrp = 0
			Switch $iGroup
				Case 0, _ ; "Element Properties (identification)" or "Element Properties (session unique)"
						 1    ; If right click in ListView group 0/1 then include selected items in both groups
					Local $nSel0 = $aSel[0]
					; ListView group 0
					For $i = 1 To $nSel0
						If $aSel[$i] <= $aGroups[0] Then ContinueLoop
						If $aSel[$i] < $aGroups[0+1] - 1 Then
							$aSel[$iSelGrp] = $aSel[$i]
							$iSelGrp += 1
							ContinueLoop
						EndIf
						ExitLoop
					Next
					; ListView group 1
					For $i = $i To $nSel0
						If $aSel[$i] <= $aGroups[1] Then ContinueLoop
						If $aSel[$i] < $aGroups[1+1] - 1 Then
							$aSel[$iSelGrp] = $aSel[$i]
							$iSelGrp += 1
							ContinueLoop
						EndIf
						ExitLoop
					Next
				Case Else
					For $i = 1 To $aSel[0]
						If $aSel[$i] <= $aGroups[$iGroup] Then ContinueLoop
						If $aSel[$i] < $aGroups[$iGroup+1] - 1 Then
							$aSel[$iSelGrp] = $aSel[$i]
							$iSelGrp += 1
							ContinueLoop
						EndIf
						ExitLoop
					Next
			EndSwitch
			Local $iSel = $iSelGrp

			Local $iControl, $sElement

			; Manage different listView groups (separated by cyan and red group headers)
			Switch $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0]
				Case "Element Properties (identification)", "Element Properties (session unique)"
					; --- Find window or control based on a Find-condition ---
					UIASpy_Comment( "Find window/control" )
					; --- Create Find-condition ---
					Local $sAndCond
					UIASpy_CreateWinCtrlCode( $aSel, $iSel, $sAndCond )
					; --- Find window or control ---
					; Item level, _GUICtrlTreeView_Level()
					Local $hItem = $aElems[$iTVSelIdx][4], $hParItem, $iItemLevel = 0, $sParent, $sWindowPane, $sControl
					$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
					While $hParItem And $iItemLevel < 3
						$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
						$iItemLevel += 1
					WEnd
					; Parent window for current window/control
					$sParent = "$o" & ( $iItemLevel = 1 ? "Desktop" : $oRegVars.Exists( "LastWindowPane" ) ? $oRegVars( "LastWindowPane" ) : "Parent" )
					; Current window/control type
					$aElems[$iTVSelIdx][1].GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
					$sElement = $aUIASpy_Controls[$iControl-50000][0]
					$sWindowPane = $sElement = "Window" Or $sElement = "Pane" ? $sElement : ""
					$sControl = $sElement <> "Window" And $sElement <> "Pane" ? $sElement : ""
					$oRegVars( $sElement ) += 1
					$sElement &= $oRegVars( $sElement )
					If $sWindowPane Then $oRegVars( "LastWindowPane" ) = $sElement
					If $sControl Then $oRegVars( "LastControl" ) = $sElement
					; Find window or control
					UIASpy_AddCode( "" )
					UIASpy_AddCode( "Local $p" & $sElement & ", $o" & $sElement )
					UIASpy_AddCode( $sParent & ".FindFirst( $TreeScope_Descendants, " & $sAndCond & ", " & "$p" & $sElement & " )" )
					UIASpy_AddCode( "$o" & $sElement & " = ObjCreateInterface( $p" & $sElement & ", " & $sIIDIUIAutomationElementName & ", " & $dtagIUIAutomationElementName & " )" )
					If $bErrorCode Then
						$sElement = "$o" & $sElement
						UIASpy_AddCode( "If Not IsObj( " & $sElement & " ) Then Return ConsoleWrite( """ & $sElement & " ERR"" & @CRLF )" )
						UIASpy_AddCode( "ConsoleWrite( """ & $sElement & " OK"" & @CRLF )" )
					EndIf

				Case "Element Properties (information)", "Element Properties (has/is info)", "Element Properties (default value)"
					UIASpy_Comment( $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0] )
					; Get window/control
					$sElement = UIASpy_GetLastWinOrCtrl()
					; Create property code
					For $i = 0 To $iSel - 1
						UIASpy_GetPropertyCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
					Next

				Case "Control Patterns (element actions)", "Control Patterns (unavailable)"
					; Get window/control
					$sElement = UIASpy_GetLastWinOrCtrl()
					; Create pattern code
					For $i = 0 To $iSel - 1
						UIASpy_GetPatternCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
					Next

				Case "Control Pattern Properties", "Control Pattern Properties (unavailable patterns)"
					UIASpy_Comment( $aElemDetails[$aElemIndex[$aGroups[$iGroup]]][0] )
					; Get window/control
					$sElement = UIASpy_GetLastWinOrCtrl()
					; Create property code
					For $i = 0 To $iSel - 1
						UIASpy_GetPatternPropCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
					Next

				Case "Control Pattern Methods", "Control Pattern Methods (unavailable patterns)"
					UIASpy_GetPatternMethodCode( $iSel, $aSel )
			EndSwitch

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			If $sCode Then UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idThreadDocu ; Open AutoIt thread
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idOpenExample ; Open Forum example
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][5] )

		Case $idHelpPage ; Open help page
			Local $aSplit = StringSplit( $aElemDetails[$aElemIndex[$iLVItem]][4], "|", 2 ) ; 2 = $STR_NOCOUNT
			Switch $aSplit[0]
				Case "Right pane"
					UIASpy_UsageRight( Int( $aSplit[1] ) )
				Case "Sample code"
					UIASpy_UsageSample( Int( $aSplit[1] ) )
			EndSwitch

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageRight()

		Case $idTopicVisible ; Make topic visible
			;_GUICtrlListView_BeginUpdate( $idLV )
			GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
			GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iElemDetails-1, 0 )
			GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $aElemDetails[$aElemIndex[$iLVItem]][4], 0 )
			;_GUICtrlListView_EnsureVisible( $idLV, 0 )
			GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
			;_GUICtrlListView_EndUpdate( $idLV )
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, True, False )
EndFunc

; ListView right click Popup Menu
Func UIASpy_CreatePopupMenu()
	Local Static $aPopupMenus, $bCreatePopupMenu = False
	If $bCreatePopupMenu Then Return $aPopupMenus

	; Create ListView right click Popup Menu
	Local $hLVItemPopupMenu0 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu1 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu2 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu3 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu4 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu5 = _GUICtrlMenu_CreatePopup()
	Local $hLVItemPopupMenu10 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu11 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu12 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu13 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu14 = _GUICtrlMenu_CreatePopup(), $hLVItemPopupMenu15 = _GUICtrlMenu_CreatePopup()
	Local $idOpenMsDocu = 200100, $idSampleCode = 200101, $idCopyToCode = 200102, $idClearCode = 200103, $idCopyAllItems = 200104, $idCopySelItems = 200105, $idShowHelp = 200106, $idOpenExample = 200107, $idTopicVisible = 200108, $idThreadDocu = 200109, $idHelpPage = 200110

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu0, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu0, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu1, "Open Microsoft docu", $idOpenMsDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu1, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu1, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu1, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu2, "Open Microsoft docu", $idOpenMsDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu2, "Open Forum example", $idOpenExample )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu2, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu2, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu2, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu3, "Make topic visible", $idTopicVisible )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu3, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu3, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu3, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu4, "Open AutoIt thread", $idThreadDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu4, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu4, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu4, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu5, "Open help page", $idHelpPage )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu5, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu5, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu5, "Copy all items", $idCopyAllItems )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu10, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu10, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu10, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu10, "Show help page", $idShowHelp )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "Open Microsoft docu", $idOpenMsDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu11, "Show help page", $idShowHelp )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Create sample code", $idSampleCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Copy to sample code", $idCopyToCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Clear sample code", $idClearCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Open Microsoft docu", $idOpenMsDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu12, "Show help page", $idShowHelp )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Create sample code", $idSampleCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Copy to sample code", $idCopyToCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Clear sample code", $idClearCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu13, "Show help page", $idShowHelp )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Create sample code", $idSampleCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Copy to sample code", $idCopyToCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Clear sample code", $idClearCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Open Microsoft docu", $idOpenMsDocu )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Open Forum example", $idOpenExample )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu14, "Show help page", $idShowHelp )

	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Create sample code", $idSampleCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Copy to sample code", $idCopyToCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Clear sample code", $idClearCode )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Open Forum example", $idOpenExample )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Copy selected items", $idCopySelItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Copy all items", $idCopyAllItems )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hLVItemPopupMenu15, "Show help page", $idShowHelp )

	Local $aPopupMenuHandles = [ $hLVItemPopupMenu0, $hLVItemPopupMenu1, $hLVItemPopupMenu2, $hLVItemPopupMenu3, $hLVItemPopupMenu4, $hLVItemPopupMenu5, 6, 7, 8, 9, _
	                             $hLVItemPopupMenu10, $hLVItemPopupMenu11, $hLVItemPopupMenu12, $hLVItemPopupMenu13, $hLVItemPopupMenu14, $hLVItemPopupMenu15 ]
	Local $aPopupMenuIds     = [ $idOpenMsDocu, $idSampleCode, $idCopyToCode, $idClearCode, $idCopyAllItems, $idCopySelItems, $idShowHelp, $idOpenExample, $idTopicVisible, $idThreadDocu, $idHelpPage ]
	Local $aPopupMenuArr     = [ $aPopupMenuHandles, $aPopupMenuIds ]

	$aPopupMenus = $aPopupMenuArr

	$bCreatePopupMenu = True

	Return $aPopupMenus
EndFunc

Func UIASpy_InitialCode()
	If $iCode Then UIASpy_AddCode( "" )
	Local $s = "#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7"
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "" )
	UIASpy_AddCode( ";#AutoIt3Wrapper_UseX64=n ; If target application is running as 32 bit code" )
	UIASpy_AddCode( ";#AutoIt3Wrapper_UseX64=y ; If target application is running as 64 bit code" )
	UIASpy_AddCode( "" )
	UIASpy_AddCode( "#include ""UIA_Constants.au3"" ; Can be copied from UIASpy Includes folder" )
	UIASpy_AddCode( ";#include ""UIA_Functions.au3"" ; Can be copied from UIASpy Includes folder" )
	UIASpy_AddCode( ";#include ""UIA_SafeArray.au3"" ; Can be copied from UIASpy Includes folder" )
	UIASpy_AddCode( ";#include ""UIA_Variant.au3"" ; Can be copied from UIASpy Includes folder" )
	UIASpy_AddCode( "" )
	UIASpy_AddCode( "Opt( ""MustDeclareVars"", 1 )" )
	UIASpy_AddCode( "" )
	UIASpy_AddCode( "Example()" )
	UIASpy_AddCode( "" )
	UIASpy_AddCode( "Func Example()" )
	UIASpy_AddCode( "    ; Create UI Automation object" )
	UIASpy_AddCode( "    Local $oUIAutomation = ObjCreateInterface( " & $sCLSIDCUIAutomationName & ", " & $sIIDIUIAutomationName & ", " & $dtagIUIAutomationName & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "    If Not IsObj( $oUIAutomation ) Then Return ConsoleWrite( ""$oUIAutomation ERR"" & @CRLF )" )
		UIASpy_AddCode( "    ConsoleWrite( ""$oUIAutomation OK"" & @CRLF )" )
	EndIf
	UIASpy_AddCode( "" )
	UIASpy_AddCode( "    ; Get Desktop element" )
	UIASpy_AddCode( "    Local $pDesktop, $oDesktop" )
	UIASpy_AddCode( "    $oUIAutomation.GetRootElement( $pDesktop )" )
	UIASpy_AddCode( "    $oDesktop = ObjCreateInterface( $pDesktop, " & $sIIDIUIAutomationElementName & ", " & $dtagIUIAutomationElementName & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "    If Not IsObj( $oDesktop ) Then Return ConsoleWrite( ""$oDesktop ERR"" & @CRLF )" )
		UIASpy_AddCode( "    ConsoleWrite( ""$oDesktop OK"" & @CRLF )" )
	EndIf
	UIASpy_AddCode( "EndFunc" )
	UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_AutomationObj()
	If $iCode Then UIASpy_AddCode( "" )
	UIASpy_AddCode( "; Create UI Automation object", $iCode ? @CRLF & "; Create UI Automation object" : "; Create UI Automation object" )
	UIASpy_AddCode( "Local $oUIAutomation = ObjCreateInterface( " & $sCLSIDCUIAutomationName & ", " & $sIIDIUIAutomationName & ", " & $dtagIUIAutomationName & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not IsObj( $oUIAutomation ) Then Return ConsoleWrite( ""$oUIAutomation ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$oUIAutomation OK"" & @CRLF )" )
	EndIf
	UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_DesktopObject()
	If $iCode Then UIASpy_AddCode( "" )
	UIASpy_AddCode( "; Get Desktop element", $iCode ? @CRLF & "; Get Desktop element" : "; Get Desktop element" )
	If Not $oRegVars.Exists( "Desktop" ) Then
		UIASpy_AddCode( "Local $pDesktop, $oDesktop" )
		$oRegVars( "Desktop" ) = 1
	EndIf
	UIASpy_AddCode( "$oUIAutomation.GetRootElement( $pDesktop )" )
	UIASpy_AddCode( "$oDesktop = ObjCreateInterface( $pDesktop, " & $sIIDIUIAutomationElementName & ", " & $dtagIUIAutomationElementName & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not IsObj( $oDesktop ) Then Return ConsoleWrite( ""$oDesktop ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$oDesktop OK"" & @CRLF )" )
	EndIf
	UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_Conditions( $iIdx, $iMsg )
	Local Static $aCondsAll[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]][6], $aCondsIdx[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]], $iCondsIdx, $pPrevElem = 0

	Local $bIdentical
	$oUIAutomation.CompareElements( $pPrevElem, $aElems[$iIdx][0], $bIdentical )
	If Not $bIdentical Then
		$pPrevElem = $aElems[$iIdx][0]
		If BitAND( $aElems[$iIdx][8], 2 ) Then
			$aCondsAll = ($aElems[$iIdx][7])[0]
			ReDim $aCondsAll[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]][6]
			$aCondsAll[2][0] = "Element Properties (identification, Sample code)"
			$aCondsAll[4][0] = "Element Properties (session unique, Sample code)"
			Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex, $n
			$iCondsIdx = 0
			For $i = 0 To 1
				$n = $i ? 0 : 2
				$aIndex = $aElemIndexes[$i][0]
				For $j = $n To $aElemIndexes[$i][1]
					$aCondsIdx[$j-$n+$iCondsIdx] = $aIndex[$j]
				Next
				$iCondsIdx += $aElemIndexes[$i][1] - $n
			Next
		Else
			$aCondsAll[0][0] = "Element Properties (identification, Sample code)"
			$aCondsAll[2][0] = "Element Properties (session unique, Sample code)"
			For $i = 2 To 4
				$aCondsAll[0][$i] = $aElemDetailsArr[2][$i]
				$aCondsAll[2][$i] = $aElemDetailsArr[4][$i]
			Next
			For $i = 0 To 2
				$aCondsIdx[$i] = $i
			Next
			$iCondsIdx = 3
		EndIf
	EndIf
	If BitAND( $aElems[$iIdx][8], 2 ) Then
		$aCondsAll[2][1] = ( $iMsg = $idSampleMenu+27 ? "(Window/control...)" : "(Application window...)" )
		$aCondsAll[0][1] = ""
	Else
		$aCondsAll[0][1] = ( $iMsg = $idSampleMenu+27 ? "(Window/control...)" : "(Application window...)" )
		$aCondsAll[2][1] = ""
	EndIf

	$aElemIndex = $aCondsIdx
	$iElemDetails = $iCondsIdx
	$aElemDetails = $aCondsAll
	UIASpy_FillListView( "Property name", "Property value" )
EndFunc

Func UIASpy_WinCtrlCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu13 = $aPopupMenuHandles[13], $hLVItemPopupMenu15 = $aPopupMenuHandles[15]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case Not ( $aElemDetails[$aElemIndex[$iLVItem]][0] _
				 Or $aElemDetails[$aElemIndex[$iLVItem]][1] )       ; Blank line
			Return
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF ; Group line with Forum example
			$hLVItemPopupMenu = $hLVItemPopupMenu15
		Case Else                                               ; Group line without Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu13
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Add comment
			UIASpy_Comment( "Condition to find window/control" )

			; Create condition code
			Local $sAndCond
			UIASpy_CreateWinCtrlCode( $aSel, $iSel, $sAndCond )

			; Find window/control
			UIASpy_FindFirst()

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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
EndFunc

Func UIASpy_CreateWinCtrlCode( $aSel, $iSel, ByRef $sAndCond )
	Local $sCond, $s, $t, $iRet
	If $iSel = 1 Then
		$sCond = "$pCondition" & $iCon
		UIASpy_AddCode( "Local " & $sCond, $iCode ? @CRLF & "Local " & $sCond : "Local " & $sCond )
		Switch $aElemDetails[$aElemIndex[$aSel[0]]][0]
			Case "$UIA_ControlTypePropertyId", "$UIA_NativeWindowHandlePropertyId", "$UIA_ProcessIdPropertyId"
				UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( " & $aElemDetails[$aElemIndex[$aSel[0]]][0] & ", " & $aElemDetails[$aElemIndex[$aSel[0]]][1] & ", " & $sCond & " )" )
			Case Else
				$iRet = $bIgnoreCase _
					? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( " & $aElemDetails[$aElemIndex[$aSel[0]]][0] & ", """ & $aElemDetails[$aElemIndex[$aSel[0]]][1] & """, $PropertyConditionFlags_IgnoreCase, " & $sCond & " )" ) _
					: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( " & $aElemDetails[$aElemIndex[$aSel[0]]][0] & ", """ & $aElemDetails[$aElemIndex[$aSel[0]]][1] & """, " & $sCond & " )" )
		EndSwitch
		$sAndCond = $sCond
		$iCon += 1
		If $bErrorCode Then
			UIASpy_AddCode( "If Not " & $sAndCond & " Then Return ConsoleWrite( """ & $sAndCond & " ERR"" & @CRLF )" )
			UIASpy_AddCode( "ConsoleWrite( """ & $sAndCond & " OK"" & @CRLF )" )
		EndIf
	Else
		For $i = 0 To $iSel - 1
			$sCond = "$pCondition" & $iCon
			Switch $i
				Case 0
					$s = "Local " & $sCond & ", $pCondition" & $iCon+1 & ", $pAndCondition" & $iCon+1
					$t = $iCode ? @CRLF & $s : $s
				Case 1
				Case Else
					$s = "Local " & "$pCondition" & $iCon+1 & ", $pAndCondition" & $iCon+1
					$t = $iCode ? @CRLF & $s : $s
					UIASpy_AddCode( "" )
			EndSwitch
			If $i <> 1 Then
				UIASpy_AddCode( $s, $t )
				$iCon += 1
			EndIf
			Switch $aElemDetails[$aElemIndex[$aSel[$i]]][0]
				Case "$UIA_ControlTypePropertyId", "$UIA_NativeWindowHandlePropertyId", "$UIA_ProcessIdPropertyId"
					UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( " & $aElemDetails[$aElemIndex[$aSel[$i]]][0] & ", " & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & ", $pCondition" & ( $i = 0 ? $iCon-1 : $iCon ) & " )" )
				Case Else
					$iRet = $bIgnoreCase _
						? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( " & $aElemDetails[$aElemIndex[$aSel[$i]]][0] & ", """ & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & """, $PropertyConditionFlags_IgnoreCase, $pCondition" & ( $i = 0 ? $iCon-1 : $iCon ) & " )" ) _
						: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( " & $aElemDetails[$aElemIndex[$aSel[$i]]][0] & ", """ & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & """, $pCondition" & ( $i = 0 ? $iCon-1 : $iCon ) & " )" )
			EndSwitch
			If $i Then
				UIASpy_AddCode( "$oUIAutomation.CreateAndCondition( " & $sAndCond & ", $pCondition" & $iCon & ", $pAndCondition" & $iCon & " )" )
				If $bErrorCode Then
					UIASpy_AddCode( "If Not $pAndCondition" & $iCon & " Then Return ConsoleWrite( ""$pAndCondition" & $iCon & " ERR"" & @CRLF )" )
					UIASpy_AddCode( "ConsoleWrite( ""$pAndCondition" & $iCon & " OK"" & @CRLF )" )
				EndIf
			EndIf
			$sAndCond = $i = 0 ? $sCond : "$pAndCondition" & $iCon
		Next
		$iCon += 1
	EndIf
	$sLastCon = $sAndCond
	#forceref $iRet
EndFunc

Func UIASpy_GetSelectedItems( ByRef $aSelRet )
	Local $aSel = _GUICtrlListView_GetSelectedIndices( $idLV, True ), $iSel = 0
	For $i = 1 To $aSel[0]
		If Not ( $aSel[$i] And StringLen( $aElemDetails[$aElemIndex[$aSel[$i]]][1] ) ) Then ContinueLoop
		$aSel[$iSel] = $aSel[$i]
		$iSel += 1
	Next
	$aSelRet = $aSel
	Return $iSel
EndFunc

Func UIASpy_FindFirst()
	; Item level, _GUICtrlTreeView_Level()
	Local $hItem = $aElems[$iTVSelIdx][4], $hParItem, $iItemLevel = 0, $sParent, $iControl, $sElement, $sWindowPane, $sControl
	$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
	While $hParItem And $iItemLevel < 3
		$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
		$iItemLevel += 1
	WEnd
	; Parent window for current window/control
	$sParent = "$o" & ( $iItemLevel = 1 ? "Desktop" : $oRegVars.Exists( "LastWindowPane" ) ? $oRegVars( "LastWindowPane" ) : "Parent" )
	; Current window/control type
	$aElems[$iTVSelIdx][1].GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
	$sElement = $aUIASpy_Controls[$iControl-50000][0]
	$sWindowPane = $sElement = "Window" Or $sElement = "Pane" ? $sElement : ""
	$sControl = $sElement <> "Window" And $sElement <> "Pane" ? $sElement : ""
	$oRegVars( $sElement ) += 1
	$sElement &= $oRegVars( $sElement )
	If $sWindowPane Then $oRegVars( "LastWindowPane" ) = $sElement
	If $sControl Then $oRegVars( "LastControl" ) = $sElement
	; Create FindFirst sample code
	UIASpy_Comment( "Find window/control" )
	Local $s = "Local $p" & $sElement & ", $o" & $sElement
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( $sParent & ".FindFirst( $TreeScope_Descendants, " & $sLastCon & ", " & "$p" & $sElement & " )" )
	UIASpy_AddCode( "$o" & $sElement & " = ObjCreateInterface( $p" & $sElement & ", " & $sIIDIUIAutomationElementName & ", " & $dtagIUIAutomationElementName & " )" )
	If $bErrorCode Then
		$sElement = "$o" & $sElement
		UIASpy_AddCode( "If Not IsObj( " & $sElement & " ) Then Return ConsoleWrite( """ & $sElement & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( """ & $sElement & " OK"" & @CRLF )" )
	EndIf
	;UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_ApplWinCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu13 = $aPopupMenuHandles[13]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case Not ( $aElemDetails[$aElemIndex[$iLVItem]][0] _
				 Or $aElemDetails[$aElemIndex[$iLVItem]][1] )       ; Blank line
			Return
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case Else                                               ; Group line without Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu13
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Item level, _GUICtrlTreeView_Level()
			Local $hItem = $aElems[$iTVSelIdx][4], $hParItem, $iItemLevel = 0
			$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
			While $hParItem And $iItemLevel < 3
				$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
				$iItemLevel += 1
			WEnd
			If $iItemLevel <> 1 Then Return

			; Current window/control type
			Local $iControl, $sElement, $sWindowPane
			$aElems[$iTVSelIdx][1].GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
			$sElement = $aUIASpy_Controls[$iControl-50000][0]
			$sWindowPane = $sElement = "Window" Or $sElement = "Pane" ? $sElement : ""
			If Not $sWindowPane Then Return

			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Add empty row or comment
			UIASpy_Comment( "Find application window from Desktop with FindAll()" )

			; Create code to find application window
			UIASpy_CreateApplWinCode( $aSel, $iSel, $sElement )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

		Case $idClearCode ; Clear sample code
			If $iCode Or $iRedo Then UIASpy_ClearCode()

		Case $idOpenMsDocu ; Open Microsoft docu
			ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )

		Case $idCopySelItems ; Copy selected items to clipboard
			UIASpy_CopyElemInfo( True )

		Case $idCopyAllItems ; Copy all items to clipboard
			UIASpy_CopyElemInfo( False )

		Case $idShowHelp ; Show help page
			UIASpy_UsageSample()
	EndSwitch
EndFunc

Func UIASpy_CreateApplWinCode( $aSel, $iSel, $sElement )
	; Create variables
	$oRegVars( $sElement ) += 1
	$sElement &= $oRegVars( $sElement )
	$oRegVars( "LastWindowPane" ) = $sElement
	UIASpy_AddCode( "Local $o" & $sElement )

	; Create array
	Local $sArray = "aPropertiesValues"
	$oRegVars( $sArray ) += 1
	$sArray &= $oRegVars( $sArray )
	UIASpy_AddCode( "Local $" & $sArray & "[" & $iSel & "][2]" )
	For $i = 0 To $iSel - 1
		UIASpy_AddCode( "$" & $sArray & "[" & $i & "][0] = " & $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
		Switch $aElemDetails[$aElemIndex[$aSel[$i]]][0]
			Case "$UIA_ControlTypePropertyId", "$UIA_NativeWindowHandlePropertyId", "$UIA_ProcessIdPropertyId"
				UIASpy_AddCode( "$" & $sArray & "[" & $i & "][1] = " & $aElemDetails[$aElemIndex[$aSel[$i]]][1] )
			Case Else
				UIASpy_AddCode( "$" & $sArray & "[" & $i & "][1] = """ & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & """" )
		EndSwitch
	Next

	; Windows version
	Local $sWinVer = $bW10 ? "WIN_10" : $bW81 ? "WIN_81" : $bW8 ? "WIN_8" : "WIN_7"

	; Get application window object
	If $bErrorCode Then
		Local $sError = "iError"
		$oRegVars( $sError ) += 1
		$sError &= $oRegVars( $sError )
		$sElement = "$o" & $sElement
		UIASpy_AddCode( "Local $" & $sError & " = UIA_GetApplicationWindow( """ & $sWinVer & """, $oUIAutomation, $oDesktop, " & $sElement & ", $" & $sArray & " )" )
		UIASpy_AddCode( "If $" & $sError & " Then Return ConsoleWrite( ""UIA_GetApplicationWindow() ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""UIA_GetApplicationWindow() OK"" & @CRLF )" )
		UIASpy_AddCode( "If Not IsObj( " & $sElement & " ) Then Return ConsoleWrite( """ & $sElement & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( """ & $sElement & " OK"" & @CRLF )" )
	Else
		UIASpy_AddCode( "UIA_GetApplicationWindow( """ & $sWinVer & """, $oUIAutomation, $oDesktop, " & "$o" & $sElement & ", $" & $sArray & " )" )
	EndIf
EndFunc

Func UIASpy_Properties( $iIdx )
	Local Static $aPropsAll[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]][6], $aPropsIdx[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]], $iPropsIdx, $pPrevElem = 0

	Local $bIdentical
	$oUIAutomation.CompareElements( $pPrevElem, $aElems[$iIdx][0], $bIdentical )
	If Not $bIdentical Then
		$pPrevElem = $aElems[$iIdx][0]
		If BitAND( $aElems[$iIdx][8], 2 ) Then
			$aPropsAll = ($aElems[$iIdx][7])[0]
			ReDim $aPropsAll[$aElemDetailsIdx[0]+$aElemDetailsIdx[1]][6]
			$aPropsAll[2][0] = "Element Properties (identification, Sample code)"
			$aPropsAll[4][0] = "Element Properties (session unique, Sample code)"
			$aPropsAll[6][0] = "Element Properties (information, Sample code)"
			$aPropsAll[8][0] = "Element Properties (has/is info, Sample code)"
			Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex, $n
			$iPropsIdx = 0
			For $i = 0 To 3
				$n = $i ? 0 : 2
				$aIndex = $aElemIndexes[$i][0]
				If $i = 1 Then
					For $j = $n To $aElemIndexes[$i][1]
						$aPropsIdx[$j-$n+$iPropsIdx] = $aIndex[$j]
						If $aPropsAll[$aIndex[$j]][0] = "$UIA_NativeWindowHandlePropertyId" Then
							$aPropsAll[$aIndex[$j]][2] = 0x000000
							$aPropsAll[$aIndex[$j]][3] = 0xCCFFFF
							$aPropsAll[$aIndex[$j]][4] = ""
							$aPropsAll[$aIndex[$j]][5] = "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507"
						EndIf
					Next
				Else
					For $j = $n To $aElemIndexes[$i][1]
						$aPropsIdx[$j-$n+$iPropsIdx] = $aIndex[$j]
					Next
				EndIf
				$iPropsIdx += $aElemIndexes[$i][1] - $n
			Next
		Else
			$aPropsAll[0][0] = "Element Properties (identification, Sample code)"
			$aPropsAll[2][0] = "Element Properties (session unique, Sample code)"
			$aPropsAll[4][0] = "Element Properties (information, Sample code)"
			$aPropsAll[6][0] = "Element Properties (has/is info, Sample code)"
			$aPropsAll[0][1] = ""
			For $i = 2 To 4
				$aPropsAll[0][$i] = $aElemDetailsArr[2][$i]
				$aPropsAll[2][$i] = $aElemDetailsArr[4][$i]
				$aPropsAll[4][$i] = $aElemDetailsArr[6][$i]
				$aPropsAll[6][$i] = $aElemDetailsArr[8][$i]
			Next
			For $i = 0 To 6
				$aPropsIdx[$i] = $i
			Next
			$iPropsIdx = 7
		EndIf
	EndIf

	$aElemIndex = $aPropsIdx
	$iElemDetails = $iPropsIdx
	$aElemDetails = $aPropsAll
	UIASpy_FillListView( "Property name", "Property value" )
EndFunc

Func UIASpy_PropertyCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu13 = $aPopupMenuHandles[13], $hLVItemPopupMenu15 = $aPopupMenuHandles[15]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case Not ( $aElemDetails[$aElemIndex[$iLVItem]][0] _
				 Or $aElemDetails[$aElemIndex[$iLVItem]][1] )       ; Blank line
			Return
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF ; Group line with Forum example
			$hLVItemPopupMenu = $hLVItemPopupMenu15
		Case Else                                               ; Group line without Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu13
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Get window/control
			Local $sElement = UIASpy_GetLastWinOrCtrl()

			; Add empty row or comment
			UIASpy_Comment( "Element Properties" )

			; Create code
			For $i = 0 To $iSel - 1
				UIASpy_GetPropertyCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
			Next

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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
EndFunc

Func UIASpy_GetPropertyCode( $sElement, $sProperty )
	Local Static $oProperties = ObjCreate( "Scripting.Dictionary" ), $bProperties = False
	If $bProperties Then
		Local $bArray, $sVar = StringRegExp( $sProperty, "\$UIA_(.*)PropertyId.*", 1 )[0] ; 1 = $STR_REGEXPARRAYMATCH
		Switch $oProperties( $sProperty )
			Case "s"
				$sVar = "$s" & $sVar
			Case "b"
				$sVar = "$b" & $sVar
			Case "a"
				If $sProperty = "$UIA_BoundingRectanglePropertyId (scaled)" Then $sVar &= "Scaled"
				$sVar = "$as" & $sVar
				$bArray = True
			Case "i"
				$sVar = "$i" & $sVar
			Case "h"
				$sVar = "$h" & $sVar
			Case "p"
				$sVar = "$p" & $sVar
		EndSwitch
		$oRegVars( $sVar ) += 1
		$sVar &= $oRegVars( $sVar )
		UIASpy_AddCode( "Local " & $sVar )
		UIASpy_AddCode( $sElement & ".GetCurrentPropertyValue( " & $sProperty & ", " & $sVar & " )" )
		If $bArray Then UIASpy_AddCode( "UIA_GetArrayPropertyValueAsString( " & $sVar & " )" )
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & $sVar & " = "" & " & $sVar & " & @CRLF )" )
		Return
	EndIf

	For $i = $aElemDetailsIdx[2] To $aElemDetailsIdx[3]
		Switch $aElemDetailsArr[$i][0]
			Case "$UIA_BoundingRectanglePropertyId", "$UIA_BoundingRectanglePropertyId (scaled)", "$UIA_ControllerForPropertyId", _
			     "$UIA_DescribedByPropertyId", "$UIA_FlowsToPropertyId", "$UIA_RuntimeIdPropertyId"
				$oProperties( $aElemDetailsArr[$i][0] ) = "a"
				ContinueLoop
			Case "$UIA_ControlTypePropertyId", "$UIA_CulturePropertyId", "$UIA_OrientationPropertyId", "$UIA_ProcessIdPropertyId"
				$oProperties( $aElemDetailsArr[$i][0] ) = "i"
				ContinueLoop
			Case "$UIA_NativeWindowHandlePropertyId"
				$oProperties( $aElemDetailsArr[$i][0] ) = "h"
				ContinueLoop
			Case "$UIA_LabeledByPropertyId"
				$oProperties( $aElemDetailsArr[$i][0] ) = "p"
				ContinueLoop
		EndSwitch
		If $aElemDetailsArr[$i][1] == "" Then
			$oProperties( $aElemDetailsArr[$i][0] ) = "s"
			ContinueLoop
		ElseIf $aElemDetailsArr[$i][1] = -1 Then
			$oProperties( $aElemDetailsArr[$i][0] ) = "b"
		EndIf
	Next
	$bProperties = True
	UIASpy_GetPropertyCode( $sElement, $sProperty )
EndFunc

Func UIASpy_GetLastWinOrCtrl( $bWindow = False )
	Local $iControl, $sElement
	$aElems[$iTVSelIdx][1].GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
	$sElement = $aUIASpy_Controls[$iControl-50000][0]

	If $bWindow Then Return _
		"$o" & ( $oRegVars.Exists( "LastWindowPane" ) ? $oRegVars( "LastWindowPane" ) : $sElement )

	Return "$o" & ( ( $sElement = "Window" Or $sElement = "Pane" ) _
	                ? ( $oRegVars.Exists( "LastWindowPane" ) ? $oRegVars( "LastWindowPane" ) : $sElement ) _
	                : ( $oRegVars.Exists( "LastControl" ) ? $oRegVars( "LastControl" ) : $sElement ) )
EndFunc

Func UIASpy_Patterns( $iIdx )
	Local Static $aPatternsDetails[$aElemDetailsIdx[7]+2][6], $aPatterns[$aElemDetailsIdx[5]+1], $iPatterns, $pPrevElem = 0

	Local $bIdentical
	$oUIAutomation.CompareElements( $pPrevElem, $aElems[$iIdx][0], $bIdentical )
	If Not $bIdentical Then
		$pPrevElem = $aElems[$iIdx][0]
		If BitAND( $aElems[$iIdx][8], 2 ) Then
			$aPatternsDetails = ($aElems[$iIdx][7])[0]
			ReDim $aPatternsDetails[$aElemDetailsIdx[7]+2][6]
			$aPatternsDetails[$aElemDetailsIdx[3]+2][0] = "Control Patterns (element actions, Sample code)"
			Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex
			$iPatterns = 0
			$aIndex = $aElemIndexes[4][0]
			For $j = 1 To $aElemIndexes[4][1]
				$aPatterns[$j-1+$iPatterns] = $aIndex[$j]
			Next
			$iPatterns += $aElemIndexes[4][1] - 1
		Else
			$aPatternsDetails[0][0] = "Control Patterns (element actions, Sample code)"
			For $i = 2 To 4
				$aPatternsDetails[0][$i] = $aElemDetailsArr[$aElemDetailsIdx[3]+2][$i]
			Next
			$iPatterns = 1
		EndIf
	EndIf

	$aElemIndex = $aPatterns
	$iElemDetails = $iPatterns
	$aElemDetails = $aPatternsDetails
	UIASpy_FillListView( "Property name", "Property value" )
EndFunc

Func UIASpy_PatternCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> ""      ; Group line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Get window/control
			Local $sElement = UIASpy_GetLastWinOrCtrl()

			; Create pattern code
			For $i = 0 To $iSel - 1
				UIASpy_GetPatternCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
			Next

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			If $sCode Then UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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
EndFunc

Func UIASpy_GetPatternCode( $sElement, $sPattern )
	; Identify pattern
	For $j = 0 To UBound( $aUIASpy_Patterns ) - 1
		If $aUIASpy_Patterns[$j][5] = $sPattern Then ExitLoop
	Next
	; Create pattern code
	UIASpy_Comment( $aUIASpy_Patterns[$j][0] & " Pattern (action) Object" )
	$sPattern = $aUIASpy_Patterns[$j][0] & "Pattern"
	$oRegVars( $sPattern ) += 1
	$sPattern &= $oRegVars( $sPattern )
	UIASpy_AddCode( "Local $p" & $sPattern & ", $o" & $sPattern, $iCode ? @CRLF & "Local $p" & $sPattern & ", $o" & $sPattern : "Local $p" & $sPattern & ", $o" & $sPattern )
	UIASpy_AddCode( $sElement & ".GetCurrentPattern( " & $aUIASpy_Patterns[$j][1] & ", $p" & $sPattern & " )" )
	UIASpy_AddCode( "$o" & $sPattern & " = ObjCreateInterface( $p" & $sPattern & ", " & $aUIASpy_Patterns[$j][6] & ", " & $aUIASpy_Patterns[$j][7] & " )" )
	If $bErrorCode Then
		$sPattern = "$o" & $sPattern
		UIASpy_AddCode( "If Not IsObj( " & $sPattern & " ) Then Return ConsoleWrite( """ & $sPattern & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( """ & $sPattern & " OK"" & @CRLF )" )
	EndIf
EndFunc

Func UIASpy_PatternProps( $iIdx )
	Local Static $aPropsAll = $aElemDetailsArr, $aPropsIdx[$aElemDetailsIdx[9]+1], $iPropsIdx, $pPrevElem = 0

	Local $bIdentical
	$oUIAutomation.CompareElements( $pPrevElem, $aElems[$iIdx][0], $bIdentical )
	If Not $bIdentical Then
		$pPrevElem = $aElems[$iIdx][0]
		If BitAND( $aElems[$iIdx][8], 2 ) Then
			$aPropsAll = ($aElems[$iIdx][7])[0]
			Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex, $n = 1
			$iPropsIdx = 0
			For $i = 5 To 5
				$aIndex = $aElemIndexes[$i][0]
				For $j = $n To $aElemIndexes[$i][1]
					$aPropsIdx[$j-$n+$iPropsIdx] = $aIndex[$j]
				Next
				$iPropsIdx += $aElemIndexes[$i][1] - $n
			Next
		Else
			For $i = 2 To 4
				$aPropsAll[0][$i] = $aElemDetailsArr[$aElemDetailsIdx[11]+2][$i]
			Next
			$iPropsIdx = 1
		EndIf
		$aPropsAll[$aPropsIdx[0]][0] = "Control Pattern Properties (Sample code)"
	EndIf

	$aElemIndex = $aPropsIdx
	$iElemDetails = $iPropsIdx
	$aElemDetails = $aPropsAll
	UIASpy_FillListView( "Property name", "Property value" )
EndFunc

Func UIASpy_PatternPropCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu13 = $aPopupMenuHandles[13], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case Not ( $aElemDetails[$aElemIndex[$iLVItem]][0] _
				 Or $aElemDetails[$aElemIndex[$iLVItem]][1] )       ; Blank line
			Return
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 ; Group header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF ; Group line with Microsoft docu and Forum example
			$hLVItemPopupMenu = $hLVItemPopupMenu14
		Case Else                                               ; Group line without Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu13
			_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )
	EndSwitch

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Get window/control
			Local $sElement = UIASpy_GetLastWinOrCtrl()

			; Add comment
			UIASpy_Comment( "Control Pattern Properties" )

			; Create code
			For $i = 0 To $iSel - 1
				UIASpy_GetPatternPropCode( $sElement, $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
			Next

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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
EndFunc

Func UIASpy_GetPatternPropCode( $sElement, $sProperty )
	Local Static $oProperties = ObjCreate( "Scripting.Dictionary" ), $bProperties = False
	If $bProperties Then
		Local $bArray, $sVar = StringRegExp( $sProperty, "\$UIA_(.*)PropertyId.*", 1 )[0] ; 1 = $STR_REGEXPARRAYMATCH
		Switch $oProperties( $sProperty )
			Case "ai"
				$sVar = "$ai" & $sVar
				$bArray = True
			Case "ap"
				$sVar = "$ap" & $sVar
				$bArray = True
			Case "b"
				$sVar = "$b" & $sVar
			Case "f"
				$sVar = "$f" & $sVar
			Case "i"
				$sVar = "$i" & $sVar
			Case "p"
				$sVar = "$p" & $sVar
			Case "s"
				$sVar = "$s" & $sVar
		EndSwitch
		$oRegVars( $sVar ) += 1
		$sVar &= $oRegVars( $sVar )
		UIASpy_AddCode( "Local " & $sVar )
		UIASpy_AddCode( $sElement & ".GetCurrentPropertyValue( " & $sProperty & ", " & $sVar & " )" )
		If $bArray Then UIASpy_AddCode( "UIA_GetArrayPropertyValueAsString( " & $sVar & " )" )
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & $sVar & " = "" & " & $sVar & " & @CRLF )" )
		Return
	EndIf

	Local $aPatternPropTypes = [ _
		[ "$UIA_DockDockPositionPropertyId",                  "i"  ], _
		[ "$UIA_ExpandCollapseExpandCollapseStatePropertyId", "i"  ], _
		[ "$UIA_GridColumnCountPropertyId",                   "i"  ], _
		[ "$UIA_GridRowCountPropertyId",                      "i"  ], _
		[ "$UIA_GridItemColumnPropertyId",                    "i"  ], _
		[ "$UIA_GridItemColumnSpanPropertyId",                "i"  ], _
		[ "$UIA_GridItemContainingGridPropertyId",            "p"  ], _
		[ "$UIA_GridItemRowPropertyId",                       "i"  ], _
		[ "$UIA_GridItemRowSpanPropertyId",                   "i"  ], _
		[ "$UIA_LegacyIAccessibleChildIdPropertyId",          "i"  ], _
		[ "$UIA_LegacyIAccessibleDefaultActionPropertyId",    "s"  ], _
		[ "$UIA_LegacyIAccessibleDescriptionPropertyId",      "s"  ], _
		[ "$UIA_LegacyIAccessibleHelpPropertyId",             "s"  ], _
		[ "$UIA_LegacyIAccessibleKeyboardShortcutPropertyId", "s"  ], _
		[ "$UIA_LegacyIAccessibleNamePropertyId",             "s"  ], _
		[ "$UIA_LegacyIAccessibleRolePropertyId",             "i"  ], _
		[ "$UIA_LegacyIAccessibleSelectionPropertyId",        "ap" ], _
		[ "$UIA_LegacyIAccessibleStatePropertyId",            "i"  ], _
		[ "$UIA_LegacyIAccessibleValuePropertyId",            "s"  ], _
		[ "$UIA_MultipleViewCurrentViewPropertyId",           "i"  ], _
		[ "$UIA_MultipleViewSupportedViewsPropertyId",        "ai" ], _
		[ "$UIA_RangeValueIsReadOnlyPropertyId",              "b"  ], _
		[ "$UIA_RangeValueLargeChangePropertyId",             "f"  ], _
		[ "$UIA_RangeValueMaximumPropertyId",                 "f"  ], _
		[ "$UIA_RangeValueMinimumPropertyId",                 "f"  ], _
		[ "$UIA_RangeValueSmallChangePropertyId",             "f"  ], _
		[ "$UIA_RangeValueValuePropertyId",                   "f"  ], _
		[ "$UIA_ScrollHorizontallyScrollablePropertyId",      "b"  ], _
		[ "$UIA_ScrollHorizontalScrollPercentPropertyId",     "f"  ], _
		[ "$UIA_ScrollHorizontalViewSizePropertyId",          "f"  ], _
		[ "$UIA_ScrollVerticallyScrollablePropertyId",        "b"  ], _
		[ "$UIA_ScrollVerticalScrollPercentPropertyId",       "f"  ], _
		[ "$UIA_ScrollVerticalViewSizePropertyId",            "f"  ], _
		[ "$UIA_SelectionCanSelectMultiplePropertyId",        "b"  ], _
		[ "$UIA_SelectionIsSelectionRequiredPropertyId",      "b"  ], _
		[ "$UIA_SelectionSelectionPropertyId",                "ap" ], _
		[ "$UIA_SelectionItemIsSelectedPropertyId",           "b"  ], _
		[ "$UIA_SelectionItemSelectionContainerPropertyId",   "p"  ], _
		[ "$UIA_TableColumnHeadersPropertyId",                "ap" ], _
		[ "$UIA_TableRowHeadersPropertyId",                   "ap" ], _
		[ "$UIA_TableRowOrColumnMajorPropertyId",             "i"  ], _
		[ "$UIA_TableItemColumnHeaderItemsPropertyId",        "ap" ], _
		[ "$UIA_TableItemRowHeaderItemsPropertyId",           "ap" ], _
		[ "$UIA_ToggleToggleStatePropertyId",                 "i"  ], _
		[ "$UIA_TransformCanMovePropertyId",                  "b"  ], _
		[ "$UIA_TransformCanResizePropertyId",                "b"  ], _
		[ "$UIA_TransformCanRotatePropertyId",                "b"  ], _
		[ "$UIA_ValueIsReadOnlyPropertyId",                   "b"  ], _
		[ "$UIA_ValueValuePropertyId",                        "s"  ], _
		[ "$UIA_WindowCanMaximizePropertyId",                 "b"  ], _
		[ "$UIA_WindowCanMinimizePropertyId",                 "b"  ], _
		[ "$UIA_WindowIsModalPropertyId",                     "b"  ], _
		[ "$UIA_WindowIsTopmostPropertyId",                   "b"  ], _
		[ "$UIA_WindowWindowInteractionStatePropertyId",      "i"  ], _
		[ "$UIA_WindowWindowVisualStatePropertyId",           "i"  ] ]

	For $i = 0 To UBound( $aPatternPropTypes ) - 1
		$oProperties( $aPatternPropTypes[$i][0] ) = $aPatternPropTypes[$i][1]
	Next
	$bProperties = True

	UIASpy_GetPatternPropCode( $sElement, $sProperty )
EndFunc

Func UIASpy_PatternMethods( $iIdx )
	Local Static $aPatternMethodsDetails = $aElemDetailsArr, $aPatternMethods[$aElemDetailsIdx[13]+1], $iPatternMethods, $pPrevElem = 0

	Local $bIdentical
	$oUIAutomation.CompareElements( $pPrevElem, $aElems[$iIdx][0], $bIdentical )
	If Not $bIdentical Then
		$pPrevElem = $aElems[$iIdx][0]
		If BitAND( $aElems[$iIdx][8], 2 ) Then
			$aPatternMethodsDetails = ($aElems[$iIdx][7])[0]
			$aPatternMethodsDetails[$aElemDetailsIdx[11]+2][0] = "Control Pattern Methods (Sample code)"
			Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex
			$iPatternMethods = 0
			$aIndex = $aElemIndexes[6][0]
			For $j = 1 To $aElemIndexes[6][1]
				$aPatternMethods[$j-1+$iPatternMethods] = $aIndex[$j]
			Next
			$iPatternMethods += $aElemIndexes[6][1] - 1
		Else
			$aPatternMethodsDetails[0][0] = "Control Pattern Methods (Sample code)"
			For $i = 2 To 4
				$aPatternMethodsDetails[0][$i] = $aElemDetailsArr[$aElemDetailsIdx[11]+2][$i]
			Next
			$iPatternMethods = 1
		EndIf
	EndIf

	$aElemIndex = $aPatternMethods
	$iElemDetails = $iPatternMethods
	$aElemDetails = $aPatternMethodsDetails
	UIASpy_FillListView( "Pattern group", "Pattern method" )
EndFunc

Func UIASpy_PatternMethodCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu11 = $aPopupMenuHandles[11], $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu14 = $aPopupMenuHandles[14]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xFFFFE0 Or _ ; Group header with Microsoft docu
		     $aElemDetails[$aElemIndex[$iLVItem]][2] = 0xE8E8E8      ; Subgroup header with Microsoft docu
			$hLVItemPopupMenu = $hLVItemPopupMenu11
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> ""           ; Group line with Microsoft docu
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

			; Pattern method code
			UIASpy_GetPatternMethodCode( $iSel, $aSel )

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			If $sCode Then UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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
EndFunc

Func UIASpy_GetPatternMethodCode( $iSel, $aSel )
	Local $sPattern, $sPatternName, $sPatternPrev, $s, $t
	For $i = 0 To $iSel - 1
		$sPattern = $aElemDetails[$aElemIndex[$aSel[$i]]][0]
		If Not $sPattern Then
			For $j = $aSel[$i] To 0 Step -1
				If $aElemDetails[$aElemIndex[$j]][0] Then ExitLoop
			Next
			$sPattern = $aElemDetails[$aElemIndex[$j]][0]
		EndIf
		$sPattern = StringSplit( $sPattern, " ", 2 )[0] ; 2 = $STR_NOCOUNT
		$sPatternName = $sPattern
		$sPattern = $sPattern & "Pattern"
		$sPattern &= $oRegVars( $sPattern )
		$sPattern = "$o" & $sPattern
		If Not $sPatternPrev Then
			$sPatternPrev = $sPattern
			UIASpy_Comment( $sPatternName & " Pattern (action) Methods" )
		EndIf
		If $sPatternPrev <> $sPattern Then
			$sPatternPrev = $sPattern
			UIASpy_Comment( $sPatternName & " Pattern (action) Methods" )
		EndIf
		If $bErrorCode And $bPatternError Then
			If Not $oRegVars.Exists( "PatternErr" ) Then
				$s = "Local $iPatternErr = " & $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1]
				$oRegVars( "PatternErr" ) = 1
			Else
				$s = "$iPatternErr = " & $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1]
			EndIf
			$t = $iCode ? @CRLF & $s : $s
			UIASpy_AddCode( $s, $t )
			UIASpy_AddCode( "If $iPatternErr Then Return ConsoleWrite( """ & $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & " ERR"" & @CRLF )" )
		Else
			UIASpy_AddCode( $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1], $iCode ? @CRLF & $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1] : $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1] )
		EndIf
		If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( """ & StringRegExp( $sPattern & "." & $aElemDetails[$aElemIndex[$aSel[$i]]][1], "^(.*)\(.*\)$", 1 )[0] & "()" & """ & @CRLF )" )
	Next
EndFunc

Func UIASpy_Sleep()
	UIASpy_Comment( "Sleep( 1000 )" )
	UIASpy_AddCode( "Sleep( 1000 )", $iCode ? @CRLF & "Sleep( 1000 )" : "Sleep( 1000 )" )
	UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_Snippets()
	;                                                                                                               Color     Color     MS docu 
	Local Static $aSnipsAll = [ _ ;    Default                                                                      Col 0     Col 1     links
		[ "Code Snippets (Sample code)", "",                                                                          0xFFFFE0 ], _
		[ "Conditions",                  "And condition",                                                             "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createandcondition"        ], _
		[ "",                            "Or condition",                                                              "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createorcondition"         ], _
		[ "",                            "Case sensitive condition",                                                  "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertycondition"   ], _
		[ "",                            "Case insensitive condition",                                                "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomation-createpropertyconditionex" ], _
		[ "",                            "" ], _
		[ "UI Automation element array", "Create an UI Automation element array from pointer",                        "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelementarray",              "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1422603" ], _
		[ "",                            "" ], _
		[ "Windows/panes",               "" ], _
		[ "        UIA_WinActivate()",   "Activate (give focus to) a window",                                         "",       0xCCFFFF, "",                                                                                                                                     "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420937" ], _
		[ "",                            "" ], _
		[ "Control clicks",              "Mouse click in middle of bounding rectangle",                               "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids",                                           "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420937" ], _
		[ "",                            "Control click via PostMessage and $UIA_AutomationIdPropertyId",             "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-postmessagew",                                                 "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420937" ] ]

	If $oRegVars.Exists( "$oUIElementArray" ) Then
		$aSnipsAll[7][1] = "Traverse an array to get access to individual elements"
		$aSnipsAll[7][3] = 0xCCFFFF
		$aSnipsAll[7][4] = "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationelementarray"
		$aSnipsAll[7][5] = "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1422603"
	Else
		$aSnipsAll[7][1] = ""
		$aSnipsAll[7][3] = ""
		$aSnipsAll[7][4] = ""
		$aSnipsAll[7][5] = ""
	EndIf

	Local Static $iSnipsIdx = UBound( $aSnipsAll ), $aSnipsIdx[$iSnipsIdx], $bDone = False
	If Not $bDone Then
		$bDone = True
		For $i = 0 To $iSnipsIdx - 1
			$aSnipsIdx[$i] = $i
		Next
	EndIf

	$aElemIndex = $aSnipsIdx
	$iElemDetails = $iSnipsIdx
	$aElemDetails = $aSnipsAll
	UIASpy_FillListView( "Snippet group", "Snippet name", 200 )
EndFunc

Func UIASpy_SnippetsCode( $iLVItem )
	; Create ListView right click Popup Menu
	Local Static $aPopupMenus = UIASpy_CreatePopupMenu(), $aPopupMenuHandles = $aPopupMenus[0], $aPopupMenuIds = $aPopupMenus[1]
	Local Static $hLVItemPopupMenu12 = $aPopupMenuHandles[12], $hLVItemPopupMenu13 = $aPopupMenuHandles[13], $hLVItemPopupMenu14 = $aPopupMenuHandles[14], $hLVItemPopupMenu15 = $aPopupMenuHandles[15]
	Local Static $idOpenMsDocu = $aPopupMenuIds[0], $idSampleCode = $aPopupMenuIds[1], $idCopyToCode = $aPopupMenuIds[2], $idClearCode = $aPopupMenuIds[3], $idCopyAllItems = $aPopupMenuIds[4], $idCopySelItems = $aPopupMenuIds[5], $idShowHelp = $aPopupMenuIds[6], $idOpenExample = $aPopupMenuIds[7]

	; Determine Popup Menu
	Local $hLVItemPopupMenu
	Switch True
		Case Not $aElemDetails[$aElemIndex[$iLVItem]][1] And _  ; Group or subgroup header without Microsoft docu
		     Not $aElemDetails[$aElemIndex[$iLVItem]][4]
			Return
		Case $aElemDetails[$aElemIndex[$iLVItem]][4] <> ""      ; Subgroup line with Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu14 : $hLVItemPopupMenu12
		Case Else                                               ; Subgroup line without Microsoft docu
			$hLVItemPopupMenu = $aElemDetails[$aElemIndex[$iLVItem]][3] = 0xCCFFFF _
			                  ? $hLVItemPopupMenu15 : $hLVItemPopupMenu13
	EndSwitch
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idCopyToCode, False, False )
	_GUICtrlMenu_SetItemEnabled( $hLVItemPopupMenu, $idClearCode, $iCode Or $iRedo, False )

	; Handle Popup Menu item
	Switch _GUICtrlMenu_TrackPopupMenu( $hLVItemPopupMenu, $hLV, -1, -1, 1, 1, 2 )

		; --- Create sample code ---

		Case $idSampleCode ; Create sample code
			; Get selected items
			Local $aSel, $iSel = UIASpy_GetSelectedItems( $aSel )

			; Add comment
			UIASpy_Comment( "Code Snippets" )

			; Create code
			Local $sGroup, $sPrevGroup, $sElement
			For $i = 0 To $iSel - 1
				; Find group
				For $j = $aSel[$i] To 0 Step - 1
					If $aElemDetails[$aElemIndex[$j]][0] And _
					   StringLeft( $aElemDetails[$aElemIndex[$j]][0], 1 ) <> " " Then ExitLoop
				Next
				$sGroup = $aElemDetails[$aElemIndex[$j]][0]
				If $i And $sPrevGroup <> $sGroup Then UIASpy_AddCode( "" )
				Switch $sGroup
					Case "Conditions"
						Switch $aElemDetails[$aElemIndex[$aSel[$i]]][1]
							Case "And condition"
								UIASpy_AndCond( Not $i ? False : True )
							Case "Or condition"
								UIASpy_OrCond( Not $i ? False : True )
							Case "Case sensitive condition"
								UIASpy_CaseCond( Not $i ? False : True )
							Case "Case insensitive condition"
								UIASpy_NoCaseCond( Not $i ? False : True )
						EndSwitch

					Case "UI Automation element array"
						Local $sVar1, $sVar2
						Switch $aElemDetails[$aElemIndex[$aSel[$i]]][1]
							Case "Create an UI Automation element array from pointer"
								$sVar1 = "$oUIElementArray"
								$sVar2 = "$iLength"
								$oRegVars( $sVar1 ) += 1
								$sVar2 &= $oRegVars( $sVar1 )
								$sVar1 &= $oRegVars( $sVar1 )
								UIASpy_AddCode( "Local " & $sVar1 & ", " & $sVar2 & " ; $pElements is a pointer to an UI Automation element array" )
								UIASpy_AddCode( $sVar1 & " = ObjCreateInterFace( $pElements, $sIID_IUIAutomationElementArray, $dtag_IUIAutomationElementArray )" )
								UIASpy_AddCode( $sVar1 & ".Length( " & $sVar2 & " )" )
								If $bErrorCode Then
									UIASpy_AddCode( "If Not " & $sVar2 & " Then Return ConsoleWrite( """ & $sVar2 & " = 0 ERR"" & @CRLF )" )
									UIASpy_AddCode( "ConsoleWrite( """ & $sVar2 & " = "" & " & $sVar2 & " & @CRLF )" )
								EndIf
							Case "Traverse an array to get access to individual elements"
								Local $sVar = "Element"
								$oRegVars( $sVar ) += 1
								$sVar &= $oRegVars( $sVar )
								Local $sValue = "$sValue" & $oRegVars( "Element" )
								UIASpy_AddCode( "Local $p" & $sVar & ", $o" & $sVar & ", " & $sValue )
								$sVar1 = "$oUIElementArray" & $oRegVars( "$oUIElementArray" )
								$sVar2 = "$iLength" & $oRegVars( "$oUIElementArray" )
								UIASpy_AddCode( "For $i = 0 To " & $sVar2 & " - 1" )
								UIASpy_AddCode( "  " & $sVar1 & ".GetElement( $i" & ", $p" & $sVar & " )" )
								UIASpy_AddCode( "  $o" & $sVar & " = ObjCreateInterface( $p" & $sVar & ", " & $sIIDIUIAutomationElementName & ", " & $dtagIUIAutomationElementName & " )" )
								UIASpy_AddCode( "  $o" & $sVar & ".GetCurrentPropertyValue( $UIA_ClassNamePropertyId, " & $sValue & " ) ; $UIA_ClassNamePropertyId is used as example" )
								If $bErrorCode Then UIASpy_AddCode( "  ConsoleWrite( """ & $sValue & " = "" & " & $sValue & " & @CRLF )" )
								UIASpy_AddCode( "Next" )
						EndSwitch

					Case "Windows/panes"
						$sElement = UIASpy_GetLastWinOrCtrl( True )
						Switch $aElemDetails[$aElemIndex[$aSel[$i]]][1]
							Case "Activate (give focus to) a window"
								UIASpy_AddCode( "UIA_WinActivate( " & $sElement & " )" )
								If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( ""UIA_WinActivate( " & $sElement & " )"" & @CRLF )" )
						EndSwitch

					Case "Control clicks"
						Switch $aElemDetails[$aElemIndex[$aSel[$i]]][1]
							Case "Mouse click in middle of bounding rectangle"
								$sElement = UIASpy_GetLastWinOrCtrl()
								UIASpy_AddCode( "UIA_MouseClick( " & $sElement & " )" )
								If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( ""UIA_MouseClick( " & $sElement & " )"" & @CRLF )" )
							Case "Control click via PostMessage and $UIA_AutomationIdPropertyId"
								$sElement = UIASpy_GetLastWinOrCtrl( True )
								UIASpy_AddCode( "UIA_PostMessage( " & $sElement & ", $sAutomationId )" )
								If $bErrorCode Then UIASpy_AddCode( "ConsoleWrite( ""UIA_PostMessage( " & $sElement & ", $sAutomationId )"" & @CRLF )" )
						EndSwitch
				EndSwitch
				$sPrevGroup = $sGroup
			Next

			; Undo/Redo info
			UIASpy_UndoRedoInfo()

			; Print and copy sample code
			UIASpy_ShowCode()

		; --- Sample code done ---

		Case $idCopyToCode ; Copy to sample code
			UIASpy_CopyToCode()

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

Func UIASpy_AndCond( $bBlankLine = True )
	UIASpy_Comment( "And condition to find window/control", $bBlankLine )
	Local $s = "Local $pCondition" & $iCon & ", $pCondition" & $iCon+1 & ", $pAndCondition" & $iCon+1
	Local $t = $iCode ? @CRLF & $s : $s, $iRet
	UIASpy_AddCode( $s, $t )
	$iRet = $bIgnoreCase _
		? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( $UIA_PropertyId, ""PropertyValue"", $PropertyConditionFlags_IgnoreCase, $pCondition" & $iCon & " )" ) _
		: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( $UIA_PropertyId, ""PropertyValue"", $pCondition" & $iCon & " )" )
	$iRet = $bIgnoreCase _
		? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( $UIA_PropertyId, ""PropertyValue"", $PropertyConditionFlags_IgnoreCase, $pCondition" & $iCon+1 & " )" ) _
		: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( $UIA_PropertyId, ""PropertyValue"", $pCondition" & $iCon+1 & " )" )
	UIASpy_AddCode( "$oUIAutomation.CreateAndCondition( $pCondition" & $iCon & ", $pCondition" & $iCon+1 & ", $pAndCondition" & $iCon+1 & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not $pAndCondition" & $iCon+1 & " Then Return ConsoleWrite( ""$pAndCondition" & $iCon+1 & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$pAndCondition" & $iCon+1 & " OK"" & @CRLF )" )
	EndIf
	$sLastCon = "$pAndCondition" & $iCon+1
	$iCon += 2
	#forceref $iRet
EndFunc

Func UIASpy_OrCond( $bBlankLine = True )
	UIASpy_Comment( "Or condition to find window/control", $bBlankLine )
	Local $s = "Local $pCondition" & $iCon & ", $pCondition" & $iCon+1 & ", $pOrCondition" & $iCon+1
	Local $t = $iCode ? @CRLF & $s : $s, $iRet
	UIASpy_AddCode( $s, $t )
	$iRet = $bIgnoreCase _
		? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( $UIA_PropertyId, ""PropertyValue"", $PropertyConditionFlags_IgnoreCase, $pCondition" & $iCon & " )" ) _
		: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( $UIA_PropertyId, ""PropertyValue"", $pCondition" & $iCon & " )" )
	$iRet = $bIgnoreCase _
		? UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( $UIA_PropertyId, ""PropertyValue"", $PropertyConditionFlags_IgnoreCase, $pCondition" & $iCon+1 & " )" ) _
		: UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( $UIA_PropertyId, ""PropertyValue"", $pCondition" & $iCon+1 & " )" )
	UIASpy_AddCode( "$oUIAutomation.CreateOrCondition( $pCondition" & $iCon & ", $pCondition" & $iCon+1 & ", $pOrCondition" & $iCon+1 & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not $pOrCondition" & $iCon+1 & " Then Return ConsoleWrite( ""$pOrCondition" & $iCon+1 & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$pOrCondition" & $iCon+1 & " OK"" & @CRLF )" )
	EndIf
	$sLastCon = "$pOrCondition" & $iCon+1
	$iCon += 2
	#forceref $iRet
EndFunc

Func UIASpy_CaseCond( $bBlankLine = True )
	UIASpy_Comment( "Case sensitive condition to find window/control", $bBlankLine )
	Local $s = "Local $pCondition" & $iCon
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "$oUIAutomation.CreatePropertyCondition( $UIA_PropertyId, ""PropertyValue"", $pCondition" & $iCon & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not $pCondition" & $iCon & " Then Return ConsoleWrite( ""$pCondition" & $iCon & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$pCondition" & $iCon & " OK"" & @CRLF )" )
	EndIf
	$sLastCon = "$pCondition" & $iCon
	$iCon += 1
EndFunc

Func UIASpy_NoCaseCond( $bBlankLine = True )
	UIASpy_Comment( "Case insensitive condition to find window/control", $bBlankLine )
	Local $s = "Local $pCondition" & $iCon
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "$oUIAutomation.CreatePropertyConditionEx( $UIA_PropertyId, ""PropertyValue"", $PropertyConditionFlags_IgnoreCase, $pCondition" & $iCon & " )" )
	If $bErrorCode Then
		UIASpy_AddCode( "If Not $pCondition" & $iCon & " Then Return ConsoleWrite( ""$pCondition" & $iCon & " ERR"" & @CRLF )" )
		UIASpy_AddCode( "ConsoleWrite( ""$pCondition" & $iCon & " OK"" & @CRLF )" )
	EndIf
	$sLastCon = "$pCondition" & $iCon
	$iCon += 1
EndFunc

Func UIASpy_ObjectErr()
	If $iCode Then UIASpy_AddCode( "" )
	Local $s = "If Not IsObj( $oObject ) Then Return ConsoleWrite( ""$oObject ERR"" & @CRLF )"
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "ConsoleWrite( ""$oObject OK"" & @CRLF )" )
	UIASpy_ShowCode()
EndFunc

Func UIASpy_PointerErr()
	If $iCode Then UIASpy_AddCode( "" )
	Local $s = "If Not $pPointer Then Return ConsoleWrite( ""$pPointer ERR"" & @CRLF )"
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "ConsoleWrite( ""$pPointer OK"" & @CRLF )" )
	UIASpy_ShowCode()
EndFunc

Func UIASpy_PatternErr()
	If $iCode Then UIASpy_AddCode( "" )
	Local $s = "Local $iPatternErr = $oPattern.Method()"
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "If $iPatternErr Then Return ConsoleWrite( ""$oPattern.Method() ERR"" & @CRLF )" )
	UIASpy_ShowCode()
EndFunc

Func UIASpy_ElemArrayErr()
	If $iCode Then UIASpy_AddCode( "" )
	Local $s = "If Not $iLength Then Return ConsoleWrite( ""$iLength = 0 ERR"" & @CRLF )"
	Local $t = $iCode ? @CRLF & $s : $s
	UIASpy_AddCode( $s, $t )
	UIASpy_AddCode( "ConsoleWrite( ""$iLength = "" & $iLength & @CRLF )" )
	UIASpy_ShowCode()
EndFunc

Func UIASpy_Comment( $sComment, $bBlankLine = True, $bConsoleWrite = True )
	If $bBlankLine And $iCode Then UIASpy_AddCode( "" )
	$sComment = "--- " & $sComment & " ---"
	UIASpy_AddCode( "; " & $sComment, $iCode ? @CRLF & "; " & $sComment : "; " & $sComment )
	UIASpy_AddCode( "" )
	If $bErrorCode And $bConsoleWrite Then
		UIASpy_AddCode( "ConsoleWrite( """ & $sComment & """ & @CRLF )" )
		UIASpy_AddCode( "" )
	EndIf
EndFunc

Func UIASpy_Corrections()
	If $iCode Then UIASpy_AddCode( "" )
	UIASpy_AddCode( "; Code corrections:", $iCode ? @CRLF & "; Code corrections:" : "; Code corrections:" )
	UIASpy_AddCode( "; UIA_Constants.au3 path" )
	UIASpy_AddCode( "; UIA_Functions.au3 path" )
	UIASpy_AddCode( "; UIA_SafeArray.au3 path" )
	UIASpy_AddCode( "; UIA_Variant.au3 path" )
	UIASpy_AddCode( "; Code to open target appl" )
	UIASpy_AddCode( ";   If it isn't already open" )
	UIASpy_AddCode( "; Create undeclared variables" )
	UIASpy_AddCode( ";   There should be very few" )
	UIASpy_AddCode( "; Delete double declared variables" )
	UIASpy_AddCode( ";   There should be very few" )
	UIASpy_AddCode( "; Window, Pane, Parent and Control names" )
	UIASpy_AddCode( ";   Most names should be correct" )
	UIASpy_AddCode( "; Fill out Pattern (action) Method parameters" )
	UIASpy_AddCode( ";   See Microsoft docu for the Pattern Method" )
	UIASpy_AddCode( "; Place the code inside a function" )
	UIASpy_AddCode( ";   Necessary due to Return statements" )
	UIASpy_UndoRedoInfo()
	UIASpy_ShowCode()
EndFunc

Func UIASpy_UndoCode()
	If Not $iRedo Then _
		GUICtrlSetState( $idSampleMenu+18, $GUI_ENABLE ) ; Redo
	$aRedo[$iRedo] = $iUndo
	$iRedo += 1
	$iCode          = $aUndoRedo[$aUndo[$iUndo-1]][0]
	$sCode          = $aUndoRedo[$aUndo[$iUndo-1]][1]
	$iCon           = $aUndoRedo[$aUndo[$iUndo-1]][2]
	$sLastCon       = $aUndoRedo[$aUndo[$iUndo-1]][3]
	Local $aRegVars = $aUndoRedo[$aUndo[$iUndo-1]][4]
	Local $iRegVars = $aUndoRedo[$aUndo[$iUndo-1]][5]
	$oRegVars.RemoveAll()
	If $iRegVars Then
		For $i = 0 To $iRegVars - 1
			$oRegVars( $aRegVars[$i][0] ) = $aRegVars[$i][1]
		Next
	EndIf
	$iUndo -= 1
	$iUndoRedo -= 1
	UIASpy_ShowCode()
	If Not $iUndo Then
		GUICtrlSetState( $idSampleMenu+17, $GUI_DISABLE ) ; Undo
		GUICtrlSetState( $idSampleMenu+20, $GUI_DISABLE ) ; Show
	EndIf
EndFunc

Func UIASpy_RedoCode()
	If Not $iUndo Then
		GUICtrlSetState( $idSampleMenu+17, $GUI_ENABLE ) ; Undo
		GUICtrlSetState( $idSampleMenu+20, $GUI_ENABLE ) ; Show
	EndIf
	$iUndo += 1
	$iUndoRedo += 1
	$iCode          = $aUndoRedo[$aRedo[$iRedo-1]][0]
	$sCode          = $aUndoRedo[$aRedo[$iRedo-1]][1]
	$iCon           = $aUndoRedo[$aRedo[$iRedo-1]][2]
	$sLastCon       = $aUndoRedo[$aRedo[$iRedo-1]][3]
	Local $aRegVars = $aUndoRedo[$aRedo[$iRedo-1]][4]
	Local $iRegVars = $aUndoRedo[$aRedo[$iRedo-1]][5]
	$oRegVars.RemoveAll()
	If $iRegVars Then
		For $i = 0 To $iRegVars - 1
			$oRegVars( $aRegVars[$i][0] ) = $aRegVars[$i][1]
		Next
	EndIf
	$iRedo -= 1
	UIASpy_ShowCode()
	If Not $iRedo Then _
		GUICtrlSetState( $idSampleMenu+18, $GUI_DISABLE ) ; Redo
EndFunc

Func UIASpy_UndoRedoInfo()
	If Not $iUndo Then
		GUICtrlSetState( $idSampleMenu+17, $GUI_ENABLE ) ; Undo
		GUICtrlSetState( $idSampleMenu+20, $GUI_ENABLE ) ; Show
		GUICtrlSetState( $idSampleMenu+21, $GUI_ENABLE ) ; Clear
	EndIf
	$aUndo[$iUndo] = $iUndoRedo - 1
	$iUndo += 1
	If $iRedo Then
		GUICtrlSetState( $idSampleMenu+18, $GUI_DISABLE ) ; Redo
		$iRedo = 0
	EndIf
	Local $aKeys = $oRegVars.Keys()
	Local $iRegVars = UBound( $aKeys )
	Local $aRegVars[$iRegVars][2]
	For $i = 0 To $iRegVars - 1
		$aRegVars[$i][0] = $aKeys[$i]
		$aRegVars[$i][1] = $oRegVars( $aKeys[$i] )
	Next
	$aUndoRedo[$iUndoRedo][0] = $iCode
	$aUndoRedo[$iUndoRedo][1] = $sCode
	$aUndoRedo[$iUndoRedo][2] = $iCon
	$aUndoRedo[$iUndoRedo][3] = $sLastCon
	$aUndoRedo[$iUndoRedo][4] = $aRegVars
	$aUndoRedo[$iUndoRedo][5] = $iRegVars
	$iUndoRedo += 1
EndFunc

Func UIASpy_AddCode( $s, $t = "" )
	$aCode[$iCode][0] = $iCode
	$aCode[$iCode][1] = $s
	$aCodeIdx[$iCode] = $iCode
	$sCode &= $t ? $t : @CRLF & $s
	$iCode += 1
EndFunc

Func UIASpy_CopyToCode()
	Local $iSel = _GUICtrlListView_GetSelectedCount( $idLV )
	If $iSel Then
		UIASpy_Comment( "Copy element info", True, False )
		Local $aSel = _GUICtrlListView_GetSelectedIndices( $idLV, True ), $s
		For $i = 1 To $aSel[0]
			$s = "; " & ( Not ( $aElemDetails[$aElemIndex[$aSel[$i]]][1] == "" ) _
			            ? ( StringFormat( "%-52s", $aElemDetails[$aElemIndex[$aSel[$i]]][0] ) & $aElemDetails[$aElemIndex[$aSel[$i]]][1] ) _
			            : $aElemDetails[$aElemIndex[$aSel[$i]]][0] )
			UIASpy_AddCode( $s )
		Next
		; Undo/Redo info
		UIASpy_UndoRedoInfo()
		; Print and copy sample code
		If $sCode Then UIASpy_ShowCode()
	EndIf
EndFunc

Func UIASpy_ShowCode()
	$fClipCopy = 2
	$aElemDetails = $aCode
	$iElemDetails = $iCode
	$aElemIndex = $aCodeIdx
	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	_GUICtrlListView_SetColumnWidth( $idLV, 0, 55 )
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth - ( WinGetClientSize( $hTV )[0] + 30 ) - 55 - 30 )
	_GUICtrlHeader_SetItemAlign( $hHeader, 0, 1 ) ; 1 = Text is right-aligned
	_GUICtrlHeader_SetItemText( $hHeader, 0, "#" )
	_GUICtrlHeader_SetItemText( $hHeader, 1, "Code" )
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 ) ; Reset selected items
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, $iElemDetails, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, 0, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
	UIASpy_ListView_SetColumn1Width()
	ClipPut( $sCode )
EndFunc

Func UIASpy_ClearCode( $bClick = True )
	; Reset code
	$sCode = ""
	$iCode = 0
	$iCon = 0
	$sLastCon = ""
	$oRegVars.RemoveAll()

	; Reset Undo/Redo
	$iUndo = 0
	$iRedo = 0
	$iUndoRedo = 1
	$aUndoRedo[0][0] = $iCode
	$aUndoRedo[0][1] = $sCode
	$aUndoRedo[0][2] = $iCon
	$aUndoRedo[0][3] = $sLastCon
	$aUndoRedo[0][4] = 0 ; $aRegVars
	$aUndoRedo[0][5] = 0 ; $iRegVars
	GUICtrlSetState( $idSampleMenu+17, $GUI_DISABLE )
	GUICtrlSetState( $idSampleMenu+18, $GUI_DISABLE )

	; Reset Show/Clear
	GUICtrlSetState( $idSampleMenu+20, $GUI_DISABLE )
	GUICtrlSetState( $idSampleMenu+21, $GUI_DISABLE )

	; Clear ListView
	If $fClipCopy = 2 Then
		;_GUICtrlListView_BeginUpdate( $idLV )
		GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
		GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 )
		GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
		;_GUICtrlListView_EndUpdate( $idLV )
	EndIf

	If $bClick Then _
		UIASpy_TreeView_ClickItem( $hTV, $aElems[$iTVSelIdx][4] )
EndFunc

Func UIASpy_FillListView( $sHeader0, $sHeader1, $iCol0Width = $iLvCol0Width )
	$fClipCopy = False
	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	_GUICtrlListView_SetColumnWidth( $idLV, 0, $iCol0Width )
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth - ( WinGetClientSize( $hTV )[0] + 30 ) - $iCol0Width - 30 )
	_GUICtrlHeader_SetItemAlign( $hHeader, 0, 0 ) ; 0 = Text is left-aligned
	_GUICtrlHeader_SetItemText( $hHeader, 0, $sHeader0 )
	_GUICtrlHeader_SetItemText( $hHeader, 1, $sHeader1 )
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 ) ; Reset selected items
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, $iElemDetails, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, 0, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
	UIASpy_ListView_SetColumn1Width()
	$fCodePage = 1
EndFunc
