#include <ImageSearchEasy.au3>
#include "UIA\UIAWrappers.au3"
#include <File.au3>
#include <Array.au3>

$DisplaySettings = @ScriptDir & "\images\displaysettings.bmp"
$GraphicsSettings = @ScriptDir & "\images\graphicssettings.bmp"
$Browse = @ScriptDir & "\images\browse.bmp"
$fnAlreadyLoaded = @ScriptDir & "\loaded.txt"
$directorytowatch = FileReadLine("DirectoryToWatch.txt", 1)

;~ Global $arrayLoaded[1000]
Global $Loaded
Global $aAllDumped[1000]
Global $handlefo = FileOpen($fnAlreadyLoaded, 1)
Global $allreadfromlog[1000]
Global $AllNotLoadedYet[1000]

;;Start Coding

$numlines = _FileCountLines($fnAlreadyLoaded)
ConsoleWrite($numlines & " number of line in LOG file!" & @CRLF)
For $i = 1 To $numlines
	$allreadfromlog[$i] = FileReadLine($fnAlreadyLoaded, $i)
Next
_ArrayDelete($allreadfromlog, 0)
For $i = UBound($allreadfromlog) - 1 To 0 Step -1 ; Delete Blanks In Array
	If $allreadfromlog[$i] = "" Then _ArrayDelete($allreadfromlog, $i)
Next

_ArraySort($allreadfromlog)
;~ _ArrayDisplay($allreadfromlog)
Local $allfoundfromdir = _FileListToArrayRec($directorytowatch, "*.exe", 1, 1)
_ArrayDelete($allfoundfromdir, 0) ; Delete Count
For $i = 0 To UBound($allfoundfromdir) - 1

	Local $found = _ArrayBinarySearch($allreadfromlog, $directorytowatch & "\" & $allfoundfromdir[$i])
	If $found = -1 Then
		ConsoleWrite("The program " & $directorytowatch & "\" & $allfoundfromdir[$i] & " has NOT been loaded yet!" & @CRLF)
		$AllNotLoadedYet[$i] = $directorytowatch & "\" & $allfoundfromdir[$i]
	Else
		ConsoleWrite("The program " & $directorytowatch & "\" & $allfoundfromdir[$i] & $found & " has already been loaded yet!" & @CRLF)
	EndIf
Next


For $i = UBound($AllNotLoadedYet) - 1 To 0 Step -1 ; Delete Blanks In Array
	If $AllNotLoadedYet[$i] = "" Then _ArrayDelete($AllNotLoadedYet, $i)
Next
If UBound($AllNotLoadedYet) = 0 Then Exit MsgBox(0,"Error", "The Directory you're watching seems to have everything loaded already, exiting!")


;;;; Found all that NEED to be LOADED

GoToSettings()
If Not WinExists("Settings") Then Exit MsgBox(0, "Error", "Expected Window not found!")
Global $ListOfAllLoadedProgram = findThemAllBoss()
Load()

Global $ListOfAllLoadedProgram = findThemAllBoss()

For $i = UBound($ListOfAllLoadedProgram) - 1 To 0 Step -1 ; Delete Blanks In Array
	If $ListOfAllLoadedProgram[$i] = "" Then _ArrayDelete($ListOfAllLoadedProgram, $i)
Next

For $i = 0 To UBound($ListOfAllLoadedProgram) - 1
	Local $d = StringInStr($ListOfAllLoadedProgram[$i], "System Default")
	If $d <> 0 Then
		ConsoleWrite($ListOfAllLoadedProgram[$i] & "Zomgsystdef" & @CRLF)
		RunWait("SSO1.exe " & $ListOfAllLoadedProgram[$i])
		If @error Then MsgBox(0, 0, @error)
		ProcessWaitClose("SSO1.exe")
		$ListOfAllLoadedProgram = findThemAllBoss()
	EndIf
Next


Func GoToSettings()
	MouseClick("Right", 1, 1, 1, 0) ; Right Click On Desktop
	Sleep(1000)
	Local $coordinates = SearchForClick($DisplaySettings, 1) ;Click On Desktop
	ConsoleWrite(@CRLF & $coordinates & @CRLF)
	WinWait("Settings")
	Sleep(1000)
	Local $coordinates = SearchForClick($GraphicsSettings, 1) ;Click On Graphics Settings
	ConsoleWrite(@CRLF & $coordinates & @CRLF)
	Sleep(1000)
EndFunc   ;==>GoToSettings

Func Load()
	If WinActive("Settings") Then
		Local $coordinates = SearchForClick($Browse, 1) ;Click On Browse Button
		ConsoleWrite(@CRLF & $coordinates & @CRLF)
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

EndFunc   ;==>Load

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
	For $i = 0 To $iLength - 1 ; it's zero based
		$oAutomationElementArray.GetElement($i, $UIA_pUIElement)
		Local $oUIElement = ObjCreateInterface($UIA_pUIElement, $sIID_IUIAutomationElement, $dtagIUIAutomationElement)
		Local $childrenofthewindow = _UIA_getPropertyValue($oUIElement, $UIA_NamePropertyId)
;~ 		ConsoleWrite("Found #" & $i & " " & $childrenofthewindow & @CRLF)
		$aAllDumped[$i] = $childrenofthewindow
	Next
	Return ($aAllDumped)
EndFunc   ;==>findThemAllBoss

;~ #ce
