//Method: Form Method: [SD_History]SummaryHeader.rpt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/27/14, 16:55:59
	// ----------------------------------------------------
	//Created : 
	Mods_2014_06_bug
	//changed name of Detail Report chk box to a process var assigned on printing detail
	
End if 
//
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		SD_Detail_Prt_l:=<>SD_Detail_l
		
End case 

//End Form Method: [SD_History]SummaryHeader.rpt