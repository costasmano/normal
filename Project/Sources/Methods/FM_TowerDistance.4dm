//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/14/15, 17:12:30
//----------------------------------------------------
//Method: FM_TowerDistance
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/14/15 17:12:32)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
C_LONGINT:C283($FormEvent_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_TowerDistance];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		
		InitChangeStack(8)  //[LSS_TowerDistance]
		If (Is new record:C668([LSS_TowerDistance:174]))
			C_LONGINT:C283($ID_L)
			Inc_Sequence("LSS_TowerDistanceId_s"; ->$ID_L)
			[LSS_TowerDistance:174]LSS_TowerDistanceId_s:1:=String:C10($ID_L; <>KeyMask_s)
			[LSS_TowerDistance:174]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			LSS_SetUpButtonsForNewRecords
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_TowerDistance:174]))
			
		End if 
		LSS_SetEntryColor(->[LSS_TowerDistance:174])
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_TowerDistance:174]))
				
			Else 
				$Entry_b:=True:C214
				
		End case 
		OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
		
		
End case 
//End FM_TowerDistance

