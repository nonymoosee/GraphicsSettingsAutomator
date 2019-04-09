
;GoToSettings
WinMinimizeAll()
MouseClick("Right", 1, 1, 1, 0) ; Right Click On Desktop
Sleep(1000)
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7

#include "C:\Users\GodMode\Desktop\EasyImageSearch\UIASpy\Includes\UIA_Constants.au3" ; Can be copied from UIASpy Includes folder


Opt( "MustDeclareVars", 1 )

Example()

Func Example(); Get Desktop element
    ; Create UI Automation object
    Local $oUIAutomation = ObjCreateInterface( $sCLSID_CUIAutomation8, $sIID_IUIAutomation5, $dtag_IUIAutomation5 )
    If Not IsObj( $oUIAutomation ) Then Return ConsoleWrite( "$oUIAutomation ERR" & @CRLF )
    ConsoleWrite( "$oUIAutomation OK" & @CRLF )


;~ Local $pDesktop, $oDesktop

    ; Create UI Automation object
;~     Local $oUIAutomation = ObjCreateInterface( $sCLSID_CUIAutomation8, $sIID_IUIAutomation5, $dtag_IUIAutomation5 )
;~     If Not IsObj( $oUIAutomation ) Then Return ConsoleWrite( "$oUIAutomation ERR" & @CRLF )
;~     ConsoleWrite( "$oUIAutomation OK" & @CRLF )

;~     ; Get Desktop element
    Local $pDesktop, $oDesktop
    $oUIAutomation.GetRootElement( $pDesktop )
    $oDesktop = ObjCreateInterface( $pDesktop, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
    If Not IsObj( $oDesktop ) Then Return ConsoleWrite( "$oDesktop ERR" & @CRLF )
    ConsoleWrite( "$oDesktop OK" & @CRLF )



$oUIAutomation.GetRootElement( $pDesktop )
$oDesktop = ObjCreateInterface( $pDesktop, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
If Not IsObj( $oDesktop ) Then Return ConsoleWrite( "$oDesktop ERR" & @CRLF )
ConsoleWrite( "$oDesktop OK" & @CRLF )

; --- Find window/control ---

ConsoleWrite( "--- Find window/control ---" & @CRLF )

Local $pCondition0
$oUIAutomation.CreatePropertyCondition( $UIA_ControlTypePropertyId, $UIA_MenuControlTypeId, $pCondition0 )
If Not $pCondition0 Then Return ConsoleWrite( "$pCondition0 ERR" & @CRLF )
ConsoleWrite( "$pCondition0 OK" & @CRLF )

Local $pMenu1, $oMenu1
$oDesktop.FindFirst( $TreeScope_Descendants, $pCondition0, $pMenu1 )
$oMenu1 = ObjCreateInterface( $pMenu1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
If Not IsObj( $oMenu1 ) Then Return ConsoleWrite( "$oMenu1 ERR" & @CRLF )
ConsoleWrite( "$oMenu1 OK" & @CRLF )

; --- Find window/control ---

ConsoleWrite( "--- Find window/control ---" & @CRLF )

Local $pCondition1
$oUIAutomation.CreatePropertyCondition( $UIA_NamePropertyId, "Context", $pCondition1 )
If Not $pCondition1 Then Return ConsoleWrite( "$pCondition1 ERR" & @CRLF )
ConsoleWrite( "$pCondition1 OK" & @CRLF )

Local $pMenu2, $oMenu2
$oDesktop.FindFirst( $TreeScope_Descendants, $pCondition1, $pMenu2 )
$oMenu2 = ObjCreateInterface( $pMenu2, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
If Not IsObj( $oMenu2 ) Then Return ConsoleWrite( "$oMenu2 ERR" & @CRLF )
ConsoleWrite( "$oMenu2 OK" & @CRLF )

; --- Find window/control ---

ConsoleWrite( "--- Find window/control ---" & @CRLF )

Local $pCondition2
$oUIAutomation.CreatePropertyCondition( $UIA_ControlTypePropertyId, $UIA_MenuItemControlTypeId, $pCondition2 )
If Not $pCondition2 Then Return ConsoleWrite( "$pCondition2 ERR" & @CRLF )
ConsoleWrite( "$pCondition2 OK" & @CRLF )

Local $pMenuItem1, $oMenuItem1
$oParent.FindFirst( $TreeScope_Descendants, $pCondition2, $pMenuItem1 )
$oMenuItem1 = ObjCreateInterface( $pMenuItem1, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
If Not IsObj( $oMenuItem1 ) Then Return ConsoleWrite( "$oMenuItem1 ERR" & @CRLF )
ConsoleWrite( "$oMenuItem1 OK" & @CRLF )

; --- Find window/control ---

ConsoleWrite( "--- Find window/control ---" & @CRLF )

Local $pCondition3
$oUIAutomation.CreatePropertyCondition( $UIA_NamePropertyId, "Display settings", $pCondition3 )
If Not $pCondition3 Then Return ConsoleWrite( "$pCondition3 ERR" & @CRLF )
ConsoleWrite( "$pCondition3 OK" & @CRLF )

Local $pMenuItem2, $oMenuItem2
$oParent.FindFirst( $TreeScope_Descendants, $pCondition3, $pMenuItem2 )
$oMenuItem2 = ObjCreateInterface( $pMenuItem2, $sIID_IUIAutomationElement8, $dtag_IUIAutomationElement8 )
If Not IsObj( $oMenuItem2 ) Then Return ConsoleWrite( "$oMenuItem2 ERR" & @CRLF )
ConsoleWrite( "$oMenuItem2 OK" & @CRLF )

; --- Invoke Pattern (action) Object ---

ConsoleWrite( "--- Invoke Pattern (action) Object ---" & @CRLF )

Local $pInvokePattern1, $oInvokePattern1
$oMenuItem2.GetCurrentPattern( $UIA_InvokePatternId, $pInvokePattern1 )
$oInvokePattern1 = ObjCreateInterface( $pInvokePattern1, $sIID_IUIAutomationInvokePattern, $dtag_IUIAutomationInvokePattern )
If Not IsObj( $oInvokePattern1 ) Then Return ConsoleWrite( "$oInvokePattern1 ERR" & @CRLF )
ConsoleWrite( "$oInvokePattern1 OK" & @CRLF )

; --- Invoke Pattern (action) Methods ---

ConsoleWrite( "--- Invoke Pattern (action) Methods ---" & @CRLF )

$oInvokePattern1.Invoke()
ConsoleWrite( "$oInvokePattern1.Invoke()" & @CRLF )

EndFunc
