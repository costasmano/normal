//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/11/11, 13:51:18
	// ----------------------------------------------------
	// Method: Method: M_MHS
	// Description
	// Show MHS funded bridges
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_01
End if 
QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]FundingSource:228="MHS")
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 
RegionTitle