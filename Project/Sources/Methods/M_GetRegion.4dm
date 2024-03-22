//%attributes = {"invisible":true}
//GP: GetRegion
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Procedure returns selection to the specified region
//
USE NAMED SELECTION:C332("UserRegionA")
C_TEXT:C284(GEN_SORTLISTCMD_txt)


If (GEN_SORTLISTCMD_txt#"")
	EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
End if 

RegionTitle