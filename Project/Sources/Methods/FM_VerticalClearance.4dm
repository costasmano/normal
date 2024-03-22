//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/14/15, 15:53:38
//----------------------------------------------------
//Method: FM_VerticalClearance
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 15:53:42)
	
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		InitChangeStack(11)  //[LSS_VerticalClearance]
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_VerticalClearance];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		If (Is new record:C668([LSS_VerticalClearance:177]))
			
			C_LONGINT:C283($ID_L)
			OBJECT SET VISIBLE:C603(*; "bFirst"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bPrevious"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bNext"; False:C215)
			OBJECT SET VISIBLE:C603(*; "bLast"; False:C215)
			Inc_Sequence("LSS_VerticalClearanceId_s"; ->$ID_L)
			[LSS_VerticalClearance:177]LSS_VerticalClearanceId_s:1:=String:C10($ID_L; <>KeyMask_s)
			[LSS_VerticalClearance:177]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			LSS_SetUpButtonsForNewRecords
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_VerticalClearance:177]))
			
			
		End if 
		LSS_SetEntryColor(->[LSS_VerticalClearance:177])
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_VerticalClearance:177]))
			: (User in group:C338(Current user:C182; "Design Access Group"))
				$Entry_b:=True:C214
			Else 
				$Entry_b:=True:C214
				
		End case 
		If ($Entry_b)
			OBJECT SET ENABLED:C1123(*; "bDelete"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bValidate"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "bDelete"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "bValidate"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		
		
End case 
//End FM_VerticalClearance

