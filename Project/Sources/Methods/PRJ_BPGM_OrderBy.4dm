//%attributes = {"invisible":true}
//Method: PRJ_BPGM_OrderBy
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
ORDER BY:C49(Current form table:C627->)
If (OK=1)
	If (Size of array:C274(v_115_002_aL)>0)
		PRJ_SetupListBoxDisplayEvent
	Else 
		PRJ_BPGM_LoadArrays
		ut_SetSortColumns(PRJ_BPGM_NumSort_L; 0)  //we don't know what got sorted from our columns
	End if 
	PRJ_BPGM_WinTitle
End if 


//End method PRJ_BPGM_OrderBy