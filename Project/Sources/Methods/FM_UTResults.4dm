//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 11:19:36
//----------------------------------------------------
//Method: FM_UTResults
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 11:20:05)
	Mods_2018_08  //Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
	//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
	//Modified by: Chuck Miller (8/30/18 15:36:57)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-18 18:56:54)
	Mods_2021_10
	//  `don't use the [LSS_UT] selections - we are working off an LSS_UT record input form
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
Case of 
	: ($FormEvent_L=On Load:K2:1)
		InitChangeStack(10)  //[LSS_UtResult]
		//USE NAMED SELECTION("UT_LB")
		
		//GOTO SELECTED RECORD([LSS_UT];LSS_UTRow_L)
		If (Is new record:C668([LSS_UtResult:176]))
			
			[LSS_UtResult:176]LSS_UTId_s:2:=[LSS_UT:175]LSS_UTId_s:1
			C_LONGINT:C283($ID_L)
			
			Inc_Sequence("LSS_UTResultId_s"; ->$ID_L)
			[LSS_UtResult:176]LSS_UTResultId_s:1:=String:C10($ID_L; <>KeyMask_s)
			
			LSS_SetUpButtonsForNewRecords
			
			
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_UtResult:176]))
			
		End if 
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_EditingInspection_B))
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (User in group:C338(Current user:C182; "Design Access Group"))
				$Entry_b:=True:C214
			: (Read only state:C362([LSS_UtResult:176]))
			Else 
				$Entry_b:=True:C214
				
		End case 
		OBJECT SET ENABLED:C1123(*; "bValidate"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete"; $Entry_b)
		
		LSS_SetEntryColor(->[LSS_UtResult:176])
		
End case 
//End FM_UTResult