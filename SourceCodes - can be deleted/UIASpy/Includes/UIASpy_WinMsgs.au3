#include-once

Func WM_NOTIFY( $hWnd, $iMsg, $wParam, $lParam )
	Local $tNMHDR = DllStructCreate( $tagNMHDR, $lParam ), $dwDrawStage
	Switch HWnd( DllStructGetData( $tNMHDR, "hWndFrom" ) )
		Case $hLV
			Local $iLVItem
			Local Static $tText = DllStructCreate( "wchar Text[4096]" ), $pText = DllStructGetPtr( $tText )
			Switch DllStructGetData( $tNMHDR, "Code" )
				Case $LVN_GETDISPINFOW
					Local $tNMLVDISPINFO = DllStructCreate( $tagNMLVDISPINFO, $lParam )
					If Not BitAND( DllStructGetData( $tNMLVDISPINFO, "Mask" ), $LVIF_TEXT ) Then Return 0
					If DllStructGetData($tNMLVDISPINFO,"Item") = -1 Or DllStructGetData($tNMLVDISPINFO,"SubItem") = -1 Then Return 0
					Local $sItem = $aElemDetails[$aElemIndex[DllStructGetData($tNMLVDISPINFO,"Item")]][DllStructGetData($tNMLVDISPINFO,"SubItem")]
					DllStructSetData( $tText, 1, $sItem )
					DllStructSetData( $tNMLVDISPINFO, "Text", $pText )
					DllStructSetData( $tNMLVDISPINFO, "TextMax", StringLen( $sItem ) )
					Return 0

				Case $NM_CUSTOMDRAW
					Local $tNMLVCUSTOMDRAW = DllStructCreate( $tagNMLVCUSTOMDRAW, $lParam )
					$dwDrawStage = DllStructGetData( $tNMLVCUSTOMDRAW, "dwDrawStage" )
					Switch $dwDrawStage                     ; Specifies the drawing stage
						Case $CDDS_PREPAINT                   ; Before the paint cycle begins
							If $fClipCopy Then Return 0
							Return $CDRF_NOTIFYITEMDRAW         ; Notify the parent window before an item is painted
						Case $CDDS_ITEMPREPAINT               ; Before an item is painted
							$iLVItem = DllStructGetData($tNMLVCUSTOMDRAW,"dwItemSpec")
							If $aElemDetails[$aElemIndex[$iLVItem]][2] Or $aElemDetails[$aElemIndex[$iLVItem]][3] Then _
								Return $CDRF_NOTIFYSUBITEMDRAW    ; Notify the parent window of any subitem-related drawing operations
							Return $CDRF_DODEFAULT              ; The item draws itself through default drawing
						Case $CDDS_ITEMPREPAINT+$CDDS_SUBITEM ; Before a subitem is painted
							Local $iColor
							Switch DllStructGetData( $tNMLVCUSTOMDRAW, "iSubItem" )
								Case 0 ; Column 0
									$iColor = $aElemDetails[$aElemIndex[DllStructGetData($tNMLVCUSTOMDRAW,"dwItemSpec")]][2]
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $iColor ? $iColor : 0xFFFFFF ) ; Back color
								Case 1 ; Column 1
									$iColor = $aElemDetails[$aElemIndex[DllStructGetData($tNMLVCUSTOMDRAW,"dwItemSpec")]][3]
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $iColor ? $iColor : 0xFFFFFF ) ; Back color
							EndSwitch
							Return $CDRF_NEWFONT                ; $CDRF_NEWFONT must be returned after changing font or colors
					EndSwitch

				Case $NM_DBLCLK
					$iLVItem = UIASpy_ListView_HitTest()
					If $iLVItem = -1 Then Return
					Switch $aElemDetails[$aElemIndex[0]][0]
						; Tree, code pages
						Case "0"
						; Detail info page
						Case "Treeview Element"
							If  BitAND( $aElems[$iTVSelIdx][8], 2 ) _           ; Valid elem info
							And $aElemDetails[$aElemIndex[$iLVItem]][4] Then _  ; URL in column 4
								GUICtrlSendToDummy( $idLVDblClick, $iLVItem )
						; Sample code pages
						Case "Element Properties (identification, Sample code)", _
						     "Control Patterns (element actions, Sample code)", _
						     "Control Pattern Properties (Sample code)", _
						     "Control Pattern Methods (Sample code)", _
						     "UI Automation objects", "UI Automation object", "UI Element object", "TextRange", _
						     "Code Snippets (Sample code)"
							If $aElemDetails[$aElemIndex[$iLVItem]][4] Then _   ; URL in column 4
								GUICtrlSendToDummy( $idLVDblClick, $iLVItem )
						; Help pages
						Case "UI Automation Controls (elements)", _
						     "UI Automation Patterns (actions)"
							If $aElemDetails[$aElemIndex[$iLVItem]][4] Then _   ; URL in column 4
								GUICtrlSendToDummy( $idLVDblClick, $iLVItem )
						; Use of UIASpy
						Case "Detect element", "Left pane", _
						     "Right pane", "Sample code"
							If ( $iLVItem < 4 Or $iLVItem > 13 ) And _
							   $aElemDetails[$aElemIndex[$iLVItem]][4] Then     ; Help page|row or URL in column 4
								GUICtrlSendToDummy( $idLVDblClick, $iLVItem )
							ElseIf $aElemDetails[$aElemIndex[$iLVItem]][4] Then ; Row no. in column 4
								GUICtrlSendToDummy( $idLVDblClick, $iLVItem )
							EndIf
					EndSwitch

				Case $NM_RCLICK
					$iLVItem = UIASpy_ListView_HitTest()
					If $iLVItem = -1 Then Return
					Switch $aElemDetails[$aElemIndex[0]][0]
						; Tree, code pages
						Case "0"
							GUICtrlSendToDummy( $idLVRClick, $iLVItem )
						; Detail info page
						Case "Treeview Element"
							If BitAND( $aElems[$iTVSelIdx][8], 2 ) Then _ ; Valid elem info
								GUICtrlSendToDummy( $idLVRClick, $iLVItem )
						; Sample code pages
						Case "Element Properties (identification, Sample code)", _
						     "Control Patterns (element actions, Sample code)", _
						     "Control Pattern Properties (Sample code)", _
						     "Control Pattern Methods (Sample code)", _
						     "UI Automation objects", "UI Automation object", "UI Element object", "TextRange", _
								 "Code Snippets (Sample code)"
							GUICtrlSendToDummy( $idLVRClick, $iLVItem )
						; Help pages
						Case "UI Automation Controls (elements)", _
						     "UI Automation Patterns (actions)"
							GUICtrlSendToDummy( $idLVRClick, $iLVItem )
						; Use of UIASpy
						Case "Detect element", "Left pane", _
						     "Right pane", "Sample code"
							GUICtrlSendToDummy( $idLVRClick, $iLVItem )
					EndSwitch
			EndSwitch

		Case $hTV
			Local Static $hHighLight = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", _WinAPI_GetSysColor( $COLOR_HIGHLIGHT ) )[0]
			Local Static $hRedSel = DllCall( "gdi32.dll", "handle", "CreateSolidBrush", "int", 0x0000FF )[0] ; BGR ; _WinAPI_CreateSolidBrush
			Local Static $iIdx
			Local $tItem, $tTreeView
			Switch DllStructGetData( $tNMHDR, "Code" )
				Case $NM_CUSTOMDRAW
					Local $tNMTVCUSTOMDRAW = DllStructCreate( $tagNMTVCUSTOMDRAW, $lParam )
					$dwDrawStage = DllStructGetData( $tNMTVCUSTOMDRAW, "DrawStage" )
					Switch $dwDrawStage                ; Holds a value that specifies the drawing stage
						Case $CDDS_PREPAINT              ; Before the paint cycle begins
							Return $CDRF_NOTIFYITEMDRAW    ; Notify the parent window of any item-related drawing operations
						Case $CDDS_ITEMPREPAINT          ; Before painting an item
							If BitAND( DllStructGetData( $tNMTVCUSTOMDRAW, "ItemState" ), $CDIS_SELECTED ) Then _
								Return $CDRF_NOTIFYPOSTPAINT ; Notify the parent window after drawing an item
							$iIdx = DllStructGetData( $tNMTVCUSTOMDRAW, "ItemParam" ) - 100000
							If $iIdx <> -100000 And Not BitAND( $aElems[$iIdx][8], 1 ) Then Return $CDRF_DODEFAULT
							DllStructSetData( $tNMTVCUSTOMDRAW, "ClrTextBk", 0xCCCCFF )
							Return $CDRF_NEWFONT           ; $CDRF_NEWFONT must be returned after changing font or colors
						Case $CDDS_ITEMPOSTPAINT         ; After painting an item
							$iIdx = DllStructGetData( $tNMTVCUSTOMDRAW, "ItemParam" ) - 100000
							; _GUICtrlTreeView_DisplayRectEx
							Local $tRect = DllStructCreate( $tagRECT )
							Local $r = @AutoItX64 ? DllStructSetData( DllStructCreate( "ptr", DllStructGetPtr( $tRect ) ), 1, $aElems[$iIdx][4] ) : DllStructSetData( $tRect, "Left", $aElems[$iIdx][4] )
							DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMRECT, "wparam", 1, "struct*", $tRect )
							; Item background color and mode, item text
							Local $hDC = DllStructGetData( $tNMTVCUSTOMDRAW, "HDC" )
							DllCall( "user32.dll", "int", "FillRect", "handle", $hDC, "struct*", $tRect, "handle", BitAND( $aElems[$iIdx][8], 1 ) ? $hRedSel : $hHighLight ) ; _WinAPI_FillRect
							DllCall( "gdi32.dll", "int", "SetBkMode", "handle", $hDC, "int", $TRANSPARENT ) ; _WinAPI_SetBkMode
							DllCall( "gdi32.dll", "int", "SetTextColor", "handle", $hDC, "int", 0xFFFFFF ) ; _WinAPI_SetTextColor
							DllStructSetData( $tRect, "Left", DllStructGetData( $tRect, "Left" ) + 2 )
							DllStructSetData( $tRect, "Top",  DllStructGetData( $tRect, "Top"  ) + 2 )
							DllCall( "user32.dll", "int", "DrawTextW", "handle", $hDC, "wstr", $aElems[$iIdx][2], "int", -1, "struct*", $tRect, "uint", $DT_SINGLELINE ) ; _WinAPI_DrawText
							Return $CDRF_NEWFONT           ; $CDRF_NEWFONT must be returned after changing font or colors
					EndSwitch

				Case $NM_DBLCLK
					GUICtrlSendToDummy( $idTVDblClick, $iIdx )
					Return 1 ; Suppress default expand/collapse

				Case $NM_RCLICK
					; _GUICtrlTreeView_HitTestEx()
					Local $tPOINT = _WinAPI_GetMousePos( True, $hTV )
					Local $tHitTest = DllStructCreate( $tagTVHITTESTINFO )
					DllStructSetData( $tHitTest, "X", DllStructGetData( $tPOINT, "X" ) )
					DllStructSetData( $tHitTest, "Y", DllStructGetData( $tPOINT, "Y" ) )
					DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_HITTEST, "wparam", 0, "struct*", $tHitTest )
					If BitAnd( DllStructGetData( $tHitTest, "Flags" ), $TVHT_ONITEMLABEL ) Then
						; _GUICtrlTreeView_GetItemParam()
						$tItem = DllStructCreate( $tagTVITEMEX )
						DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
						DllStructSetData( $tItem, "hItem", DllStructGetData( $tHitTest, "Item" ) )
						DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
						GUICtrlSendToDummy( $idTVRClick, DllStructGetData( $tItem, "Param" ) - 100000 )
						Return 0 ; Suppress native context menu
					EndIf

				Case $TVN_ITEMEXPANDINGW
					If Not $idTVExpand Then Return 0
					$tTreeView = DllStructCreate( $tagNMTREEVIEW, $lParam )
					$iIdx = DllStructGetData( $tTreeView, "NewParam" ) - 100000
					If Not $aElems[$iIdx][5] Then GUICtrlSendToDummy( $idTVExpand, $iIdx )

				Case $TVN_SELCHANGEDW
					$tTreeView = DllStructCreate( $tagNMTREEVIEW, $lParam )
					If BitAND( DllStructGetData( $tTreeView, "NewState" ), $TVIS_SELECTED ) Then
						$iIdx = DllStructGetData( $tTreeView, "NewParam" ) - 100000
						GUICtrlSendToDummy( $idTVSelect, $iIdx )
						$iNavigate = 0
					EndIf
			EndSwitch
	EndSwitch

	Return $GUI_RUNDEFMSG
	#forceref $hWnd, $iMsg, $wParam, $r
EndFunc

Func UIASpy_ListView_HitTest()
	Local Static $tPoint = DllStructCreate($tagPOINT), $tTest = DllStructCreate($tagLVHITTESTINFO)

	Local $iMode = Opt("MouseCoordMode", 1), $aPos = MouseGetPos()
	DllStructSetData($tPoint, "X", $aPos[0])
	DllStructSetData($tPoint, "Y", $aPos[1])
	DllCall("user32.dll", "bool", "ScreenToClient", "hwnd", $hLV, "struct*", $tPoint)
	Opt("MouseCoordMode", $iMode)

	DllStructSetData($tTest, "X", DllStructGetData($tPoint, "X"))
	DllStructSetData($tTest, "Y", DllStructGetData($tPoint, "Y"))
	Return GUICtrlSendMsg($idLV, $LVM_HITTEST, 0, DllStructGetPtr($tTest))
EndFunc

Func WM_SIZING( $hWnd, $iMsg, $wParam, $lParam )
	Switch $hWnd
		Case $hGui
			MoveControls()
	EndSwitch
	Return $GUI_RUNDEFMSG
	#forceref $iMsg, $wParam, $lParam
EndFunc

Func WM_GETMINMAXINFO( $hWnd, $iMsg, $wParam, $lParam )
	Switch $hWnd
		Case $hGui
			Local $tMINMAXINFO = DllStructCreate( "int;int;int;int;int;int;int;int;int;int", $lParam )
			DllStructSetData( $tMINMAXINFO, 7, 300 ) ; Min width ; Minimum GUI size
			DllStructSetData( $tMINMAXINFO, 8, 150 ) ; Min height
	EndSwitch
	Return $GUI_RUNDEFMSG
	#forceref $iMsg, $wParam, $lParam
EndFunc

; ListView message handler function
Func ListViewFunc( $hWnd, $iMsg, $wParam, $lParam )
	If $HDN_BEGINTRACKW = DllStructGetData( DllStructCreate( $tagNMHEADER, $lParam ), "Code" ) Then Return 1
	Return $GUI_RUNDEFMSG
	#forceref $hWnd, $iMsg, $wParam
EndFunc

; Header message handler function
Func HeaderFunc( $hWnd, $iMsg, $wParam, $lParam )
	Return 1
	#forceref $hWnd, $iMsg, $wParam, $lParam
EndFunc
