//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 10/14/14, 14:12:24
// ----------------------------------------------------
// Method: LSS_LoadElementInspectionRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
QUERY:C277([LSS_ElementInspection:163]; [LSS_ElementInspection:163]LSS_InspectionId_s:3=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_ElementInspection:163];  & ; [LSS_ElementInspection:163]LSS_ElementId_L:2=v_163_002_aL{LSS_SelectedRow_L})
LSS_DefaultDescription_txt:=v_163_007_atxt{LSS_SelectedRow_L}
LSS_IsNewESRecord_B:=False:C215
If (Records in selection:C76([LSS_ElementInspection:163])=0)
	C_TEXT:C284($ErrorMethodCalled_txt)
	$ErrorMethodCalled_txt:=Method called on error:C704
	ON ERR CALL:C155("LSS_ErrorMethod")
	LSS_IsNewESRecord_B:=True:C214
	C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
	FORM GET PROPERTIES:C674([LSS_ElementInspection:163]; "Input"; $Width_L; $Height_L)
	FORM SET INPUT:C55([LSS_ElementInspection:163]; "Input")
	//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
	//ADD RECORD([LSS_ElementInspection])
	CREATE RECORD:C68([LSS_ElementInspection:163])
	C_LONGINT:C283($ID_L)
	
	Inc_Sequence("LSS_ElementInspectionId_s"; ->$ID_L)
	[LSS_ElementInspection:163]LSS_ElementInspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
	
	SAVE RECORD:C53([LSS_ElementInspection:163])
	ON ERR CALL:C155($ErrorMethodCalled_txt)
End if 

