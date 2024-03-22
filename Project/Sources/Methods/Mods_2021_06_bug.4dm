//%attributes = {"invisible":true}
//Method: Mods_2021_06_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/21, 09:21:26
	// ----------------------------------------------------
	//Created : 
	Mods_2021_06_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(6/14/21)
// Modified Method(s) : 
// ut_SQLDownloadNewRecords - copied form v15
//  `moved ut_SQLLogout before the final dialogue if transfers, 
//  ` before the message if there are NRC entries, and before the last error checksa
// ut_DelayDBSynch - copied form v15
//  `use AddToDateTime to find the next launch date and time
//  `add use of system parameter TransfExcludeTimes to specify a time span when trsnfers should not be run

//```
//```    **** End of Release 7.3.1.d 15-Jun-2021
//```

//End Mods_2021_06_bug