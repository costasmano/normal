//%attributes = {"invisible":true}
//Method: Mods_2019_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 02/04/19, 12:20:39
	// ----------------------------------------------------
	//Created : 
	Mods_2019_02
End if 
//
//Change lss inspection input forms to use subforms wherever possible
//LSS_ControlUT 
//LSS_GotToInspectionPage 
//LSS_SelectUTResults

//[LSS_Inspection];"UltraSonicSubForm"
//[LSS_Inspection];"PhotoSubFormLB"
//[LSS_Inspection];"Input_Signal"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"DMeterSubForm"
//LSS_SelectUTResults 
//LSS_GotToInspectionPage 
//LSS_ControlUT 
//LB_ProcessLSSElementQuery
//Deleted following forms as they are not used
//[LSS_Inspection](LSS_InspectUltraSubForm)
//[LSS_Inspection](LSS_InspectDMeterSubForm)

//Bring over code to development from bug fix
//LSS_CountandPrintDamagePages
//End Mods_2019_02