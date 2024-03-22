//%attributes = {"invisible":true}
//Method: DEV_GetFormObjects
//Description
//
// Parameters
// $1 : $FormName_txt
// $2 : $TableNumber_L
// #3 : $objecttoLoad_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousaki
	//User (4D) : Designer
	//Date and time: 06/28/18, 10:02:38
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06
	
	// usage :
	//FORM LOAD([Table];$formnames_atxt{$loop_L})
	//C_OBJECT($FormObjects_o)
	//CLEAR VARIABLE($FormObjects_o)
	//DEV_GetFormObjects ($formnames_atxt{$loop_L};Table(->[Table]);->$FormObjects_o)
	
	C_TEXT:C284(DEV_GetFormObjects; $1)
	C_LONGINT:C283(DEV_GetFormObjects; $2)
	C_POINTER:C301(DEV_GetFormObjects; $3)
End if 
//

//---------- Type Parameters & Local Variables ----------
ARRAY LONGINT:C221($_aL_FormEvents; 0)
ARRAY LONGINT:C221($_aL_PagesArray; 0)
ARRAY OBJECT:C1221($_aObj_FormObjects; 0)
ARRAY POINTER:C280($_ptr_VariablesArray; 0)
ARRAY TEXT:C222($_aT_EnabledFormEvents; 0)
ARRAY TEXT:C222($_aT_EnabledObjectEvents; 0)
ARRAY TEXT:C222($_aT_ObjectsArray; 0)
C_BOOLEAN:C305($_bo_AppendtoName; $_Bo_AutoDraggable; $_Bo_automaticDrop; $_Bo_Draggable; $_Bo_Droppable; $_Bo_FixedHeight; $_Bo_FixedWidth; $_Bo_FocusRectangleVIsible; $_Bo_HasAlignment; $_Bo_HasDataSource; $_Bo_HasFont)
C_BOOLEAN:C305($_Bo_hResize; $_Bo_isThreeStateCB; $_Bo_ObjectAutoSpellCheck; $_Bo_ObjectEnabled; $_Bo_ObjectEnterable; $_Bo_ObjectHasContextMenu; $_Bo_ObjectisStyledText; $_Bo_ObjectisVIsible; $_Bo_PrintVarFrame; $_Bo_ScrollBarAvailable; $_Bo_VisibleHScroll)
C_BOOLEAN:C305($_Bo_VisibleVScroll; $_Bo_vResize; CORE_bo_GetFormObject)
C_LONGINT:C283($_L_altBackGroundColour; $_L_BackgroundColour; $_L_BorderLineStyle; $_l_FieldNumber; $_L_FixedSubform; $_L_FontSize; $_L_FontStyle; $_L_ForegroundColour; $_l_FormHeight; $_l_FormWIdth; $_L_HorizontalResizing)
C_LONGINT:C283($_L_index; $_L_index2; $_l_IndexRef; $_L_Indicator; $_L_ListReference; $_l_lOBottom; $_l_lOLeft; $_l_lORight; $_l_lOTop; $_L_lSHortcutModifier; $_L_MaxHeight)
C_LONGINT:C283($_L_MaxWidth; $_L_minHeight; $_L_MultiLine; $_L_mWidth; $_L_NonInvertObjects; $_L_NumPages; $_L_ObjectAlignment; $_L_ObjectMaximumValue; $_L_ObjectMimimumValue; $_L_ObjectOrientation; $_L_objectType)
C_LONGINT:C283($_L_Selector; $_L_SubformHeight; $_L_SubformWidth; $_L_TableNum; $_L_verticalAlignment; $_L_VerticalResizing; $2)
C_OBJECT:C1216($_Obj_ObjectObject)
C_POINTER:C301($_Ptr_ptrToSourceObject; $_Ptr_SubformTable; $_Ptr_TablePointer)
C_TEXT:C284($_t_DetailSubform; $_t_ListSubform; $_Txt_altBackGroundColour; $_Txt_BackGroundColour; $_Txt_BorderLinestyle; $_Txt_ButtonText; $_Txt_DisplayFormat; $_Txt_FilterName; $_Txt_FontName; $_Txt_FontStyleName; $_Txt_ForegroundColour)
C_TEXT:C284($_Txt_FormName; $_Txt_FormTitle; $_Txt_HelpText; $_Txt_HorizontalResizing; $_Txt_Indicator; $_Txt_InputSuformObjectName; $_Txt_Keyboard; $_Txt_ListName; $_Txt_MenuBarReference; $_Txt_MultiLineName; $_Txt_ObjectStyleSheet)
C_TEXT:C284($_Txt_objectType; $_Txt_OjbectAlignment; $_Txt_OutputSuformObjectName; $_Txt_Placeholder; $_Txt_ShortcutKey; $_Txt_StandardAction; $_Txt_SubformOption; $_Txt_VariableName; $_Txt_VerticalAlignment; $_Txt_VerticalResizing; $1)
C_TEXT:C284(CORE_T_ParseFormName)
C_TEXT:C284($1)
C_LONGINT:C283($2)

ARRAY LONGINT:C221($_aL_FormEvents; 0)
ARRAY LONGINT:C221($_aL_PagesArray; 0)
ARRAY OBJECT:C1221($_aObj_FormObjects; 0)
ARRAY TEXT:C222($_aT_EnabledFormEvents; 0)
ARRAY TEXT:C222($_aT_EnabledObjectEvents; 0)
ARRAY TEXT:C222($_aT_ObjectsArray; 0)
C_BOOLEAN:C305($_Bo_AutoDraggable)
C_BOOLEAN:C305($_Bo_automaticDrop)
C_BOOLEAN:C305($_Bo_Draggable)
C_BOOLEAN:C305($_Bo_Droppable)
C_BOOLEAN:C305($_Bo_FixedHeight)
C_BOOLEAN:C305($_Bo_FixedWidth)
C_BOOLEAN:C305($_Bo_FocusRectangleVIsible)
C_BOOLEAN:C305($_Bo_HasAlignment)
C_BOOLEAN:C305($_Bo_HasDataSource)
C_BOOLEAN:C305($_Bo_HasFont)
C_BOOLEAN:C305($_Bo_hResize)
C_BOOLEAN:C305($_Bo_isThreeStateCB)
C_BOOLEAN:C305($_Bo_ObjectAutoSpellCheck)
C_BOOLEAN:C305($_Bo_ObjectEnabled)
C_BOOLEAN:C305($_Bo_ObjectEnterable)
C_BOOLEAN:C305($_Bo_ObjectHasContextMenu)
C_BOOLEAN:C305($_Bo_ObjectisStyledText)
C_BOOLEAN:C305($_Bo_ObjectisVIsible)
C_BOOLEAN:C305($_Bo_PrintVarFrame)
C_BOOLEAN:C305($_Bo_ScrollBarAvailable)
C_BOOLEAN:C305($_Bo_VisibleHScroll)
C_BOOLEAN:C305($_Bo_VisibleVScroll)
C_BOOLEAN:C305($_Bo_vResize)
C_LONGINT:C283($_L_altBackGroundColour)
C_LONGINT:C283($_L_BackgroundColour)
C_LONGINT:C283($_L_BorderLineStyle)
C_LONGINT:C283($_L_FixedSubform)
C_LONGINT:C283($_L_FontSize)
C_LONGINT:C283($_L_FontStyle)
C_LONGINT:C283($_L_ForegroundColour)
C_LONGINT:C283($_L_HorizontalResizing)
C_LONGINT:C283($_L_index)
C_LONGINT:C283($_L_index2)
C_LONGINT:C283($_L_Indicator)
C_LONGINT:C283($_L_ListReference)
C_LONGINT:C283($_L_lSHortcutModifier)
C_LONGINT:C283($_L_MaxHeight)
C_LONGINT:C283($_L_MaxWidth)
C_LONGINT:C283($_L_minHeight)
C_LONGINT:C283($_L_MultiLine)
C_LONGINT:C283($_L_mWidth)
C_LONGINT:C283($_L_NonInvertObjects)
C_LONGINT:C283($_L_NumPages)
C_LONGINT:C283($_l_FieldNumber)
C_LONGINT:C283($_L_ObjectAlignment)
C_LONGINT:C283($_L_ObjectMaximumValue)
C_LONGINT:C283($_L_ObjectMimimumValue)
C_LONGINT:C283($_L_ObjectOrientation)
C_LONGINT:C283($_L_objectType)
C_LONGINT:C283($_L_Selector)
C_LONGINT:C283($_L_SubformHeight)
C_LONGINT:C283($_L_SubformWidth)
C_LONGINT:C283($_L_TableNum)
C_LONGINT:C283($_L_verticalAlignment)
C_LONGINT:C283($_L_VerticalResizing)
C_OBJECT:C1216($_Obj_ObjectObject)
C_POINTER:C301($_Ptr_ptrToSourceObject)
C_POINTER:C301($_Ptr_SubformTable)
C_POINTER:C301($_Ptr_TablePointer)
C_TEXT:C284($_Txt_altBackGroundColour)
C_TEXT:C284($_Txt_BackGroundColour)
C_TEXT:C284($_Txt_BorderLinestyle)
C_TEXT:C284($_Txt_ButtonText)
C_TEXT:C284($_Txt_DisplayFormat)
C_TEXT:C284($_Txt_FilterName)
C_TEXT:C284($_Txt_FontName)
C_TEXT:C284($_Txt_FontStyleName)
C_TEXT:C284($_Txt_ForegroundColour)
C_TEXT:C284($_Txt_HelpText)
C_TEXT:C284($_Txt_HorizontalResizing)
C_TEXT:C284($_Txt_Indicator)
C_TEXT:C284($_Txt_InputSuformObjectName)
C_TEXT:C284($_Txt_Keyboard)
C_TEXT:C284($_Txt_ListName)
C_TEXT:C284($_Txt_MenuBarReference)
C_TEXT:C284($_Txt_MultiLineName)
C_TEXT:C284($_Txt_ObjectStyleSheet)
C_TEXT:C284($_Txt_objectType)
C_TEXT:C284($_Txt_OjbectAlignment)
C_TEXT:C284($_Txt_OutputSuformObjectName)
C_TEXT:C284($_Txt_Placeholder)
C_TEXT:C284($_Txt_StandardAction)
C_TEXT:C284($_Txt_SubformOption)
C_TEXT:C284($_Txt_VariableName)
C_TEXT:C284($_Txt_VerticalAlignment)
C_TEXT:C284($_Txt_VerticalResizing)
C_TEXT:C284($_Txt_FormName)
C_TEXT:C284($_Txt_FormTitle)
C_TEXT:C284($_Txt_ShortcutKey)
C_TEXT:C284($1)
C_BOOLEAN:C305($_Bo_FixedHeight; $_Bo_Droppable; $_Bo_Draggable; $_Bo_hResize; $_Bo_AutoDraggable; $_Bo_FixedWidth; $_Bo_vResize; $_Bo_PrintVarFrame)
C_BOOLEAN:C305($_Bo_automaticDrop)
C_POINTER:C301($_Ptr_SubformTable)
C_LONGINT:C283($_L_MaxHeight; $_L_MaxWidth; $_L_minHeight; $_L_lSHortcutModifier; $_L_mWidth; $_L_NumPages; $_L_NonInvertObjects)
C_TEXT:C284($_Txt_FormTitle; $_Txt_FormName; $1; $_Txt_ShortcutKey)
//---------- Reassign Passed Parameters OR get values

$_Txt_FormName:=$1
CORE_T_ParseFormName:=$_Txt_FormName
C_POINTER:C301($_ptr_FormObject)
If ($2>0)
	$_Ptr_TablePointer:=Table:C252($2)
	
	FORM GET PROPERTIES:C674($_Ptr_TablePointer->; CORE_T_ParseFormName; $_l_FormWIdth; $_l_FormHeight; $_L_NumPages; $_Bo_FixedWidth; $_Bo_FixedHeight; $_Txt_FormTitle)
Else 
	FORM GET PROPERTIES:C674(CORE_T_ParseFormName; $_l_FormWIdth; $_l_FormHeight; $_L_NumPages; $_Bo_FixedWidth; $_Bo_FixedHeight; $_Txt_FormTitle)
End if 
If (Count parameters:C259>=3)
	$_ptr_FormObject:=$3
Else 
	C_OBJECT:C1216(CORE_ob_FormObject)
	CLEAR VARIABLE:C89(CORE_ob_FormObject)
	$_ptr_FormObject:=->CORE_ob_FormObject
End if 
If ($2>0)
	
	OB SET:C1220($_ptr_FormObject->; "Table Name"; Table name:C256($_Ptr_TablePointer))
End if 
OB SET:C1220($_ptr_FormObject->; "Form Name"; $_Txt_FormName)
OB SET:C1220($_ptr_FormObject->; "Number of Pages"; $_L_NumPages)
OB SET:C1220($_ptr_FormObject->; "Fixed Width"; $_Bo_FixedWidth)
OB SET:C1220($_ptr_FormObject->; "Fixed Height"; $_Bo_FixedHeight)
OB SET:C1220($_ptr_FormObject->; "Form Title"; $_Txt_FormTitle)
$_L_Selector:=0
If ($2>0)
	_O_FORM GET PARAMETER:C969($_Ptr_TablePointer->; CORE_T_ParseFormName; $_L_Selector; $_L_NonInvertObjects)
Else 
	_O_FORM GET PARAMETER:C969(CORE_T_ParseFormName; $_L_Selector; $_L_NonInvertObjects)
End if 
$_Txt_MenuBarReference:=Get menu bar reference:C979

OB SET:C1220($_ptr_FormObject->; "Form Menu"; $_Txt_MenuBarReference)
CORE_bo_GetFormObject:=True:C214

C_BOOLEAN:C305(CORE_bo_GetFormObject)
If (CORE_bo_GetFormObject)  //to prevent this being run accidently
	ARRAY LONGINT:C221($_aL_FormEvents; 0)
	OBJECT GET EVENTS:C1238(*; ""; $_aL_FormEvents)  //gets a list of the form events
	FORM GET VERTICAL RESIZING:C1078($_Bo_vResize; $_L_minHeight; $_L_MaxHeight)
	FORM GET HORIZONTAL RESIZING:C1077($_Bo_hResize; $_L_mWidth; $_L_MaxWidth)
	ARRAY TEXT:C222($_aT_EnabledFormEvents; 0)
	For ($_L_index; 1; Size of array:C274($_aL_FormEvents))
		Case of 
			: ($_aL_FormEvents{$_L_index}=On Load:K2:1)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On Load")
			: ($_aL_FormEvents{$_L_index}=On Page Change:K2:54)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On page change")
			: ($_aL_FormEvents{$_L_index}=On Validate:K2:3)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On Validate")
			: ($_aL_FormEvents{$_L_index}=On Clicked:K2:4)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On Clicked")
			: ($_aL_FormEvents{$_L_index}=On Double Clicked:K2:5)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On Double CLicked")
			: ($_aL_FormEvents{$_L_index}=On Outside Call:K2:11)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On outside Call")
			: ($_aL_FormEvents{$_L_index}=On Activate:K2:9)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On Activate")
			: ($_aL_FormEvents{$_L_index}=On Deactivate:K2:10)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On deactivate")
			: ($_aL_FormEvents{$_L_index}=On Getting Focus:K2:7)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On getting focus")
			: ($_aL_FormEvents{$_L_index}=On Losing Focus:K2:8)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On losing focus")
			: ($_aL_FormEvents{$_L_index}=On Begin Drag Over:K2:44)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On begin drag over")
			: ($_aL_FormEvents{$_L_index}=On Drag Over:K2:13)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On drag over")
			: ($_aL_FormEvents{$_L_index}=On Drop:K2:12)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On drop")
			: ($_aL_FormEvents{$_L_index}=On Before Keystroke:K2:6)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On before keystroke")
			: ($_aL_FormEvents{$_L_index}=On After Keystroke:K2:26)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On after keystroke")
			: ($_aL_FormEvents{$_L_index}=On Menu Selected:K2:14)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On menu selected")
			: ($_aL_FormEvents{$_L_index}=On Plug in Area:K2:16)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on Plug in area")
			: ($_aL_FormEvents{$_L_index}=On Data Change:K2:15)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on data change")
			: ($_aL_FormEvents{$_L_index}=On After Edit:K2:43)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on after edit")
			: ($_aL_FormEvents{$_L_index}=On Close Box:K2:21)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on close box")
			: ($_aL_FormEvents{$_L_index}=On Unload:K2:2)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on unload")
			: ($_aL_FormEvents{$_L_index}=On Timer:K2:25)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On timer")
			: ($_aL_FormEvents{$_L_index}=On Resize:K2:27)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On resize")
			: ($_aL_FormEvents{$_L_index}=On Selection Change:K2:29)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On selection change")
			: ($_aL_FormEvents{$_L_index}=On Mouse Enter:K2:33)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "on mouse enter")
			: ($_aL_FormEvents{$_L_index}=On Mouse Move:K2:35)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On mouse move")
			: ($_aL_FormEvents{$_L_index}=On Mouse Leave:K2:34)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On mouse leave")
			: ($_aL_FormEvents{$_L_index}=On Bound Variable Change:K2:52)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On bound variable change")
			: ($_aL_FormEvents{$_L_index}=_o_On Mac Toolbar Button:K2:53)
				APPEND TO ARRAY:C911($_aT_EnabledFormEvents; "On mac toolbar button")
		End case 
	End for 
	OB SET ARRAY:C1227($_ptr_FormObject->; "Active Form Events"; $_aT_EnabledFormEvents)
	ARRAY OBJECT:C1221($_aObj_FormObjects; 0)
	//the following form setting cannot be obtained in code
	//Markers
	//access
	//menu bar
	//print settings
	//appearance
	//form type
	//inherited form table
	//inherited form name
	//save geometry
	ARRAY POINTER:C280($_ptr_VariablesArray; 0)
	ARRAY LONGINT:C221($_aL_PagesArray; 0)
	FORM GET OBJECTS:C898($_aT_ObjectsArray; $_ptr_VariablesArray; $_aL_PagesArray)
	
	//There is is an object name problem with inherited forms. 
	//if an object name on the inherited form and on the inhereting form on page 0(inherited form is always included as part of page 0).
	//then we can get confused here and it causes the system to constantly confuse what it what.
	SORT ARRAY:C229($_aL_PagesArray; $_aT_ObjectsArray; $_ptr_VariablesArray)
	$_L_Indicator:=0
	$_Txt_Indicator:=""
	C_OBJECT:C1216($_Obj_ObjectObject)
	For ($_L_index; 1; Size of array:C274($_aT_ObjectsArray))
		$_bo_AppendtoName:=False:C215
		If ($_aL_PagesArray{$_L_index}=0)
			$_l_IndexRef:=Find in array:C230($_aT_ObjectsArray; $_aT_ObjectsArray{$_L_index})
			If ($_l_IndexRef<$_L_index)
				//This is second object with the same name as the inhereted form(it could be that this is the one on the inherited form)
				$_bo_AppendtoName:=True:C214
				//note that we can only have one repeated 
				
			End if 
		End if 
		CLEAR VARIABLE:C89($_Obj_ObjectObject)
		C_OBJECT:C1216($_Obj_ObjectObject)
		//Get the object type. and depending on the type get
		$_L_objectType:=OBJECT Get type:C1300(*; $_aT_ObjectsArray{$_L_index})
		$_Bo_HasDataSource:=True:C214  //most object have a variable or field
		$_Bo_HasFont:=True:C214
		$_Bo_HasAlignment:=True:C214
		$_Bo_ScrollBarAvailable:=False:C215
		$_Txt_InputSuformObjectName:=""
		$_Txt_OutputSuformObjectName:=""
		$_L_SubformWidth:=0
		$_L_SubformHeight:=0
		$_Bo_isThreeStateCB:=False:C215
		$_Txt_ButtonText:=""
		$_L_verticalAlignment:=0
		$_Txt_VerticalAlignment:=""
		Case of 
			: ($_L_objectType=Object type 3D button:K79:17)
				$_Txt_objectType:="Object type 3D button"
				$_Bo_HasAlignment:=False:C215
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type 3D checkbox:K79:27)
				$_Txt_objectType:="Object type 3D checkbox"
				$_Bo_HasAlignment:=False:C215
				$_Bo_isThreeStateCB:=OBJECT Get three states checkbox:C1250(*; $_aT_ObjectsArray{$_L_index})
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type 3D radio button:K79:24)
				$_Txt_objectType:="Object type 3D radio button"
				$_Bo_HasAlignment:=False:C215
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type button grid:K79:21)
				$_Txt_objectType:="Object type button grid"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type checkbox:K79:26)
				$_Txt_objectType:="Object type checkbox"
				$_Bo_HasAlignment:=False:C215
				$_Bo_isThreeStateCB:=OBJECT Get three states checkbox:C1250(*; $_aT_ObjectsArray{$_L_index})
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type combobox:K79:12)
				$_Txt_objectType:="Object type combobox"
			: ($_L_objectType=Object type dial:K79:29)
				$_Txt_objectType:="Object type dial"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type group:K79:22)
				$_Txt_objectType:="Object type group"
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
				$_Bo_HasDataSource:=False:C215
			: ($_L_objectType=Object type groupbox:K79:31)
				$_Txt_objectType:="Object type groupbox"
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type hierarchical list:K79:7)
				$_Txt_objectType:="Object type hierarchical list"
				$_Bo_ScrollBarAvailable:=True:C214
			: ($_L_objectType=Object type hierarchical popup menu:K79:14)
				$_Txt_objectType:="Object type hierarchical popup menu"
			: ($_L_objectType=Object type highlight button:K79:18)
				$_Txt_objectType:="Object type highlight button"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type invisible button:K79:19)
				$_Txt_objectType:="Object type invisible button"
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type line:K79:33)
				$_Txt_objectType:="Object type line"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type listbox:K79:8)
				$_Txt_objectType:="Object type listbox"
				$_Bo_ScrollBarAvailable:=True:C214
				$_L_verticalAlignment:=OBJECT Get vertical alignment:C1188(*; $_aT_ObjectsArray{$_L_index})
				Case of 
					: ($_L_verticalAlignment=Align bottom:K42:6)
						$_Txt_VerticalAlignment:="Align bottom"
					: ($_L_verticalAlignment=Align center:K42:3)
						$_Txt_VerticalAlignment:="Align Center"
					: ($_L_verticalAlignment=Align top:K42:5)
						$_Txt_VerticalAlignment:="Align Top"
				End case 
			: ($_L_objectType=Object type listbox column:K79:10)
				$_Txt_objectType:="Object type listbox column"
				$_L_verticalAlignment:=OBJECT Get vertical alignment:C1188(*; $_aT_ObjectsArray{$_L_index})
				Case of 
					: ($_L_verticalAlignment=Align bottom:K42:6)
						$_Txt_VerticalAlignment:="Align bottom"
					: ($_L_verticalAlignment=Align center:K42:3)
						$_Txt_VerticalAlignment:="Align Center"
					: ($_L_verticalAlignment=Align top:K42:5)
						$_Txt_VerticalAlignment:="Align Top"
				End case 
			: ($_L_objectType=Object type listbox footer:K79:11)
				$_Txt_objectType:="Object type listbox Footer"
				$_L_verticalAlignment:=OBJECT Get vertical alignment:C1188(*; $_aT_ObjectsArray{$_L_index})
				Case of 
					: ($_L_verticalAlignment=Align bottom:K42:6)
						$_Txt_VerticalAlignment:="Align bottom"
					: ($_L_verticalAlignment=Align center:K42:3)
						$_Txt_VerticalAlignment:="Align Center"
					: ($_L_verticalAlignment=Align top:K42:5)
						$_Txt_VerticalAlignment:="Align Top"
				End case 
			: ($_L_objectType=Object type listbox header:K79:9)
				$_Txt_objectType:="Object type listbox Header"
				$_L_verticalAlignment:=OBJECT Get vertical alignment:C1188(*; $_aT_ObjectsArray{$_L_index})
				Case of 
					: ($_L_verticalAlignment=Align bottom:K42:6)
						$_Txt_VerticalAlignment:="Align bottom"
					: ($_L_verticalAlignment=Align center:K42:3)
						$_Txt_VerticalAlignment:="Align Center"
					: ($_L_verticalAlignment=Align top:K42:5)
						$_Txt_VerticalAlignment:="Align Top"
				End case 
				
			: ($_L_objectType=Object type matrix:K79:36)
				$_Txt_objectType:="Object type matrix"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type oval:K79:35)
				$_Txt_objectType:="Object type oval"
				$_Bo_HasFont:=False:C215
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type picture button:K79:20)
				$_Txt_objectType:="Object type picture button"
				$_Bo_HasFont:=False:C215
			: ($_L_objectType=Object type picture input:K79:5)
				$_Txt_objectType:="Object type picture input"
				$_Bo_HasFont:=False:C215
				$_Bo_ScrollBarAvailable:=True:C214
			: ($_L_objectType=Object type picture popup menu:K79:15)
				$_Txt_objectType:="Object type picture popup menu"
			: ($_L_objectType=Object type picture radio button:K79:25)
				$_Txt_objectType:="Object type picture radio button"
			: ($_L_objectType=Object type plugin area:K79:39)
				$_Txt_objectType:="Object type plugin area"
				$_Bo_HasFont:=False:C215
			: ($_L_objectType=Object type popup dropdown list:K79:13)
				$_Txt_objectType:="Object type popup dropdown list"
			: ($_L_objectType=Object type progress indicator:K79:28)
				$_Txt_objectType:="Object type progress indicator"
				$_Bo_HasAlignment:=False:C215
				$_L_Indicator:=OBJECT Get indicator type:C1247(*; $_aT_ObjectsArray{$_L_index})
				Case of 
					: ($_L_Indicator=Asynchronous progress bar:K42:36)
						$_Txt_Indicator:="Asynchronous progress bar"
					: ($_L_Indicator=Barber shop:K42:35)
						$_Txt_Indicator:="Barber Shop"
					: ($_L_Indicator=Progress bar:K42:34)
						$_Txt_Indicator:="progress bar"
				End case 
			: ($_L_objectType=Object type push button:K79:16)
				$_Txt_objectType:="Object type push button"
				$_Bo_HasAlignment:=False:C215
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type radio button field:K79:6)
				$_Txt_objectType:="Object type radio button field"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type radio button:K79:23)
				$_Txt_objectType:="Object type radio button"
				$_Bo_HasAlignment:=False:C215
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type rectangle:K79:32)
				$_Txt_objectType:="Object type rectangle"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type rounded rectangle:K79:34)
				$_Txt_objectType:="Object type rounded rectangle"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type ruler:K79:30)
				$_Txt_objectType:="Object type ruler"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type splitter:K79:37)
				$_Txt_objectType:="Object type splitter"
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type static picture:K79:3)
				$_Txt_objectType:="Object type static picture"
				$_Bo_HasFont:=False:C215
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasAlignment:=False:C215
				$_Bo_ScrollBarAvailable:=True:C214
			: ($_L_objectType=Object type static text:K79:2)
				$_Txt_objectType:="Object type static text"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasAlignment:=False:C215
				$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
				
			: ($_L_objectType=Object type subform:K79:40)
				$_Txt_objectType:="Object type subform"
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
				$_Bo_ScrollBarAvailable:=True:C214
				OBJECT GET SUBFORM:C1139(*; $_aT_ObjectsArray{$_L_index}; $_Ptr_SubformTable; $_t_DetailSubform; $_t_ListSubform)
				//OBJECT GET SUBFORM CONTAINER SIZE(*;$_aT_ObjectsArray{$_L_index};$_L_SubformWidth;$_L_SubformHeight)
				If (Not:C34(Is nil pointer:C315($_Ptr_SubformTable)))
					$_Txt_InputSuformObjectName:=Table name:C256($_Ptr_SubformTable)+":"+$_t_DetailSubform
					$_Txt_OutputSuformObjectName:=Table name:C256($_Ptr_SubformTable)+":"+$_t_ListSubform
				Else 
					$_Txt_InputSuformObjectName:="Project Form or Widget"+":"+$_t_DetailSubform
					$_Txt_OutputSuformObjectName:="Project Form or Widget"+":"+$_t_ListSubform
				End if 
			: ($_L_objectType=Object type tab control:K79:38)
				$_Txt_objectType:="Object type tab control"
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type text input:K79:4)
				$_Txt_objectType:="Object type text input"
				$_Bo_ScrollBarAvailable:=True:C214
			: ($_L_objectType=Object type unknown:K79:1)
				$_Txt_objectType:="Object type unknown"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
			: ($_L_objectType=Object type web area:K79:41)
				$_Txt_objectType:="Object type web area"
				$_Bo_HasAlignment:=False:C215
				$_Bo_HasFont:=False:C215
			Else 
				$_Txt_objectType:="OTHER???"
				$_Bo_HasDataSource:=False:C215
				$_Bo_HasFont:=False:C215
				$_Bo_HasAlignment:=False:C215
		End case 
		OBJECT GET COORDINATES:C663(*; $_aT_ObjectsArray{$_L_index}; $_l_lOLeft; $_l_lOTop; $_l_lORight; $_l_lOBottom)
		//object events
		OBJECT GET EVENTS:C1238(*; $_aT_ObjectsArray{$_L_index}; $_aL_FormEvents)  //gets a list of the Object events
		ARRAY TEXT:C222($_aT_EnabledObjectEvents; 0)
		For ($_L_index2; 1; Size of array:C274($_aL_FormEvents))
			Case of 
				: ($_aL_FormEvents{$_L_index2}=On Load:K2:1)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On Load")
				: ($_aL_FormEvents{$_L_index2}=On Page Change:K2:54)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On page change")
				: ($_aL_FormEvents{$_L_index2}=On Validate:K2:3)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On Validate")
				: ($_aL_FormEvents{$_L_index2}=On Clicked:K2:4)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On Clicked")
				: ($_aL_FormEvents{$_L_index2}=On Double Clicked:K2:5)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On Double CLicked")
				: ($_aL_FormEvents{$_L_index2}=On Outside Call:K2:11)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On outside Call")
				: ($_aL_FormEvents{$_L_index2}=On Activate:K2:9)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On Activate")
				: ($_aL_FormEvents{$_L_index2}=On Deactivate:K2:10)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On deactivate")
				: ($_aL_FormEvents{$_L_index2}=On Getting Focus:K2:7)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On getting focus")
				: ($_aL_FormEvents{$_L_index2}=On Losing Focus:K2:8)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On losing focus")
				: ($_aL_FormEvents{$_L_index2}=On Begin Drag Over:K2:44)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On begin drag over")
				: ($_aL_FormEvents{$_L_index2}=On Drag Over:K2:13)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On drag over")
				: ($_aL_FormEvents{$_L_index2}=On Drop:K2:12)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On drop")
				: ($_aL_FormEvents{$_L_index2}=On Before Keystroke:K2:6)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On before keystroke")
				: ($_aL_FormEvents{$_L_index2}=On After Keystroke:K2:26)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On after keystroke")
				: ($_aL_FormEvents{$_L_index2}=On Menu Selected:K2:14)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On menu selected")
				: ($_aL_FormEvents{$_L_index2}=On Plug in Area:K2:16)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on Plug in area")
				: ($_aL_FormEvents{$_L_index2}=On Data Change:K2:15)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on data change")
				: ($_aL_FormEvents{$_L_index2}=On After Edit:K2:43)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on after edit")
				: ($_aL_FormEvents{$_L_index2}=On Close Box:K2:21)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on close box")
				: ($_aL_FormEvents{$_L_index2}=On Unload:K2:2)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on unload")
				: ($_aL_FormEvents{$_L_index2}=On Timer:K2:25)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On timer")
				: ($_aL_FormEvents{$_L_index2}=On Resize:K2:27)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On resize")
				: ($_aL_FormEvents{$_L_index2}=On Selection Change:K2:29)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On selection change")
				: ($_aL_FormEvents{$_L_index2}=On Mouse Enter:K2:33)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "on mouse enter")
				: ($_aL_FormEvents{$_L_index2}=On Mouse Move:K2:35)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On mouse move")
				: ($_aL_FormEvents{$_L_index2}=On Mouse Leave:K2:34)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On mouse leave")
				: ($_aL_FormEvents{$_L_index2}=On Bound Variable Change:K2:52)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On bound variable change")
				: ($_aL_FormEvents{$_L_index2}=_o_On Mac Toolbar Button:K2:53)
					APPEND TO ARRAY:C911($_aT_EnabledObjectEvents; "On mac toolbar button")
			End case 
		End for 
		//Style sheet
		$_Txt_ObjectStyleSheet:=OBJECT Get style sheet:C1258(*; $_aT_ObjectsArray{$_L_index})
		$_Bo_ObjectAutoSpellCheck:=OBJECT Get auto spellcheck:C1174(*; $_aT_ObjectsArray{$_L_index})
		//border style]
		$_L_BorderLineStyle:=OBJECT Get border style:C1263(*; $_aT_ObjectsArray{$_L_index})
		Case of 
			: ($_L_BorderLineStyle=Border Dotted:K42:29)
				$_Txt_BorderLinestyle:="border dotted"
			: ($_L_BorderLineStyle=Border Double:K42:32)
				$_Txt_BorderLinestyle:="border double"
			: ($_L_BorderLineStyle=Border None:K42:27)
				$_Txt_BorderLinestyle:="border None"
			: ($_L_BorderLineStyle=Border Plain:K42:28)
				$_Txt_BorderLinestyle:="border Plain"
			: ($_L_BorderLineStyle=Border Raised:K42:30)
				$_Txt_BorderLinestyle:="border Raised"
			: ($_L_BorderLineStyle=Border Sunken:K42:31)
				$_Txt_BorderLinestyle:="border Sunken"
			: ($_L_BorderLineStyle=Border System:K42:33)
				$_Txt_BorderLinestyle:="border system"
		End case 
		//contect menu
		$_Bo_ObjectHasContextMenu:=OBJECT Get context menu:C1252(*; $_aT_ObjectsArray{$_L_index})
		$_Txt_StandardAction:=""
		$_Txt_VariableName:=""
		$_Bo_ObjectEnabled:=False:C215
		$_Bo_ObjectEnterable:=False:C215
		$_Txt_FilterName:=""
		$_Bo_FocusRectangleVIsible:=False:C215
		$_Txt_DisplayFormat:=""
		$_Txt_Keyboard:=""
		If ($_Bo_HasDataSource)  //object is a variable-this exludes lines static pictures and text
			$_Ptr_ptrToSourceObject:=OBJECT Get data source:C1265(*; $_aT_ObjectsArray{$_L_index})
			$_Txt_StandardAction:=_O_OBJECT Get action:C1260(*; $_aT_ObjectsArray{$_L_index})
			RESOLVE POINTER:C394($_Ptr_ptrToSourceObject; $_Txt_VariableName; $_L_TableNum; $_l_FieldNumber)
			If ($_L_TableNum>0)
				$_Txt_VariableName:=Field name:C257($_L_TableNum; $_l_FieldNumber)  //in the context of what we are doing here this is correct
			End if 
			$_Bo_ObjectEnterable:=OBJECT Get enterable:C1067(*; $_aT_ObjectsArray{$_L_index})
			$_Bo_ObjectEnabled:=OBJECT Get enabled:C1079(*; $_aT_ObjectsArray{$_L_index})
			$_Txt_FilterName:=OBJECT Get filter:C1073(*; $_aT_ObjectsArray{$_L_index})
			$_Bo_FocusRectangleVIsible:=OBJECT Get focus rectangle invisible:C1178(*; $_aT_ObjectsArray{$_L_index})
			$_Txt_DisplayFormat:=OBJECT Get format:C894(*; $_aT_ObjectsArray{$_L_index})
			$_Txt_Keyboard:=OBJECT Get keyboard layout:C1180(*; $_aT_ObjectsArray{$_L_index})
			If (Not:C34(Is nil pointer:C315($_Ptr_ptrToSourceObject)))
				If (Type:C295($_Ptr_ptrToSourceObject->)=Is date:K8:7) | (Type:C295($_Ptr_ptrToSourceObject->)=Is longint:K8:6) | (Type:C295($_Ptr_ptrToSourceObject->)=Is integer:K8:5) | (Type:C295($_Ptr_ptrToSourceObject->)=Is real:K8:4) | (Type:C295($_Ptr_ptrToSourceObject->)=Is time:K8:8)
					//OBJECT GET MAXIMUM VALUE(*;$_aT_ObjectsArray{$_L_index};$_L_ObjectMaximumValue)
					//OBJECT GET MINIMUM VALUE(*;$_aT_ObjectsArray{$_L_index};$_L_ObjectMimimumValue)
				End if 
			End if 
		End if 
		
		$_Txt_DisplayFormat:=OBJECT Get format:C894(*; $_aT_ObjectsArray{$_L_index})
		OBJECT GET DRAG AND DROP OPTIONS:C1184(*; $_aT_ObjectsArray{$_L_index}; $_Bo_Draggable; $_Bo_AutoDraggable; $_Bo_Droppable; $_Bo_automaticDrop)
		$_Txt_FontName:=""
		$_L_FontSize:=0
		$_L_FontStyle:=0
		$_Txt_FontStyleName:=""
		If ($_Bo_HasFont)
			$_Txt_FontName:=OBJECT Get font:C1069(*; $_aT_ObjectsArray{$_L_index})
			$_L_FontSize:=OBJECT Get font size:C1070(*; $_aT_ObjectsArray{$_L_index})
			$_L_FontStyle:=OBJECT Get font style:C1071(*; $_aT_ObjectsArray{$_L_index})
			
			Case of 
				: ($_L_FontStyle=Plain:K14:1)  //00
					$_Txt_FontStyleName:="Plain"
				: ($_L_FontStyle=Bold:K14:2)  //1
					$_Txt_FontStyleName:="Bold"
				: ($_L_FontStyle=Italic:K14:3)  //2/
					$_Txt_FontStyleName:="Italic"
				: ($_L_FontStyle=(Italic:K14:3+Bold:K14:2))  //3
					$_Txt_FontStyleName:="Bold Italic"
				: ($_L_FontStyle=Underline:K14:4)  //4
					$_Txt_FontStyleName:="Underline"
				: ($_L_FontStyle=(Bold:K14:2+Underline:K14:4))  //5
					$_Txt_FontStyleName:="Bold Undeline"
				: ($_L_FontStyle=(Italic:K14:3+Underline:K14:4))  //6
					$_Txt_FontStyleName:="Italic Undeline"
				: ($_L_FontStyle=(Italic:K14:3+Bold:K14:2+Underline:K14:4))  //7
					$_Txt_FontStyleName:="Bold Italic Undeline"
					
					
				Else 
					$_Txt_FontStyleName:="Other???"
			End case 
		End if 
		$_Txt_HelpText:=OBJECT Get help tip:C1182(*; $_aT_ObjectsArray{$_L_index})
		$_L_ObjectAlignment:=0
		$_Txt_OjbectAlignment:=""
		If ($_Bo_HasAlignment)
			$_L_ObjectAlignment:=OBJECT Get horizontal alignment:C707(*; $_aT_ObjectsArray{$_L_index})
			Case of 
				: ($_L_ObjectAlignment=Align center:K42:3)
					$_Txt_OjbectAlignment:="Align Center"
				: ($_L_ObjectAlignment=Align default:K42:1)
					$_Txt_OjbectAlignment:="Align default"
				: ($_L_ObjectAlignment=Align left:K42:2)
					$_Txt_OjbectAlignment:="Align left"
				: ($_L_ObjectAlignment=Align right:K42:4)
					$_Txt_OjbectAlignment:="Align right"
			End case 
		End if 
		$_Txt_ListName:=OBJECT Get list name:C1072(*; $_aT_ObjectsArray{$_L_index})
		$_L_ListReference:=OBJECT Get list reference:C1267(*; $_aT_ObjectsArray{$_L_index})
		$_L_MultiLine:=OBJECT Get multiline:C1254(*; $_aT_ObjectsArray{$_L_index})
		$_Txt_MultiLineName:=""
		Case of 
			: ($_L_MultiLine=Multiline Auto:K42:22)
				$_Txt_MultiLineName:="Multiline Auto"
			: ($_L_MultiLine=Multiline No:K42:24)
				$_Txt_MultiLineName:="Multiline No"
			: ($_L_MultiLine=Multiline Yes:K42:23)
				$_Txt_MultiLineName:="Multiline Yes"
		End case 
		$_Txt_Placeholder:=OBJECT Get placeholder:C1296(*; $_aT_ObjectsArray{$_L_index})
		OBJECT GET PRINT VARIABLE FRAME:C1241(*; $_aT_ObjectsArray{$_L_index}; $_Bo_PrintVarFrame; $_L_FixedSubform)
		$_Txt_SubformOption:=""
		Case of 
			: ($_L_FixedSubform=Print Frame fixed with multiple records:K42:26)
				$_Txt_SubformOption:="Print Frame fixed with multiple records"
			: ($_L_FixedSubform=Print Frame fixed with truncation:K42:25)
				$_Txt_SubformOption:="Print Frame fixed with truncation"
		End case 
		OBJECT GET RESIZING OPTIONS:C1176(*; $_aT_ObjectsArray{$_L_index}; $_L_HorizontalResizing; $_L_VerticalResizing)
		$_Txt_HorizontalResizing:=""
		Case of 
			: ($_L_HorizontalResizing=Resize horizontal grow:K42:8)
				$_Txt_HorizontalResizing:="Resize horizontal grow"
			: ($_L_HorizontalResizing=Resize horizontal move:K42:9)
				$_Txt_HorizontalResizing:="Resize horizontal Move"
			: ($_L_HorizontalResizing=Resize horizontal none:K42:7)
				$_Txt_HorizontalResizing:="Resize horizontal None"
		End case 
		Case of 
			: ($_L_VerticalResizing=Resize vertical grow:K42:11)
				$_Txt_VerticalResizing:="Resize Vertical grow"
			: ($_L_VerticalResizing=Resize vertical move:K42:12)
				$_Txt_VerticalResizing:="Resize Vertical Move"
			: ($_L_VerticalResizing=Resize vertical none:K42:10)
				$_Txt_VerticalResizing:="Resize Vertical None"
		End case 
		OBJECT GET RGB COLORS:C1074(*; $_aT_ObjectsArray{$_L_index}; $_L_ForegroundColour; $_L_BackgroundColour; $_L_altBackGroundColour)
		$_Txt_ForegroundColour:=""
		$_Txt_BackGroundColour:=""
		$_Txt_altBackGroundColour:=""
		
		Case of 
			: ($_L_ForegroundColour=Background color:K23:2)
				$_Txt_ForegroundColour:="Background Color"
			: ($_L_ForegroundColour=Background color none:K23:10)
				$_Txt_ForegroundColour:="Background Color none"
			: ($_L_ForegroundColour=Dark shadow color:K23:3)
				$_Txt_ForegroundColour:="dark shadow color"
			: ($_L_ForegroundColour=Disable highlight item color:K23:9)
				$_Txt_ForegroundColour:="disable highlight item color"
			: ($_L_ForegroundColour=Foreground color:K23:1)
				$_Txt_ForegroundColour:="Foreground Color"
			: ($_L_ForegroundColour=Highlight menu background color:K23:7)
				$_Txt_ForegroundColour:="Highlight menu background color"
			: ($_L_ForegroundColour=Highlight menu text color:K23:8)
				$_Txt_ForegroundColour:="Highlight Menu text color"
			: ($_L_ForegroundColour=Highlight text background color:K23:5)
				$_Txt_ForegroundColour:="Highlight text Background color"
			: ($_L_ForegroundColour=Highlight text color:K23:6)
				$_Txt_ForegroundColour:="Highlight text color"
			: ($_L_ForegroundColour=Light shadow color:K23:4)
				$_Txt_ForegroundColour:="Light shadow color"
			Else 
				$_Txt_ForegroundColour:=String:C10($_L_ForegroundColour)
		End case 
		Case of 
			: ($_L_BackgroundColour=Background color:K23:2)
				$_Txt_BackGroundColour:="Background Color"
			: ($_L_BackgroundColour=Background color none:K23:10)
				$_Txt_BackGroundColour:="Background Color none"
			: ($_L_BackgroundColour=Dark shadow color:K23:3)
				$_Txt_BackGroundColour:="dark shadow color"
			: ($_L_BackgroundColour=Disable highlight item color:K23:9)
				$_Txt_BackGroundColour:="disable highlight item color"
			: ($_L_BackgroundColour=Foreground color:K23:1)
				$_Txt_BackGroundColour:="Foreground Color"
			: ($_L_BackgroundColour=Highlight menu background color:K23:7)
				$_Txt_BackGroundColour:="Highlight menu background color"
			: ($_L_BackgroundColour=Highlight menu text color:K23:8)
				$_Txt_BackGroundColour:="Highlight Menu text color"
			: ($_L_BackgroundColour=Highlight text background color:K23:5)
				$_Txt_BackGroundColour:="Highlight text Background color"
			: ($_L_BackgroundColour=Highlight text color:K23:6)
				$_Txt_BackGroundColour:="Highlight text color"
			: ($_L_BackgroundColour=Light shadow color:K23:4)
				$_Txt_BackGroundColour:="Light shadow color"
			Else 
				$_Txt_BackGroundColour:=String:C10($_L_BackgroundColour)
		End case 
		If ($_L_altBackGroundColour#0)
			Case of 
				: ($_L_altBackGroundColour=Background color:K23:2)
					$_Txt_altBackGroundColour:="Background Color"
				: ($_L_altBackGroundColour=Background color none:K23:10)
					$_Txt_altBackGroundColour:="Background Color none"
				: ($_L_altBackGroundColour=Dark shadow color:K23:3)
					$_Txt_altBackGroundColour:="dark shadow color"
				: ($_L_altBackGroundColour=Disable highlight item color:K23:9)
					$_Txt_altBackGroundColour:="disable highlight item color"
				: ($_L_altBackGroundColour=Foreground color:K23:1)
					$_Txt_altBackGroundColour:="Foreground Color"
				: ($_L_altBackGroundColour=Highlight menu background color:K23:7)
					$_Txt_altBackGroundColour:="Highlight menu background color"
				: ($_L_altBackGroundColour=Highlight menu text color:K23:8)
					$_Txt_altBackGroundColour:="Highlight Menu text color"
				: ($_L_altBackGroundColour=Highlight text background color:K23:5)
					$_Txt_altBackGroundColour:="Highlight text Background color"
				: ($_L_altBackGroundColour=Highlight text color:K23:6)
					$_Txt_altBackGroundColour:="Highlight text color"
				: ($_L_altBackGroundColour=Light shadow color:K23:4)
					$_Txt_altBackGroundColour:="Light shadow color"
				Else 
					$_Txt_altBackGroundColour:=String:C10($_L_altBackGroundColour)
			End case 
		End if 
		$_Bo_VisibleHScroll:=False:C215
		$_Bo_VisibleVScroll:=False:C215
		If ($_Bo_ScrollBarAvailable)
			OBJECT GET SCROLLBAR:C1076(*; $_aT_ObjectsArray{$_L_index}; $_Bo_VisibleHScroll; $_Bo_VisibleVScroll)
		End if 
		OBJECT GET SHORTCUT:C1186(*; $_aT_ObjectsArray{$_L_index}; $_Txt_ShortcutKey; $_L_lSHortcutModifier)
		$_L_ObjectOrientation:=OBJECT Get text orientation:C1283(*; $_aT_ObjectsArray{$_L_index})
		$_Bo_isThreeStateCB:=OBJECT Get three states checkbox:C1250(*; $_aT_ObjectsArray{$_L_index})
		$_Txt_ButtonText:=OBJECT Get title:C1068(*; $_aT_ObjectsArray{$_L_index})
		$_Bo_ObjectisVIsible:=OBJECT Get visible:C1075(*; $_aT_ObjectsArray{$_L_index})
		$_Bo_ObjectisStyledText:=OBJECT Is styled text:C1261(*; $_aT_ObjectsArray{$_L_index})
		OB SET:C1220($_Obj_ObjectObject; "Page Number"; $_aL_PagesArray{$_L_index})
		OB SET:C1220($_Obj_ObjectObject; "Name"; $_aT_ObjectsArray{$_L_index})
		If ($_Txt_VariableName#"")
			OB SET:C1220($_Obj_ObjectObject; "Variable Name"; $_Txt_VariableName)
		End if 
		OB SET:C1220($_Obj_ObjectObject; "Type"; $_L_objectType)
		OB SET:C1220($_Obj_ObjectObject; "Type Name"; $_Txt_objectType)
		If ($_Txt_ButtonText#"")
			OB SET:C1220($_Obj_ObjectObject; "Text"; $_Txt_objectType)
		End if 
		If ($_L_ObjectMaximumValue#0)
			OB SET:C1220($_Obj_ObjectObject; "Maximum Value"; $_L_ObjectMaximumValue)
		End if 
		If ($_L_ObjectMimimumValue#0)
			OB SET:C1220($_Obj_ObjectObject; "Mimimum Value"; $_L_ObjectMimimumValue)
		End if 
		If ($_Txt_MultiLineName#"")
			OB SET:C1220($_Obj_ObjectObject; "Multiline option"; $_L_MultiLine)
			OB SET:C1220($_Obj_ObjectObject; "Multiline option Name"; $_Txt_MultiLineName)
		End if 
		
		
		If ($_Txt_Placeholder#"")
			OB SET:C1220($_Obj_ObjectObject; "Placeholder Text"; $_Txt_Placeholder)
		End if 
		If ($_Txt_HelpText#"")
			OB SET:C1220($_Obj_ObjectObject; "Tooltip Text"; $_Txt_HelpText)
		End if 
		
		
		If ($_Txt_ObjectStyleSheet#"")
			OB SET:C1220($_Obj_ObjectObject; "Style Sheet"; $_Txt_ObjectStyleSheet)
		End if 
		If ($_Txt_FontName#"")
			OB SET:C1220($_Obj_ObjectObject; "Font Name"; $_Txt_FontName)
			OB SET:C1220($_Obj_ObjectObject; "Font Size"; $_L_FontSize)
			OB SET:C1220($_Obj_ObjectObject; "Font Style"; $_L_FontStyle)
			OB SET:C1220($_Obj_ObjectObject; "Font Style Name"; $_Txt_FontStyleName)
			
		End if 
		OB SET:C1220($_Obj_ObjectObject; "Is visible?"; $_Bo_ObjectisVIsible)
		OB SET:C1220($_Obj_ObjectObject; "Foreground Colour"; $_Txt_ForegroundColour)
		OB SET:C1220($_Obj_ObjectObject; "Background Colour"; $_Txt_BackGroundColour)
		If ($_Txt_altBackGroundColour#"")
			OB SET:C1220($_Obj_ObjectObject; "Alternate Background Colour"; $_Txt_altBackGroundColour)
		End if 
		OB SET:C1220($_Obj_ObjectObject; "Left Position"; $_l_lOLeft)
		OB SET:C1220($_Obj_ObjectObject; "Top Position"; $_l_lOTop)
		OB SET:C1220($_Obj_ObjectObject; "Right Position"; $_l_lORight)
		OB SET:C1220($_Obj_ObjectObject; "Bottom Position"; $_l_lOBottom)
		OB SET:C1220($_Obj_ObjectObject; "Horizontal Resize"; $_L_HorizontalResizing)
		OB SET:C1220($_Obj_ObjectObject; "Horizontal Resize Name"; $_Txt_HorizontalResizing)
		OB SET:C1220($_Obj_ObjectObject; "Vertical Resize"; $_L_VerticalResizing)
		OB SET:C1220($_Obj_ObjectObject; "Vertical Resize Name"; $_Txt_VerticalResizing)
		OB SET:C1220($_Obj_ObjectObject; "Horizontal Alignment"; $_L_ObjectAlignment)
		OB SET:C1220($_Obj_ObjectObject; "Horizontal Alignment Name"; $_Txt_OjbectAlignment)
		If ($_Txt_VerticalAlignment#"")
			OB SET:C1220($_Obj_ObjectObject; "Vertical Alignment"; $_L_verticalAlignment)
			OB SET:C1220($_Obj_ObjectObject; "Vertical Alignment Name"; $_Txt_VerticalAlignment)
		End if 
		If ($_L_objectType=Object type subform:K79:40)
			OB SET:C1220($_Obj_ObjectObject; "Subform Input Form"; $_Txt_InputSuformObjectName)
			OB SET:C1220($_Obj_ObjectObject; "Subform Output Form"; $_Txt_OutputSuformObjectName)
			OB SET:C1220($_Obj_ObjectObject; "Print Variable Frame"; $_Bo_PrintVarFrame)
			OB SET:C1220($_Obj_ObjectObject; "Print Fixed Option"; $_L_FixedSubform)
			OB SET:C1220($_Obj_ObjectObject; "Print Fixed Frame"; $_Txt_SubformOption)
		End if 
		
		If ($_Txt_BorderLinestyle#"")
			OB SET:C1220($_Obj_ObjectObject; "Border Line Style"; $_L_BorderLineStyle)
			OB SET:C1220($_Obj_ObjectObject; "Border Line Style Name"; $_Txt_BorderLinestyle)
			
		End if 
		If ($_Txt_ShortcutKey#"")
			OB SET:C1220($_Obj_ObjectObject; "Shortcut"; $_Txt_ShortcutKey)
			OB SET:C1220($_Obj_ObjectObject; "Shortcut Modifiers"; $_L_lSHortcutModifier)
		End if 
		If ($_L_ObjectOrientation#0)
			OB SET:C1220($_Obj_ObjectObject; "Text Orientation"; $_L_ObjectOrientation)
		End if 
		
		
		$_Bo_ObjectisStyledText:=OBJECT Is styled text:C1261(*; $_aT_ObjectsArray{$_L_index})
		
		OB SET:C1220($_Obj_ObjectObject; "Show Focus"; $_Bo_FocusRectangleVIsible)
		
		If ($_Bo_ScrollBarAvailable)
			OB SET:C1220($_Obj_ObjectObject; "Horizontal Scroll Bar"; $_Bo_VisibleHScroll)
			OB SET:C1220($_Obj_ObjectObject; "Vertical Scroll Bar"; $_Bo_VisibleVScroll)
		End if 
		If ($_L_objectType=Object type 3D checkbox:K79:27) | ($_L_objectType=Object type checkbox:K79:26)
			OB SET:C1220($_Obj_ObjectObject; "Three State Checkbox"; $_Bo_isThreeStateCB)
		End if 
		If ($_Txt_Indicator#"")
			OB SET:C1220($_Obj_ObjectObject; "Indicator type"; $_L_Indicator)
			OB SET:C1220($_Obj_ObjectObject; "Indicator type Name"; $_Txt_Indicator)
		End if 
		OB SET:C1220($_Obj_ObjectObject; "Auto Spellcheck"; $_Bo_ObjectAutoSpellCheck)
		OB SET:C1220($_Obj_ObjectObject; "Has Contextual Menu"; $_Bo_ObjectHasContextMenu)
		If ($_Txt_ListName#"")
			OB SET:C1220($_Obj_ObjectObject; "List Name"; $_Txt_ListName)
		End if 
		If ($_L_ListReference#0)
			OB SET:C1220($_Obj_ObjectObject; "List Reference"; $_L_ListReference)
		End if 
		If ($_Txt_StandardAction#"")
			OB SET:C1220($_Obj_ObjectObject; "Standard Action"; $_Txt_StandardAction)
		End if 
		If ($_Bo_HasDataSource)
			OB SET:C1220($_Obj_ObjectObject; "Enterable"; $_Bo_ObjectEnterable)
			OB SET:C1220($_Obj_ObjectObject; "Enabled"; $_Bo_ObjectEnabled)
			If ($_Txt_FilterName#"")
				OB SET:C1220($_Obj_ObjectObject; "Filter"; $_Txt_FilterName)
			End if 
			If ($_Txt_Keyboard#"")
				OB SET:C1220($_Obj_ObjectObject; "Keyboard Layout"; $_Txt_DisplayFormat)
			End if 
			
		End if 
		If ($_Txt_DisplayFormat#"")
		End if 
		OB SET:C1220($_Obj_ObjectObject; "Display Format"; $_Txt_DisplayFormat)
		
		OB SET:C1220($_Obj_ObjectObject; "Draggable"; $_Bo_Draggable)
		OB SET:C1220($_Obj_ObjectObject; "Auto Drag"; $_Bo_AutoDraggable)
		OB SET:C1220($_Obj_ObjectObject; "Droppable"; $_Bo_Droppable)
		OB SET:C1220($_Obj_ObjectObject; "Auto Drop"; $_Bo_automaticDrop)
		OB SET ARRAY:C1227($_Obj_ObjectObject; "Active Events"; $_aT_EnabledObjectEvents)  //this is an array
		
		
		APPEND TO ARRAY:C911($_aObj_FormObjects; $_Obj_ObjectObject)
		
		
	End for 
	OB SET ARRAY:C1227($_ptr_FormObject->; "Form Objects"; $_aObj_FormObjects)
	
End if 

//End DEV_GetFormObjects