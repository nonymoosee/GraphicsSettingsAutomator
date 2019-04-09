;SpeedTest
#include "UIAWrappers.au3"
AutoItSetOption("MustDeclareVars", 1)


Local $oP4=_UIA_getObjectByFindAll($UIA_oDesktop, "Title:=Settings;controltype:=UIA_WindowControlTypeId;class:=ApplicationFrameWindow", $treescope_children)
_UIA_Action($oP4,"setfocus")
Local $oP3=_UIA_getObjectByFindAll($oP4, "Title:=Settings;controltype:=UIA_WindowControlTypeId;class:=Windows.UI.Core.CoreWindow", $treescope_children)
_UIA_Action($oP3,"setfocus")
Local $oP2=_UIA_getObjectByFindAll($oP3, "Title:=;controltype:=UIA_GroupControlTypeId;class:=LandmarkTarget", $treescope_children)
Local $oP1=_UIA_getObjectByFindAll($oP2, "Title:=;controltype:=UIA_PaneControlTypeId;class:=ScrollViewer", $treescope_children)
Local $oP0=_UIA_getObjectByFindAll($oP1, "Title:=Graphics performance preference;controltype:=UIA_GroupControlTypeId;class:=GroupItem", $treescope_children)
;~ First find the object in the parent before you can do something
;~$oUIElement=_UIA_getObjectByFindAll("Browse.mainwindow", "title:=Browse;ControlType:=UIA_ButtonControlTypeId", $treescope_subtree)
Local $oUIElement=_UIA_getObjectByFindAll($oP0, "title:=Browse;ControlType:=UIA_ButtonControlTypeId", $treescope_subtree)
;~_UIA_action($oUIElement,"highlight")
_UIA_action($oUIElement,"click")