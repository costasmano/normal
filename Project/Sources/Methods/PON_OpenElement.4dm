//%attributes = {"invisible":true}
//Method: PON_OpenElement
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/05/15, 10:45:02
	// ----------------------------------------------------
	//Created : 
	Mods_2015_03
End if 
//
C_LONGINT:C283($loadoption_L)
If (vbInspectionLocked)
	$loadoption_L:=2
	READ ONLY:C145([PON_ELEM_INSP:179])
	LOAD RECORD:C52([PON_ELEM_INSP:179])
	
Else 
	$loadoption_L:=ut_LoadRecordInteractiveV2(->[PON_ELEM_INSP:179])
End if 
Case of 
	: ($loadoption_L=2)
		//read only
		DIALOG:C40([PON_ELEM_INSP:179]; "Input")
	: ($loadoption_L=1)
		MODIFY RECORD:C57([PON_ELEM_INSP:179])
End case 

//End PON_OpenElement