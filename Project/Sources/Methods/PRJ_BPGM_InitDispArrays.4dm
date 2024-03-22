//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/06/07, 15:41:35
	// ----------------------------------------------------
	// Method: PRJ_BPGM_InitDispArrays
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(5/21/10 11:31:42)
	Mods_2010_05
	//  `Added array PRJ_BPGMAdDate_aD
End if 
ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)
ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(PRJ_DistrNo_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222(PRJ_UnderConstr_aS; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY DATE:C224(PRJ_InitInsp_aD; 0)
ARRAY DATE:C224(PRJ_BPGMAdDate_aD; 0)  //Actual or Sched Ad Date
ARRAY BOOLEAN:C223(PRJ_RatingDone_ab; 0)
