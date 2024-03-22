//Method: [ElementsSafety];"ElementSafetyTunnelS_SUB"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 05/01/19, 13:57:36
	// ----------------------------------------------------
	//Created : 
	Mods_2019_05
End if 
//
If ([Inspections:27]Insp Type:6="TSP")
	OBJECT SET VISIBLE:C603(*; "InspectionType"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "InspectionType"; True:C214)
	
End if 
INSP_ElemSftySUB_FM
//End [ElementsSafety];"ElementSafetyTunnelS_SUB"