If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/01/05, 15:56:34
	// ----------------------------------------------------
	// Method: Form Method: TownLineOUT
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM14
End if 

Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		C_TEXT:C284(sBDEPT)  // Command Replaced was o_C_STRING length was 80
		sBDEPT:=[TownLineInfo:73]BDEPT:2
		sBDEPT:=Replace string:C233(sBDEPT; " "; "")
		If (Length:C16(sBDEPT)=0)
			sBDEPT:=6*"_"
		End if 
End case 
