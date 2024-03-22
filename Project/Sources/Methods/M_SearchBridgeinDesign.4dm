//%attributes = {"invisible":true}
If (False:C215)
	
	//7/15/2003: Copied and modified M_SearchBridge 
	//Searches a for a match in [Bridge Design] table given BDEPT and BIN
	
	// Modified by: costasmanousakis-(Designer)-(11/27/2006 09:26:11)
	Mods_2006_CM07
End if 
SRC_SearchByBridge(->[Bridge Design:75]; ->[Bridge Design:75]BIN:1; ->[Bridge MHD NBIS:1]BDEPT:1; ->[Bridge MHD NBIS:1]Bridge Key:2)