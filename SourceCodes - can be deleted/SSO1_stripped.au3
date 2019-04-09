Global Const $UIA_InvokePatternId = 10000
Global Const $UIA_SelectionItemPatternId = 10010
Global Const $UIA_NamePropertyId = 30005
Global Const $UIA_AutomationIdPropertyId = 30011
Global Const $UIA_ClassNamePropertyId = 30012
Global Const $TreeScope_Descendants = 4
Global Const $sCLSID_CUIAutomation8 = "{E22AD333-B25F-460C-83D0-0581107395C9}"
Global Const $dtag_IUIAutomation = "CompareElements hresult(ptr;ptr;long*);" & "CompareRuntimeIds hresult(ptr;ptr;long*);" & "GetRootElement hresult(ptr*);" & "ElementFromHandle hresult(hwnd;ptr*);" & "ElementFromPoint hresult(struct;ptr*);" & "GetFocusedElement hresult(ptr*);" & "GetRootElementBuildCache hresult(ptr;ptr*);" & "ElementFromHandleBuildCache hresult(hwnd;ptr;ptr*);" & "ElementFromPointBuildCache hresult(struct;ptr;ptr*);" & "GetFocusedElementBuildCache hresult(ptr;ptr*);" & "CreateTreeWalker hresult(ptr;ptr*);" & "ControlViewWalker hresult(ptr*);" & "ContentViewWalker hresult(ptr*);" & "RawViewWalker hresult(ptr*);" & "RawViewCondition hresult(ptr*);" & "ControlViewCondition hresult(ptr*);" & "ContentViewCondition hresult(ptr*);" & "CreateCacheRequest hresult(ptr*);" & "CreateTrueCondition hresult(ptr*);" & "CreateFalseCondition hresult(ptr*);" & "CreatePropertyCondition hresult(int;variant;ptr*);" & "CreatePropertyConditionEx hresult(int;variant;long;ptr*);" & "CreateAndCondition hresult(ptr;ptr;ptr*);" & "CreateAndConditionFromArray hresult(ptr;ptr*);" & "CreateAndConditionFromNativeArray hresult(ptr;int;ptr*);" & "CreateOrCondition hresult(ptr;ptr;ptr*);" & "CreateOrConditionFromArray hresult(ptr;ptr*);" & "CreateOrConditionFromNativeArray hresult(ptr;int;ptr*);" & "CreateNotCondition hresult(ptr;ptr*);" & "AddAutomationEventHandler hresult(int;ptr;long;ptr;ptr);" & "RemoveAutomationEventHandler hresult(int;ptr;ptr);" & "AddPropertyChangedEventHandlerNativeArray hresult(ptr;long;ptr;ptr;struct*;int);" & "AddPropertyChangedEventHandler hresult(ptr;long;ptr;ptr;ptr);" & "RemovePropertyChangedEventHandler hresult(ptr;ptr);" & "AddStructureChangedEventHandler hresult(ptr;long;ptr;ptr);" & "RemoveStructureChangedEventHandler hresult(ptr;ptr);" & "AddFocusChangedEventHandler hresult(ptr;ptr);" & "RemoveFocusChangedEventHandler hresult(ptr);" & "RemoveAllEventHandlers hresult();" & "IntNativeArrayToSafeArray hresult(int;int;ptr*);" & "IntSafeArrayToNativeArray hresult(ptr;int*;int*);" & "RectToVariant hresult(struct;variant*);" & "VariantToRect hresult(variant;struct*);" & "SafeArrayToRectNativeArray hresult(ptr;struct*;int*);" & "CreateProxyFactoryEntry hresult(ptr;ptr*);" & "ProxyFactoryMapping hresult(ptr*);" & "GetPropertyProgrammaticName hresult(int;bstr*);" & "GetPatternProgrammaticName hresult(int;bstr*);" & "PollForPotentialSupportedPatterns hresult(ptr;ptr*;ptr*);" & "PollForPotentialSupportedProperties hresult(ptr;ptr*;ptr*);" & "CheckNotSupported hresult(variant;long*);" & "ReservedNotSupportedValue hresult(ptr*);" & "ReservedMixedAttributeValue hresult(ptr*);" & "ElementFromIAccessible hresult(idispatch;int;ptr*);" & "ElementFromIAccessibleBuildCache hresult(iaccessible;int;ptr;ptr*);"
Global Const $dtag_IUIAutomation2 = $dtag_IUIAutomation & "get_AutoSetFocus hresult(bool*);" & "put_AutoSetFocus hresult(bool);" & "get_ConnectionTimeout hresult(dword*);" & "put_ConnectionTimeout hresult(dword);" & "get_TransactionTimeout hresult(dword*);" & "put_TransactionTimeout hresult(dword);"
Global Const $dtag_IUIAutomation3 = $dtag_IUIAutomation2 & "AddTextEditTextChangedEventHandler hresult(ptr;long;long;ptr;ptr);" & "RemoveTextEditTextChangedEventHandler hresult(ptr;ptr);"
Global Const $dtag_IUIAutomation4 = $dtag_IUIAutomation3 & "AddChangesEventHandler hresult(ptr;long;ptr;int;ptr;ptr);" & "RemoveChangesEventHandler hresult(ptr;ptr);"
Global Const $sIID_IUIAutomation5 = "{25F700C8-D816-4057-A9DC-3CBDEE77E256}"
Global Const $dtag_IUIAutomation5 = $dtag_IUIAutomation4 & "AddNotificationEventHandler hresult(ptr;long;ptr;ptr);" & "RemoveNotificationEventHandler hresult(ptr;ptr);"
Global Const $dtag_IUIAutomationElement = "SetFocus hresult();" & "GetRuntimeId hresult(ptr*);" & "FindFirst hresult(long;ptr;ptr*);" & "FindAll hresult(long;ptr;ptr*);" & "FindFirstBuildCache hresult(long;ptr;ptr;ptr*);" & "FindAllBuildCache hresult(long;ptr;ptr;ptr*);" & "BuildUpdatedCache hresult(ptr;ptr*);" & "GetCurrentPropertyValue hresult(int;variant*);" & "GetCurrentPropertyValueEx hresult(int;long;variant*);" & "GetCachedPropertyValue hresult(int;variant*);" & "GetCachedPropertyValueEx hresult(int;long;variant*);" & "GetCurrentPatternAs hresult(int;none;none*);" & "GetCachedPatternAs hresult(int;none;none*);" & "GetCurrentPattern hresult(int;ptr*);" & "GetCachedPattern hresult(int;ptr*);" & "GetCachedParent hresult(ptr*);" & "GetCachedChildren hresult(ptr*);" & "CurrentProcessId hresult(int*);" & "CurrentControlType hresult(int*);" & "CurrentLocalizedControlType hresult(bstr*);" & "CurrentName hresult(bstr*);" & "CurrentAcceleratorKey hresult(bstr*);" & "CurrentAccessKey hresult(bstr*);" & "CurrentHasKeyboardFocus hresult(long*);" & "CurrentIsKeyboardFocusable hresult(long*);" & "CurrentIsEnabled hresult(long*);" & "CurrentAutomationId hresult(bstr*);" & "CurrentClassName hresult(bstr*);" & "CurrentHelpText hresult(bstr*);" & "CurrentCulture hresult(int*);" & "CurrentIsControlElement hresult(long*);" & "CurrentIsContentElement hresult(long*);" & "CurrentIsPassword hresult(long*);" & "CurrentNativeWindowHandle hresult(hwnd*);" & "CurrentItemType hresult(bstr*);" & "CurrentIsOffscreen hresult(long*);" & "CurrentOrientation hresult(long*);" & "CurrentFrameworkId hresult(bstr*);" & "CurrentIsRequiredForForm hresult(long*);" & "CurrentItemStatus hresult(bstr*);" & "CurrentBoundingRectangle hresult(struct*);" & "CurrentLabeledBy hresult(ptr*);" & "CurrentAriaRole hresult(bstr*);" & "CurrentAriaProperties hresult(bstr*);" & "CurrentIsDataValidForForm hresult(long*);" & "CurrentControllerFor hresult(ptr*);" & "CurrentDescribedBy hresult(ptr*);" & "CurrentFlowsTo hresult(ptr*);" & "CurrentProviderDescription hresult(bstr*);" & "CachedProcessId hresult(int*);" & "CachedControlType hresult(int*);" & "CachedLocalizedControlType hresult(bstr*);" & "CachedName hresult(bstr*);" & "CachedAcceleratorKey hresult(bstr*);" & "CachedAccessKey hresult(bstr*);" & "CachedHasKeyboardFocus hresult(long*);" & "CachedIsKeyboardFocusable hresult(long*);" & "CachedIsEnabled hresult(long*);" & "CachedAutomationId hresult(bstr*);" & "CachedClassName hresult(bstr*);" & "CachedHelpText hresult(bstr*);" & "CachedCulture hresult(int*);" & "CachedIsControlElement hresult(long*);" & "CachedIsContentElement hresult(long*);" & "CachedIsPassword hresult(long*);" & "CachedNativeWindowHandle hresult(hwnd*);" & "CachedItemType hresult(bstr*);" & "CachedIsOffscreen hresult(long*);" & "CachedOrientation hresult(long*);" & "CachedFrameworkId hresult(bstr*);" & "CachedIsRequiredForForm hresult(long*);" & "CachedItemStatus hresult(bstr*);" & "CachedBoundingRectangle hresult(struct*);" & "CachedLabeledBy hresult(ptr*);" & "CachedAriaRole hresult(bstr*);" & "CachedAriaProperties hresult(bstr*);" & "CachedIsDataValidForForm hresult(long*);" & "CachedControllerFor hresult(ptr*);" & "CachedDescribedBy hresult(ptr*);" & "CachedFlowsTo hresult(ptr*);" & "CachedProviderDescription hresult(bstr*);" & "GetClickablePoint hresult(struct*;long*);"
Global Const $dtag_IUIAutomationElement2 = $dtag_IUIAutomationElement & "get_CurrentOptimizeForVisualContent hresult(bool*);" & "get_CachedOptimizeForVisualContent hresult(bool*);" & "get_CurrentLiveSetting hresult(long*);" & "get_CachedLiveSetting hresult(long*);" & "get_CurrentFlowsFrom hresult(ptr*);" & "get_CachedFlowsFrom hresult(ptr*);"
Global Const $dtag_IUIAutomationElement3 = $dtag_IUIAutomationElement2 & "ShowContextMenu hresult();" & "get_CurrentIsPeripheral hresult(bool*);" & "get_CachedIsPeripheral hresult(bool*);"
Global Const $dtag_IUIAutomationElement4 = $dtag_IUIAutomationElement3 & "get_CurrentPositionInSet hresult(int*);" & "get_CurrentSizeOfSet hresult(int*);" & "get_CurrentLevel hresult(int*);" & "get_CurrentAnnotationTypes hresult(ptr*);" & "get_CurrentAnnotationObjects hresult(ptr*);" & "get_CachedPositionInSet hresult(int*);" & "get_CachedSizeOfSet hresult(int*);" & "get_CachedLevel hresult(int*);" & "get_CachedAnnotationTypes hresult(ptr*);" & "get_CachedAnnotationObjects hresult(ptr*);"
Global Const $dtag_IUIAutomationElement5 = $dtag_IUIAutomationElement4 & "get_CurrentLandmarkType hresult(long*);" & "get_CurrentLocalizedLandmarkType hresult(bstr*);" & "get_CachedLandmarkType hresult(long*);" & "get_CachedLocalizedLandmarkType hresult(bstr*);"
Global Const $dtag_IUIAutomationElement6 = $dtag_IUIAutomationElement5 & "get_CurrentFullDescription hresult(bstr*);" & "get_CachedFullDescription hresult(bstr*);"
Global Const $dtag_IUIAutomationElement7 = $dtag_IUIAutomationElement6 & "FindFirstWithOptions hresult(long;ptr;long;ptr;ptr*);" & "FindAllWithOptions hresult(long;ptr;long;ptr;ptr*);" & "FindFirstWithOptionsBuildCache hresult(long;ptr;ptr;long;ptr;ptr*);" & "FindAllWithOptionsBuildCache hresult(long;ptr;ptr;long;ptr;ptr*);" & "GetCurrentMetadataValue hresult(int;long;variant*);"
Global Const $sIID_IUIAutomationElement8 = "{8C60217D-5411-4CDE-BCC0-1CEDA223830C}"
Global Const $dtag_IUIAutomationElement8 = $dtag_IUIAutomationElement7 & "get_CurrentHeadingLevel hresult(long*);" & "get_CachedHeadingLevel hresult(long*);"
Global Const $dtag_IUIAutomationElementArray = "Length hresult(int*);" & "GetElement hresult(int;ptr*);"
Global Const $dtag_IUIAutomationAndCondition = "ChildCount hresult(int*);" & "GetChildrenAsNativeArray hresult(ptr*;int*);" & "GetChildren hresult(ptr*);"
Global Const $dtag_IUIAutomationBoolCondition = "BooleanValue hresult(long*);"
Global Const $dtag_IUIAutomationNotCondition = "GetChild hresult(ptr*);"
Global Const $dtag_IUIAutomationOrCondition = "ChildCount hresult(int*);" & "GetChildrenAsNativeArray hresult(ptr*;int*);" & "GetChildren hresult(ptr*);"
Global Const $dtag_IUIAutomationPropertyCondition = "propertyId hresult(int*);" & "PropertyValue hresult(variant*);" & "PropertyConditionFlags hresult(long*);"
Global Const $dtag_IUIAutomationAnnotationPattern = "get_CurrentAnnotationTypeId hresult(int*);" & "get_CurrentAnnotationTypeName hresult(bstr*);" & "get_CurrentAuthor hresult(bstr*);" & "get_CurrentDateTime hresult(bstr*);" & "get_CurrentTarget hresult(ptr*);" & "get_CachedAnnotationTypeId hresult(int*);" & "get_CachedAnnotationTypeName hresult(bstr*);" & "get_CachedAuthor hresult(bstr*);" & "get_CachedDateTime hresult(bstr*);" & "get_CachedTarget hresult(ptr*);"
Global Const $dtag_IUIAutomationCustomNavigationPattern = "Navigate hresult(long;ptr*);"
Global Const $dtag_IUIAutomationDockPattern = "SetDockPosition hresult(long);" & "CurrentDockPosition hresult(long*);" & "CachedDockPosition hresult(long*);"
Global Const $dtag_IUIAutomationDragPattern = "get_CurrentIsGrabbed hresult(bool*);" & "get_CachedIsGrabbed hresult(bool*);" & "get_CurrentDropEffect hresult(bstr*);" & "get_CachedDropEffect hresult(bstr*);" & "get_CurrentDropEffects hresult(ptr*);" & "get_CachedDropEffects hresult(ptr*);" & "GetCurrentGrabbedItems hresult(ptr*);" & "GetCachedGrabbedItems hresult(ptr*);"
Global Const $dtag_IUIAutomationDropTargetPattern = "get_CurrentDropTargetEffect hresult(bstr*);" & "get_CachedDropTargetEffect hresult(bstr*);" & "get_CurrentDropTargetEffects hresult(ptr*);" & "get_CachedDropTargetEffects hresult(ptr*);"
Global Const $dtag_IUIAutomationExpandCollapsePattern = "Expand hresult();" & "Collapse hresult();" & "CurrentExpandCollapseState hresult(long*);" & "CachedExpandCollapseState hresult(long*);"
Global Const $dtag_IUIAutomationGridPattern = "GetItem hresult(int;int;ptr*);" & "CurrentRowCount hresult(int*);" & "CurrentColumnCount hresult(int*);" & "CachedRowCount hresult(int*);" & "CachedColumnCount hresult(int*);"
Global Const $dtag_IUIAutomationGridItemPattern = "CurrentContainingGrid hresult(ptr*);" & "CurrentRow hresult(int*);" & "CurrentColumn hresult(int*);" & "CurrentRowSpan hresult(int*);" & "CurrentColumnSpan hresult(int*);" & "CachedContainingGrid hresult(ptr*);" & "CachedRow hresult(int*);" & "CachedColumn hresult(int*);" & "CachedRowSpan hresult(int*);" & "CachedColumnSpan hresult(int*);"
Global Const $sIID_IUIAutomationInvokePattern = "{FB377FBE-8EA6-46D5-9C73-6499642D3059}"
Global Const $dtag_IUIAutomationInvokePattern = "Invoke hresult();"
Global Const $dtag_IUIAutomationItemContainerPattern = "FindItemByProperty hresult(ptr;int;variant;ptr*);"
Global Const $dtag_IUIAutomationLegacyIAccessiblePattern = "Select hresult(long);" & "DoDefaultAction hresult();" & "SetValue hresult(wstr);" & "CurrentChildId hresult(int*);" & "CurrentName hresult(bstr*);" & "CurrentValue hresult(bstr*);" & "CurrentDescription hresult(bstr*);" & "CurrentRole hresult(uint*);" & "CurrentState hresult(uint*);" & "CurrentHelp hresult(bstr*);" & "CurrentKeyboardShortcut hresult(bstr*);" & "GetCurrentSelection hresult(ptr*);" & "CurrentDefaultAction hresult(bstr*);" & "CachedChildId hresult(int*);" & "CachedName hresult(bstr*);" & "CachedValue hresult(bstr*);" & "CachedDescription hresult(bstr*);" & "CachedRole hresult(uint*);" & "CachedState hresult(uint*);" & "CachedHelp hresult(bstr*);" & "CachedKeyboardShortcut hresult(bstr*);" & "GetCachedSelection hresult(ptr*);" & "CachedDefaultAction hresult(bstr*);" & "GetIAccessible hresult(idispatch*);"
Global Const $dtag_IAccessible = "GetTypeInfoCount hresult(uint*);" & "GetTypeInfo hresult(uint;int;ptr*);" & "GetIDsOfNames hresult(struct*;wstr;uint;int;int);" & "Invoke hresult(int;struct*;int;word;ptr*;ptr*;ptr*;uint*);" & "get_accParent hresult(ptr*);" & "get_accChildCount hresult(long*);" & "get_accChild hresult(variant;idispatch*);" & "get_accName hresult(variant;bstr*);" & "get_accValue hresult(variant;bstr*);" & "get_accDescription hresult(variant;bstr*);" & "get_accRole hresult(variant;variant*);" & "get_accState hresult(variant;variant*);" & "get_accHelp hresult(variant;bstr*);" & "get_accHelpTopic hresult(bstr*;variant;long*);" & "get_accKeyboardShortcut hresult(variant;bstr*);" & "get_accFocus hresult(struct*);" & "get_accSelection hresult(variant*);" & "get_accDefaultAction hresult(variant;bstr*);" & "accSelect hresult(long;variant);" & "accLocation hresult(long*;long*;long*;long*;variant);" & "accNavigate hresult(long;variant;variant*);" & "accHitTest hresult(long;long;variant*);" & "accDoDefaultAction hresult(variant);" & "put_accName hresult(variant;bstr);" & "put_accValue hresult(variant;bstr);"
Global Const $dtag_IUIAutomationMultipleViewPattern = "GetViewName hresult(int;bstr*);" & "SetCurrentView hresult(int);" & "CurrentCurrentView hresult(int*);" & "GetCurrentSupportedViews hresult(ptr*);" & "CachedCurrentView hresult(int*);" & "GetCachedSupportedViews hresult(ptr*);"
Global Const $dtag_IUIAutomationObjectModelPattern = "GetUnderlyingObjectModel hresult(ptr*);"
Global Const $dtag_IUIAutomationRangeValuePattern = "SetValue hresult(ushort);" & "CurrentValue hresult(ushort*);" & "CurrentIsReadOnly hresult(long*);" & "CurrentMaximum hresult(ushort*);" & "CurrentMinimum hresult(ushort*);" & "CurrentLargeChange hresult(ushort*);" & "CurrentSmallChange hresult(ushort*);" & "CachedValue hresult(ushort*);" & "CachedIsReadOnly hresult(long*);" & "CachedMaximum hresult(ushort*);" & "CachedMinimum hresult(ushort*);" & "CachedLargeChange hresult(ushort*);" & "CachedSmallChange hresult(ushort*);"
Global Const $dtag_IUIAutomationScrollPattern = "Scroll hresult(long;long);" & "SetScrollPercent hresult(double;double);" & "CurrentHorizontalScrollPercent hresult(double*);" & "CurrentVerticalScrollPercent hresult(double*);" & "CurrentHorizontalViewSize hresult(double*);" & "CurrentVerticalViewSize hresult(double*);" & "CurrentHorizontallyScrollable hresult(long*);" & "CurrentVerticallyScrollable hresult(long*);" & "CachedHorizontalScrollPercent hresult(double*);" & "CachedVerticalScrollPercent hresult(double*);" & "CachedHorizontalViewSize hresult(double*);" & "CachedVerticalViewSize hresult(double*);" & "CachedHorizontallyScrollable hresult(long*);" & "CachedVerticallyScrollable hresult(long*);"
Global Const $dtag_IUIAutomationScrollItemPattern = "ScrollIntoView hresult();"
Global Const $dtag_IUIAutomationSelectionPattern = "GetCurrentSelection hresult(ptr*);" & "CurrentCanSelectMultiple hresult(long*);" & "CurrentIsSelectionRequired hresult(long*);" & "GetCachedSelection hresult(ptr*);" & "CachedCanSelectMultiple hresult(long*);" & "CachedIsSelectionRequired hresult(long*);"
Global Const $sIID_IUIAutomationSelectionItemPattern = "{A8EFA66A-0FDA-421A-9194-38021F3578EA}"
Global Const $dtag_IUIAutomationSelectionItemPattern = "Select hresult();" & "AddToSelection hresult();" & "RemoveFromSelection hresult();" & "CurrentIsSelected hresult(long*);" & "CurrentSelectionContainer hresult(ptr*);" & "CachedIsSelected hresult(long*);" & "CachedSelectionContainer hresult(ptr*);"
Global Const $dtag_IUIAutomationSelectionPattern2 = $dtag_IUIAutomationSelectionPattern & "get_CurrentFirstSelectedItem hresult(ptr*);" & "get_CurrentLastSelectedItem hresult(ptr*);" & "get_CurrentCurrentSelectedItem hresult(ptr*);" & "get_CurrentItemCount hresult(int*);" & "get_CachedFirstSelectedItem hresult(ptr*);" & "get_CachedLastSelectedItem hresult(ptr*);" & "get_CachedCurrentSelectedItem hresult(ptr*);" & "get_CachedItemCount hresult(int*);"
Global Const $dtag_IUIAutomationSpreadsheetPattern = "GetItemByName hresult(bstr;ptr*);"
Global Const $dtag_IUIAutomationSpreadsheetItemPattern = "get_CurrentFormula hresult(bstr*);" & "GetCurrentAnnotationObjects hresult(ptr*);" & "GetCurrentAnnotationTypes hresult(ptr*);" & "get_CachedFormula hresult(bstr*);" & "GetCachedAnnotationObjects hresult(ptr*);" & "GetCachedAnnotationTypes hresult(ptr*);"
Global Const $dtag_IUIAutomationStylesPattern = "get_CurrentStyleId hresult(int*);" & "get_CurrentStyleName hresult(bstr*);" & "get_CurrentFillColor hresult(int*);" & "get_CurrentFillPatternStyle hresult(bstr*);" & "get_CurrentShape hresult(bstr*);" & "get_CurrentFillPatternColor hresult(int*);" & "get_CurrentExtendedProperties hresult(bstr*);" & "GetCurrentExtendedPropertiesAsArray hresult(struct*;int*);" & "get_CachedStyleId hresult(int*);" & "get_CachedStyleName hresult(bstr*);" & "get_CachedFillColor hresult(int*);" & "get_CachedFillPatternStyle hresult(bstr*);" & "get_CachedShape hresult(bstr*);" & "get_CachedFillPatternColor hresult(int*);" & "get_CachedExtendedProperties hresult(bstr*);" & "GetCachedExtendedPropertiesAsArray hresult(struct*;int*);"
Global Const $dtag_IUIAutomationSynchronizedInputPattern = "StartListening hresult(long);" & "Cancel hresult();"
Global Const $dtag_IUIAutomationTablePattern = "GetCurrentRowHeaders hresult(ptr*);" & "GetCurrentColumnHeaders hresult(ptr*);" & "CurrentRowOrColumnMajor hresult(long*);" & "GetCachedRowHeaders hresult(ptr*);" & "GetCachedColumnHeaders hresult(ptr*);" & "CachedRowOrColumnMajor hresult(long*);"
Global Const $dtag_IUIAutomationTableItemPattern = "GetCurrentRowHeaderItems hresult(ptr*);" & "GetCurrentColumnHeaderItems hresult(ptr*);" & "GetCachedRowHeaderItems hresult(ptr*);" & "GetCachedColumnHeaderItems hresult(ptr*);"
Global Const $dtag_IUIAutomationTextChildPattern = "get_TextContainer hresult(ptr*);" & "get_TextRange hresult(ptr*);"
Global Const $dtag_IUIAutomationTextPattern = "RangeFromPoint hresult(struct;ptr*);" & "RangeFromChild hresult(ptr;ptr*);" & "GetSelection hresult(ptr*);" & "GetVisibleRanges hresult(ptr*);" & "DocumentRange hresult(ptr*);" & "SupportedTextSelection hresult(long*);"
Global Const $dtag_IUIAutomationTextPattern2 = $dtag_IUIAutomationTextPattern & "RangeFromAnnotation hresult(ptr;ptr*);" & "GetCaretRange hresult(bool;ptr*);"
Global Const $dtag_IUIAutomationTextEditPattern = $dtag_IUIAutomationTextPattern & "GetActiveComposition hresult(ptr*);" & "GetConversionTarget hresult(ptr*);"
Global Const $dtag_IUIAutomationTextRange = "Clone hresult(ptr*);" & "Compare hresult(ptr;long*);" & "CompareEndpoints hresult(long;ptr;long;int*);" & "ExpandToEnclosingUnit hresult(long);" & "FindAttribute hresult(int;variant;long;ptr*);" & "FindText hresult(bstr;long;long;ptr*);" & "GetAttributeValue hresult(int;variant*);" & "GetBoundingRectangles hresult(ptr*);" & "GetEnclosingElement hresult(ptr*);" & "GetText hresult(int;bstr*);" & "Move hresult(long;int;int*);" & "MoveEndpointByUnit hresult(long;long;int;int*);" & "MoveEndpointByRange hresult(long;ptr;long);" & "Select hresult();" & "AddToSelection hresult();" & "RemoveFromSelection hresult();" & "ScrollIntoView hresult(long);" & "GetChildren hresult(ptr*);"
Global Const $dtag_IUIAutomationTextRange2 = $dtag_IUIAutomationTextRange & "ShowContextMenu hresult();"
Global Const $dtag_IUIAutomationTextRange3 = $dtag_IUIAutomationTextRange2 & "GetEnclosingElementBuildCache hresult(ptr;ptr*);" & "GetChildrenBuildCache hresult(ptr;ptr*);" & "GetAttributeValues hresult(long;int;ptr*);"
Global Const $dtag_IUIAutomationTextRangeArray = "Length hresult(int*);" & "GetElement hresult(int;ptr*);"
Global Const $dtag_IUIAutomationTogglePattern = "Toggle hresult();" & "CurrentToggleState hresult(long*);" & "CachedToggleState hresult(long*);"
Global Const $dtag_IUIAutomationTransformPattern = "Move hresult(double;double);" & "Resize hresult(double;double);" & "Rotate hresult(double);" & "CurrentCanMove hresult(long*);" & "CurrentCanResize hresult(long*);" & "CurrentCanRotate hresult(long*);" & "CachedCanMove hresult(long*);" & "CachedCanResize hresult(long*);" & "CachedCanRotate hresult(long*);"
Global Const $dtag_IUIAutomationTransformPattern2 = $dtag_IUIAutomationTransformPattern & "Zoom hresult(double);" & "ZoomByUnit hresult(long);" & "get_CurrentCanZoom hresult(bool*);" & "get_CachedCanZoom hresult(bool*);" & "get_CurrentZoomLevel hresult(double*);" & "get_CachedZoomLevel hresult(double*);" & "get_CurrentZoomMinimum hresult(double*);" & "get_CachedZoomMinimum hresult(double*);" & "get_CurrentZoomMaximum hresult(double*);" & "get_CachedZoomMaximum hresult(double*);"
Global Const $dtag_IUIAutomationValuePattern = "SetValue hresult(bstr);" & "CurrentValue hresult(bstr*);" & "CurrentIsReadOnly hresult(long*);" & "CachedValue hresult(bstr*);" & "CachedIsReadOnly hresult(long*);"
Global Const $dtag_IUIAutomationVirtualizedItemPattern = "Realize hresult();"
Global Const $dtag_IUIAutomationWindowPattern = "Close hresult();" & "WaitForInputIdle hresult(int;long*);" & "SetWindowVisualState hresult(long);" & "CurrentCanMaximize hresult(long*);" & "CurrentCanMinimize hresult(long*);" & "CurrentIsModal hresult(long*);" & "CurrentIsTopmost hresult(long*);" & "CurrentWindowVisualState hresult(long*);" & "CurrentWindowInteractionState hresult(long*);" & "CachedCanMaximize hresult(long*);" & "CachedCanMinimize hresult(long*);" & "CachedIsModal hresult(long*);" & "CachedIsTopmost hresult(long*);" & "CachedWindowVisualState hresult(long*);" & "CachedWindowInteractionState hresult(long*);"
Global Const $dtag_IUIAutomationEventHandler = "HandleAutomationEvent hresult(ptr;int);"
Global Const $dtag_IUIAutomationFocusChangedEventHandler = "HandleFocusChangedEvent hresult(ptr);"
Global Const $dtag_IUIAutomationPropertyChangedEventHandler = "HandlePropertyChangedEvent hresult(ptr;int;variant);"
Global Const $dtag_IUIAutomationStructureChangedEventHandler = "HandleStructureChangedEvent hresult(ptr;long;ptr);"
Global Const $dtag_IUIAutomationTextEditTextChangedEventHandler = "HandleTextEditTextChangedEvent hresult(ptr;long;ptr);"
Global Const $dtag_IUIAutomationChangesEventHandler = "HandleChangesEvent hresult(ptr;struct;int);"
Global Const $dtag_IUIAutomationNotificationEventHandler = "HandleNotificationEvent hresult(ptr;long;long;bstr;bstr);"
Global Const $dtag_IUIAutomationCacheRequest = "AddProperty hresult(int);" & "AddPattern hresult(int);" & "Clone hresult(ptr*);" & "get_TreeScope hresult(long*);" & "put_TreeScope hresult(long);" & "get_TreeFilter hresult(ptr*);" & "put_TreeFilter hresult(ptr);" & "get_AutomationElementMode hresult(long*);" & "put_AutomationElementMode hresult(long);"
Global Const $dtag_IUIAutomationTreeWalker = "GetParentElement hresult(ptr;ptr*);" & "GetFirstChildElement hresult(ptr;ptr*);" & "GetLastChildElement hresult(ptr;ptr*);" & "GetNextSiblingElement hresult(ptr;ptr*);" & "GetPreviousSiblingElement hresult(ptr;ptr*);" & "NormalizeElement hresult(ptr;ptr*);" & "GetParentElementBuildCache hresult(ptr;ptr;ptr*);" & "GetFirstChildElementBuildCache hresult(ptr;ptr;ptr*);" & "GetLastChildElementBuildCache hresult(ptr;ptr;ptr*);" & "GetNextSiblingElementBuildCache hresult(ptr;ptr;ptr*);" & "GetPreviousSiblingElementBuildCache hresult(ptr;ptr;ptr*);" & "NormalizeElementBuildCache hresult(ptr;ptr;ptr*);" & "Condition hresult(ptr*);"
Global Const $dtag_IRawElementProviderSimple = "ProviderOptions hresult(long*);" & "GetPatternProvider hresult(int;ptr*);" & "GetPropertyValue hresult(int;variant*);" & "HostRawElementProvider hresult(ptr*);"
Global Const $dtag_IUIAutomationProxyFactory = "CreateProvider hresult(hwnd;long;long;ptr*);" & "ProxyFactoryId hresult(bstr*);"
Global Const $dtag_IUIAutomationProxyFactoryEntry = "ProxyFactory hresult(ptr*);" & "ClassName hresult(bstr*);" & "ImageName hresult(bstr*);" & "AllowSubstringMatch hresult(long*);" & "CanCheckBaseClass hresult(long*);" & "NeedsAdviseEvents hresult(long*);" & "ClassName hresult(wstr);" & "ImageName hresult(wstr);" & "AllowSubstringMatch hresult(long);" & "CanCheckBaseClass hresult(long);" & "NeedsAdviseEvents hresult(long);" & "SetWinEventsForAutomationEvent hresult(int;int;ptr);" & "GetWinEventsForAutomationEvent hresult(int;int;ptr*);"
Global Const $dtag_IUIAutomationProxyFactoryMapping = "Count hresult(uint*);" & "GetTable hresult(ptr*);" & "GetEntry hresult(uint;ptr*);" & "SetTable hresult(ptr);" & "InsertEntries hresult(uint;ptr);" & "InsertEntry hresult(uint;ptr);" & "RemoveEntry hresult(uint);" & "ClearTable hresult();" & "RestoreDefaultTable hresult();"
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $STR_STRIPLEADING = 1
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
Opt("MustDeclareVars", 1)
Global $oUIAutomation, $oDesktop, $oWindow1, $oList1, $oListItem1
Global $passedVar
_ArrayDelete($CmdLine, 0)
For $i = 0 To UBound($CmdLine) - 1
$passedVar = $passedVar & " " & $CmdLine[$i]
Next
$passedVar = StringStripWS($passedVar, $STR_STRIPLEADING)
$passedVar = $passedVar & " "
ClickBoth($passedVar)
Func ClickBoth($Whattoclick2)
$oUIAutomation = ObjCreateInterface($sCLSID_CUIAutomation8, $sIID_IUIAutomation5, $dtag_IUIAutomation5)
ConsoleWrite("$oUIAutomation OK - Aka Startup" & @CRLF)
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
EndFunc
