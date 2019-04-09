#include-once
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiTreeView.au3>
#include <GuiMenu.au3>

; Windows version
Global $bW8, $bW81, $bW10

; GUI
Global $hGui, $iGuiWidth = 850, $iGuiHeight = 504

; ListView
Global $idLV, $hLV, $iLvCol0Width = 300, $hHeader, $idLVDblClick, $idLVRClick

; TreeView
Global $idTV, $hTV, $iTVSelIdx = 0, $idTVSelect, $idTVSelect0, $idTVExpand, $idTVDblClick, $idTVRClick

; SplitterBar
Global $idSplitterBar, $iSplitterWidth = 4, $iMinWidth = 100, $fTVWidthRatio

; Main menu and HotKeys
Global $idSampleMenu, $idFkey

#include "UIASpy_Menu.au3"
#include "UIASpy_Elements.au3"
#include "UIASpy_ElemInfo.au3"
#include "UIASpy_Detect.au3"
#include "UIASpy_Sample.au3"
#include "UIASpy_WinMsgs.au3"

#include "GUIRegisterMsg20.au3" ; https://www.autoitscript.com/forum/index.php?showtopic=195151

Func UIASpy_Gui()
	; Only one UIASpy at a time
	If WinExists( "[REGEXPTITLE:UIASpy . UI Automation Spy Tool;CLASS:AutoIt v3 GUI;]" ) Or _
     WinExists( "[REGEXPTITLE:UIASpy . UI Automation Spy Tool;CLASS:AutoIt v3;]" ) Then Return

	; Create GUI
	$hGui = GUICreate( "UIASpy - UI Automation Spy Tool", $iGuiWidth, $iGuiHeight, -1, -1, $GUI_SS_DEFAULT_GUI+$WS_MAXIMIZEBOX+$WS_SIZEBOX )
	Local $iWidth = Int( $iGuiWidth/3 ), $iHeight = $iGuiHeight

	; Create main menu
	; Detect element menu
	Local $idDetectMenu = GUICtrlCreateMenu( "Detect element" )
	CreateDetectMenu( $idDetectMenu )
	; Left pane menu
	Local $idLeftPane = GUICtrlCreateMenu( "Left pane" )
	GUICtrlCreateMenuItem( "Update top windows", $idLeftPane )
	GUICtrlCreateMenuItem( "Delete top windows", $idLeftPane )
	GUICtrlCreateMenuItem( "Use short window names", $idLeftPane )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "", $idLeftPane )
	Local $bOnlyVisibleElems = True
	GUICtrlCreateMenuItem( "Show element rectangle", $idLeftPane )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "Only visible elements", $idLeftPane )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "", $idLeftPane )
	GUICtrlCreateMenuItem( "Show help page", $idLeftPane )
	; Right pane menu
	Local $idRightPane = GUICtrlCreateMenu( "Right pane" )
	GUICtrlCreateMenuItem( "Show default and unavailable properties", $idRightPane )
	GUICtrlCreateMenuItem( "", $idRightPane )
	GUICtrlCreateMenuItem( "Show help page", $idRightPane )
	; Sample code menu
	Local $idSampleCodeFunc = 0
	$idSampleMenu = GUICtrlCreateMenu( "Sample code" )
	Local $idInitial = GUICtrlCreateMenu( "Initial code", $idSampleMenu )
	Local $idWinCtrl = GUICtrlCreateMenu( "Window/control", $idSampleMenu )
	GUICtrlCreateMenuItem( "Properties...",                $idSampleMenu )
	GUICtrlCreateMenuItem( "Patterns...",                  $idSampleMenu )
	GUICtrlCreateMenuItem( "Pattern props...",             $idSampleMenu )
	GUICtrlCreateMenuItem( "Pattern methods...",           $idSampleMenu )
	GUICtrlCreateMenuItem( "Sleep( 1000 )",                $idSampleMenu )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	Local $idObjects = GUICtrlCreateMenu( "Objects/methods", $idSampleMenu )
	GUICtrlCreateMenuItem( "Code snippets...",             $idSampleMenu )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	Local $idError = GUICtrlCreateMenu( "Check error", $idSampleMenu )
	GUICtrlCreateMenuItem( "Corrections",                  $idSampleMenu )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	Local $idSampleOptions = GUICtrlCreateMenu( "Options", $idSampleMenu )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	GUICtrlCreateMenuItem( "Undo code",                    $idSampleMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "Redo code",                    $idSampleMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	GUICtrlCreateMenuItem( "Show code",                    $idSampleMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "Clear code",                   $idSampleMenu )
	GUICtrlSetState( -1, $GUI_DISABLE )
	GUICtrlCreateMenuItem( "",                             $idSampleMenu )
	GUICtrlCreateMenuItem( "Show help page",               $idSampleMenu )
	; Initial code
	GUICtrlCreateMenuItem( "Complete code",                $idInitial )
	GUICtrlCreateMenuItem( "Automation obj",               $idInitial )
	GUICtrlCreateMenuItem( "Desktop object",               $idInitial )
	; Window/control
	GUICtrlCreateMenuItem( "Window/control...",            $idWinCtrl )
	GUICtrlCreateMenuItem( "Application window...",        $idWinCtrl )
	GUICtrlSetState( -1, $GUI_DISABLE )
	; Objects/methods
	GUICtrlCreateMenuItem( "Create UIA objects...",        $idObjects )
	GUICtrlCreateMenuItem( "",                             $idObjects )
	GUICtrlCreateMenuItem( "Automation object methods...", $idObjects )
	GUICtrlCreateMenuItem( "Element object methods...",    $idObjects )
	GUICtrlCreateMenuItem( "Other object methods...",      $idObjects )
	; Check error
	GUICtrlCreateMenuItem( "Object err",                   $idError )
	GUICtrlCreateMenuItem( "Pointer err",                  $idError )
	GUICtrlCreateMenuItem( "Pattern err",                  $idError )
	GUICtrlCreateMenuItem( "Elem array err",               $idError )
	; Sample code options
	GUICtrlCreateMenuItem( "Ignore case",                  $idSampleOptions )
	GUICtrlCreateMenuItem( "Check error",                  $idSampleOptions )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "Pattern err",                  $idSampleOptions )
	; Options menu
	Local $idOptionsMenu = GUICtrlCreateMenu( "Options" )
	Local $idDisplayMenu = GUICtrlCreateMenu( "Display", $idOptionsMenu )
	Local $idScaleMenu = GUICtrlCreateMenu( "Scale", $idDisplayMenu )
	GUICtrlCreateMenuItem( "100%", $idScaleMenu )
	GUICtrlSetState( -1, $GUI_CHECKED )
	GUICtrlCreateMenuItem( "125%", $idScaleMenu )
	GUICtrlCreateMenuItem( "150%", $idScaleMenu )
	GUICtrlCreateMenuItem( "175%", $idScaleMenu )
	GUICtrlCreateMenuItem( "200%", $idScaleMenu )
	GUICtrlCreateMenuItem( "225%", $idScaleMenu )
	GUICtrlCreateMenuItem( "250%", $idScaleMenu )
	GUICtrlCreateMenuItem( "275%", $idScaleMenu )
	GUICtrlCreateMenuItem( "300%", $idScaleMenu )
	GUICtrlCreateMenuItem( "325%", $idScaleMenu )
	GUICtrlCreateMenuItem( "350%", $idScaleMenu )
	GUICtrlCreateMenuItem( "375%", $idScaleMenu )
	GUICtrlCreateMenuItem( "400%", $idScaleMenu )
	GUICtrlCreateMenuItem( "",     $idScaleMenu )
	GUICtrlCreateMenuItem( "Help", $idScaleMenu )
	Local $idWindowsMenu = GUICtrlCreateMenu( "Windows", $idOptionsMenu )
	Local $idModeMenu = GUICtrlCreateMenu( "Mode", $idWindowsMenu )
	GUICtrlCreateMenuItem( "Windows 7",   $idModeMenu )
	GUICtrlCreateMenuItem( "Windows 8",   $idModeMenu )
	GUICtrlCreateMenuItem( "Windows 8.1", $idModeMenu )
	GUICtrlCreateMenuItem( "Windows 10",  $idModeMenu )
	GUICtrlCreateMenuItem( "",            $idModeMenu )
	GUICtrlCreateMenuItem( "Help",        $idModeMenu )
	Switch True
		Case $bW10
			GUICtrlSetState( $idModeMenu+4, $GUI_CHECKED )
		Case $bW81
			GUICtrlSetState( $idModeMenu+4, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+3, $GUI_CHECKED )
		Case $bW8
			GUICtrlSetState( $idModeMenu+4, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+3, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+2, $GUI_CHECKED )
		Case Else
			GUICtrlSetState( $idModeMenu+4, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+3, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+2, $GUI_DISABLE )
			GUICtrlSetState( $idModeMenu+1, $GUI_CHECKED )
	EndSwitch
	; Help menu
	Local $idHelpMenu = GUICtrlCreateMenu( "Help" )
	Local $idUsageMenu = GUICtrlCreateMenu( "Use of UIASpy", $idHelpMenu )
	Local $idUsageSubMenu = GUICtrlCreateMenu( "Use of UIASpy", $idUsageMenu )
	GUICtrlCreateMenuItem( "Detect element", $idUsageSubMenu )
	GUICtrlCreateMenuItem( "Left pane", $idUsageSubMenu )
	GUICtrlCreateMenuItem( "Right pane", $idUsageSubMenu )
	GUICtrlCreateMenuItem( "Sample code", $idUsageSubMenu )
	GUICtrlCreateMenuItem( "", $idUsageMenu )
	GUICtrlCreateMenuItem( "How to topics", $idUsageMenu )
	GUICtrlCreateMenuItem( "Browse AutoIt example", $idUsageMenu )
	GUICtrlCreateMenuItem( "UIASpy demo example, Notepad", $idUsageMenu )
	GUICtrlCreateMenuItem( "UIASpy demo examples, Sample code", $idUsageMenu )
	Local $idElemsObjs = GUICtrlCreateMenu( "Elements and Patterns", $idHelpMenu )
	GUICtrlCreateMenuItem( "UI Automation Controls (elements)", $idElemsObjs )
	GUICtrlCreateMenuItem( "UI Automation Patterns (actions)", $idElemsObjs )
	Local $idMsDocuMenu = GUICtrlCreateMenu( "Microsoft Documentation", $idHelpMenu )
	GUICtrlCreateMenuItem( "Windows Automation API", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "Client UI Automation Guide", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "Client UI Automation Reference", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "UI Automation Controls (elements)", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "UI Automation Patterns (actions)", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "Control Types and Supported Patterns", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "UI Automation object (main obj)", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "UI Automation Element object", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "UI Element Properties", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "Control Patterns (actions)", $idMsDocuMenu )
	GUICtrlCreateMenuItem( "Control Pattern Properties", $idMsDocuMenu )

	; Create TreeView
	$idTV = GUICtrlCreateTreeView( 0, 0, $iWidth-$iSplitterWidth/2, $iHeight, $GUI_SS_DEFAULT_TREEVIEW, $WS_EX_CLIENTEDGE )
	GUICtrlSetResizing( $idTV, $GUI_DOCKWIDTH+$GUI_DOCKTOP+$GUI_DOCKBOTTOM )
	$hTV = GUICtrlGetHandle( $idTV )
	; Item events
	$idTVSelect = GUICtrlCreateDummy()
	$idTVSelect0 = $idTVSelect
	$idTVExpand = GUICtrlCreateDummy()
	Local $idTVExpand0 = $idTVExpand
	$idTVDblClick = GUICtrlCreateDummy()
	; Enter key
	Local $idTVEnter = GUICtrlCreateDummy()
	Local $aAccelKeys = [ [ "{ENTER}", $idTVEnter ] ]
	GUISetAccelerators( $aAccelKeys )
	; Right click context Menu
	$idTVRClick = GUICtrlCreateDummy()
	Local $hTVItemPopupMenu = _GUICtrlMenu_CreatePopup()
	Local Enum $idShowElement = 200000, $idUpdateElementInfo, $idUpdateChildsOfElement, $idUpdateAllChildsOfElement, $idDeleteElement, $idDeleteTopElements, $idTreeStructure, $idTreeHelp
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Show UI Automation element", $idShowElement )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Update current element info", $idUpdateElementInfo )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Update direct childs of element", $idUpdateChildsOfElement )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Update all childs of element", $idUpdateAllChildsOfElement )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Delete element and all childs", $idDeleteElement )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Delete all 1st level elements", $idDeleteTopElements )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Create element tree structure", $idTreeStructure )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "", 0 )
	_GUICtrlMenu_AddMenuItem( $hTVItemPopupMenu, "Show help page", $idTreeHelp )

	; Create ListView
	$idLV = GUICtrlCreateListView( "", $iWidth+$iSplitterWidth-1, 0, $iGuiWidth-$iWidth-$iSplitterWidth/2+4, $iHeight, $LVS_OWNERDATA, $WS_EX_CLIENTEDGE )
	_GUICtrlListView_SetExtendedListViewStyle( GUICtrlGetHandle( $idLV ), $LVS_EX_DOUBLEBUFFER+$LVS_EX_FULLROWSELECT+$LVS_EX_GRIDLINES )
	GUICtrlSetResizing( $idLV, $GUI_DOCKTOP+$GUI_DOCKBOTTOM )
	; Add columns
	$hLV = GUICtrlGetHandle( $idLV )
	_GUICtrlListView_AddColumn( $hLV, "Property name", $iLvCol0Width )
	_GUICtrlListView_AddColumn( $hLV, "Property value", $iGuiWidth-$iWidth-$iSplitterWidth/2+4 - $iLvCol0Width - 30 )
	; ListView Header
	$hHeader = _GUICtrlListView_GetHeader( $idLV )
	; Double-click
	$idLVDblClick = GUICtrlCreateDummy()
	; Right click context Menu
	$idLVRClick = GUICtrlCreateDummy()

	; Create SplitterBar
	$idSplitterBar = GUICtrlCreateLabel( "", $iWidth-1, 0, $iSplitterWidth, $iHeight )
	GUICtrlSetResizing( $idSplitterBar, $GUI_DOCKWIDTH+$GUI_DOCKLEFT+$GUI_DOCKTOP+$GUI_DOCKBOTTOM )
	$fTVWidthRatio = ( $iGuiWidth / 3 - $iSplitterWidth / 2 ) / $iGuiWidth
	GUICtrlSetCursor( $idSplitterBar, 13 )

	; Message handlers
	GUIRegisterMsg( $WM_NOTIFY, "WM_NOTIFY" )
	GUIRegisterMsg( $WM_SIZING, "WM_SIZING" )
	GUIRegisterMsg( $WM_GETMINMAXINFO, "WM_GETMINMAXINFO" )

	; Subclass ListView and Header
	GUIRegisterMsg20( $hLV, $WM_NOTIFY, ListViewFunc )
	GUIRegisterMsg20( $hHeader, $WM_SETCURSOR, HeaderFunc )

	; Detect element under mouse with F1 - F4
	$idFkey = GUICtrlCreateDummy()
	For $i = 0 To 5
		HotKeySet( $aFuncKeys[$i][0], $aFuncKeys[$i][1] )
	Next

	; Get open windows
	UIASpy_Windows()

	; Desktop element info
	UIASpy_ShowElemInfo(0)

	; Desktop element rect
	UIASpy_ShowElement(0)

	; Show GUI
	GUISetState( @SW_SHOW, $hGui )
	MoveControls()

	Local $iMsg, $iIdx, $pElement, $bIdentical, $hCheckWindowsTimer = TimerInit(), $hF7F8Timer
	Local $iControls, $aControls, $aControlsIndex, $iPatterns, $aPatterns, $aPatternsIndex

	; Loop
	While 1
		; Redraw or clear element rectangle
		If $bRedrawElemRect And TimerDiff( $hRedrawElemTimer ) > ( $iRepClearsRedraws ? 100 : $iRedrawElemTime ) Then
			If $bFkeyDetect Or $bOnlyVisibleElems Then
				$oUIAutomation.ElementFromPoint( $tDetectPoint, $pElement )
				$oUIAutomation.CompareElements( $pDetectElement, $pElement, $bIdentical )
				If Not $bIdentical Then $bIdentical = UIASpy_ShowElement( $iTVSelIdx, False, $bOnlyVisibleElems )
			EndIf
			If $bIdentical Or ( Not $bFkeyDetect And Not $bOnlyVisibleElems ) Then
				If $iRepClearsRedraws Then ClearElemRect()
				RedrawElemRect( $aRedrawElemInfo )
			Else
				If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
				$bRedrawElemRect = False
				$hRedrawElemTimer = 0
				$iDetectElemIdx = 0
				$hRedrawWindow = 0
				ClearElemRect()
			EndIf
		EndIf

		; Check top windows, first TreeView level
		If TimerDiff( $hCheckWindowsTimer ) > 1250 Then
			UIASpy_CheckWindows()
			$hCheckWindowsTimer = TimerInit()
		EndIf

		; AutoIt messages
		$iMsg = GUIGetMsg()
		Switch $iMsg
			Case 0, $GUI_EVENT_MOUSEMOVE
				ContinueLoop

			; --- HotKey events ---

			Case $idFkey
				Local $iFkey = GUICtrlRead( $idFkey )
				If $iFkey < 5 Then
					UIASpy_DetectElement( $iFkey )
					; F1: Update direct childs of element
					; F2: Update direct childs of parent
					; F3: Update all childs of element
					; F4: Update all childs of parent
				Else
					If $hF7F8Timer And TimerDiff( $hF7F8Timer ) < 100 Then ContinueLoop
					UIASpy_NavigateElement( $iFkey )
					; F7: Navigate to parent element
					; F8: Navigate to child element
					$hF7F8Timer = TimerInit()
				EndIf

			; --- Menu events ---

			; All menu events
			Case $idDetectMenu+1 To $idMsDocuMenu+15
				Switch $iMsg
					; Detect element menu
					Case $idDetectMenu+1 To $idLeftPane-1
						Switch $iMsg
							Case $idDetectMenu+1 ; Detect element and show rectangle
								DetectFKeyEvents( 1, 0, $bDetectAndRect )
								$bDetectAndRect = Not $bDetectAndRect
								$bShowElemRect = $bDetectAndRect
								DetectFKeyEvents( $idDetectMenu+3, $idDetectMenu )
								GUICtrlSetState( $idDetectMenu+1, $bDetectAndRect ? $GUI_CHECKED : $GUI_UNCHECKED )
								GUICtrlSetState( $idLeftPane+5, $bShowElemRect ? $GUI_CHECKED : $GUI_UNCHECKED )
								If $bShowElemRect Then
									UIASpy_ShowElement( $iTVSelIdx, False, $bOnlyVisibleElems )
								Else
									If $bRedrawElemRect Then
										If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
										$bRedrawElemRect = False
										$hRedrawElemTimer = 0
										$iDetectElemIdx = 0
										$hRedrawWindow = 0
										ClearElemRect()
									EndIf
								EndIf
							Case $idDetectMenu+15 ; Show help page
								UIASpy_UsageDetect()
							Case Else
								DetectFKeyEvents( $iMsg, $idDetectMenu )
						EndSwitch

					; Left pane menu
					Case $idLeftPane+1 To $idLeftPane+8
						Switch $iMsg
							Case $idLeftPane+1 ; Update top windows
								$idTVExpand = 0 ; Disable $idTVExpand
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChilds( 0 )
								UIASpy_AddChilds( 0, False, True )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								$idTVExpand = $idTVExpand0

							Case $idLeftPane+2 ; Delete top windows
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChilds( 0 )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								$aElems[0][5] = False ; Recalc child elements on expand
								UIASpy_TreeView_ClickItem( $hTV, $aElems[0][4] )

							Case $idLeftPane+3 ; Use short window names
								$bShortWindowNames = Not $bShortWindowNames
								GUICtrlSetState( $iMsg, $bShortWindowNames ? $GUI_CHECKED : $GUI_UNCHECKED )
								$idTVExpand = 0 ; Disable $idTVExpand
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChilds( 0 )
								UIASpy_AddChilds( 0, False, True )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								$idTVExpand = $idTVExpand0

							Case $idLeftPane+5 ; Show element rectangle
								$bShowElemRect = Not $bShowElemRect
								GUICtrlSetState( $iMsg, $bShowElemRect ? $GUI_CHECKED : $GUI_UNCHECKED )
								If $bShowElemRect Then
									UIASpy_ShowElement( $iTVSelIdx, False, $bOnlyVisibleElems )
								Else
									If $bRedrawElemRect Then
										If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
										$bRedrawElemRect = False
										$hRedrawElemTimer = 0
										$iDetectElemIdx = 0
										$hRedrawWindow = 0
										ClearElemRect()
									EndIf
								EndIf
								If DetectFKeyEvents( 0, 0 ) = $bShowElemRect Then
									$bDetectAndRect = $bShowElemRect
									GUICtrlSetState( $idDetectMenu+1, $bDetectAndRect ? $GUI_CHECKED : $GUI_UNCHECKED )
								EndIf

							Case $idLeftPane+6 ; Only visible elements
								$bOnlyVisibleElems = Not $bOnlyVisibleElems
								GUICtrlSetState( $iMsg, $bOnlyVisibleElems ? $GUI_CHECKED : $GUI_UNCHECKED )
								If $bShowElemRect Then
									If $bRedrawElemRect Then
										If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
										$bRedrawElemRect = False
										$hRedrawElemTimer = 0
										$iDetectElemIdx = 0
										$hRedrawWindow = 0
										ClearElemRect()
									EndIf
									UIASpy_ShowElement( $iTVSelIdx, False, $bOnlyVisibleElems )
								Else
									If $bRedrawElemRect Then
										If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
										$bRedrawElemRect = False
										$hRedrawElemTimer = 0
										$iDetectElemIdx = 0
										$hRedrawWindow = 0
										ClearElemRect()
									EndIf
								EndIf

							Case $idLeftPane+8 ; Show help page
								UIASpy_UsageLeft()
						EndSwitch

					; Right pane menu
					Case $idRightPane+1 ; Show default and unavailable properties
						$bElemDetailsAll = Not $bElemDetailsAll
						GUICtrlSetState( $iMsg, $bElemDetailsAll ? $GUI_CHECKED : $GUI_UNCHECKED )
						UIASpy_ShowElemInfo( $iTVSelIdx )

					Case $idRightPane+3 ; Show help page
						UIASpy_UsageRight()

					; Sample code menu
					Case $idSampleMenu+3 To $idSampleMenu+23
						Switch $iMsg
							Case $idSampleMenu+3 ; Properties...
								$idSampleCodeFunc = $idSampleMenu+3
								UIASpy_Properties( $iTVSelIdx )

							Case $idSampleMenu+4 ; Patterns...
								UIASpy_Patterns( $iTVSelIdx )

							Case $idSampleMenu+5 ; Pattern props...
								UIASpy_PatternProps( $iTVSelIdx )

							Case $idSampleMenu+6 ; Pattern methods...
								UIASpy_PatternMethods( $iTVSelIdx )

							Case $idSampleMenu+7 ; Sleep( 1000 )
								UIASpy_Sleep()

							Case $idSampleMenu+10 ; Code snippets...
								UIASpy_Snippets()

							Case $idSampleMenu+13 ; Corrections
								UIASpy_Corrections()

							Case $idSampleMenu+17 ; Undo code
								If $iUndo Then UIASpy_UndoCode()

							Case $idSampleMenu+18 ; Redo code
								If $iRedo Then UIASpy_RedoCode()

							Case $idSampleMenu+20 ; Show code
								If $iCode Then UIASpy_ShowCode()

							Case $idSampleMenu+21 ; Clear code
								If $iCode Or $iRedo Then UIASpy_ClearCode()

							Case $idSampleMenu+23 ; Show help page
								UIASpy_UsageSample()
						EndSwitch

					; Initial code
					Case $idSampleMenu+24 To $idSampleMenu+26
						Switch $iMsg
							Case $idSampleMenu+24 ; Complete code
								UIASpy_InitialCode()

							Case $idSampleMenu+25 ; Automation obj
								UIASpy_AutomationObj()

							Case $idSampleMenu+26 ; Desktop object
								UIASpy_DesktopObject()
						EndSwitch

					; Window/control
					Case $idSampleMenu+27 To $idSampleMenu+28
						Switch $iMsg
							Case $idSampleMenu+27 ; Window/control...
								$idSampleCodeFunc = $idSampleMenu+27
								UIASpy_Conditions( $iTVSelIdx, $iMsg )

							Case $idSampleMenu+28 ; Application window...
								$idSampleCodeFunc = $idSampleMenu+28
								UIASpy_Conditions( $iTVSelIdx, $iMsg )
						EndSwitch

					; Objects/methods
					Case $idSampleMenu+29 To $idSampleMenu+33
						Switch $iMsg
							Case $idSampleMenu+29 ; Create UIA objects...
								UIASpy_CreateUIAObjects()

							Case $idSampleMenu+31 ; Automation object methods...
								UIASpy_AutomationMethods()

							Case $idSampleMenu+32 ; Element object methods...
								UIASpy_ElementMethods()

							Case $idSampleMenu+33 ; Other object methods...
								UIASpy_OtherObjMethods()
						EndSwitch

					; Check error
					Case $idSampleMenu+34 To $idSampleMenu+37
						Switch $iMsg
							Case $idSampleMenu+34 ; Object err
								UIASpy_ObjectErr()
								UIASpy_UndoRedoInfo()

							Case $idSampleMenu+35 ; Pointer err
								UIASpy_PointerErr()
								UIASpy_UndoRedoInfo()

							Case $idSampleMenu+36 ; Pattern err
								UIASpy_PatternErr()
								UIASpy_UndoRedoInfo()

							Case $idSampleMenu+37 ; Elem array err
								UIASpy_ElemArrayErr()
								UIASpy_UndoRedoInfo()
						EndSwitch

					; Sample code options
					Case $idSampleMenu+38 To $idSampleMenu+40
						Switch $iMsg
							Case $idSampleMenu+38 ; Ignore case
								$bIgnoreCase = Not $bIgnoreCase
								GUICtrlSetState( $iMsg, $bIgnoreCase ? $GUI_CHECKED : $GUI_UNCHECKED )

							Case $idSampleMenu+39 ; Check error
								$bErrorCode = Not $bErrorCode
								GUICtrlSetState( $iMsg, $bErrorCode ? $GUI_CHECKED : $GUI_UNCHECKED )

							Case $idSampleMenu+40 ; Pattern err
								$bPatternError = Not $bPatternError
								GUICtrlSetState( $iMsg, $bPatternError ? $GUI_CHECKED : $GUI_UNCHECKED )
						EndSwitch

					; Scale menu
					Case $idScaleMenu+1 To $idScaleMenu+15
						If $iMsg = $idScaleMenu+15 Then ; Help
							ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=196833&view=findpost&p=1412383" )
							ContinueLoop
						EndIf
						GUICtrlSetState( $idScaleMenu + 1 + ( $fScale - 1.00 ) / 0.25, $GUI_UNCHECKED )
						$fScale = 1.00 + 0.25 * ( $iMsg - $idScaleMenu - 1 )
						GUICtrlSetState( $iMsg, $GUI_CHECKED )
						;_GUICtrlTreeView_BeginUpdate( $hTV )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
						UIASpy_DelChildsElement( 0 )
						; Get open windows
						UIASpy_Windows()
						; Desktop element info
						UIASpy_ShowElemInfo(0)
						; Desktop element rect
						UIASpy_ShowElement(0)
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
						;_GUICtrlTreeView_EndUpdate( $hTV )
						_GUICtrlTreeView_SetSelected( $hTV, $aElems[0][4] )

					; Windows menu
					Case $idModeMenu+1 To $idModeMenu+6
						If $iMsg = $idModeMenu+6 Then ; Help
							ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=196833&view=findpost&p=1423296" )
							ContinueLoop
						EndIf
						Local $sWin = $iMsg = $idModeMenu+1 ? "WIN_7" : $iMsg = $idModeMenu+2 ? "WIN_8" : $iMsg = $idModeMenu+3 ? "WIN_81" : "WIN_10"
						GUICtrlSetState( $idModeMenu+1, $GUI_UNCHECKED )
						GUICtrlSetState( $idModeMenu+2, $GUI_UNCHECKED )
						GUICtrlSetState( $idModeMenu+3, $GUI_UNCHECKED )
						GUICtrlSetState( $idModeMenu+4, $GUI_UNCHECKED )
						GUICtrlSetState( $iMsg, $GUI_CHECKED )
						; Clear sample code
						If $iCode Or $iRedo Then UIASpy_ClearCode( False )
						; Clear red rect
						If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
						$bRedrawElemRect = False
						$hRedrawElemTimer = 0
						$iDetectElemIdx = 0
						$hRedrawWindow = 0
						ClearElemRect()
						; Delete top windows
						;_GUICtrlTreeView_BeginUpdate( $hTV )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
						;UIASpy_DelChilds( 0 )
						UIASpy_DelChildsElement( 0 )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
						;_GUICtrlTreeView_EndUpdate( $hTV )
						; Set Windows mode
						UIASpy_WindowsMode( $sWin )
						UIASpy_SampleMode()
						; Get open windows
						UIASpy_Windows()
						; Desktop element info
						UIASpy_ShowElemInfo(0)
						; Desktop element rect
						UIASpy_ShowElement(0)
						UIASpy_TreeView_ClickItem( $hTV, $aElems[0][4] )

					; Help menu
					Case $idHelpMenu+3 To $idHelpMenu+14
						Switch $iMsg
							Case $idHelpMenu+3 ; Detect element
								UIASpy_UsageDetect()

							Case $idHelpMenu+4 ; Left pane
								UIASpy_UsageLeft()

							Case $idHelpMenu+5 ; Right pane
								UIASpy_UsageRight()

							Case $idHelpMenu+6 ; Sample code
								UIASpy_UsageSample()

							Case $idHelpMenu+8 ; How to topics
								ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1417296" )

							Case $idHelpMenu+9 ; Browse AutoIt example
								ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=196833" )

							Case $idHelpMenu+10 ; UIASpy demo example, Notepad
								ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1413533" )

							Case $idHelpMenu+11 ; UIASpy demo examples, Sample code
								ShellExecute( "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1416659" )

							Case $idHelpMenu+13 ; UI Automation Controls (elements)
								If Not $iControls Then
									$aControls = $aUIASpy_Controls
									_ArraySort( $aControls )
									$iControls = UBound( $aControls ) + 1
									ReDim $aControls[$iControls][6]
									$aControls[$iControls-1][0] = "UI Automation Controls (elements)"
									$aControls[$iControls-1][2] = 0xFFFFE0
									$aControls[$iControls-1][4] = "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportinguiautocontroltypes"
									Dim $aControlsIndex[$iControls]
									$aControlsIndex[0] = $iControls - 1
									For $i = 1 To $iControls - 1
										$aControlsIndex[$i] = $i - 1
									Next
								EndIf
								UIASpy_DisplayHelpPage( $iControls, $aControls, $aControlsIndex, "Control name", "Control value" )

							Case $idHelpMenu+14 ; UI Automation Patterns (actions)
								If Not $iPatterns Then
									$aPatterns = $aUIASpy_Patterns
									For $i = 0 To UBound( $aPatterns ) - 1
										$aPatterns[$i][5] = $aPatterns[$i][9]
									Next
									_ArraySort( $aPatterns )
									$iPatterns = UBound( $aPatterns ) + 1
									ReDim $aPatterns[$iPatterns][6]
									$aPatterns[$iPatterns-1][0] = "UI Automation Patterns (actions)"
									$aPatterns[$iPatterns-1][2] = 0xFFFFE0
									$aPatterns[$iPatterns-1][4] = "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinguiautocontrolpatterns"
									Dim $aPatternsIndex[$iPatterns]
									$aPatternsIndex[0] = $iPatterns - 1
									For $i = 1 To $iPatterns - 1
										$aPatternsIndex[$i] = $i - 1
									Next
								EndIf
								UIASpy_DisplayHelpPage( $iPatterns, $aPatterns, $aPatternsIndex, "Pattern name", "Pattern value" )
						EndSwitch

					; Microsoft Documentation
					Case $idMsDocuMenu+1 To $idMsDocuMenu+15
						Switch $iMsg
							Case $idMsDocuMenu+1 ; Windows Automation API
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/WinAuto/windows-automation-api-portal" )

							Case $idMsDocuMenu+3 ; Client UI Automation Guide
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-clientportal" )

							Case $idMsDocuMenu+4 ; Client UI Automation Reference
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-entry-uiautoclientsforwin32apps" )

							Case $idMsDocuMenu+6 ; UI Automation Controls (elements)
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportinguiautocontroltypes" )

							Case $idMsDocuMenu+7 ; UI Automation Patterns (actions)
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinguiautocontrolpatterns" )

							Case $idMsDocuMenu+8 ; Control Types and Supported Patterns
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternmapping" )

							Case $idMsDocuMenu+10 ; UI Automation object (main obj)
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomation" )

							Case $idMsDocuMenu+11 ; UI Automation Element object
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationelement" )

							Case $idMsDocuMenu+13 ; UI Element Properties
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" )

							Case $idMsDocuMenu+14 ; Control Patterns (actions)
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternsoverview" )

							Case $idMsDocuMenu+15 ; Control Pattern Properties
								ShellExecute( "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-control-pattern-propids" )
						EndSwitch
				EndSwitch

			; --- TreeView events ---

			; All TreeView events
			Case $idTVSelect To $idTVRClick
				Switch $iMsg
					Case $idTVSelect
						$iIdx = GUICtrlRead( $idTVSelect )
						; Clear element rect
						If $bRedrawElemRect And $iIdx <> $iDetectElemIdx Then
							If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
							$bRedrawElemRect = False
							$hRedrawElemTimer = 0
							$iDetectElemIdx = 0
							$hRedrawWindow = 0
							ClearElemRect()
						EndIf
						; Check element
						UIASpy_CheckElement( $iIdx )
						; Show element info
						UIASpy_ShowElemInfo( $iIdx )
						; Show element rect
						If $bShowElemRect Then _
							UIASpy_ShowElement( $iIdx, False, $bOnlyVisibleElems )
						GUICtrlSetState( $idSampleMenu+28, UIASpy_TreeView_Level1( $iIdx ) ? $GUI_ENABLE : $GUI_DISABLE ) ; Application window... menu item
						$iTVSelIdx = $iIdx

					Case $idTVExpand
						$iIdx = GUICtrlRead( $idTVExpand )
						;_GUICtrlTreeView_BeginUpdate( $hTV )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
						UIASpy_AddChilds( $iIdx, False, $iIdx ? False : True )
						DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $aElems[$iIdx][4] )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
						;_GUICtrlTreeView_EndUpdate( $hTV )

					Case $idTVDblClick
						; Update child elements
						$iIdx = GUICtrlRead( $idTVDblClick )
						$idTVExpand = 0 ; Disable $idTVExpand
						;_GUICtrlTreeView_BeginUpdate( $hTV )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
						UIASpy_DelChilds( $iIdx )
						UIASpy_AddChilds( $iIdx, False, $iIdx ? False : True )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
						;_GUICtrlTreeView_EndUpdate( $hTV )
						$idTVExpand = $idTVExpand0

					Case $idTVEnter
						If Not GUIGetCursorInfo()[4] = $idTV Then ContinueLoop
						$idTVExpand = 0 ; Disable $idTVExpand
						;_GUICtrlTreeView_BeginUpdate( $hTV )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
						UIASpy_DelChilds( $iIdx )
						UIASpy_AddChilds( $iIdx, False, $iIdx ? False : True )
						GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
						;_GUICtrlTreeView_EndUpdate( $hTV )
						$idTVExpand = $idTVExpand0

					; TreeView right-click
					Case $idTVRClick
						$iIdx = GUICtrlRead( $idTVRClick )
						If Not $iIdx Then ContinueLoop ; Skip Desktop
						$iTVSelIdx = $iIdx
						; Clear element rect
						If $bRedrawElemRect And $iIdx <> $iDetectElemIdx Then
							If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
							$bRedrawElemRect = False
							$hRedrawElemTimer = 0
							$iDetectElemIdx = 0
							$hRedrawWindow = 0
							ClearElemRect()
						EndIf
						; Check element
						UIASpy_CheckElement( $iIdx )
						; Show element info
						UIASpy_ShowElemInfo( $iIdx )
						; Show element rect
						If $bShowElemRect Then _
							UIASpy_ShowElement( $iIdx, False, $bOnlyVisibleElems )
						GUICtrlSetState( $idSampleMenu+28, UIASpy_TreeView_Level1( $iIdx ) ? $GUI_ENABLE : $GUI_DISABLE ) ; Application window... menu item
						$idTVSelect = 0 ; Disable $idTVSelect
						UIASpy_TreeView_ClickItem( $hTV, $aElems[$iIdx][4] )
						Switch _GUICtrlMenu_TrackPopupMenu( $hTVItemPopupMenu, $hTV, -1, -1, 1, 1, 2 )
							Case $idShowElement ; Show UI Automation element
								If $bShowElemRect Then _
									UIASpy_ShowElement( $iIdx, True, $bOnlyVisibleElems )

							Case $idUpdateElementInfo ; Update current element info
								$aElems[$iIdx][7] = 0        ; Delete old element info
								UIASpy_ShowElemInfo( $iIdx ) ; Show new element info

							Case $idUpdateChildsOfElement ; Update direct childs of element
								$idTVExpand = 0 ; Disable $idTVExpand
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChilds( $iIdx )
								UIASpy_AddChilds( $iIdx )
								DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $aElems[$iIdx][4] )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								$idTVExpand = $idTVExpand0

							Case $idUpdateAllChildsOfElement ; Update all childs of element
								$idTVExpand = 0 ; Disable $idTVExpand
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChilds( $iIdx )
								$iCntElems = 0
								UIASpy_AddChilds( $iIdx, True )
								DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_ENSUREVISIBLE, "wparam", 0, "handle", $aElems[$iIdx][4] )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								$idTVExpand = $idTVExpand0
								ToolTip("")

							Case $idDeleteElement ; Delete element and all childs
								$idTVSelect = $idTVSelect0
								;_GUICtrlTreeView_BeginUpdate( $hTV )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 0, 0 )
								UIASpy_DelChildsElement( $iIdx )
								GUICtrlSendMsg( $idTV, $WM_SETREDRAW, 1, 0 )
								;_GUICtrlTreeView_EndUpdate( $hTV )
								; --- More top windows? ---
								; _GUICtrlTreeView_GetFirstChild()
								If Not DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_CHILD, "handle", $aElems[0][4] )[0] Then _ ; $aElems[0][4] = $hDesktop
									$aElems[0][5] = False ; Recalc child elements on expand

							Case $idDeleteTopElements ; Delete all 1st level elements
								UIASpy_DeleteTopElements( $iIdx )

							Case $idTreeStructure ; Create element tree structure
								UIASpy_CopyStructure( $iIdx )

							Case $idTreeHelp ; Show help page
								UIASpy_UsageLeft()
						EndSwitch
						$idTVSelect = $idTVSelect0
				EndSwitch

			; --- ListView events ---

			; All ListView events
			Case $idLVDblClick To $idLVRClick
				Local $iLVItem
				Switch $iMsg
					Case $idLVDblClick
						$iLVItem = GUICtrlRead( $idLVDblClick )
						Switch $aElemDetails[$aElemIndex[0]][0]
							; Use of UIASpy help pages
							Case "Detect element", "Left pane", _
							     "Right pane", "Sample code"
								If ( $iLVItem < 4 Or $iLVItem > 13 ) And _
								   $aElemDetails[$aElemIndex[$iLVItem]][4] Then     ; Help page|row or URL in column 4
									Local $aSplit = StringSplit( $aElemDetails[$aElemIndex[$iLVItem]][4], "|", 2 ) ; 2 = $STR_NOCOUNT
									Switch $aSplit[0]
										Case "Right pane"
											UIASpy_UsageRight( Int( $aSplit[1] ) )
										Case "Sample code"
											UIASpy_UsageSample( Int( $aSplit[1] ) )
										Case Else
											ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )
									EndSwitch
								ElseIf $aElemDetails[$aElemIndex[$iLVItem]][4] Then ; Row no. in column 4
									;_GUICtrlListView_BeginUpdate( $idLV )
									GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
									GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $iElemDetails-1, 0 )
									GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, $aElemDetails[$aElemIndex[$iLVItem]][4], 0 )
									;_GUICtrlListView_EnsureVisible( $idLV, 0 )
									GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
									;_GUICtrlListView_EndUpdate( $idLV )
								EndIf
							Case Else
								ShellExecute( $aElemDetails[$aElemIndex[$iLVItem]][4] )
						EndSwitch

					; ListView right-click
					Case $idLVRClick
						$iLVItem = GUICtrlRead( $idLVRClick )
						Switch $aElemDetails[$aElemIndex[0]][0]
							Case "0" ; Tree, code
								UIASpy_LVRightClick( $iLVItem )
							Case "Element Properties (identification, Sample code)"
								Switch $idSampleCodeFunc
									Case $idSampleMenu+3
										UIASpy_PropertyCode( $iLVItem )
									Case $idSampleMenu+27
										UIASpy_WinCtrlCode( $iLVItem )
									Case $idSampleMenu+28
										UIASpy_ApplWinCode( $iLVItem )
								EndSwitch
							Case "Control Patterns (element actions, Sample code)"
								UIASpy_PatternCode( $iLVItem )
							Case "Control Pattern Properties (Sample code)"
								UIASpy_PatternPropCode( $iLVItem )
							Case "Control Pattern Methods (Sample code)"
								UIASpy_PatternMethodCode( $iLVItem )
							Case "UI Automation objects"
								UIASpy_CreateUIAObjectsCode( $iLVItem )
							Case "UI Automation object"
								UIASpy_AutomationMethodsCode( $iLVItem )
							Case "UI Element object"
								UIASpy_ElementMethodsCode( $iLVItem )
							Case "TextRange"
								UIASpy_OtherObjMethodsCode( $iLVItem )
							Case "Code Snippets (Sample code)"
								UIASpy_SnippetsCode( $iLVItem )
							Case Else
								UIASpy_LVRightClick( $iLVItem )
						EndSwitch
				EndSwitch

			; --- SplitterBar events ---

			Case $idSplitterBar
				If $iGuiWidth > 2 * $iMinWidth + $iSplitterWidth Then
					DragSplitterBar()
					Local $aSpos = ControlGetPos( $hGui, "", $idSplitterBar )
					$fTVWidthRatio = $aSpos[0] / $iGuiWidth
					Local $iTVwidth = $iGuiWidth * $fTVWidthRatio
					If $iTVwidth < $iMinWidth Then $iTVwidth = $iMinWidth
					GUICtrlSetPos( $idTV, 0, 0, $iTVwidth, $iGuiHeight )
					GUICtrlSetPos( $idSplitterBar, $iTVwidth, 0, $iSplitterWidth, $iHeight )
					GUICtrlSetPos( $idLV, $iTVwidth+$iSplitterWidth, 0, $iGuiWidth-$iTVwidth-$iSplitterWidth+2, $iGuiHeight )
					_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth-$iTVwidth - _GUICtrlListView_GetColumnWidth( $idLV, 0 ) - 30 )
				EndIf

			; --- Other GUI events ---

			Case $GUI_EVENT_MAXIMIZE, $GUI_EVENT_RESIZED, $GUI_EVENT_RESTORE
				MoveControls()

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	; Cleanup
	If $bRedrawElemRect Then
		If WinExists( $hRedrawWindow ) Then ClearElemRect( $hRedrawWindow )
		$bRedrawElemRect = False
		$hRedrawElemTimer = 0
		ClearElemRect()
	EndIf
	GUIDelete( $hGui )
EndFunc

Func DragSplitterBar()
	; To avoid flicker (especially after resizing the GUI) use a child window to show the splitter bar when dragging
	Local $aCpos, $aWpos = WinGetPos( $hGui ), $dx = $aWpos[0] + 5, $dy = $aWpos[1] + 30 + 20, $iHeight = $iGuiHeight
	Local $hSplitterDragWin = GUICreate( "", $iSplitterWidth, $iHeight, $iGuiWidth * $fTVWidthRatio, 0, $WS_POPUP, $WS_EX_MDICHILD, $hGui )
	GUISetState( @SW_SHOWNOACTIVATE, $hSplitterDragWin )
	Do
		$aCpos = GUIGetCursorInfo( $hGui )
		If $aCpos[0] > $iMinWidth + $iSplitterWidth / 2 And $aCpos[0] < $iGuiWidth - $iMinWidth - $iSplitterWidth / 2 Then _
			WinMove( $hSplitterDragWin, "", $dx + $aCpos[0] - $iSplitterWidth / 2, $dy, $iSplitterWidth, $iHeight )
	Until $aCpos[2] = 0
	GUIDelete( $hSplitterDragWin )
	If $aCpos[0] < $iMinWidth Then
		$aCpos[0] = $iMinWidth
	ElseIf $aCpos[0] + $iSplitterWidth > $iGuiWidth - $iMinWidth Then
		$aCpos[0] = $iGuiWidth - $iMinWidth - $iSplitterWidth
	EndIf
	GUICtrlSetPos( $idSplitterBar, $aCpos[0] - $iSplitterWidth / 2, 0, $iSplitterWidth, $iHeight )
EndFunc

Func MoveControls()
	Local $aSize = WinGetClientSize( $hGui )
	$iGuiWidth = $aSize[0]
	$iGuiHeight = $aSize[1]
	Local $iTVwidth = $iGuiWidth * $fTVWidthRatio
	If $iGuiWidth > 2 * $iMinWidth + $iSplitterWidth Then
		If $iTVwidth < $iMinWidth Then
			$iTVwidth = $iMinWidth
		ElseIf $iTVwidth + $iSplitterWidth > $iGuiWidth - $iMinWidth Then
			$iTVwidth = $iGuiWidth - $iMinWidth - $iSplitterWidth
		EndIf
	Else
		$iTVwidth = $iGuiWidth / 2 - $iSplitterWidth / 2
	EndIf
	GUICtrlSetPos( $idTV, 0, 0, $iTVwidth, $iGuiHeight )
	GUICtrlSetPos( $idSplitterBar, $iTVwidth, 0, $iSplitterWidth, $iGuiHeight )
	GUICtrlSetPos( $idLV, $iTVwidth+$iSplitterWidth, 0, $iGuiWidth-$iTVwidth-$iSplitterWidth+2, $iGuiHeight )
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth-$iTVwidth - _GUICtrlListView_GetColumnWidth( $idLV, 0 ) - 30 )
EndFunc

Func UIASpy_ListView_SetColumn1Width()
	Local $iTVwidth = $iGuiWidth * $fTVWidthRatio
	If $iGuiWidth > 2 * $iMinWidth + $iSplitterWidth Then
		If $iTVwidth < $iMinWidth Then
			$iTVwidth = $iMinWidth
		ElseIf $iTVwidth + $iSplitterWidth > $iGuiWidth - $iMinWidth Then
			$iTVwidth = $iGuiWidth - $iMinWidth - $iSplitterWidth
		EndIf
	Else
		$iTVwidth = $iGuiWidth / 2 - $iSplitterWidth / 2
	EndIf
	_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth-$iTVwidth - _GUICtrlListView_GetColumnWidth( $idLV, 0 ) - 30 )
EndFunc

Func UIASpy_TreeView_ClickItem($hWnd, $hItem, $sButton = "left", $bMove = False, $iClicks = 1, $iSpeed = 0)
	Local $tRect = DllStructCreate($tagRECT)
	Local $iRet = @AutoItX64 ? DllStructSetData( DllStructCreate( "ptr", DllStructGetPtr( $tRect ) ), 1, $hItem ) : DllStructSetData( $tRect, "Left", $hItem )
	$iRet = _SendMessage($hWnd, $TVM_GETITEMRECT, True, $tRect, 0, "wparam", "struct*")
	; Always click on the left-most portion of the control, not the center.  A
	; very wide control may be off-screen which means clicking on it's center
	; will click outside the window.
	Local $tPoint = _WinAPI_PointFromRect($tRect, False), $iX, $iY
	_WinAPI_ClientToScreen($hWnd, $tPoint)
	_WinAPI_GetXYFromPoint($tPoint, $iX, $iY)
	Local $iMode = Opt("MouseCoordMode", 1)
	If Not $bMove Then
		Local $aPos = MouseGetPos()
		_WinAPI_ShowCursor(False)
		MouseClick($sButton, $iX, $iY, $iClicks, $iSpeed)
		MouseMove($aPos[0], $aPos[1], 0)
		_WinAPI_ShowCursor(True)
	Else
		MouseClick($sButton, $iX, $iY, $iClicks, $iSpeed)
	EndIf
	Opt("MouseCoordMode", $iMode)
	Return 1
	#forceref $iRet
EndFunc

Func UIASpy_TreeView_Level1( $iIdx )
	; Item level, _GUICtrlTreeView_Level()
	Local $hItem = $aElems[$iIdx][4], $hParItem, $iItemLevel = 0
	$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
	While $hParItem And $iItemLevel < 3
		$hParItem = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParItem )[0]
		$iItemLevel += 1
	WEnd
	Return ( $iItemLevel = 1 )
EndFunc
