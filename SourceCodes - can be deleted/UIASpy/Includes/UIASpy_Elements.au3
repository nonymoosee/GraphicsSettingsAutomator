#include-once
#include "UIA_Constants.au3"
#include "UIASpy_Arrays.au3"

Global $sCLSIDCUIAutomation, $sIIDIUIAutomation, $dtagIUIAutomation, $sIIDIUIAutomationElement, $dtagIUIAutomationElement
UIASpy_WindowsMode( @OSVersion )

Global $oUIAutomation = ObjCreateInterface( $sCLSIDCUIAutomation, $sIIDIUIAutomation, $dtagIUIAutomation )

Global $bShortWindowNames = True, $fClipCopy = False, $fCodePage = False, $bUIAHelp = False, $iCntElems

Global $aElemDetails, $iElemDetails, $aElemIndex[490], $bElemDetailsAll = False

Global $aElems[110000][10], $iElems = 0
; $aElems columns
; ---------------
;  0  $pElement    ; Pointer to UIElement
;  1  $oElement    ; UI Automation element object
;  2  $sElement    ; Control name + $UIA_NamePropertyId or $UIA_ClassNamePropertyId
;  3  $hElement    ; Window handle if available, $UIA_NativeWindowHandlePropertyId
;  4  $hTVItem     ; Item handle where the element is inserted in treeview
;  5  $bChilds     ; True if child elements are calculated, else false
;  6  $iChild      ; Child element index relative to parent element
;  7  $aInfo       ; Detail element info calculated by UIASpy_ElemInfo
;  8  $iState      ; State info: Bit 0 set => Invalid element
;                                Bit 1 set => Valid info calc

Global $aDelElems[110000], $iDelElems = 0

Func UIASpy_WindowsMode( $sWin )
	$bW8 = False
	$bW81 = False
	$bW10 = False
	Switch $sWin
		Case "WIN_8"
			$bW8 = True
			$sCLSIDCUIAutomation = $sCLSID_CUIAutomation8
			$sIIDIUIAutomation = $sIID_IUIAutomation2
			$dtagIUIAutomation = $dtag_IUIAutomation2
			$sIIDIUIAutomationElement = $sIID_IUIAutomationElement2
			$dtagIUIAutomationElement = $dtag_IUIAutomationElement2
		Case "WIN_81"
			$bW8 = True
			$bW81 = True
			$sCLSIDCUIAutomation = $sCLSID_CUIAutomation8
			$sIIDIUIAutomation = $sIID_IUIAutomation3
			$dtagIUIAutomation = $dtag_IUIAutomation3
			$sIIDIUIAutomationElement = $sIID_IUIAutomationElement3
			$dtagIUIAutomationElement = $dtag_IUIAutomationElement3
		Case "WIN_10"
			$bW8 = True
			$bW81 = True
			$bW10 = True
			$sCLSIDCUIAutomation = $sCLSID_CUIAutomation8
			$sIIDIUIAutomation = $sIID_IUIAutomation5
			$dtagIUIAutomation = $dtag_IUIAutomation5
			$sIIDIUIAutomationElement = $sIID_IUIAutomationElement8
			$dtagIUIAutomationElement = $dtag_IUIAutomationElement8
		Case Else
			$sCLSIDCUIAutomation = $sCLSID_CUIAutomation
			$sIIDIUIAutomation = $sIID_IUIAutomation
			$dtagIUIAutomation = $dtag_IUIAutomation
			$sIIDIUIAutomationElement = $sIID_IUIAutomationElement
			$dtagIUIAutomationElement = $dtag_IUIAutomationElement
	EndSwitch
EndFunc

Func UIASpy_Windows()
	$iElems = 0
	$iDelElems = 0

	; Desktop (root element)
	Local $pDesktop, $oDesktop
	$oUIAutomation.GetRootElement( $pDesktop )
	$aElems[$iElems][1] = ObjCreateInterface( $pDesktop, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
	If Not IsObj( $aElems[$iElems][1] ) Then Return
	$oDesktop = $aElems[$iElems][1]

	; RawViewWalker object for childs
	Local $pRawViewWalkerChilds, $oRawViewWalkerChilds
	$oUIAutomation.RawViewWalker( $pRawViewWalkerChilds )
	$oRawViewWalkerChilds = ObjCreateInterface( $pRawViewWalkerChilds, $sIID_IUIAutomationTreeWalker, $dtag_IUIAutomationTreeWalker )

	Local $hElement, $iControl, $sElement
	$oDesktop.GetCurrentPropertyValue( $UIA_NativeWindowHandlePropertyId, $hElement )
	$oDesktop.GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
	$oDesktop.GetCurrentPropertyValue( $UIA_NamePropertyId, $sElement )
	If Not $sElement Then $oDesktop.GetCurrentPropertyValue( $UIA_ClassNamePropertyId, $sElement )
	$sElement = $aUIASpy_Controls[$iControl-50000][0] & ( $sElement ? ": " & $sElement : "" )

	Local $pUIChild = 0
	$oRawViewWalkerChilds.GetFirstChildElement( $oDesktop, $pUIChild )

	Local $hTVItem = _GUICtrlTreeView_Add( $hTV, 0, $sElement )
	_GUICtrlTreeView_SetChildren( $hTV, $hTVItem, $pUIChild ? True : False )
	_GUICtrlTreeView_SetItemParam( $hTV, $hTVItem, $iElems+100000 ) ; Index in $aElems

	$aElems[$iElems][0] = $pDesktop
	;$aElems[$iElems][1] = $oDesktop
	$aElems[$iElems][2] = $sElement
	$aElems[$iElems][3] = $hElement
	$aElems[$iElems][4] = $hTVItem
	$aElems[$iElems][5] = True
	$aElems[$iElems][7] = UIASpy_ElemInfo( $iElems )
	$aElems[$iElems][8] = 2 ; Valid info calc
	$iElems += 1

	; Desktop windows
	If $pUIChild Then
		UIASpy_AddChilds( $iElems - 1, False, True )
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $hTVItem )
	EndIf
EndFunc

Func UIASpy_AddChilds( $iIdxParent, $bRecursive = False, $bDesktop = False )
	Local $oParent = $aElems[$iIdxParent][1], $hTVParent = $aElems[$iIdxParent][4]

	; RawViewWalker object
	Local $pRawViewWalker, $oRawViewWalker
	$oUIAutomation.RawViewWalker( $pRawViewWalker )
	$oRawViewWalker = ObjCreateInterface( $pRawViewWalker, $sIID_IUIAutomationTreeWalker, $dtag_IUIAutomationTreeWalker )

	; RawViewWalker object for childs
	Local $pRawViewWalkerChilds, $oRawViewWalkerChilds
	$oUIAutomation.RawViewWalker( $pRawViewWalkerChilds )
	$oRawViewWalkerChilds = ObjCreateInterface( $pRawViewWalkerChilds, $sIID_IUIAutomationTreeWalker, $dtag_IUIAutomationTreeWalker )

	; Reuse deleted rows in $aElems
	Local $iIdx = $iDelElems ? $aDelElems[$iDelElems-1] : $iElems

	; First child element
	Local $pUIElement, $oUIElement
	$oRawViewWalker.GetFirstChildElement( $oParent, $pUIElement )
	$aElems[$iIdx][1] = ObjCreateInterface( $pUIElement, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
	$oUIElement = $aElems[$iIdx][1]

	Local $hElement, $iControl, $sElement, $pUIChild, $hTVItem, $iChild = 0
	Local $tInsert = DllStructCreate( $tagTVINSERTSTRUCT )
	DllStructSetData( $tInsert, "Parent", $hTVParent )
	DllStructSetData( $tInsert, "InsertAfter", $TVI_LAST )
	DllStructSetData( $tInsert, "Mask", $TVIF_TEXT )
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_HANDLE+$TVIF_CHILDREN+$TVIF_PARAM )

	While IsObj( $oUIElement )
		$oUIElement.GetCurrentPropertyValue( $UIA_NativeWindowHandlePropertyId, $hElement )
		$oUIElement.GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $iControl )
		$oUIElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sElement )
		If Not $sElement Then $oUIElement.GetCurrentPropertyValue( $UIA_ClassNamePropertyId, $sElement )
		If $bDesktop And $sElement Then
			If $sElement = "UIASpy - UI Automation Spy Tool" Then
				$oRawViewWalker.GetNextSiblingElement( $oUIElement, $pUIElement )
				$aElems[$iIdx][1] = ObjCreateInterface( $pUIElement, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
				$oUIElement = $aElems[$iIdx][1]
				ContinueLoop
			EndIf
			If $bShortWindowNames Then
				Local $aNames = StringRegExp( $sElement, ".\:\\.*(\\)(.+)", 2 ) ; 2 = $STR_REGEXPARRAYFULLMATCH
				If UBound( $aNames ) = 3 Then $sElement = $aNames[2]
			EndIf
		EndIf
		$sElement = $aUIASpy_Controls[$iControl-50000][0] & ( $sElement ? ": " & $sElement : "" )

		; _GUICtrlTreeView_AddChild()
		Local $iBuffer = 2 * StringLen( $sElement ) + 2
		Local $tBuffer = DllStructCreate( "wchar Text[" & $iBuffer & "]" )
		DllStructSetData( $tBuffer, "Text", $sElement )
		DllStructSetData( $tInsert, "Text", DllStructGetPtr( $tBuffer ) )
		DllStructSetData( $tInsert, "TextMax", $iBuffer )
		$hTVItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_INSERTITEMW, "wparam", 0, "struct*", $tInsert )[0]

		$pUIChild = 0
		$oRawViewWalkerChilds.GetFirstChildElement( $oUIElement, $pUIChild )

		; _GUICtrlTreeView_SetChildren()
		; _GUICtrlTreeView_SetItemParam()
		DllStructSetData( $tItem, "hItem", $hTVItem )
		DllStructSetData( $tItem, "Children", $pUIChild ? True : False )
		DllStructSetData( $tItem, "Param", $iIdx+100000 ) ; Index in $aElems
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_SETITEMW, "wparam", 0, "struct*", $tItem )

		$aElems[$iIdx][0] = $pUIElement
		;$aElems[$iIdx][1] = $oUIElement
		$aElems[$iIdx][2] = $sElement
		$aElems[$iIdx][3] = $hElement
		$aElems[$iIdx][4] = $hTVItem
		$aElems[$iIdx][5] = False
		If Not $bDesktop Then $aElems[$iIdx][6] = $iChild
		If Not $bRecursive Then
			$aElems[$iIdx][7] = UIASpy_ElemInfo( $iIdx )
			$aElems[$iIdx][8] = 2 ; Valid info calc
		EndIf
		If $iDelElems Then
			$iDelElems -= 1
		Else
			$iElems += 1
		EndIf
		$iChild += 1

		$iCntElems += 1

		If $bRecursive And $pUIChild Then UIASpy_AddChilds( $iIdx, $bRecursive, $bDesktop )

		; Reuse deleted rows in $aElems
		$iIdx = $iDelElems ? $aDelElems[$iDelElems-1] : $iElems

		$oRawViewWalker.GetNextSiblingElement( $oUIElement, $pUIElement )
		$aElems[$iIdx][1] = ObjCreateInterface( $pUIElement, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
		$oUIElement = $aElems[$iIdx][1]
	WEnd

	$aElems[$iIdxParent][5] = True
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_EXPAND, "wparam", $TVE_EXPAND, "handle", $hTVParent )

	If $bRecursive Then ToolTip( $iCntElems )
EndFunc

Func UIASpy_DelChilds( $iIdx )
	Local $aChilds = UIASpy_GetAllChilds( $iIdx ), $iChilds = $aChilds[1]
	$aChilds = $aChilds[0]

	; Delete all childs
	For $i = $iChilds - 1 To 0 Step -1
		$iIdx = $aChilds[$i]
		$aElems[$iIdx][1] = 0  ; Delete $oElement
		$aElems[$iIdx][3] = 0  ; Delete $hElement
		$aElems[$iIdx][6] = "" ; Delete child idx
		$aElems[$iIdx][7] = 0  ; Delete element info
		$aElems[$iIdx][8] = 0  ; Delete state info
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_DELETEITEM, "wparam", 0, "handle", $aElems[$iIdx][4] )
		$aDelElems[$iDelElems] = $iIdx
		$iDelElems += 1
	Next
EndFunc

Func UIASpy_DelChildsElement( $iIdx )
	Local $aChilds = UIASpy_GetAllChilds( $iIdx ), $iChilds = $aChilds[1], $iIdx0 = $iIdx
	$aChilds = $aChilds[0]

	; Delete all childs
	For $i = $iChilds - 1 To 0 Step -1
		$iIdx = $aChilds[$i]
		$aElems[$iIdx][1] = 0  ; Delete $oElement
		$aElems[$iIdx][3] = 0  ; Delete $hElement
		$aElems[$iIdx][6] = "" ; Delete child idx
		$aElems[$iIdx][7] = 0  ; Delete element info
		$aElems[$iIdx][8] = 0  ; Delete state info
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_DELETEITEM, "wparam", 0, "handle", $aElems[$iIdx][4] )
		$aDelElems[$iDelElems] = $iIdx
		$iDelElems += 1
	Next

	; Delete element
	$aElems[$iIdx0][1] = 0  ; Delete $oElement
	$aElems[$iIdx0][3] = 0  ; Delete $hElement
	$aElems[$iIdx0][6] = "" ; Delete child idx
	$aElems[$iIdx0][7] = 0  ; Delete element info
	$aElems[$iIdx0][8] = 0  ; Delete state info
	DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_DELETEITEM, "wparam", 0, "handle", $aElems[$iIdx0][4] )
	$aDelElems[$iDelElems] = $iIdx0
	$iDelElems += 1
EndFunc

Func UIASpy_CopyStructure( $iIdx )
	Local $sSpaces = "                                                                                                    " & _
	                 "                                                                                                    " & _
	                 "                                                                                                    " & _
	                 "                                                                                                    " ; 400 spaces
	Local $aChilds = UIASpy_GetAllChilds( $iIdx ), $iChilds = $aChilds[1], $aTree[$iChilds+1][2], $iTree[$iChilds+1]
	$aChilds = $aChilds[0]

	; Item level, _GUICtrlTreeView_Level()
	Local $sTree = $aElems[$iIdx][2], $iItemLevel = 0
	Local $hItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $aElems[$iIdx][4] )[0]
	While $hItem
		$hItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
		$iItemLevel += 1
	WEnd
	$aTree[0][0] = 0
	$aTree[0][1] = $sTree
	$iTree[0] = 0
	$sTree = "0000    " & $sTree

	Local $iLevel, $s
	For $i = 0 To $iChilds - 1
		$iLevel = 0
		$iIdx = $aChilds[$i]
		$hItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $aElems[$iIdx][4] )[0]
		While $hItem
			$hItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
			$iLevel += 1
		WEnd
		$s = StringLeft( $sSpaces, 4 * ( $iLevel - $iItemLevel ) ) & $aElems[$iIdx][2]
		$sTree &= @CRLF & StringFormat( "%04i    ", $i+1 ) & $s
		$aTree[$i+1][0] = $i+1
		$aTree[$i+1][1] = $s
		$iTree[$i+1] = $i+1
	Next
	$fClipCopy = 1
	$aElemIndex = $iTree
	$aElemDetails = $aTree
	$iElemDetails = $iChilds+1
	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	_GUICtrlListView_SetColumnWidth( $idLV, 0, 55 )
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth - ( WinGetClientSize( $hTV )[0] + 30 ) - 55 - 30 )
	_GUICtrlHeader_SetItemAlign( $hHeader, 0, 1 ) ; 1 = Text is right-aligned
	_GUICtrlHeader_SetItemText( $hHeader, 0, "#" )
	_GUICtrlHeader_SetItemText( $hHeader, 1, "Element" )
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 ) ; Reset selected items
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, $iElemDetails, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, 0, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
	UIASpy_ListView_SetColumn1Width()
	ClipPut( $sTree )
EndFunc

Func UIASpy_CheckWindows()
	; First level childs
	; Find first non-existent window element
	Local $aChilds1[100], $iChilds1 = 0
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
	Local $iIdx, $hChild, $hParent = $aElems[0][4] ; Desktop
	$hChild = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $hParent )[0]
	While $hChild
		; _GUICtrlTreeView_GetItemParam()
		DllStructSetData( $tItem, "hItem", $hChild )
		DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
		$iIdx = DllStructGetData( $tItem, "Param" ) - 100000
		If $aElems[$iIdx][3] And Not BitAND( $aElems[$iIdx][8], 1 ) And Not WinExists( HWnd( $aElems[$iIdx][3] ) ) Then ExitLoop
		If Not BitAND( $aElems[$iIdx][8], 1 ) Then
			$aChilds1[$iChilds1] = $hChild
			$iChilds1 += 1
		EndIf
		$hChild = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hChild )[0]
	WEnd

	If Not $hChild Then
		If $iChilds1 Then
			; Second level childs
			For $i = 0 To $iChilds1 - 1
				$hChild = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $aChilds1[$i] )[0]
				While $hChild
					; _GUICtrlTreeView_GetItemParam()
					DllStructSetData( $tItem, "hItem", $hChild )
					DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
					$iIdx = DllStructGetData( $tItem, "Param" ) - 100000
					If $aElems[$iIdx][3] And Not BitAND( $aElems[$iIdx][8], 1 ) And Not WinExists( HWnd( $aElems[$iIdx][3] ) ) Then ExitLoop 2
					$hChild = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hChild )[0]
				WEnd
			Next
		EndIf
		If Not $hChild Then
			UIASpy_CheckElement( $iTVSelIdx )
			Return
		EndIf
	EndIf

	; Mark non-existent window element and all childs invalid
	$aElems[$iIdx][8] += 1 ; Mark window element invalid
	If Not $fClipCopy And $iIdx = $iTVSelIdx Then $aElemDetails[0][2] = 0xCCCCFF
	Local $aChilds = UIASpy_GetAllChilds( $iIdx ), $iChilds = $aChilds[1]
	$aChilds = $aChilds[0]
	; Mark all childs invalid
	For $i = 0 To $iChilds - 1
		$aElems[$aChilds[$i]][8] = BitOR( $aElems[$aChilds[$i]][8], 1 )
		If Not $fClipCopy And $aChilds[$i] = $iTVSelIdx Then $aElemDetails[0][2] = 0xCCCCFF
	Next
	DllCall( "user32.dll", "bool", "InvalidateRect", "hwnd", $hTV, "struct*", 0, "bool", False ) ; _WinAPI_InvalidateRect
	_GUICtrlListView_RedrawItems( $idLV, 0, 0 )
EndFunc

Func UIASpy_CheckElement( $iIdx )
	If Not ( $aElems[$iIdx][3] And Not WinExists( HWnd( $aElems[$iIdx][3] ) ) And Not BitAND( $aElems[$iIdx][8], 1 ) ) Then Return
	$aElems[$iIdx][8] += 1 ; Mark element invalid
	If Not $fClipCopy And $iIdx = $iTVSelIdx Then $aElemDetails[0][2] = 0xCCCCFF
	Local $aChilds = UIASpy_GetAllChilds( $iIdx ), $iChilds = $aChilds[1]
	$aChilds = $aChilds[0]
	; Mark all childs invalid
	For $i = 0 To $iChilds - 1
		$aElems[$aChilds[$i]][8] = BitOR( $aElems[$aChilds[$i]][8], 1 )
		If Not $fClipCopy And $aChilds[$i] = $iTVSelIdx Then $aElemDetails[0][2] = 0xCCCCFF
	Next
	DllCall( "user32.dll", "bool", "InvalidateRect", "hwnd", $hTV, "struct*", 0, "bool", False ) ; _WinAPI_InvalidateRect
	_GUICtrlListView_RedrawItems( $idLV, 0, 0 )
EndFunc

Func UIASpy_GetAllChilds( $iIdx )
	; Item level, _GUICtrlTreeView_Level()
	Local $hItem = $aElems[$iIdx][4], $hParItem, $iItemLevel = 0
	$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
	While $hParItem
		$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
		$iItemLevel += 1
	WEnd

	; Find all childs below $hItem
	Local $aChilds[110000], $iChilds = 0, $hNext, $hParent, $iLevel
	Local $tItem = DllStructCreate( $tagTVITEMEX )
	DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
	Do
		; _GUICtrlTreeView_GetNext()
		$hNext = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $hItem )[0]
		If Not $hNext Then $hNext = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hItem )[0]
		$hParent = $hItem
		While Not $hNext And $hParent
			$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParent )[0]
			If Not $hParent Then
				$hNext = 0
				ExitLoop
			EndIf
			$hNext = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_NEXT, "handle", $hParent )[0]
		WEnd
		$iLevel = 0
		$hItem = $hNext

		; _GUICtrlTreeView_Level()
		$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
		While $hParItem
			$iLevel += 1
			If $iLevel > $iItemLevel Then
				; _GUICtrlTreeView_GetItemParam()
				DllStructSetData( $tItem, "hItem", $hItem )
				DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
				$aChilds[$iChilds] = DllStructGetData( $tItem, "Param" ) - 100000
				$iChilds += 1
				ExitLoop
			EndIf
			$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
		WEnd
	Until $iLevel <= $iItemLevel

	Local $aChldInf = [ $aChilds, $iChilds ]
	Return $aChldInf
EndFunc
