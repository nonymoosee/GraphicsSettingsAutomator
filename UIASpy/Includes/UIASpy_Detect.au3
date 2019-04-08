#include-once

Global $iNavigate = 0, $tDetectPoint, $pDetectElement, $iDetectElemIdx = 0, $bFkeyDetect = False, $bDetectAndRect = True, $bShowElemRect = True, $bRedrawElemRect = False, $hRedrawWindow, $iRedrawElemTime, $hRedrawElemTimer, $aRedrawElemInfo, $iRepClearsRedraws

Global $fScale = 1.00 ; Display scaling: 1.00 - 4.00 (100% - 400%)

Func UIASpy_DetectElement( $iFkey )
	; $iFkey = 1 ; Update direct childs of element
	; $iFkey = 2 ; Update direct childs of parent
	; $iFkey = 3 ; Update all childs of element
	; $iFkey = 4 ; Update all childs of parent

	$bFkeyDetect = True

	; Get element under mouse
	Local $pUIElement, $oUIElement
	Local $x = MouseGetPos(0), $y = MouseGetPos(1)
	Local Static $tPoint = DllStructCreate( $tagPOINT )
	DllStructSetData( $tPoint, "X", $x )
	DllStructSetData( $tPoint, "Y", $y )
	$oUIAutomation.ElementFromPoint( $tPoint, $pUIElement )
	If Not $pUIElement Then Return

	; Element object
	$oUIElement = ObjCreateInterface( $pUIElement, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )

	; RawViewWalker object
	Local $pRawViewWalker, $oRawViewWalker
	$oUIAutomation.RawViewWalker( $pRawViewWalker )
	$oRawViewWalker = ObjCreateInterface( $pRawViewWalker, $sIID_IUIAutomationTreeWalker, $dtag_IUIAutomationTreeWalker )

	; Get parent elements
	Local $pUIParent, $aUIParents[100][2], $iUIParents = 0
	If $iFkey = 1 Or $iFkey = 3 Then
		; Detected element
		$aUIParents[$iUIParents][0] = $pUIElement
		$aUIParents[$iUIParents][1] = $oUIElement
		$iUIParents += 1
	EndIf
	; Parent elements
	$oRawViewWalker.GetParentElement( $oUIElement, $pUIParent )
	While $pUIParent
		$aUIParents[$iUIParents][0] = $pUIParent
		$aUIParents[$iUIParents][1] = ObjCreateInterface( $pUIParent, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
		$oRawViewWalker.GetParentElement( $aUIParents[$iUIParents][1], $pUIParent )
		$iUIParents += 1
	WEnd

	; Only Desktop is parent?
	If $iUIParents = 1 Then Return

	; UIASpy window?
	Local $sElement
	$aUIParents[$iUIParents-2][1].GetCurrentPropertyValue( $UIA_NamePropertyId, $sElement )
	If $sElement = "UIASpy - UI Automation Spy Tool" Then Return

	; Find first parent with
	; real bounding rectangle.
	Local $aRect, $iMin = 0
	If $iFkey = 2 Or $iFkey = 4 Then
		For $i = 0 To $iUIParents - 1
			$aUIParents[$i][1].GetCurrentPropertyValue( $UIA_BoundingRectanglePropertyId, $aRect )
			If IsArray( $aRect ) And $aRect[2] And $aRect[3] Then ExitLoop
		Next
		If Not IsArray( $aRect ) Then Return
		$iMin = $i
	EndIf

	; Reset F7-F8 navigation
	$iNavigate = 0

	; Clear prev elem rect
	If $bRedrawElemRect Then
		If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
		$bRedrawElemRect = False
		$hRedrawElemTimer = 0
		$hRedrawWindow = 0
		ClearElemRect()
	EndIf

	; Store element info
	$tDetectPoint = $tPoint
	$oUIAutomation.ElementFromPoint( $tPoint, $pDetectElement )

	; Get current windows
	; Level 1 in TV, level 0 is Desktop
	Local $aWins[100], $iWins = 0
	; _GUICtrlTreeView_GetItemParam()
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
	; _GUICtrlTreeView_GetFirstChild()
	Local $hWin = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $aElems[0][4] )[0] ; $aElems[0][4] = $hDesktop
	While $hWin
		; _GUICtrlTreeView_GetItemParam()
		DllStructSetData( $tItem, "hItem", $hWin )
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
		$aWins[$iWins] = DllStructGetData( $tItem, "Param" ) - 100000 ; Index in $aElems
		; _GUICtrlTreeView_GetNextSibling()
		$hWin = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hWin )[0]
		$iWins += 1
	WEnd

	; Does detected window exist as a TV-item
	Local $bIdentical               ; $aElems[$aWins[$i]][0] is the pointer to a current element that matches the window just below the Desktop
	For $i = 0 To $iWins - 1        ; $aUIParents[$iUIParents-2][0] is the pointer to the detected element that matches the window just below the Desktop
		$oUIAutomation.CompareElements( $aElems[$aWins[$i]][0], $aUIParents[$iUIParents-2][0], $bIdentical )
		If $bIdentical Then ExitLoop
	Next

	$idTVSelect = 0 ; Disable $idTVSelect
	; _GUICtrlTreeView_BeginUpdate( $hTV )
	GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )

	; If it does, delete TV-item
	If $bIdentical Then
		; Delete all childs of existing window
		UIASpy_DelChilds( $aWins[$i] )
		; Delete existing window
		$aElems[$aWins[$i]][1] = 0  ; Delete $oElement
		$aElems[$aWins[$i]][3] = 0  ; Delete $hElement
		$aElems[$aWins[$i]][6] = "" ; Delete child idx
		$aElems[$aWins[$i]][7] = 0  ; Delete element info
		$aElems[$aWins[$i]][8] = 0  ; Delete state info
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_DELETEITEM, "wparam", 0, "handle", $aElems[$aWins[$i]][4] )
		$aDelElems[$iDelElems] = $aWins[$i]
		$iDelElems += 1
	EndIf

	If $iFkey = 2 Or $iFkey = 4 Then _    ; First parent with
		$oUIElement = $aUIParents[$iMin][1] ; real bounding rect.

	; $tagTVINSERTSTRUCT structure
	Local $tInsert = DllStructCreate( $tagTVINSERTSTRUCT )
	DllStructSetData( $tInsert, "InsertAfter", $TVI_LAST )
	DllStructSetData( $tInsert, "Mask", $TVIF_TEXT )
	DllStructSetData( $tItem, "Mask", $TVIF_HANDLE+$TVIF_CHILDREN+$TVIF_PARAM )

	; Reuse deleted rows in $aElems
	Local $iIdx = $iDelElems ? $aDelElems[$iDelElems-1] : $iElems, $iIdxPar1, $iIdxPar2

	; Add elements to TreeView
	Local $hElement, $iControl, $pUIChild = 1, $hTVItem
	For $i = $iUIParents - 2 To $iMin Step -1
		$aUIParents[$i][1].GetCurrentPropertyValue( $UIA_NativeWindowHandlePropertyId, $hElement )
		$aUIParents[$i][1].GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
		$aUIParents[$i][1].GetCurrentPropertyValue( $UIA_NamePropertyId, $sElement )
		If Not $iControl Then ContinueLoop
		If $i = $iUIParents - 2 Then
			If $hElement Then $hRedrawWindow = HWnd( $hElement )
			If $sElement And $bShortWindowNames Then
				Local $aNames = StringRegExp( $sElement, ".\:\\.*(\\)(.+)", 2 ) ; 2 = $STR_REGEXPARRAYFULLMATCH
				If UBound( $aNames ) = 3 Then $sElement = $aNames[2]
			EndIf
		EndIf
		If Not $sElement Then $aUIParents[$i][1].GetCurrentPropertyValue( $UIA_ClassNamePropertyId, $sElement )
		$sElement = $aUIASpy_Controls[$iControl-50000][0] & ( $sElement ? ": " & $sElement : "" )

		; _GUICtrlTreeView_AddChild()
		Local $iBuffer = 2 * StringLen( $sElement ) + 2
		Local $tBuffer = DllStructCreate( "wchar Text[" & $iBuffer & "]" )
		DllStructSetData( $tBuffer, "Text", $sElement )
		DllStructSetData( $tInsert, "Parent", $i = $iUIParents - 2 ? $aElems[0][4] : $aElems[$iIdxPar1][4] )
		DllStructSetData( $tInsert, "Text", DllStructGetPtr( $tBuffer ) )
		DllStructSetData( $tInsert, "TextMax", $iBuffer )
		$hTVItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_INSERTITEMW, "wparam", 0, "struct*", $tInsert )[0]

		If $i = $iMin Then
			$pUIChild = 0
			$oRawViewWalker.GetFirstChildElement( $oUIElement, $pUIChild )
		EndIf

		; _GUICtrlTreeView_SetChildren()
		; _GUICtrlTreeView_SetItemParam()
		DllStructSetData( $tItem, "hItem", $hTVItem )
		DllStructSetData( $tItem, "Children", $pUIChild ? True : False )
		DllStructSetData( $tItem, "Param", $iIdx+100000 ) ; Index in $aElems
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )

		$aElems[$iIdx][0] = $aUIParents[$i][0]
		$aElems[$iIdx][1] = $aUIParents[$i][1]
		$aElems[$iIdx][2] = $sElement
		$aElems[$iIdx][3] = $hElement
		$aElems[$iIdx][4] = $hTVItem
		$aElems[$iIdx][5] = True
		$aElems[$iIdx][7] = UIASpy_ElemInfo( $iIdx )
		If Not IsArray( $aElems[$iIdx][7] ) Then ContinueLoop
		$aElems[$iIdx][8] = 2 ; Valid info calc
		$iIdxPar2 = $iIdxPar1
		$iIdxPar1 = $iIdx
		If $iDelElems Then
			$iDelElems -= 1
		Else
			$iElems += 1
		EndIf

		; Reuse deleted rows in $aElems
		$iIdx = $iDelElems ? $aDelElems[$iDelElems-1] : $iElems

		; Expand parent
		If $i = $iUIParents - 2 Then
			DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_EXPAND, "wparam", $TVE_EXPAND, "handle", $aElems[0][4] )
		Else
			DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_EXPAND, "wparam", $TVE_EXPAND, "handle", $aElems[$iIdxPar2][4] )
		EndIf
	Next

	; Index of detected item
	$iIdx = $iIdxPar1

	; Element/item childs
	If $pUIChild Then
		If $iFkey > 2 Then $iCntElems = 0
		UIASpy_AddChilds( $iIdx, $iFkey > 2 ? True : False )
		If $iFkey > 2 Then ToolTip("")
	EndIf

	; Make detected item visible
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $aElems[$iIdx][4] )

	; Set detected item selected
	; _GUICtrlTreeView_SetSelected( $hTV, _GUICtrlTreeView_GetSelection( $hTV ), False )
	DllStructSetData( $tItem, "Mask", $TVIF_STATE )
	DllStructSetData( $tItem, "hItem", DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CARET, "handle", 0 )[0] ) ; _GUICtrlTreeView_GetSelection
	DllStructSetData( $tItem, "State", 0 )
	DllStructSetData( $tItem, "StateMask", $TVIS_SELECTED )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )
	; _GUICtrlTreeView_SetSelected( $hTV, ( Item given by $iTVSelIdx ), False )
	DllStructSetData( $tItem, "hItem", $aElems[$iTVSelIdx][4] ) ; Item given by $iTVSelIdx
	DllStructSetData( $tItem, "State", 0 )
	DllStructSetData( $tItem, "StateMask", $TVIS_SELECTED )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )
	; _GUICtrlTreeView_SetSelected( $hTV, $aElems[$iIdx][4] )
	DllStructSetData( $tItem, "hItem", $aElems[$iIdx][4] )
	DllStructSetData( $tItem, "State", $TVIS_SELECTED )
	DllStructSetData( $tItem, "StateMask", BitOR( 1, $TVIS_SELECTED ) )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )

	; _GUICtrlTreeView_EndUpdate( $hTV )
	GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
	$idTVSelect = $idTVSelect0

	; Show element info
	$iDetectElemIdx = $iIdx
	GUICtrlSendToDummy( $idTVSelect, $iIdx )

	; Draw element rectangle
	If $bShowElemRect And $hRedrawWindow Then
		$oUIElement.GetCurrentPropertyValue( $UIA_BoundingRectanglePropertyId, $aRect )
		If IsArray( $aRect ) Then
			DrawElemRect( Round($aRect[0]*$fScale), Round(($aRect[0]+$aRect[2])*$fScale), Round($aRect[1]*$fScale), Round(($aRect[1]+$aRect[3])*$fScale) )
			ReDrawElemRectInit( $hRedrawWindow, Round($aRect[0]*$fScale), Round(($aRect[0]+$aRect[2])*$fScale), Round($aRect[1]*$fScale), Round(($aRect[1]+$aRect[3])*$fScale) )
		EndIf
	EndIf
EndFunc

Func UIASpy_NavigateElement( $iFkey )
	Local Static $aNavigate[100], $iNavigateIdx
	Local Static $tItem = DllStructCreate( $tagTVITEMEX )

	; Is initial navigation element deleted?
	If $iNavigate And Not IsObj( $aElems[$aNavigate[0]][1] ) Then
		$iNavigate = 0
		Return
	EndIf

	; New initial navigation element?
	For $i = 0 To $iNavigate - 1
		If IsObj( $aElems[$aNavigate[$i]][1] ) And $aElems[$aNavigate[$i]][4] = $aElems[$iTVSelIdx][4] Then ExitLoop
	Next
	; Store navigation elements
	If $i = $iNavigate Then
		If $iFkey = 8 Or Not $iTVSelIdx Then Return
		; Initial navigation element
		$iNavigate = 0
		$iNavigateIdx = 0
		$aNavigate[$iNavigate] = $iTVSelIdx
		$iNavigate += 1
		; Navigation elements through parents to Desktop
		Local $hItem = $aElems[$iTVSelIdx][4], $hParent
		DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
		; _GUICtrlTreeView_GetParentHandle
		$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
		While $hParent
			; _GUICtrlTreeView_GetItemParam()
			DllStructSetData( $tItem, "hItem", $hParent )
			DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
			$aNavigate[$iNavigate] = DllStructGetData($tItem,"Param")-100000
			$iNavigate += 1
			; _GUICtrlTreeView_GetParentHandle
			$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParent )[0]
		WEnd
	EndIf

	; Index of next navigation element
	If $iFkey = 7 And Not $iTVSelIdx Then Return
	If $iFkey = 7 And $iNavigateIdx = $iNavigate - 1 Then Return
	If $iFkey = 8 And $iNavigateIdx = 0 Then Return
	$iNavigateIdx += $iFkey = 7 ? 1 : -1
	Local $iIdx = $aNavigate[$iNavigateIdx]

	; Make navigation element visible
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $aElems[$iIdx][4] )

	; Set navigation element selected
	DllStructSetData( $tItem, "Mask", $TVIF_STATE )
	; _GUICtrlTreeView_SetSelected( $hTV, _GUICtrlTreeView_GetSelection( $hTV ), False )
	DllStructSetData( $tItem, "hItem", DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CARET, "handle", 0 )[0] ) ; _GUICtrlTreeView_GetSelection
	DllStructSetData( $tItem, "State", 0 )
	DllStructSetData( $tItem, "StateMask", $TVIS_SELECTED )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )
	; _GUICtrlTreeView_SetSelected( $hTV, ( Item given by $iTVSelIdx ), False )
	DllStructSetData( $tItem, "hItem", $aElems[$iTVSelIdx][4] ) ; Item given by $iTVSelIdx
	DllStructSetData( $tItem, "State", 0 )
	DllStructSetData( $tItem, "StateMask", $TVIS_SELECTED )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )
	; _GUICtrlTreeView_SetSelected( $hTV, $aElems[$iIdx][4] )
	DllStructSetData( $tItem, "hItem", $aElems[$iIdx][4] )
	DllStructSetData( $tItem, "State", $TVIS_SELECTED )
	DllStructSetData( $tItem, "StateMask", BitOR( 1, $TVIS_SELECTED ) )
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )

	; Show element info
	$iDetectElemIdx = $iIdx
	GUICtrlSendToDummy( $idTVSelect, $iIdx )
EndFunc

Func DrawElemRect( $iLeft, $iRight, $iTop, $iBottom, $iColor = 0x0000FF, $iPenWidth = 2 )
	Local $hDC = DllCall( "user32.dll", "handle", "GetWindowDC", "hwnd", 0 )[0]
	Local $hPen = DllCall( "gdi32.dll", "handle", "CreatePen", "int", $PS_SOLID, "int", $iPenWidth, "INT", $iColor )[0]
	DllCall( "gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hPen )

	$iLeft += $iPenWidth
	$iTop += $iPenWidth
	$iRight -= $iPenWidth
	$iBottom -= $iPenWidth

	;_WinAPI_DrawLine( $hDC, $iLeft,  $iTop,    $iRight, $iTop    )
	DllCall( "gdi32.dll", "bool", "MoveToEx", "handle", $hDC, "int", $iLeft, "int", $iTop, "ptr", 0 ) ; _WinAPI_MoveTo
	DllCall( "gdi32.dll", "bool", "LineTo", "handle", $hDC, "int", $iRight, "int", $iTop ) ; _WinAPI_LineTo
	;_WinAPI_DrawLine( $hDC, $iRight, $iTop,    $iRight, $iBottom )
	DllCall( "gdi32.dll", "bool", "MoveToEx", "handle", $hDC, "int", $iRight, "int", $iTop, "ptr", 0 ) ; _WinAPI_MoveTo
	DllCall( "gdi32.dll", "bool", "LineTo", "handle", $hDC, "int", $iRight, "int", $iBottom ) ; _WinAPI_LineTo
	;_WinAPI_DrawLine( $hDC, $iRight, $iBottom, $iLeft,  $iBottom )
	DllCall( "gdi32.dll", "bool", "MoveToEx", "handle", $hDC, "int", $iRight, "int", $iBottom, "ptr", 0 ) ; _WinAPI_MoveTo
	DllCall( "gdi32.dll", "bool", "LineTo", "handle", $hDC, "int", $iLeft, "int", $iBottom ) ; _WinAPI_LineTo
	;_WinAPI_DrawLine( $hDC, $iLeft,  $iBottom, $iLeft,  $iTop    )
	DllCall( "gdi32.dll", "bool", "MoveToEx", "handle", $hDC, "int", $iLeft, "int", $iBottom, "ptr", 0 ) ; _WinAPI_MoveTo
	DllCall( "gdi32.dll", "bool", "LineTo", "handle", $hDC, "int", $iLeft, "int", $iTop ) ; _WinAPI_LineTo

	DllCall( "gdi32.dll", "bool", "DeleteObject", "handle", $hPen )
	DllCall( "user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $hDC )
EndFunc

Func RedrawElemRectInit( $hWindow, $iLeft, $iRight, $iTop, $iBottom, $iColor = 0x0000FF, $iPenWidth = 2, $iRedrawTime = 250, $iClears = 2 )
	$bRedrawElemRect = True
	$hRedrawWindow = $hWindow
	Local $aInfo = [ $iLeft, $iRight, $iTop, $iBottom, $iColor, $iPenWidth ]
	$aRedrawElemInfo = $aInfo
	$hRedrawElemTimer = TimerInit()
	$iRedrawElemTime = $iRedrawTime
	$iRepClearsRedraws = $iClears
EndFunc

Func RedrawElemRect( ByRef $aInfo )
	DrawElemRect( $aInfo[0], $aInfo[1], $aInfo[2], $aInfo[3], $aInfo[4], $aInfo[5] )
	$hRedrawElemTimer = TimerInit()
EndFunc

Func ClearElemRect( $hWindow = 0 )
	If $iRepClearsRedraws Then _
		$iRepClearsRedraws -= 1
	If $hWindow Then
		DllCall( "user32.dll", "bool", "RedrawWindow", "hwnd", $hWindow, "struct*", 0, "handle", 0, "uint", $RDW_INVALIDATE+$RDW_ALLCHILDREN ) ; _WinAPI_RedrawWindow
		Return
	EndIf
	Local $aList = WinList()
	For $i = 1 To $aList[0][0]
		If $aList[$i][0] And $aList[$i][1] <> $hGui And BitAND( WinGetState( $aList[$i][1] ), 2 ) Then _ ; 2 = $WIN_STATE_VISIBLE
			DllCall( "user32.dll", "bool", "RedrawWindow", "hwnd", $aList[$i][1], "struct*", 0, "handle", 0, "uint", $RDW_INVALIDATE+$RDW_ALLCHILDREN ) ; _WinAPI_RedrawWindow
	Next
EndFunc
