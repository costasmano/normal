//%attributes = {"invisible":true}
If (False:C215)
	
	//6/26/2003: Copied and modified M_SearchBridge 
	//This procedure searches a for a match in [Conslt Rating] table given BDEPT and B
	// Modified by: costasmanousakis-(Designer)-(11/27/2006 09:23:50)
	Mods_2006_CM07
End if 
SRC_SearchByBridge(->[Conslt Rating:63]; ->[Conslt Rating:63]BIN:1; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2)