//%attributes = {"invisible":true}
//Method: NTI_OpenElement
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:07:53
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_OpenElement; $1)
	
End if 
//
C_POINTER:C301($1)

C_LONGINT:C283($loadoption_L)
If (vbInspectionLocked)
	$loadoption_L:=2
	READ ONLY:C145($1->)
	LOAD RECORD:C52($1->)
	
Else 
	$loadoption_L:=ut_LoadRecordInteractiveV2($1)
End if 
Case of 
	: ($loadoption_L=2)
		//read only
		DIALOG:C40($1->; "Input")
	: ($loadoption_L=1)
		MODIFY RECORD:C57($1->)
End case 

//End NTI_OpenElement