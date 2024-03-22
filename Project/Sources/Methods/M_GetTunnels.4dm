//%attributes = {"invisible":true}
//Method: M_GetTunnels
//Description
// Get the Tunnel Records
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/13, 09:50:14
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
End if 
//
QUERY SELECTION:C341(pFile->; [Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL@"; *)  //x
QUERY SELECTION:C341(pFile->;  | ; [Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS@")  //x
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle
//End M_GetTunnels