#include-once
#include "UIASpy_Elements.au3"
#include "UIASpy_Detect.au3"

Global $aFuncKeys = [ [ "{F1}", "UIASpy_F1" ], _ ; F-key, Function
                      [ "{F2}", "UIASpy_F2" ], _
                      [ "{F3}", "UIASpy_F3" ], _
                      [ "{F4}", "UIASpy_F4" ], _
                      [ "{F7}", "UIASpy_F7" ], _
                      [ "{F8}", "UIASpy_F8" ] ]

Func CreateDetectMenu( $idDetectMenu )
	GUICtrlCreateMenuItem( "Detect element and show rectangle", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "", $idDetectMenu )
	GUICtrlCreateMenuItem( "Detect UI Automation element", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "", $idDetectMenu )
	GUICtrlCreateMenuItem( "F1 - F4: Detect element under mouse", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_CHECKED+$GUI_DISABLE )
	GUICtrlCreateMenuItem( "F1: Update direct childs of element", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "F2: Update direct childs of parent", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "F3: Update all childs of element", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "F4: Update all childs of parent", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "", $idDetectMenu )
	GUICtrlCreateMenuItem( "F7 - F8: Navigate up/down along path", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_CHECKED+$GUI_DISABLE )
	GUICtrlCreateMenuItem( "F7: Navigate to parent element", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "F8: Navigate to child element", $idDetectMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "", $idDetectMenu )
	GUICtrlCreateMenuItem( "Show help page", $idDetectMenu )
EndFunc

Func DetectFKeyEvents( $iMsg, $idDetectMenu, $bDetectVal = Default )
	Local Static $bDetect = True
	If $iMsg = 0 Then Return $bDetect
	If $iMsg = 1 Then
		$bDetect = $bDetectVal
		Return
	EndIf
	Switch $iMsg - $idDetectMenu - 1
		Case 2 ; Detect UI Automation element
			If $bDetect Then
				For $i = 0 To 5
					HotKeySet( $aFuncKeys[$i][0] )
				Next
			Else
				For $i = 0 To 5
					HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
				Next
				; A mouse click in title bar causes hotkeys to work immediately
				; Without a mouse click, hotkeys seems to have no effect
				Local $aMPos = MouseGetPos(), $aPos = WinGetPos( $hGui )
				MouseClick( "primary", $aPos[0]+100, $aPos[1]+15, 1, 0 )
				MouseMove( $aMPos[0], $aMPos[1], 0 )
			EndIf
			$bDetect = Not $bDetect
			GUICtrlSetState( $iMsg, $bDetect ? $GUI_CHECKED : $GUI_UNCHECKED )
			GUICtrlSetState( $iMsg+2, $GUI_DISABLE + ( $bDetect ? $GUI_CHECKED : $GUI_UNCHECKED ) )
			GUICtrlSetState( $iMsg+8, $GUI_DISABLE + ( $bDetect ? $GUI_CHECKED : $GUI_UNCHECKED ) )
			If $bDetect = $bShowElemRect Then
				$bDetectAndRect = $bShowElemRect
				GUICtrlSetState( 4, $bDetectAndRect ? $GUI_CHECKED : $GUI_UNCHECKED ) ; 4 = $idDetectMenu+1
			EndIf
	EndSwitch
EndFunc

Func UIASpy_F1()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 1 ) ; Update direct childs of element
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_F2()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 2 ) ; Update direct childs of parent
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_F3()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 3 ) ; Update all childs of element
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_F4()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 4 ) ; Update all childs of parent
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_F7()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 7 ) ; Navigate to parent element
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_F8()
	; Don't start a new function while there is already one running
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], "UIASpy_Fn_Running"  )
	Next
	GUICtrlSendToDummy( $idFkey, 8 ) ; Navigate to child element
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next
EndFunc

Func UIASpy_Fn_Running()
EndFunc

Func UIASpy_ShowElement( $iIdx, $bActivate = False, $bVisible = True )
	$iDetectElemIdx = $iIdx
	$bFkeyDetect = False

	; $UIA_BoundingRectanglePropertyId
	Local $sRect = (($aElems[$iIdx][7])[0])[19][1]
	If Not $sRect Then Return
	Local $aRect = StringSplit( $sRect, "=,", 2 ) ; 2 = $STR_NOCOUNT
	If @error Then Return
	Local $l = $aRect[1], $t = $aRect[3], $w = $aRect[5], $h = $aRect[7]

	; Top window
	Local $aWindows[100], $iWindows = 0
	Local $hItem = $aElems[$iIdx][4], $hParent
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
	DllStructSetData( $tItem, "hItem", $hItem )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
	$aWindows[$iWindows] = $aElems[DllStructGetData($tItem,"Param")-100000][3]
	$iWindows += 1
	; _GUICtrlTreeView_GetParentHandle
	$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
	While $hParent
		; _GUICtrlTreeView_GetItemParam()
		DllStructSetData( $tItem, "hItem", $hParent )
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
		$aWindows[$iWindows] = $aElems[DllStructGetData($tItem,"Param")-100000][3]
		$iWindows += 1
		; _GUICtrlTreeView_GetParentHandle
		$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParent )[0]
	WEnd
	Local $hWindow = HWnd( $iWindows > 2 ? $aWindows[$iWindows-2] : $aWindows[0] )
	If Not $hWindow Or Not WinExists( $hWindow ) Then Return

	If $bActivate Then
		; Activate window
		WinActivate( $hWindow )
		Sleep( 100 ) ; Wait 100 ms
		If Not WinActive( $hWindow ) Then Return
	EndIf

	; Check visibility of element at center and points near the 4 corners
	; Must match the element given by the pointer in $aElems[$iIdx][0]
	If $bVisible Then
		Local $pUIElement, $bIdentical
		Local Static $tPoint = DllStructCreate( $tagPOINT )
		; Checks at element center
		DllStructSetData( $tPoint, "X", $l+$w/2 )
		DllStructSetData( $tPoint, "Y", $t+$h/2 )
		$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
		$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
		If Not $bIdentical Then
			; Checks at element corners
			DllStructSetData( $tPoint, "X", $l )
			DllStructSetData( $tPoint, "Y", $t )
			$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
			$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
			If Not $bIdentical Then
				DllStructSetData( $tPoint, "X", $l+$w )
				DllStructSetData( $tPoint, "Y", $t )
				$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
				$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
				If Not $bIdentical Then
					DllStructSetData( $tPoint, "X", $l+$w )
					DllStructSetData( $tPoint, "Y", $t+$h )
					$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
					$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
					If Not $bIdentical Then
						DllStructSetData( $tPoint, "X", $l )
						DllStructSetData( $tPoint, "Y", $t+$h )
						$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
						$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
						If Not $bIdentical Then
							; Checks 4 pixels inside element from corners
							DllStructSetData( $tPoint, "X", $l+4 )
							DllStructSetData( $tPoint, "Y", $t+4 )
							$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
							$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
							If Not $bIdentical Then
								DllStructSetData( $tPoint, "X", $l+$w-4 )
								DllStructSetData( $tPoint, "Y", $t+4 )
								$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
								$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
								If Not $bIdentical Then
									DllStructSetData( $tPoint, "X", $l+$w-4 )
									DllStructSetData( $tPoint, "Y", $t+$h-4 )
									$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
									$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
									If Not $bIdentical Then
										DllStructSetData( $tPoint, "X", $l+4 )
										DllStructSetData( $tPoint, "Y", $t+$h-4 )
										$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
										$oUIAutomation.CompareElements( $pUIElement, $aElems[$iIdx][0], $bIdentical )
										If Not $bIdentical Then Return
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		; Store element info
		$oUIAutomation.ElementFromPoint( $tPoint, $pDetectElement )
		$tDetectPoint = $tPoint
	EndIf

	; Draw element rectangle
	DrawElemRect( $l, $l+$w, $t, $t+$h )
	ReDrawElemRectInit( $hWindow, $l, $l+$w, $t, $t+$h )
	Return True
EndFunc

Func UIASpy_DeleteTopElements( $iIdx )
	; Current 1st level element (top window)
	; _GUICtrlTreeView_GetParentHandle
	Local $hTVItem[2] = [ $aElems[$iIdx][4] ], $hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $aElems[$iIdx][4] )[0]
	While $hParent
		$hTVItem[1] = $hTVItem[0]
		$hTVItem[0] = $hParent
		; _GUICtrlTreeView_GetParentHandle
		$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParent )[0]
	WEnd

	; Delete 1st level elements (top windows)
	; _GUICtrlTreeView_GetItemParam()
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
	; _GUICtrlTreeView_GetFirstChild()
	Local $iWin, $hWin0, $hWin = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $aElems[0][4] )[0] ; $aElems[0][4] = $hDesktop
	While $hWin
		$hWin0 = $hWin
		; _GUICtrlTreeView_GetNextSibling()
		$hWin = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hWin )[0]
		If $hWin0 = $hTVItem[1] Then ContinueLoop
		; _GUICtrlTreeView_GetItemParam()
		DllStructSetData( $tItem, "hItem", $hWin0 )
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
		$iWin = DllStructGetData( $tItem, "Param" ) - 100000 ; Index in $aElems
		;_GUICtrlTreeView_BeginUpdate( $hTV )
		GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
		UIASpy_DelChildsElement( $iWin )
		GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
		;_GUICtrlTreeView_EndUpdate( $hTV )
	WEnd
EndFunc

Func UIASpy_DisplayHelpPage( $iData, $aData, $aDataIdx, $sHeader0, $sHeader1 )
	$bUIAHelp = True
	$fClipCopy = False
	$fCodePage = False
	$iElemDetails = $iData
	$aElemDetails = $aData
	$aElemIndex = $aDataIdx
	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	_GUICtrlListView_SetColumnWidth( $idLV, 0, 200 )
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth - ( WinGetClientSize( $hTV )[0] + 30 ) - 200 - 30 )
	_GUICtrlHeader_SetItemAlign( $hHeader, 0, 0 ) ; 0 = Text is left-aligned
	_GUICtrlHeader_SetItemText( $hHeader, 0, $sHeader0 )
	_GUICtrlHeader_SetItemText( $hHeader, 1, $sHeader1 )
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 ) ; Reset selected rows
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, $iElemDetails, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, 0, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
	UIASpy_ListView_SetColumn1Width()
EndFunc

Func UIASpy_UsageDetect()
	Local Static $aUsageAll = [ _
		[ "Detect element",                               "Element detection and navigation. Detection with", 0xFFFFE0, "", "" ], _
		[ "",                                             "mouse and F1 - F4. Navigation with F7 - F8." ], _
		[ "",                                             "" ], _
		[ "Help topics",                                  "Double-click or right-click to make topic visible.", 0xE8E8E8 ], _
		[ "",                                             "Mouse/keyboard", "", 0xE8E8E8, 8 ], _
		[ "",                                             "Main menu", "", 0xE8E8E8, 21 ], _
		[ "",                                             "Function keys F1 - F4", "", 0xE8E8E8, 26 ], _
		[ "",                                             "Function keys F7 - F8", "", 0xE8E8E8, 61 ], _
		[ "Mouse/keyboard",                               "", 0xE8E8E8 ], _
		[ "F1 - F4",                                      "Element detection: Place the mouse cursor over an" ], _
		[ "",                                             "element and press F1 - F4." ], _
		[ "F1",                                           "Update direct childs of element." ], _
		[ "F2",                                           "Update direct childs of parent." ], _
		[ "F3",                                           "Update all childs of element." ], _
		[ "F4",                                           "Update all childs of parent." ], _
		[ "",                                             "" ], _
		[ "F7 - F8",                                      "Navigate up/down along path of parents/childs. The" ], _
		[ "",                                             "mouse is NOT used with F7 or F8." ], _
		[ "F7",                                           "Navigate to parent element." ], _
		[ "F8",                                           "Navigate to child element." ], _
		[ "",                                             "" ], _
		[ "Main menu",                                    "", 0xE8E8E8 ], _
		[ "Detect element and show rectangle",            "Turn on/off both element detection and red rectangle." ], _
		[ "Detect UI Automation element",                 "Turn on/off element detection with F1 - F4." ], _
		[ "Show help page",                               "Shows this help page." ], _
		[ "",                                             "" ], _
		[ "Function keys F1 - F4",                        "Detect element under mouse.", 0xE8E8E8 ], _
		[ "F1 - F4",                                      "Place mouse cursor over an element and press F1 - F4." ], _
		[ "F1",                                           "Update direct childs of element." ], _
		[ "F2",                                           "Update direct childs of parent." ], _
		[ "F3",                                           "Update all childs of element." ], _
		[ "F4",                                           "Update all childs of parent." ], _
		[ "",                                             "" ], _
		[ "F1 and F3",                                    "Detects the element under the mouse, all parents to" ], _
		[ "",                                             "Desktop, and either direct childs (F1) or all childs (F3)." ], _
		[ "F2 and F4",                                    "Detects the element under the mouse, navigates to the" ], _
		[ "",                                             "parent element, detects all other parents to Desktop, and" ], _
		[ "",                                             "detects either direct childs (F2) or all childs (F4) of the" ], _
		[ "",                                             "initial parent." ], _
		[ "",                                             "" ], _
		[ "F2 and F4",                                    "Because F2 and F4 first navigates to the parent element," ], _
		[ "",                                             "they are convenient to use when it's difficult to identify" ], _
		[ "",                                             "the parent element." ], _
		[ "",                                             "An example is an application top window. It can often" ], _
		[ "",                                             "only be identified on the edge around the window. It's" ], _
		[ "",                                             "easier to place the mouse cursor over the title bar and" ], _
		[ "",                                             "press F2." ], _
		[ "",                                             "Another example is a context menu. It can often only be" ], _
		[ "",                                             "identified on a thin edge around the menu. It's easier to" ], _
		[ "",                                             "place the mouse cursor over a menu item and press F2." ], _
		[ "",                                             "" ], _
		[ "F1 and F2",                                    "Calculates detail information for the elements. F1 and F2" ], _
		[ "",                                             "detects direct (1st level) childs of the element only. This" ], _
		[ "",                                             "is a limited number of elements, and therefore it's pos-" ], _
		[ "",                                             "sible to calculate detail information for the elements." ], _
		[ "F3 and F4",                                    "Does not calculate detail info. Detail info is calculated" ], _
		[ "",                                             "when an element is selected in the treeview. F3 and F4" ], _
		[ "",                                             "detects all childs of the element. This may be a very large" ], _
		[ "",                                             "number of elements. Therefore, it's not possible to" ], _
		[ "",                                             "calculate detail information for the elements." ], _
		[ "",                                             "" ], _
		[ "Function keys F7 - F8",                        "Navigate up/down along path of parents/childs. The", 0xE8E8E8 ], _
		[ "",                                             "mouse is NOT used with F7 or F8." ], _
		[ "F7",                                           "Navigate to parent element." ], _
		[ "F8",                                           "Navigate to child element." ], _
		[ "",                                             "" ], _
		[ "F7 initialization",                            "F7 initializes navigation with F7/F8. The elements from" ], _
		[ "",                                             "selected treeview element up along the path of parents" ], _
		[ "",                                             "to Desktop are calculated and stored." ], _
		[ "Reset F7/F8 navigation",                       "As soon as a treeview element is selected in other ways" ], _
		[ "",                                             "than with F7/F8, navigation is reset and the stored ele-" ], _
		[ "",                                             "ments are deleted. Press F7 to start a new navigation." ], _
		[ "F8",                                           "F8 has no effect unless a navigation is initialized with F7." ] ]

	Local Static $iUsageIdx = UBound( $aUsageAll ), $aUsageIdx[$iUsageIdx], $bDone = False
	If Not $bDone Then
		$bDone = True
		For $i = 0 To $iUsageIdx - 1
			$aUsageIdx[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUsageIdx
	$iElemDetails = $iUsageIdx
	$aElemDetails = $aUsageAll
	UIASpy_FillListView( "Topic", "Description", 225 )
EndFunc

Func UIASpy_UsageLeft()
	Local Static $aUsageAll = [ _
		[ "Left pane",                                    "The left pane is a treeview that initially lists open programs", 0xFFFFE0, "", "" ], _
		[ "",                                             "and windows. Generally, the left pane shows UI Automation" ], _
		[ "",                                             "elements represented as treeview items." ], _
		[ "",                                             "" ], _
		[ "Help topics",                                  "Double-click or right-click to make topic visible.", 0xE8E8E8 ], _
		[ "",                                             "Mouse/keyboard", "", 0xE8E8E8, 9 ], _
		[ "",                                             "Main menu", "", 0xE8E8E8, 16 ], _
		[ "",                                             "Context menu", "", 0xE8E8E8, 29 ], _
		[ "",                                             "" ], _
		[ "Mouse/keyboard",                               "Click a treeview item or use up/down arrows to select an item and", 0xE8E8E8 ], _
		[ "",                                             "update the right pane listview." ], _
		[ "",                                             "Click the expand/collapse bitmap or use left/right arrows to ex-" ], _
		[ "",                                             "pand or collapse a treeview item." ], _
		[ "",                                             "Double-click or press Enter to recalculate and update direct childs" ], _
		[ "",                                             "of a treeview element." ], _
		[ "",                                             "Right-click to open context menu." ], _
		[ "Main menu",                                    "", 0xE8E8E8 ], _
		[ "Update top windows",                           "Updates the list of open programs and windows. Same as double-" ], _
		[ "",                                             "click/Enter on Desktop item." ], _
		[ "Delete top windows",                           "Deletes the list of open programs and windows. Desktop isn't" ], _
		[ "",                                             "deleted." ], _
		[ "Use short window names",                       "Removes a (possible long) path in main and top window names." ], _
		[ "Show element rectangle",                       "Draws a red rectangle around the selected UI Automation element." ], _
		[ "Only visible elements",                        "Only draw the red rectangle for visible UI Automation elements." ], _
		[ "",                                             "If the selected element is completely covered by another window," ], _
		[ "",                                             "then the red rectangle will not be drawn on top of this other" ], _
		[ "",                                             "window." ], _
		[ "Show help page",                               "Shows this help page." ], _
		[ "",                                             "" ], _
		[ "Context menu",                                 "Note that the Desktop element has no context menu.", 0xE8E8E8 ], _
		[ "Show UI Automation element",                   "Activates the application window and draws a red rectangle" ], _
		[ "",                                             "around the element." ], _
		[ "Update current element info",                  "Updates listview detail information for current element." ], _
		[ "Update direct childs of element",              "Recalculates and updates direct childs of the element. Calculates" ], _
		[ "",                                             "detail information for the elements." ], _
		[ "Update all childs of element",                 "Recalculates and updates all childs of the element. Does not" ], _
		[ "",                                             "calculate detail info. Detail info is calculated when an element" ], _
		[ "",                                             "is selected in the treeview." ], _
		[ "Delete element and all childs",                "Deletes the treeview element and all child elements." ], _
		[ "Delete all 1st level elements",                "Deletes the list of open programs and windows except current." ], _
		[ "",                                             "Open programs and windows are listed as elements in first level" ], _
		[ "",                                             "of the treeview." ], _
		[ "Create element tree structure",                "Copies the structure of the element subtree to clipboard." ], _
		[ "",                                             "The procedure to copy the entire application top window subtree" ], _
		[ "",                                             "structure to clipboard is:" ], _
		[ "",                                             "1. Update all childs of element" ], _
		[ "",                                             "2. Create element tree structure" ], _
		[ "Show help page",                               "Shows this help page." ] ]

	Local Static $iUsageIdx = UBound( $aUsageAll ), $aUsageIdx[$iUsageIdx], $bDone = False
	If Not $bDone Then
		$bDone = True
		For $i = 0 To $iUsageIdx - 1
			$aUsageIdx[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUsageIdx
	$iElemDetails = $iUsageIdx
	$aElemDetails = $aUsageAll
	UIASpy_FillListView( "Topic", "Description", 175 )
EndFunc

Func UIASpy_UsageRight( $iRow = 0 )
	Local Static $aUsageAll = [ _
		[ "Right pane",                                   "The right pane is a listview that displays information.", 0xFFFFE0, "", "" ], _
		[ "",                                             "Various types of information is displayed in different" ], _
		[ "",                                             "listview pages." ], _
		[ "",                                             "" ], _
		[ "Help topics",                                  "Double-click or right-click to make topic visible.", 0xE8E8E8 ], _
		[ "",                                             "Listview pages", "", 0xE8E8E8, 13 ], _
		[ "",                                             "Detail info types", "", 0xE8E8E8, 28 ], _
		[ "",                                             "Mouse", "", 0xE8E8E8, 42 ], _
		[ "",                                             "Main menu", "", 0xE8E8E8, 44 ], _
		[ "",                                             "Context menu", "", 0xE8E8E8, 50 ], _
		[ "",                                             "Sample code creation", "", 0xE8E8E8, 67 ], _
		[ "",                                             "Forum example", "", 0xE8E8E8, 107 ], _
		[ "",                                             "Colors", "", 0xE8E8E8, 120 ], _
		[ "Listview pages",                               "", 0xE8E8E8 ], _
		[ "Detail info page",                             "Detail information for the selected treeview element." ], _
		[ "",                                             "The information is grouped in different types of info." ], _
		[ "",                                             "The Detail info page is the default listview page." ], _
		[ "",                                             "Click the treeview element to show the page." ], _
		[ "Element tree structure",                       "Displays the subtree structure for the selected element." ], _
		[ "Listview code page",                           "Displays sample code generated through the Detail info" ], _
		[ "",                                             "listview page or the Sample code main menu." ], _
		[ "Sample code intermediate pages",               "Some of the Sample code menu items creates inter-" ], _
		[ "",                                             "mediate listview pages to support sample code creation." ], _
		[ "Listview help pages",                          "Displays help pages through the Help main menu and" ], _
		[ "",                                             "through Show help page menu items in bottom of other" ], _
		[ "",                                             "main menus and context menus." ], _
		[ "Return to Detail info page",                   "Click a treeview element." ], _
		[ "",                                             "" ], _
		[ "Detail info types",                            "Detail information for the selected treeview element", 0xE8E8E8 ], _
		[ "",                                             "is grouped in different types of information." ], _
		[ "Treeview Element",                             "Shows the element control type and name or class name." ], _
		[ "Element Properties (identification)",          "Properties that can be used for element identification." ], _
		[ "Element Properties (session unique)",          "Identification of specific element among several occurrences." ], _
		[ "Element Properties (information)",             "Properties that shows information for an element." ], _
		[ "Element Properties (has/is info)",             "Displays True/False information for an element." ], _
		[ "Control Patterns (element actions)",           "Patterns that can be used to perform element actions." ], _
		[ "Control Pattern Properties",                   "Properties for available control pattern objects." ], _
		[ "Control Pattern Methods",                      "Methods for available control pattern objects." ], _
		[ "Parents from Desktop",                         "Lists all parent elements from the Desktop element." ], _
		[ "Parent to child index",                        "Child index relative to parent. For elements grouped in" ], _
		[ "",                                             "lists." ], _
		[ "",                                             "" ], _
		[ "Mouse",                                        "Double-click to open Microsoft documentation.", 0xE8E8E8 ], _
		[ "",                                             "Right-click to open context menu." ], _
		[ "Main menu",                                    "", 0xE8E8E8 ], _
		[ "Show default and unavailable properties",      "Displays all information in the Detail info listview page." ], _
		[ "",                                             "This includes default properties and unavailable proper-" ], _
		[ "",                                             "ties and methods." ], _
		[ "Show help page",                               "Shows this help page." ], _
		[ "",                                             "" ], _
		[ "Context menu",                                 "All listview pages and all listview rows (except completely", 0xE8E8E8 ], _
		[ "",                                             "empty rows) opens a context menu on right-click. The" ], _
		[ "",                                             "menu may vary depending on listview page and row." ], _
		[ "Create sample code",                           "Creates sample code." ], _
		[ "",                                             "Displays sample code." ], _
		[ "",                                             "Copies code to clipboard." ], _
		[ "Copy to sample code",                          "Copies selected rows to sample code as comments." ], _
		[ "",                                             "Displays sample code in the Code page." ], _
		[ "",                                             "Copies code to clipboard." ], _
		[ "Clear sample code",                            "Clears all sample code." ], _
		[ "",                                             "Does not clear the clipboard." ], _
		[ "Open Microsoft docu",                          "Opens Microsoft documentation." ], _
		[ "Open Forum example",                           "Opens Forum post with example." ], _
		[ "Copy selected items",                          "Copies text in selected items to clipboard." ], _
		[ "Copy all items",                               "Copies text in all items to clipboard." ], _
		[ "Show help page",                               "Shows this help page." ], _
		[ "",                                             "" ], _
		[ "Sample code creation",                         "See ""Sample code creation"" section in UIASpy thread.", 0xE8E8E8, 0xE8E8E8, "https://www.autoitscript.com/forum/index.php?showtopic=196833" ], _
		[ "",                                             "Sample code creation in the Detail info listview page." ], _
		[ "",                                             "Select one or more rows in a single section and right" ], _
		[ "",                                             "click a selected row to create sample code through" ], _
		[ "",                                             "the context menu. The sample code is displayed in the" ], _
		[ "",                                             "listview code page and copied to clipboard. Click the" ], _
		[ "",                                             "treeview element to show the Detail info listview page." ], _
		[ "Sample code creation steps",                   "Create UI Automation initial code." ], _
		[ "",                                             "Create condition and find application window." ], _
		[ "",                                             "Create condition and find control in window." ], _
		[ "",                                             "Get information about windows and controls." ], _
		[ "",                                             "Create pattern objects to perform actions." ], _
		[ "",                                             "Get information related to pattern objects." ], _
		[ "",                                             "Perform actions with pattern object methods." ], _
		[ "",                                             "Add a Sleep() statement if necessary." ], _
		[ "",                                             "(Wait for the action to finish.)" ], _
		[ "Initial code",                                 "Create complete script and function header or only" ], _
		[ "",                                             "$oUIAutomation and $oDesktop objects." ], _
		[ "",                                             "Can only be done through the Sample code main menu.", 0x000000, 0xE8E8E8, "Sample code|23" ], _
		[ "Window/control",                               "Use Element Properties (identification) and Element" ], _
		[ "",                                             "Properties (session unique) sections to create sample" ], _
		[ "",                                             "code to identify and find a window/control." ], _
		[ "",                                             "These two sections are the only ones where you can" ], _
		[ "",                                             "select rows from more than one section." ], _
		[ "Properties",                                   "Get property info in Element Properties (information)" ], _
		[ "",                                             "and Element Properties (has/is info) sections." ], _
		[ "",                                             "Because a section can only be used for one purpose," ], _
		[ "",                                             "it's not possible to use the rows in the two sections" ], _
		[ "",                                             "above (used to find window/control) to extract the in-" ], _
		[ "",                                             "formation as properties. But this can be done through" ], _
		[ "",                                             "the Sample code main menu.", 0x000000, 0xE8E8E8, "Sample code|23" ], _
		[ "Patterns",                                     "Add code to create pattern (action) objects in Control" ], _
		[ "",                                             "Patterns (element actions) section." ], _
		[ "Pattern properties",                           "Get properties in Control Pattern Properties section." ], _
		[ "Pattern methods",                              "Add code to execute pattern methods in Control Pattern" ], _
		[ "",                                             "Methods section." ], _
		[ "",                                             "Correct the code and fill out parameters for the methods" ], _
		[ "",                                             "that takes input/output parameters. See Microsoft docu-" ], _
		[ "",                                             "mentation for a description of the parameters." ], _
		[ "",                                             "" ], _
		[ "Forum example",                                "Some properties, patterns and methods are marked with", 0xE8E8E8 ], _
		[ "",                                             "a yellow color in second column. This means that the" ], _
		[ "",                                             "right-click menu gives access to a Forum post with an" ], _
		[ "",                                             "example. Eg. there is an example that demonstrates how" ], _
		[ "",                                             "to use $UIA_ClassNamePropertyId to identify and find a" ], _
		[ "",                                             "window or control." ], _
		[ "",                                             "Some Forum posts demonstrates several properties, pat-" ], _
		[ "",                                             "terns or methods in the same post. These posts are pro-" ], _
		[ "",                                             "vided with a topic list at the top of the post. To the right" ], _
		[ "",                                             "of each topic in the list is highlighted in yellow color" ], _
		[ "",                                             "which properties, patterns or methods are demon-" ], _
		[ "",                                             "strated in the current topic." ], _
		[ "",                                             "" ], _
		[ "Colors",                                       "The meaning of the listview colors.",                          0xE8E8E8 ], _
		[ "Cyan",                                         "Listview group header.",                                       0xFFFFE0 ], _
		[ "",                                             "Double-click to open Microsoft documentation." ], _
		[ "Red",                                          "Listview group header.",                                       0xCCCCFF ], _
		[ "",                                             "For invalid elements, default properties and unavailable" ], _
		[ "",                                             "properties and methods." ], _
		[ "",                                             "Double-click to open Microsoft documentation." ], _
		[ "Gray",                                         "Listview subgroup header.",                                    0xE8E8E8 ], _
		[ "",                                             "Gray color in second column indicates available docu." ], _
		[ "",                                             "Double-click to open Microsoft documentation." ], _
		[ "Yellow",                                       "Yellow replaces gray in second column.",                       0xCCFFFF ], _
		[ "",                                             "Yellow indicates available example and possibly docu." ], _
		[ "",                                             "Double-click to open Microsoft documentation." ], _
		[ "",                                             "Right-click to open example." ], _
		[ "Doubts",                                       "If doubts about colors, right-click to see options." ] ]

	Local Static $iUsageIdx = UBound( $aUsageAll ), $aUsageIdx[$iUsageIdx], $bDone = False
	If Not $bDone Then
		$bDone = True
		For $i = 0 To $iUsageIdx - 1
			$aUsageIdx[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUsageIdx
	$iElemDetails = $iUsageIdx
	$aElemDetails = $aUsageAll
	UIASpy_FillListView( "Topic", "Description", 225 )
	If Not $iRow Then Return

	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iElemDetails-1, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iRow, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
EndFunc

Func UIASpy_UsageSample( $iRow = 0 )
	Local Static $aUsageAll = [ _
		[ "Sample code",                                  "See ""Sample code creation"" section in UIASpy thread.", 0xFFFFE0, 0xE8E8E8, "https://www.autoitscript.com/forum/index.php?showtopic=196833" ], _
		[ "",                                             "The Sample code main menu is used for Sample code" ], _
		[ "",                                             "creation. Much more code can be created through the" ], _
		[ "",                                             "menu than through the Detail info listview page." ], _
		[ "",                                             "In addition, the menu can be used to set Sample code" ], _
		[ "",                                             "options and for Sample code maintenance." ], _
		[ "",                                             "" ], _
		[ "Help topics",                                  "Double-click or right-click to make topic visible.", 0xE8E8E8 ], _
		[ "",                                             "Intermediate listview pages", "", 0xE8E8E8, 13 ], _
		[ "",                                             "Mouse", "", 0xE8E8E8, 20 ], _
		[ "",                                             "Main menu", "", 0xE8E8E8, 23 ], _
		[ "",                                             "Context menu", "", 0xE8E8E8, 87 ], _
		[ "",                                             "" ], _
		[ "Intermediate listview pages",                  "Menu items with a 3-point ending opens an intermediate", 0xE8E8E8 ], _
		[ "",                                             "listview page. These pages works in the same way as the" ], _
		[ "",                                             "Detail info listview page. Select one or more rows and" ], _
		[ "",                                             "right-click to create Sample code. Unlike the Detail info" ], _
		[ "",                                             "page, rows can be selected in several sections at once." ], _
		[ "",                                             "See ""Sample code creation"" in Right pane help page.", 0x000000, 0xE8E8E8, "Right pane|67" ], _
		[ "",                                             "" ], _
		[ "Mouse (intermediate listview pages)",          "Double-click to open Microsoft documentation.", 0xE8E8E8 ], _
		[ "",                                             "Right-click to open context menu." ], _
		[ "",                                             "" ], _
		[ "Main menu",                                    "The upper part of the menu through Sleep(1000) creates", 0xE8E8E8 ], _
		[ "",                                             "common Sample code." ], _
		[ "",                                             "Objects/methods creates objects and methods." ], _
		[ "",                                             "Code snippets... adds functions and code sections to" ], _
		[ "",                                             "solve tasks of a more specific nature." ], _
		[ "",                                             "If Check error is off in the Options menu, the Check error" ], _
		[ "",                                             "submenu can be used to add error checking as needed." ], _
		[ "",                                             "Corrections adds a list of necessary and optional cor-" ], _
		[ "",                                             "rections to the code." ], _
		[ "",                                             "Settings can be turned on/off in the Options menu." ], _
		[ "",                                             "The last part of the menu is about Sample code main-" ], _
		[ "",                                             "tenance." ], _
		[ "Initial code",                                 "" ], _
		[ "        Complete code",                        "Adds a complete script and function header to the code" ], _
		[ "",                                             "and creates Automation and Desktop objects." ], _
		[ "        Automation obj",                       "Creates the Automation object." ], _
		[ "        Desktop object",                       "Creates the Desktop object." ], _
		[ "Window/control",                               "Note that the two menu items below uses the same" ], _
		[ "",                                             "intermediate listview page." ], _
		[ "        Window/control...",                    "Generates code to identify and find a window/control in" ], _
		[ "",                                             "the same way as in the Detail info listview page." ], _
		[ "        Application window...",                "Generates code to identify and find the application top" ], _
		[ "",                                             "window through the FindAll() method. Requires the" ], _
		[ "",                                             "UIA_Functions.au3 UDF." ], _
		[ "",                                             "Note that this technique can be used for application top" ], _
		[ "",                                             "windows only. This corresponds to first-level windows in" ], _
		[ "",                                             "the left pane treeview." ], _
		[ "Properties...",                                "Get element properties." ], _
		[ "Patterns...",                                  "Create pattern (action) objects." ], _
		[ "Pattern props...",                             "Get pattern properties." ], _
		[ "Pattern methods...",                           "Execute pattern methods." ], _
		[ "Sleep( 1000 )",                                "A Sleep statement is often required after a pattern" ], _
		[ "------------------",                           "method is executed." ], _
		[ "Objects/methods",                              "Submenu to create objects and methods." ], _
		[ "        Create UIA objects...",                "Creates UI Automation objects." ], _
		[ "        --------------------------------",     "" ], _
		[ "        Automation object methods...",         "Creates Automation object methods." ], _
		[ "        Element object methods...",            "Creates Element object methods." ], _
		[ "        Other object methods...",              "Creates other object methods." ], _
		[ "Code snippets...",                             "Generates functions and code sections to solve tasks of" ], _
		[ "",                                             "a more specific nature. Some of the functions requires" ], _
		[ "----------------",                             "the UIA_Functions.au3 UDF." ], _
		[ "Check error",                                  "Add error checking as needed if Check error is off." ], _
		[ "        Object err",                           "Error checking for objects." ], _
		[ "        Pointer err",                          "Error checking for pointers." ], _
		[ "        Pattern err",                          "Error checking for pattern methods." ], _
		[ "        Elem array err",                       "Error checking for element array objects." ], _
		[ "Corrections",                                  "Adds a list of necessary and optional corrections to" ], _
		[ "----------------",                             "the code." ], _
		[ "Options",                                      "" ], _
		[ "        Ignore case",                          "Default is case-sensitive string conditions. Turn on" ], _
		[ "",                                             "Ignore case to use case-insensitive string conditions." ], _
		[ "        Check error",                          "As default general error checking is turned on." ], _
		[ "        Pattern err",                          "As default pattern method error checking is turned off." ], _
		[ "----------------",                             "" ], _
		[ "Undo code",                                    "Simple Undo code feature." ], _
		[ "Redo code",                                    "Simple Redo code feature." ], _
		[ "----------------",                             "" ], _
		[ "Show code",                                    "Displays code in the listview code page and copies code" ], _
		[ "",                                             "to clipboard." ], _
		[ "Clear code",                                   "Clears all sample code. Does not clear the clipboard." ], _
		[ "----------------",                             "" ], _
		[ "Show help page",                               "Shows this help page." ], _
		[ "",                                             "" ], _
		[ "Context menu (intermediate pages)",            "All intermediate listview pages and all listview rows", 0xE8E8E8 ], _
		[ "",                                             "(except completely empty rows) opens a context menu" ], _
		[ "",                                             "on right-click. The menu may vary depending on listview" ], _
		[ "",                                             "page and row." ], _
		[ "Create sample code",                           "Creates sample code." ], _
		[ "",                                             "Displays sample code." ], _
		[ "",                                             "Copies code to clipboard." ], _
		[ "Copy to sample code",                          "Copies selected rows to sample code as comments." ], _
		[ "",                                             "Displays sample code in the Code page." ], _
		[ "",                                             "Copies code to clipboard." ], _
		[ "Clear sample code",                            "Clears all sample code." ], _
		[ "",                                             "Does not clear the clipboard." ], _
		[ "Open Microsoft docu",                          "Opens Microsoft documentation." ], _
		[ "Open Forum example",                           "Opens Forum post with example." ], _
		[ "Copy selected items",                          "Copies text in selected items to clipboard." ], _
		[ "Copy all items",                               "Copies text in all items to clipboard." ], _
		[ "Show help page",                               "Shows this help page." ] ]

	Local Static $iUsageIdx = UBound( $aUsageAll ), $aUsageIdx[$iUsageIdx], $bDone = False
	If Not $bDone Then
		$bDone = True
		For $i = 0 To $iUsageIdx - 1
			$aUsageIdx[$i] = $i
		Next
	EndIf

	$aElemIndex = $aUsageIdx
	$iElemDetails = $iUsageIdx
	$aElemDetails = $aUsageAll
	UIASpy_FillListView( "Topic", "Description", 225 )
	If Not $iRow Then Return

	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iElemDetails-1, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iRow, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
EndFunc
