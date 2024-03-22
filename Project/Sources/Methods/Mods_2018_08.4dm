//%attributes = {"invisible":true}
//Method: Mods_2018_08
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/28/18, 15:23:04
	// ----------------------------------------------------
	//Created : 
	Mods_2018_08
End if 
//
//WORK ON LSS DAMAGE FORMS


//Turn element page into a sub form
//[LSS_Inspection];"ElementSubFormLB"

//Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
//MissingSetError 
//LSS_AddUTResultRecord
//FM_UTResults 
//LSS_SelectUTResults 
//LSS_ModifyUTResults 
//LSS_GotToInspectionPage
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Signal"


//End Mods_2018_08