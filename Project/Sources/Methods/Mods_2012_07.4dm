//%attributes = {"invisible":true}
//Method: Mods_2012_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/12, 16:36:43
	// ----------------------------------------------------
	//Created : 
	Mods_2012_07
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(7/6/12)
// Modified Method(s) : 
//G_SortTable_new
//  `When removing the ending _x(xxx) from the field names verify that the field type matches the name extension

// Modified Object Methods : 
//Object Method: [Cons Inspection].View Cslt Insp.SortInspMonth 
//  `When sorting by insp month include the bdept and bin in the sort.

// Modified Method(s) : 
//ut_SQLCheckExternalTransfer
//ut_SQLReturnINSActRecords
//  `Added READ ONLY (*) at the  start

//**********`Modified by: Costas Manousakis-(Designer)-(7/9/12)
// Modified Method(s) : 
//INSP_PrintInspBtn_OM
//  `Removed the "CANCEL" command if the inspection should not be printed

//*********
//********* End of release 6.0.7
//*********

//End Mods_2012_07