//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 09:50:14
	// ----------------------------------------------------
	// Method: MHDDB_LookupTbl_FM 
	// Description
	//  `Method that handles the form method called from input forms in lookup tables
	//  `such as Design Load, Design, 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: costasmanousakis-(Designer)-(11/2/10 16:14:07)
	Mods_2010_11
	// `Added use of new filter variable code - init of ptr_Changes array
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305(MHDDB_NewRecord)
		C_TEXT:C284(MHDDB_CodeFilter_txt)
		If (Is new record:C668(MHDDB_TABLE->))
			MHDDB_NewRecord:=True:C214
			OBJECT SET ENTERABLE:C238(MHDDB_KeyFld->; True:C214)
			OBJECT SET RGB COLORS:C628(MHDDB_KeyFld->; Col_paletteToRGB(Abs:C99(<>Color_Editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Editable)\256))  // **Replaced o OBJECT SET COLOR(MHDDB_KeyFld->; <>Color_Editable)
			If (MHDDB_CodeFilter_txt#"")
				OBJECT SET FILTER:C235(MHDDB_KeyFld->; MHDDB_CodeFilter_txt)
			Else 
				OBJECT SET FILTER:C235(MHDDB_KeyFld->; "!0&9"+("#"*MHDDB_NumCodeChars))
			End if 
			
		Else 
			MHDDB_NewRecord:=False:C215
			OBJECT SET ENTERABLE:C238(MHDDB_KeyFld->; False:C215)
			OBJECT SET RGB COLORS:C628(MHDDB_KeyFld->; Col_paletteToRGB(Abs:C99(<>Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR(MHDDB_KeyFld->; <>Color_Not_editable)
		End if 
		If (Type:C295(ptr_Changes)#Array 2D:K8:24)
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
		End if 
		InitChangeStack(1)
		
	: (Form event code:C388=On Validate:K2:3)
		If (MHDDB_NewRecord)
			LogNewRecord(MHDDB_KeyFld; MHDDB_KeyFld; MHDDB_KeyFld; 0; "")
		End if 
		FlushGrpChgs(1; MHDDB_KeyFld; MHDDB_KeyFld; MHDDB_KeyFld; 0)
		
	: (Form event code:C388=On Unload:K2:2)
		MHDDB_CodeFilter_txt:=""
End case 