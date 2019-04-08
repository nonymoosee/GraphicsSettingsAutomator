#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_AU3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/sf
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include "UIASpy\Includes\UIA_Constants.au3" ; Can be copied from UIASpy Includes folder
#include <Array.au3>

Opt("MustDeclareVars", 1)
Global $oUIAutomation, $oDesktop, $oWindow1, $oList1, $oListItem1

Global $count = $CmdLine[0]
Global $passedVar
_ArrayDelete($CmdLine, 0)
For $i = 0 To UBound($CmdLine) - 1
	$passedVar = $passedVar & " " & $CmdLine[$i]
Next
$passedVar = StringStripWS($passedVar, $STR_STRIPLEADING)
$passedVar = $passedVar & " "

ClickBoth($passedVar)

Func ClickFileName($Whattoclick)
	; Create UI Automation object
	$oUIAutomation = ObjCreateInterface($sCLSID_CUIAutomation8, $sIID_IUIAutomation5, $dtag_IUIAutomation5)
;~     If Not IsObj( $oUIAutomation ) Then MsgBox(0,0, "$oUIAutomation ERR" & @CRLF )
	ConsoleWrite("$oUIAutomation OK - Aka Startup" & @CRLF)

	; Get Desktop element
	Local $pDesktop, $oDesktop
	$oUIAutomation.GetRootElement($pDesktop)
	$oDesktop = ObjCreateInterface($pDesktop, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oDesktop) Then MsgBox(0, 0, "$oDesktop ERR" & @CRLF)
	ConsoleWrite("$oDesktop OK" & @CRLF)

	ConsoleWrite("--- Find window/control ---" & @CRLF)

	Local $pCondition1
	$oUIAutomation.CreatePropertyCondition($UIA_NamePropertyId, "Settings", $pCondition1)
	If Not $pCondition1 Then MsgBox(0, 0, "$pCondition1 ERR" & @CRLF)
	ConsoleWrite("$pCondition1 OK" & @CRLF)

	Local $pWindow1, $oWindow1
	$oDesktop.FindFirst($TreeScope_Descendants, $pCondition1, $pWindow1)
	$oWindow1 = ObjCreateInterface($pWindow1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oWindow1) Then MsgBox(0, 0, "$oWindow1 ERR" & @CRLF)
	ConsoleWrite("$oWindow1 OK - Found Settings Window" & @CRLF)

	ConsoleWrite("--- Find window/control ---" & @CRLF)

	Local $pCondition3
	$oUIAutomation.CreatePropertyCondition($UIA_ClassNamePropertyId, "ListView", $pCondition3)
	If Not $pCondition3 Then MsgBox(0, 0, "$pCondition3 ERR" & @CRLF)
	ConsoleWrite("$pCondition3 OK" & @CRLF)

	Local $pList1, $oList1
	$oWindow1.FindFirst($TreeScope_Descendants, $pCondition3, $pList1)
	$oList1 = ObjCreateInterface($pList1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oList1) Then MsgBox(0, 0, "$oList1 ERR - I GUESS WE DIDNT FIND THE LIST?" & @CRLF)
	ConsoleWrite("$oList1 OK - AKA Find the List in the settings!" & @CRLF)

	Local $pCondition5
	$oUIAutomation.CreatePropertyCondition($UIA_NamePropertyId, $Whattoclick, $pCondition5)
	If Not $pCondition5 Then MsgBox(0, 0, "$pCondition5 ERR" & @CRLF)
	ConsoleWrite("$pCondition0 OK" & @CRLF)
	Local $pListItem1, $oListItem1
	$oList1.FindFirst($TreeScope_Descendants, $pCondition5, $pListItem1)
	$oListItem1 = ObjCreateInterface($pListItem1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oListItem1) Then MsgBox(0, 0, "$oListItem1 ERR" & @CRLF)
	ConsoleWrite("$oListItem1 OK" & @CRLF)
	ConsoleWrite("--- SelectionItem Pattern (action) Object ---" & @CRLF)
	Local $pSelectionItemPattern1, $oSelectionItemPattern1
	$oListItem1.GetCurrentPattern($UIA_SelectionItemPatternId, $pSelectionItemPattern1)
	$oSelectionItemPattern1 = ObjCreateInterface($pSelectionItemPattern1, $sIID_IUIAutomationSelectionItemPattern, $dtag_IUIAutomationSelectionItemPattern)
	If Not IsObj($oSelectionItemPattern1) Then MsgBox(0, 0, "$oSelectionItemPattern1 ERR" & @CRLF)
	ConsoleWrite("$oSelectionItemPattern1 OK" & @CRLF)
	$oSelectionItemPattern1.Select()
	Sleep(1000)
	Run("OptionsButton.exe " & $Whattoclick)
	ProcessWaitClose("OptionsButton.exe")
	Sleep(1000)
	Send("{Tab 2}")
	Sleep(100)
	Send("{Space 2}")
	Sleep(100)
	Send("{Tab}")
	Sleep(100)
	Send("{Space}")
EndFunc   ;==>ClickFileName


Func ClickBoth($Whattoclick2)

	; Create UI Automation object
	$oUIAutomation = ObjCreateInterface($sCLSID_CUIAutomation8, $sIID_IUIAutomation5, $dtag_IUIAutomation5)
;~     If Not IsObj( $oUIAutomation ) Then MsgBox(0,0, "$oUIAutomation ERR" & @CRLF )
	ConsoleWrite("$oUIAutomation OK - Aka Startup" & @CRLF)

	; Get Desktop element
	Local $pDesktop, $oDesktop
	$oUIAutomation.GetRootElement($pDesktop)
	$oDesktop = ObjCreateInterface($pDesktop, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oDesktop) Then MsgBox(0, 0, "$oDesktop ERR" & @CRLF)
	ConsoleWrite("$oDesktop OK" & @CRLF)

	ConsoleWrite("--- Find window/control ---" & @CRLF)

	Local $pCondition1
	$oUIAutomation.CreatePropertyCondition($UIA_NamePropertyId, "Settings", $pCondition1)
	If Not $pCondition1 Then MsgBox(0, 0, "$pCondition1 ERR" & @CRLF)
	ConsoleWrite("$pCondition1 OK" & @CRLF)

	Local $pWindow1, $oWindow1
	$oDesktop.FindFirst($TreeScope_Descendants, $pCondition1, $pWindow1)
	$oWindow1 = ObjCreateInterface($pWindow1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oWindow1) Then MsgBox(0, 0, "$oWindow1 ERR" & @CRLF)
	ConsoleWrite("$oWindow1 OK - Found Settings Window" & @CRLF)

	ConsoleWrite("--- Find window/control ---" & @CRLF)

	Local $pCondition3
	$oUIAutomation.CreatePropertyCondition($UIA_ClassNamePropertyId, "ListView", $pCondition3)
	If Not $pCondition3 Then MsgBox(0, 0, "$pCondition3 ERR" & @CRLF)
	ConsoleWrite("$pCondition3 OK" & @CRLF)

	Local $pList1, $oList1
	$oWindow1.FindFirst($TreeScope_Descendants, $pCondition3, $pList1)
	$oList1 = ObjCreateInterface($pList1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oList1) Then MsgBox(0, 0, "$oList1 ERR - I GUESS WE DIDNT FIND THE LIST?" & @CRLF)
	ConsoleWrite("$oList1 OK - AKA Find the List in the settings!" & @CRLF)

	Local $pCondition5
	$oUIAutomation.CreatePropertyCondition($UIA_NamePropertyId, $Whattoclick2, $pCondition5)
	If Not $pCondition5 Then MsgBox(0, 0, "$pCondition5 ERR" & @CRLF)
	ConsoleWrite("$pCondition0 OK" & @CRLF)
	Local $pListItem1, $oListItem1
	$oList1.FindFirst($TreeScope_Descendants, $pCondition5, $pListItem1)
	$oListItem1 = ObjCreateInterface($pListItem1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oListItem1) Then MsgBox(0, 0, "$oListItem1 ERR" & @CRLF)
	ConsoleWrite("$oListItem1 OK" & @CRLF)
	ConsoleWrite("--- SelectionItem Pattern (action) Object ---" & @CRLF)
	Local $pSelectionItemPattern1, $oSelectionItemPattern1
	$oListItem1.GetCurrentPattern($UIA_SelectionItemPatternId, $pSelectionItemPattern1)
	$oSelectionItemPattern1 = ObjCreateInterface($pSelectionItemPattern1, $sIID_IUIAutomationSelectionItemPattern, $dtag_IUIAutomationSelectionItemPattern)
	If Not IsObj($oSelectionItemPattern1) Then MsgBox(0, 0, "$oSelectionItemPattern1 ERR" & @CRLF)
	ConsoleWrite("$oSelectionItemPattern1 OK" & @CRLF)
	$oSelectionItemPattern1.Select()
	Send("{Down 2}")
	$oSelectionItemPattern1.Select()

	; NEW CODE!!!!!

	ConsoleWrite("--- Find window/control ---" & @CRLF)

	Local $pCondition8
	$oUIAutomation.CreatePropertyCondition($UIA_AutomationIdPropertyId, "SystemSettings_AdvancedGraphics_PerApp_OptionButton_Button", $pCondition8)
	If Not $pCondition8 Then Return ConsoleWrite("$pCondition8 ERR" & @CRLF)
	ConsoleWrite("$pCondition8 OK" & @CRLF)

	Local $pButton1, $oButton1
	$oWindow1.FindFirst($TreeScope_Descendants, $pCondition8, $pButton1)
	$oButton1 = ObjCreateInterface($pButton1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8)
	If Not IsObj($oButton1) Then Return ConsoleWrite("$oButton1 ERR" & @CRLF)
	ConsoleWrite("$oButton1 OK" & @CRLF)


	ConsoleWrite("--- Invoke Pattern (action) Object ---" & @CRLF)

	Local $pInvokePattern10, $oInvokePattern1
	$oButton1.GetCurrentPattern($UIA_InvokePatternId, $pInvokePattern10)
	$oInvokePattern1 = ObjCreateInterface($pInvokePattern10, $sIID_IUIAutomationInvokePattern, $dtag_IUIAutomationInvokePattern)
	If Not IsObj($oInvokePattern1) Then Return ConsoleWrite("$oInvokePattern1 ERR" & @CRLF)
	ConsoleWrite("$oInvokePattern1 OK" & @CRLF)

	; --- Invoke Pattern (action) Methods ---

	ConsoleWrite("--- Invoke Pattern (action) Methods ---" & @CRLF)

	$oInvokePattern1.Invoke()
	ConsoleWrite("$oInvokePattern1.Invoke()" & @CRLF)
	Sleep(500)
	Send("{Tab 2}")
	Sleep(100)
	Send("{Space 2}")
	Sleep(100)
	Send("{Tab}")
	Sleep(100)
	Send("{Space}")
EndFunc   ;==>ClickBoth
