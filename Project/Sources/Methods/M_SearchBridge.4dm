//%attributes = {"invisible":true}
If (False:C215)
	//GP: SEARCH_BRIDGE
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//This procedure searches a for a match given BDEPT, Bridge Key and BIN
	
	// Modified by: costasmanousakis-(Designer)-(11/24/2006 17:29:16)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(4/3/08 16:31:03)
	Mods_2008_CM_5403
End if 
SRC_SearchByBridge(->[Bridge MHD NBIS:1]; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2)
C_TEXT:C284(GEN_SORTLISTCMD_txt)
If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 