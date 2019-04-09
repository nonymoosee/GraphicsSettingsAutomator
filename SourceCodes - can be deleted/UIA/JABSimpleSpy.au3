#AutoIt3Wrapper_UseX64=Y

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <constants.au3>
#include <WinAPI.au3>
#include <WinAPIEx.au3>
#include <debug.au3>
#include <memory.au3>
#include <Misc.au3>

HotKeySet("{ESC}", "Close") ; Set ESC as a hotkey to exit the script.
HotKeySet("^w", "GetElementInfo") ; Set Hotkey Ctrl+W to get some basic information in the GUI

Global $hAccessBridgeDll  ;~ reference to the accessbridge dll

Const $tagAccessBridgeVersionInfo="WCHAR VMversion[256];WCHAR bridgeJavaClassVersion[256];WCHAR bridgeJavaDLLVersion[256];WCHAR bridgeWinDLLVersion[256]"

const $c_JOBJECT64="UINT64"   ;~ JOBJECT64
const $cP_JOBJECT64="UINT64*" ;~ POINTER(JOBJECT64)

Local $tAccessBridgeVersionInfo=DllStructCreate($tagAccessBridgeVersionInfo)

const $tagAccessibleContextInfo="WCHAR name[1024];WCHAR description[1024];WCHAR role[256];WCHAR role_en_US[256];WCHAR states[256];WCHAR states_en_US[256];INT indexInParent;INT childrenCount;INT x;INT y;INT width;INT height;BOOL accessibleComponent;BOOL accessibleAction;BOOL accessibleSelection;BOOL accessibleText;BOOL accessibleInterfaces"
Local $tAccessibleContextInfo=DllStructCreate($tagAccessibleContextInfo)
;~ struct AccessibleTextInfo {
;~  jint charCount;       // # of characters in this text object
;~  jint caretIndex;      // index of caret
;~  jint indexAtPoint;    // index at the passsed in point
;~ };
const $tagAccessibleTextInfo="INT charCount;INT caretIndex;INT indexAtPoint"

const $AutoSpy=0 ;2000 ; SPY about every 2000 milliseconds automatically, 0 is turn of use only ctrl+w

;~ global $oldUIElement ; To keep track of latest referenced element
global $frmSimpleSpy, $edtCtrlInfo , $lblCapture, $lblEscape, $lblRecord, $edtCtrlRecord, $msg
global $i              ; Just a simple counter to measure time expired in main loop

;~ Determine java location
Local $sJavaVersion = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion")
Local $sJavaHome =RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" & $sJavaVersion , "JavaHome")
consolewrite($sJavaHome & @CRLF)

shellexecute($sJavaHome & "\bin\javacpl.exe")
sleep(3000)

_JABInit()
;~ _Example1_IterateJavaWindows()

#Region ### START Koda GUI section ### Form=
$frmSimpleSpy = GUICreate("Simple UIA Spy", 801, 601, 181, 4)
$edtCtrlInfo = GUICtrlCreateEdit("", 18, 18, 512, 580)
GUICtrlSetData(-1, "")
$lblCapture = GUICtrlCreateLabel("Ctrl+W to capture information", 544, 10, 528, 17)
$lblEscape = GUICtrlCreateLabel("Escape to exit", 544, 53, 528, 17)
$edtCtrlRecord = GUICtrlCreateEdit("", 544, 72, 233, 520)
GUICtrlSetData(-1, "//TO DO edtCtrlRecord")
;~ $lblRecord = GUICtrlCreateLabel("Ctrl + R to record code", 544, 32, 527, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

;~ _UIA_Init()

;~ loadCodeTemplates() ; //TODO: To use templates per class/controltype

; Run the GUI until the dialog is closed
While true
	$msg = GUIGetMsg()
	sleep(100)
	;~ if _ispressed(01) Then
	;~ getelementinfo()
	;~ endif

	;Just to show anyway the information about every n ms so ctrl+w is not interfering / removing window as unwanted side effects
	$i=$i+100
	if ($autoSpy<>0) and ($i>= $autoSpy) then
		$i=0
		getelementinfo()
	EndIf

	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd
_JABShutDown()

Func GetElementInfo()
	local $acParent=0
	local $vmID=0
	Local $tStruct = DllStructCreate($tagPOINT)
	local $description

	$description=""

	$xMouse=MouseGetPos(0)
 	$yMouse=MouseGetPos(1)
 	DllStructSetData($tStruct, "x", $xMouse)
	DllStructSetData($tStruct, "y", $yMouse)

	$tGetMousePos = _WinAPI_GetMousePos()
	$hWnd = _WinAPI_WindowFromPoint($tGetMousePos)

	$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "isJavaWindow", "hwnd", $hWnd)
	if @error=0 Then
		if $result[0]=1 Then
			$description = "Mouse position is retrieved " & $xMouse & "-" & $yMouse & @CRLF
;~ 			GUICtrlSetData($edtCtrlInfo, "Mouse position is retrieved " & $xMouse & "-" & $yMouse & @CRLF)

			$description = $description & ( "  JAVA window found <" & "> Java Window Title=" &  " Handle=" & $hWnd & @TAB & " res: " &  $result[0] & @CRLF)

			$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "getAccessibleContextFromHWND", "hwnd", $hWnd, "long*", $vmID, "UINT64*", $acParent)
			if @error=0 Then
				$description = $description & ("Result getAccessibleContextFromHWND is <" & $result & "> ubound: " & ubound($result) & @crlf)
				$vmID=$result[2]
				$acParent=$result[3]
				$description = $description & ("  We have a VMid " & $vmID & " ac " & $acParent & @CRLF)

				$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getVersionInfo", "long", $vmId, "struct*", DllStructGetPtr($tAccessBridgeVersionInfo))

				if @error=0 Then
						$s1=dllstructgetdata($tAccessBridgeVersionInfo, "VMVersion")
						$s2=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeJavaClassVersion")
						$s3=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeJavaDLLVersion")
						$s4=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeWinDLLVersion")

						$description = $description & ("Call version info: PASSED VMID found : " & $vmID & @CRLF)
						$description = $description & ("  VMVersion: <" & $s1 & ">" & @CRLF)
 						$description = $description & ("  bridgeJavaClassVersion: <" & $s2 & ">" & @CRLF)
 						$description = $description & ("  bridgeJavaDLLVersion: <" & $s3 & ">" & @CRLF)
						$description = $description & ("  bridgeWinDLLVersion: <" & $s4 & ">" & @CRLF)
					Else
						$description = $description & ("getVersionInfo error:" & @error  & @CRLF)
					EndIf

					local $childAT_AC
					__getAccessibleContextAt($vmid,$acparent,$xmouse, $yMouse,$childAT_AC)
						$description = $description & (" *** getAccessibleContextAT result is <" & $childAT_AC & "> " & @crlf)

					if @error=0 Then
						$description = $description & (" *** getAccessibleContextAT result is <" & $childAT_AC & "> " & @crlf)
						$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $childAT_AC, "struct*", $tAccessibleContextInfo)
						$AccessibleContextInfo=$result[3]

						$description = $description & (getDescription($AccessibleContextInfo))

						$description = $description & ("End of getAcceccibleContextAt info" & @CRLF)

					endif
				EndIf
		EndIf

	EndIf
	GUICtrlSetData($edtCtrlInfo, $description & @CRLF)


EndFunc

Func Close()
_JABShutDown()
Exit
EndFunc   ;==>Close

Func _JABInit()
	;~ Make sure Java Access Bridge is turned on
	runwait($sJavaHome & "\bin\jabswitch /enable","",@SW_MAXIMIZE)

	;~ TODO: Check if it works with both dll's
	consolewrite("We are using " & @OSArch & " at cpu " & @CPUArch & " Autoit 64 bit version "& @AutoItX64 & @CRLF)

	if @AutoItX64 = 1 then
		$sAccessBridgeDLL="WindowsAccessBridge-64.dll"
	Else
		$sAccessBridgeDLL="WindowsAccessBridge-32.dll"
	EndIf

	;~ Open the Dll for accessibility
    $hAccessBridgeDll=DLLOPEN($sJavaHome & "\bin\" & $sAccessBridgeDLL)
	If $hAccessBridgeDll=true Then
		consolewrite("  Windows accessbridge 32 opened " & $hAccessBridgeDll & @CRLF)
	Else
		consolewrite("  DLL not found try to change to WindowsAccessBridge-64.dll if you use 64 bits autoit and windows")
	endIf

	;~ TODO: Handle messages received from initialize
	$result = __Windows_run()
	consolewrite($result & " " & @error & " initializeAccessBridge is finished")

	sleep(250)

	consolewrite("Windows_run passed :" & $result & @CRLF)
EndFunc

;~ 	_fixBridgeFunc(None,'Windows_run')
func __Windows_run()
	$result =dllcall($hAccessBridgeDll,"NONE", "Windows_run")
	If @error Then Return SetError(1, 0, 0)
	Return $result[0]
EndFunc

;~ 	_fixBridgeFunc(None,'setFocusGainedFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyStateChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyCaretChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyActiveDescendentChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'releaseJavaObject',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getVersionInfo',POINTER(AccessBridgeVersionInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'isJavaWindow',HWND)
;~ 	_fixBridgeFunc(BOOL,'isSameObject',c_long,JOBJECT64,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextFromHWND',HWND,POINTER(c_long),POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(HWND,'getHWNDFromAccessibleContext',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextAt',c_long,JOBJECT64,jint,jint,POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextWithFocus',HWND,POINTER(c_long),POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextInfo',c_long,JOBJECT64,POINTER(AccessibleContextInfo),errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleChildFromContext',c_long,JOBJECT64,jint,errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleParentFromContext',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleRelationSet',c_long,JOBJECT64,POINTER(AccessibleRelationSetInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextInfo',c_long,JOBJECT64,POINTER(AccessibleTextInfo),jint,jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextItems',c_long,JOBJECT64,POINTER(AccessibleTextItemsInfo),jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextSelectionInfo',c_long,JOBJECT64,POINTER(AccessibleTextSelectionInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextAttributes',c_long,JOBJECT64,jint,POINTER(AccessibleTextAttributesInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextLineBounds',c_long,JOBJECT64,jint,POINTER(jint),POINTER(jint),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextRange',c_long,JOBJECT64,jint,jint,POINTER(c_wchar),c_short,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getCurrentAccessibleValueFromContext',c_long,JOBJECT64,POINTER(c_wchar),c_short,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'selectTextRange',c_long,JOBJECT64,c_int,c_int,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getTextAttributesInRange',c_long,JOBJECT64,c_int,c_int,POINTER(AccessibleTextAttributesInfo),POINTER(c_short),errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getTopLevelObject',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(c_int,'getObjectDepth',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(JOBJECT64,'getActiveDescendent',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'requestFocus',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'setCaretPosition',c_long,JOBJECT64,c_int,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getCaretLocation',c_long,JOBJECT64,POINTER(AccessibleTextRectInfo),jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleActions',c_long,JOBJECT64,POINTER(AccessibleActions),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'doAccessibleActions',c_long,JOBJECT64,POINTER(AccessibleActionsToDo),POINTER(jint),errcheck=True)




;~ By inspecting the WindowsAccessBridge-32.dll it reveals some information about the hidden dialogs
;~   So it seems the hidden dialog is shown after you call windows_run() no clue if interaction is needed
;~
;~ Somehow it sends a message unclear if this is to the JVM to respond to
;~   push	SSZ6E73E320_AccessBridge_FromJava_Hello
;~   push	SSZ6E73E300_AccessBridge_FromWindows_Hello
;~   db	'AccessBridge-FromWindows-Hello',0
;~   db	'AccessBridge-FromJava-Hello',0

;~ JABHANDLER.PY is a usefull source to study on internet

;~ *******
;~ Every AccessibleContext IntPtr must be replaced by long, including but not limited to getAccessibleContextFromHWND, getAccessibleParentFromContext, getAccessibleChildFromContext, getAccessibleTextInf
;~ JOBJECT64 is defined as jlong on 64-bit systems and jobject on legacy versions of Java Access Bridge. For definitions, see the section ACCESSBRIDGE_ARCH_LEGACY in the AccessBridgePackages.h header file.
;~ #ifdef ACCESSBRIDGE_ARCH_LEGACY
;~ 		typedef jobject JOBJECT64;
;~ 		typedef HWND ABHWND64;
;~ 		#define ABHandleToLong
;~ 		#define ABLongToHandle
;~ #else
;~ 		typedef jlong JOBJECT64;
;~ 		typedef long ABHWND64;
;~ 		#define ABHandleToLong HandleToLong
;~ 		#define ABLongToHandle LongToHandle
;~ #endif
;~ a jobject is a 32 bit pointer for 32 bit builds
;~ 'bool' is a built-in C++ type while 'BOOL' is a Microsoft specific type that is defined as an 'int'. You can find it in 'windef.h'
;~
;~ ** jni_md.h **
;~ typedef long jint;
;~ typedef __int64 jlong;
;~ typedef signed char jbyte;
;~ *******
;~ accessbridgecalls.h
;~     typedef JOBJECT64 AccessibleContext;
;~     typedef JOBJECT64 AccessibleText;
;~     typedef JOBJECT64 AccessibleValue;
;~     typedef JOBJECT64 AccessibleSelection;
;~     typedef JOBJECT64 Java_Object;
;~     typedef JOBJECT64 PropertyChangeEvent;
;~     typedef JOBJECT64 FocusEvent;
;~     typedef JOBJECT64 CaretEvent;
;~     typedef JOBJECT64 MouseEvent;
;~     typedef JOBJECT64 MenuEvent;
;~     typedef JOBJECT64 AccessibleTable;
;~     typedef JOBJECT64 AccessibleHyperlink;
;~     typedef JOBJECT64 AccessibleHypertext;

;~ #Appropriately set the return and argument types of all the access bridge dll functions
;~ if bridgeDll:
;~ 	_fixBridgeFunc(None,'Windows_run')
;~ 	_fixBridgeFunc(None,'setFocusGainedFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyStateChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyCaretChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'setPropertyActiveDescendentChangeFP',c_void_p)
;~ 	_fixBridgeFunc(None,'releaseJavaObject',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getVersionInfo',POINTER(AccessBridgeVersionInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'isJavaWindow',HWND)
;~ 	_fixBridgeFunc(BOOL,'isSameObject',c_long,JOBJECT64,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextFromHWND',HWND,POINTER(c_long),POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(HWND,'getHWNDFromAccessibleContext',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextAt',c_long,JOBJECT64,jint,jint,POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextWithFocus',HWND,POINTER(c_long),POINTER(JOBJECT64),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextInfo',c_long,JOBJECT64,POINTER(AccessibleContextInfo),errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleChildFromContext',c_long,JOBJECT64,jint,errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleParentFromContext',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleRelationSet',c_long,JOBJECT64,POINTER(AccessibleRelationSetInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextInfo',c_long,JOBJECT64,POINTER(AccessibleTextInfo),jint,jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextItems',c_long,JOBJECT64,POINTER(AccessibleTextItemsInfo),jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextSelectionInfo',c_long,JOBJECT64,POINTER(AccessibleTextSelectionInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextAttributes',c_long,JOBJECT64,jint,POINTER(AccessibleTextAttributesInfo),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextLineBounds',c_long,JOBJECT64,jint,POINTER(jint),POINTER(jint),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleTextRange',c_long,JOBJECT64,jint,jint,POINTER(c_wchar),c_short,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getCurrentAccessibleValueFromContext',c_long,JOBJECT64,POINTER(c_wchar),c_short,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'selectTextRange',c_long,JOBJECT64,c_int,c_int,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getTextAttributesInRange',c_long,JOBJECT64,c_int,c_int,POINTER(AccessibleTextAttributesInfo),POINTER(c_short),errcheck=True)
;~ 	_fixBridgeFunc(JOBJECT64,'getTopLevelObject',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(c_int,'getObjectDepth',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(JOBJECT64,'getActiveDescendent',c_long,JOBJECT64)
;~ 	_fixBridgeFunc(BOOL,'requestFocus',c_long,JOBJECT64,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'setCaretPosition',c_long,JOBJECT64,c_int,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getCaretLocation',c_long,JOBJECT64,POINTER(AccessibleTextRectInfo),jint,errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'getAccessibleActions',c_long,JOBJECT64,POINTER(AccessibleActions),errcheck=True)
;~ 	_fixBridgeFunc(BOOL,'doAccessibleActions',c_long,JOBJECT64,POINTER(AccessibleActionsToDo),POINTER(jint),errcheck=True)


;~ Primitive Types and Native Equivalents
;~ Java Type	Native Type	Description
;~ boolean		jboolean	unsigned 8 bits
;~ byte			jbyte		signed 8 bits
;~ char			jchar		unsigned 16 bits
;~ short		jshort		signed 16 bits
;~ int			jint		signed 32 bits
;~ long			jlong		signed 64 bits
;~ float		jfloat		32 bits
;~ double		jdouble		64 bits
;~ void			void		not applicable

;~ Copied from this NVDA reference and translated to AutoIT
;~ http://www.webbie.org.uk/nvda/api/JABHandler-pysrc.html
;~
;~ def initialize():
;~         global isRunning
;~         if not bridgeDll:
;~                 raise NotImplementedError("dll not available")
;~         bridgeDll.Windows_run()
;~         #Accept wm_copydata and any wm_user messages from other processes even if running with higher privilages
;~***         ChangeWindowMessageFilter=getattr(windll.user32,'ChangeWindowMessageFilter',None)
;~***         if ChangeWindowMessageFilter:
;~***                 if not ChangeWindowMessageFilter(winUser.WM_COPYDATA,1):
;~***                         raise WinError()
;~***                 for msg in xrange(winUser.WM_USER+1,65535):
;~***                         if not ChangeWindowMessageFilter(msg,1):
;~***                                 raise WinError()
;~         #Register java events
;~         bridgeDll.setFocusGainedFP(internal_event_focusGained)
;~         bridgeDll.setPropertyActiveDescendentChangeFP(internal_event_activeDescendantChange)
;~         bridgeDll.setPropertyNameChangeFP(event_nameChange)
;~         bridgeDll.setPropertyDescriptionChangeFP(event_descriptionChange)
;~         bridgeDll.setPropertyValueChangeFP(event_valueChange)
;~         bridgeDll.setPropertyStateChangeFP(internal_event_stateChange)
;~         bridgeDll.setPropertyCaretChangeFP(internal_event_caretChange)
;~         isRunning=True

;create the structs
;~
;~ 	http://docs.oracle.com/javase/accessbridge/2.0.2/api.htm
;~
;~ #define MAX_STRING_SIZE     1024
;~ #define SHORT_STRING_SIZE    256
;~ 					struct AccessBridgeVersionInfo {
;~  wchar_t VMversion[SHORT_STRING_SIZE];              // version of the Java VM
;~  wchar_t bridgeJavaClassVersion[SHORT_STRING_SIZE]; // version of the AccessBridge.class
;~  wchar_t bridgeJavaDLLVersion[SHORT_STRING_SIZE];   // version of JavaAccessBridge.dll
;~  wchar_t bridgeWinDLLVersion[SHORT_STRING_SIZE];    // version of WindowsAccessBridge.dll
;~ };


;~ struct AccessibleContextInfo {
;~  wchar_ name[MAX_STRING_SIZE];        // the AccessibleName of the object
;~  wchar_ description[MAX_STRING_SIZE]; // the AccessibleDescription of the object
;~  wchar_ role[SHORT_STRING_SIZE];      // localized AccesibleRole string
;~  wchar_ states[SHORT_STRING_SIZE];    // localized AccesibleStateSet string
;~                                       //   (comma separated)
;~  jint indexInParent                   // index of object in parent
;~  jint childrenCount                   // # of children, if any
;~  jint x;                              // screen x-axis co-ordinate in pixels
;~  jint y;                              // screen y-axis co-ordinate in pixels
;~  jint width;                          // pixel width of object
;~  jint height;                         // pixel height of object
;~  BOOL accessibleComponent;            // flags for various additional
;~  BOOL accessibleAction;               // Java Accessibility interfaces
;~  BOOL accessibleSelection;            // FALSE if this object doesn't
;~  BOOL accessibleText;                 // implement the additional interface
;~  BOOL accessibleInterfaces;           // new bitfield containing additional
;~                                       //   interface flags
;~ };
;~     typedef struct AccessibleContextInfoTag {
;~         wchar_t name[MAX_STRING_SIZE];          // the AccessibleName of the object
;~         wchar_t description[MAX_STRING_SIZE];   // the AccessibleDescription of the object

;~         wchar_t role[SHORT_STRING_SIZE];        // localized AccesibleRole string
;~         wchar_t role_en_US[SHORT_STRING_SIZE];  // AccesibleRole string in the en_US locale
;~         wchar_t states[SHORT_STRING_SIZE];      // localized AccesibleStateSet string (comma separated)
;~         wchar_t states_en_US[SHORT_STRING_SIZE]; // AccesibleStateSet string in the en_US locale (comma separated)

;~         jint indexInParent;                     // index of object in parent
;~         jint childrenCount;                     // # of children, if any

;~         jint x;                                 // screen coords in pixels
;~         jint y;                                 // "
;~         jint width;                             // pixel width of object
;~         jint height;                            // pixel height of object

;~         BOOL accessibleComponent;               // flags for various additional
;~         BOOL accessibleAction;                  //  Java Accessibility interfaces
;~         BOOL accessibleSelection;               //  FALSE if this object doesn't
;~         BOOL accessibleText;                    //  implement the additional interface
;~                                                 //  in question

;~         // BOOL accessibleValue;                // old BOOL indicating whether AccessibleValue is supported
;~         BOOL accessibleInterfaces;              // new bitfield containing additional interface flags

;~     } AccessibleContextInfo;


local $hwnd
local $i
local $result
local $vmID
local $ac

;~ //TODO: Check if needed
;~ Make messages elevated
;~ _ChangeWindowMessageFilter($WM_COPYDATA,1)
;~ for $i=$WM_USER to $WM_USER+65536
;~ 	_ChangeWindowMessageFilter($i, 1)
;~ Next

;~ Func _ChangeWindowMessageFilter($iMsg, $iAction)
;~     Local $aCall = DllCall("user32.dll", "bool", "ChangeWindowMessageFilter", "dword", $iMsg, "dword", $iAction)
;~     If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
;~     Return 1
;~ EndFunc

;~ typedef AccessibleContext (*getTopLevelObjectFP) (const long vmID, const AccessibleContext ac);
;~ 	_fixBridgeFunc(JOBJECT64,'getTopLevelObject',c_long,JOBJECT64,errcheck=True)
func __getTopLevelObject($vmId,$ac)
;~ Seems not to be allowed to call with null so passing $acParent
	$result=dllcall($hAccessBridgeDll, "ptr:cdecl", "getTopLevelObject", "long", $vmId, $c_JOBJECT64, $ac)
	If @error Then Return SetError(1, 0, 0)
	Return $result[0]
EndFunc

;~ typedef AccessibleContext (*GetAccessibleChildFromContextFP) (long vmID, AccessibleContext ac, jint i);
;~ typedef AccessibleContext (*GetAccessibleParentFromContextFP) (long vmID, AccessibleContext ac);
;~ typedef AccessibleContext GetAccessibleChildFromContext(long vmID, AccessibleContext ac, jint index);
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleChildFromContext',c_long,JOBJECT64,jint,errcheck=True)
;~ Returns an AccessibleContext object that represents the nth child of the object ac, where n is specified by the value index.
func __getAccessibleChildFromContext($vmId, $ac, $index)
;~ Seems not to be allowed to call with null so passing $acParent
	$result=dllcall($hAccessBridgeDll, "ptr:cdecl", "getAccessibleChildFromContext", "long", $vmId, $c_JOBJECT64, $ac, "int", $index)
	If @error Then Return SetError(1, 0, 0)
	Return $result[0]
EndFunc

;~ _fixBridgeFunc(JOBJECT64,'getActiveDescendent',c_long,JOBJECT64)
func __getActiveDescendent($vmId, $ac)
;~ Seems not to be allowed to call with null so passing $acParent
	$result=dllcall($hAccessBridgeDll, "ptr:cdecl", "getActiveDescendent", "long", $vmId, $c_JOBJECT64, $ac)
	If @error Then Return SetError(1, 0, 0)
	Return $result[0]
EndFunc

;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextAt',c_long,JOBJECT64,jint,jint,POINTER(JOBJECT64),errcheck=True)
;~ BOOL GetAccessibleContextAt(long vmID, AccessibleContext acParent, jint x, jint y, AccessibleContext *ac)
func __getAccessibleContextAt($vmId, $acParent, $x, $y, byref $ac)
;~ Seems not to be allowed to call with null so passing $acParent
	$result=dllcall($hAccessBridgeDll, "bool:cdecl", "getAccessibleContextAt", "long", $vmId, $c_JOBJECT64, $acParent, "int", $x, "int", $y, $cP_JOBJECT64, $ac)
consolewrite(@error)
	If @error Then Return SetError(1, 0, 0)
	consolewrite("hello")
	$ac=$result[5]
	Return $result[0]
EndFunc

func _Example1_IterateJavaWindows()


;~ Just check all windows if its a java window
Local $var = WinList()
consolewrite("Before checking all Windows: " & $var[0][0] & @CRLF)

For $i = 1 To $var[0][0]
; Only display visble windows that have a title
	If IsVisible($var[$i][1]) Then
		local $handle=wingethandle($var[$i][0])
		$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "isJavaWindow", "hwnd", $handle)
		if @error=0 Then
			if $result[0]=1 Then
				consolewrite( "  JAVA window found <" & $i & "> Java Window Title=" & $var[$i][0] &  " Handle=" & $var[$i][1] & @TAB & " res: " &  $result[0] & @CRLF)

			local $acParent=0
			local $vmID=0

;~AccessibilityContext (acParent above), which I had incorrectly mapped as an IntPtr, is actually an Int32 when using the "legacy" WindowsAccessBridge.dll library (used under x86),
;~and an Int64 when using the WOW64 WindowsAccessBridge-32.dll library.
;~WindowsAccessBridge-32.dll bool getAccessibleContextFromHWND(IntPtr hwnd, out Int32 vmID, out Int64 acParent);
;~WindowsAccessBridge.dll    bool _getAccessibleContextFromHWND(IntPtr hwnd, out Int32 vmID, out Int32 acParent);
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextFromHWND',HWND,POINTER(c_long),POINTER(JOBJECT64),errcheck=True)
			$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "getAccessibleContextFromHWND", "hwnd", $handle, "long*", $vmID, "UINT64*", $acParent)
;~ 			$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "getAccessibleContextFromHWND", "hwnd", $handle, "long*", $vmID, "ptr*", $acParent)
;~ 			$result =dllcall($hAccessBridgeDll,"BOOL:cdecl", "getAccessibleContextFromHWND", "hwnd", $handle, "long*", $vmID, "INT64*", $acParent)


				if @error=0 Then
					consolewrite("Result getAccessibleContextFromHWND is <" & $result & "> ubound: " & ubound($result) & @crlf)
					$vmID=$result[2]
					$acParent=$result[3]
					consolewrite("  We have a VMid " & $vmID & " ac " & $acParent & @CRLF)

;~ 					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getVersionInfo", "long", $vmId, "struct", $AccessBridgeVersionInfo)
;~   typedef BOOL (*GetVersionInfoFP) (long vmID, AccessBridgeVersionInfo *info);
					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getVersionInfo", "long", $vmId, "struct*", DllStructGetPtr($tAccessBridgeVersionInfo))

					if @error=0 Then
						$s1=dllstructgetdata($tAccessBridgeVersionInfo, "VMVersion")
						$s2=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeJavaClassVersion")
						$s3=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeJavaDLLVersion")
						$s4=dllstructgetdata($tAccessBridgeVersionInfo, "bridgeWinDLLVersion")

						consolewrite("Call version info: PASSED VMID found : " & $vmID & @CRLF)
						consolewrite("  VMVersion: <" & $s1 & ">" & @CRLF)
 						consolewrite("  bridgeJavaClassVersion: <" & $s2 & ">" & @CRLF)
 						consolewrite("  bridgeJavaDLLVersion: <" & $s3 & ">" & @CRLF)
						consolewrite("  bridgeWinDLLVersion: <" & $s4 & ">" & @CRLF)
					Else
						consolewrite("getVersionInfo error:" & @error  & @CRLF)
					EndIf

;~ /**
;~      * Returns the Accessible Context for the top level object in
;~      * a Java Window.  This is same Accessible Context that is obtained
;~      * from GetAccessibleContextFromHWND for that window.  Returns
;~      * (AccessibleContext)0 on error.
;~      */
;~     AccessibleContext getTopLevelObject (const long vmID, const AccessibleContext accessibleContext);
;~ typedef AccessibleContext (*getTopLevelObjectFP) (const long vmID, const AccessibleContext ac);
;~ 	_fixBridgeFunc(JOBJECT64,'getTopLevelObject',c_long,JOBJECT64,errcheck=True)


local $topAC=__getTopLevelObject($vmId, $acparent)
if @error=0 Then
	consolewrite(" *** getTopLevelObject Result is <" & $topAC & "> " & @crlf)

;~ 	$vmID=$result[1]

;~ 	local $tPtr = DllStructCreate( "ptr", $result[0] )
;~ 	local $ptr = DllStructGetData( $tPtr,1 )
;~ 	local $topAC = $result
;~ 	DllStructCreate( $tagAccessibleContextInfo, $ptr )

;~ 	Local $topAC=DllStructCreate($tagAccessibleContextInfo,DllStructGetPtr($result[0]))
;~ 	Local $topAC=DllStructCreate($tagAccessibleContextInfo,$result[0])

;~ 	dllstructsetdata($topAC,-1,$result[0]
	consolewrite("We have a VMid " & $vmID & " toplevel object ac " & $topAC & @CRLF)
	$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $topAC, "struct*", $tAccessibleContextInfo)
	$AccessibleContextInfo=$result[3]

	consolewrite(getDescription($AccessibleContextInfo))

	consolewrite("End of top level object info" & @CRLF)

	$childAC=__getAccessibleChildFromContext($vmId, $topAC, 0)
	consolewrite(" *** getAccessibleChildFromContext Result is <" & $childAC & "> " & @crlf)

	$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $childAC, "struct*", $tAccessibleContextInfo)
	$AccessibleContextInfo=$result[3]

	consolewrite(getDescription($AccessibleContextInfo))

	consolewrite("End of getAccessibleChild object info" & @CRLF)

	$descentAC=__getActiveDescendent($vmId, $topAC)
	consolewrite(" *** getActiveDescendent Result is <" & $descentAC & "> " & @crlf)

	$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $descentAC, "struct*", $tAccessibleContextInfo)
	$AccessibleContextInfo=$result[3]

	consolewrite(getDescription($AccessibleContextInfo))

	consolewrite("End of getActiveDescendent object info" & @CRLF)

Else
	consolewrite("getTopLevelObjecterror:" & @error  & @CRLF)
	_WinAPI_DisplayStruct($topAC, $tagAccessibleContextInfo)

endif



					consolewrite("  We still have a VMid " & $vmID & " acParent " & $acParent & @CRLF)
;~ Retrieves an AccessibleContextInfo object of the AccessibleContext object ac.
;~ 					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "ptr", $ac, "ptr", DllStructGetPtr($AccessibleContextInfo))
;~ typedef BOOL (*GetAccessibleContextInfoFP) (long vmID, AccessibleContext ac, AccessibleContextInfo *info);
;~ 	_fixBridgeFunc(BOOL,'getAccessibleContextInfo',c_long,JOBJECT64,POINTER(AccessibleContextInfo),errcheck=True)

;~ 					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","INT64", $vmId, "int", $ac, "ptr*", DllStructGetPtr($AccessibleContextInfo))
;~ 					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $ac, "ptr", DllStructGetPtr($AccessibleContextInfo),DllStructGetSize($AccessibleContextInfo))
;~ 					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "INT64", $acParent, "struct*", DllStructGetPtr($AccessibleContextInfo))
					$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $acParent, "struct*", $tAccessibleContextInfo)

					if @error<>0 Then
						consolewrite("We have an error " & @error & @CRLF)
					EndIf
;~ We should pass it by reference
;~ Exception code c0000005 is an access violation, also known as general protection fault. The program is reading from, or writing to, an address which is not part of the virtual address space.
;~ A very common cause is that you are de-referencing a stale pointer. In other words, the pointer was once valid, but you have subsequently freed it. Then later when you attempt to access it,
;~ an exception is raised.

;~ The problem is don't use out parameter. Use the IntPtr.
;~ So it should be getAccessibleContextInfo(Int32 vmID, IntPtr accessibleContext, IntPtr acInfo)


					consolewrite("Result is <" & $result & "> ubound: " & ubound($result) & @crlf)
					$AccessibleContextInfo=$result[3]
				_WinAPI_DisplayStruct($tAccessibleContextInfo, $tagAccessibleContextInfo)

					consolewrite(getDescription($AccessibleContextInfo))

					$s9=dllstructgetdata($AccessibleContextInfo, "x")
					$s10=dllstructgetdata($AccessibleContextInfo, "y")
					$s11=dllstructgetdata($AccessibleContextInfo, "width")
					$s12=dllstructgetdata($AccessibleContextInfo, "height")

consolewrite("  We still have before getAccessible Child FromContext a VMid " & $vmID & " acParent " & $acParent & @CRLF)
consolewrite("rect:" &$s9 & $s9+$s11 & $s10 & $s10+$s12)
 _UIA_DrawRect($s9, $s9+$s11, $s10, $s10+$s12)
sleep(3000)


;~ AccessibleContext GetAccessibleChildFromContext(long vmID, AccessibleContext ac, jint index);
;~ 	_fixBridgeFunc(JOBJECT64,'getAccessibleChildFromContext',c_long,JOBJECT64,jint,errcheck=True)
;~ Returns an AccessibleContext object that represents the nth child of the object ac, where n is specified by the value index.
	$childAC=__getAccessibleChildFromContext($vmId, $topAC, 0)
	consolewrite(" *** getAccessibleChildFromContext Result is <" & $childAC & "> " & @crlf)

	$result =dllcall($hAccessBridgeDll, "BOOL:cdecl", "getAccessibleContextInfo","long", $vmId, "long", $childAC, "struct*", $tAccessibleContextInfo)
	$AccessibleContextInfo=$result[3]

	consolewrite(getDescription($AccessibleContextInfo))

	consolewrite("End of getAccessibleChild object info" & @CRLF)

				_WinAPI_DisplayStruct($tAccessibleContextInfo, $tagAccessibleContextInfo)

;~ memcpy(tData->ResponceHTML, m_pResponse, INT_BUFFERSIZE);

					consolewrite(getDescription($AccessibleContextInfo))


				Else
					consolewrite( @error & " No context found" & @CRLF)
				endif
			EndIf
		Else
		EndIf
	endif
Next

EndFunc

;~ http://www.autohotkey.com/board/topic/95343-how-to-send-to-unseen-controls-in-a-java-app/
func _JABShutDown()
	local $result
	$result=dllcall($hAccessBridgeDll,"BOOL", "shutdownAccessBridge")
EndFunc

Func IsVisible($handle)
    If BitAND(WinGetState($handle), 2) Then
        Return 1
    Else
        Return 0
    EndIf

EndFunc   ;==>IsVisible

; Draw rectangle on screen.
Func _UIA_DrawRect($tLeft, $tRight, $tTop, $tBottom, $color = 0xFF, $PenWidth = 4)
	Local $hDC, $hPen, $obj_orig, $x1, $x2, $y1, $y2
	$x1 = $tLeft
	$x2 = $tRight
	$y1 = $tTop
	$y2 = $tBottom
	$hDC = _WinAPI_GetWindowDC(0) ; DC of entire screen (desktop)
	$hPen = _WinAPI_CreatePen($PS_SOLID, $PenWidth, $color)
	$obj_orig = _WinAPI_SelectObject($hDC, $hPen)

	_WinAPI_DrawLine($hDC, $x1, $y1, $x2, $y1) ; horizontal to right
	_WinAPI_DrawLine($hDC, $x2, $y1, $x2, $y2) ; vertical down on right
	_WinAPI_DrawLine($hDC, $x2, $y2, $x1, $y2) ; horizontal to left right
	_WinAPI_DrawLine($hDC, $x1, $y2, $x1, $y1) ; vertical up on left

	; clear resources
	_WinAPI_SelectObject($hDC, $obj_orig)
	_WinAPI_DeleteObject($hPen)
	_WinAPI_ReleaseDC(0, $hDC)
EndFunc   ;==>_UIA_DrawRect

func getDescription($ac)

					$s1=dllstructgetdata($ac, "name")
					$s2=dllstructgetdata($ac, "description")
					$s3=dllstructgetdata($ac, "role")
					$s4=dllstructgetdata($ac, "role_en_US")
					$s5=dllstructgetdata($ac, "states")
					$s6=dllstructgetdata($ac, "states_en_US")
					$s7=dllstructgetdata($ac, "indexInParent")
					$s8=dllstructgetdata($ac, "childrenCount")
					$s9=dllstructgetdata($ac, "x")
					$s10=dllstructgetdata($ac, "y")
					$s11=dllstructgetdata($ac, "width")
					$s12=dllstructgetdata($ac, "heigth")

					consolewrite("  name: <" & $s1 & ">" & @CRLF)
					consolewrite("  description: <" & $s2 & ">" & @CRLF)
					consolewrite("  role: <" & $s3 & ">" & @CRLF)
					consolewrite("  role_en_US: <" & $s4 & ">" & @CRLF)
					consolewrite("  states: <" & $s5 & ">" & @CRLF)
					consolewrite("  states_en_US: <" & $s6 & ">" & @CRLF)
					consolewrite("  indexInParent: <" & $s7 & ">" & @CRLF)
					consolewrite("  childrenCount: <" & $s8 & ">" & @CRLF)
					consolewrite("  x: <" & $s9 & ">" & @CRLF)
					consolewrite("  y: <" & $s10 & ">" & @CRLF)
					consolewrite("  width: <" & $s11 & ">" & @CRLF)
					consolewrite("  height: <" & $s12 & ">" & @CRLF)

	return $s1 & @crlf & $s2 & @crlf & $s3 & @crlf & $s4 & @crlf & $s5 & @crlf & $s6 & @crlf & $s7 & @crlf & $s8 & @crlf & $s9 & @crlf & $s10 & @crlf & $s11 & @crlf & $s12 & @crlf

EndFunc