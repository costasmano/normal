//%attributes = {"invisible":true}
//Method: PRJ_BPGM_ShowSubset
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/01/20, 13:13:39
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27) 
End if 
If (Records in set:C195("UserSet")>0)
	USE SET:C118("UserSet")
	
	If (Size of array:C274(v_115_002_aL)>0)
		PRJ_SetupListBoxDisplayEvent
	Else 
		
		PRJ_BPGM_LoadArrays
		PRJ_BPGM_DoSort  //re-apply current sort
	End if 
	PRJ_BPGM_WinTitle
Else 
	ALERT:C41("No Records Selected!!")
End if 


//End method PRJ_BPGM_ShowSubset