//%attributes = {"invisible":true,"publishedSql":true,"executedOnServer":true}
//Method: ut_ReturnRecordCountViaSQL
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/14/20, 15:32:46
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug  //Modified to use new funciton to return number of expected records
	//Modified by: CJ (1/21/20 11:11:11)
	Mods_2020_03  //Fix issue with clone call to return record counts for
	//[Standard Photos] and [ElementsSafety]
End if 
//


$0:=FN_ReturnRecordCount($1)



//End ut_ReturnRecordCountViaSQL