//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/03/10, 09:48:26
	// ----------------------------------------------------
	// Method: M_GetRailRoadOnly
	// Description
	// Get the RailRoad Bridges
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_02
End if 

QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO@"; *)  //x
QUERY SELECTION:C341(pFile->;  | ; [Bridge MHD NBIS:1]Item8 BridgeCat:207="TRO@")  //x
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle