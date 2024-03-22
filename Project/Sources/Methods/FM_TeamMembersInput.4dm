//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Bridge Section
//Date and time: 04/08/15, 16:27:41
//----------------------------------------------------
//Method: FM_TeamMembersInput
//Description
//NOtr used we can delete
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: Bridge Section (4/8/15 16:27:44)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 


C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		InitChangeStack(7)  //current table
		If (Is new record:C668([LSS_TeamMembers:173]))
			C_LONGINT:C283($ID_L)
			Inc_Sequence("LSS_InspectionId_s"; ->$ID_L)
			[LSS_TeamMembers:173]LSS_InspectionId_s:1:=String:C10($ID_L; <>KeyMask_s)
			LSS_SetUpButtonsForNewRecords
		Else 
			//what do we do with this one
			//LSS_SetPrevNextButtons (LSS_InspectionRow_L;Records in selection([LSS_TeamMembers]))
		End if 
	: (Form event code:C388=On Validate:K2:3) | ($FormEvent_L=On Validate:K2:3)
		If (Modified record:C314([LSS_TeamMembers:173]))
			C_TEXT:C284($ErrorMethodCalled_txt)
			$ErrorMethodCalled_txt:=Method called on error:C704
			ON ERR CALL:C155("LSS_ErrorMethod")
			If (Is new record:C668([LSS_TeamMembers:173]))
				LogNewRecord(->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; 0; "LSS_InspectionId_s")
			End if 
			ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
			APPEND TO ARRAY:C911($FieldsToSkip_atxt; "LSS_InspectionId_s")
			If (ACT_PushGroupChanges(Table:C252(->[LSS_TeamMembers:173]); 7; ->$FieldsToSkip_atxt))
				FlushGrpChgs(7; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; ->[LSS_TeamMembers:173]LSS_InspectionId_s:1; 0)
				
				SAVE RECORD:C53([LSS_TeamMembers:173])
			End if 
			ON ERR CALL:C155($ErrorMethodCalled_txt)
			UNLOAD RECORD:C212([LSS_TeamMembers:173])
		End if 
End case 


//End FM_TeamMembersInput

