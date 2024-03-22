//%attributes = {"invisible":true}
//Method: FM_CondUnitsIn
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/16/19, 13:43:39
	// ----------------------------------------------------
	//Created : 
	
	Mods_2019_05  //New method from form method so we can pass in form event if desired
End if 
//
C_LONGINT:C283($FormEvent_L; $Choice_L)

If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
End if 
C_BOOLEAN:C305(vbinspectionLocked)
Case of 
	: (Form event code:C388=On Load:K2:1) | ($FormEvent_L=On Load:K2:1)
		If (vbinspectionLocked)  // added code here so we can use modify record in subform - table set to read wite whern it really should be read only
			UNLOAD RECORD:C212([Cond Units:45])
			READ ONLY:C145([Cond Units:45])
			LOAD RECORD:C52([Cond Units:45])
			READ WRITE:C146([Cond Units:45])
		End if 
		utl_SetSpellandContextMenu
		If (vbinspectionLocked)
			If (Is new record:C668([Cond Units:45]))
				CANCEL:C270
			Else 
				SETUP_CSs
				OBJECT SET ENTERABLE:C238(*; "DE@"; False:C215)
				OBJECT SET RGB COLORS:C628(*; "DE@"; Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_Editable)\256))  // **Replaced o OBJECT SET COLOR(*;"DE@";<>Color_Not_Editable)
				OBJECT SET ENABLED:C1123(*; "DE@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			End if 
		Else 
			If ([Cond Units:45]Inspection ID:2=0)
				CANCEL:C270
			Else 
				OBJECT SET ENTERABLE:C238(*; "DE@"; True:C214)
				OBJECT SET ENABLED:C1123(*; "DE@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				SETUP_CSs
			End if 
		End if 
		C_LONGINT:C283(INSP_CurrCUID_L; $Row_L)
		INSP_CurrCUID_L:=[Cond Units:45]Cond Unit ID:1
		$Row_L:=Selected record number:C246([Cond Units:45])
		
		//LSS_SetPrevNextButtons ($Row_L;Records in selection([Cond Units]))
	: (Form event code:C388=On Validate:K2:3)
		// ALERT("validated cond un")
End case 
//End FM_CondUnitsIn