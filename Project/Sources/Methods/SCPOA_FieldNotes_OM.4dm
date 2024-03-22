//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/06/09, 10:06:13
	// ----------------------------------------------------
	// Method: SCPOA_FieldNotes_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 

C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
Case of 
	: ($FormEvent=On Load:K2:1)
		SCPOA_FieldNoteCtrl("INIT")
		SCPOA_FieldNoteCtrl("GETNAMES")
		
	: ($FormEvent=On Double Clicked:K2:5)  //Views the field note
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($currItem_L)
			$currItem_L:=SCPOAFieldNotesListBox
			If ($currItem_L>0)
				SCPOA_FLDNOTEDESC_TXT:=SCPOA_FLDNOTENAMES_atxt{$currItem_L}
				SCPOA_FieldNoteCtrl("LOADFROMDB")
				SCPOA_FieldNoteCtrl("VIEW")
			Else 
				
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
		
	: ($FormEvent=On Unload:K2:2)
		SCPOA_FieldNoteCtrl("CLEAR")
End case 