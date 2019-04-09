#include-once
#include "UIASpy_AccVars.au3"

Global $oAutomationElement, $oAutomationElementArray

Func UIASpy_ElemInfo( $iIdx )
	Local $aElemDetails = $aElemDetailsArr
	$aElemDetails[0][1] = $aElems[$iIdx][2]

	If Not IsObj( $aElems[$iIdx][1] ) Then Return

	; --- Element Properties ---

	Local $i = BitAND( $aElems[$iIdx][8], 1 ) ? 2 : $aElemDetailsIdx[2]
	Local $aElementProps[$aElemDetailsIdx[1]+3] = [ 0, 1, 2 ], $iElementProps = BitAND( $aElems[$iIdx][8], 1 ) ? 2 : 3

	If Not BitAND( $aElems[$iIdx][8], 1 ) Then ; Valid elements only
		Local $aElementPropsSes[$aElemDetailsIdx[1]+2] = [ 3, 4 ], $iElementPropsSes = 2
		Local $aElementPropsInf[$aElemDetailsIdx[1]+2] = [ 5, 6 ], $iElementPropsInf = 2
		Local $aElementPropsIs[$aElemDetailsIdx[1]+2] = [ 7, 8 ], $iElementPropsIs = 2
		Local $aElementPropsDefault[$aElemDetailsIdx[1]+2] = [ 9, 10 ], $iElementPropsDefault = 2

		Local $oUIElement = $aElems[$iIdx][1], $vValue, $sValue, $iLength, $pElement, $oElement, $sPropVal

		;[ "$UIA_AcceleratorKeyPropertyId",                     ""                       ], _                      ; $i = $aElemDetailsIdx[2]
		$oUIElement.GetCurrentPropertyValue( $UIA_AcceleratorKeyPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_AccessKeyPropertyId",                          ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_AccessKeyPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_AnnotationObjectsPropertyId",                  ""                       ], _ ; Windows 10, VT_I4 | VT_ARRAY, VT_EMPTY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationObjectsPropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_AnnotationTypesPropertyId",                    ""                       ], _ ; Windows 10, VT_I4 | VT_ARRAY, VT_EMPTY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationTypesPropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_AriaPropertiesPropertyId",                     ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_AriaPropertiesPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_AriaRolePropertyId",                           ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_AriaRolePropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_AutomationIdPropertyId",                       ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_AutomationIdPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_BoundingRectanglePropertyId"                   ], _ ; [0,0,0,0]
		$oUIElement.GetCurrentPropertyValue( $UIA_BoundingRectanglePropertyId, $vValue )
		$sValue = IsArray( $vValue ) ? "l=" & $vValue[0] & "," & "t=" & $vValue[1] & "," & "w=" & $vValue[2] & "," & "h=" & $vValue[3] : ""
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_BoundingRectanglePropertyId (scaled)"          ], _ ; [0,0,0,0]
		If $fScale > 1.00 Then
			$sValue = IsArray( $vValue ) ? "l=" & Round($vValue[0]*$fScale) & "," & "t=" & Round($vValue[1]*$fScale) & "," & "w=" & Round($vValue[2]*$fScale) & "," & "h=" & Round($vValue[3]*$fScale) : ""
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			EndIf
		Else
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_CenterPointPropertyId",                        ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_CenterPointPropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_ClassNamePropertyId",                          ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ClassNamePropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_ClickablePointPropertyId",                     ""                       ], _ ; VT_R8 | VT_ARRAY, VT_EMPTY
		$oUIElement.GetCurrentPropertyValue( $UIA_ClickablePointPropertyId, $vValue )
		$sValue = ""
		If IsArray( $vValue ) And UBound( $vValue ) Then
			$sValue = $vValue[0]
			For $j = 1 To UBound( $vValue ) - 1
				$sValue &= "," & $vValue[$j]
			Next
		EndIf
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_ControllerForPropertyId"                       ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_ControllerForPropertyId, $vValue )
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_ControlTypePropertyId",                        $UIA_CustomControlTypeId ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ControlTypePropertyId, $vValue )
		$aElemDetails[0][4]  = $vValue ? $aUIASpy_Controls[$vValue-50000][4] : "" ; Control/element help
		$aElemDetails[$i][1] = $vValue ? $aUIASpy_Controls[$vValue-50000][1] : ""
		$aElementProps[$iElementProps] = $i
		$iElementProps += 1
		$i += 1
		;[ "$UIA_CulturePropertyId",                            0                        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_CulturePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue ? $vValue : ""
		If $aElemDetails[$i][1] Then
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_DescribedByPropertyId"                         ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_DescribedByPropertyId, $vValue )
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_FillColorPropertyId",                          0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_FillColorPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_FillTypePropertyId",                           0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_FillTypePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_FlowsFromPropertyId"                           ], _ ; Empty array            ; Windows 8, VT_UNKNOWN | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_FlowsFromPropertyId, $vValue )
			$sValue = ""
			If IsObj( $vValue ) Then
				AccVars01( UIASpy_GetElementArray, $vValue )
			  $oAutomationElementArray.Length( $iLength )
			  If $iLength Then
				  For $j = 0 To $iLength - 1
				    $oAutomationElementArray.GetElement( $j, $pElement )
				    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
				    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
						$sValue &= $sValue ? "," & $sPropVal : $sPropVal
				  Next
				EndIf
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_FlowsToPropertyId"                             ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_FlowsToPropertyId, $vValue )
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_FrameworkIdPropertyId",                        ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_FrameworkIdPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_FullDescriptionPropertyId",                    ""                       ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_FullDescriptionPropertyId, $vValue )
			If $vValue Then
				$aElemDetails[$i][1] = $vValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_HasKeyboardFocusPropertyId",                   -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_HasKeyboardFocusPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_HeadingLevelPropertyId",                       0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_HeadingLevelPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_HelpTextPropertyId",                           ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_HelpTextPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_IsContentElementPropertyId",                   -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsContentElementPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsControlElementPropertyId",                   -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsControlElementPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsDataValidForFormPropertyId",                 -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsDataValidForFormPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsDialogPropertyId",                           -1                       ], _ ; Windows 10, VT_BOOL
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsDialogPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? "True" : "False"
			$aElementPropsIs[$iElementPropsIs] = $i
			$iElementPropsIs += 1
		EndIf
		$i += 1
		;[ "$UIA_IsEnabledPropertyId",                          -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsEnabledPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsKeyboardFocusablePropertyId",                -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsKeyboardFocusablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsOffscreenPropertyId",                        -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsOffscreenPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsPasswordPropertyId",                         -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsPasswordPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_IsPeripheralPropertyId",                       -1                       ], _ ; Windows 8.1, VT_BOOL
		If $bW81 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsPeripheralPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			$aElementPropsIs[$iElementPropsIs] = $i
			$iElementPropsIs += 1
		EndIf
		$i += 1
		;[ "$UIA_IsRequiredForFormPropertyId",                  -1                       ], _ ; VT_BOOL
		$oUIElement.GetCurrentPropertyValue( $UIA_IsRequiredForFormPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		$aElementPropsIs[$iElementPropsIs] = $i
		$iElementPropsIs += 1
		$i += 1
		;[ "$UIA_ItemStatusPropertyId",                         ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ItemStatusPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_ItemTypePropertyId",                           ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ItemTypePropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_LabeledByPropertyId",                          NULL                     ], _ ; VT_UNKNOWN
		$oUIElement.GetCurrentPropertyValue( $UIA_LabeledByPropertyId, $vValue )
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElement, $vValue )
			$oAutomationElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $vValue )
			If $vValue Then $sValue = $vValue
		EndIf
		$aElemDetails[$i][1] = $sValue
		If $aElemDetails[$i][1] Then
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_LandmarkTypePropertyId",                       0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_LandmarkTypePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_LevelPropertyId",                              0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_LevelPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_LiveSettingPropertyId",                        0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_LiveSettingPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				If $aElemDetails[$i][1] > 0 And $aElemDetails[$i][1] < UBound( $aUIA_LiveSettings ) Then _
					$aElemDetails[$i][1] = $aUIA_LiveSettings[$aElemDetails[$i][1]]
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_LocalizedControlTypePropertyId",               ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LocalizedControlTypePropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_LocalizedLandmarkTypePropertyId",              ""                       ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_LocalizedLandmarkTypePropertyId, $vValue )
			If $vValue Then
				$aElemDetails[$i][1] = $vValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_NamePropertyId",                               ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementProps[$iElementProps] = $i
			$iElementProps += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_NativeWindowHandlePropertyId",                 0                        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_NativeWindowHandlePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue ? Ptr( $vValue ) : ""
		If $aElemDetails[$i][1] Then
			$aElementPropsSes[$iElementPropsSes] = $i
			$iElementPropsSes += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_OptimizeForVisualContentPropertyId",           -1                       ], _ ; Windows 8, VT_BOOL
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_OptimizeForVisualContentPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		EndIf
		$i += 1
		;[ "$UIA_OrientationPropertyId",                        0                        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_OrientationPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue ? $vValue : ""
		If $aElemDetails[$i][1] Then
			If $aElemDetails[$i][1] > 0 And $aElemDetails[$i][1] < UBound( $aUIA_OrientationTypes ) Then _
				$aElemDetails[$i][1] = $aUIA_OrientationTypes[$aElemDetails[$i][1]]
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_OutlineColorPropertyId",                       0                        ], _ ; Windows 10, VT_I4 | VT_ARRAY
		;[ "$UIA_OutlineColorPropertyId",                       ""                       ], _ ; Windows 10, VT_I4 | VT_ARRAY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_OutlineColorPropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_OutlineThicknessPropertyId",                   ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_OutlineThicknessPropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_PositionInSetPropertyId",                      0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_PositionInSetPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_ProcessIdPropertyId",                          0                        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ProcessIdPropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue ? $vValue : ""
		If $aElemDetails[$i][1] Then
			$aElementPropsSes[$iElementPropsSes] = $i
			$iElementPropsSes += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_ProviderDescriptionPropertyId",                ""                       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ProviderDescriptionPropertyId, $vValue )
		If $vValue Then
			$aElemDetails[$i][1] = $vValue
			$aElementPropsInf[$iElementPropsInf] = $i
			$iElementPropsInf += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_RotationPropertyId",                           0.0                      ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_RotationPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_RuntimeIdPropertyId"                           ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_RuntimeIdPropertyId, $vValue )
		$sValue = ""
		If IsArray( $vValue ) And UBound( $vValue ) Then
			$sValue = $vValue[0]
			For $j = 1 To UBound( $vValue ) - 1
				$sValue &= "," & $vValue[$j]
			Next
		EndIf
		If $sValue Then
			$aElemDetails[$i][1] = $sValue
			$aElementPropsSes[$iElementPropsSes] = $i
			$iElementPropsSes += 1
		Else
			$aElementPropsDefault[$iElementPropsDefault] = $i
			$iElementPropsDefault += 1
		EndIf
		$i += 1
		;[ "$UIA_SizePropertyId",                               ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SizePropertyId, $vValue )
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			If $sValue Then
				$aElemDetails[$i][1] = $sValue
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_SizeOfSetPropertyId",                          0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SizeOfSetPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_VisualEffectsPropertyId",                      0                        ], _ ; Windows 10
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_VisualEffectsPropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue ? $vValue : ""
			If $aElemDetails[$i][1] Then
				$aElementPropsInf[$iElementPropsInf] = $i
				$iElementPropsInf += 1
			Else
				$aElementPropsDefault[$iElementPropsDefault] = $i
				$iElementPropsDefault += 1
			EndIf
		EndIf
		$i += 1

		; --- Control Patterns ---

		; $UIA_IsLegacyIAccessiblePatternAvailablePropertyId True -->
		; $UIA_IsLegacyIAccessiblePatternAvailablePropertyId True (LegacyIAccessiblePattern)
		Local Static $oPatterns = ObjCreate( "Scripting.Dictionary" ), $iPatterns = 0
		If Not $iPatterns Then
			$iPatterns = UBound( $aUIASpy_Patterns )
			For $j = 0 To $iPatterns - 1
				$oPatterns( $aUIASpy_Patterns[$j][8] ) = " (" & $aUIASpy_Patterns[$j][0] & "Pattern)"
			Next
		EndIf

		Local $aControlPatts[$aElemDetailsIdx[5]+2] = [ $i+0, $i+1 ], $aPatterns[$aElemDetailsIdx[5]+2], $iControlPatts = 2
		Local $aControlPattsUnavail[$aElemDetailsIdx[5]+2] = [ $i+2, $i+3 ], $aPatternsUnavail[$aElemDetailsIdx[5]+2], $iControlPattsUnavail = 2
		$i += 4

		If $i <> $aElemDetailsIdx[6] Then Return
		;[ "$UIA_IsAnnotationPatternAvailablePropertyId",       "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsAnnotationPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsAnnotationPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsAnnotationPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsCustomNavigationPatternAvailablePropertyId", "",                      "", 0xE8E8E8,       ], _ ; Windows 10
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsAnnotationPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsAnnotationPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsAnnotationPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsDockPatternAvailablePropertyId"              ], _ ; TRUE/FALSE
		$oUIElement.GetCurrentPropertyValue( $UIA_IsDockPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsDockPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsDockPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsDragPatternAvailablePropertyId",             "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsDragPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsDragPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsDragPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsDropTargetPatternAvailablePropertyId",       "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsDropTargetPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsDropTargetPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsDropTargetPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsExpandCollapsePatternAvailablePropertyId"    ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsExpandCollapsePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsExpandCollapsePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsExpandCollapsePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsGridPatternAvailablePropertyId"              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsGridPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsGridPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsGridPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsGridItemPatternAvailablePropertyId"          ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsGridItemPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsGridItemPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsGridItemPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsInvokePatternAvailablePropertyId"            ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsInvokePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsInvokePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsInvokePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsItemContainerPatternAvailablePropertyId"     ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsItemContainerPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsItemContainerPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsItemContainerPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsLegacyIAccessiblePatternAvailablePropertyId" ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsLegacyIAccessiblePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsLegacyIAccessiblePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsLegacyIAccessiblePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsMultipleViewPatternAvailablePropertyId"      ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsMultipleViewPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsMultipleViewPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsMultipleViewPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsObjectModelPatternAvailablePropertyId",      "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsObjectModelPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsObjectModelPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsObjectModelPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsRangeValuePatternAvailablePropertyId"        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsRangeValuePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsRangeValuePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsRangeValuePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsScrollPatternAvailablePropertyId"            ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsScrollPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsScrollPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsScrollPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsScrollItemPatternAvailablePropertyId"        ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsScrollItemPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsScrollItemPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsScrollItemPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsSelectionPatternAvailablePropertyId"         ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsSelectionPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSelectionPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSelectionPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsSelectionItemPatternAvailablePropertyId"     ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsSelectionItemPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSelectionItemPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSelectionItemPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsSelectionPattern2AvailablePropertyId",       "",                      "", 0xE8E8E8,       ], _ ; Windows 10-1709
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsSelectionPattern2AvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSelectionPattern2AvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSelectionPattern2AvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsSpreadsheetPatternAvailablePropertyId",      "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsSpreadsheetPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSpreadsheetPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSpreadsheetPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsSpreadsheetItemPatternAvailablePropertyId",  "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsSpreadsheetItemPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSpreadsheetItemPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSpreadsheetItemPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsStylesPatternAvailablePropertyId",           "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsStylesPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsStylesPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsStylesPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsSynchronizedInputPatternAvailablePropertyId" ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsSynchronizedInputPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsSynchronizedInputPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsSynchronizedInputPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTablePatternAvailablePropertyId"             ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsTablePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTablePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTablePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTableItemPatternAvailablePropertyId"         ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsTableItemPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTableItemPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTableItemPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTextPatternAvailablePropertyId"              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsTextPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTextPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTextPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTextPattern2AvailablePropertyId",            "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsTextPattern2AvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTextPattern2AvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTextPattern2AvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsTextChildPatternAvailablePropertyId",        "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsTextChildPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTextChildPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTextChildPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsTextEditPatternAvailablePropertyId",         "",                      "", 0xE8E8E8,       ], _ ; Windows 8.1
		If $bW81 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsTextEditPatternAvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTextEditPatternAvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTextEditPatternAvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsTogglePatternAvailablePropertyId"            ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsTogglePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTogglePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTogglePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTransformPatternAvailablePropertyId"         ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsTransformPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTransformPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTransformPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsTransformPattern2AvailablePropertyId",       "",                      "", 0xE8E8E8,       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_IsTransformPattern2AvailablePropertyId, $vValue )
			$aElemDetails[$i][1] = $vValue
			If $vValue Then
				$aControlPatts[$iControlPatts] = $i
				$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsTransformPattern2AvailablePropertyId ) 
				$iControlPatts += 1
			Else
				$aControlPattsUnavail[$iControlPattsUnavail] = $i
				$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsTransformPattern2AvailablePropertyId ) 
				$iControlPattsUnavail += 1
			EndIf
		EndIf
		$i += 1
		;[ "$UIA_IsValuePatternAvailablePropertyId"             ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsValuePatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsValuePatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsValuePatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsVirtualizedItemPatternAvailablePropertyId"   ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsItemContainerPatternAvailablePropertyId, $vValue )
		;$oUIElement.GetCurrentPropertyValue( $UIA_IsVirtualizedItemPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsVirtualizedItemPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsVirtualizedItemPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1
		;[ "$UIA_IsWindowPatternAvailablePropertyId"            ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_IsWindowPatternAvailablePropertyId, $vValue )
		$aElemDetails[$i][1] = $vValue
		If $vValue Then
			$aControlPatts[$iControlPatts] = $i
			$aPatterns[$iControlPatts] = $oPatterns( $UIA_IsWindowPatternAvailablePropertyId ) 
			$iControlPatts += 1
		Else
			$aControlPattsUnavail[$iControlPattsUnavail] = $i
			$aPatternsUnavail[$iControlPattsUnavail] = $oPatterns( $UIA_IsWindowPatternAvailablePropertyId ) 
			$iControlPattsUnavail += 1
		EndIf
		$i += 1

		; --- Control Pattern Properties ---

		Local $aControlProps[$aElemDetailsIdx[9]+2] = [ $i+0, $i+1 ], $iControlProps = 2
		Local $oCtrlPropGrps = ObjCreate( "Scripting.Dictionary" ), $iCtrlPropGrps = 0
		Local $aControlPropsUnavail[$aElemDetailsIdx[9]+2] = [ $i+2, $i+3 ], $iControlPropsUnavail = 2
		Local $oCtrlPropGrpsUnavail = ObjCreate( "Scripting.Dictionary" ), $iCtrlPropGrpsUnavail = 0
		$i += 4

		If $i <> $aElemDetailsIdx[10] Then Return
		;[ "$UIA_AnnotationAnnotationTypeIdPropertyId",         0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationAnnotationTypeIdPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then                       ; The If-statement indicates whether the pattern exists.
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then          ; If the pattern exists, the current property is always in-
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps          ; cluded in the detail info even if the property value cor-
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8 ; responds to the default value. It may need to be changed
					$iCtrlPropGrps += 1                                              ; so that a property is only included if it's different from
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then       ; default. See eg. $UIA_ControllerForPropertyId above.
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		;Else                        ; Although $aElemDetails[$i][1] is pre-populated with an index in $aElemDetailsArr,
			;$aElemDetails[$i][1] = "" ; these two lines are redundant. The particular line in $aElemDetailsArr specified
		EndIf                        ; by $i isn't included in either $aControlProps or $aControlPropsUnavail.
		$i += 1
		;[ "$UIA_AnnotationAnnotationTypeNamePropertyId",       ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationAnnotationTypeNamePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_AnnotationAuthorPropertyId",                   ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationAuthorPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_AnnotationDateTimePropertyId",                 ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationDateTimePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_AnnotationTargetPropertyId",                   NULL                     ], _ ; Windows 8, VT_UNKNOWN
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_AnnotationTargetPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsObj( $vValue ) Then
				AccVars01( UIASpy_GetElement, $vValue )
				$oAutomationElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $vValue )
				If $vValue Then $sValue = $vValue
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_DockDockPositionPropertyId",                   $DockPosition_None,             ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_DockDockPositionPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		If $aElemDetails[$i][1] >= 0 And $aElemDetails[$i][1] < UBound( $aUIA_DockPositions ) Then _
			$aElemDetails[$i][1] = $aUIA_DockPositions[$aElemDetails[$i][1]]
		$i += 1
		;[ "$UIA_DragDropEffectPropertyId",                     ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DragDropEffectPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_DragDropEffectsPropertyId"                     ], _ ; Empty array            ; Windows 8, VT_BSTR    | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DragDropEffectsPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_DragGrabbedItemsPropertyId"                    ], _ ; Empty array            ; Windows 8, VT_UNKNOWN | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DragGrabbedItemsPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsObj( $vValue ) Then
				AccVars01( UIASpy_GetElementArray, $vValue )
			  $oAutomationElementArray.Length( $iLength )
			  If $iLength Then
				  For $j = 0 To $iLength - 1
				    $oAutomationElementArray.GetElement( $j, $pElement )
				    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
				    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
						$sValue &= $sValue ? "," & $sPropVal : $sPropVal
				  Next
				EndIf
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_DragIsGrabbedPropertyId",                      -1                       ], _ ; Windows 8, VT_BOOL
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DragIsGrabbedPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_DropTargetDropTargetEffectPropertyId",         0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DropTargetDropTargetEffectPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_DropTargetDropTargetEffectsPropertyId",        ], _ ; Empty array            ; Windows 8, VT_BSTR    | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_DropTargetDropTargetEffectsPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_ExpandCollapseExpandCollapseStatePropertyId",  $ExpandCollapseState_LeafNode   ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ExpandCollapseExpandCollapseStatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		If $aElemDetails[$i][1] >= 0 And $aElemDetails[$i][1] < UBound( $aUIA_ExpandCollapseStates ) Then _
			$aElemDetails[$i][1] = $aUIA_ExpandCollapseStates[$aElemDetails[$i][1]]
		$i += 1
		;[ "$UIA_GridColumnCountPropertyId",                    0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridColumnCountPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_GridRowCountPropertyId",                       0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridRowCountPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_GridItemColumnPropertyId",                     0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridItemColumnPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_GridItemColumnSpanPropertyId",                 1                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridItemColumnSpanPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_GridItemContainingGridPropertyId",             NULL                            ], _ ; VT_UNKNOWN
		$oUIElement.GetCurrentPropertyValue( $UIA_GridItemContainingGridPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElement, $vValue )
			$oAutomationElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $vValue )
			If $vValue Then $sValue = $vValue
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_GridItemRowPropertyId",                        0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridItemRowPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_GridItemRowSpanPropertyId",                    1                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_GridItemRowSpanPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleChildIdPropertyId",           0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleChildIdPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleDefaultActionPropertyId",     ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleDefaultActionPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleDescriptionPropertyId",       ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleDescriptionPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleHelpPropertyId",              ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleHelpPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleKeyboardShortcutPropertyId",  ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleKeyboardShortcutPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleNamePropertyId",              ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleNamePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_LegacyIAccessibleRolePropertyId",              0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleRolePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue & " = " & $aUIA_LegacyIAccessibleRoles[$vValue]
		$i += 1
		;[ "$UIA_LegacyIAccessibleSelectionPropertyId"          ], _ ; Empty array
		;$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleSelectionPropertyId, $vValue )
		; $UIA_LegacyIAccessibleSelectionPropertyId seems to be the cause of the Shell problems in Windows 7.
		; The property is special in that it returns an array of IUnknown pointers. The problems arise during
		; calculation of "Pane: Control Host" and "Tree: Namespace Tree Control".
		$i += 1
		;[ "$UIA_LegacyIAccessibleStatePropertyId",             0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleStatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		Local $s
		For $j = 0 To 30
			If BitAND( 2^$j, $vValue ) Then $s &= $s ? "+" & $aUIA_LegacyIAccessibleStates[$j] : $aUIA_LegacyIAccessibleStates[$j]
		Next
		If Not $s Then $s = "$STATE_SYSTEM_NORMAL"
		$aElemDetails[$i][1] = $vValue & " = " & $s
		$i += 1
		;[ "$UIA_LegacyIAccessibleValuePropertyId",             ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_LegacyIAccessibleValuePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_MultipleViewCurrentViewPropertyId",            0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_MultipleViewCurrentViewPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_MultipleViewSupportedViewsPropertyId"          ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_MultipleViewSupportedViewsPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsArray( $vValue ) And UBound( $vValue ) Then
			$sValue = $vValue[0]
			For $j = 1 To UBound( $vValue ) - 1
				$sValue &= "," & $vValue[$j]
			Next
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_RangeValueIsReadOnlyPropertyId",               -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueIsReadOnlyPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_RangeValueLargeChangePropertyId",              0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueLargeChangePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_RangeValueMaximumPropertyId",                  0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueMaximumPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_RangeValueMinimumPropertyId",                  0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueMinimumPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_RangeValueSmallChangePropertyId",              0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueSmallChangePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_RangeValueValuePropertyId",                    0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_RangeValueValuePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollHorizontallyScrollablePropertyId",       -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollHorizontallyScrollablePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollHorizontalScrollPercentPropertyId",      0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollHorizontalScrollPercentPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollHorizontalViewSizePropertyId",           100                             ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollHorizontalViewSizePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollVerticallyScrollablePropertyId",         -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollVerticallyScrollablePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollVerticalScrollPercentPropertyId",        0                               ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollVerticalScrollPercentPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ScrollVerticalViewSizePropertyId",             100                             ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ScrollVerticalViewSizePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_SelectionCanSelectMultiplePropertyId",         -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_SelectionCanSelectMultiplePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_SelectionIsSelectionRequiredPropertyId",       -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_SelectionIsSelectionRequiredPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_SelectionSelectionPropertyId"                  ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_SelectionSelectionPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
			$oAutomationElementArray.Length( $iLength )
			If $iLength Then
				For $j = 0 To $iLength - 1
					$oAutomationElementArray.GetElement( $j, $pElement )
					$oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
					$oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
				Next
			EndIf
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_SelectionItemIsSelectedPropertyId",            -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_SelectionItemIsSelectedPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_SelectionItemSelectionContainerPropertyId",    NULL                            ], _ ; VT_UNKNOWN
		$oUIElement.GetCurrentPropertyValue( $UIA_SelectionItemSelectionContainerPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElement, $vValue )
			$oAutomationElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $vValue )
			If $vValue Then $sValue = $vValue
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_SelectionCanSelectMultiplePropertyId",         -1                              ], _
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SelectionCanSelectMultiplePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_SelectionIsSelectionRequiredPropertyId",       -1                              ], _
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SelectionIsSelectionRequiredPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_SelectionSelectionPropertyId"                  ], _ ; Empty array
		If $bW10 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SelectionSelectionPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsObj( $vValue ) Then
				AccVars01( UIASpy_GetElementArray, $vValue )
			  $oAutomationElementArray.Length( $iLength )
			  If $iLength Then
				  For $j = 0 To $iLength - 1
				    $oAutomationElementArray.GetElement( $j, $pElement )
				    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
				    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
						$sValue &= $sValue ? "," & $sPropVal : $sPropVal
				  Next
				EndIf
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_Selection2FirstSelectedItemPropertyId",        55+17                    ], _ ; Windows 10
		If $bW10 Then _
			$oUIElement.GetCurrentPropertyValue( $UIA_Selection2FirstSelectedItemPropertyId, $vValue )
		$i += 1
		;[ "$UIA_Selection2LastSelectedItemPropertyId",         55+17                    ], _ ; Windows 10
		If $bW10 Then _
			$oUIElement.GetCurrentPropertyValue( $UIA_Selection2LastSelectedItemPropertyId, $vValue )
		$i += 1
		;[ "$UIA_Selection2CurrentSelectedItemPropertyId",      55+17                    ], _ ; Windows 10
		If $bW10 Then _
			$oUIElement.GetCurrentPropertyValue( $UIA_Selection2CurrentSelectedItemPropertyId, $vValue )
		$i += 1
		;[ "$UIA_Selection2ItemCountPropertyId",                55+17                    ], _ ; Windows 10
		If $bW10 Then _
			$oUIElement.GetCurrentPropertyValue( $UIA_Selection2ItemCountPropertyId, $vValue )
		$i += 1
		;[ "$UIA_SpreadsheetItemAnnotationObjectsPropertyId"    ], _ ; Empty array            ; Windows 8, VT_UNKNOWN | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SpreadsheetItemAnnotationObjectsPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsObj( $vValue ) Then
				AccVars01( UIASpy_GetElementArray, $vValue )
			  $oAutomationElementArray.Length( $iLength )
			  If $iLength Then
				  For $j = 0 To $iLength - 1
				    $oAutomationElementArray.GetElement( $j, $pElement )
				    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
				    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
						$sValue &= $sValue ? "," & $sPropVal : $sPropVal
				  Next
				EndIf
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_SpreadsheetItemAnnotationTypesPropertyId"      ], _ ; Empty array            ; Windows 8, VT_I4      | VT_ARRAY
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SpreadsheetItemAnnotationTypesPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$sValue = ""
			If IsArray( $vValue ) And UBound( $vValue ) Then
				$sValue = $vValue[0]
				For $j = 1 To UBound( $vValue ) - 1
					$sValue &= "," & $vValue[$j]
				Next
			EndIf
			$aElemDetails[$i][1] = $sValue
		EndIf
		$i += 1
		;[ "$UIA_SpreadsheetItemFormulaPropertyId",             ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_SpreadsheetItemFormulaPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesExtendedPropertiesPropertyId",           ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesExtendedPropertiesPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesFillColorPropertyId",                    0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesFillColorPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesFillPatternColorPropertyId",             0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesFillPatternColorPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesFillPatternStylePropertyId",             ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesFillPatternStylePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesShapePropertyId",                        ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesShapePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesStyleIdPropertyId",                      0                        ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesStyleIdPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_StylesStyleNamePropertyId",                    ""                       ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_StylesStyleNamePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_TableColumnHeadersPropertyId"                  ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_TableColumnHeadersPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_TableRowHeadersPropertyId"                     ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_TableRowHeadersPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_TableRowOrColumnMajorPropertyId",              $RowOrColumnMajor_Indeterminate ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_TableRowOrColumnMajorPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_TableItemColumnHeaderItemsPropertyId"          ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_TableItemColumnHeaderItemsPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_TableItemRowHeaderItemsPropertyId"             ], _ ; Empty array
		$oUIElement.GetCurrentPropertyValue( $UIA_TableItemRowHeaderItemsPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$sValue = ""
		If IsObj( $vValue ) Then
			AccVars01( UIASpy_GetElementArray, $vValue )
		  $oAutomationElementArray.Length( $iLength )
		  If $iLength Then
			  For $j = 0 To $iLength - 1
			    $oAutomationElementArray.GetElement( $j, $pElement )
			    $oElement = ObjCreateInterface( $pElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement )
			    $oElement.GetCurrentPropertyValue( $UIA_NamePropertyId, $sPropVal )
					$sValue &= $sValue ? "," & $sPropVal : $sPropVal
			  Next
			EndIf
		EndIf
		$aElemDetails[$i][1] = $sValue
		$i += 1
		;[ "$UIA_ToggleToggleStatePropertyId",                  $ToggleState_Indeterminate      ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ToggleToggleStatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		If $aElemDetails[$i][1] >= 0 And $aElemDetails[$i][1] < UBound( $aUIA_ToggleStates ) Then _
			$aElemDetails[$i][1] = $aUIA_ToggleStates[$aElemDetails[$i][1]]
		$i += 1
		;[ "$UIA_TransformCanMovePropertyId",                   -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanMovePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_TransformCanResizePropertyId",                 -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanResizePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_TransformCanRotatePropertyId",                 -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanRotatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_TransformCanMovePropertyId",                   -1                              ], _
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanMovePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_TransformCanResizePropertyId",                 -1                              ], _
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanResizePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_TransformCanRotatePropertyId",                 -1                              ], _
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_TransformCanRotatePropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_Transform2CanZoomPropertyId",                  -1                       ], _ ; Windows 8, VT_BOOL
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_Transform2CanZoomPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_Transform2ZoomLevelPropertyId",                1.0                      ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_Transform2ZoomLevelPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_Transform2ZoomMaximumPropertyId",              1.0                      ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_Transform2ZoomMaximumPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_Transform2ZoomMinimumPropertyId",              1.0                      ], _ ; Windows 8
		If $bW8 Then
			$oUIElement.GetCurrentPropertyValue( $UIA_Transform2ZoomMinimumPropertyId, $vValue )
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
					If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrps += 1
				ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlProps[$iControlProps] = $i
				$iControlProps += 1
			Else
				If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
					$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
					If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
					$iCtrlPropGrpsUnavail += 1
				ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
					$aElemDetails[$i][2] = 0xE8E8E8
				EndIf
				$aControlPropsUnavail[$iControlPropsUnavail] = $i
				$iControlPropsUnavail += 1
			EndIf
			$aElemDetails[$i][1] = $vValue
		EndIf
		$i += 1
		;[ "$UIA_ValueIsReadOnlyPropertyId",                    -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ValueIsReadOnlyPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_ValueValuePropertyId",                         ""                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_ValueValuePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_WindowCanMaximizePropertyId",                  -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowCanMaximizePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_WindowCanMinimizePropertyId",                  -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowCanMinimizePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_WindowIsModalPropertyId",                      -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowIsModalPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_WindowIsTopmostPropertyId",                    -1                              ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowIsTopmostPropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		$i += 1
		;[ "$UIA_WindowWindowInteractionStatePropertyId",       $WindowInteractionState_Running ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowWindowInteractionStatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		If $aElemDetails[$i][1] >= 0 And $aElemDetails[$i][1] < UBound( $aUIA_WindowInteractionStates ) Then _
			$aElemDetails[$i][1] = $aUIA_WindowInteractionStates[$aElemDetails[$i][1]]
		$i += 1
		;[ "$UIA_WindowWindowVisualStatePropertyId",            $WindowVisualState_Normal       ], _
		$oUIElement.GetCurrentPropertyValue( $UIA_WindowWindowVisualStatePropertyId, $vValue )
		If $aElemDetails[$aElemDetails[$i][1]][1] Then
			If Not $oCtrlPropGrps.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrps( $aElemDetails[$i][1] ) = $iCtrlPropGrps
				If Mod( $iCtrlPropGrps, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrps += 1
			ElseIf Mod( $oCtrlPropGrps( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlProps[$iControlProps] = $i
			$iControlProps += 1
		Else
			If Not $oCtrlPropGrpsUnavail.Exists( $aElemDetails[$i][1] ) Then
				$oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ) = $iCtrlPropGrpsUnavail
				If Mod( $iCtrlPropGrpsUnavail, 2 ) Then $aElemDetails[$i][2] = 0xE8E8E8
				$iCtrlPropGrpsUnavail += 1
			ElseIf Mod( $oCtrlPropGrpsUnavail( $aElemDetails[$i][1] ), 2 ) Then
				$aElemDetails[$i][2] = 0xE8E8E8
			EndIf
			$aControlPropsUnavail[$iControlPropsUnavail] = $i
			$iControlPropsUnavail += 1
		EndIf
		$aElemDetails[$i][1] = $vValue
		If $aElemDetails[$i][1] >= 0 And $aElemDetails[$i][1] < UBound( $aUIA_WindowVisualStates ) Then _
			$aElemDetails[$i][1] = $aUIA_WindowVisualStates[$aElemDetails[$i][1]]
		$i += 1

		; --- Control Pattern Methods ---

		Local $aControlMthds[$aElemDetailsIdx[13]+2] = [ $i+0, $i+1 ], $iControlMthds = 2
		Local $aControlMthdsUnavail[$aElemDetailsIdx[13]+2] = [ $i+2, $i+3 ], $iControlMthdsUnavail = 2
		$i += 4                                                                                                    ; $i = $aElemDetailsIdx[14]

		If $i <> $aElemDetailsIdx[14] Then Return
		;[ "$UIA_IsAnnotationPatternAvailablePropertyId"              ], _ ; First                                 ; $i = $aElemDetailsIdx[6]
		For $k = 1 To $aElemDetailsIdx[5]
			If $aElemDetails[$aElemDetails[$i][1]][1] Then
				$aControlMthds[$iControlMthds] = $i
				$j = 1
				While $aElemDetails[$i+$j][1] = $aElemDetails[$i][1]
					$aControlMthds[$iControlMthds+$j] = $i+$j
					$aElemDetails[$i+$j][1] = $aElemDetails[$i+$j][0]
					$aElemDetails[$i+$j][0] = ""
					$j += 1
				WEnd
				$iControlMthds += $j
			Else
				$aControlMthdsUnavail[$iControlMthdsUnavail] = $i
				$j = 1
				While $aElemDetails[$i+$j][1] = $aElemDetails[$i][1]
					$aControlMthdsUnavail[$iControlMthdsUnavail+$j] = $i+$j
					$aElemDetails[$i+$j][1] = $aElemDetails[$i+$j][0]
					$aElemDetails[$i+$j][0] = ""
					$j += 1
				WEnd
				$iControlMthdsUnavail += $j
			EndIf
			$aElemDetails[$i][1] = ""
			$i += $j
		Next
		;[ "$UIA_IsWindowPatternAvailablePropertyId"            ], _ ; Last

		; $UIA_IsLegacyIAccessiblePatternAvailablePropertyId True -->
		; $UIA_IsLegacyIAccessiblePatternAvailablePropertyId True (LegacyIAccessiblePattern)
		For $j = 0 To $iControlPatts - 1
			$aElemDetails[$aControlPatts[$j]][1] &= $aPatterns[$j]
		Next
		For $j = 0 To $iControlPattsUnavail - 1
			$aElemDetails[$aControlPattsUnavail[$j]][1] &= $aPatternsUnavail[$j]
		Next
	EndIf

	; Index in $aElemDetails
	$i = $aElemDetailsIdx[15] + 1

	; --- Additional element info ---

	Local $aElementInfo[100], $iElementInfo = 0

	; --- Parents from Desktop ---

	If Not BitAND( $aElems[$iIdx][8], 1 ) Then
		$aElementInfo[$iElementInfo] = $i
		$iElementInfo += 1
		$i += 1
	EndIf

	$aElemDetails[$i][0] = "Parents from Desktop"
	$aElemDetails[$i][1] = $iIdx ? $aElems[0][2] : ""
	$aElemDetails[$i][2] = 0xFFFFE0
	$aElementInfo[$iElementInfo] = $i
	$iElementInfo += 1
	$i += 1

	If $iIdx Then
		Local $aParents[100], $iParents = 0
		Local $hItem = $aElems[$iIdx][4], $hParent
		Local $tItem = DllStructCreate( $tagTVITEMEX )
		DllStructSetData( $tItem, "Mask", $TVIF_PARAM )
		; _GUICtrlTreeView_GetParentHandle
		$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hItem )[0]
		While $hParent
			; _GUICtrlTreeView_GetItemParam()
			DllStructSetData( $tItem, "hItem", $hParent )
			DllCall( "user32.dll", "lresult", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETITEMW, "wparam", 0, "struct*", $tItem )
			$aParents[$iParents] = $aElems[DllStructGetData($tItem,"Param")-100000][2]
			$iParents += 1
			; _GUICtrlTreeView_GetParentHandle
			$hParent = DllCall( "user32.dll", "handle", "SendMessageW", "hwnd", $hTV, "uint", $TVM_GETNEXTITEM, "wparam", $TVGN_PARENT, "handle", $hParent )[0]
		WEnd
		For $j = $iParents - 2 To 0 Step -1
			$aElemDetails[$i][0] = ""
			$aElemDetails[$i][1] = $aParents[$j]
			$aElemDetails[$i][2] = ""
			$aElementInfo[$iElementInfo] = $i
			$iElementInfo += 1
			$i += 1
		Next
	EndIf

	; --- Parent to child index ---

	$aElemDetails[$i][0] = ""
	$aElemDetails[$i][1] = ""
	$aElemDetails[$i][2] = ""
	$aElementInfo[$iElementInfo] = $i
	$iElementInfo += 1
	$i += 1

	$aElemDetails[$i][0] = "Parent to child index"
	$aElemDetails[$i][1] = $aElems[$iIdx][6]
	$aElemDetails[$i][2] = 0xFFFFE0
	$aElementInfo[$iElementInfo] = $i
	$iElementInfo += 1
	$i += 1

	; --- All element info ---

	If Not BitAND( $aElems[$iIdx][8], 1 ) Then ; Valid elements only
		Local $aElemIndexes1 = [ [ $aElementProps,    $iElementProps                                                  ], _
		                         [ $aElementPropsSes, $iElementPropsSes                                               ], _
		                         [ $aElementPropsInf, $iElementPropsInf                                               ], _
		                         [ $aElementPropsIs,  $iElementPropsIs,  $aElementPropsDefault, $iElementPropsDefault ], _
		                         [ $aControlPatts,    $iControlPatts,    $aControlPattsUnavail, $iControlPattsUnavail ], _
		                         [ $aControlProps,    $iControlProps,    $aControlPropsUnavail, $iControlPropsUnavail ], _
		                         [ $aControlMthds,    $iControlMthds,    $aControlMthdsUnavail, $iControlMthdsUnavail ], _
		                         [ $aElementInfo,     $iElementInfo                                                   ] ]
	EndIf

	Local $aElemIndexes2 =   [ [ $aElementProps,    $iElementProps                                                  ], _
	                           [ $aElementInfo,     $iElementInfo                                                   ] ]

	Local $aElemIndexes = Not BitAND( $aElems[$iIdx][8], 1 ) ? $aElemIndexes1 : $aElemIndexes2
	Local $aElemInfoAll = [ $aElemDetails, $aElemIndexes ]
	Return $aElemInfoAll
EndFunc

Func UIASpy_GetElement( $pVariant )
	Local $pPtr = DllStructGetData( DllStructCreate( "ptr", $pVariant + 8 ), 1 )
  $oAutomationElement = ObjCreateInterFace( $pPtr, $sIIDIUIAutomationElement, $dtagIUIAutomationElement )
EndFunc

Func UIASpy_GetElementArray( $pVariant )
	Local $pPtr = DllStructGetData( DllStructCreate( "ptr", $pVariant + 8 ), 1 )
  $oAutomationElementArray = ObjCreateInterFace( $pPtr, $sIID_IUIAutomationElementArray, $dtag_IUIAutomationElementArray )
EndFunc

Func UIASpy_ShowElemInfo( $iIdx )
	If $fClipCopy Or $fCodePage Or $bUIAHelp Then ReDim $aElemIndex[490]
	If Not IsArray( $aElems[$iIdx][7] ) Then
		$aElems[$iIdx][7] = UIASpy_ElemInfo( $iIdx )
		If IsArray( $aElems[$iIdx][7] ) And Not BitAND( $aElems[$iIdx][8], 1 ) Then _
			$aElems[$iIdx][8] = BitOR( $aElems[$iIdx][8], 2 )
	EndIf
	Local $aElemIndexes = ($aElems[$iIdx][7])[1], $aIndex, $jCnt = 0
	If BitAND( $aElems[$iIdx][8], 2 ) Then
		For $i = 0 To 7
			$aIndex = $aElemIndexes[$i][0]
			For $j = 0 To $aElemIndexes[$i][1]
				$aElemIndex[$j+$jCnt] = $aIndex[$j]
			Next
			$jCnt += $aElemIndexes[$i][1]
			If $bElemDetailsAll And $i > 2 And $i < 7 Then
				$aIndex = $aElemIndexes[$i][2]
				For $j = 0 To $aElemIndexes[$i][3]
					$aElemIndex[$j+$jCnt] = $aIndex[$j]
				Next
				$jCnt += $aElemIndexes[$i][3]
			EndIf
		Next
	Else
		For $i = 0 To 1
			$aIndex = $aElemIndexes[$i][0]
			For $j = 0 To $aElemIndexes[$i][1]
				$aElemIndex[$j+$jCnt] = $aIndex[$j]
			Next
			$jCnt += $aElemIndexes[$i][1]
		Next
	EndIf
	$iElemDetails = $jCnt
	$aElemDetails = ($aElems[$iIdx][7])[0]
	If BitAND( $aElems[$iIdx][8], 1 ) Then $aElemDetails[0][2] = 0xCCCCFF
	;_GUICtrlListView_BeginUpdate( $idLV )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 0, 0 )
	If $fClipCopy Or $fCodePage Or $bUIAHelp Then
		_GUICtrlListView_SetColumnWidth( $idLV, 0, $iLvCol0Width )
		_GUICtrlListView_SetColumnWidth( $idLV, 1, $iGuiWidth - ( WinGetClientSize( $hTV )[0] + 30 ) - $iLvCol0Width - 30 )
		_GUICtrlHeader_SetItemAlign( $hHeader, 0, 0 ) ; 0 = Text is left-aligned
		_GUICtrlHeader_SetItemText( $hHeader, 0, "Property name" )
		_GUICtrlHeader_SetItemText( $hHeader, 1, "Property value" )
		$fClipCopy = False
		$fCodePage = False
		$bUIAHelp = False
	EndIf
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, 0, 0 ) ; Reset selected rows
	GUICtrlSendMsg( $idLV, $LVM_SETITEMCOUNT, $iElemDetails, 0 )
	GUICtrlSendMsg( $idLV, $LVM_ENSUREVISIBLE, 0, 0 )
	;_GUICtrlListView_EnsureVisible( $idLV, 0 )
	GUICtrlSendMsg( $idLV, $WM_SETREDRAW, 1, 0 )
	;_GUICtrlListView_EndUpdate( $idLV )
	UIASpy_ListView_SetColumn1Width()
EndFunc

Func UIASpy_CopyElemInfo( $bSel = True )
	Local $iSel = _GUICtrlListView_GetSelectedCount( $idLV ), $s
	If $iSel And $bSel Then
		Local $aSel = _GUICtrlListView_GetSelectedIndices( $idLV, True )
		Switch $fClipCopy
			Case 0
				For $i = 1 To $aSel[0]
					$s &= StringFormat( "%-52s", $aElemDetails[$aElemIndex[$aSel[$i]]][0] ) & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & @CRLF
				Next
			Case 1 ; Copy tree
				For $i = 1 To $aSel[0]
					$s &= StringFormat( "%04i    ", $aElemDetails[$aElemIndex[$aSel[$i]]][0] ) & $aElemDetails[$aElemIndex[$aSel[$i]]][1] & @CRLF
				Next
			Case 2 ; Copy code
				For $i = 1 To $aSel[0]
					$s &= $aElemDetails[$aElemIndex[$aSel[$i]]][1] & @CRLF
				Next
		EndSwitch
	Else
		Switch $fClipCopy
			Case 0
				For $i = 0 To $iElemDetails - 1
					$s &= StringFormat( "%-52s", $aElemDetails[$aElemIndex[$i]][0] ) & $aElemDetails[$aElemIndex[$i]][1] & @CRLF
				Next
			Case 1 ; Copy tree
				For $i = 0 To $iElemDetails - 1
					$s &= StringFormat( "%04i    ", $aElemDetails[$aElemIndex[$i]][0] ) & $aElemDetails[$aElemIndex[$i]][1] & @CRLF
				Next
			Case 2 ; Copy code
				For $i = 0 To $iElemDetails - 1
					$s &= $aElemDetails[$aElemIndex[$i]][1] & @CRLF
				Next
		EndSwitch
	EndIf
	ClipPut( $s )
EndFunc
