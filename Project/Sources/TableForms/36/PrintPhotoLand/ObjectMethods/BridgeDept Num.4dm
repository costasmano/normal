If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/24/05, 08:27:37
	// ----------------------------------------------------
	// Method: Object Method: sBDEPT
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM15
End if 
Case of 
	: (Length:C16(sBDEPT)>13)
		OBJECT SET FONT SIZE:C165(*; "BridgeDept Num"; 10)
End case 