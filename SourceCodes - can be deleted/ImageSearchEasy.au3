#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region includes
;~ Opt('MustDeclareVars', 1)
#include <GUIConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <string.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#EndRegion includes

;Read lines 20-66 to customize program to what you're looking for.

Const $bDebug = False
Global $filetofind, $CoordsArray

Const $cMatchLinePercentage = 0.70 ;Minimum matching, put on 1 if exact matching is needed on all lines , So for my purposes I've found that 80% generally yields a good match.
;~ Const $cMatchLinePercentage = 0.99 ;Minimum matching, put on 1 if exact matching is needed on all lines

;~ Constants for type of picture matching, Choose the match type that best fits your image. Change this value on like #38.
Const $c24RGBFullMatch = 1 ;Load as 24 bits and full match
Const $c24RGBPartialMatch = 2 ;Load as 24 bits and partial match
Const $c16RGBFullMatch = 3 ;Load as 16 bits and full match
Const $c16RGBPartialMatch = 4 ;Load as 16 bits and partial match

Global Const $Bitmap1Filename = @ScriptDir & "\FULLSCREEN.BMP"
Local $calcHWND, $begin, $pos, $aWinPos, $aWinCSize, $start
Local $pBitmap, $BitmapData, $pixelFormat

Func SearchForClick($filetofind, $clickitt)
	If FileExists($filetofind) Then

		_GDIPlus_Startup()
		$begin = TimerInit()
		_ScreenCapture_Capture($Bitmap1Filename, 0, 0, -1, -1, False)
		ConsoleWrite("Saving full screen took " & TimerDiff($begin) & " milliseconds " & @LF)
		FindTester($Bitmap1Filename, $filetofind, $c24RGBPartialMatch, $clickitt) ; Change match type here.
		FileDelete($Bitmap1Filename)
		_GDIPlus_Shutdown()
;~ 		_ArrayDisplay($CoordsArray)
;~ 		Exit
		Return ($CoordsArray[3] & ";" & $CoordsArray[4])
	Else
		Exit MsgBox(0, "ERROR", "Image Missing!")
	EndIf
EndFunc   ;==>SearchForClick


Func filegetname($f)
	Local $i
	$i = StringInStr($f, "\", False, -1)
	If $i > 0 Then
		Return StringMid($f, $i + 1)
	Else
		Return $f
	EndIf
EndFunc   ;==>filegetname

Func FindTester($BMP1, $BMP2, $Bool, $clickit)
	Local $tResult
	$start = TimerInit()
	$tResult = findBMP($BMP1, $BMP2, $Bool)
	ConsoleWrite($tResult & " " & filegetname($BMP2) & " in " & filegetname($BMP1) & " ** matchtype " & $Bool & " time elapsed: " & TimerDiff($start) & "  milliseconds" & @LF)
	$CoordsArray = StringSplit($tResult, ";")
	If $CoordsArray[1] = "False" Then ; If Imagesearch fails, error out.
		MsgBox(0, 0, "Window Not Found")
		Exit
	EndIf
	If $clickit = 1 Then MouseClick("Primary", $CoordsArray[3] + $CoordsArray[5]/2, $CoordsArray[4]+ $CoordsArray[6]/2) ; Change here for mousemove / Mouse click / whatever action you're looking for. You can also use a return value to use coordinates outside of this file.

EndFunc   ;==>FindTester


#Region actual functions
;===============================================================================
; Function Name:    findBMP
; Description:    Finds a bitmap (.BMP) in another BMP file (other formats PNG and TIFF work also other formats less usefull GIF, JPEG, Exif, WMF, and EMF should work)
; Syntax:          findBMP($BMP1, $BMP2, $MatchType=TRUE)
;
; Parameter(s):  $BMP1           = Filename of bitmap to search in
;                  $BMP2             = Filename of bitmap to search for
;                  $MatchType       = c24RGBFullMatch, c24RGBPartialMatch, c16RGBFullMatch, c16RGBPartialMatch
;
; Return Value(s):  On Success:   = Returns Array List
;                  On Failure:   = @error 1 (Control was found but there was an error with the DLLCall)
;
; Author(s):        JunkEW
;
; Note(s):
;               * Its never an exact match even with TRUE as last few bits are disposed in algorithm and lines below
;                are not checked under assumption that those are 99.99% of the time correct
;              * locking bits overview http://www.bobpowell.net/lockingbits.htm
; ToDo:
;               * Transparency (when search letters on a different background) http://www.winprog.org/tutorial/transparency.html
;               * Match quicker by doing a bitblt with srcinvert when first line is found (instead of checking line by line)
;               * $BMP1 and $BMP2 to be HBITMAP handle as input instead of filenames (will make searching within partial screen easier)
; Example(s):
;
;===============================================================================

Func findBMP($BMP1, $BMP2, $MatchType = $c24RGBFullMatch)
	Dim $fLine[1] ;Line number of found line(s), redimmed when second picture size is known
	Dim $BMP1Data = "", $BMP1Width = 0, $BMP1Height = 0, $BMP1LineWidth = 0 ;
	Dim $BMP2Data = "", $BMP2Width = 0, $BMP2Height = 0, $BMP2LineWidth = 0
	Dim $foundAt = "", $matchPossible = False, $matchedLines = 0, $foundAtLeft = -1, $foundAtTop = -1
	Dim $bestMatchLine = -1, $HighestMatchingLines = -1 ; For knowing when no match is found where best area is
	Dim $iPos = 1 ;
	Dim $imgBytes, $avData ;

	Local $iFuzzyDist, $searchFor, $iAbove, $bMatchPossible, $aboveLine
	Local $j, $imgBits
	Local $tDebug

	If ($MatchType = $c24RGBFullMatch) Or ($MatchType = $c24RGBPartialMatch) Then
		$imgBytes = 3
	Else
		$imgBytes = 2
	EndIf

	; Load the bitmap to search in
	GetImage($BMP1, $BMP1Data, $BMP1Width, $BMP1Height, $BMP1LineWidth, $imgBytes)
	$BMP1Data = BinaryToString($BMP1Data)

	; Load the bitmap to find
	GetImage($BMP2, $BMP2Data, $BMP2Width, $BMP2Height, $BMP2LineWidth, $imgBytes)
	;Make it strings to be able to use string functions for searching
	$BMP2Data = BinaryToString($BMP2Data)

	If $bDebug = True Then
;~ START debugging
		;Get some debugging information
		FileDelete(@ScriptDir & "\BMP1DATA.TXT")
		FileDelete(@ScriptDir & "\BMP2DATA.TXT")
		FileDelete(@ScriptDir & "\COMPAREDLINES.TXT")

		ConsoleWrite($BMP1Width & @CRLF)
		ConsoleWrite($BMP1Height & @CRLF)
		ConsoleWrite($BMP1LineWidth & @CRLF)
		ConsoleWrite(StringLen($BMP1Data) & @CRLF)

		ConsoleWrite(".{" & $BMP1LineWidth & "}" & @CRLF)

		ConsoleWrite(".{" & $BMP2LineWidth & "}" & @CRLF)
		$tDebug = StringRegExpReplace(_StringToHex($BMP1Data), "(.{" & $BMP1LineWidth * 2 & "})", "$1" & @CRLF)
		ConsoleWrite(@error & @extended & @CRLF)
		FileWrite(@ScriptDir & "\BMP1DATA.TXT", $tDebug)

		$tDebug = StringRegExpReplace(_StringToHex($BMP2Data), "(.{" & $BMP2LineWidth * 2 & "})", "$1" & @CRLF)
		ConsoleWrite(@error & @extended & @CRLF)
		FileWrite(@ScriptDir & "\BMP2DATA.TXT", $tDebug)
;~ END debugging
	EndIf

	;For reference of line where in BMP2FindIn a line of BMP2Find was found
	If $BMP2Height = 0 Then
		SetError(1, 0, 0)
		Return False
	EndIf

	ReDim $fLine[$BMP2Height]

	;If exact match check every 1 line else do it more fuzzy (as most likely other lines are unique)
	If ($MatchType = $c24RGBFullMatch) Or ($MatchType = $c16RGBFullMatch) Then
		$iFuzzyDist = 1
	Else
		;Check fuzzy every 10% of lines
		$iFuzzyDist = Ceiling(($BMP2Height * 0.1))
	EndIf

	$begin = TimerInit()
	;Look for each line of the bitmap if it exists in the bitmap to find in
;~ Split bitmap to search in lines
;~  $avData=stringregexp($BMP2Data, ".{1," & $BMP2lineWidth & "}+", 3)
	Dim $searchForRegEx
	$searchForRegEx = StringMid($BMP2Data, 1 + (0 * $BMP2LineWidth), ($BMP2LineWidth - $imgBytes))
	$searchForRegEx = $searchForRegEx & ".*" & StringMid($BMP2Data, 1 + ($BMP2Height * $BMP2LineWidth), ($BMP2LineWidth - $imgBytes))
	Local $aArray = StringRegExp($BMP1Data, $searchForRegEx, 3)
	If @error = 0 Then
		ConsoleWrite("Regex found " & TimerDiff($begin) & " ms " & @CRLF)
;~ For $i = 0 To UBound($aArray) - 1
;~     consolewrite("RegExp Test with Option 3 - " & $i & $aArray[$i])
;~ Next
	EndIf


	For $i = 0 To $BMP2Height - 1
		;Minus imgbytes as last bits are padded with unpredictable bytes (24 bits image assumption) or 2 when 16 bits
		$searchFor = StringMid($BMP2Data, 1 + ($i * $BMP2LineWidth), ($BMP2LineWidth - $imgBytes))
;~      $searchfor=stringleft($avData[$i],$BMP2lineWidth - $imgBytes)

		$iPos = StringInStr($BMP1Data, $searchFor, 2, 1, $iPos)
		;       $iPos = StringInStr($BMP1Data, $searchFor)


		;Look for all lines above if there is also a match
		;Not doing it for the lines below as speed is more important and risk of mismatch on lines below is small
		$iAbove = 1
		If $iPos > 0 Then
			$bMatchPossible = True
			$matchedLines = 1 ;As first found line is matched we start counting
			;Location of the match
			$foundAtTop = Int($iPos / $BMP1LineWidth) - $i
			$foundAtLeft = Int(Mod($iPos, $BMP1LineWidth) / $imgBytes)
		Else
;~          No 1st line found so far nothing to start matching
			$bMatchPossible = False
			ExitLoop
		EndIf

		While (($i + $iAbove) <= ($BMP2Height - 1)) And ($bMatchPossible = True)
			$searchFor = StringMid($BMP2Data, 1 + (($i + $iAbove) * $BMP2LineWidth), ($BMP2LineWidth - $imgBytes))
;~          $searchfor = stringleft($avData[$i+$iAbove],$BMP2lineWidth - $imgBytes)
			$aboveLine = StringMid($BMP1Data, $iPos + ($iAbove * $BMP1LineWidth), ($BMP2LineWidth - $imgBytes))

			If $bDebug = True Then
;~ START debugging
				$tDebug = StringRegExpReplace(_StringToHex($searchFor), "(.{8})", "$1_")
				FileWrite(@ScriptDir & "\COMPAREDLINES.TXT", $tDebug & @CRLF)
				$tDebug = StringRegExpReplace(_StringToHex($aboveLine), "(.{8})", "$1_")
				FileWrite(@ScriptDir & "\COMPAREDLINES.TXT", $tDebug & @CRLF)
				If $aboveLine <> $searchFor Then
					FileWrite(@ScriptDir & "\COMPAREDLINES.TXT", "** MISMATCH ** of line " & (1 + $iAbove) & " in 2nd bitmap at line " & ($foundAtTop + $i) & @CRLF)
				EndIf
;~ END debugging
			EndIf

			If comparePicLine($aboveLine, $searchFor) = False Then
				$bMatchPossible = False
				;To remember the area with the best match
				If $matchedLines >= $HighestMatchingLines Then
					$HighestMatchingLines = $matchedLines

					;Best guess of location
;~                  $foundAtTop = $fline[$i] + $i - $BMP2Height
					$foundAtTop = Int($iPos / $BMP1LineWidth) ;+ $i - $BMP2Height
					$bestMatchLine = Int($iPos / $BMP1LineWidth)
				EndIf
				ExitLoop
			EndIf
			$matchedLines = $matchedLines + 1
			$iAbove = $iAbove + $iFuzzyDist
		WEnd

		;If bMatchPossible is still true most likely we have found the bitmap
		If $bMatchPossible = True Then
;~          ConsoleWrite("Could match top: " & $foundAtTop & " left: " & $foundAtLeft & " in " & TimerDiff($begin) / 1000 & "  seconds" & @LF)
			;           MouseMove($foundatleft,$foundatTop)
			ExitLoop
		Else
;~          consolewrite("i not matched " & $ipos & " " & $matchedlines & @crlf )
		EndIf

	Next

	;For some debugging of time
	;   if $bMatchPossible = True Then
	;       ConsoleWrite("Searching took " & TimerDiff($begin) / 1000 & "  seconds " & @LF)
	;   Else
	;       ConsoleWrite("NOT FOUND Searching took " & TimerDiff($begin) / 1000 & "  seconds" & @LF)
	;   endif

	;Return an error if not found else return an array with all information
	If $bMatchPossible = False Then
		SetError(1, 0, 0)
	EndIf
	;   return stringsplit($bMatchPossible & ";" & $matchedLines & ";" & $foundAtLeft & ";" & $foundAtTop & ";" & $bmp2width & ";" & $BMP2Height & ";" & $HighestMatchingLines & ";" & $bestMatchLine,";")
	Return $bMatchPossible & ";" & $matchedLines & ";" & $foundAtLeft & ";" & $foundAtTop & ";" & $BMP2Width & ";" & $BMP2Height & ";" & $HighestMatchingLines & ";" & $bestMatchLine
EndFunc   ;==>findBMP

Func comparePicLine($s1, $s2)
	Local $sLen, $iMatched
	If $s1 = $s2 Then
		Return True
	Else
		$iMatched = 0
		$sLen = StringLen($s1)
		For $tJ = 1 To $sLen
			If StringMid($s1, $tJ, 1) = StringMid($s2, $tJ, 1) Then
				$iMatched = $iMatched + 1
			Else
				If $bDebug = True Then
;~ START debugging
					FileWrite(@ScriptDir & "\COMPAREDLINES.TXT", "Debug mismatch pixel " & $tJ & "=" & Int($tJ / 4) & @CRLF)
				EndIf
			EndIf
		Next
		If ($iMatched / $sLen) > $cMatchLinePercentage Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>comparePicLine

Func GetImage($BMPFile, ByRef $BMPDataStart, ByRef $Width, ByRef $Height, ByRef $Stride, $imgBytes = 3)
	Local $Scan0, $pixelData, $hbScreen, $pBitmap, $pBitmapCap, $handle

	; Load the bitmap to search in
	If $BMPFile = "SCREEN" Then
		$hbScreen = _ScreenCapture_Capture("", 0, 0, -1, -1, False)
		$pBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hbScreen) ; returns memory bitmap
	Else
		;try to get a handle
		$handle = WinGetHandle($BMPFile)
		If @error Then
			;Assume its an unknown handle so correct filename should be given
			$pBitmap = _GDIPlus_BitmapCreateFromFile($BMPFile)
		Else
			$hbScreen = _ScreenCapture_CaptureWnd("", $handle, 0, 0, -1, -1, False)
			$pBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hbScreen) ; returns memory bitmap
		EndIf
	EndIf

	;Get $tagGDIPBITMAPDATA structure
;~  ConsoleWrite("Bitmap Width:    " & _GDIPlus_ImageGetWidth($pBitmap) & @CRLF )
;~  ConsoleWrite("Bitmap Height:      " & _GDIPlus_ImageGetHeight($pBitmap) & @CRLF)

;~  24 bits (3 bytes) or 16 bits (2 bytes) comparison
	If ($imgBytes = 2) Then
		$BitmapData = _GDIPlus_BitmapLockBits($pBitmap, 0, 0, _GDIPlus_ImageGetWidth($pBitmap), _GDIPlus_ImageGetHeight($pBitmap), $GDIP_ILMREAD, $GDIP_PXF16RGB555)
;~      $BitmapData= _GDIPlus_BitmapLockBits($pBitmap, 0, 0, _GDIPlus_ImageGetWidth($pBitmap), _GDIPlus_ImageGetHeight($pBitmap), $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	Else
		$BitmapData = _GDIPlus_BitmapLockBits($pBitmap, 0, 0, _GDIPlus_ImageGetWidth($pBitmap), _GDIPlus_ImageGetHeight($pBitmap), $GDIP_ILMREAD, $GDIP_PXF24RGB)
;~      $BitmapData= _GDIPlus_BitmapLockBits($pBitmap, 0, 0, _GDIPlus_ImageGetWidth($pBitmap), _GDIPlus_ImageGetHeight($pBitmap), $GDIP_ILMREAD, $GDIP_PXF32ARGB)
	EndIf

	If @error Then MsgBox(0, "", "Error locking region " & @error)

	$Stride = DllStructGetData($BitmapData, "Stride") ;Stride - Offset, in bytes, between consecutive scan lines of the bitmap. If the stride is positive, the bitmap is top-down. If the stride is negative, the bitmap is bottom-up.
	$Width = DllStructGetData($BitmapData, "Width") ;Image width - Number of pixels in one scan line of the bitmap.
	$Height = DllStructGetData($BitmapData, "Height") ;Image height - Number of scan lines in the bitmap.
	$pixelFormat = DllStructGetData($BitmapData, "PixelFormat") ;Pixel format - Integer that specifies the pixel format of the bitmap
	$Scan0 = DllStructGetData($BitmapData, "Scan0") ;Scan0 - Pointer to the first (index 0) scan line of the bitmap.

	$pixelData = DllStructCreate("ubyte lData[" & (Abs($Stride) * $Height - 1) & "]", $Scan0)
	$BMPDataStart = $BMPDataStart & DllStructGetData($pixelData, "lData")

	_GDIPlus_BitmapUnlockBits($pBitmap, $BitmapData)
	_GDIPlus_ImageDispose($pBitmap)
	_WinAPI_DeleteObject($pBitmap)

EndFunc   ;==>GetImage
; Draw rectangle on screen.
;~ Func _UIA_DrawRect($tLeft, $tRight, $tTop, $tBottom, $color = 0xFF, $PenWidth = 4)
;~ 	Local $hDC, $hPen, $obj_orig, $x1, $x2, $y1, $y2
;~ 	$x1 = $tLeft
;~ 	$x2 = $tRight
;~ 	$y1 = $tTop
;~ 	$y2 = $tBottom
;~ 	$hDC = _WinAPI_GetWindowDC(0) ; DC of entire screen (desktop)
;~ 	$hPen = _WinAPI_CreatePen($PS_SOLID, $PenWidth, $color)
;~ 	$obj_orig = _WinAPI_SelectObject($hDC, $hPen)

;~ 	_WinAPI_DrawLine($hDC, $x1, $y1, $x2, $y1) ; horizontal to right
;~ 	_WinAPI_DrawLine($hDC, $x2, $y1, $x2, $y2) ; vertical down on right
;~ 	_WinAPI_DrawLine($hDC, $x2, $y2, $x1, $y2) ; horizontal to left right
;~ 	_WinAPI_DrawLine($hDC, $x1, $y2, $x1, $y1) ; vertical up on left

;~ 	; clear resources
;~ 	_WinAPI_SelectObject($hDC, $obj_orig)
;~ 	_WinAPI_DeleteObject($hPen)
;~ 	_WinAPI_ReleaseDC(0, $hDC)
;~ EndFunc   ;==>_UIA_DrawRect
;~ #EndRegion actual functions
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.5
	Author:         myName

	Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
