If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 09:54:55
	// ----------------------------------------------------
	// Method: Form Method: Input
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: costasmanousakis-(Designer)-(11/2/10 16:12:22)
	Mods_2010_11
	//  `Changed num of chars MHDDB_NumCodeChars to 1 - added entry filter MHDDB_CodeFilter_txt
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_POINTER:C301(MHDDB_TABLE; MHDDB_KeyFld; MHDDB_DescFld)
		MHDDB_TABLE:=->[Design Load:6]
		MHDDB_KeyFld:=->[Design Load:6]Code:1
		MHDDB_DescFld:=->[Design Load:6]Description:2
		C_LONGINT:C283(MHDDB_NumCodeChars)
		MHDDB_NumCodeChars:=1
		C_TEXT:C284(MHDDB_CodeFilter_txt)
		MHDDB_CodeFilter_txt:="~@#"
End case 
MHDDB_LookupTbl_FM