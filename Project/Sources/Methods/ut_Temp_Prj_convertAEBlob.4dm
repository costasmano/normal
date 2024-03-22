//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/11/10, 14:41:08
	// ----------------------------------------------------
	// Method: ut_Temp_Prj_convertAEBlob
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_06
	//  `Method to convert the [PRJ_ConstructionProject]CP_AEData_blb data in the new format that includes
	//  `the data from the sql database and what is modified in 4D
End if 

If (Current user:C182="Designer")
	//Convert the constr contr AE  Bid Item blob to new 'format'
	QUERY:C277([PRJ_ConstructionProject:116])
	TRACE:C157
	C_BLOB:C604($SQLArrays_x; $LocalArrays_x)
	ARRAY TEXT:C222(ITMLB_ItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
	ARRAY TEXT:C222(ITMLB_ItemUnit_as; 0)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222(ITMLB_ItemDesc_atxt; 0)
	ARRAY REAL:C219(ITMLB_ItemQ_ar; 0)
	ARRAY REAL:C219(ITMLB_ItemPrice_ar; 0)
	ARRAY REAL:C219(ITMLB_ItemQEnt_ar; 0)
	
	C_LONGINT:C283($offset_L)
	
	FIRST RECORD:C50([PRJ_ConstructionProject:116])
	While (Not:C34(End selection:C36([PRJ_ConstructionProject:116])))
		If (BLOB size:C605([PRJ_ConstructionProject:116]CP_AEData_blb:21)>0)
			$offset_L:=0
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; ITMLB_ItemNos_as; $offset_L)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; ITMLB_ItemUnit_as; $offset_L)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; ITMLB_ItemDesc_atxt; $offset_L)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; ITMLB_ItemQ_ar; $offset_L)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; ITMLB_ItemPrice_ar; $offset_L)
			SET BLOB SIZE:C606($SQLArrays_x; 0)
			SET BLOB SIZE:C606($LocalArrays_x; 0)
			VARIABLE TO BLOB:C532(ITMLB_ItemNos_as; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemUnit_as; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemDesc_atxt; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemQ_ar; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemPrice_ar; $SQLArrays_x; *)
			
			VARIABLE TO BLOB:C532(ITMLB_ItemNos_as; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemQ_ar; $LocalArrays_x; *)
			
			VARIABLE TO BLOB:C532($SQLArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21)
			VARIABLE TO BLOB:C532($LocalArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21; *)
			
			SAVE RECORD:C53([PRJ_ConstructionProject:116])
		End if 
		
		NEXT RECORD:C51([PRJ_ConstructionProject:116])
	End while 
	
End if 
