Global Const $PS_SOLID = 0
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Global Const $FO_CREATEPATH = 8
Global Const $FO_UTF8 = 128
Global Const $FLTAR_FILESFOLDERS = 0
Global Const $FLTAR_NOHIDDEN = 4
Global Const $FLTAR_NOSYSTEM = 8
Global Const $FLTAR_NOLINK = 16
Global Const $FLTAR_NORECUR = 0
Global Const $FLTAR_NOSORT = 0
Global Const $FLTAR_RELPATH = 1
Global Const $STR_NOCASESENSEBASIC = 2
Global Const $STR_STRIPLEADING = 1
Global Const $STR_STRIPTRAILING = 2
Global Const $STR_ENTIRESPLIT = 1
Global Const $STR_NOCOUNT = 2
Global Const $STR_REGEXPMATCH = 0
Global Const $tagRECT = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $tagGDIPENCODERPARAM = "struct;byte GUID[16];ulong NumberOfValues;ulong Type;ptr Values;endstruct"
Global Const $tagGDIPENCODERPARAMS = "uint Count;" & $tagGDIPENCODERPARAM
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagGDIPIMAGECODECINFO = "byte CLSID[16];byte FormatID[16];ptr CodecName;ptr DllName;ptr FormatDesc;ptr FileExt;" & "ptr MimeType;dword Flags;dword Version;dword SigCount;dword SigSize;ptr SigPattern;ptr SigMask"
Global Const $tagREBARBANDINFO = "uint cbSize;uint fMask;uint fStyle;dword clrFore;dword clrBack;ptr lpText;uint cch;" & "int iImage;hwnd hwndChild;uint cxMinChild;uint cyMinChild;uint cx;handle hbmBack;uint wID;uint cyChild;uint cyMaxChild;" & "uint cyIntegral;uint cxIdeal;lparam lParam;uint cxHeader" &((@OSVersion = "WIN_XP") ? "" : ";" & $tagRECT & ";uint uChevronState")
Global Const $tagGUID = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $__tagCURSORINFO = "dword Size;dword Flags;handle hCursor;" & "struct;long X;long Y;endstruct"
Global Const $__WINVER = __WINVER()
Func _WinAPI_GetCursorInfo()
Local $tCursor = DllStructCreate($__tagCURSORINFO)
Local $iCursor = DllStructGetSize($tCursor)
DllStructSetData($tCursor, "Size", $iCursor)
Local $aRet = DllCall("user32.dll", "bool", "GetCursorInfo", "struct*", $tCursor)
If @error Or Not $aRet[0] Then Return SetError(@error + 10, @extended, 0)
Local $aCursor[5]
$aCursor[0] = True
$aCursor[1] = DllStructGetData($tCursor, "Flags") <> 0
$aCursor[2] = DllStructGetData($tCursor, "hCursor")
$aCursor[3] = DllStructGetData($tCursor, "X")
$aCursor[4] = DllStructGetData($tCursor, "Y")
Return $aCursor
EndFunc
Func __WINVER()
Local $tOSVI = DllStructCreate($tagOSVERSIONINFO)
DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
Local $aRet = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $tOSVI)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc
Func _WinAPI_GUIDFromString($sGUID)
Local $tGUID = DllStructCreate($tagGUID)
_WinAPI_GUIDFromStringEx($sGUID, $tGUID)
If @error Then Return SetError(@error + 10, @extended, 0)
Return $tGUID
EndFunc
Func _WinAPI_GUIDFromStringEx($sGUID, $tGUID)
Local $aResult = DllCall("ole32.dll", "long", "CLSIDFromString", "wstr", $sGUID, "struct*", $tGUID)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_StringFromGUID($tGUID)
Local $aResult = DllCall("ole32.dll", "int", "StringFromGUID2", "struct*", $tGUID, "wstr", "", "int", 40)
If @error Or Not $aResult[0] Then Return SetError(@error, @extended, "")
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_WideCharToMultiByte($vUnicode, $iCodePage = 0, $bRetNoStruct = True, $bRetBinary = False)
Local $sUnicodeType = "wstr"
If Not IsString($vUnicode) Then $sUnicodeType = "struct*"
Local $aResult = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $iCodePage, "dword", 0, $sUnicodeType, $vUnicode, "int", -1, "ptr", 0, "int", 0, "ptr", 0, "ptr", 0)
If @error Or Not $aResult[0] Then Return SetError(@error + 20, @extended, "")
Local $tMultiByte = DllStructCreate((($bRetBinary) ?("byte") :("char")) & "[" & $aResult[0] & "]")
$aResult = DllCall("kernel32.dll", "int", "WideCharToMultiByte", "uint", $iCodePage, "dword", 0, $sUnicodeType, $vUnicode, "int", -1, "struct*", $tMultiByte, "int", $aResult[0], "ptr", 0, "ptr", 0)
If @error Or Not $aResult[0] Then Return SetError(@error + 10, @extended, "")
If $bRetNoStruct Then Return DllStructGetData($tMultiByte, 1)
Return $tMultiByte
EndFunc
Func _WinAPI_DeleteObject($hObject)
Local $aResult = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hObject)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_SelectObject($hDC, $hGDIObj)
Local $aResult = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hGDIObj)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_BitBlt($hDestDC, $iXDest, $iYDest, $iWidth, $iHeight, $hSrcDC, $iXSrc, $iYSrc, $iROP)
Local $aResult = DllCall("gdi32.dll", "bool", "BitBlt", "handle", $hDestDC, "int", $iXDest, "int", $iYDest, "int", $iWidth, "int", $iHeight, "handle", $hSrcDC, "int", $iXSrc, "int", $iYSrc, "dword", $iROP)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_CreateCompatibleBitmap($hDC, $iWidth, $iHeight)
Local $aResult = DllCall("gdi32.dll", "handle", "CreateCompatibleBitmap", "handle", $hDC, "int", $iWidth, "int", $iHeight)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_CreateCompatibleDC($hDC)
Local $aResult = DllCall("gdi32.dll", "handle", "CreateCompatibleDC", "handle", $hDC)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_DeleteDC($hDC)
Local $aResult = DllCall("gdi32.dll", "bool", "DeleteDC", "handle", $hDC)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_DrawIcon($hDC, $iX, $iY, $hIcon)
Local $aResult = DllCall("user32.dll", "bool", "DrawIcon", "handle", $hDC, "int", $iX, "int", $iY, "handle", $hIcon)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetDC($hWnd)
Local $aResult = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetWindowDC($hWnd)
Local $aResult = DllCall("user32.dll", "handle", "GetWindowDC", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_ReleaseDC($hWnd, $hDC)
Local $aResult = DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $hWnd, "handle", $hDC)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Global Const $tagICONINFO = "bool Icon;dword XHotSpot;dword YHotSpot;handle hMask;handle hColor"
Func _WinAPI_CopyIcon($hIcon)
Local $aResult = DllCall("user32.dll", "handle", "CopyIcon", "handle", $hIcon)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_DestroyIcon($hIcon)
Local $aResult = DllCall("user32.dll", "bool", "DestroyIcon", "handle", $hIcon)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetIconInfo($hIcon)
Local $tInfo = DllStructCreate($tagICONINFO)
Local $aRet = DllCall("user32.dll", "bool", "GetIconInfo", "handle", $hIcon, "struct*", $tInfo)
If @error Or Not $aRet[0] Then Return SetError(@error + 10, @extended, 0)
Local $aIcon[6]
$aIcon[0] = True
$aIcon[1] = DllStructGetData($tInfo, "Icon") <> 0
$aIcon[2] = DllStructGetData($tInfo, "XHotSpot")
$aIcon[3] = DllStructGetData($tInfo, "YHotSpot")
$aIcon[4] = DllStructGetData($tInfo, "hMask")
$aIcon[5] = DllStructGetData($tInfo, "hColor")
Return $aIcon
EndFunc
Func _WinAPI_GetDesktopWindow()
Local $aResult = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetSystemMetrics($iIndex)
Local $aResult = DllCall("user32.dll", "int", "GetSystemMetrics", "int", $iIndex)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_CreatePen($iPenStyle, $iWidth, $iColor)
Local $aResult = DllCall("gdi32.dll", "handle", "CreatePen", "int", $iPenStyle, "int", $iWidth, "INT", $iColor)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_DrawLine($hDC, $iX1, $iY1, $iX2, $iY2)
_WinAPI_MoveTo($hDC, $iX1, $iY1)
If @error Then Return SetError(@error, @extended, False)
_WinAPI_LineTo($hDC, $iX2, $iY2)
If @error Then Return SetError(@error + 10, @extended, False)
Return True
EndFunc
Func _WinAPI_LineTo($hDC, $iX, $iY)
Local $aResult = DllCall("gdi32.dll", "bool", "LineTo", "handle", $hDC, "int", $iX, "int", $iY)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_MoveTo($hDC, $iX, $iY)
Local $aResult = DllCall("gdi32.dll", "bool", "MoveToEx", "handle", $hDC, "int", $iX, "int", $iY, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Global Const $_ARRAYCONSTANT_SORTINFOSIZE = 11
Global $__g_aArrayDisplay_SortInfo[$_ARRAYCONSTANT_SORTINFOSIZE]
Global Const $_ARRAYCONSTANT_tagLVITEM = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($nItem1, $nItem2, $hWnd)
If $__g_aArrayDisplay_SortInfo[3] = $__g_aArrayDisplay_SortInfo[4] Then
If Not $__g_aArrayDisplay_SortInfo[7] Then
$__g_aArrayDisplay_SortInfo[5] *= -1
$__g_aArrayDisplay_SortInfo[7] = 1
EndIf
Else
$__g_aArrayDisplay_SortInfo[7] = 1
EndIf
$__g_aArrayDisplay_SortInfo[6] = $__g_aArrayDisplay_SortInfo[3]
Local $sVal1 = __ArrayDisplay_GetItemText($hWnd, $nItem1, $__g_aArrayDisplay_SortInfo[3])
Local $sVal2 = __ArrayDisplay_GetItemText($hWnd, $nItem2, $__g_aArrayDisplay_SortInfo[3])
If $__g_aArrayDisplay_SortInfo[8] = 1 Then
If(StringIsFloat($sVal1) Or StringIsInt($sVal1)) Then $sVal1 = Number($sVal1)
If(StringIsFloat($sVal2) Or StringIsInt($sVal2)) Then $sVal2 = Number($sVal2)
EndIf
Local $nResult
If $__g_aArrayDisplay_SortInfo[8] < 2 Then
$nResult = 0
If $sVal1 < $sVal2 Then
$nResult = -1
ElseIf $sVal1 > $sVal2 Then
$nResult = 1
EndIf
Else
$nResult = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $sVal1, 'wstr', $sVal2)[0]
EndIf
$nResult = $nResult * $__g_aArrayDisplay_SortInfo[5]
Return $nResult
EndFunc
Func __ArrayDisplay_GetItemText($hWnd, $iIndex, $iSubItem = 0)
Local $tBuffer = DllStructCreate("wchar Text[4096]")
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($_ARRAYCONSTANT_tagLVITEM)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "TextMax", 4096)
DllStructSetData($tItem, "Text", $pBuffer)
If IsHWnd($hWnd) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", 0x1073, "wparam", $iIndex, "struct*", $tItem)
Else
Local $pItem = DllStructGetPtr($tItem)
GUICtrlSendMsg($hWnd, 0x1073, $iIndex, $pItem)
EndIf
Return DllStructGetData($tBuffer, "Text")
EndFunc
Global Enum $ARRAYFILL_FORCE_DEFAULT, $ARRAYFILL_FORCE_SINGLEITEM, $ARRAYFILL_FORCE_INT, $ARRAYFILL_FORCE_NUMBER, $ARRAYFILL_FORCE_PTR, $ARRAYFILL_FORCE_HWND, $ARRAYFILL_FORCE_STRING, $ARRAYFILL_FORCE_BOOLEAN
Func _ArrayAdd(ByRef $aArray, $vValue, $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYFILL_FORCE_DEFAULT)
If $iStart = Default Then $iStart = 0
If $sDelim_Item = Default Then $sDelim_Item = "|"
If $sDelim_Row = Default Then $sDelim_Row = @CRLF
If $iForce = Default Then $iForce = $ARRAYFILL_FORCE_DEFAULT
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
Local $hDataType = 0
Switch $iForce
Case $ARRAYFILL_FORCE_INT
$hDataType = Int
Case $ARRAYFILL_FORCE_NUMBER
$hDataType = Number
Case $ARRAYFILL_FORCE_PTR
$hDataType = Ptr
Case $ARRAYFILL_FORCE_HWND
$hDataType = Hwnd
Case $ARRAYFILL_FORCE_STRING
$hDataType = String
Case $ARRAYFILL_FORCE_BOOLEAN
$hDataType = "Boolean"
EndSwitch
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iForce = $ARRAYFILL_FORCE_SINGLEITEM Then
ReDim $aArray[$iDim_1 + 1]
$aArray[$iDim_1] = $vValue
Return $iDim_1
EndIf
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
$hDataType = 0
Else
Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
If UBound($aTmp, $UBOUND_ROWS) = 1 Then
$aTmp[0] = $vValue
EndIf
$vValue = $aTmp
EndIf
Local $iAdd = UBound($vValue, $UBOUND_ROWS)
ReDim $aArray[$iDim_1 + $iAdd]
For $i = 0 To $iAdd - 1
If String($hDataType) = "Boolean" Then
Switch $vValue[$i]
Case "True", "1"
$aArray[$iDim_1 + $i] = True
Case "False", "0", ""
$aArray[$iDim_1 + $i] = False
EndSwitch
ElseIf IsFunc($hDataType) Then
$aArray[$iDim_1 + $i] = $hDataType($vValue[$i])
Else
$aArray[$iDim_1 + $i] = $vValue[$i]
EndIf
Next
Return $iDim_1 + $iAdd - 1
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(4, 0, -1)
Local $iValDim_1, $iValDim_2 = 0, $iColCount
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(5, 0, -1)
$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
$hDataType = 0
Else
Local $aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
Local $aTmp[$iValDim_1][0], $aSplit_2
For $i = 0 To $iValDim_1 - 1
$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iColCount = UBound($aSplit_2)
If $iColCount > $iValDim_2 Then
$iValDim_2 = $iColCount
ReDim $aTmp[$iValDim_1][$iValDim_2]
EndIf
For $j = 0 To $iColCount - 1
$aTmp[$i][$j] = $aSplit_2[$j]
Next
Next
$vValue = $aTmp
EndIf
If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($aArray, $UBOUND_COLUMNS) Then Return SetError(3, 0, -1)
ReDim $aArray[$iDim_1 + $iValDim_1][$iDim_2]
For $iWriteTo_Index = 0 To $iValDim_1 - 1
For $j = 0 To $iDim_2 - 1
If $j < $iStart Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
ElseIf $j - $iStart > $iValDim_2 - 1 Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
Else
If String($hDataType) = "Boolean" Then
Switch $vValue[$iWriteTo_Index][$j - $iStart]
Case "True", "1"
$aArray[$iWriteTo_Index + $iDim_1][$j] = True
Case "False", "0", ""
$aArray[$iWriteTo_Index + $iDim_1][$j] = False
EndSwitch
ElseIf IsFunc($hDataType) Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = $hDataType($vValue[$iWriteTo_Index][$j - $iStart])
Else
$aArray[$iWriteTo_Index + $iDim_1][$j] = $vValue[$iWriteTo_Index][$j - $iStart]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS) - 1
EndFunc
Func _ArrayBinarySearch(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iColumn = 0)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iColumn = Default Then $iColumn = 0
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
If $iDim_1 = 0 Then Return SetError(6, 0, -1)
If $iEnd < 1 Or $iEnd > $iDim_1 - 1 Then $iEnd = $iDim_1 - 1
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Local $iMid = Int(($iEnd + $iStart) / 2)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $aArray[$iStart] > $vValue Or $aArray[$iEnd] < $vValue Then Return SetError(2, 0, -1)
While $iStart <= $iMid And $vValue <> $aArray[$iMid]
If $vValue < $aArray[$iMid] Then
$iEnd = $iMid - 1
Else
$iStart = $iMid + 1
EndIf
$iMid = Int(($iEnd + $iStart) / 2)
WEnd
If $iStart > $iEnd Then Return SetError(3, 0, -1)
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iColumn < 0 Or $iColumn > $iDim_2 Then Return SetError(7, 0, -1)
If $aArray[$iStart][$iColumn] > $vValue Or $aArray[$iEnd][$iColumn] < $vValue Then Return SetError(2, 0, -1)
While $iStart <= $iMid And $vValue <> $aArray[$iMid][$iColumn]
If $vValue < $aArray[$iMid][$iColumn] Then
$iEnd = $iMid - 1
Else
$iStart = $iMid + 1
EndIf
$iMid = Int(($iEnd + $iStart) / 2)
WEnd
If $iStart > $iEnd Then Return SetError(3, 0, -1)
Case Else
Return SetError(5, 0, -1)
EndSwitch
Return $iMid
EndFunc
Func _ArrayConcatenate(ByRef $aArrayTarget, Const ByRef $aArraySource, $iStart = 0)
If $iStart = Default Then $iStart = 0
If Not IsArray($aArrayTarget) Then Return SetError(1, 0, -1)
If Not IsArray($aArraySource) Then Return SetError(2, 0, -1)
Local $iDim_Total_Tgt = UBound($aArrayTarget, $UBOUND_DIMENSIONS)
Local $iDim_Total_Src = UBound($aArraySource, $UBOUND_DIMENSIONS)
Local $iDim_1_Tgt = UBound($aArrayTarget, $UBOUND_ROWS)
Local $iDim_1_Src = UBound($aArraySource, $UBOUND_ROWS)
If $iStart < 0 Or $iStart > $iDim_1_Src - 1 Then Return SetError(6, 0, -1)
Switch $iDim_Total_Tgt
Case 1
If $iDim_Total_Src <> 1 Then Return SetError(4, 0, -1)
ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart]
For $i = $iStart To $iDim_1_Src - 1
$aArrayTarget[$iDim_1_Tgt + $i - $iStart] = $aArraySource[$i]
Next
Case 2
If $iDim_Total_Src <> 2 Then Return SetError(4, 0, -1)
Local $iDim_2_Tgt = UBound($aArrayTarget, $UBOUND_COLUMNS)
If UBound($aArraySource, $UBOUND_COLUMNS) <> $iDim_2_Tgt Then Return SetError(5, 0, -1)
ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart][$iDim_2_Tgt]
For $i = $iStart To $iDim_1_Src - 1
For $j = 0 To $iDim_2_Tgt - 1
$aArrayTarget[$iDim_1_Tgt + $i - $iStart][$j] = $aArraySource[$i][$j]
Next
Next
Case Else
Return SetError(3, 0, -1)
EndSwitch
Return UBound($aArrayTarget, $UBOUND_ROWS)
EndFunc
Func _ArrayDelete(ByRef $aArray, $vRange)
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If IsArray($vRange) Then
If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
Else
Local $iNumber, $aSplit_1, $aSplit_2
$vRange = StringStripWS($vRange, 8)
$aSplit_1 = StringSplit($vRange, ";")
$vRange = ""
For $i = 1 To $aSplit_1[0]
If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
Switch $aSplit_2[0]
Case 1
$vRange &= $aSplit_2[1] & ";"
Case 2
If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
$iNumber = $aSplit_2[1] - 1
Do
$iNumber += 1
$vRange &= $iNumber & ";"
Until $iNumber = $aSplit_2[2]
EndIf
EndSwitch
Next
$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
EndIf
If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
Local $iCopyTo_Index = 0
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
$aArray[$iCopyTo_Index] = $aArray[$iReadFrom_Index]
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1]
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]][0] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index][0] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
For $j = 0 To $iDim_2
$aArray[$iCopyTo_Index][$j] = $aArray[$iReadFrom_Index][$j]
Next
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1][$iDim_2 + 1]
Case Else
Return SetError(2, 0, False)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS)
EndFunc
Func _ArrayReverse(ByRef $aArray, $iStart = 0, $iEnd = 0)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
If Not UBound($aArray) Then Return SetError(4, 0, 0)
Local $vTmp, $iUBound = UBound($aArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
$vTmp = $aArray[$i]
$aArray[$i] = $aArray[$iEnd]
$aArray[$iEnd] = $vTmp
$iEnd -= 1
Next
Return 1
EndFunc
Func _ArraySearch(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iForward = 1, $iSubItem = -1, $bRow = False)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iCase = Default Then $iCase = 0
If $iCompare = Default Then $iCompare = 0
If $iForward = Default Then $iForward = 1
If $iSubItem = Default Then $iSubItem = -1
If $bRow = Default Then $bRow = False
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray) - 1
If $iDim_1 = -1 Then Return SetError(3, 0, -1)
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
Local $bCompType = False
If $iCompare = 2 Then
$iCompare = 0
$bCompType = True
EndIf
If $bRow Then
If UBound($aArray, $UBOUND_DIMENSIONS) = 1 Then Return SetError(5, 0, -1)
If $iEnd < 1 Or $iEnd > $iDim_2 Then $iEnd = $iDim_2
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Else
If $iEnd < 1 Or $iEnd > $iDim_1 Then $iEnd = $iDim_1
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
EndIf
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If StringRegExp($aArray[$i], $vValue) Then Return $i
Else
If StringInStr($aArray[$i], $vValue, $iCase) > 0 Then Return $i
EndIf
Next
EndIf
Case 2
Local $iDim_Sub
If $bRow Then
$iDim_Sub = $iDim_1
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
Else
$iDim_Sub = $iDim_2
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
EndIf
For $j = $iSubItem To $iDim_Sub
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] = $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] = $vValue Then Return $i
EndIf
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] == $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] == $vValue Then Return $i
EndIf
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If $bRow Then
If StringRegExp($aArray[$j][$i], $vValue) Then Return $i
Else
If StringRegExp($aArray[$i][$j], $vValue) Then Return $i
EndIf
Else
If $bRow Then
If StringInStr($aArray[$j][$i], $vValue, $iCase) > 0 Then Return $i
Else
If StringInStr($aArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
EndIf
EndIf
Next
EndIf
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _ArraySort(ByRef $aArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0, $iPivot = 0)
If $iDescending = Default Then $iDescending = 0
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iSubItem = Default Then $iSubItem = 0
If $iPivot = Default Then $iPivot = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
Local $iUBound = UBound($aArray) - 1
If $iUBound = -1 Then Return SetError(5, 0, 0)
If $iEnd = Default Then $iEnd = 0
If $iEnd < 1 Or $iEnd > $iUBound Or $iEnd = Default Then $iEnd = $iUBound
If $iStart < 0 Or $iStart = Default Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iPivot Then
__ArrayDualPivotSort($aArray, $iStart, $iEnd)
Else
__ArrayQuickSort1D($aArray, $iStart, $iEnd)
EndIf
If $iDescending Then _ArrayReverse($aArray, $iStart, $iEnd)
Case 2
If $iPivot Then Return SetError(6, 0, 0)
Local $iSubMax = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
If $iDescending Then
$iDescending = -1
Else
$iDescending = 1
EndIf
__ArrayQuickSort2D($aArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
Case Else
Return SetError(4, 0, 0)
EndSwitch
Return 1
EndFunc
Func __ArrayQuickSort1D(ByRef $aArray, Const ByRef $iStart, Const ByRef $iEnd)
If $iEnd <= $iStart Then Return
Local $vTmp
If($iEnd - $iStart) < 15 Then
Local $vCur
For $i = $iStart + 1 To $iEnd
$vTmp = $aArray[$i]
If IsNumber($vTmp) Then
For $j = $i - 1 To $iStart Step -1
$vCur = $aArray[$j]
If($vTmp >= $vCur And IsNumber($vCur)) Or(Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
$aArray[$j + 1] = $vCur
Next
Else
For $j = $i - 1 To $iStart Step -1
If(StringCompare($vTmp, $aArray[$j]) >= 0) Then ExitLoop
$aArray[$j + 1] = $aArray[$j]
Next
EndIf
$aArray[$j + 1] = $vTmp
Next
Return
EndIf
Local $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While($aArray[$L] < $vPivot And IsNumber($aArray[$L])) Or(Not IsNumber($aArray[$L]) And StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While($aArray[$R] > $vPivot And IsNumber($aArray[$R])) Or(Not IsNumber($aArray[$R]) And StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
Else
While(StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While(StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
$vTmp = $aArray[$L]
$aArray[$L] = $aArray[$R]
$aArray[$R] = $vTmp
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort1D($aArray, $iStart, $R)
__ArrayQuickSort1D($aArray, $L, $iEnd)
EndFunc
Func __ArrayQuickSort2D(ByRef $aArray, Const ByRef $iStep, Const ByRef $iStart, Const ByRef $iEnd, Const ByRef $iSubItem, Const ByRef $iSubMax)
If $iEnd <= $iStart Then Return
Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While($iStep *($aArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($aArray[$L][$iSubItem])) Or(Not IsNumber($aArray[$L][$iSubItem]) And $iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep *($aArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($aArray[$R][$iSubItem])) Or(Not IsNumber($aArray[$R][$iSubItem]) And $iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
Else
While($iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While($iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
For $i = 0 To $iSubMax
$vTmp = $aArray[$L][$i]
$aArray[$L][$i] = $aArray[$R][$i]
$aArray[$R][$i] = $vTmp
Next
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort2D($aArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
__ArrayQuickSort2D($aArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc
Func __ArrayDualPivotSort(ByRef $aArray, $iPivot_Left, $iPivot_Right, $bLeftMost = True)
If $iPivot_Left > $iPivot_Right Then Return
Local $iLength = $iPivot_Right - $iPivot_Left + 1
Local $i, $j, $k, $iAi, $iAk, $iA1, $iA2, $iLast
If $iLength < 45 Then
If $bLeftMost Then
$i = $iPivot_Left
While $i < $iPivot_Right
$j = $i
$iAi = $aArray[$i + 1]
While $iAi < $aArray[$j]
$aArray[$j + 1] = $aArray[$j]
$j -= 1
If $j + 1 = $iPivot_Left Then ExitLoop
WEnd
$aArray[$j + 1] = $iAi
$i += 1
WEnd
Else
While 1
If $iPivot_Left >= $iPivot_Right Then Return 1
$iPivot_Left += 1
If $aArray[$iPivot_Left] < $aArray[$iPivot_Left - 1] Then ExitLoop
WEnd
While 1
$k = $iPivot_Left
$iPivot_Left += 1
If $iPivot_Left > $iPivot_Right Then ExitLoop
$iA1 = $aArray[$k]
$iA2 = $aArray[$iPivot_Left]
If $iA1 < $iA2 Then
$iA2 = $iA1
$iA1 = $aArray[$iPivot_Left]
EndIf
$k -= 1
While $iA1 < $aArray[$k]
$aArray[$k + 2] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 2] = $iA1
While $iA2 < $aArray[$k]
$aArray[$k + 1] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 1] = $iA2
$iPivot_Left += 1
WEnd
$iLast = $aArray[$iPivot_Right]
$iPivot_Right -= 1
While $iLast < $aArray[$iPivot_Right]
$aArray[$iPivot_Right + 1] = $aArray[$iPivot_Right]
$iPivot_Right -= 1
WEnd
$aArray[$iPivot_Right + 1] = $iLast
EndIf
Return 1
EndIf
Local $iSeventh = BitShift($iLength, 3) + BitShift($iLength, 6) + 1
Local $iE1, $iE2, $iE3, $iE4, $iE5, $t
$iE3 = Ceiling(($iPivot_Left + $iPivot_Right) / 2)
$iE2 = $iE3 - $iSeventh
$iE1 = $iE2 - $iSeventh
$iE4 = $iE3 + $iSeventh
$iE5 = $iE4 + $iSeventh
If $aArray[$iE2] < $aArray[$iE1] Then
$t = $aArray[$iE2]
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
If $aArray[$iE3] < $aArray[$iE2] Then
$t = $aArray[$iE3]
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
If $aArray[$iE4] < $aArray[$iE3] Then
$t = $aArray[$iE4]
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
If $aArray[$iE5] < $aArray[$iE4] Then
$t = $aArray[$iE5]
$aArray[$iE5] = $aArray[$iE4]
$aArray[$iE4] = $t
If $t < $aArray[$iE3] Then
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
EndIf
Local $iLess = $iPivot_Left
Local $iGreater = $iPivot_Right
If(($aArray[$iE1] <> $aArray[$iE2]) And($aArray[$iE2] <> $aArray[$iE3]) And($aArray[$iE3] <> $aArray[$iE4]) And($aArray[$iE4] <> $aArray[$iE5])) Then
Local $iPivot_1 = $aArray[$iE2]
Local $iPivot_2 = $aArray[$iE4]
$aArray[$iE2] = $aArray[$iPivot_Left]
$aArray[$iE4] = $aArray[$iPivot_Right]
Do
$iLess += 1
Until $aArray[$iLess] >= $iPivot_1
Do
$iGreater -= 1
Until $aArray[$iGreater] <= $iPivot_2
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk > $iPivot_2 Then
While $aArray[$iGreater] > $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
$aArray[$iPivot_Left] = $aArray[$iLess - 1]
$aArray[$iLess - 1] = $iPivot_1
$aArray[$iPivot_Right] = $aArray[$iGreater + 1]
$aArray[$iGreater + 1] = $iPivot_2
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 2, True)
__ArrayDualPivotSort($aArray, $iGreater + 2, $iPivot_Right, False)
If($iLess < $iE1) And($iE5 < $iGreater) Then
While $aArray[$iLess] = $iPivot_1
$iLess += 1
WEnd
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
WEnd
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk = $iPivot_2 Then
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iPivot_1
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
EndIf
__ArrayDualPivotSort($aArray, $iLess, $iGreater, False)
Else
Local $iPivot = $aArray[$iE3]
$k = $iLess
While $k <= $iGreater
If $aArray[$k] = $iPivot Then
$k += 1
ContinueLoop
EndIf
$iAk = $aArray[$k]
If $iAk < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
Else
While $aArray[$iGreater] > $iPivot
$iGreater -= 1
WEnd
If $aArray[$iGreater] < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $iPivot
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 1, True)
__ArrayDualPivotSort($aArray, $iGreater + 1, $iPivot_Right, False)
EndIf
EndFunc
Global Const $GDIP_EPGCOLORDEPTH = '{66087055-AD66-4C7C-9A18-38A2310B8337}'
Global Const $GDIP_EPGCOMPRESSION = '{E09D739D-CCD4-44EE-8EBA-3FBF8BE4FC58}'
Global Const $GDIP_EPGQUALITY = '{1D5BE4B5-FA4A-452D-9CDD-5DB35105E7EB}'
Global Const $GDIP_EPTLONG = 4
Global Const $GDIP_EVTCOMPRESSIONLZW = 2
Global Const $GDIP_PXF24RGB = 0x00021808
Global $__g_hGDIPDll = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Func _GDIPlus_BitmapCloneArea($hBitmap, $nLeft, $nTop, $nWidth, $nHeight, $iFormat = 0x00021808)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCloneBitmapArea", "float", $nLeft, "float", $nTop, "float", $nWidth, "float", $nHeight, "int", $iFormat, "handle", $hBitmap, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[7]
EndFunc
Func _GDIPlus_BitmapCreateFromHBITMAP($hBitmap, $hPal = 0)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateBitmapFromHBITMAP", "handle", $hBitmap, "handle", $hPal, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[3]
EndFunc
Func _GDIPlus_Encoders()
Local $iCount = _GDIPlus_EncodersGetCount()
Local $iSize = _GDIPlus_EncodersGetSize()
Local $tBuffer = DllStructCreate("byte[" & $iSize & "]")
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageEncoders", "uint", $iCount, "uint", $iSize, "struct*", $tBuffer)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tCodec, $aInfo[$iCount + 1][14]
$aInfo[0][0] = $iCount
For $iI = 1 To $iCount
$tCodec = DllStructCreate($tagGDIPIMAGECODECINFO, $pBuffer)
$aInfo[$iI][1] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "CLSID"))
$aInfo[$iI][2] = _WinAPI_StringFromGUID(DllStructGetPtr($tCodec, "FormatID"))
$aInfo[$iI][3] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "CodecName"))
$aInfo[$iI][4] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "DllName"))
$aInfo[$iI][5] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FormatDesc"))
$aInfo[$iI][6] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "FileExt"))
$aInfo[$iI][7] = _WinAPI_WideCharToMultiByte(DllStructGetData($tCodec, "MimeType"))
$aInfo[$iI][8] = DllStructGetData($tCodec, "Flags")
$aInfo[$iI][9] = DllStructGetData($tCodec, "Version")
$aInfo[$iI][10] = DllStructGetData($tCodec, "SigCount")
$aInfo[$iI][11] = DllStructGetData($tCodec, "SigSize")
$aInfo[$iI][12] = DllStructGetData($tCodec, "SigPattern")
$aInfo[$iI][13] = DllStructGetData($tCodec, "SigMask")
$pBuffer += DllStructGetSize($tCodec)
Next
Return $aInfo
EndFunc
Func _GDIPlus_EncodersGetCLSID($sFileExtension)
Local $aEncoders = _GDIPlus_Encoders()
If @error Then Return SetError(@error, 0, "")
For $iI = 1 To $aEncoders[0][0]
If StringInStr($aEncoders[$iI][6], "*." & $sFileExtension) > 0 Then Return $aEncoders[$iI][1]
Next
Return SetError(-1, -1, "")
EndFunc
Func _GDIPlus_EncodersGetCount()
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $aResult[0] Then Return SetError(10, $aResult[0], -1)
Return $aResult[1]
EndFunc
Func _GDIPlus_EncodersGetSize()
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageEncodersSize", "uint*", 0, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $aResult[0] Then Return SetError(10, $aResult[0], -1)
Return $aResult[2]
EndFunc
Func _GDIPlus_ImageDispose($hImage)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDisposeImage", "handle", $hImage)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_ImageGetHeight($hImage)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageHeight", "handle", $hImage, "uint*", 0)
If @error Then Return SetError(@error, @extended, -1)
If $aResult[0] Then Return SetError(10, $aResult[0], -1)
Return $aResult[2]
EndFunc
Func _GDIPlus_ImageGetWidth($hImage)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageWidth", "handle", $hImage, "uint*", -1)
If @error Then Return SetError(@error, @extended, -1)
If $aResult[0] Then Return SetError(10, $aResult[0], -1)
Return $aResult[2]
EndFunc
Func _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sEncoder, $tParams = 0)
Local $tGUID = _WinAPI_GUIDFromString($sEncoder)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSaveImageToFile", "handle", $hImage, "wstr", $sFileName, "struct*", $tGUID, "struct*", $tParams)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_ParamAdd(ByRef $tParams, $sGUID, $iNbOfValues, $iType, $pValues)
Local $iCount = DllStructGetData($tParams, "Count")
Local $pGUID = DllStructGetPtr($tParams, "GUID") +($iCount * _GDIPlus_ParamSize())
Local $tParam = DllStructCreate($tagGDIPENCODERPARAM, $pGUID)
_WinAPI_GUIDFromStringEx($sGUID, $pGUID)
DllStructSetData($tParam, "Type", $iType)
DllStructSetData($tParam, "NumberOfValues", $iNbOfValues)
DllStructSetData($tParam, "Values", $pValues)
DllStructSetData($tParams, "Count", $iCount + 1)
EndFunc
Func _GDIPlus_ParamInit($iCount)
Local $sStruct = $tagGDIPENCODERPARAMS
For $i = 2 To $iCount
$sStruct &= ";struct;byte[16];ulong;ulong;ptr;endstruct"
Next
Return DllStructCreate($sStruct)
EndFunc
Func _GDIPlus_ParamSize()
Local $tParam = DllStructCreate($tagGDIPENCODERPARAM)
Return DllStructGetSize($tParam)
EndFunc
Func _GDIPlus_Shutdown()
If $__g_hGDIPDll = 0 Then Return SetError(-1, -1, False)
$__g_iGDIPRef -= 1
If $__g_iGDIPRef = 0 Then
DllCall($__g_hGDIPDll, "none", "GdiplusShutdown", "ulong_ptr", $__g_iGDIPToken)
DllClose($__g_hGDIPDll)
$__g_hGDIPDll = 0
EndIf
Return True
EndFunc
Func _GDIPlus_Startup($sGDIPDLL = Default, $bRetDllHandle = False)
$__g_iGDIPRef += 1
If $__g_iGDIPRef > 1 Then Return True
If $sGDIPDLL = Default Then $sGDIPDLL = "gdiplus.dll"
$__g_hGDIPDll = DllOpen($sGDIPDLL)
If $__g_hGDIPDll = -1 Then
$__g_iGDIPRef = 0
Return SetError(1, 2, False)
EndIf
Local $sVer = FileGetVersion($sGDIPDLL)
$sVer = StringSplit($sVer, ".")
If $sVer[1] > 5 Then $__g_bGDIP_V1_0 = False
Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
Local $tToken = DllStructCreate("ulong_ptr Data")
DllStructSetData($tInput, "Version", 1)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
$__g_iGDIPToken = DllStructGetData($tToken, "Data")
If $bRetDllHandle Then Return $__g_hGDIPDll
Return SetExtended($sVer[1], True)
EndFunc
Func __GDIPlus_ExtractFileExt($sFileName, $bNoDot = True)
Local $iIndex = __GDIPlus_LastDelimiter(".\:", $sFileName)
If($iIndex > 0) And(StringMid($sFileName, $iIndex, 1) = '.') Then
If $bNoDot Then
Return StringMid($sFileName, $iIndex + 1)
Else
Return StringMid($sFileName, $iIndex)
EndIf
Else
Return ""
EndIf
EndFunc
Func __GDIPlus_LastDelimiter($sDelimiters, $sString)
Local $sDelimiter, $iN
For $iI = 1 To StringLen($sDelimiters)
$sDelimiter = StringMid($sDelimiters, $iI, 1)
$iN = StringInStr($sString, $sDelimiter, $STR_NOCASESENSEBASIC, -1)
If $iN > 0 Then Return $iN
Next
EndFunc
Global $__g_iBMPFormat = $GDIP_PXF24RGB
Global $__g_iJPGQuality = 100
Global $__g_iTIFColorDepth = 24
Global $__g_iTIFCompression = $GDIP_EVTCOMPRESSIONLZW
Global Const $__SCREENCAPTURECONSTANT_SM_CXSCREEN = 0
Global Const $__SCREENCAPTURECONSTANT_SM_CYSCREEN = 1
Global Const $__SCREENCAPTURECONSTANT_SRCCOPY = 0x00CC0020
Func _ScreenCapture_Capture($sFileName = "", $iLeft = 0, $iTop = 0, $iRight = -1, $iBottom = -1, $bCursor = True)
Local $bRet = False
If $iRight = -1 Then $iRight = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CXSCREEN) - 1
If $iBottom = -1 Then $iBottom = _WinAPI_GetSystemMetrics($__SCREENCAPTURECONSTANT_SM_CYSCREEN) - 1
If $iRight < $iLeft Then Return SetError(-1, 0, $bRet)
If $iBottom < $iTop Then Return SetError(-2, 0, $bRet)
Local $iW =($iRight - $iLeft) + 1
Local $iH =($iBottom - $iTop) + 1
Local $hWnd = _WinAPI_GetDesktopWindow()
Local $hDDC = _WinAPI_GetDC($hWnd)
Local $hCDC = _WinAPI_CreateCompatibleDC($hDDC)
Local $hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iW, $iH)
_WinAPI_SelectObject($hCDC, $hBMP)
_WinAPI_BitBlt($hCDC, 0, 0, $iW, $iH, $hDDC, $iLeft, $iTop, $__SCREENCAPTURECONSTANT_SRCCOPY)
If $bCursor Then
Local $aCursor = _WinAPI_GetCursorInfo()
If Not @error And $aCursor[1] Then
$bCursor = True
Local $hIcon = _WinAPI_CopyIcon($aCursor[2])
Local $aIcon = _WinAPI_GetIconInfo($hIcon)
If Not @error Then
_WinAPI_DeleteObject($aIcon[4])
If $aIcon[5] <> 0 Then _WinAPI_DeleteObject($aIcon[5])
_WinAPI_DrawIcon($hCDC, $aCursor[3] - $aIcon[2] - $iLeft, $aCursor[4] - $aIcon[3] - $iTop, $hIcon)
EndIf
_WinAPI_DestroyIcon($hIcon)
EndIf
EndIf
_WinAPI_ReleaseDC($hWnd, $hDDC)
_WinAPI_DeleteDC($hCDC)
If $sFileName = "" Then Return $hBMP
$bRet = _ScreenCapture_SaveImage($sFileName, $hBMP, True)
Return SetError(@error, @extended, $bRet)
EndFunc
Func _ScreenCapture_SaveImage($sFileName, $hBitmap, $bFreeBmp = True)
_GDIPlus_Startup()
If @error Then Return SetError(-1, -1, False)
Local $sExt = StringUpper(__GDIPlus_ExtractFileExt($sFileName))
Local $sCLSID = _GDIPlus_EncodersGetCLSID($sExt)
If $sCLSID = "" Then Return SetError(-2, -2, False)
Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
If @error Then Return SetError(-3, -3, False)
Local $tData, $tParams
Switch $sExt
Case "BMP"
Local $iX = _GDIPlus_ImageGetWidth($hImage)
Local $iY = _GDIPlus_ImageGetHeight($hImage)
Local $hClone = _GDIPlus_BitmapCloneArea($hImage, 0, 0, $iX, $iY, $__g_iBMPFormat)
_GDIPlus_ImageDispose($hImage)
$hImage = $hClone
Case "JPG", "JPEG"
$tParams = _GDIPlus_ParamInit(1)
$tData = DllStructCreate("int Quality")
DllStructSetData($tData, "Quality", $__g_iJPGQuality)
_GDIPlus_ParamAdd($tParams, $GDIP_EPGQUALITY, 1, $GDIP_EPTLONG, DllStructGetPtr($tData))
Case "TIF", "TIFF"
$tParams = _GDIPlus_ParamInit(2)
$tData = DllStructCreate("int ColorDepth;int Compression")
DllStructSetData($tData, "ColorDepth", $__g_iTIFColorDepth)
DllStructSetData($tData, "Compression", $__g_iTIFCompression)
_GDIPlus_ParamAdd($tParams, $GDIP_EPGCOLORDEPTH, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "ColorDepth"))
_GDIPlus_ParamAdd($tParams, $GDIP_EPGCOMPRESSION, 1, $GDIP_EPTLONG, DllStructGetPtr($tData, "Compression"))
EndSwitch
Local $pParams = 0
If IsDllStruct($tParams) Then $pParams = $tParams
Local $bRet = _GDIPlus_ImageSaveToFileEx($hImage, $sFileName, $sCLSID, $pParams)
_GDIPlus_ImageDispose($hImage)
If $bFreeBmp Then _WinAPI_DeleteObject($hBitmap)
_GDIPlus_Shutdown()
Return SetError($bRet = False, 0, $bRet)
EndFunc
Global Const $sCLSID_CUIAutomation="{FF48DBA4-60EF-4201-AA87-54103EEF594E}"
Global Const $UIA_InvokePatternId=10000
Global Const $UIA_SelectionPatternId=10001
Global Const $UIA_ValuePatternId=10002
Global Const $UIA_RangeValuePatternId=10003
Global Const $UIA_ScrollPatternId=10004
Global Const $UIA_ExpandCollapsePatternId=10005
Global Const $UIA_GridPatternId=10006
Global Const $UIA_GridItemPatternId=10007
Global Const $UIA_MultipleViewPatternId=10008
Global Const $UIA_WindowPatternId=10009
Global Const $UIA_SelectionItemPatternId=10010
Global Const $UIA_DockPatternId=10011
Global Const $UIA_TablePatternId=10012
Global Const $UIA_TextPatternId=10014
Global Const $UIA_TogglePatternId=10015
Global Const $UIA_TransformPatternId=10016
Global Const $UIA_ScrollItemPatternId=10017
Global Const $UIA_LegacyIAccessiblePatternId=10018
Global Const $UIA_ItemContainerPatternId=10019
Global Const $UIA_VirtualizedItemPatternId=10020
Global Const $UIA_SynchronizedInputPatternId=10021
Global Const $UIA_RuntimeIdPropertyId=30000
Global Const $UIA_BoundingRectanglePropertyId=30001
Global Const $UIA_ProcessIdPropertyId=30002
Global Const $UIA_ControlTypePropertyId=30003
Global Const $UIA_LocalizedControlTypePropertyId=30004
Global Const $UIA_NamePropertyId=30005
Global Const $UIA_AcceleratorKeyPropertyId=30006
Global Const $UIA_AccessKeyPropertyId=30007
Global Const $UIA_HasKeyboardFocusPropertyId=30008
Global Const $UIA_IsKeyboardFocusablePropertyId=30009
Global Const $UIA_IsEnabledPropertyId=30010
Global Const $UIA_AutomationIdPropertyId=30011
Global Const $UIA_ClassNamePropertyId=30012
Global Const $UIA_HelpTextPropertyId=30013
Global Const $UIA_ClickablePointPropertyId=30014
Global Const $UIA_CulturePropertyId=30015
Global Const $UIA_IsControlElementPropertyId=30016
Global Const $UIA_IsContentElementPropertyId=30017
Global Const $UIA_LabeledByPropertyId=30018
Global Const $UIA_IsPasswordPropertyId=30019
Global Const $UIA_NativeWindowHandlePropertyId=30020
Global Const $UIA_ItemTypePropertyId=30021
Global Const $UIA_IsOffscreenPropertyId=30022
Global Const $UIA_OrientationPropertyId=30023
Global Const $UIA_FrameworkIdPropertyId=30024
Global Const $UIA_IsRequiredForFormPropertyId=30025
Global Const $UIA_ItemStatusPropertyId=30026
Global Const $UIA_IsDockPatternAvailablePropertyId=30027
Global Const $UIA_IsExpandCollapsePatternAvailablePropertyId=30028
Global Const $UIA_IsGridItemPatternAvailablePropertyId=30029
Global Const $UIA_IsGridPatternAvailablePropertyId=30030
Global Const $UIA_IsInvokePatternAvailablePropertyId=30031
Global Const $UIA_IsMultipleViewPatternAvailablePropertyId=30032
Global Const $UIA_IsRangeValuePatternAvailablePropertyId=30033
Global Const $UIA_IsScrollPatternAvailablePropertyId=30034
Global Const $UIA_IsScrollItemPatternAvailablePropertyId=30035
Global Const $UIA_IsSelectionItemPatternAvailablePropertyId=30036
Global Const $UIA_IsSelectionPatternAvailablePropertyId=30037
Global Const $UIA_IsTablePatternAvailablePropertyId=30038
Global Const $UIA_IsTableItemPatternAvailablePropertyId=30039
Global Const $UIA_IsTextPatternAvailablePropertyId=30040
Global Const $UIA_IsTogglePatternAvailablePropertyId=30041
Global Const $UIA_IsTransformPatternAvailablePropertyId=30042
Global Const $UIA_IsValuePatternAvailablePropertyId=30043
Global Const $UIA_IsWindowPatternAvailablePropertyId=30044
Global Const $UIA_ValueValuePropertyId=30045
Global Const $UIA_ValueIsReadOnlyPropertyId=30046
Global Const $UIA_RangeValueValuePropertyId=30047
Global Const $UIA_RangeValueIsReadOnlyPropertyId=30048
Global Const $UIA_RangeValueMinimumPropertyId=30049
Global Const $UIA_RangeValueMaximumPropertyId=30050
Global Const $UIA_RangeValueLargeChangePropertyId=30051
Global Const $UIA_RangeValueSmallChangePropertyId=30052
Global Const $UIA_ScrollHorizontalScrollPercentPropertyId=30053
Global Const $UIA_ScrollHorizontalViewSizePropertyId=30054
Global Const $UIA_ScrollVerticalScrollPercentPropertyId=30055
Global Const $UIA_ScrollVerticalViewSizePropertyId=30056
Global Const $UIA_ScrollHorizontallyScrollablePropertyId=30057
Global Const $UIA_ScrollVerticallyScrollablePropertyId=30058
Global Const $UIA_SelectionSelectionPropertyId=30059
Global Const $UIA_SelectionCanSelectMultiplePropertyId=30060
Global Const $UIA_SelectionIsSelectionRequiredPropertyId=30061
Global Const $UIA_GridRowCountPropertyId=30062
Global Const $UIA_GridColumnCountPropertyId=30063
Global Const $UIA_GridItemRowPropertyId=30064
Global Const $UIA_GridItemColumnPropertyId=30065
Global Const $UIA_GridItemRowSpanPropertyId=30066
Global Const $UIA_GridItemColumnSpanPropertyId=30067
Global Const $UIA_GridItemContainingGridPropertyId=30068
Global Const $UIA_DockDockPositionPropertyId=30069
Global Const $UIA_ExpandCollapseExpandCollapseStatePropertyId=30070
Global Const $UIA_MultipleViewCurrentViewPropertyId=30071
Global Const $UIA_MultipleViewSupportedViewsPropertyId=30072
Global Const $UIA_WindowCanMaximizePropertyId=30073
Global Const $UIA_WindowCanMinimizePropertyId=30074
Global Const $UIA_WindowWindowVisualStatePropertyId=30075
Global Const $UIA_WindowWindowInteractionStatePropertyId=30076
Global Const $UIA_WindowIsModalPropertyId=30077
Global Const $UIA_WindowIsTopmostPropertyId=30078
Global Const $UIA_SelectionItemIsSelectedPropertyId=30079
Global Const $UIA_SelectionItemSelectionContainerPropertyId=30080
Global Const $UIA_TableRowHeadersPropertyId=30081
Global Const $UIA_TableColumnHeadersPropertyId=30082
Global Const $UIA_TableRowOrColumnMajorPropertyId=30083
Global Const $UIA_TableItemRowHeaderItemsPropertyId=30084
Global Const $UIA_TableItemColumnHeaderItemsPropertyId=30085
Global Const $UIA_ToggleToggleStatePropertyId=30086
Global Const $UIA_TransformCanMovePropertyId=30087
Global Const $UIA_TransformCanResizePropertyId=30088
Global Const $UIA_TransformCanRotatePropertyId=30089
Global Const $UIA_IsLegacyIAccessiblePatternAvailablePropertyId=30090
Global Const $UIA_LegacyIAccessibleChildIdPropertyId=30091
Global Const $UIA_LegacyIAccessibleNamePropertyId=30092
Global Const $UIA_LegacyIAccessibleValuePropertyId=30093
Global Const $UIA_LegacyIAccessibleDescriptionPropertyId=30094
Global Const $UIA_LegacyIAccessibleRolePropertyId=30095
Global Const $UIA_LegacyIAccessibleStatePropertyId=30096
Global Const $UIA_LegacyIAccessibleHelpPropertyId=30097
Global Const $UIA_LegacyIAccessibleKeyboardShortcutPropertyId=30098
Global Const $UIA_LegacyIAccessibleSelectionPropertyId=30099
Global Const $UIA_LegacyIAccessibleDefaultActionPropertyId=30100
Global Const $UIA_AriaRolePropertyId=30101
Global Const $UIA_AriaPropertiesPropertyId=30102
Global Const $UIA_IsDataValidForFormPropertyId=30103
Global Const $UIA_ControllerForPropertyId=30104
Global Const $UIA_DescribedByPropertyId=30105
Global Const $UIA_FlowsToPropertyId=30106
Global Const $UIA_ProviderDescriptionPropertyId=30107
Global Const $UIA_IsItemContainerPatternAvailablePropertyId=30108
Global Const $UIA_IsVirtualizedItemPatternAvailablePropertyId=30109
Global Const $UIA_IsSynchronizedInputPatternAvailablePropertyId=30110
Global Const $UIA_WindowControlTypeId=50032
Global Const $TreeScope_Children=2
Global Const $TreeScope_Subtree=7
Global Const $WindowVisualState_Normal=0
Global Const $WindowVisualState_Maximized=1
Global Const $WindowVisualState_Minimized=2
Global Const $sIID_IUIAutomationElement="{D22108AA-8AC5-49A5-837B-37BBB3D7591E}"
Global $dtagIUIAutomationElement = "SetFocus hresult();" & "GetRuntimeId hresult(ptr*);" & "FindFirst hresult(long;ptr;ptr*);" & "FindAll hresult(long;ptr;ptr*);" & "FindFirstBuildCache hresult(long;ptr;ptr;ptr*);" & "FindAllBuildCache hresult(long;ptr;ptr;ptr*);" & "BuildUpdatedCache hresult(ptr;ptr*);" & "GetCurrentPropertyValue hresult(int;variant*);" & "GetCurrentPropertyValueEx hresult(int;long;variant*);" & "GetCachedPropertyValue hresult(int;variant*);" & "GetCachedPropertyValueEx hresult(int;long;variant*);" & "GetCurrentPatternAs hresult(int;none;none*);" & "GetCachedPatternAs hresult(int;none;none*);" & "GetCurrentPattern hresult(int;ptr*);" & "GetCachedPattern hresult(int;ptr*);" & "GetCachedParent hresult(ptr*);" & "GetCachedChildren hresult(ptr*);" & "CurrentProcessId hresult(int*);" & "CurrentControlType hresult(int*);" & "CurrentLocalizedControlType hresult(bstr*);" & "CurrentName hresult(bstr*);" & "CurrentAcceleratorKey hresult(bstr*);" & "CurrentAccessKey hresult(bstr*);" & "CurrentHasKeyboardFocus hresult(long*);" & "CurrentIsKeyboardFocusable hresult(long*);" & "CurrentIsEnabled hresult(long*);" & "CurrentAutomationId hresult(bstr*);" & "CurrentClassName hresult(bstr*);" & "CurrentHelpText hresult(bstr*);" & "CurrentCulture hresult(int*);" & "CurrentIsControlElement hresult(long*);" & "CurrentIsContentElement hresult(long*);" & "CurrentIsPassword hresult(long*);" & "CurrentNativeWindowHandle hresult(hwnd*);" & "CurrentItemType hresult(bstr*);" & "CurrentIsOffscreen hresult(long*);" & "CurrentOrientation hresult(long*);" & "CurrentFrameworkId hresult(bstr*);" & "CurrentIsRequiredForForm hresult(long*);" & "CurrentItemStatus hresult(bstr*);" & "CurrentBoundingRectangle hresult(struct*);" & "CurrentLabeledBy hresult(ptr*);" & "CurrentAriaRole hresult(bstr*);" & "CurrentAriaProperties hresult(bstr*);" & "CurrentIsDataValidForForm hresult(long*);" & "CurrentControllerFor hresult(ptr*);" & "CurrentDescribedBy hresult(ptr*);" & "CurrentFlowsTo hresult(ptr*);" & "CurrentProviderDescription hresult(bstr*);" & "CachedProcessId hresult(int*);" & "CachedControlType hresult(int*);" & "CachedLocalizedControlType hresult(bstr*);" & "CachedName hresult(bstr*);" & "CachedAcceleratorKey hresult(bstr*);" & "CachedAccessKey hresult(bstr*);" & "CachedHasKeyboardFocus hresult(long*);" & "CachedIsKeyboardFocusable hresult(long*);" & "CachedIsEnabled hresult(long*);" & "CachedAutomationId hresult(bstr*);" & "CachedClassName hresult(bstr*);" & "CachedHelpText hresult(bstr*);" & "CachedCulture hresult(int*);" & "CachedIsControlElement hresult(long*);" & "CachedIsContentElement hresult(long*);" & "CachedIsPassword hresult(long*);" & "CachedNativeWindowHandle hresult(hwnd*);" & "CachedItemType hresult(bstr*);" & "CachedIsOffscreen hresult(long*);" & "CachedOrientation hresult(long*);" & "CachedFrameworkId hresult(bstr*);" & "CachedIsRequiredForForm hresult(long*);" & "CachedItemStatus hresult(bstr*);" & "CachedBoundingRectangle hresult(struct*);" & "CachedLabeledBy hresult(ptr*);" & "CachedAriaRole hresult(bstr*);" & "CachedAriaProperties hresult(bstr*);" & "CachedIsDataValidForForm hresult(long*);" & "CachedControllerFor hresult(ptr*);" & "CachedDescribedBy hresult(ptr*);" & "CachedFlowsTo hresult(ptr*);" & "CachedProviderDescription hresult(bstr*);" & "GetClickablePoint hresult(struct*;long*);"
Global Const $sIID_IUIAutomationCondition="{352FFBA8-0973-437C-A61F-F64CAFD81DF9}"
Global $dtagIUIAutomationCondition = ""
Global Const $sIID_IUIAutomationElementArray="{14314595-B4BC-4055-95F2-58F2E42C9855}"
Global $dtagIUIAutomationElementArray = "Length hresult(int*);" & "GetElement hresult(int;ptr*);"
Global $dtagIUIAutomationCacheRequest = "AddProperty hresult(int);" & "AddPattern hresult(int);" & "Clone hresult(ptr*);" & "get_TreeScope hresult(long*);" & "put_TreeScope hresult(long);" & "get_TreeFilter hresult(ptr*);" & "put_TreeFilter hresult(ptr);" & "get_AutomationElementMode hresult(long*);" & "put_AutomationElementMode hresult(long);"
Global $dtagIUIAutomationBoolCondition = "BooleanValue hresult(long*);"
Global $dtagIUIAutomationPropertyCondition = "propertyId hresult(int*);" & "PropertyValue hresult(variant*);" & "PropertyConditionFlags hresult(long*);"
Global $dtagIUIAutomationAndCondition = "ChildCount hresult(int*);" & "GetChildrenAsNativeArray hresult(ptr*;int*);" & "GetChildren hresult(ptr*);"
Global $dtagIUIAutomationOrCondition = "ChildCount hresult(int*);" & "GetChildrenAsNativeArray hresult(ptr*;int*);" & "GetChildren hresult(ptr*);"
Global $dtagIUIAutomationNotCondition = "GetChild hresult(ptr*);"
Global Const $sIID_IUIAutomationTreeWalker="{4042C624-389C-4AFC-A630-9DF854A541FC}"
Global $dtagIUIAutomationTreeWalker = "GetParentElement hresult(ptr;ptr*);" & "GetFirstChildElement hresult(ptr;ptr*);" & "GetLastChildElement hresult(ptr;ptr*);" & "GetNextSiblingElement hresult(ptr;ptr*);" & "GetPreviousSiblingElement hresult(ptr;ptr*);" & "NormalizeElement hresult(ptr;ptr*);" & "GetParentElementBuildCache hresult(ptr;ptr;ptr*);" & "GetFirstChildElementBuildCache hresult(ptr;ptr;ptr*);" & "GetLastChildElementBuildCache hresult(ptr;ptr;ptr*);" & "GetNextSiblingElementBuildCache hresult(ptr;ptr;ptr*);" & "GetPreviousSiblingElementBuildCache hresult(ptr;ptr;ptr*);" & "NormalizeElementBuildCache hresult(ptr;ptr;ptr*);" & "condition hresult(ptr*);"
Global $dtagIUIAutomationEventHandler = "HandleAutomationEvent hresult(ptr;int);"
Global $dtagIUIAutomationPropertyChangedEventHandler = "HandlePropertyChangedEvent hresult(ptr;int;variant);"
Global $dtagIUIAutomationStructureChangedEventHandler = "HandleStructureChangedEvent hresult(ptr;long;ptr);"
Global $dtagIUIAutomationFocusChangedEventHandler = "HandleFocusChangedEvent hresult(ptr);"
Global Const $sIID_IUIAutomationInvokePattern="{FB377FBE-8EA6-46D5-9C73-6499642D3059}"
Global $dtagIUIAutomationInvokePattern = "Invoke hresult();"
Global Const $sIID_IUIAutomationDockPattern="{FDE5EF97-1464-48F6-90BF-43D0948E86EC}"
Global $dtagIUIAutomationDockPattern = "SetDockPosition hresult(long);" & "CurrentDockPosition hresult(long*);" & "CachedDockPosition hresult(long*);"
Global Const $sIID_IUIAutomationExpandCollapsePattern="{619BE086-1F4E-4EE4-BAFA-210128738730}"
Global $dtagIUIAutomationExpandCollapsePattern = "Expand hresult();" & "Collapse hresult();" & "CurrentExpandCollapseState hresult(long*);" & "CachedExpandCollapseState hresult(long*);"
Global Const $sIID_IUIAutomationGridPattern="{414C3CDC-856B-4F5B-8538-3131C6302550}"
Global $dtagIUIAutomationGridPattern = "GetItem hresult(int;int;ptr*);" & "CurrentRowCount hresult(int*);" & "CurrentColumnCount hresult(int*);" & "CachedRowCount hresult(int*);" & "CachedColumnCount hresult(int*);"
Global Const $sIID_IUIAutomationGridItemPattern="{78F8EF57-66C3-4E09-BD7C-E79B2004894D}"
Global $dtagIUIAutomationGridItemPattern = "CurrentContainingGrid hresult(ptr*);" & "CurrentRow hresult(int*);" & "CurrentColumn hresult(int*);" & "CurrentRowSpan hresult(int*);" & "CurrentColumnSpan hresult(int*);" & "CachedContainingGrid hresult(ptr*);" & "CachedRow hresult(int*);" & "CachedColumn hresult(int*);" & "CachedRowSpan hresult(int*);" & "CachedColumnSpan hresult(int*);"
Global Const $sIID_IUIAutomationMultipleViewPattern="{8D253C91-1DC5-4BB5-B18F-ADE16FA495E8}"
Global $dtagIUIAutomationMultipleViewPattern = "GetViewName hresult(int;bstr*);" & "SetCurrentView hresult(int);" & "CurrentCurrentView hresult(int*);" & "GetCurrentSupportedViews hresult(ptr*);" & "CachedCurrentView hresult(int*);" & "GetCachedSupportedViews hresult(ptr*);"
Global Const $sIID_IUIAutomationRangeValuePattern="{59213F4F-7346-49E5-B120-80555987A148}"
Global $dtagIUIAutomationRangeValuePattern = "SetValue hresult(ushort);" & "CurrentValue hresult(ushort*);" & "CurrentIsReadOnly hresult(long*);" & "CurrentMaximum hresult(ushort*);" & "CurrentMinimum hresult(ushort*);" & "CurrentLargeChange hresult(ushort*);" & "CurrentSmallChange hresult(ushort*);" & "CachedValue hresult(ushort*);" & "CachedIsReadOnly hresult(long*);" & "CachedMaximum hresult(ushort*);" & "CachedMinimum hresult(ushort*);" & "CachedLargeChange hresult(ushort*);" & "CachedSmallChange hresult(ushort*);"
Global Const $sIID_IUIAutomationScrollPattern="{88F4D42A-E881-459D-A77C-73BBBB7E02DC}"
Global $dtagIUIAutomationScrollPattern = "Scroll hresult(long;long);" & "SetScrollPercent hresult(ushort;ushort);" & "CurrentHorizontalScrollPercent hresult(ushort*);" & "CurrentVerticalScrollPercent hresult(ushort*);" & "CurrentHorizontalViewSize hresult(ushort*);" & "CurrentVerticalViewSize hresult(ushort*);" & "CurrentHorizontallyScrollable hresult(long*);" & "CurrentVerticallyScrollable hresult(long*);" & "CachedHorizontalScrollPercent hresult(ushort*);" & "CachedVerticalScrollPercent hresult(ushort*);" & "CachedHorizontalViewSize hresult(ushort*);" & "CachedVerticalViewSize hresult(ushort*);" & "CachedHorizontallyScrollable hresult(long*);" & "CachedVerticallyScrollable hresult(long*);"
Global Const $sIID_IUIAutomationScrollItemPattern="{B488300F-D015-4F19-9C29-BB595E3645EF}"
Global $dtagIUIAutomationScrollItemPattern = "ScrollIntoView hresult();"
Global Const $sIID_IUIAutomationSelectionPattern="{5ED5202E-B2AC-47A6-B638-4B0BF140D78E}"
Global $dtagIUIAutomationSelectionPattern = "GetCurrentSelection hresult(ptr*);" & "CurrentCanSelectMultiple hresult(long*);" & "CurrentIsSelectionRequired hresult(long*);" & "GetCachedSelection hresult(ptr*);" & "CachedCanSelectMultiple hresult(long*);" & "CachedIsSelectionRequired hresult(long*);"
Global Const $sIID_IUIAutomationSelectionItemPattern="{A8EFA66A-0FDA-421A-9194-38021F3578EA}"
Global $dtagIUIAutomationSelectionItemPattern = "Select hresult();" & "AddToSelection hresult();" & "RemoveFromSelection hresult();" & "CurrentIsSelected hresult(long*);" & "CurrentSelectionContainer hresult(ptr*);" & "CachedIsSelected hresult(long*);" & "CachedSelectionContainer hresult(ptr*);"
Global Const $sIID_IUIAutomationSynchronizedInputPattern="{2233BE0B-AFB7-448B-9FDA-3B378AA5EAE1}"
Global $dtagIUIAutomationSynchronizedInputPattern = "StartListening hresult(long);" & "Cancel hresult();"
Global Const $sIID_IUIAutomationTablePattern="{620E691C-EA96-4710-A850-754B24CE2417}"
Global $dtagIUIAutomationTablePattern = "GetCurrentRowHeaders hresult(ptr*);" & "GetCurrentColumnHeaders hresult(ptr*);" & "CurrentRowOrColumnMajor hresult(long*);" & "GetCachedRowHeaders hresult(ptr*);" & "GetCachedColumnHeaders hresult(ptr*);" & "CachedRowOrColumnMajor hresult(long*);"
Global $dtagIUIAutomationTableItemPattern = "GetCurrentRowHeaderItems hresult(ptr*);" & "GetCurrentColumnHeaderItems hresult(ptr*);" & "GetCachedRowHeaderItems hresult(ptr*);" & "GetCachedColumnHeaderItems hresult(ptr*);"
Global Const $sIID_IUIAutomationTogglePattern="{94CF8058-9B8D-4AB9-8BFD-4CD0A33C8C70}"
Global $dtagIUIAutomationTogglePattern = "Toggle hresult();" & "CurrentToggleState hresult(long*);" & "CachedToggleState hresult(long*);"
Global Const $sIID_IUIAutomationTransformPattern="{A9B55844-A55D-4EF0-926D-569C16FF89BB}"
Global $dtagIUIAutomationTransformPattern = "Move hresult(double;double);" & "Resize hresult(double;double);" & "Rotate hresult(ushort);" & "CurrentCanMove hresult(long*);" & "CurrentCanResize hresult(long*);" & "CurrentCanRotate hresult(long*);" & "CachedCanMove hresult(long*);" & "CachedCanResize hresult(long*);" & "CachedCanRotate hresult(long*);"
Global Const $sIID_IUIAutomationValuePattern="{A94CD8B1-0844-4CD6-9D2D-640537AB39E9}"
Global $dtagIUIAutomationValuePattern = "SetValue hresult(bstr);" & "CurrentValue hresult(bstr*);" & "CurrentIsReadOnly hresult(long*);" & "CachedValue hresult(bstr*);" & "CachedIsReadOnly hresult(long*);"
Global Const $sIID_IUIAutomationWindowPattern="{0FAEF453-9208-43EF-BBB2-3B485177864F}"
Global $dtagIUIAutomationWindowPattern = "Close hresult();" & "WaitForInputIdle hresult(int;long*);" & "SetWindowVisualState hresult(long);" & "CurrentCanMaximize hresult(long*);" & "CurrentCanMinimize hresult(long*);" & "CurrentIsModal hresult(long*);" & "CurrentIsTopmost hresult(long*);" & "CurrentWindowVisualState hresult(long*);" & "CurrentWindowInteractionState hresult(long*);" & "CachedCanMaximize hresult(long*);" & "CachedCanMinimize hresult(long*);" & "CachedIsModal hresult(long*);" & "CachedIsTopmost hresult(long*);" & "CachedWindowVisualState hresult(long*);" & "CachedWindowInteractionState hresult(long*);"
Global $dtagIUIAutomationTextRange = "Clone hresult(ptr*);" & "Compare hresult(ptr;long*);" & "CompareEndpoints hresult(long;ptr;long;int*);" & "ExpandToEnclosingUnit hresult(long);" & "FindAttribute hresult(int;variant;long;ptr*);" & "FindText hresult(bstr;long;long;ptr*);" & "GetAttributeValue hresult(int;variant*);" & "GetBoundingRectangles hresult(ptr*);" & "GetEnclosingElement hresult(ptr*);" & "GetText hresult(int;bstr*);" & "Move hresult(long;int;int*);" & "MoveEndpointByUnit hresult(long;long;int;int*);" & "MoveEndpointByRange hresult(long;ptr;long);" & "Select hresult();" & "AddToSelection hresult();" & "RemoveFromSelection hresult();" & "ScrollIntoView hresult(long);" & "GetChildren hresult(ptr*);"
Global $dtagIUIAutomationTextRangeArray = "Length hresult(int*);" & "GetElement hresult(int;ptr*);"
Global Const $sIID_IUIAutomationTextPattern="{32EBA289-3583-42C9-9C59-3B6D9A1E9B6A}"
Global $dtagIUIAutomationTextPattern = "RangeFromPoint hresult(struct;ptr*);" & "RangeFromChild hresult(ptr;ptr*);" & "GetSelection hresult(ptr*);" & "GetVisibleRanges hresult(ptr*);" & "DocumentRange hresult(ptr*);" & "SupportedTextSelection hresult(long*);"
Global Const $sIID_IUIAutomationLegacyIAccessiblePattern="{828055AD-355B-4435-86D5-3B51C14A9B1B}"
Global $dtagIUIAutomationLegacyIAccessiblePattern = "Select hresult(long);" & "DoDefaultAction hresult();" & "SetValue hresult(wstr);" & "CurrentChildId hresult(int*);" & "CurrentName hresult(bstr*);" & "CurrentValue hresult(bstr*);" & "CurrentDescription hresult(bstr*);" & "CurrentRole hresult(uint*);" & "CurrentState hresult(uint*);" & "CurrentHelp hresult(bstr*);" & "CurrentKeyboardShortcut hresult(bstr*);" & "GetCurrentSelection hresult(ptr*);" & "CurrentDefaultAction hresult(bstr*);" & "CachedChildId hresult(int*);" & "CachedName hresult(bstr*);" & "CachedValue hresult(bstr*);" & "CachedDescription hresult(bstr*);" & "CachedRole hresult(uint*);" & "CachedState hresult(uint*);" & "CachedHelp hresult(bstr*);" & "CachedKeyboardShortcut hresult(bstr*);" & "GetCachedSelection hresult(ptr*);" & "CachedDefaultAction hresult(bstr*);" & "GetIAccessible hresult(idispatch*);"
Global $dtagIAccessible = "GetTypeInfoCount hresult(uint*);" & "GetTypeInfo hresult(uint;int;ptr*);" & "GetIDsOfNames hresult(struct*;wstr;uint;int;int);" & "Invoke hresult(int;struct*;int;word;ptr*;ptr*;ptr*;uint*);" & "get_accParent hresult(ptr*);" & "get_accChildCount hresult(long*);" & "get_accChild hresult(variant;idispatch*);" & "get_accName hresult(variant;bstr*);" & "get_accValue hresult(variant;bstr*);" & "get_accDescription hresult(variant;bstr*);" & "get_accRole hresult(variant;variant*);" & "get_accState hresult(variant;variant*);" & "get_accHelp hresult(variant;bstr*);" & "get_accHelpTopic hresult(bstr*;variant;long*);" & "get_accKeyboardShortcut hresult(variant;bstr*);" & "get_accFocus hresult(struct*);" & "get_accSelection hresult(variant*);" & "get_accDefaultAction hresult(variant;bstr*);" & "accSelect hresult(long;variant);" & "accLocation hresult(long*;long*;long*;long*;variant);" & "accNavigate hresult(long;variant;variant*);" & "accHitTest hresult(long;long;variant*);" & "accDoDefaultAction hresult(variant);" & "put_accName hresult(variant;bstr);" & "put_accValue hresult(variant;bstr);"
Global Const $sIID_IUIAutomationItemContainerPattern="{C690FDB2-27A8-423C-812D-429773C9084E}"
Global $dtagIUIAutomationItemContainerPattern = "FindItemByProperty hresult(ptr;int;variant;ptr*);"
Global Const $sIID_IUIAutomationVirtualizedItemPattern="{6BA3D7A6-04CF-4F11-8793-A8D1CDE9969F}"
Global $dtagIUIAutomationVirtualizedItemPattern = "Realize hresult();"
Global $dtagIUIAutomationProxyFactory = "CreateProvider hresult(hwnd;long;long;ptr*);" & "ProxyFactoryId hresult(bstr*);"
Global $dtagIRawElementProviderSimple = "ProviderOptions hresult(long*);" & "GetPatternProvider hresult(int;ptr*);" & "GetPropertyValue hresult(int;variant*);" & "HostRawElementProvider hresult(ptr*);"
Global $dtagIUIAutomationProxyFactoryEntry = "ProxyFactory hresult(ptr*);" & "ClassName hresult(bstr*);" & "ImageName hresult(bstr*);" & "AllowSubstringMatch hresult(long*);" & "CanCheckBaseClass hresult(long*);" & "NeedsAdviseEvents hresult(long*);" & "ClassName hresult(wstr);" & "ImageName hresult(wstr);" & "AllowSubstringMatch hresult(long);" & "CanCheckBaseClass hresult(long);" & "NeedsAdviseEvents hresult(long);" & "SetWinEventsForAutomationEvent hresult(int;int;ptr);" & "GetWinEventsForAutomationEvent hresult(int;int;ptr*);"
Global $dtagIUIAutomationProxyFactoryMapping = "count hresult(uint*);" & "GetTable hresult(ptr*);" & "GetEntry hresult(uint;ptr*);" & "SetTable hresult(ptr);" & "InsertEntries hresult(uint;ptr);" & "InsertEntry hresult(uint;ptr);" & "RemoveEntry hresult(uint);" & "ClearTable hresult();" & "RestoreDefaultTable hresult();"
Global Const $sIID_IUIAutomation="{30CBE57D-D9D0-452A-AB13-7AC5AC4825EE}"
Global $dtagIUIAutomation = "CompareElements hresult(ptr;ptr;long*);" & "CompareRuntimeIds hresult(ptr;ptr;long*);" & "GetRootElement hresult(ptr*);" & "ElementFromHandle hresult(hwnd;ptr*);" & "ElementFromPoint hresult(struct;ptr*);" & "GetFocusedElement hresult(ptr*);" & "GetRootElementBuildCache hresult(ptr;ptr*);" & "ElementFromHandleBuildCache hresult(hwnd;ptr;ptr*);" & "ElementFromPointBuildCache hresult(struct;ptr;ptr*);" & "GetFocusedElementBuildCache hresult(ptr;ptr*);" & "CreateTreeWalker hresult(ptr;ptr*);" & "ControlViewWalker hresult(ptr*);" & "ContentViewWalker hresult(ptr*);" & "RawViewWalker hresult(ptr*);" & "RawViewCondition hresult(ptr*);" & "ControlViewCondition hresult(ptr*);" & "ContentViewCondition hresult(ptr*);" & "CreateCacheRequest hresult(ptr*);" & "CreateTrueCondition hresult(ptr*);" & "CreateFalseCondition hresult(ptr*);" & "CreatePropertyCondition hresult(int;variant;ptr*);" & "CreatePropertyConditionEx hresult(int;variant;long;ptr*);" & "CreateAndCondition hresult(ptr;ptr;ptr*);" & "CreateAndConditionFromArray hresult(ptr;ptr*);" & "CreateAndConditionFromNativeArray hresult(ptr;int;ptr*);" & "CreateOrCondition hresult(ptr;ptr;ptr*);" & "CreateOrConditionFromArray hresult(ptr;ptr*);" & "CreateOrConditionFromNativeArray hresult(ptr;int;ptr*);" & "CreateNotCondition hresult(ptr;ptr*);" & "AddAutomationEventHandler hresult(int;ptr;long;ptr;ptr);" & "RemoveAutomationEventHandler hresult(int;ptr;ptr);" & "AddPropertyChangedEventHandlerNativeArray hresult(ptr;long;ptr;ptr;struct*;int);" & "AddPropertyChangedEventHandler hresult(ptr;long;ptr;ptr;ptr);" & "RemovePropertyChangedEventHandler hresult(ptr;ptr);" & "AddStructureChangedEventHandler hresult(ptr;long;ptr;ptr);" & "RemoveStructureChangedEventHandler hresult(ptr;ptr);" & "AddFocusChangedEventHandler hresult(ptr;ptr);" & "RemoveFocusChangedEventHandler hresult(ptr);" & "RemoveAllEventHandlers hresult();" & "IntNativeArrayToSafeArray hresult(int;int;ptr*);" & "IntSafeArrayToNativeArray hresult(ptr;int*;int*);" & "RectToVariant hresult(struct;variant*);" & "VariantToRect hresult(variant;struct*);" & "SafeArrayToRectNativeArray hresult(ptr;struct*;int*);" & "CreateProxyFactoryEntry hresult(ptr;ptr*);" & "ProxyFactoryMapping hresult(ptr*);" & "GetPropertyProgrammaticName hresult(int;bstr*);" & "GetPatternProgrammaticName hresult(int;bstr*);" & "PollForPotentialSupportedPatterns hresult(ptr;ptr*;ptr*);" & "PollForPotentialSupportedProperties hresult(ptr;ptr*;ptr*);" & "CheckNotSupported hresult(variant;long*);" & "ReservedNotSupportedValue hresult(ptr*);" & "ReservedMixedAttributeValue hresult(ptr*);" & "ElementFromIAccessible hresult(idispatch;int;ptr*);" & "ElementFromIAccessibleBuildCache hresult(iaccessible;int;ptr;ptr*);"
Global $UIA_oUIAutomation
Global $UIA_oDesktop, $UIA_pDesktop
Global $UIA_oUIElement, $UIA_pUIElement
Global $UIA_oTW, $UIA_pTW
Global $UIA_oTRUECondition
Global $UIA_Vars[0][2]
Global $UIA_DefaultWaitTime = 250
Global Const $__gaUIAAU3VersionInfo[6] = ["T", 0, 6, 6, "20181104", "T0.6-6"]
Global Const $_UIA_MAXDEPTH = 25
Local Const $UIA_CFGFileName = "UIA.CFG"
Local Const $UIA_Log_Wrapper = 5, $UIA_Log_trace = 10, $UIA_Log_debug = 20, $UIA_Log_info = 30, $UIA_Log_warn = 40, $UIA_Log_error = 50, $UIA_Log_fatal = 60
Local Const $__UIA_debugCacheOn = 1
Local Const $__UIA_debugCacheOff = 2
Local Const $__UIA_SpecialProperty = -1
Local $__gl_XMLCache
Local $__l_UIA_CacheState = False
Global Enum $_UIASTATUS_Success = 0, $_UIASTATUS_GeneralError, $_UIASTATUS_InvalidValue, $_UIASTATUS_NoMatch, $_UIASTATUS_NoUIAutomationFound, $_UIASTATUS_NoTreewalkerFound, $_UIASTATUS_NoDesktopFound
_UIA_Init()
Func _UIA_Init()
Local $UIA_pTRUECondition
$UIA_oUIAutomation = ObjCreateInterface($sCLSID_CUIAutomation, $sIID_IUIAutomation, $dtagIUIAutomation)
If _UIA_IsElement($UIA_oUIAutomation) = 0 Then
Return SetError($_UIASTATUS_NoUIAutomationFound, 0, 0)
EndIf
$UIA_oUIAutomation.GetRootElement($UIA_pDesktop)
$UIA_oDesktop = ObjCreateInterface($UIA_pDesktop, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
If IsObj($UIA_oDesktop) = 0 Then
Return SetError($_UIASTATUS_NoDesktopFound, 0, 0)
EndIf
$UIA_oUIAutomation.RawViewWalker($UIA_pTW)
$UIA_oTW = ObjCreateInterface($UIA_pTW, $sIID_IUIAutomationTreeWalker, $dtagIUIAutomationTreeWalker)
If _UIA_IsElement($UIA_oTW) = 0 Then
Return SetError($_UIASTATUS_NoTreewalkerFound, 0, 0)
EndIf
$UIA_oUIAutomation.CreateTrueCondition($UIA_pTRUECondition)
$UIA_oTRUECondition = ObjCreateInterface($UIA_pTRUECondition, $sIID_IUIAutomationCondition, $dtagIUIAutomationCondition)
Return SetError($_UIASTATUS_Success, $_UIASTATUS_Success, True)
EndFunc
const $constColName=0
const $constColType=1
Local $UIA_propertiesSupportedArray[123][2] = [ ["indexrelative", $__UIA_SpecialProperty], ["index", $__UIA_SpecialProperty], ["instance", $__UIA_SpecialProperty], ["title", $UIA_NamePropertyId], ["text", $UIA_NamePropertyId], ["regexptitle", $UIA_NamePropertyId], ["class", $UIA_ClassNamePropertyId], ["regexpclass", $UIA_ClassNamePropertyId], ["iaccessiblevalue", $UIA_LegacyIAccessibleValuePropertyId], ["iaccessiblechildId", $UIA_LegacyIAccessibleChildIdPropertyId], ["id", $UIA_AutomationIdPropertyId], ["handle", $UIA_NativeWindowHandlePropertyId], ["RuntimeId", $UIA_RuntimeIdPropertyId], ["BoundingRectangle", $UIA_BoundingRectanglePropertyId], ["ProcessId", $UIA_ProcessIdPropertyId], ["ControlType", $UIA_ControlTypePropertyId], ["LocalizedControlType", $UIA_LocalizedControlTypePropertyId], ["Name", $UIA_NamePropertyId], ["AcceleratorKey", $UIA_AcceleratorKeyPropertyId], ["AccessKey", $UIA_AccessKeyPropertyId], ["HasKeyboardFocus", $UIA_HasKeyboardFocusPropertyId], ["IsKeyboardFocusable", $UIA_IsKeyboardFocusablePropertyId], ["IsEnabled", $UIA_IsEnabledPropertyId], ["AutomationId", $UIA_AutomationIdPropertyId], ["ClassName", $UIA_ClassNamePropertyId], ["HelpText", $UIA_HelpTextPropertyId], ["ClickablePoint", $UIA_ClickablePointPropertyId], ["Culture", $UIA_CulturePropertyId], ["IsControlElement", $UIA_IsControlElementPropertyId], ["IsContentElement", $UIA_IsContentElementPropertyId], ["LabeledBy", $UIA_LabeledByPropertyId], ["IsPassword", $UIA_IsPasswordPropertyId], ["NativeWindowHandle", $UIA_NativeWindowHandlePropertyId], ["ItemType", $UIA_ItemTypePropertyId], ["IsOffscreen", $UIA_IsOffscreenPropertyId], ["Orientation", $UIA_OrientationPropertyId], ["FrameworkId", $UIA_FrameworkIdPropertyId], ["IsRequiredForForm", $UIA_IsRequiredForFormPropertyId], ["ItemStatus", $UIA_ItemStatusPropertyId], ["IsDockPatternAvailable", $UIA_IsDockPatternAvailablePropertyId], ["IsExpandCollapsePatternAvailable", $UIA_IsExpandCollapsePatternAvailablePropertyId], ["IsGridItemPatternAvailable", $UIA_IsGridItemPatternAvailablePropertyId], ["IsGridPatternAvailable", $UIA_IsGridPatternAvailablePropertyId], ["IsInvokePatternAvailable", $UIA_IsInvokePatternAvailablePropertyId], ["IsMultipleViewPatternAvailable", $UIA_IsMultipleViewPatternAvailablePropertyId], ["IsRangeValuePatternAvailable", $UIA_IsRangeValuePatternAvailablePropertyId], ["IsScrollPatternAvailable", $UIA_IsScrollPatternAvailablePropertyId], ["IsScrollItemPatternAvailable", $UIA_IsScrollItemPatternAvailablePropertyId], ["IsSelectionItemPatternAvailable", $UIA_IsSelectionItemPatternAvailablePropertyId], ["IsSelectionPatternAvailable", $UIA_IsSelectionPatternAvailablePropertyId], ["IsTablePatternAvailable", $UIA_IsTablePatternAvailablePropertyId], ["IsTableItemPatternAvailable", $UIA_IsTableItemPatternAvailablePropertyId], ["IsTextPatternAvailable", $UIA_IsTextPatternAvailablePropertyId], ["IsTogglePatternAvailable", $UIA_IsTogglePatternAvailablePropertyId], ["IsTransformPatternAvailable", $UIA_IsTransformPatternAvailablePropertyId], ["IsValuePatternAvailable", $UIA_IsValuePatternAvailablePropertyId], ["IsWindowPatternAvailable", $UIA_IsWindowPatternAvailablePropertyId], ["ValueValue", $UIA_ValueValuePropertyId], ["ValueIsReadOnly", $UIA_ValueIsReadOnlyPropertyId], ["RangeValueValue", $UIA_RangeValueValuePropertyId], ["RangeValueIsReadOnly", $UIA_RangeValueIsReadOnlyPropertyId], ["RangeValueMinimum", $UIA_RangeValueMinimumPropertyId], ["RangeValueMaximum", $UIA_RangeValueMaximumPropertyId], ["RangeValueLargeChange", $UIA_RangeValueLargeChangePropertyId], ["RangeValueSmallChange", $UIA_RangeValueSmallChangePropertyId], ["ScrollHorizontalScrollPercent", $UIA_ScrollHorizontalScrollPercentPropertyId], ["ScrollHorizontalViewSize", $UIA_ScrollHorizontalViewSizePropertyId], ["ScrollVerticalScrollPercent", $UIA_ScrollVerticalScrollPercentPropertyId], ["ScrollVerticalViewSize", $UIA_ScrollVerticalViewSizePropertyId], ["ScrollHorizontallyScrollable", $UIA_ScrollHorizontallyScrollablePropertyId], _
["ScrollVerticallyScrollable", $UIA_ScrollVerticallyScrollablePropertyId], ["SelectionSelection", $UIA_SelectionSelectionPropertyId], ["SelectionCanSelectMultiple", $UIA_SelectionCanSelectMultiplePropertyId], ["SelectionIsSelectionRequired", $UIA_SelectionIsSelectionRequiredPropertyId], ["GridRowCount", $UIA_GridRowCountPropertyId], ["GridColumnCount", $UIA_GridColumnCountPropertyId], ["GridItemRow", $UIA_GridItemRowPropertyId], ["GridItemColumn", $UIA_GridItemColumnPropertyId], ["GridItemRowSpan", $UIA_GridItemRowSpanPropertyId], ["GridItemColumnSpan", $UIA_GridItemColumnSpanPropertyId], ["GridItemContainingGrid", $UIA_GridItemContainingGridPropertyId], ["DockDockPosition", $UIA_DockDockPositionPropertyId], ["ExpandCollapseExpandCollapseState", $UIA_ExpandCollapseExpandCollapseStatePropertyId], ["MultipleViewCurrentView", $UIA_MultipleViewCurrentViewPropertyId], ["MultipleViewSupportedViews", $UIA_MultipleViewSupportedViewsPropertyId], ["WindowCanMaximize", $UIA_WindowCanMaximizePropertyId], ["WindowCanMinimize", $UIA_WindowCanMinimizePropertyId], ["WindowWindowVisualState", $UIA_WindowWindowVisualStatePropertyId], ["WindowWindowInteractionState", $UIA_WindowWindowInteractionStatePropertyId], ["WindowIsModal", $UIA_WindowIsModalPropertyId], ["WindowIsTopmost", $UIA_WindowIsTopmostPropertyId], ["SelectionItemIsSelected", $UIA_SelectionItemIsSelectedPropertyId], ["SelectionItemSelectionContainer", $UIA_SelectionItemSelectionContainerPropertyId], ["TableRowHeaders", $UIA_TableRowHeadersPropertyId], ["TableColumnHeaders", $UIA_TableColumnHeadersPropertyId], ["TableRowOrColumnMajor", $UIA_TableRowOrColumnMajorPropertyId], ["TableItemRowHeaderItems", $UIA_TableItemRowHeaderItemsPropertyId], ["TableItemColumnHeaderItems", $UIA_TableItemColumnHeaderItemsPropertyId], ["ToggleToggleState", $UIA_ToggleToggleStatePropertyId], ["TransformCanMove", $UIA_TransformCanMovePropertyId], ["TransformCanResize", $UIA_TransformCanResizePropertyId], ["TransformCanRotate", $UIA_TransformCanRotatePropertyId], ["IsLegacyIAccessiblePatternAvailable", $UIA_IsLegacyIAccessiblePatternAvailablePropertyId], ["LegacyIAccessibleChildId", $UIA_LegacyIAccessibleChildIdPropertyId], ["LegacyIAccessibleName", $UIA_LegacyIAccessibleNamePropertyId], ["LegacyIAccessibleValue", $UIA_LegacyIAccessibleValuePropertyId], ["LegacyIAccessibleDescription", $UIA_LegacyIAccessibleDescriptionPropertyId], ["LegacyIAccessibleRole", $UIA_LegacyIAccessibleRolePropertyId], ["LegacyIAccessibleState", $UIA_LegacyIAccessibleStatePropertyId], ["LegacyIAccessibleHelp", $UIA_LegacyIAccessibleHelpPropertyId], ["LegacyIAccessibleKeyboardShortcut", $UIA_LegacyIAccessibleKeyboardShortcutPropertyId], ["LegacyIAccessibleSelection", $UIA_LegacyIAccessibleSelectionPropertyId], ["LegacyIAccessibleDefaultAction", $UIA_LegacyIAccessibleDefaultActionPropertyId], ["AriaRole", $UIA_AriaRolePropertyId], ["AriaProperties", $UIA_AriaPropertiesPropertyId], ["IsDataValidForForm", $UIA_IsDataValidForFormPropertyId], ["ControllerFor", $UIA_ControllerForPropertyId], ["DescribedBy", $UIA_DescribedByPropertyId], ["FlowsTo", $UIA_FlowsToPropertyId], ["ProviderDescription", $UIA_ProviderDescriptionPropertyId], ["IsItemContainerPatternAvailable", $UIA_IsItemContainerPatternAvailablePropertyId], ["IsVirtualizedItemPatternAvailable", $UIA_IsVirtualizedItemPatternAvailablePropertyId], ["IsSynchronizedInputPatternAvailable", $UIA_IsSynchronizedInputPatternAvailablePropertyId] ]
Local $UIA_ControlArray[41][3] = [ ["UIA_AppBarControlTypeId", 50040, "Identifies the AppBar control type. Supported starting with Windows 8.1."], ["UIA_ButtonControlTypeId", 50000, "Identifies the Button control type."], ["UIA_CalendarControlTypeId", 50001, "Identifies the Calendar control type."], ["UIA_CheckBoxControlTypeId", 50002, "Identifies the CheckBox control type."], ["UIA_ComboBoxControlTypeId", 50003, "Identifies the ComboBox control type."], ["UIA_CustomControlTypeId", 50025, "Identifies the Custom control type. For more information, see Custom Properties, Events, and Control Patterns."], ["UIA_DataGridControlTypeId", 50028, "Identifies the DataGrid control type."], ["UIA_DataItemControlTypeId", 50029, "Identifies the DataItem control type."], ["UIA_DocumentControlTypeId", 50030, "Identifies the Document control type."], ["UIA_EditControlTypeId", 50004, "Identifies the Edit control type."], ["UIA_GroupControlTypeId", 50026, "Identifies the Group control type."], ["UIA_HeaderControlTypeId", 50034, "Identifies the Header control type."], ["UIA_HeaderItemControlTypeId", 50035, "Identifies the HeaderItem control type."], ["UIA_HyperlinkControlTypeId", 50005, "Identifies the Hyperlink control type."], ["UIA_ImageControlTypeId", 50006, "Identifies the Image control type."], ["UIA_ListControlTypeId", 50008, "Identifies the List control type."], ["UIA_ListItemControlTypeId", 50007, "Identifies the ListItem control type."], ["UIA_MenuBarControlTypeId", 50010, "Identifies the MenuBar control type."], ["UIA_MenuControlTypeId", 50009, "Identifies the Menu control type."], ["UIA_MenuItemControlTypeId", 50011, "Identifies the MenuItem control type."], ["UIA_PaneControlTypeId", 50033, "Identifies the Pane control type."], ["UIA_ProgressBarControlTypeId", 50012, "Identifies the ProgressBar control type."], ["UIA_RadioButtonControlTypeId", 50013, "Identifies the RadioButton control type."], ["UIA_ScrollBarControlTypeId", 50014, "Identifies the ScrollBar control type."], ["UIA_SemanticZoomControlTypeId", 50039, "Identifies the SemanticZoom control type. Supported starting with Windows 8."], ["UIA_SeparatorControlTypeId", 50038, "Identifies the Separator control type."], ["UIA_SliderControlTypeId", 50015, "Identifies the Slider control type."], ["UIA_SpinnerControlTypeId", 50016, "Identifies the Spinner control type."], ["UIA_SplitButtonControlTypeId", 50031, "Identifies the SplitButton control type."], ["UIA_StatusBarControlTypeId", 50017, "Identifies the StatusBar control type."], ["UIA_TabControlTypeId", 50018, "Identifies the Tab control type."], ["UIA_TabItemControlTypeId", 50019, "Identifies the TabItem control type."], ["UIA_TableControlTypeId", 50036, "Identifies the Table control type."], ["UIA_TextControlTypeId", 50020, "Identifies the Text control type."], ["UIA_ThumbControlTypeId", 50027, "Identifies the Thumb control type."], ["UIA_TitleBarControlTypeId", 50037, "Identifies the TitleBar control type."], ["UIA_ToolBarControlTypeId", 50021, "Identifies the ToolBar control type."], ["UIA_ToolTipControlTypeId", 50022, "Identifies the ToolTip control type."], ["UIA_TreeControlTypeId", 50023, "Identifies the Tree control type."], ["UIA_TreeItemControlTypeId", 50024, "Identifies the TreeItem control type."], ["UIA_WindowControlTypeId", 50032, "Identifies the Window control type."] ]
Local $patternArray[21][3] = [ [$UIA_ValuePatternId, $sIID_IUIAutomationValuePattern, $dtagIUIAutomationValuePattern], [$UIA_InvokePatternId, $sIID_IUIAutomationInvokePattern, $dtagIUIAutomationInvokePattern], [$UIA_SelectionPatternId, $sIID_IUIAutomationSelectionPattern, $dtagIUIAutomationSelectionPattern], [$UIA_LegacyIAccessiblePatternId, $sIID_IUIAutomationLegacyIAccessiblePattern, $dtagIUIAutomationLegacyIAccessiblePattern], [$UIA_SelectionItemPatternId, $sIID_IUIAutomationSelectionItemPattern, $dtagIUIAutomationSelectionItemPattern], [$UIA_RangeValuePatternId, $sIID_IUIAutomationRangeValuePattern, $dtagIUIAutomationRangeValuePattern], [$UIA_ScrollPatternId, $sIID_IUIAutomationScrollPattern, $dtagIUIAutomationScrollPattern], [$UIA_GridPatternId, $sIID_IUIAutomationGridPattern, $dtagIUIAutomationGridPattern], [$UIA_GridItemPatternId, $sIID_IUIAutomationGridItemPattern, $dtagIUIAutomationGridItemPattern], [$UIA_MultipleViewPatternId, $sIID_IUIAutomationMultipleViewPattern, $dtagIUIAutomationMultipleViewPattern], [$UIA_WindowPatternId, $sIID_IUIAutomationWindowPattern, $dtagIUIAutomationWindowPattern], [$UIA_DockPatternId, $sIID_IUIAutomationDockPattern, $dtagIUIAutomationDockPattern], [$UIA_TablePatternId, $sIID_IUIAutomationTablePattern, $dtagIUIAutomationTablePattern], [$UIA_TextPatternId, $sIID_IUIAutomationTextPattern, $dtagIUIAutomationTextPattern], [$UIA_TogglePatternId, $sIID_IUIAutomationTogglePattern, $dtagIUIAutomationTogglePattern], [$UIA_TransformPatternId, $sIID_IUIAutomationTransformPattern, $dtagIUIAutomationTransformPattern], [$UIA_ScrollItemPatternId, $sIID_IUIAutomationScrollItemPattern, $dtagIUIAutomationScrollItemPattern], [$UIA_ItemContainerPatternId, $sIID_IUIAutomationItemContainerPattern, $dtagIUIAutomationItemContainerPattern], [$UIA_VirtualizedItemPatternId, $sIID_IUIAutomationVirtualizedItemPattern, $dtagIUIAutomationVirtualizedItemPattern], [$UIA_SynchronizedInputPatternId, $sIID_IUIAutomationSynchronizedInputPattern, $dtagIUIAutomationSynchronizedInputPattern], [$UIA_ExpandCollapsePatternId, $sIID_IUIAutomationExpandCollapsePattern, $dtagIUIAutomationExpandCollapsePattern] ]
Func _UIA_getControlName($controlID)
Local $i
For $i = 0 To UBound($UIA_ControlArray) - 1
If($UIA_ControlArray[$i][1] = $controlID) Then
Return $UIA_ControlArray[$i][0]
EndIf
Next
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "No control with that id")
EndFunc
Func _UIA_getControlID($controlName)
Local $tName, $i
if isnumber($controlName) Then
return $controlName
EndIf
$tName = StringUpper($controlName)
If StringLeft($tName, 4) <> "UIA_" Then
$tName = "UIA_" & $tName
EndIf
If StringRight($tName, 7) = "CONTROL" Then
$tName = $tName & "CONTROLTYPEID"
EndIf
If StringRight($tName, 13) <> "CONTROLTYPEID" Then
$tName = $tName & "CONTROLTYPEID"
EndIf
For $i = 0 To UBound($UIA_ControlArray) - 1
If(StringUpper($UIA_ControlArray[$i][0]) = $tName) Then
Return $UIA_ControlArray[$i][1]
EndIf
Next
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "No control with that name " & $tname)
EndFunc
Func _UIA_getPropertyIndex($propName)
Local $i
For $i = 0 To UBound($UIA_propertiesSupportedArray, 1) - 1
If StringLower($UIA_propertiesSupportedArray[$i][$constColName]) = StringLower($propName) Then
Return $i
EndIf
Next
_UIA_LOG("[FATAL] : property you use is having invalid name:=" & $propName & @CRLF, $UIA_Log_Wrapper)
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "[FATAL] : property you use is having invalid name:=" & $propName & @CRLF)
EndFunc
Func _UIA_getPropertyValue($UIA_oUIElement, $id)
Local $tmpValue, $tmpStr, $iProperty
If Not _UIA_IsElement($UIA_oUIElement) Then
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "** NO PROPERTYVALUE DUE TO NONEXISTING OBJECT **")
EndIf
$UIA_oUIElement.GetCurrentPropertyValue($id, $tmpValue)
$tmpStr = "" & $tmpValue
If IsArray($tmpValue) Then
$tmpStr = ""
For $iProperty = 0 To UBound($tmpValue) - 1
$tmpStr = $tmpStr & StringStripWS($tmpValue[$iProperty], $STR_STRIPLEADING + $STR_STRIPTRAILING)
If $iProperty <> UBound($tmpValue) - 1 Then
$tmpStr = $tmpStr & ";"
EndIf
Next
Return $tmpStr
EndIf
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, $tmpStr)
EndFunc
Func _UIA_getAllPropertyValues($UIA_oUIElement)
Local $tmpStr, $tmpValue, $tSeparator, $i
$tmpStr = ""
$tSeparator = @CRLF
For $i = 0 To UBound($UIA_propertiesSupportedArray) - 1
If $UIA_propertiesSupportedArray[$i][$constColType] <> $__UIA_SpecialProperty Then
$tmpValue = _UIA_getPropertyValue($UIA_oUIElement, $UIA_propertiesSupportedArray[$i][1])
If $tmpValue <> "" Then
$tmpStr = $tmpStr & "UIA_" & $UIA_propertiesSupportedArray[$i][$constColName] & ":= <" & $tmpValue & ">" & $tSeparator
EndIf
EndIf
Next
Return $tmpStr
EndFunc
Func _UIA_getPattern($UIA_oUIElement, $patternID)
Local $pPattern, $oPattern
Local $sIID_Pattern
Local $sdTagPattern
Local $i
If Not _UIA_IsElement($UIA_oUIElement) Then
_UIA_LOG("Critical: UIA ERROR invalid element passed to getPattern function" & @CRLF, $UIA_Log_Wrapper)
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "UIA CRITICAL INVALID ELEMENT" & @CRLF)
Exit
EndIf
For $i = 0 To UBound($patternArray) - 1
If $patternArray[$i][0] = $patternID Then
$sIID_Pattern = $patternArray[$i][1]
$sdTagPattern = $patternArray[$i][2]
ExitLoop
EndIf
Next
$UIA_oUIElement.getCurrentPattern($patternID, $pPattern)
$oPattern = ObjCreateInterface($pPattern, $sIID_Pattern, $sdTagPattern)
If _UIA_IsElement($oPattern) Then
Return $oPattern
Else
_UIA_LOG("UIA WARNING ** NOT ** found the pattern" & @CRLF, $UIA_Log_Wrapper)
Return SetError($_UIASTATUS_GeneralError, $_UIASTATUS_GeneralError, "UIA WARNING ** NOT ** found the pattern" & @CRLF)
EndIf
EndFunc
Local Const $cRTI_Prefix = "RTI."
Global $__g_hFileLog
_UIA_TFW_Init()
Func _UIA_TFW_Init()
OnAutoItExitRegister("_UIA_TFW_Close")
_UIA_LoadConfiguration()
Local $logFileName = @ScriptDir & "\LOG\" & @YEAR & @MON & @MDAY & "-" & @HOUR & @MIN & @SEC & @MSEC & ".XML"
_UIA_setVar("logFileName", $logFileName)
_UIA_LogFile($logFileName, True)
_UIA_setVar("DESKTOP", $UIA_oDesktop)
_UIA_setVar("RTI.MAINWINDOW", $UIA_oDesktop)
_UIA_VersionInfo()
Return SetError($_UIASTATUS_Success, 0, 1)
EndFunc
Func _UIA_TFW_Close()
_UIA_LogFileClose()
Return SetError($_UIASTATUS_Success, 0, 1)
EndFunc
Func _UIA_LoadConfiguration()
_UIA_setVar("RTI.ACTIONCOUNT", 0)
_UIA_setVar("Global.Debug", True)
_UIA_setVar("Global.Debug.File", True)
_UIA_setVar("Global.Highlight", True)
If FileExists($UIA_CFGFileName) Then
_UIA_loadCFGFile($UIA_CFGFileName)
EndIf
Return SetError($_UIASTATUS_Success, 0, 1)
EndFunc
Func _UIA_loadCFGFile($strFname)
Local $sections, $values, $strKey, $strVal, $i, $j
$sections = IniReadSectionNames($strFname)
If @error <> 0 Then
_UIA_LOG("Error occurred on reading " & $strFname & @CRLF, $UIA_Log_Wrapper)
Else
For $i = 1 To $sections[0]
$values = IniReadSection($strFname, $sections[$i])
If @error <> 0 Then
_UIA_LOG("Error occurred on reading " & $strFname & @CRLF, $UIA_Log_Wrapper)
Else
For $j = 1 To $values[0][0]
$strKey = $sections[$i] & "." & $values[$j][0]
$strVal = $values[$j][1]
If StringLower($strVal) = "true" Then $strVal = True
If StringLower($strVal) = "false" Then $strVal = False
If StringLower($strVal) = "on" Then $strVal = True
If StringLower($strVal) = "off" Then $strVal = False
If StringLower($strVal) = "minimized" Then $strVal = @SW_MINIMIZE
If StringLower($strVal) = "maximized" Then $strVal = @SW_MAXIMIZE
If StringLower($strVal) = "normal" Then $strVal = @SW_RESTORE
$strVal = StringReplace($strVal, "%windowsdir%", @WindowsDir)
$strVal = StringReplace($strVal, "%programfilesdir%", @ProgramFilesDir)
_UIA_setVar($strKey, $strVal)
Next
EndIf
Next
EndIf
Return SetError($_UIASTATUS_Success, 0, 1)
EndFunc
Func _UIA_getVar($varName)
Local $iIndex
$iIndex = _ArraySearch($UIA_Vars, $varName)
If $iIndex <> -1 Then
Local $retValue = $UIA_Vars[$iIndex][1]
Return SetError($_UIASTATUS_Success, 0, $retValue)
Else
Return SetError($_UIASTATUS_InvalidValue, 1, "*** WARNING: not in repository *** reference:=" & $varName)
EndIf
EndFunc
Func _UIA_LogVarsArray()
Local $i, $vKey, $vValue, $vType
For $i = 0 To UBound($UIA_Vars, 1) - 1
$vKey = $UIA_Vars[$i][0]
$vValue = $UIA_Vars[$i][1]
$vType = VarGetType($vValue)
_UIA_LOG("Key: [" & $vKey & "] Value: [" & $vValue & "] Variable Type: " & $vType & @CRLF)
Next
EndFunc
Func _UIA_setVar($varName, $varValue)
Local $iIndex
$iIndex = _ArraySearch($UIA_Vars, $varName)
If $iIndex <> -1 Then
$UIA_Vars[$iIndex][1] = $varValue
Else
Local $aFill[1][2] = [[$varName, $varValue]]
_ArrayAdd($UIA_Vars, $aFill)
EndIf
Return SetError($_UIASTATUS_Success, 0, 1)
EndFunc
Func _UIA_normalizeExpression($sPropList)
Local $asAllProperties
Local $iPropertyCount
Local $asProperties2Match[1][4]
Local $i
Local $aKV
Local $iMatch
Local $propName, $propValue
Local $bSkipSpecialProperty
Local $UIA_oUIElement
Local $UIA_pUIElement
Local $index
$asAllProperties = StringSplit($sPropList, ";", 1)
$iPropertyCount = $asAllProperties[0] + 1
ReDim $asProperties2Match[$iPropertyCount][4]
If($iPropertyCount - 1) >= 1 Then
_UIA_LOG("_UIA_normalizeExpression " & $sPropList & ";" & "elements 1-" &($iPropertyCount - 1) & "in properties array" & @CRLF, $UIA_Log_Wrapper)
Else
_UIA_LOG("_UIA_normalizeExpression " & $sPropList & ";" & " property definition is incorrect" & @CRLF, $UIA_Log_Wrapper)
EndIf
For $i = 1 To $iPropertyCount - 1
_UIA_LOG("  _UIA_getObjectByFindAll property " & $i & " " & $asAllProperties[$i] & @CRLF, $UIA_Log_Wrapper)
$aKV = StringSplit($asAllProperties[$i], ":=", 1)
$iMatch = 0
$bSkipSpecialProperty = False
If $aKV[0] = 1 Then
$aKV[1] = StringStripWS($aKV[1], 3)
$propName = $UIA_NamePropertyId
$propValue = $asAllProperties[$i]
Switch $aKV[1]
Case "active", "[active]"
$UIA_oUIAutomation.GetFocusedElement($UIA_pUIElement)
$UIA_oUIElement = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
$propName = "object"
$propValue = $UIA_oUIElement
$iMatch = 1
$bSkipSpecialProperty = True
Case "last", "[last]"
$UIA_oUIElement = _UIA_getVar("RTI.LASTELEMENT")
If Not _UIA_IsElement($UIA_oUIElement) Then
$UIA_oUIElement = $UIA_oDesktop
EndIf
$propName = "object"
$propValue = $UIA_oUIElement
$iMatch = 1
$bSkipSpecialProperty = True
Case Else
$propName = $UIA_NamePropertyId
$propValue = $asAllProperties[$i]
$iMatch = 0
$bSkipSpecialProperty = False
EndSwitch
$asProperties2Match[$i][0] = $propName
$asProperties2Match[$i][1] = $propValue
$asProperties2Match[$i][2] = $iMatch
$asProperties2Match[$i][3] = $bSkipSpecialProperty
Else
$aKV[1] = StringStripWS($aKV[1], 3)
$aKV[2] = StringStripWS($aKV[2], 3)
$propName = $aKV[1]
$propValue = $aKV[2]
$iMatch = 0
$bSkipSpecialProperty = False
$index = _UIA_getPropertyIndex($propName)
If $index >= 0 Then
If $UIA_propertiesSupportedArray[$index][$constColType] = $__UIA_SpecialProperty Then
$bSkipSpecialProperty = True
$asProperties2Match[$i][0] = $propName
Else
Switch $UIA_propertiesSupportedArray[$index][$constcoltype]
Case $UIA_ControlTypePropertyId
if number($propValue)=0 Then
$propValue = _UIA_getControlID($propValue)
EndIf
$propvalue=number($propvalue)
EndSwitch
_UIA_LOG(" name:[" & $propName & "] value:[" & $propValue & "] having index " & $index & @CRLF, $UIA_Log_Wrapper)
$asProperties2Match[$i][0] = $UIA_propertiesSupportedArray[$index][$constColType]
EndIf
Else
$asProperties2Match[$i][0] = $propName
EndIf
$asProperties2Match[$i][1] = $propValue
$asProperties2Match[$i][2] = $iMatch
$asProperties2Match[$i][3] = $bSkipSpecialProperty
EndIf
Next
$asProperties2Match[0][0] = $iPropertyCount
Return $asProperties2Match
EndFunc
Func _UIA_getObjectByFindAll($UIA_oUIElement, $str, $treeScope = $treescope_children, $p1 = 0)
Local $pElements, $iLength
Local $iPropertyMatch = 0
Local $propertyID
Local $relPos = 0
Local $relIndex = 0
Local $iMatch = 0
Local $tmpStr
Local $parentHandle
Local $properties2Match[1][4]
Local $i, $arrSize, $j
Local $objParent, $propertyActualValue, $propertyVal, $oAutomationElementArray, $matchCount
Local $bSkipSpecialProperty = False
Local $tXMLLogString
Local $itUIA_oUIElement
Local $UIA_oUIElementFound
Local $propName
$properties2Match = _UIA_normalizeExpression($str)
$arrSize = UBound($properties2Match, 1) - 1
If $properties2Match[1][0] = "object" Then
$UIA_oUIElementFound = $properties2Match[1][1]
$iMatch = 1
EndIf
If $iMatch = 0 Then
For $i = 1 To $arrSize
$propName = $properties2Match[$i][0]
$bSkipSpecialProperty = $properties2Match[$i][3]
If $bSkipSpecialProperty = True Then
If $propName = "indexrelative" Then
$relPos = $properties2Match[$i][1]
consolewrite("Relative position is : "& $relPos &@CRLF)
EndIf
If($propName = "index") Or($propName = "instance") Then
$relIndex = $properties2Match[$i][1]
EndIf
EndIf
Next
If _UIA_IsElement($UIA_oUIElement) Then
_UIA_LOG("*** Try to get a list of elements *** treescopetype:=" & $treeScope & @CRLF, $UIA_Log_Wrapper)
$UIA_oUIElement.FindAll($treeScope, $UIA_oTRUECondition, $pElements)
$oAutomationElementArray = ObjCreateInterface($pElements, $sIID_IUIAutomationElementArray, $dtagIUIAutomationElementArray)
EndIf
$matchCount = 0
If _UIA_IsElement($oAutomationElementArray) Then
$oAutomationElementArray.Length($iLength)
Else
_UIA_LOG("***** FATAL:???? _UIA_getObjectByFindAll no childarray found for object with following details *****" & @CRLF, $UIA_Log_Wrapper)
_UIA_LOG(_UIA_getAllPropertyValues($UIA_oUIElement) & @CRLF, $UIA_Log_Wrapper)
$iLength = 0
EndIf
_UIA_LOG("_UIA_getObjectByFindAll walk thru the tree with n elements where n equals " & $iLength )
$tXMLLogString = "<propertymatching>"
For $i = 0 To $iLength - 1
$oAutomationElementArray.GetElement($i, $UIA_pUIElement)
$itUIA_oUIElement = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
$iMatch = 0
$tmpStr = _UIA_getBasePropertyInfo($itUIA_oUIElement)
$iPropertyMatch = 0
For $j = 1 To $arrSize
$bSkipSpecialProperty = $properties2Match[$j][3]
If $bSkipSpecialProperty = False Then
$propertyID = $properties2Match[$j][0]
$propertyVal = $properties2Match[$j][1]
$propertyActualValue = ""
Switch $propertyID
Case $UIA_ControlTypePropertyId
$propertyVal = Number($propertyVal)
EndSwitch
$propertyActualValue = _UIA_getPropertyValue($itUIA_oUIElement, $propertyID)
$iPropertyMatch = StringRegExp($propertyActualValue, $propertyVal, $STR_REGEXPMATCH)
If $iPropertyMatch = 0 Then
If $propertyVal <> $propertyActualValue Then
ExitLoop
EndIf
EndIf
EndIf
Next
If $iPropertyMatch = 1 Then
$iMatch = 1
If $relPos <> 0 Then
_UIA_LOG("Relative position used", $UIA_Log_Wrapper)
$oAutomationElementArray.GetElement($i + $relPos, $UIA_pUIElement)
$UIA_oUIElementFound = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
$itUIA_oUIElement=$UIA_oUIElementFound
$iMatch = 1
EndIf
If $relIndex <> 0 Then
$matchCount = $matchCount + 1
If $matchCount <> $relIndex Then
$iMatch = 0
_UIA_LOG(" Found and skipped due to index position: <" & $relIndex & " " & $matchCount & " " & $tmpStr & @CRLF, $UIA_Log_Wrapper)
Else
$iMatch = 1
EndIf
EndIf
If $iMatch = 1 Then
_UIA_LOG("Found match with element: " & $i & " the Name is: <" & $tmpStr & @CRLF, $UIA_Log_Wrapper)
$UIA_oUIElementFound = $itUIA_oUIElement
ExitLoop
EndIf
EndIf
Next
$tXMLLogString = $tXMLLogString & "</propertymatching>"
_UIA_LOG($tXMLLogString, $UIA_Log_Wrapper)
EndIf
If $iMatch = 1 Then
$UIA_oTW.getparentelement($UIA_oUIElementFound, $parentHandle)
$objParent = ObjCreateInterface($parentHandle, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
If _UIA_IsElement($objParent) = 0 Then
_UIA_LOG("No parent " & @CRLF, $UIA_Log_Wrapper)
Else
_UIA_LOG("Storing parent for found object in RTI as RTI.PARENT " & _UIA_getPropertyValue($objParent, $UIA_NamePropertyId) & @CRLF, $UIA_Log_Wrapper)
_UIA_setVar("RTI.PARENT", $objParent)
EndIf
If IsString($p1) Then
_UIA_LOG("Storing in RTI as RTI." & $p1 & @CRLF, $UIA_Log_Wrapper)
_UIA_setVar("RTI." & StringUpper($p1), $UIA_oUIElementFound)
EndIf
If(_UIA_getVar("Global.Highlight") = True) Then
_UIA_Highlight($UIA_oUIElementFound)
EndIf
Return $UIA_oUIElementFound
Else
Return ""
EndIf
EndFunc
Func _UIA_getObject($obj_or_string)
Local $oElement
Local $tPhysical
Local $strStartElement, $oStart, $pos, $tmpStr
Local $oParentHandle, $oParentBefore, $i
Local $parentCount
$parentCount = $parentCount + 1
If _UIA_IsElement($obj_or_string) Then
$oElement = $obj_or_string
Else
$oElement = _UIA_getVar($cRTI_Prefix & $obj_or_string)
If @error <> 0 Then
$oElement = _UIA_getVar($obj_or_string)
$tPhysical = $oElement
EndIf
If @error <> 0 Then
_UIA_LOG("Finding object (bypassing repository) with physical description " & $tPhysical & ":" & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
$tPhysical = $obj_or_string
EndIf
EndIf
If _UIA_IsElement($oElement) Then
_UIA_LOG("Quickly referenced object " & $tPhysical & ":" & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
Else
If StringRight($obj_or_string, StringLen(".mainwindow")) = ".mainwindow" Then
$strStartElement = "Desktop"
$oStart = $UIA_oDesktop
_UIA_LOG("Fallback finding 1 object under " & $strStartElement & @TAB & $tPhysical & @CRLF, $UIA_Log_Wrapper)
$oElement = _UIA_getObjectByFindAll($oStart, $tPhysical, $treescope_children, $obj_or_string)
_UIA_setVar("RTI.MAINWINDOW", $oElement)
_UIA_setVar($cRTI_Prefix & StringUpper($obj_or_string), $oElement)
_UIA_setVar("RTI.SEARCHCONTEXT", $oElement)
Else
$oStart = _UIA_getVar("RTI.SEARCHCONTEXT")
$strStartElement = "RTI.SEARCHCONTEXT"
If Not _UIA_IsElement($oStart) Then
$pos = StringInStr($obj_or_string, ".")
_UIA_LOG("_UIA_action: No RTI.SEARCHCONTEXT used for " & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
If $pos > 0 Then
$tmpStr = $cRTI_Prefix & StringLeft(StringUpper($obj_or_string), $pos - 1) & ".MAINWINDOW"
Else
$tmpStr = "RTI.MAINWINDOW"
EndIf
_UIA_LOG("_UIA_action: try for " & $tmpStr & @CRLF, $UIA_Log_Wrapper)
$oStart = _UIA_getVar($tmpStr)
$strStartElement = $tmpStr
If Not _UIA_IsElement($oStart) Then
_UIA_LOG("_UIA_action: No RTI.MAINWINDOW used for " & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
_UIA_LogVarsArray()
$oStart = _UIA_getVar("RTI.PARENT")
$strStartElement = "RTI.PARENT"
If Not _UIA_IsElement($oStart) Then
_UIA_LOG("_UIA_action: No RTI.PARENT used for " & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
$strStartElement = "Desktop"
$oStart = $UIA_oDesktop
EndIf
EndIf
EndIf
_UIA_LOG("_UIA_action: Finding object " & $obj_or_string & " object a:=" & _UIA_IsElement($obj_or_string) & " under " & $strStartElement & " object b:=" & _UIA_IsElement($oStart) & @CRLF, $UIA_Log_Wrapper)
_UIA_LOG("  looking for " & $tPhysical & @CRLF, $UIA_Log_Wrapper)
$oElement = _UIA_getObjectByFindAll($oStart, $tPhysical, $treescope_children)
If Not _UIA_IsElement($oElement) Then
consolewrite("  deep find in subtree 1 " & $obj_or_string & ";" & $strStartElement & @CRLF)
consolewrite("  deep find in subtree 2 " & $tPhysical & ";" & $strStartElement & @CRLF)
consolewrite("    RTI.MAINWINDOW is an object" & isobj(_UIA_getVar("RTI.MAINWINDOW")) & @CRLF)
_UIA_LOG("  deep find in subtree " & $tPhysical & @CRLF, $UIA_Log_Wrapper)
$oElement = _UIA_getObjectByFindAll($oStart, $tPhysical, $treescope_subtree)
EndIf
If Not _UIA_IsElement($oElement) Then
_UIA_LOG("  walking back to mainwindow and deep find in subtree " & $tPhysical & @CRLF, $UIA_Log_Wrapper)
$UIA_oUIAutomation.RawViewWalker($UIA_pTW)
$UIA_oTW = ObjCreateInterface($UIA_pTW, $sIID_IUIAutomationTreeWalker, $dtagIUIAutomationTreeWalker)
If Not _UIA_IsElement($UIA_oTW) Then
_UIA_LOG("UI automation treewalker failed. UI Automation failed failed " & @CRLF, $UIA_Log_Wrapper)
EndIf
$i = 0
$UIA_oTW.getparentelement($oStart, $oParentHandle)
$oParentHandle = ObjCreateInterface($oParentHandle, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
If _UIA_IsElement($oParentHandle) = 0 Then
_UIA_LOG("No parent: UI Automation failed could be you spy the desktop", $UIA_Log_Wrapper)
Else
While($i <= $_UIA_MAXDEPTH) And(_UIA_IsElement($oParentHandle) = True)
_UIA_LOG(_UIA_getPropertyValue($oParentHandle, $UIA_NamePropertyId) & " parent" & $i, $UIA_Log_Wrapper)
$i = $i + 1
$oParentBefore = $oParentHandle
$UIA_oTW.getparentelement($oParentHandle, $oParentHandle)
$oParentHandle = ObjCreateInterface($oParentHandle, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
WEnd
$parentCount = $i - 1
$oStart = $oParentBefore
EndIf
$oElement = _UIA_getObjectByFindAll($oStart, $tPhysical, $treescope_subtree)
EndIf
If Not _UIA_IsElement($oElement) Then
If _UIA_getVar("Global.Debug") = True Then
_UIA_DumpThemAll($oStart, $treescope_subtree)
EndIf
Else
EndIf
EndIf
EndIf
Return $oElement
EndFunc
Func _UIA_action($obj_or_string, $strAction, $p1 = 0, $p2 = 0, $p3 = 0, $p4 = 0)
Local $obj2ActOn
Local $tPattern
Local $x, $y
Local $controlType
Local $oElement
Local $hwnd
Local $retValue = True
Local $tRect
_UIA_LOG($__UIA_debugCacheOn)
$oElement = _UIA_getObject($obj_or_string)
If _UIA_IsElement($oElement) Then
$obj2ActOn = $oElement
_UIA_setVar("RTI.LASTELEMENT", $oElement)
$controlType = _UIA_getPropertyValue($obj2ActOn, $UIA_ControlTypePropertyId)
Else
If Not StringInStr("exist,exists", $strAction) Then
_UIA_LOG("Not an object failing action " & $strAction & " on " & $obj_or_string & @CRLF, $UIA_Log_Wrapper)
SetError(1)
Return False
EndIf
EndIf
_UIA_setVar("RTI.ACTIONCOUNT", _UIA_getVar("RTI.ACTIONCOUNT") + 1)
_UIA_LOG("<action>Action " & _UIA_getVar("RTI.ACTIONCOUNT") & " " & $strAction & " on " & $obj_or_string & " _UIA_IsElement:=" & _UIA_IsElement($obj2ActOn) & " Parameters 1:=" & $p1 & " 2:=" & $p2 & " 3:=" & $p3 & " 4:=" & $p4 & "</action>" & @CRLF, $UIA_Log_Wrapper)
_UIA_LOG($__UIA_debugCacheOff)
Switch $strAction
Case "leftclick", "left", "click", "leftdoubleclick", "leftdouble", "doubleclick", "rightclick", "right", "rightdoubleclick", "rightdouble", "middleclick", "middle", "middledoubleclick", "middledouble", "mousemove", "movemouse"
Local $clickAction = "left"
Local $clickCount = 1
If StringInStr($strAction, "right") Then $clickAction = "right"
If StringInStr($strAction, "middle") Then $clickAction = "middle"
If StringInStr($strAction, "double") Then $clickCount = 2
Local $t
$t = StringSplit(_UIA_getPropertyValue($obj2ActOn, $UIA_BoundingRectanglePropertyId), ";")
if $p1=0 then
$x = Int($t[1] +($t[3] / 2))
$y = Int($t[2] + $t[4] / 2)
Else
$x=Int($t[1] +$p1)
$y=Int($t[2] +$p2)
endif
MouseMove($x, $y, 0)
If Not StringInStr($strAction, "move") Then
MouseClick($clickAction, $x, $y, $clickCount, 0)
EndIf
Sleep($UIA_DefaultWaitTime)
Case "setValue", "settextValue"
If($controlType = $UIA_WindowControlTypeId) Then
$hwnd = 0
$obj2ActOn.CurrentNativeWindowHandle($hwnd)
WinSetTitle(HWnd($hwnd), "", $p1)
Else
$obj2ActOn.setfocus()
Sleep($UIA_DefaultWaitTime)
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_LegacyIAccessiblePatternId)
If _UIA_IsElement($tPattern) Then
$tPattern.setValue($p1)
Else
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_ValuePatternId)
If _UIA_IsElement($tPattern) Then
$tPattern.setValue($p1)
EndIf
EndIf
EndIf
Case "setValue using keys"
$obj2ActOn.setfocus()
Send("^a")
Send($p1)
Sleep($UIA_DefaultWaitTime)
Case "setValue using clipboard"
ClipPut($p1)
$obj2ActOn.setfocus()
Send("^v")
Sleep($UIA_DefaultWaitTime)
Case "getValue"
$obj2ActOn.setfocus()
Send("^a")
sleep(50)
Send("^c")
$retValue = ClipGet()
Case "sendkeys", "enterstring", "type", "typetext"
$obj2ActOn.setfocus()
Send($p1)
Case "invoke"
$obj2ActOn.setfocus()
Sleep($UIA_DefaultWaitTime)
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_InvokePatternId)
if isobj($tPattern) then
$tPattern.invoke()
Else
consolewrite("FATAL: your object does not support invoke, try click instead")
EndIf
Case "focus", "setfocus", "activate", "switchto"
_UIA_setVar("RTI.SEARCHCONTEXT", $obj2ActOn)
$obj2ActOn.setfocus()
Sleep($UIA_DefaultWaitTime)
Case "close"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.close()
Case "move", "setposition"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_TransformPatternId)
$tPattern.move($p1, $p2)
Case "resize"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.SetWindowVisualState($WindowVisualState_Normal)
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_TransformPatternId)
$tPattern.resize($p1, $p2)
Case "minimize"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.SetWindowVisualState($WindowVisualState_Minimized)
Case "maximize"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.SetWindowVisualState($WindowVisualState_Maximized)
Case "normal"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.SetWindowVisualState($WindowVisualState_Normal)
Case "close"
$tPattern = _UIA_getPattern($obj2ActOn, $UIA_WindowPatternId)
$tPattern.close()
Case "exist", "exists"
$retValue = True
Case "searchcontext", "context"
_UIA_setVar("RTI.SEARCHCONTEXT", $obj2ActOn)
Case "highlight"
_UIA_Highlight($obj2ActOn)
Case "getobject", "object"
Return $obj2ActOn
Case "attach"
Return $obj2ActOn
Case "capture", "screenshot", "takescreenshot"
$tRect = StringSplit(_UIA_getPropertyValue($obj2ActOn, $UIA_BoundingRectanglePropertyId), ";")
ConsoleWrite($p1 & ";" & $tRect[1] & ";" &($tRect[3] + $tRect[1]) & ";" & $tRect[2] & ";" &($tRect[4] + $tRect[2]))
_ScreenCapture_Capture($p1, $tRect[1], $tRect[2], $tRect[3] + $tRect[1], $tRect[4] + $tRect[2])
Case "dump", "dumpthemall"
_UIA_DumpThemAll($obj2ActOn, $treescope_subtree)
Case "propertyvalue", "property"
Local $i = _UIA_getPropertyIndex($p1)
If Not @error <> 0 Then
$retValue = _UIA_getPropertyValue($obj2ActOn, $UIA_propertiesSupportedArray[$i][1])
Else
$retValue = _UIA_getPropertyValue($obj2ActOn, $p1)
EndIf
Case Else
EndSwitch
Return $retValue
EndFunc
Func _UIA_DumpThemAll($oElementStart, $treeScope)
Local $oAutomationElementArray
Local $pElements, $iLength, $i
Local $dumpStr
Local $tmpStr
If not _UIA_IsElement($oElementStart) Then
exit
EndIf
$dumpStr = "<treedump>"
$dumpStr = $dumpStr & "<treeheader>***** Dumping tree *****</treeheader>"
$oElementStart.FindAll($treeScope, $UIA_oTRUECondition, $pElements)
$oAutomationElementArray = ObjCreateInterface($pElements, $sIID_IUIAutomationElementArray, $dtagIUIAutomationElementArray)
If _UIA_IsElement($oAutomationElementArray) Then
$oAutomationElementArray.Length($iLength)
Else
$dumpStr = $dumpStr & "<fatal>***** FATAL:???? _UIA_DumpThemAll no childarray found ***** </fatal>"
$iLength = 0
EndIf
For $i = 0 To $iLength - 1
$oAutomationElementArray.GetElement($i, $UIA_pUIElement)
$UIA_oUIElement = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
$tmpStr = "Title is: <" & _UIA_getPropertyValue($UIA_oUIElement, $UIA_NamePropertyId) & ">" & @TAB & "Class   := <" & _UIA_getPropertyValue($UIA_oUIElement, $UIA_ClassNamePropertyId) & ">" & @TAB & "controltype:= " & "<" & _UIA_getControlName(_UIA_getPropertyValue($UIA_oUIElement, $UIA_ControlTypePropertyId)) & ">" & @TAB & ",<" & _UIA_getPropertyValue($UIA_oUIElement, $UIA_ControlTypePropertyId) & ">" & @TAB & ", (" & Hex(_UIA_getPropertyValue($UIA_oUIElement, $UIA_ControlTypePropertyId)) & ")" & @TAB & ", acceleratorkey:= <" & _UIA_getPropertyValue($UIA_oUIElement, $UIA_AcceleratorKeyPropertyId) & ">" & @TAB & ", automationid:= <" & _UIA_getPropertyValue($UIA_oUIElement, $UIA_AutomationIdPropertyId) & ">" & @TAB
$tmpStr = _UIA_EncodeHTMLString($tmpStr)
$dumpStr = $dumpStr & "<elementinfo>" & $tmpStr & "</elementinfo>"
Next
$dumpStr = $dumpStr & "</treedump>"
_UIA_LOG($dumpStr)
EndFunc
Func _UIA_Highlight($oElement)
Local $t
$t = StringSplit(_UIA_getPropertyValue($oElement, $UIA_BoundingRectanglePropertyId), ";")
_UIA_DrawRect($t[1], $t[3] + $t[1], $t[2], $t[4] + $t[2])
EndFunc
Func _UIA_EncodeHTMLString($str)
Local $tmpStr = $str
$tmpStr = StringReplace($tmpStr, "&", "&amp;")
$tmpStr = StringReplace($tmpStr, ">", "&gt;")
$tmpStr = StringReplace($tmpStr, "<", "&lt;")
$tmpStr = StringReplace($tmpStr, """", "&quot;")
$tmpStr = StringReplace($tmpStr, "'", "&apos;")
$tmpStr = StringReplace($tmpStr, "&amp;gt;", "&gt;")
$tmpStr = StringReplace($tmpStr, "&amp;lt;", "&lt;")
$tmpStr = StringReplace($tmpStr, "&amp;quot;", "&quot;")
$tmpStr = StringReplace($tmpStr, "&amp;apos;", "&apos;")
Return $tmpStr
EndFunc
Func _UIA_LogFile($strName = "log.xml", $reset = False)
If _UIA_getVar("global.debug.file") = True Then
If $reset = True Then
$__g_hFileLog = FileOpen($strName, $FO_CREATEPATH + $FO_OVERWRITE + $FO_UTF8)
FileWrite($__g_hFileLog, "<?xml version=""1.0"" encoding=""UTF-8""?>")
FileWrite($__g_hFileLog, "<log space=""preserve"">")
Else
$__g_hFileLog = FileOpen($strName, $FO_APPEND + $FO_UTF8)
EndIf
EndIf
EndFunc
Func _UIA_LogFileClose()
If _UIA_getVar("global.debug.file") = True Then
FileWrite($__g_hFileLog, "</log>" & @CRLF)
FileClose($__g_hFileLog)
EndIf
EndFunc
Func _UIA_LOG($sLogString, $logLevel = 0)
Local $sLogStrOut, $bFlushCache = False
If Not((_UIA_getVar("global.debug.file") = True) Or(_UIA_getVar("global.debug") = True)) Then Return SetError($_UIASTATUS_Success, $_UIASTATUS_Success, "")
If $sLogString = $__UIA_debugCacheOn Then
$sLogString = ""
$__l_UIA_CacheState = True
$bFlushCache = True
EndIf
If $sLogString = $__UIA_debugCacheOff Then
$__l_UIA_CacheState = False
$sLogString = $__gl_XMLCache
EndIf
If StringLeft($sLogString, 1) <> "<" Then
$sLogString = _UIA_EncodeHTMLString($sLogString)
EndIf
If $__l_UIA_CacheState = True And $bFlushCache = False Then
$__gl_XMLCache = $__gl_XMLCache & $sLogString
EndIf
If($__l_UIA_CacheState = False) Or($bFlushCache = True) Then
If StringRight($sLogString, 2) = @CRLF Then
$sLogString = StringLeft($sLogString, StringLen($sLogString) - 2)
EndIf
$sLogStrOut = "<logline level=""" & $logLevel & """"
$sLogStrOut = $sLogStrOut & " timestamp=""" & @YEAR & @MON & @MDAY & "-" & @HOUR & @MIN & @SEC & @MSEC & """>"
$sLogStrOut = $sLogStrOut & " " & $sLogString & "</logline>" & @CRLF
If _UIA_getVar("global.debug.file") = True Then
FileWrite($__g_hFileLog, $sLogStrOut)
Else
If _UIA_getVar("global.debug") = True Then
ConsoleWrite($sLogStrOut)
EndIf
EndIf
$__gl_XMLCache = ""
EndIf
Return $_UIASTATUS_Success
EndFunc
Func _UIA_getBasePropertyInfo($oUIElement)
Local $title = _UIA_getPropertyValue($oUIElement, $UIA_NamePropertyId)
Local $class = _UIA_getPropertyValue($oUIElement, $uia_classnamepropertyid)
Local $controltypeName = _UIA_getControlName(_UIA_getPropertyValue($oUIElement, $UIA_ControlTypePropertyId))
Local $controltypeId = _UIA_getPropertyValue($oUIElement, $UIA_ControlTypePropertyId)
Local $nativeWindow = _UIA_getPropertyValue($oUIElement, $UIA_NativeWindowHandlePropertyId)
Local $controlRect = _UIA_getPropertyValue($oUIElement, $UIA_BoundingRectanglePropertyId)
Local $acceleratorkey = _UIA_getPropertyValue($oUIElement, $UIA_AcceleratorKeyPropertyId)
Local $automationid = _UIA_getPropertyValue($oUIElement, $UIA_AutomationIdPropertyId)
Return "Title is: <" & $title & ">" & @TAB & "Class   := <" & $class & ">" & @TAB & "controltype:= " & "<" & $controltypeName & ">" & @TAB & ",<" & $controltypeId & ">" & @TAB & ", (" & Hex($controltypeId) & ")" & @TAB & "rect := < " & $controlRect & ">" & @TAB & "hwnd := < " & $nativeWindow & ">" & @TAB & "acceleratorkey := < " & $acceleratorkey & ">" & @TAB & "automationid := <" & $automationid & ">" & @CRLF
EndFunc
Func _UIA_DrawRect($tLeft, $tRight, $tTop, $tBottom, $color = 0xFF, $PenWidth = 4)
Local $hDC, $hPen, $obj_orig, $x1, $x2, $y1, $y2
$x1 = $tLeft
$x2 = $tRight
$y1 = $tTop
$y2 = $tBottom
$hDC = _WinAPI_GetWindowDC(0)
$hPen = _WinAPI_CreatePen($PS_SOLID, $PenWidth, $color)
$obj_orig = _WinAPI_SelectObject($hDC, $hPen)
_WinAPI_DrawLine($hDC, $x1, $y1, $x2, $y1)
_WinAPI_DrawLine($hDC, $x2, $y1, $x2, $y2)
_WinAPI_DrawLine($hDC, $x2, $y2, $x1, $y2)
_WinAPI_DrawLine($hDC, $x1, $y2, $x1, $y1)
_WinAPI_SelectObject($hDC, $obj_orig)
_WinAPI_DeleteObject($hPen)
_WinAPI_ReleaseDC(0, $hDC)
EndFunc
Func _UIA_IsElement($control)
Return IsObj($control)
EndFunc
Func _UIA_VersionInfo()
_UIA_LOG(_UIA_getVersionInfoString(), $UIA_Log_Wrapper)
Return SetError($_UIASTATUS_Success, 0, $__gaUIAAU3VersionInfo)
EndFunc
Func _UIA_getVersionInfoString()
Return "<information> Information " & "_UIA_VersionInfo" & " version: " & $__gaUIAAU3VersionInfo[0] & $__gaUIAAU3VersionInfo[1] & "." & $__gaUIAAU3VersionInfo[2] & "-" & $__gaUIAAU3VersionInfo[3] & ";" & " Release date: " & $__gaUIAAU3VersionInfo[4] & ";" & " OS Version: " & @OSVersion & "</information>" & @CRLF
EndFunc
Func _FileCountLines($sFilePath)
FileReadToArray($sFilePath)
If @error Then Return SetError(@error, @extended, 0)
Return @extended
EndFunc
Func _FileListToArrayRec($sFilePath, $sMask = "*", $iReturn = $FLTAR_FILESFOLDERS, $iRecur = $FLTAR_NORECUR, $iSort = $FLTAR_NOSORT, $iReturnPath = $FLTAR_RELPATH)
If Not FileExists($sFilePath) Then Return SetError(1, 1, "")
If $sMask = Default Then $sMask = "*"
If $iReturn = Default Then $iReturn = $FLTAR_FILESFOLDERS
If $iRecur = Default Then $iRecur = $FLTAR_NORECUR
If $iSort = Default Then $iSort = $FLTAR_NOSORT
If $iReturnPath = Default Then $iReturnPath = $FLTAR_RELPATH
If $iRecur > 1 Or Not IsInt($iRecur) Then Return SetError(1, 6, "")
Local $bLongPath = False
If StringLeft($sFilePath, 4) == "\\?\" Then
$bLongPath = True
EndIf
Local $sFolderSlash = ""
If StringRight($sFilePath, 1) = "\" Then
$sFolderSlash = "\"
Else
$sFilePath = $sFilePath & "\"
EndIf
Local $asFolderSearchList[100] = [1]
$asFolderSearchList[1] = $sFilePath
Local $iHide_HS = 0, $sHide_HS = ""
If BitAND($iReturn, $FLTAR_NOHIDDEN) Then
$iHide_HS += 2
$sHide_HS &= "H"
$iReturn -= $FLTAR_NOHIDDEN
EndIf
If BitAND($iReturn, $FLTAR_NOSYSTEM) Then
$iHide_HS += 4
$sHide_HS &= "S"
$iReturn -= $FLTAR_NOSYSTEM
EndIf
Local $iHide_Link = 0
If BitAND($iReturn, $FLTAR_NOLINK) Then
$iHide_Link = 0x400
$iReturn -= $FLTAR_NOLINK
EndIf
Local $iMaxLevel = 0
If $iRecur < 0 Then
StringReplace($sFilePath, "\", "", 0, $STR_NOCASESENSEBASIC)
$iMaxLevel = @extended - $iRecur
EndIf
Local $sExclude_List = "", $sExclude_List_Folder = "", $sInclude_List = "*"
Local $aMaskSplit = StringSplit($sMask, "|")
Switch $aMaskSplit[0]
Case 3
$sExclude_List_Folder = $aMaskSplit[3]
ContinueCase
Case 2
$sExclude_List = $aMaskSplit[2]
ContinueCase
Case 1
$sInclude_List = $aMaskSplit[1]
EndSwitch
Local $sInclude_File_Mask = ".+"
If $sInclude_List <> "*" Then
If Not __FLTAR_ListToMask($sInclude_File_Mask, $sInclude_List) Then Return SetError(1, 2, "")
EndIf
Local $sInclude_Folder_Mask = ".+"
Switch $iReturn
Case 0
Switch $iRecur
Case 0
$sInclude_Folder_Mask = $sInclude_File_Mask
EndSwitch
Case 2
$sInclude_Folder_Mask = $sInclude_File_Mask
EndSwitch
Local $sExclude_File_Mask = ":"
If $sExclude_List <> "" Then
If Not __FLTAR_ListToMask($sExclude_File_Mask, $sExclude_List) Then Return SetError(1, 3, "")
EndIf
Local $sExclude_Folder_Mask = ":"
If $iRecur Then
If $sExclude_List_Folder Then
If Not __FLTAR_ListToMask($sExclude_Folder_Mask, $sExclude_List_Folder) Then Return SetError(1, 4, "")
EndIf
If $iReturn = 2 Then
$sExclude_Folder_Mask = $sExclude_File_Mask
EndIf
Else
$sExclude_Folder_Mask = $sExclude_File_Mask
EndIf
If Not($iReturn = 0 Or $iReturn = 1 Or $iReturn = 2) Then Return SetError(1, 5, "")
If Not($iSort = 0 Or $iSort = 1 Or $iSort = 2) Then Return SetError(1, 7, "")
If Not($iReturnPath = 0 Or $iReturnPath = 1 Or $iReturnPath = 2) Then Return SetError(1, 8, "")
If $iHide_Link Then
Local $tFile_Data = DllStructCreate("struct;align 4;dword FileAttributes;uint64 CreationTime;uint64 LastAccessTime;uint64 LastWriteTime;" & "dword FileSizeHigh;dword FileSizeLow;dword Reserved0;dword Reserved1;wchar FileName[260];wchar AlternateFileName[14];endstruct")
Local $hDLL = DllOpen('kernel32.dll'), $aDLL_Ret
EndIf
Local $asReturnList[100] = [0]
Local $asFileMatchList = $asReturnList, $asRootFileMatchList = $asReturnList, $asFolderMatchList = $asReturnList
Local $bFolder = False, $hSearch = 0, $sCurrentPath = "", $sName = "", $sRetPath = ""
Local $iAttribs = 0, $sAttribs = ''
Local $asFolderFileSectionList[100][2] = [[0, 0]]
While $asFolderSearchList[0] > 0
$sCurrentPath = $asFolderSearchList[$asFolderSearchList[0]]
$asFolderSearchList[0] -= 1
Switch $iReturnPath
Case 1
$sRetPath = StringReplace($sCurrentPath, $sFilePath, "")
Case 2
If $bLongPath Then
$sRetPath = StringTrimLeft($sCurrentPath, 4)
Else
$sRetPath = $sCurrentPath
EndIf
EndSwitch
If $iHide_Link Then
$aDLL_Ret = DllCall($hDLL, 'handle', 'FindFirstFileW', 'wstr', $sCurrentPath & "*", 'struct*', $tFile_Data)
If @error Or Not $aDLL_Ret[0] Then
ContinueLoop
EndIf
$hSearch = $aDLL_Ret[0]
Else
$hSearch = FileFindFirstFile($sCurrentPath & "*")
If $hSearch = -1 Then
ContinueLoop
EndIf
EndIf
If $iReturn = 0 And $iSort And $iReturnPath Then
__FLTAR_AddToList($asFolderFileSectionList, $sRetPath, $asFileMatchList[0] + 1)
EndIf
$sAttribs = ''
While 1
If $iHide_Link Then
$aDLL_Ret = DllCall($hDLL, 'int', 'FindNextFileW', 'handle', $hSearch, 'struct*', $tFile_Data)
If @error Or Not $aDLL_Ret[0] Then
ExitLoop
EndIf
$sName = DllStructGetData($tFile_Data, "FileName")
If $sName = ".." Then
ContinueLoop
EndIf
$iAttribs = DllStructGetData($tFile_Data, "FileAttributes")
If $iHide_HS And BitAND($iAttribs, $iHide_HS) Then
ContinueLoop
EndIf
If BitAND($iAttribs, $iHide_Link) Then
ContinueLoop
EndIf
$bFolder = False
If BitAND($iAttribs, 16) Then
$bFolder = True
EndIf
Else
$bFolder = False
$sName = FileFindNextFile($hSearch, 1)
If @error Then
ExitLoop
EndIf
$sAttribs = @extended
If StringInStr($sAttribs, "D") Then
$bFolder = True
EndIf
If StringRegExp($sAttribs, "[" & $sHide_HS & "]") Then
ContinueLoop
EndIf
EndIf
If $bFolder Then
Select
Case $iRecur < 0
StringReplace($sCurrentPath, "\", "", 0, $STR_NOCASESENSEBASIC)
If @extended < $iMaxLevel Then
ContinueCase
EndIf
Case $iRecur = 1
If Not StringRegExp($sName, $sExclude_Folder_Mask) Then
__FLTAR_AddToList($asFolderSearchList, $sCurrentPath & $sName & "\")
EndIf
EndSelect
EndIf
If $iSort Then
If $bFolder Then
If StringRegExp($sName, $sInclude_Folder_Mask) And Not StringRegExp($sName, $sExclude_Folder_Mask) Then
__FLTAR_AddToList($asFolderMatchList, $sRetPath & $sName & $sFolderSlash)
EndIf
Else
If StringRegExp($sName, $sInclude_File_Mask) And Not StringRegExp($sName, $sExclude_File_Mask) Then
If $sCurrentPath = $sFilePath Then
__FLTAR_AddToList($asRootFileMatchList, $sRetPath & $sName)
Else
__FLTAR_AddToList($asFileMatchList, $sRetPath & $sName)
EndIf
EndIf
EndIf
Else
If $bFolder Then
If $iReturn <> 1 And StringRegExp($sName, $sInclude_Folder_Mask) And Not StringRegExp($sName, $sExclude_Folder_Mask) Then
__FLTAR_AddToList($asReturnList, $sRetPath & $sName & $sFolderSlash)
EndIf
Else
If $iReturn <> 2 And StringRegExp($sName, $sInclude_File_Mask) And Not StringRegExp($sName, $sExclude_File_Mask) Then
__FLTAR_AddToList($asReturnList, $sRetPath & $sName)
EndIf
EndIf
EndIf
WEnd
If $iHide_Link Then
DllCall($hDLL, 'int', 'FindClose', 'ptr', $hSearch)
Else
FileClose($hSearch)
EndIf
WEnd
If $iHide_Link Then
DllClose($hDLL)
EndIf
If $iSort Then
Switch $iReturn
Case 2
If $asFolderMatchList[0] = 0 Then Return SetError(1, 9, "")
ReDim $asFolderMatchList[$asFolderMatchList[0] + 1]
$asReturnList = $asFolderMatchList
__ArrayDualPivotSort($asReturnList, 1, $asReturnList[0])
Case 1
If $asRootFileMatchList[0] = 0 And $asFileMatchList[0] = 0 Then Return SetError(1, 9, "")
If $iReturnPath = 0 Then
__FLTAR_AddFileLists($asReturnList, $asRootFileMatchList, $asFileMatchList)
__ArrayDualPivotSort($asReturnList, 1, $asReturnList[0])
Else
__FLTAR_AddFileLists($asReturnList, $asRootFileMatchList, $asFileMatchList, 1)
EndIf
Case 0
If $asRootFileMatchList[0] = 0 And $asFolderMatchList[0] = 0 Then Return SetError(1, 9, "")
If $iReturnPath = 0 Then
__FLTAR_AddFileLists($asReturnList, $asRootFileMatchList, $asFileMatchList)
$asReturnList[0] += $asFolderMatchList[0]
ReDim $asFolderMatchList[$asFolderMatchList[0] + 1]
_ArrayConcatenate($asReturnList, $asFolderMatchList, 1)
__ArrayDualPivotSort($asReturnList, 1, $asReturnList[0])
Else
Local $asReturnList[$asFileMatchList[0] + $asRootFileMatchList[0] + $asFolderMatchList[0] + 1]
$asReturnList[0] = $asFileMatchList[0] + $asRootFileMatchList[0] + $asFolderMatchList[0]
__ArrayDualPivotSort($asRootFileMatchList, 1, $asRootFileMatchList[0])
For $i = 1 To $asRootFileMatchList[0]
$asReturnList[$i] = $asRootFileMatchList[$i]
Next
Local $iNextInsertionIndex = $asRootFileMatchList[0] + 1
__ArrayDualPivotSort($asFolderMatchList, 1, $asFolderMatchList[0])
Local $sFolderToFind = ""
For $i = 1 To $asFolderMatchList[0]
$asReturnList[$iNextInsertionIndex] = $asFolderMatchList[$i]
$iNextInsertionIndex += 1
If $sFolderSlash Then
$sFolderToFind = $asFolderMatchList[$i]
Else
$sFolderToFind = $asFolderMatchList[$i] & "\"
EndIf
Local $iFileSectionEndIndex = 0, $iFileSectionStartIndex = 0
For $j = 1 To $asFolderFileSectionList[0][0]
If $sFolderToFind = $asFolderFileSectionList[$j][0] Then
$iFileSectionStartIndex = $asFolderFileSectionList[$j][1]
If $j = $asFolderFileSectionList[0][0] Then
$iFileSectionEndIndex = $asFileMatchList[0]
Else
$iFileSectionEndIndex = $asFolderFileSectionList[$j + 1][1] - 1
EndIf
If $iSort = 1 Then
__ArrayDualPivotSort($asFileMatchList, $iFileSectionStartIndex, $iFileSectionEndIndex)
EndIf
For $k = $iFileSectionStartIndex To $iFileSectionEndIndex
$asReturnList[$iNextInsertionIndex] = $asFileMatchList[$k]
$iNextInsertionIndex += 1
Next
ExitLoop
EndIf
Next
Next
EndIf
EndSwitch
Else
If $asReturnList[0] = 0 Then Return SetError(1, 9, "")
ReDim $asReturnList[$asReturnList[0] + 1]
EndIf
Return $asReturnList
EndFunc
Func __FLTAR_AddFileLists(ByRef $asTarget, $asSource_1, $asSource_2, $iSort = 0)
ReDim $asSource_1[$asSource_1[0] + 1]
If $iSort = 1 Then __ArrayDualPivotSort($asSource_1, 1, $asSource_1[0])
$asTarget = $asSource_1
$asTarget[0] += $asSource_2[0]
ReDim $asSource_2[$asSource_2[0] + 1]
If $iSort = 1 Then __ArrayDualPivotSort($asSource_2, 1, $asSource_2[0])
_ArrayConcatenate($asTarget, $asSource_2, 1)
EndFunc
Func __FLTAR_AddToList(ByRef $aList, $vValue_0, $vValue_1 = -1)
If $vValue_1 = -1 Then
$aList[0] += 1
If UBound($aList) <= $aList[0] Then ReDim $aList[UBound($aList) * 2]
$aList[$aList[0]] = $vValue_0
Else
$aList[0][0] += 1
If UBound($aList) <= $aList[0][0] Then ReDim $aList[UBound($aList) * 2][2]
$aList[$aList[0][0]][0] = $vValue_0
$aList[$aList[0][0]][1] = $vValue_1
EndIf
EndFunc
Func __FLTAR_ListToMask(ByRef $sMask, $sList)
If StringRegExp($sList, "\\|/|:|\<|\>|\|") Then Return 0
$sList = StringReplace(StringStripWS(StringRegExpReplace($sList, "\s*;\s*", ";"), BitOR($STR_STRIPLEADING, $STR_STRIPTRAILING)), ";", "|")
$sList = StringReplace(StringReplace(StringRegExpReplace($sList, "[][$^.{}()+\-]", "\\$0"), "?", "."), "*", ".*?")
$sMask = "(?i)^(" & $sList & ")\z"
Return 1
EndFunc
$fnAlreadyLoaded = @ScriptDir & "\loaded.txt"
$directorytowatch = FileReadLine("DirectoryToWatch.txt", 1)
If @error then Exit MsgBox(0,"Error!", "DirectoryToWatch.txt file is missing or empty!")
Global $aAllDumped[1000]
Global $handlefo = FileOpen($fnAlreadyLoaded, 1)
Global $allreadfromlog[1000]
Global $AllNotLoadedYet[1000]
MsgBox(0, "Automator", "Press OK when ready, close other open windows, and SPAM ESCAPE to FORCE QUIT!")
Sleep(500)
HotKeySet("{Esc}", "_quit")
Func _quit()
Exit
EndFunc
$numlines = _FileCountLines($fnAlreadyLoaded)
ConsoleWrite($numlines & " number of line in LOG file!" & @CRLF)
For $i = 1 To $numlines
$allreadfromlog[$i] = FileReadLine($fnAlreadyLoaded, $i)
Next
_ArrayDelete($allreadfromlog, 0)
For $i = UBound($allreadfromlog) - 1 To 0 Step -1
If $allreadfromlog[$i] = "" Then _ArrayDelete($allreadfromlog, $i)
Next
_ArraySort($allreadfromlog)
Local $allfoundfromdir = _FileListToArrayRec($directorytowatch, "*.exe", 1, 1)
_ArrayDelete($allfoundfromdir, 0)
For $i = 0 To UBound($allfoundfromdir) - 1
Local $found = _ArrayBinarySearch($allreadfromlog, $directorytowatch & "\" & $allfoundfromdir[$i])
If $found = -1 Then
ConsoleWrite("The program " & $directorytowatch & "\" & $allfoundfromdir[$i] & " has NOT been loaded yet!" & @CRLF)
$AllNotLoadedYet[$i] = $directorytowatch & "\" & $allfoundfromdir[$i]
Else
ConsoleWrite("The program " & $directorytowatch & "\" & $allfoundfromdir[$i] & $found & " has already been loaded yet!" & @CRLF)
EndIf
Next
For $i = UBound($AllNotLoadedYet) - 1 To 0 Step -1
If $AllNotLoadedYet[$i] = "" Then _ArrayDelete($AllNotLoadedYet, $i)
Next
If UBound($AllNotLoadedYet) = 0 Then Exit MsgBox(0, "Error", "The Directory you're watching seems to have everything loaded already, exiting!")
GoToSettings()
If Not WinExists("Settings") Then Exit MsgBox(0, "Error", "Expected Window not found!")
Global $ListOfAllLoadedProgram = findThemAllBoss()
Load()
Global $ListOfAllLoadedProgram = findThemAllBoss()
For $i = UBound($ListOfAllLoadedProgram) - 1 To 0 Step -1
If $ListOfAllLoadedProgram[$i] = "" Then _ArrayDelete($ListOfAllLoadedProgram, $i)
Next
For $i = 0 To UBound($ListOfAllLoadedProgram) - 1
Local $d = StringInStr($ListOfAllLoadedProgram[$i], "System Default")
If $d <> 0 Then
ConsoleWrite($ListOfAllLoadedProgram[$i] & "Zomgsystdef" & @CRLF)
If FileExists("SSO1.exe") Then
RunWait("SSO1.exe " & $ListOfAllLoadedProgram[$i])
If @error Then MsgBox(0, 0, @error)
ProcessWaitClose("SSO1.exe")
$ListOfAllLoadedProgram = findThemAllBoss()
Else
Exit MsgBox(0, 0, "SSO1.exe is missing or not in the same directory!")
EndIf
EndIf
Next
MsgBox(0, "Finished!", "YAY!")
Exit
Func GoToSettings()
WinMinimizeAll()
If FileExists("GoToSettings.exe") Then
RunWait("GoToSettings.exe")
ProcessWaitClose("GoToSettings.exe")
Else
Exit MsgBox(0, 0, "GoToSettings.exe is missing or not in the same directory!")
EndIf
EndFunc
Func Load()
If WinActive("Settings") Then
ClickBrowse()
WinWait("Open")
ControlSetText("Open", "", "Edit1", $AllNotLoadedYet[0])
FileWriteLine($handlefo, $AllNotLoadedYet[0])
Sleep(100)
Send("{Enter}")
Sleep(100)
For $i = 0 To UBound($AllNotLoadedYet) - 1
Sleep(300)
Send("{Enter}")
WinWait("Open")
ControlSetText("Open", "", "Edit1", $AllNotLoadedYet[$i])
Send("{Enter}")
If $i <> 0 Then FileWriteLine($handlefo, $AllNotLoadedYet[$i])
Next
FileClose($handlefo)
Else
MsgBox(0, "Error", "Expected settings window not found!")
EndIf
EndFunc
Func findThemAllBoss()
Local $oP5 = _UIA_getObjectByFindAll($UIA_oDesktop, "Title:=Settings;controltype:=UIA_WindowControlTypeId;class:=ApplicationFrameWindow", $treescope_children)
_UIA_Action($oP5, "setfocus")
Local $oP4 = _UIA_getObjectByFindAll($oP5, "Title:=Settings;controltype:=UIA_WindowControlTypeId;class:=Windows.UI.Core.CoreWindow", $treescope_children)
_UIA_Action($oP4, "setfocus")
Local $oP3 = _UIA_getObjectByFindAll($oP4, "Title:=;controltype:=UIA_GroupControlTypeId;class:=LandmarkTarget", $treescope_children)
_UIA_Action($oP3, "setfocus")
Local $oP2 = _UIA_getObjectByFindAll($oP3, "Title:=;controltype:=UIA_PaneControlTypeId;class:=ScrollViewer", $treescope_children)
_UIA_Action($oP2, "setfocus")
Local $oP1 = _UIA_getObjectByFindAll($oP2, "Title:=Graphics performance preference;controltype:=UIA_GroupControlTypeId;class:=GroupItem", $treescope_children)
_UIA_Action($oP1, "setfocus")
Local $oP0 = _UIA_getObjectByFindAll($oP1, "Title:=;controltype:=UIA_ListControlTypeId;class:=ListView", $treescope_children)
_UIA_Action($oP0, "setfocus")
Local $oElementStart = $oP0
Local $TreeScope = $treescope_children
Local $oCondition, $pTrueCondition
Local $pElements, $iLength
$UIA_oUIAutomation.CreateTrueCondition($pTrueCondition)
$oCondition = ObjCreateInterface($pTrueCondition, $sIID_IUIAutomationCondition, $dtagIUIAutomationCondition)
$oElementStart.FindAll($TreeScope, $oCondition, $pElements)
Local $oAutomationElementArray = ObjCreateInterface($pElements, $sIID_IUIAutomationElementArray, $dtagIUIAutomationElementArray)
$oAutomationElementArray.Length($iLength)
For $i = 0 To $iLength - 1
$oAutomationElementArray.GetElement($i, $UIA_pUIElement)
Local $oUIElement = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
Local $childrenofthewindow = _UIA_getPropertyValue($oUIElement, $UIA_NamePropertyId)
$aAllDumped[$i] = $childrenofthewindow
Next
Return($aAllDumped)
EndFunc
Func ClickBrowse()
Local $oP4 = _UIA_getObjectByFindAll($UIA_oDesktop, "Title:=Settings;controltype:=UIA_WindowControlTypeId;class:=ApplicationFrameWindow", $treescope_children)
_UIA_Action($oP4, "setfocus")
Local $oUIElement = _UIA_getObjectByFindAll($oP4, "title:=Browse;ControlType:=UIA_ButtonControlTypeId", $treescope_subtree)
_UIA_action($oUIElement, "click")
EndFunc
