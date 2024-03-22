//%attributes = {"invisible":true}
//Method: Mods_2014_05_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/01/14, 11:51:31
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(5/1/14)
// Modified Method(s) : 
//ut_SRVMonthlyReports
//  `Removed the printing of the MassDOT 5 Dist version of the bridge report

//WRUTIL_Function
//  `to fix crashing bug when  printing comments, added code to remove all negative tabs in the 4D write areas

//**********`Modified by: Costas Manousakis-(Designer)-(5/7/14)
// Modified Method(s) : 
//ut_CreateSQLVariables
//  `fixed case where $arraytoSelect was only an End IF.

//**********`Modified by: Costas Manousakis-(Designer)-(5/12/14)
// Modified Forms : 
//[RatingRequests];"Input"
//  `fixed input filter for dates to match other date fields

//**********`Modified by: Costas Manousakis-(Designer)-(5/13/14)
// Modified Method(s) : 
//ARCH_M_MasterList
//ARCH_M_RPC_Report
//ARCHIVE_OutOfFreq
//  `Adjusted  logic to allow running report if reason and date are not unique in the  selection


//```
//```   **** End of Release 6.3.2 06/02/14
//```

//End Mods_2014_05_bug