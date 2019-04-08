#include-once

; Array index offset relative to UIA_ControlTypeIds = -50000
Global Const $aUIASpy_Controls = [ _
	[ "Button",       "$UIA_ButtonControlTypeId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportbuttoncontroltype"        ], _
	[ "Calendar",     "$UIA_CalendarControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportcalendarcontroltype"      ], _
	[ "CheckBox",     "$UIA_CheckBoxControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportcheckboxcontroltype"      ], _
	[ "ComboBox",     "$UIA_ComboBoxControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportcomboboxcontroltype"      ], _
	[ "Edit",         "$UIA_EditControlTypeId",         "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporteditcontroltype",         "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "Hyperlink",    "$UIA_HyperlinkControlTypeId",    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporthyperlinkcontroltype"     ], _
	[ "Image",        "$UIA_ImageControlTypeId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportimagecontroltype"         ], _
	[ "ListItem",     "$UIA_ListItemControlTypeId",     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportlistitemcontroltype",     "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "List",         "$UIA_ListControlTypeId",         "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportlistcontroltype",         "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Menu",         "$UIA_MenuControlTypeId",         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportmenucontroltype"          ], _
	[ "MenuBar",      "$UIA_MenuBarControlTypeId",      "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportmenubarcontroltype",      "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1422603" ], _
	[ "MenuItem",     "$UIA_MenuItemControlTypeId",     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportmenuitemcontroltype",     "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420937" ], _
	[ "ProgressBar",  "$UIA_ProgressBarControlTypeId",  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportprogressbarcontroltype"   ], _
	[ "RadioButton",  "$UIA_RadioButtonControlTypeId",  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportradiobuttoncontroltype"   ], _
	[ "ScrollBar",    "$UIA_ScrollBarControlTypeId",    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportscrollbarcontroltype"     ], _
	[ "Slider",       "$UIA_SliderControlTypeId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportslidercontroltype"        ], _
	[ "Spinner",      "$UIA_SpinnerControlTypeId",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportspinnercontroltype"       ], _
	[ "StatusBar",    "$UIA_StatusBarControlTypeId",    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportstatusbarcontroltype"     ], _
	[ "Tab",          "$UIA_TabControlTypeId",          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttabcontroltype"           ], _
	[ "TabItem",      "$UIA_TabItemControlTypeId",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttabitemcontroltype"       ], _
	[ "Text",         "$UIA_TextControlTypeId",         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttextcontroltype"          ], _
	[ "ToolBar",      "$UIA_ToolBarControlTypeId",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttoolbarcontroltype"       ], _
	[ "ToolTip",      "$UIA_ToolTipControlTypeId",      "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttooltipcontroltype"       ], _
	[ "Tree",         "$UIA_TreeControlTypeId",         "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttreecontroltype",         "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "TreeItem",     "$UIA_TreeItemControlTypeId",     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttreeitemcontroltype",     "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Custom",       "$UIA_CustomControlTypeId",       "", "", ""                                                                                                      ], _
	[ "Group",        "$UIA_GroupControlTypeId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportgroupcontroltype"         ], _
	[ "Thumb",        "$UIA_ThumbControlTypeId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportthumbcontroltype"         ], _
	[ "DataGrid",     "$UIA_DataGridControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportdatagridcontroltype"      ], _
	[ "DataItem",     "$UIA_DataItemControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportdataitemcontroltype"      ], _
	[ "Document",     "$UIA_DocumentControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportdocumentcontroltype"      ], _
	[ "SplitButton",  "$UIA_SplitButtonControlTypeId",  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportsplitbuttoncontroltype"   ], _
	[ "Window",       "$UIA_WindowControlTypeId",       "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportwindowcontroltype",       "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Pane",         "$UIA_PaneControlTypeId",         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportpanecontroltype"          ], _
	[ "Header",       "$UIA_HeaderControlTypeId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportheadercontroltype"        ], _
	[ "HeaderItem",   "$UIA_HeaderItemControlTypeId",   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportheaderitemcontroltype"    ], _
	[ "Table",        "$UIA_TableControlTypeId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttablecontroltype"         ], _
	[ "TitleBar",     "$UIA_TitleBarControlTypeId",     "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supporttitlebarcontroltype"      ], _
	[ "Separator",    "$UIA_SeparatorControlTypeId",    "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportseparatorcontroltype"     ], _
	[ "SemanticZoom", "$UIA_SemanticZoomControlTypeId", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/WinAuto/uiauto-supportsemanticzoomcontroltype"  ], _
	[ "AppBar",       "$UIA_AppBarControlTypeId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-supportappbarcontroltype"        ] ]

; Array index offset relative to UIA_PatternIds = -10000
Global Const $aUIASpy_Patterns = [ _
	[ "Invoke",            "$UIA_InvokePatternId",            "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinginvoke",            "$UIA_IsInvokePatternAvailablePropertyId",            "$sIID_IUIAutomationInvokePattern",            "$dtag_IUIAutomationInvokePattern",            30031, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Selection",         "$UIA_SelectionPatternId",         "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingselection",         "$UIA_IsSelectionPatternAvailablePropertyId",         "$sIID_IUIAutomationSelectionPattern",         "$dtag_IUIAutomationSelectionPattern",         30037, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Value",             "$UIA_ValuePatternId",             "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingvalue",             "$UIA_IsValuePatternAvailablePropertyId",             "$sIID_IUIAutomationValuePattern",             "$dtag_IUIAutomationValuePattern",             30043, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "RangeValue",        "$UIA_RangeValuePatternId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingrangevalue",        "$UIA_IsRangeValuePatternAvailablePropertyId",        "$sIID_IUIAutomationRangeValuePattern",        "$dtag_IUIAutomationRangeValuePattern",        30033  ], _
	[ "Scroll",            "$UIA_ScrollPatternId",            "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingscroll",            "$UIA_IsScrollPatternAvailablePropertyId",            "$sIID_IUIAutomationScrollPattern",            "$dtag_IUIAutomationScrollPattern",            30034, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "ExpandCollapse",    "$UIA_ExpandCollapsePatternId",    "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingexpandcollapse",    "$UIA_IsExpandCollapsePatternAvailablePropertyId",    "$sIID_IUIAutomationExpandCollapsePattern",    "$dtag_IUIAutomationExpandCollapsePattern",    30028, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Grid",              "$UIA_GridPatternId",              "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinggrid",              "$UIA_IsGridPatternAvailablePropertyId",              "$sIID_IUIAutomationGridPattern",              "$dtag_IUIAutomationGridPattern",              30030, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "GridItem",          "$UIA_GridItemPatternId",          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinggriditem",          "$UIA_IsGridItemPatternAvailablePropertyId",          "$sIID_IUIAutomationGridItemPattern",          "$dtag_IUIAutomationGridItemPattern",          30029  ], _
	[ "MultipleView",      "$UIA_MultipleViewPatternId",      "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingmultipleview",      "$UIA_IsMultipleViewPatternAvailablePropertyId",      "$sIID_IUIAutomationMultipleViewPattern",      "$dtag_IUIAutomationMultipleViewPattern",      30032, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Window",            "$UIA_WindowPatternId",            "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingwindow",            "$UIA_IsWindowPatternAvailablePropertyId",            "$sIID_IUIAutomationWindowPattern",            "$dtag_IUIAutomationWindowPattern",            30044, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "SelectionItem",     "$UIA_SelectionItemPatternId",     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingselectionitem",     "$UIA_IsSelectionItemPatternAvailablePropertyId",     "$sIID_IUIAutomationSelectionItemPattern",     "$dtag_IUIAutomationSelectionItemPattern",     30036, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Dock",              "$UIA_DockPatternId",              "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingdock",              "$UIA_IsDockPatternAvailablePropertyId",              "$sIID_IUIAutomationDockPattern",              "$dtag_IUIAutomationDockPattern",              30027  ], _
	[ "Table",             "$UIA_TablePatternId",             "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtable",             "$UIA_IsTablePatternAvailablePropertyId",             "$sIID_IUIAutomationTablePattern",             "$dtag_IUIAutomationTablePattern",             30038, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "TableItem",         "$UIA_TableItemPatternId",         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtableitem",         "$UIA_IsTableItemPatternAvailablePropertyId",         "$sIID_IUIAutomationTableItemPattern",         "$dtag_IUIAutomationTableItemPattern",         30039  ], _
	[ "Text",              "$UIA_TextPatternId",              "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtextandtextrange",  "$UIA_IsTextPatternAvailablePropertyId",              "$sIID_IUIAutomationTextPattern",              "$dtag_IUIAutomationTextPattern",              30040  ], _
	[ "Toggle",            "$UIA_TogglePatternId",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtoggle",            "$UIA_IsTogglePatternAvailablePropertyId",            "$sIID_IUIAutomationTogglePattern",            "$dtag_IUIAutomationTogglePattern",            30041  ], _
	[ "Transform",         "$UIA_TransformPatternId",         "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtransform",         "$UIA_IsTransformPatternAvailablePropertyId",         "$sIID_IUIAutomationTransformPattern",         "$dtag_IUIAutomationTransformPattern",         30042, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "ScrollItem",        "$UIA_ScrollItemPatternId",        "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingscrollitem",        "$UIA_IsScrollItemPatternAvailablePropertyId",        "$sIID_IUIAutomationScrollItemPattern",        "$dtag_IUIAutomationScrollItemPattern",        30035, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "LegacyIAccessible", "$UIA_LegacyIAccessiblePatternId", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementinglegacyiaccessible", "$UIA_IsLegacyIAccessiblePatternAvailablePropertyId", "$sIID_IUIAutomationLegacyIAccessiblePattern", "$dtag_IUIAutomationLegacyIAccessiblePattern", 30090  ], _
	[ "ItemContainer",     "$UIA_ItemContainerPatternId",     "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingitemcontainer",     "$UIA_IsItemContainerPatternAvailablePropertyId",     "$sIID_IUIAutomationItemContainerPattern",     "$dtag_IUIAutomationItemContainerPattern",     30108, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _
	[ "VirtualizedItem",   "$UIA_VirtualizedItemPatternId",   "", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingvirtualizeditem",   "$UIA_IsVirtualizedItemPatternAvailablePropertyId",   "$sIID_IUIAutomationVirtualizedItemPattern",   "$dtag_IUIAutomationVirtualizedItemPattern",   30109, "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _
	[ "SynchronizedInput", "$UIA_SynchronizedInputPatternId", "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingsynchronizedinput", "$UIA_IsSynchronizedInputPatternAvailablePropertyId", "$sIID_IUIAutomationSynchronizedInputPattern", "$dtag_IUIAutomationSynchronizedInputPattern", 30110  ], _
	[ "ObjectModel",       "$UIA_ObjectModelPatternId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingobjectmodel",       "$UIA_IsObjectModelPatternAvailablePropertyId",       "$sIID_IUIAutomationObjectModelPattern",       "$dtag_IUIAutomationObjectModelPattern",       30112  ], _ ; Windows 8
	[ "Annotation",        "$UIA_AnnotationPatternId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingannotation",        "$UIA_IsAnnotationPatternAvailablePropertyId",        "$sIID_IUIAutomationAnnotationPattern",        "$dtag_IUIAutomationAnnotationPattern",        30118  ], _ ; Windows 8
	[ "Text2",             "$UIA_TextPattern2Id",             "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtextandtextrange",  "$UIA_IsTextPattern2AvailablePropertyId",             "$sIID_IUIAutomationTextPattern2",             "$dtag_IUIAutomationTextPattern2",             30119  ], _ ; Windows 8
	[ "Styles",            "$UIA_StylesPatternId",            "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingstyles",            "$UIA_IsStylesPatternAvailablePropertyId",            "$sIID_IUIAutomationStylesPattern",            "$dtag_IUIAutomationStylesPattern",            30127  ], _ ; Windows 8
	[ "Spreadsheet",       "$UIA_SpreadsheetPatternId",       "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingspreadsheet",       "$UIA_IsSpreadsheetPatternAvailablePropertyId",       "$sIID_IUIAutomationSpreadsheetPattern",       "$dtag_IUIAutomationSpreadsheetPattern",       30128  ], _ ; Windows 8
	[ "SpreadsheetItem",   "$UIA_SpreadsheetItemPatternId",   "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingspreadsheetitem",   "$UIA_IsSpreadsheetItemPatternAvailablePropertyId",   "$sIID_IUIAutomationSpreadsheetItemPattern",   "$dtag_IUIAutomationSpreadsheetItemPattern",   30132  ], _ ; Windows 8
	[ "Transform2",        "$UIA_TransformPattern2Id",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingtransform",         "$UIA_IsTransformPattern2AvailablePropertyId",        "$sIID_IUIAutomationTransformPattern2",        "$dtag_IUIAutomationTransformPattern2",        30134  ], _ ; Windows 8
	[ "TextChild",         "$UIA_TextChildPatternId",         "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/textchild-control-pattern",            "$UIA_IsTextChildPatternAvailablePropertyId",         "$sIID_IUIAutomationTextChildPattern",         "$dtag_IUIAutomationTextChildPattern",         30136  ], _ ; Windows 8
	[ "Drag",              "$UIA_DragPatternId",              "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingdrag",              "$UIA_IsDragPatternAvailablePropertyId",              "$sIID_IUIAutomationDragPattern",              "$dtag_IUIAutomationDragPattern",              30137  ], _ ; Windows 8
	[ "DropTarget",        "$UIA_DropTargetPatternId",        "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingdroptarget",        "$UIA_IsDropTargetPatternAvailablePropertyId",        "$sIID_IUIAutomationDropTargetPattern",        "$dtag_IUIAutomationDropTargetPattern",        30141  ], _ ; Windows 8
	[ "TextEdit",          "$UIA_TextEditPatternId",          "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/textedit-control-pattern",             "$UIA_IsTextEditPatternAvailablePropertyId",          "$sIID_IUIAutomationTextEditPattern",          "$dtag_IUIAutomationTextEditPattern",          30149  ], _ ; Windows 8.1
	[ "CustomNavigation",  "$UIA_CustomNavigationPatternId",  "", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-implementingcustomnavigation",  "$UIA_IsCustomNavigationPatternAvailablePropertyId",  "$sIID_IUIAutomationCustomNavigationPattern",  "$dtag_IUIAutomationCustomNavigationPattern",  30151  ], _ ; Windows 10
	[ "Selection2",        "$UIA_SelectionPattern2Id",        "", "",       "",                                                                                              "$UIA_IsSelectionPattern2AvailablePropertyId",        "$sIID_IUIAutomationSelectionPattern2",        "$dtag_IUIAutomationSelectionPattern2",        30168  ] ]  ; Windows 10-1709

Global $aElemDetailsIdx[16]
; Element Properties
$aElemDetailsIdx[ 0] =  11 ; Header rows
$aElemDetailsIdx[ 1] =  57 ; Item number
$aElemDetailsIdx[ 2] = $aElemDetailsIdx[ 0]                            ; Index first =  11
$aElemDetailsIdx[ 3] = $aElemDetailsIdx[ 2] + $aElemDetailsIdx[ 1] - 1 ; Index last  =  67
; Control Patterns
$aElemDetailsIdx[ 4] =   4 ; Header rows
$aElemDetailsIdx[ 5] =  35 ; Item number
$aElemDetailsIdx[ 6] = $aElemDetailsIdx[ 3] + $aElemDetailsIdx[ 4] + 1 ; Index first =  72
$aElemDetailsIdx[ 7] = $aElemDetailsIdx[ 6] + $aElemDetailsIdx[ 5] - 1 ; Index last  = 106
; Pattern Properties
$aElemDetailsIdx[ 8] =   4 ; Header rows
$aElemDetailsIdx[ 9] =  90 ; Item number
$aElemDetailsIdx[10] = $aElemDetailsIdx[ 7] + $aElemDetailsIdx[ 8] + 1 ; Index first = 111
$aElemDetailsIdx[11] = $aElemDetailsIdx[10] + $aElemDetailsIdx[ 9] - 1 ; Index last  = 200
; Pattern Methods
$aElemDetailsIdx[12] =   4 ; Header rows
$aElemDetailsIdx[13] = 182 ; Item number, 181 + 1
$aElemDetailsIdx[14] = $aElemDetailsIdx[11] + $aElemDetailsIdx[12] + 1 ; Index first = 205
$aElemDetailsIdx[15] = $aElemDetailsIdx[14] + $aElemDetailsIdx[13] - 1 ; Index last  = 386

;                                                                                 Color     Color     MS docu    Forum
Global Const $aElemDetailsArr[490][6] = [ _ ;            Default/index            Col 0     Col 1     links      example
	[ "Treeview Element",                                  "",                      0xFFFFE0 ], _                ; Index
	[ "",                                                  "",                      0x000000 ], _                ; $i = 1
	[ "Element Properties (identification)",               "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" ], _      ; $i = 2
	[ "",                                                  "",                      0x000000 ], _
	[ "Element Properties (session unique)",               "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" ], _      ; $i = 2
	[ "",                                                  "",                      0x000000 ], _
	[ "Element Properties (information)",                  "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" ], _      ; $i = 4
	[ "",                                                  "",                      0x000000 ], _
	[ "Element Properties (has/is info)",                  "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" ], _      ; $i = 4
	[ "",                                                  "",                      0x000000 ], _
	[ "Element Properties (default value)",                "",                      0xCCCCFF, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-automation-element-propids" ], _      ; $i = 6
	[ "$UIA_AcceleratorKeyPropertyId",                     ""                       ], _                         ; $i = 11 = $aElemDetailsIdx[2]
	[ "$UIA_AccessKeyPropertyId",                          ""                       ], _
	[ "$UIA_AnnotationObjectsPropertyId",                  ""                       ], _ ; Windows 10, VT_I4 | VT_ARRAY, VT_EMPTY
	[ "$UIA_AnnotationTypesPropertyId",                    ""                       ], _ ; Windows 10, VT_I4 | VT_ARRAY, VT_EMPTY
	[ "$UIA_AriaPropertiesPropertyId",                     ""                       ], _
	[ "$UIA_AriaRolePropertyId",                           ""                       ], _
	[ "$UIA_AutomationIdPropertyId",                       "",                      0x000000, 0xCCFFFF, "",        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "$UIA_BoundingRectanglePropertyId",                  "",                      0x000000, 0xCCFFFF, "",        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "$UIA_BoundingRectanglePropertyId (scaled)"          ], _ ; [0,0,0,0]
	[ "$UIA_CenterPointPropertyId",                        ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
	[ "$UIA_ClassNamePropertyId",                          "",                      0x000000, 0xCCFFFF, "",        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "$UIA_ClickablePointPropertyId",                     ""                       ], _ ; VT_R8 | VT_ARRAY, VT_EMPTY
	[ "$UIA_ControllerForPropertyId"                       ], _ ; Empty array
	[ "$UIA_ControlTypePropertyId",                        $UIA_CustomControlTypeId ], _
	[ "$UIA_CulturePropertyId",                            0                        ], _
	[ "$UIA_DescribedByPropertyId"                         ], _ ; Empty array
	[ "$UIA_FillColorPropertyId",                          0                        ], _ ; Windows 10
	[ "$UIA_FillTypePropertyId",                           0                        ], _ ; Windows 10
	[ "$UIA_FlowsFromPropertyId"                           ], _ ; Empty array            ; Windows 8, VT_UNKNOWN | VT_ARRAY
	[ "$UIA_FlowsToPropertyId"                             ], _ ; Empty array
	[ "$UIA_FrameworkIdPropertyId",                        ""                       ], _
	[ "$UIA_FullDescriptionPropertyId",                    ""                       ], _ ; Windows 10
	[ "$UIA_HasKeyboardFocusPropertyId",                   -1                       ], _ ; VT_BOOL
	[ "$UIA_HeadingLevelPropertyId",                       0                        ], _ ; Windows 10
	[ "$UIA_HelpTextPropertyId",                           ""                       ], _
	[ "$UIA_IsContentElementPropertyId",                   -1                       ], _ ; VT_BOOL
	[ "$UIA_IsControlElementPropertyId",                   -1                       ], _ ; VT_BOOL
	[ "$UIA_IsDataValidForFormPropertyId",                 -1                       ], _ ; VT_BOOL
	[ "$UIA_IsDialogPropertyId",                           -1                       ], _ ; Windows 10, VT_BOOL
	[ "$UIA_IsEnabledPropertyId",                          -1                       ], _ ; VT_BOOL
	[ "$UIA_IsKeyboardFocusablePropertyId",                -1                       ], _ ; VT_BOOL
	[ "$UIA_IsOffscreenPropertyId",                        -1                       ], _ ; VT_BOOL
	[ "$UIA_IsPasswordPropertyId",                         -1                       ], _ ; VT_BOOL
	[ "$UIA_IsPeripheralPropertyId",                       -1                       ], _ ; Windows 8.1, VT_BOOL
	[ "$UIA_IsRequiredForFormPropertyId",                  -1                       ], _ ; VT_BOOL
	[ "$UIA_ItemStatusPropertyId",                         ""                       ], _
	[ "$UIA_ItemTypePropertyId",                           ""                       ], _
	[ "$UIA_LabeledByPropertyId",                          NULL                     ], _ ; VT_UNKNOWN
	[ "$UIA_LandmarkTypePropertyId",                       0                        ], _ ; Windows 10
	[ "$UIA_LevelPropertyId",                              0                        ], _ ; Windows 10
	[ "$UIA_LiveSettingPropertyId",                        0                        ], _ ; Windows 8
	[ "$UIA_LocalizedControlTypePropertyId",               ""                       ], _
	[ "$UIA_LocalizedLandmarkTypePropertyId",              ""                       ], _ ; Windows 10
	[ "$UIA_NamePropertyId",                               ""                       ], _
	[ "$UIA_NativeWindowHandlePropertyId",                 0                        ], _
	[ "$UIA_OptimizeForVisualContentPropertyId",           -1                       ], _ ; Windows 8, VT_BOOL
	[ "$UIA_OrientationPropertyId",                        0                        ], _
	[ "$UIA_OutlineColorPropertyId",                       0                        ], _ ; Windows 10, VT_I4 | VT_ARRAY
	[ "$UIA_OutlineThicknessPropertyId",                   ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
	[ "$UIA_PositionInSetPropertyId",                      0                        ], _ ; Windows 10
	[ "$UIA_ProcessIdPropertyId",                          0                        ], _
	[ "$UIA_ProviderDescriptionPropertyId",                ""                       ], _
	[ "$UIA_RotationPropertyId",                           0.0                      ], _ ; Windows 10
	[ "$UIA_RuntimeIdPropertyId"                           ], _ ; Empty array
	[ "$UIA_SizePropertyId",                               ""                       ], _ ; Windows 10, VT_R8 | VT_ARRAY, VT_EMPTY
	[ "$UIA_SizeOfSetPropertyId",                          0                        ], _ ; Windows 10
	[ "$UIA_VisualEffectsPropertyId",                      0                        ], _ ; Windows 10,           ; 57 items
	[ "",                                                  "",                      0x000000 ], _                ; $i = 68
	[ "Control Patterns (element actions)",                "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternsoverview" ], _
	[ "",                                                  "",                      0x000000 ], _
	[ "Control Patterns (unavailable)",                    "",                      0xCCCCFF, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternsoverview" ], _
	[ "$UIA_IsAnnotationPatternAvailablePropertyId",       "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationannotationpattern"                ], _ ; Windows 8, 43+29, TRUE/FALSE ; $i = 72 = $aElemDetailsIdx[6]
	[ "$UIA_IsCustomNavigationPatternAvailablePropertyId", "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationcustomnavigationpattern-navigate" ], _ ; Windows 10, 43+30
	[ "$UIA_IsDockPatternAvailablePropertyId",             "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationdockpattern"                      ], _ ; 43+31
	[ "$UIA_IsDragPatternAvailablePropertyId",             "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationdragpattern"                      ], _ ; Windows 8, 43+32
	[ "$UIA_IsDropTargetPatternAvailablePropertyId",       "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationdroptargetpattern"                ], _ ; Windows 8, 43+33
	[ "$UIA_IsExpandCollapsePatternAvailablePropertyId",   "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationexpandcollapsepattern",           "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 44+33
	[ "$UIA_IsGridPatternAvailablePropertyId",             "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationgridpattern",                     "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 45+33
	[ "$UIA_IsGridItemPatternAvailablePropertyId",         "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationgriditempattern"                  ], _ ; 46+33
	[ "$UIA_IsInvokePatternAvailablePropertyId",           "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationinvokepattern",                   "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 47+33
	[ "$UIA_IsItemContainerPatternAvailablePropertyId",    "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationitemcontainerpattern",            "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _ ; 48+33
	[ "$UIA_IsLegacyIAccessiblePatternAvailablePropertyId","",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationlegacyiaccessiblepattern"         ], _ ; 49+33
	[ "$UIA_IsMultipleViewPatternAvailablePropertyId",     "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationmultipleviewpattern",             "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 50+33
	[ "$UIA_IsObjectModelPatternAvailablePropertyId",      "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationobjectmodelpattern"               ], _ ; Windows 8, 50+34
	[ "$UIA_IsRangeValuePatternAvailablePropertyId",       "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationrangevaluepattern"                ], _ ; 51+34
	[ "$UIA_IsScrollPatternAvailablePropertyId",           "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationscrollpattern",                   "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 52+34
	[ "$UIA_IsScrollItemPatternAvailablePropertyId",       "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationscrollitempattern",               "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 53+34
	[ "$UIA_IsSelectionPatternAvailablePropertyId",        "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationselectionpattern",                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 54+34
	[ "$UIA_IsSelectionItemPatternAvailablePropertyId",    "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationselectionitempattern",            "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 55+34
	[ "$UIA_IsSelectionPattern2AvailablePropertyId",       "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern2"                ], _ ; Windows 10-1709, 55+35
	[ "$UIA_IsSpreadsheetPatternAvailablePropertyId",      "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetpattern"               ], _ ; Windows 8, 55+36
	[ "$UIA_IsSpreadsheetItemPatternAvailablePropertyId",  "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetitempattern"           ], _ ; Windows 8, 55+37
	[ "$UIA_IsStylesPatternAvailablePropertyId",           "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationstylespattern"                    ], _ ; Windows 8, 55+38
	[ "$UIA_IsSynchronizedInputPatternAvailablePropertyId","",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationsynchronizedinputpattern"         ], _ ; 56+38
	[ "$UIA_IsTablePatternAvailablePropertyId",            "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtablepattern",                    "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 57+38
	[ "$UIA_IsTableItemPatternAvailablePropertyId",        "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtableitempattern"                 ], _ ; 58+38
	[ "$UIA_IsTextPatternAvailablePropertyId",             "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtextpattern"                      ], _ ; 59+38
	[ "$UIA_IsTextPattern2AvailablePropertyId",            "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern2"                     ], _ ; Windows 8, 59+39
	[ "$UIA_IsTextChildPatternAvailablePropertyId",        "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextchildpattern"                 ], _ ; Windows 8, 59+40
	[ "$UIA_IsTextEditPatternAvailablePropertyId",         "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtexteditpattern"                  ], _ ; Windows 8.1, 59+41
	[ "$UIA_IsTogglePatternAvailablePropertyId",           "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtogglepattern"                    ], _ ; 60+41
	[ "$UIA_IsTransformPatternAvailablePropertyId",        "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtransformpattern",                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 61+41
	[ "$UIA_IsTransformPattern2AvailablePropertyId",       "",                      "", 0xE8E8E8,       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern2"                ], _ ; Windows 8, 61+42
	[ "$UIA_IsValuePatternAvailablePropertyId",            "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationvaluepattern",                    "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _ ; 62+42
	[ "$UIA_IsVirtualizedItemPatternAvailablePropertyId",  "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationvirtualizeditempattern",          "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _ ; 63+42
	[ "$UIA_IsWindowPatternAvailablePropertyId",           "",                      "", 0xCCFFFF,       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationwindowpattern",                   "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _ ; 64+42 ; 35 items
	[ "",                                                  "",                      0x000000 ], _
	[ "Control Pattern Properties",                        "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-control-pattern-propids" ], _
	[ "",                                                  "",                      0x000000 ], _
	[ "Control Pattern Properties (unavailable patterns)", "",                      0xCCCCFF, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-control-pattern-propids" ], _
	[ "$UIA_AnnotationAnnotationTypeIdPropertyId",         43+29                    ], _ ; Windows 8             ; $i = 111 = $aElemDetailsIdx[10]
	[ "$UIA_AnnotationAnnotationTypeNamePropertyId",       43+29                    ], _ ; Windows 8
	[ "$UIA_AnnotationAuthorPropertyId",                   43+29                    ], _ ; Windows 8
	[ "$UIA_AnnotationDateTimePropertyId",                 43+29                    ], _ ; Windows 8
	[ "$UIA_AnnotationTargetPropertyId",                   43+29                    ], _ ; Windows 8, VT_UNKNOWN
	[ "$UIA_DockDockPositionPropertyId",                   43+31                    ], _
	[ "$UIA_DragDropEffectPropertyId",                     43+32                    ], _ ; Windows 8
	[ "$UIA_DragDropEffectsPropertyId",                    43+32                    ], _ ; Windows 8, VT_BSTR    | VT_ARRAY
	[ "$UIA_DragGrabbedItemsPropertyId",                   43+32                    ], _ ; Windows 8, VT_UNKNOWN | VT_ARRAY
	[ "$UIA_DragIsGrabbedPropertyId",                      43+32                    ], _ ; Windows 8, VT_BOOL
	[ "$UIA_DropTargetDropTargetEffectPropertyId",         43+33                    ], _ ; Windows 8
	[ "$UIA_DropTargetDropTargetEffectsPropertyId",        43+33                    ], _ ; Windows 8, VT_BSTR    | VT_ARRAY
	[ "$UIA_ExpandCollapseExpandCollapseStatePropertyId",  44+33                    ], _
	[ "$UIA_GridColumnCountPropertyId",                    45+33                    ], _
	[ "$UIA_GridRowCountPropertyId",                       45+33                    ], _
	[ "$UIA_GridItemColumnPropertyId",                     46+33                    ], _
	[ "$UIA_GridItemColumnSpanPropertyId",                 46+33                    ], _
	[ "$UIA_GridItemContainingGridPropertyId",             46+33                    ], _
	[ "$UIA_GridItemRowPropertyId",                        46+33                    ], _
	[ "$UIA_GridItemRowSpanPropertyId",                    46+33                    ], _
	[ "$UIA_LegacyIAccessibleChildIdPropertyId",           49+33                    ], _
	[ "$UIA_LegacyIAccessibleDefaultActionPropertyId",     49+33                    ], _
	[ "$UIA_LegacyIAccessibleDescriptionPropertyId",       49+33                    ], _
	[ "$UIA_LegacyIAccessibleHelpPropertyId",              49+33                    ], _
	[ "$UIA_LegacyIAccessibleKeyboardShortcutPropertyId",  49+33                    ], _
	[ "$UIA_LegacyIAccessibleNamePropertyId",              49+33                    ], _
	[ "$UIA_LegacyIAccessibleRolePropertyId",              49+33                    ], _
	[ "$UIA_LegacyIAccessibleSelectionPropertyId",         49+33                    ], _
	[ "$UIA_LegacyIAccessibleStatePropertyId",             49+33                    ], _
	[ "$UIA_LegacyIAccessibleValuePropertyId",             49+33                    ], _
	[ "$UIA_MultipleViewCurrentViewPropertyId",            50+33                    ], _
	[ "$UIA_MultipleViewSupportedViewsPropertyId",         50+33                    ], _
	[ "$UIA_RangeValueIsReadOnlyPropertyId",               51+34                    ], _
	[ "$UIA_RangeValueLargeChangePropertyId",              51+34                    ], _
	[ "$UIA_RangeValueMaximumPropertyId",                  51+34                    ], _
	[ "$UIA_RangeValueMinimumPropertyId",                  51+34                    ], _
	[ "$UIA_RangeValueSmallChangePropertyId",              51+34                    ], _
	[ "$UIA_RangeValueValuePropertyId",                    51+34                    ], _
	[ "$UIA_ScrollHorizontallyScrollablePropertyId",       52+34                    ], _
	[ "$UIA_ScrollHorizontalScrollPercentPropertyId",      52+34                    ], _
	[ "$UIA_ScrollHorizontalViewSizePropertyId",           52+34                    ], _
	[ "$UIA_ScrollVerticallyScrollablePropertyId",         52+34                    ], _
	[ "$UIA_ScrollVerticalScrollPercentPropertyId",        52+34                    ], _
	[ "$UIA_ScrollVerticalViewSizePropertyId",             52+34                    ], _
	[ "$UIA_SelectionCanSelectMultiplePropertyId",         54+34                    ], _
	[ "$UIA_SelectionIsSelectionRequiredPropertyId",       54+34                    ], _
	[ "$UIA_SelectionSelectionPropertyId",                 54+34                    ], _
	[ "$UIA_SelectionItemIsSelectedPropertyId",            55+34                    ], _
	[ "$UIA_SelectionItemSelectionContainerPropertyId",    55+34                    ], _
	[ "$UIA_SelectionCanSelectMultiplePropertyId",         55+35                    ], _
	[ "$UIA_SelectionIsSelectionRequiredPropertyId",       55+35                    ], _
	[ "$UIA_SelectionSelectionPropertyId",                 55+35                    ], _
	[ "$UIA_Selection2FirstSelectedItemPropertyId",        55+35                    ], _ ; Windows 10
	[ "$UIA_Selection2LastSelectedItemPropertyId",         55+35                    ], _ ; Windows 10
	[ "$UIA_Selection2CurrentSelectedItemPropertyId",      55+35                    ], _ ; Windows 10
	[ "$UIA_Selection2ItemCountPropertyId",                55+35                    ], _ ; Windows 10
	[ "$UIA_SpreadsheetItemAnnotationObjectsPropertyId",   55+37                    ], _ ; Windows 8, VT_UNKNOWN | VT_ARRAY
	[ "$UIA_SpreadsheetItemAnnotationTypesPropertyId",     55+37                    ], _ ; Windows 8, VT_I4      | VT_ARRAY
	[ "$UIA_SpreadsheetItemFormulaPropertyId",             55+37                    ], _ ; Windows 8
	[ "$UIA_StylesExtendedPropertiesPropertyId",           55+38                    ], _ ; Windows 8
	[ "$UIA_StylesFillColorPropertyId",                    55+38                    ], _ ; Windows 8
	[ "$UIA_StylesFillPatternColorPropertyId",             55+38                    ], _ ; Windows 8
	[ "$UIA_StylesFillPatternStylePropertyId",             55+38                    ], _ ; Windows 8
	[ "$UIA_StylesShapePropertyId",                        55+38                    ], _ ; Windows 8
	[ "$UIA_StylesStyleIdPropertyId",                      55+38                    ], _ ; Windows 8
	[ "$UIA_StylesStyleNamePropertyId",                    55+38                    ], _ ; Windows 8
	[ "$UIA_TableColumnHeadersPropertyId",                 57+38                    ], _
	[ "$UIA_TableRowHeadersPropertyId",                    57+38                    ], _
	[ "$UIA_TableRowOrColumnMajorPropertyId",              57+38                    ], _
	[ "$UIA_TableItemColumnHeaderItemsPropertyId",         58+38                    ], _
	[ "$UIA_TableItemRowHeaderItemsPropertyId",            58+38                    ], _
	[ "$UIA_ToggleToggleStatePropertyId",                  60+41                    ], _
	[ "$UIA_TransformCanMovePropertyId",                   61+41                    ], _
	[ "$UIA_TransformCanResizePropertyId",                 61+41                    ], _
	[ "$UIA_TransformCanRotatePropertyId",                 61+41                    ], _
	[ "$UIA_TransformCanMovePropertyId",                   61+42                    ], _
	[ "$UIA_TransformCanResizePropertyId",                 61+42                    ], _
	[ "$UIA_TransformCanRotatePropertyId",                 61+42                    ], _
	[ "$UIA_Transform2CanZoomPropertyId",                  61+42                    ], _ ; Windows 8, VT_BOOL
	[ "$UIA_Transform2ZoomLevelPropertyId",                61+42                    ], _ ; Windows 8
	[ "$UIA_Transform2ZoomMaximumPropertyId",              61+42                    ], _ ; Windows 8
	[ "$UIA_Transform2ZoomMinimumPropertyId",              61+42                    ], _ ; Windows 8
	[ "$UIA_ValueIsReadOnlyPropertyId",                    62+42                    ], _
	[ "$UIA_ValueValuePropertyId",                         62+42,                   0x000000, 0xCCFFFF, "",        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "$UIA_WindowCanMaximizePropertyId",                  64+42                    ], _
	[ "$UIA_WindowCanMinimizePropertyId",                  64+42                    ], _
	[ "$UIA_WindowIsModalPropertyId",                      64+42                    ], _
	[ "$UIA_WindowIsTopmostPropertyId",                    64+42                    ], _
	[ "$UIA_WindowWindowInteractionStatePropertyId",       64+42                    ], _
	[ "$UIA_WindowWindowVisualStatePropertyId",            64+42                    ], _                         ; 90 items
	[ "",                                                  "",                      0x000000 ], _
	[ "Control Pattern Methods",                           "",                      0xFFFFE0, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternsoverview" ], _
	[ "",                                                  "",                      0x000000 ], _
	[ "Control Pattern Methods (unavailable patterns)",    "",                      0xCCCCFF, "",       "https://docs.microsoft.com/en-us/windows/desktop/winauto/uiauto-controlpatternsoverview" ], _
	[ "Annotation Pattern Methods",                        43+29,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationannotationpattern"                                    ], _ ; Annotation Pattern Methods, Windows 8 ; $i = 205 = $aElemDetailsIdx[14]
	[ "get_CurrentAnnotationTypeId(int*)",                 43+29,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypeid"        ], _
	[ "get_CurrentAnnotationTypeName(bstr*)",              43+29,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentannotationtypename"      ], _
	[ "get_CurrentAuthor(bstr*)",                          43+29,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentauthor"                  ], _
	[ "get_CurrentDateTime(bstr*)",                        43+29,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currentdatetime"                ], _
	[ "get_CurrentTarget(ptr*)",                           43+29,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationannotationpattern-get_currenttarget"                  ], _
	[ "CustomNavigation Pattern Methods",                  43+30,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationcustomnavigationpattern"                              ], _ ; CustomNavigation Pattern Methods, Windows 10
	[ "Navigate(long;ptr*)",                               43+30,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationcustomnavigationpattern-navigate"                     ], _
	[ "Dock Pattern Methods",                              43+31,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationdockpattern"                                          ], _ ; Dock Pattern Methods
	[ "SetDockPosition(long)",                             43+31,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationdockpattern-setdockposition"                          ], _
	[ "CurrentDockPosition(long*)",                        43+31,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationdockpattern-get_currentdockposition"                  ], _
	[ "Drag Pattern Methods",                              43+32,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationdragpattern"                                          ], _ ; Drag Pattern Methods, Windows 8
	[ "get_CurrentIsGrabbed(bool*)",                       43+32,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentisgrabbed"                     ], _
	[ "get_CurrentDropEffect(bstr*)",                      43+32,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffect"                    ], _
	[ "get_CurrentDropEffects(ptr*)",                      43+32,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-get_currentdropeffects"                   ], _
	[ "GetCurrentGrabbedItems(ptr*)",                      43+32,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdragpattern-getcurrentgrabbeditems"                   ], _
	[ "DropTarget Pattern Methods",                        43+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationdroptargetpattern"                                    ], _ ; DropTarget Pattern Methods, Windows 8
	[ "get_CurrentDropTargetEffect(bstr*)",                43+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffect"        ], _
	[ "get_CurrentDropTargetEffects(ptr*)",                43+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationdroptargetpattern-get_currentdroptargeteffects"       ], _
	[ "ExpandCollapse Pattern Methods",                    44+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationexpandcollapsepattern"                                ], _ ; ExpandCollapse Pattern Methods
	[ "Expand()",                                          44+33,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-expand",                        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Collapse()",                                        44+33,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-collapse",                      "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "CurrentExpandCollapseState($iState*)",              44+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationexpandcollapsepattern-get_currentexpandcollapsestate" ], _
	[ "Grid Pattern Methods",                              45+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationgridpattern"                                          ], _ ; Grid Pattern Methods
	[ "GetItem($iRow,$iColumn,$pUIElement*)",              45+33,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationgridpattern-getitem",                                 "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "CurrentRowCount($iRows*)",                          45+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentrowcount"                      ], _
	[ "CurrentColumnCount($iColumns*)",                    45+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgridpattern-get_currentcolumncount"                   ], _
	[ "GridItem Pattern Methods",                          46+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationgriditempattern"                                      ], _ ; GridItem Pattern Methods
	[ "CurrentColumn(int*)",                               46+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumn"                    ], _
	[ "CurrentColumnSpan(int*)",                           46+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcolumnspan"                ], _
	[ "CurrentContainingGrid(ptr*)",                       46+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentcontaininggrid"            ], _
	[ "CurrentRow(int*)",                                  46+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrow"                       ], _
	[ "CurrentRowSpan(int*)",                              46+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationgriditempattern-get_currentrowspan"                   ], _
	[ "Invoke Pattern Methods",                            47+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationinvokepattern"                                        ], _ ; Invoke Pattern Methods
	[ "Invoke()",                                          47+33,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationinvokepattern-invoke",                                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "ItemContainer Pattern Methods",                     48+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationitemcontainerpattern"                                 ], _ ; ItemContainer Pattern Methods
	[ "FindItemByProperty($pUIElement,$iUIA_PropertyId,$vPropVal,pUIElement*)",     48+33,"", 0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationitemcontainerpattern-finditembyproperty",             "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _
	[ "LegacyIAccessible Pattern Methods",                 49+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationlegacyiaccessiblepattern"                             ], _ ; LegacyIAccessible Pattern Methods
	[ "DoDefaultAction()",                                 49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-dodefaultaction"             ], _
	[ "Select(long)",                                      49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-select"                      ], _
	[ "SetValue(wstr)",                                    49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-setvalue"                    ], _
	[ "GetIAccessible(idispatch*)",                        49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getiaccessible"              ], _
	[ "CurrentChildId(int*)",                              49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentchildid"          ], _
	[ "CurrentDefaultAction(bstr*)",                       49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdefaultaction"    ], _
	[ "CurrentDescription(bstr*)",                         49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentdescription"      ], _
	[ "CurrentHelp(bstr*)",                                49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currenthelp"             ], _
	[ "CurrentKeyboardShortcut(bstr*)",                    49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentkeyboardshortcut" ], _
	[ "CurrentName(bstr*)",                                49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentname"             ], _
	[ "CurrentRole(uint*)",                                49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentrole"             ], _
	[ "CurrentState(uint*)",                               49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentstate"            ], _
	[ "CurrentValue(bstr*)",                               49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-get_currentvalue"            ], _
	[ "GetCurrentSelection(ptr*)",                         49+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationlegacyiaccessiblepattern-getcurrentselection"         ], _
	[ "MultipleView Pattern Methods",                      50+33,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationmultipleviewpattern"                                  ], _ ; MultipleView Pattern Methods
	[ "GetViewName($iViewId,$sViewName*)",                 50+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getviewname"                      ], _
	[ "SetCurrentView($iViewId)",                          50+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-setcurrentview"                   ], _
	[ "CurrentCurrentView($iViewId*)",                     50+33,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-get_currentcurrentview"           ], _
	[ "GetCurrentSupportedViews($pSafeArray*)",            50+33,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationmultipleviewpattern-getcurrentsupportedviews",        "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "ObjectModel Pattern Methods",                       50+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationobjectmodelpattern"                                   ], _ ; ObjectModel Pattern Methods, Windows 8
	[ "GetUnderlyingObjectModel(ptr*)",                    50+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationobjectmodelpattern-getunderlyingobjectmodel"          ], _
	[ "RangeValue Pattern Methods",                        51+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationrangevaluepattern"                                    ], _ ; RangeValue Pattern Methods
	[ "SetValue(ushort)",                                  51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationrangevaluepattern-setvalue"                           ], _
	[ "CurrentIsReadOnly(long*)",                          51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentisreadonly"              ], _
	[ "CurrentMaximum(ushort*)",                           51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentmaximum"                 ], _
	[ "CurrentMinimum(ushort*)",                           51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentminimum"                 ], _
	[ "CurrentLargeChange(ushort*)",                       51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentlargechange"             ], _
	[ "CurrentSmallChange(ushort*)",                       51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentsmallchange"             ], _
	[ "CurrentValue(ushort*)",                             51+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationrangevaluepattern-get_currentvalue"                   ], _
	[ "Scroll Pattern Methods",                            52+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationscrollpattern"                                        ], _ ; Scroll Pattern Methods
	[ "Scroll($iScrollAmountHorz,$iScrollAmountVert)",     52+34,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationscrollpattern-scroll",                                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "SetScrollPercent($fPercentHorz,$fPercentVert)",     52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-setscrollpercent"                       ], _
	[ "CurrentHorizontalScrollPercent($fPercent*)",        52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalscrollpercent"     ], _
	[ "CurrentVerticalScrollPercent($fPercent*)",          52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalscrollpercent"       ], _
	[ "CurrentHorizontalViewSize($fViewSize*)",            52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontalviewsize"          ], _
	[ "CurrentVerticalViewSize($fViewSize*)",              52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticalviewsize"            ], _
	[ "CurrentHorizontallyScrollable($bScrollable*)",      52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currenthorizontallyscrollable"      ], _
	[ "CurrentVerticallyScrollable($bScrollable*)",        52+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationscrollpattern-get_currentverticallyscrollable"        ], _
	[ "ScrollItem Pattern Methods",                        53+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationscrollitempattern"                                    ], _ ; ScrollItem Pattern Methods
	[ "ScrollIntoView()",                                  53+34,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationscrollitempattern-scrollintoview",                    "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Selection Pattern Methods",                         54+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationselectionpattern"                                     ], _ ; Selection Pattern Methods
	[ "GetCurrentSelection($pElementArray*)",              54+34,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationselectionpattern-getcurrentselection",                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "CurrentCanSelectMultiple($bCanSelectMultiple*)",    54+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentcanselectmultiple"        ], _
	[ "CurrentIsSelectionRequired($bIsSelectionRequired*)",54+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentisselectionrequired"      ], _
	[ "SelectionItem Pattern Methods",                     55+34,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationselectionitempattern"                                 ], _ ; SelectionItem Pattern Methods
	[ "Select()",                                          55+34,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationselectionitempattern-select",                         "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "AddToSelection()",                                  55+34,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-addtoselection",                 "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "RemoveFromSelection()",                             55+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-removefromselection"             ], _
	[ "CurrentIsSelected($bIsSelected*)",                  55+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentisselected"           ], _
	[ "CurrentSelectionContainer($pUIElement*)",           55+34,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionitempattern-get_currentselectioncontainer"   ], _
	[ "Selection2 Pattern Methods",                        55+35,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationselectionpattern2"                                    ], _ ; Selection2 Pattern Methods, Windows 10-1709
	[ "GetCurrentSelection($pElementArray*)",              55+35,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationselectionpattern-getcurrentselection",                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "CurrentCanSelectMultiple($bCanSelectMultiple*)",    55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentcanselectmultiple"        ], _
	[ "CurrentIsSelectionRequired($bIsSelectionRequired*)",55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern-get_currentisselectionrequired"      ], _
	[ "get_CurrentFirstSelectedItem(ptr*)",                55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentfirstselecteditem"       ], _
	[ "get_CurrentLastSelectedItem(ptr*)",                 55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentlastselecteditem"        ], _
	[ "get_CurrentCurrentSelectedItem(ptr*)",              55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentcurrentselecteditem"     ], _
	[ "get_CurrentItemCount(int*)",                        55+35,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationselectionpattern2-get_currentitemcount"               ], _
	[ "Spreadsheet Pattern Methods",                       55+36,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetpattern"                                   ], _ ; Spreadsheet Pattern Methods, Windows 8
	[ "GetItemByName(bstr;ptr*)",                          55+36,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetpattern-getitembyname"                     ], _
	[ "SpreadsheetItem Pattern Methods",                   55+37,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationspreadsheetitempattern"                               ], _ ; SpreadsheetItem Pattern Methods, Windows 8
	[ "get_CurrentFormula(bstr*)",                         55+37,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-get_currentformula"            ], _
	[ "GetCurrentAnnotationObjects(ptr*)",                 55+37,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationobjects"   ], _
	[ "GetCurrentAnnotationTypes(ptr*)",                   55+37,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationspreadsheetitempattern-getcurrentannotationtypes"     ], _
	[ "Styles Pattern Methods",                            55+38,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationstylespattern"                                        ], _ ; Styles Pattern Methods, Windows 8
	[ "get_CurrentFillColor(int*)",                        55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillcolor"                   ], _
	[ "get_CurrentFillPatternColor(int*)",                 55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentfillpatterncolor"            ], _
	[ "get_CurrentFillPatternStyle(bstr*)",                55+38,                   "",       "",       "" ], _
	[ "get_CurrentShape(bstr*)",                           55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentshape"                       ], _
	[ "get_CurrentStyleId(int*)",                          55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstyleid"                     ], _
	[ "get_CurrentStyleName(bstr*)",                       55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentstylename"                   ], _
	[ "get_CurrentExtendedProperties(bstr*)",              55+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationstylespattern-get_currentextendedproperties"          ], _
	[ "SynchronizedInput Pattern Methods",                 56+38,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationsynchronizedinputpattern"                             ], _ ; SynchronizedInput Pattern Methods
	[ "StartListening(long)",                              56+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-startlistening"              ], _
	[ "Cancel()",                                          56+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationsynchronizedinputpattern-cancel"                      ], _
	[ "Table Pattern Methods",                             57+38,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtablepattern"                                         ], _ ; Table Pattern Methods
	[ "GetCurrentRowHeaders($pElementArray*)",             57+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentrowheaders"                    ], _
	[ "GetCurrentColumnHeaders($pElementArray*)",          57+38,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-getcurrentcolumnheaders",                "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "CurrentRowOrColumnMajor($iRowOrColumnMajor*)",      57+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtablepattern-get_currentroworcolumnmajor"             ], _
	[ "TableItem Pattern Methods",                         58+38,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtableitempattern"                                     ], _ ; TableItem Pattern Methods
	[ "GetCurrentRowHeaderItems(ptr*)",                    58+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentrowheaderitems"            ], _
	[ "GetCurrentColumnHeaderItems(ptr*)",                 58+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtableitempattern-getcurrentcolumnheaderitems"         ], _
	[ "Text Pattern Methods",                              59+38,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtextpattern"                                          ], _ ; Text Pattern Methods
	[ "DocumentRange(ptr*)",                               59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtextpattern-get_documentrange"                        ], _
	[ "GetSelection(ptr*)",                                59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getselection"                             ], _
	[ "GetVisibleRanges(ptr*)",                            59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getvisibleranges"                         ], _
	[ "RangeFromChild(ptr,ptr*)",                          59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefromchild"                           ], _
	[ "RangeFromPoint(struct,ptr*)",                       59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefrompoint"                           ], _
	[ "SupportedTextSelection(long*)",                     59+38,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_supportedtextselection"               ], _
	[ "Text2 Pattern Methods",                             59+39,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextpattern2"                                         ], _ ; Text2 Pattern Methods, Windows 8
	[ "DocumentRange(ptr*)",                               59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtextpattern-get_documentrange"                        ], _
	[ "GetSelection(ptr*)",                                59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getselection"                             ], _
	[ "GetVisibleRanges(ptr*)",                            59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-getvisibleranges"                         ], _
	[ "RangeFromChild(ptr,ptr*)",                          59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefromchild"                           ], _
	[ "RangeFromPoint(struct,ptr*)",                       59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-rangefrompoint"                           ], _
	[ "SupportedTextSelection(long*)",                     59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern-get_supportedtextselection"               ], _
	[ "RangeFromAnnotation(ptr;ptr*)",                     59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-rangefromannotation"                     ], _
	[ "GetCaretRange(bool;ptr*)",                          59+39,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextpattern2-getcaretrange"                           ], _
	[ "TextChild Pattern Methods",                         59+40,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtextchildpattern"                                     ], _ ; TextChild Pattern Methods, Windows 8
	[ "get_TextContainer(ptr*)",                           59+40,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textcontainer"                   ], _
	[ "get_TextRange(ptr*)",                               59+40,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtextchildpattern-get_textrange"                       ], _
	[ "TextEdit Pattern Methods",                          59+41,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtexteditpattern"                                      ], _ ; TextEdit Pattern Methods, Windows 8.1
	[ "GetActiveComposition(ptr*)",                        59+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getactivecomposition"                 ], _
	[ "GetConversionTarget(ptr*)",                         59+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtexteditpattern-getconversiontarget"                  ], _
	[ "Toggle Pattern Methods",                            60+41,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtogglepattern"                                        ], _ ; Toggle Pattern Methods
	[ "Toggle()",                                          60+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtogglepattern-toggle"                                 ], _
	[ "CurrentToggleState(long*)",                         60+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtogglepattern-get_currenttogglestate"                 ], _
	[ "Transform Pattern Methods",                         61+41,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationtransformpattern"                                     ], _ ; Transform Pattern Methods
	[ "Move($fXPos,$fYPos)",                               61+41,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtransformpattern-move",                               "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Resize($fWidth,$fHeight)",                          61+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-resize"                              ], _
	[ "Rotate($fDegrees)",                                 61+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-rotate"                              ], _
	[ "CurrentCanMove($bCanMove*)",                        61+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanmove"                  ], _
	[ "CurrentCanResize($bCanResize*)",                    61+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanresize"                ], _
	[ "CurrentCanRotate($bCanRotate*)",                    61+41,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanrotate"                ], _
	[ "Transform2 Pattern Methods",                        61+42,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nn-uiautomationclient-iuiautomationtransformpattern2"                                    ], _ ; Transform2 Pattern Methods, Windows 8
	[ "Move($fXPos,$fYPos)",                               61+42,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationtransformpattern-move",                               "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "Resize($fWidth,$fHeight)",                          61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-resize"                              ], _
	[ "Rotate($fDegrees)",                                 61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-rotate"                              ], _
	[ "CurrentCanMove($bCanMove*)",                        61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanmove"                  ], _
	[ "CurrentCanResize($bCanResize*)",                    61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanresize"                ], _
	[ "CurrentCanRotate($bCanRotate*)",                    61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern-get_currentcanrotate"                ], _
	[ "Zoom(double)",                                      61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoom"                               ], _
	[ "ZoomByUnit(long)",                                  61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-zoombyunit"                         ], _
	[ "get_CurrentCanZoom(bool*)",                         61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentcanzoom"                 ], _
	[ "get_CurrentZoomLevel(double*)",                     61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomlevel"               ], _
	[ "get_CurrentZoomMinimum(double*)",                   61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoomminimum"             ], _
	[ "get_CurrentZoomMaximum(double*)",                   61+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationtransformpattern2-get_currentzoommaximum"             ], _
	[ "Value Pattern Methods",                             62+42,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationvaluepattern"                                         ], _ ; Value Pattern Methods
	[ "SetValue($sValue)",                                 62+42,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationvaluepattern-setvalue",                               "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1419507" ], _
	[ "CurrentValue($sValue*)",                            62+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentvalue"                        ], _
	[ "CurrentIsReadOnly($bIsReadOnly*)",                  62+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationvaluepattern-get_currentisreadonly"                   ], _
	[ "VirtualizedItem Pattern Methods",                   63+42,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationvirtualizeditempattern"                               ], _ ; VirtualizedItem Pattern Methods
	[ "Realize()",                                         63+42,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationvirtualizeditempattern-realize",                      "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1421955" ], _
	[ "Window Pattern Methods",                            64+42,                   0xE8E8E8, "",       "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nn-uiautomationclient-iuiautomationwindowpattern"                                        ], _ ; Window Pattern Methods
	[ "Close()",                                           64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/UIAutomationClient/nf-uiautomationclient-iuiautomationwindowpattern-close"                                  ], _
	[ "SetWindowVisualState($iWindowVisualState)",         64+42,                   "",       0xCCFFFF, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-setwindowvisualstate",                  "https://www.autoitscript.com/forum/index.php?showtopic=197080&view=findpost&p=1420941" ], _
	[ "WaitForInputIdle($iMilliSeconds,$bSuccess*)",       64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-waitforinputidle"                       ], _
	[ "CurrentCanMaximize($bCanMaximize*)",                64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanmaximize"                 ], _
	[ "CurrentCanMinimize($bCanMinimize*)",                64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentcanminimize"                 ], _
	[ "CurrentIsModal($bIsModal*)",                        64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentismodal"                     ], _
	[ "CurrentIsTopmost($bIsTopmost*)",                    64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentistopmost"                   ], _
	[ "CurrentWindowVisualState($iWindowVisualState*)",    64+42,                   "",       0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowvisualstate"           ], _
	[ "CurrentWindowInteractionState($iWindowInteractionState*)",                   64+42,"", 0xE8E8E8, "https://docs.microsoft.com/en-us/windows/desktop/api/uiautomationclient/nf-uiautomationclient-iuiautomationwindowpattern-get_currentwindowinteractionstate"      ], _
	[ "",                                                  ""                       ] ]                          ; 181 + 1 items

; --- Element Property Values ---

Global Const $aUIA_LiveSettings = [ _
	"$LiveSetting_Off", _
	"$LiveSetting_Polite", _
	"$LiveSetting_Assertive" ]

Global Const $aUIA_OrientationTypes = [ _
	"$OrientationType_None", _
	"$OrientationType_Horizontal", _
	"$OrientationType_Vertical" ]

; --- Control Pattern Property Values ---

Global Const $aUIA_DockPositions = [ _
	"$DockPosition_Top", _
	"$DockPosition_Left", _
	"$DockPosition_Bottom", _
	"$DockPosition_Right", _
	"$DockPosition_Fill", _
	"$DockPosition_None" ]

Global Const $aUIA_ExpandCollapseStates = [ _
	"$ExpandCollapseState_Collapsed", _
	"$ExpandCollapseState_Expanded", _
	"$ExpandCollapseState_PartiallyExpanded", _
	"$ExpandCollapseState_LeafNode" ]

Global Const $aUIA_LegacyIAccessibleRoles = [ _
	"", _
	"$ROLE_SYSTEM_TITLEBAR", _
	"$ROLE_SYSTEM_MENUBAR", _
	"$ROLE_SYSTEM_SCROLLBAR", _
	"$ROLE_SYSTEM_GRIP", _
	"$ROLE_SYSTEM_SOUND", _
	"$ROLE_SYSTEM_CURSOR", _
	"$ROLE_SYSTEM_CARET", _
	"$ROLE_SYSTEM_ALERT", _
	"$ROLE_SYSTEM_WINDOW", _
	"$ROLE_SYSTEM_CLIENT", _
	"$ROLE_SYSTEM_MENUPOPUP", _
	"$ROLE_SYSTEM_MENUITEM", _
	"$ROLE_SYSTEM_TOOLTIP", _
	"$ROLE_SYSTEM_APPLICATION", _
	"$ROLE_SYSTEM_DOCUMENT", _
	"$ROLE_SYSTEM_PANE", _
	"$ROLE_SYSTEM_CHART", _
	"$ROLE_SYSTEM_DIALOG", _
	"$ROLE_SYSTEM_BORDER", _
	"$ROLE_SYSTEM_GROUPING", _
	"$ROLE_SYSTEM_SEPARATOR", _
	"$ROLE_SYSTEM_TOOLBAR", _
	"$ROLE_SYSTEM_STATUSBAR", _
	"$ROLE_SYSTEM_TABLE", _
	"$ROLE_SYSTEM_COLUMNHEADER", _
	"$ROLE_SYSTEM_ROWHEADER", _
	"$ROLE_SYSTEM_COLUMN", _
	"$ROLE_SYSTEM_ROW", _
	"$ROLE_SYSTEM_CELL", _
	"$ROLE_SYSTEM_LINK", _
	"$ROLE_SYSTEM_HELPBALLOON", _
	"$ROLE_SYSTEM_CHARACTER", _
	"$ROLE_SYSTEM_LIST", _
	"$ROLE_SYSTEM_LISTITEM", _
	"$ROLE_SYSTEM_OUTLINE", _
	"$ROLE_SYSTEM_OUTLINEITEM", _
	"$ROLE_SYSTEM_PAGETAB", _
	"$ROLE_SYSTEM_PROPERTYPAGE", _
	"$ROLE_SYSTEM_INDICATOR", _
	"$ROLE_SYSTEM_GRAPHIC", _
	"$ROLE_SYSTEM_STATICTEXT", _
	"$ROLE_SYSTEM_TEXT", _
	"$ROLE_SYSTEM_PUSHBUTTON", _
	"$ROLE_SYSTEM_CHECKBUTTON", _
	"$ROLE_SYSTEM_RADIOBUTTON", _
	"$ROLE_SYSTEM_COMBOBOX", _
	"$ROLE_SYSTEM_DROPLIST", _
	"$ROLE_SYSTEM_PROGRESSBAR", _
	"$ROLE_SYSTEM_DIAL", _
	"$ROLE_SYSTEM_HOTKEYFIELD", _
	"$ROLE_SYSTEM_SLIDER", _
	"$ROLE_SYSTEM_SPINBUTTON", _
	"$ROLE_SYSTEM_DIAGRAM", _
	"$ROLE_SYSTEM_ANIMATION", _
	"$ROLE_SYSTEM_EQUATION", _
	"$ROLE_SYSTEM_BUTTONDROPDOWN", _
	"$ROLE_SYSTEM_BUTTONMENU", _
	"$ROLE_SYSTEM_BUTTONDROPDOWNGRID", _
	"$ROLE_SYSTEM_WHITESPACE", _
	"$ROLE_SYSTEM_PAGETABLIST", _
	"$ROLE_SYSTEM_CLOCK", _
	"$ROLE_SYSTEM_SPLITBUTTON", _
	"$ROLE_SYSTEM_IPADDRESS", _
	"$ROLE_SYSTEM_OUTLINEBUTTON" ]

Global Const $aUIA_LegacyIAccessibleStates = [ _
	"$STATE_SYSTEM_UNAVAILABLE", _ ;     = 0x1
	"$STATE_SYSTEM_SELECTED", _ ;        = 0x2
	"$STATE_SYSTEM_FOCUSED", _ ;         = 0x4
	"$STATE_SYSTEM_PRESSED", _ ;         = 0x8
	"$STATE_SYSTEM_CHECKED", _ ;         = 0x10
	"$STATE_SYSTEM_MIXED", _ ;           = 0x20
	"$STATE_SYSTEM_READONLY", _ ;        = 0x40
	"$STATE_SYSTEM_HOTTRACKED", _ ;      = 0x80
	"$STATE_SYSTEM_DEFAULT", _ ;         = 0x100
	"$STATE_SYSTEM_EXPANDED", _ ;        = 0x200
	"$STATE_SYSTEM_COLLAPSED", _ ;       = 0x400
	"$STATE_SYSTEM_BUSY", _ ;            = 0x800
	"$STATE_SYSTEM_FLOATING", _ ;        = 0x1000
	"$STATE_SYSTEM_MARQUEED", _ ;        = 0x2000
	"$STATE_SYSTEM_ANIMATED", _ ;        = 0x4000
	"$STATE_SYSTEM_INVISIBLE", _ ;       = 0x8000
	"$STATE_SYSTEM_OFFSCREEN", _ ;       = 0x10000
	"$STATE_SYSTEM_SIZEABLE", _ ;        = 0x20000
	"$STATE_SYSTEM_MOVEABLE", _ ;        = 0x40000
	"$STATE_SYSTEM_SELFVOICING", _ ;     = 0x80000
	"$STATE_SYSTEM_FOCUSABLE", _ ;       = 0x100000
	"$STATE_SYSTEM_SELECTABLE", _ ;      = 0x200000
	"$STATE_SYSTEM_LINKED", _ ;          = 0x400000
	"$STATE_SYSTEM_TRAVERSED", _ ;       = 0x800000
	"$STATE_SYSTEM_MULTISELECTABLE", _ ; = 0x1000000
	"$STATE_SYSTEM_EXTSELECTABLE", _ ;   = 0x2000000
	"$STATE_SYSTEM_ALERT_LOW", _ ;       = 0x4000000
	"$STATE_SYSTEM_ALERT_MEDIUM", _ ;    = 0x8000000
	"$STATE_SYSTEM_ALERT_HIGH", _ ;      = 0x10000000
	"$STATE_SYSTEM_PROTECTED", _ ;       = 0x20000000
	"$STATE_SYSTEM_HASPOPUP" ] ;         = 0x40000000
; $STATE_SYSTEM_NORMAL = 0
; $STATE_SYSTEM_VALID  = 0x7FFFFFFF

#cs
Global Const $aUIA_ScrollAmounts = [ _
	"$ScrollAmount_LargeDecrement", _
	"$ScrollAmount_SmallDecrement", _
	"$ScrollAmount_NoAmount", _
	"$ScrollAmount_LargeIncrement", _
	"$ScrollAmount_SmallIncrement" ]

Global Const $aUIA_RowOrColumnMajors = [ _
	"$RowOrColumnMajor_RowMajor", _
	"$RowOrColumnMajor_ColumnMajor", _
	"$RowOrColumnMajor_Indeterminate" ]
#ce

Global Const $aUIA_ToggleStates = [ _
	"$ToggleState_Off", _
	"$ToggleState_On", _
	"$ToggleState_Indeterminate" ]

Global Const $aUIA_WindowInteractionStates = [ _
	"$WindowInteractionState_Running", _
	"$WindowInteractionState_Closing", _
	"$WindowInteractionState_ReadyForUserInteraction", _
	"$WindowInteractionState_BlockedByModalWindow", _
	"$WindowInteractionState_NotResponding" ]

Global Const $aUIA_WindowVisualStates = [ _
	"$WindowVisualState_Normal", _
	"$WindowVisualState_Maximized", _
	"$WindowVisualState_Minimized" ]
