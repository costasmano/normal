//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 09:50:48
	// ----------------------------------------------------
	// Method: MHDDB_LookupCode_OM
	// Description
	//  `Method that handles the object method called from the keyfields oninput forms in lookup tables
	//  `such as Design Load, Design, 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($OtherOnes_L)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $OtherOnes_L)
		QUERY:C277(MHDDB_TABLE->; MHDDB_KeyFld->=MHDDB_KeyFld->)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($OtherOnes_L>0)
			ALERT:C41("There are other records with code "+MHDDB_KeyFld->+"! Try another code!")
			MHDDB_KeyFld->:=""
			GOTO OBJECT:C206(MHDDB_KeyFld->)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 