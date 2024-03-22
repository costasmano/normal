//%attributes = {"invisible":true}
//Method: Mods_2019_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/02/19, 10:29:13
	// ----------------------------------------------------
	//Created : 
	Mods_2019_07
	
End if 
//Add code to allow for sorting or NTI review inspections
//Compiler_NTI 
//Compiler_Utilities 


//Change to use the following subforms
//[Standard Photos];"LBStdPhotos"
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"
//[Inspections];"FreezeThaw"
//[Inspections];"FreezeThawA"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"RailRoutineInput"
//[Inspections];"Routine Combined"
//[Inspections];"TunnelDamageForm"
//[Inspections];"TunnelInspection"
//[Inspections];"TunnelOverheadInspection"
//[Inspections];"TunnelSpecial"
//[Inspections];"Underwater Special Member"

//[ElementsSafety];"ElementSafety_SUB"
//[Inspections];"Culvert Combined"
//[Inspections];"PedestrianInspection-PED"
//[Inspections];"RailCulvertCombined-RRC"
//[Inspections];"RailRoutineInput"
//[Inspections];"Routine Combined"

//[ElementsSafety];"ElementSafetyCM_SUB"
//[Inspections];"Critical Member"
//[Inspections];"Damage Form"

//[ElementsSafety];"ElementSafetyDive_SUB"
//[Inspections];"Dive Form"
//[Inspections];"Dive LowCl"

//[ElementsSafety];"ElementSafetyUW_SUB"
//[Inspections];"Underwater Special Member"

//[ElementsSafety];"ElementSafetyTunnel_SUB"
//[Inspections];"TunnelInspection"
//[Inspections];"TunnelOverheadInspection"

//[ElementsSafety];"ElementSafetyTunnelS_SUB"
//[Inspections];"TunnelDamageForm"
//[Inspections];"TunnelSpecial"


//Modify code to save better folder structure when saving methods and to identify Form methdods
//Modified by: Chuck Miller (7/16/19 17:02:22)
//ut_NewSaveMethod 
//ut_OpenMethod


//InitProcessVar

//Added declaration of missing array $RecordNumbers_al
//ConsAddress_sortFunction
//Modified by: Chuck Miller (7/18/19 12:13:19)
//replace inspection review with a list box 
//Modified by: Chuck Miller (7/25/19 15:23:20)
//[Inspections];"InspectionReview_LB"
//Method: Form Method: [Inspections];"InspectionReview"
//P_ReviewInspcts

//Create new list box NewNBIS_StackInfo form to test as width and height changed
//Modified by: Chuck Miller (7/18/19 12:51:34)
//[Bridge MHD NBIS];"NewNBIS_StackInfo"
//ModSelSort
//P_DISTRICT1 
//P_DISTRICT2 
//P_DISTRICT3 
//P_DISTRICT4 
//P_DISTRICT5  
//P_OtherAgc 
//P_MTA 
//P_MPA 
//P_MHD 
//P_MDC 
//P_MBTA
//Compiler_BridgeList
//InitProcessVar
//SIA_BridgeInput_FM 
//NBISStackInfo_FM
//End Mods_2019_07