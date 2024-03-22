//%attributes = {"invisible":true}
If (False:C215)
	
	//7/15/2003: Copied and modified M_SearchBridgeinConsltRating 
	//This procedure searches a for a match in [Cons Inspection] table 
	//given BDEPT and BIN
	
	// Modified by: costasmanousakis-(Designer)-(11/27/2006 08:32:58)
	Mods_2006_CM07
End if 
SRC_SearchByBridge(->[Cons Inspection:64]; ->[Cons Inspection:64]BIN:1; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2)