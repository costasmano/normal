//%attributes = {"invisible":true}
// Method: LSS_DisplayInspection
// Description
// Parameters

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 09/23/14, 15:22:00
	// ----------------------------------------------------
	// 
	//
	// Modified by: Costas Manousakis-(Designer)-(2024-03-28 13:37:10)
	Mods_2024_LSS_1
	//  `Allow users in LSS_MassEditAccess to edit so they can modify Contract and assignment number
	
End if 
C_TEXT:C284($1; $InputForm_txt)
$InputForm_txt:=$1
LSS_PermissionModInspection
LSS_PermissionDelInspection
If (Not:C34(LSS_AllowInspectionEdit_B))
	
	Case of 
		: (User in group:C338(Current user:C182; "Design Access Group"))
			CONFIRM:C162("Do you "+Current user:C182+" want to edit the inspection"; "Edit"; "Read Only")
			If (OK=1)
				LSS_AllowInspectionEdit_B:=True:C214
				LSS_AllowInspectionDelete_B:=True:C214
			End if 
		: (GRP_UserInGroup("LSS_MassEditAccess")=1)
			CONFIRM:C162("Do you "+Current user:C182+" want to edit the inspection to change Contract and Assignment?"; "Edit"; "Read Only")
			If (OK=1)
				LSS_AllowInspectionEdit_B:=True:C214
			End if 
			
	End case 
	
End if 

C_LONGINT:C283($Width_L; $Height_L; $Choice_L)
FORM SET INPUT:C55([LSS_Inspection:164]; $InputForm_txt)
FORM GET PROPERTIES:C674([LSS_Inspection:164]; $InputForm_txt; $Width_L; $Height_l)
//ut_OpenNewWindow ($Width_L;$Height_l;0;Plain window )
If (LSS_AllowInspectionEdit_B)
	$Choice_L:=ut_LoadRecordInteractiveV2(->[LSS_Inspection:164])
Else 
	$Choice_L:=2
End if 


If ($InputForm_txt="Input_Sign")
	If (Type:C295(LSS_SignPanel_as)=Is undefined:K8:13)
		ARRAY TEXT:C222(LSS_SignPanel_as; 0)  //Command Replaced was o_ARRAY string length was 50
	End if 
	If (Size of array:C274(LSS_SignPanel_as)=0)
		APPEND TO ARRAY:C911(LSS_SignPanel_as; "Aluminum")
		APPEND TO ARRAY:C911(LSS_SignPanel_as; "Steel")
		APPEND TO ARRAY:C911(LSS_SignPanel_as; "Other")
	End if 
End if 
LSS_EditingInspection_B:=False:C215
Case of 
	: ($Choice_L=1)
		LSS_EditingInspection_B:=True:C214
		ut_SetReadWrite("Write"; ->[LSS_Inspection:164]; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
		
		If ($InputForm_txt="Input_Sign")
			ut_SetReadWrite("Write"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
		End if 
		
		MODIFY RECORD:C57([LSS_Inspection:164])
		ut_SetReadWrite("Read"; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
		If ($InputForm_txt="Input_Sign")
			ut_SetReadWrite("Read"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
		End if 
		
	: ($Choice_L=2)
		READ ONLY:C145([LSS_Inspection:164])
		ut_SetReadWrite("Read"; ->[LSS_ElementInspection:163]; ->[LSS_Photos:166]; ->[LSS_Accessibility:159]; ->[LSS_DMeter:161]; ->[LSS_UT:175]; ->[LSS_UtResult:176]; ->[LSS_TeamMembers:173])
		If ($InputForm_txt="Input_Sign")
			ut_SetReadWrite("read"; ->[LSS_SignPanel:172]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177]; ->[LSS_TowerDistance:174]; ->[LSS_VerticalClearance:177])
		End if 
		
		DIALOG:C40([LSS_Inspection:164]; $InputForm_txt)
		
End case 