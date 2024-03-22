//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/25/14, 10:42:46
//----------------------------------------------------
//Method: FM_DMeterInput
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
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
		//GET FORM PROPERTIES([LSS_DMeter];"Input";$Width_L;$Height_L)
		//GET WINDOW RECT($l;$t;$r;$b)
		//SET WINDOW RECT($l;$t;$l+$Width_L+5;$t+$Height_L+20)
		
		InitChangeStack(4)  //[LSS_DMeter]
		
		If (Is new record:C668([LSS_DMeter:161]))
			LSS_SetUpButtonsForNewRecords
			[LSS_DMeter:161]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			
			[LSS_DMeter:161]LSS_InspectionId_s:2:=[LSS_Inspection:164]LSS_InspectionId_s:1
			C_LONGINT:C283($ID_L)
			Inc_Sequence("LSS_DMeterId_s"; ->$ID_L)
			[LSS_DMeter:161]LSS_DMeterId_s:1:=String:C10($ID_L; <>KeyMask_s)
			
		Else 
			LSS_SetPrevNextButtons(LSS_SelectedRow_L; Records in selection:C76([LSS_DMeter:161]))
			
		End if 
		OBJECT SET RGB COLORS:C628(*; "LSS_DMeterId_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_DMeterId_s";<>Color_Not_Editable)
		OBJECT SET RGB COLORS:C628(*; "LSS_InspectionId_s"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"LSS_InspectionId_s";<>Color_Not_Editable)
		OBJECT SET ENTERABLE:C238(*; "LSS_DMeterId_s"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "LSS_InspectionId_s"; False:C215)
		LSS_SetEntryColor(->[LSS_DMeter:161])
		C_BOOLEAN:C305($Entry_b)
		$Entry_b:=False:C215
		Case of 
			: (Not:C34(LSS_AllowInspectionEdit_B))
			: (Read only state:C362([LSS_DMeter:161]))
				
			Else 
				$Entry_b:=True:C214
				
		End case 
		OBJECT SET ENABLED:C1123(*; "bValidate@"; $Entry_b)
		OBJECT SET ENABLED:C1123(*; "bDelete@"; $Entry_b)
		
End case 
//End FM_DMeterInput

