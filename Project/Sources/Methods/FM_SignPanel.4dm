//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/20/14, 15:46:57
//----------------------------------------------------
//Method: FM_SignPanel
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_03  // 
	//Modified by: administrator (11/20/14 15:46:58)
	Mods_2018_11  // Change code from
	//_ o _ENABLE BUTTON and _ o _DISABLE to
	//OBJECT SET ENABLED
	//Modified by: Chuck Miller (11/19/18 12:28:01)
End if 
C_LONGINT:C283($FormEvent_L; $Choice_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		//C_LONGINT($l;$t;$r;$b;$Width_L;$Height_L)
		//GET FORM PROPERTIES([LSS_SignPanel];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		
		InitChangeStack(6)  //[LSS_SignPanel]
		If (Is new record:C668([LSS_SignPanel:172]))
			LSS_SetUpButtonsForNewRecords
			[LSS_SignPanel:172]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			C_LONGINT:C283($Key_L)
			Inc_Sequence("LSS_SignPanelId_s"; ->$Key_L)
			[LSS_SignPanel:172]LSS_SignPanelId_s:1:=String:C10($Key_L; <>KeyMask_s)
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_SignPanel:172]))
		End if 
		LSS_SetEntryColor(->[LSS_SignPanel:172])
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_SignPanel:172]))
				
			Else 
				$Entry_b:=True:C214
				
		End case 
		If (Size of array:C274(LSS_SignPanel_as)=0)
			APPEND TO ARRAY:C911(LSS_SignPanel_as; "")
			APPEND TO ARRAY:C911(LSS_SignPanel_as; "Aluminum")
			APPEND TO ARRAY:C911(LSS_SignPanel_as; "Steel")
			APPEND TO ARRAY:C911(LSS_SignPanel_as; "Other")
		End if 
		OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "LSS_SignPanel_as"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete"; $Entry_b)
		
		
		
End case 
//End FM_SignPanel