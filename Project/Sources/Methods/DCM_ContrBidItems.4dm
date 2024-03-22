//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/15/09, 10:27:33
	// ----------------------------------------------------
	// Method: DCM_ContrBidItems
	// Description
	// 
	// 
	// Parameters
	// $1  : $Action_txt ("LOAD" | "SAVE" | "CALCSUM" | "SUMWOS"
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(9/13/10 16:47:04)
	Mods_2010_09
	//  `Additions for bid items used 
	// Modified by: costasmanousakis-(Designer)-(12/13/10 10:57:11)
	Mods_2010_12
	//  `Fixes additions for Bid Item Calculations ; additional Bid Items
End if 
C_TEXT:C284($1; $Action_txt)
$Action_txt:=$1
Case of 
	: ($Action_txt="LOAD")
		//AE Data
		ARRAY TEXT:C222(ITMLB_AE_ItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
		ARRAY TEXT:C222(ITMLB_AE_ItemUnit_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(ITMLB_AE_ItemDesc_atxt; 0)
		ARRAY REAL:C219(ITMLB_AE_ItemQ_ar; 0)  //quantity in Contract
		ARRAY REAL:C219(ITMLB_AE_ItemPrice_ar; 0)
		
		//Data Entry  arrays
		ARRAY REAL:C219(ITMLB_ItemQEnt_ar; 0)  //quantity used
		ARRAY REAL:C219(ITMLB_ItemQRem_ar; 0)  //quantity remaining
		ARRAY REAL:C219(ITMLB_ItemQOEst_ar; 0)  //office estimate
		ARRAY REAL:C219(ITMLB_ItemQCEst_ar; 0)  //contractor's estimate
		
		//Merged  arrays - first are copies of AE data; then ItemQ can be modified for 999 items;
		// and more 999 items can be added
		ARRAY TEXT:C222(ITMLB_ItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
		ARRAY TEXT:C222(ITMLB_ItemUnit_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222(ITMLB_ItemDesc_atxt; 0)
		ARRAY REAL:C219(ITMLB_ItemQ_ar; 0)
		ARRAY REAL:C219(ITMLB_ItemPrice_ar; 0)
		
		C_BOOLEAN:C305(DCM_ItemQEntered_b)
		DCM_ItemQEntered_b:=False:C215
		C_LONGINT:C283($offset_L)
		C_REAL:C285(DCM_ItemSum_r; DCM_ItemUsedSum_r; DCM_CO_CEstSum_r; DCM_CO_OEstSum_r)
		DCM_ItemSum_r:=0
		DCM_ItemUsedSum_r:=0
		DCM_CO_CEstSum_r:=0
		DCM_CO_OEstSum_r:=0
		$offset_L:=0
		If (BLOB size:C605([PRJ_ConstructionProject:116]CP_AEData_blb:21)>0)
			C_BLOB:C604($SQLArrays_x; $LocalArrays_x)
			C_LONGINT:C283($offset_L)
			$offset_L:=0
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; $SQLArrays_x; $offset_L)
			BLOB TO VARIABLE:C533([PRJ_ConstructionProject:116]CP_AEData_blb:21; $LocalArrays_x; $offset_L)
			
			$offset_L:=0
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemNos_as; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemUnit_as; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemDesc_atxt; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemQ_ar; $offset_L)
			BLOB TO VARIABLE:C533($SQLArrays_x; ITMLB_AE_ItemPrice_ar; $offset_L)
			
			If (BLOB size:C605($LocalArrays_x)>0)
				$offset_L:=0
				
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemNos_as; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemQEnt_ar; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemQOEst_ar; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemQCEst_ar; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemQ_ar; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemUnit_as; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemDesc_atxt; $offset_L)
				BLOB TO VARIABLE:C533($LocalArrays_x; ITMLB_ItemPrice_ar; $offset_L)
				If (Size of array:C274(ITMLB_ItemQ_ar)>0)
					//All should be OK
				Else 
					//this is previous version of storing info
					ARRAY TEXT:C222(ITMLB_ItemUnit_as; Size of array:C274(ITMLB_ItemNos_as))  //Command Replaced was o_ARRAY string length was 3
					ARRAY TEXT:C222(ITMLB_ItemDesc_atxt; Size of array:C274(ITMLB_ItemNos_as))
					ARRAY REAL:C219(ITMLB_ItemQ_ar; Size of array:C274(ITMLB_ItemNos_as))
					ARRAY REAL:C219(ITMLB_ItemPrice_ar; Size of array:C274(ITMLB_ItemNos_as))
					C_LONGINT:C283($loop_L; $PosInAEList_L)
					For ($loop_L; 1; Size of array:C274(ITMLB_ItemNos_as))
						$PosInAEList_L:=Find in array:C230(ITMLB_AE_ItemNos_as; ITMLB_ItemNos_as{$loop_L})
						If ($PosInAEList_L>0)
							ITMLB_ItemUnit_as{$loop_L}:=ITMLB_AE_ItemUnit_as{$PosInAEList_L}
							ITMLB_ItemDesc_atxt{$loop_L}:=ITMLB_AE_ItemDesc_atxt{$PosInAEList_L}
							ITMLB_ItemQ_ar{$loop_L}:=ITMLB_AE_ItemQ_ar{$PosInAEList_L}
							ITMLB_ItemPrice_ar{$loop_L}:=ITMLB_AE_ItemPrice_ar{$PosInAEList_L}
						Else 
							ITMLB_ItemUnit_as{$loop_L}:=""
							ITMLB_ItemDesc_atxt{$loop_L}:=""
							ITMLB_ItemQ_ar{$loop_L}:=0
							ITMLB_ItemPrice_ar{$loop_L}:=0
						End if 
						
					End for 
					
				End if 
				
			Else 
				COPY ARRAY:C226(ITMLB_AE_ItemNos_as; ITMLB_ItemNos_as)
				COPY ARRAY:C226(ITMLB_AE_ItemUnit_as; ITMLB_ItemUnit_as)
				COPY ARRAY:C226(ITMLB_AE_ItemDesc_atxt; ITMLB_ItemDesc_atxt)
				COPY ARRAY:C226(ITMLB_AE_ItemQ_ar; ITMLB_ItemQ_ar)
				COPY ARRAY:C226(ITMLB_AE_ItemPrice_ar; ITMLB_ItemPrice_ar)
				
				ARRAY REAL:C219(ITMLB_ItemQEnt_ar; Size of array:C274(ITMLB_ItemNos_as))
				ARRAY REAL:C219(ITMLB_ItemQOEst_ar; Size of array:C274(ITMLB_ItemNos_as))
				ARRAY REAL:C219(ITMLB_ItemQCEst_ar; Size of array:C274(ITMLB_ItemNos_as))
				
			End if 
			
			ARRAY REAL:C219(ITMLB_ItemQRem_ar; Size of array:C274(ITMLB_ItemNos_as))
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(ITMLB_ItemNos_as))
				ITMLB_ItemQRem_ar{$loop_L}:=ITMLB_ItemQ_ar{$loop_L}-ITMLB_ItemQEnt_ar{$loop_L}
			End for 
			
			SORT ARRAY:C229(ITMLB_ItemNos_as; ITMLB_ItemUnit_as; ITMLB_ItemDesc_atxt; ITMLB_ItemQ_ar; ITMLB_ItemPrice_ar; ITMLB_ItemQEnt_ar; ITMLB_ItemQOEst_ar; ITMLB_ItemQCEst_ar; ITMLB_ItemQRem_ar)
			
			SET BLOB SIZE:C606($SQLArrays_x; 0)
			SET BLOB SIZE:C606($LocalArrays_x; 0)
		End if 
		LISTBOX SELECT ROW:C912(LineItems_lb; 0; lk remove from selection:K53:3)
		DCM_ContrBidItems("CALCSUM")
		
	: ($Action_txt="SAVE")
		If (ut_LoadRecordInteractive(->[PRJ_ConstructionProject:116]))
			C_BLOB:C604($SQLArrays_x; $LocalArrays_x)
			SET BLOB SIZE:C606($SQLArrays_x; 0)
			VARIABLE TO BLOB:C532(ITMLB_AE_ItemNos_as; $SQLArrays_x)
			VARIABLE TO BLOB:C532(ITMLB_AE_ItemUnit_as; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_AE_ItemDesc_atxt; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_AE_ItemQ_ar; $SQLArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_AE_ItemPrice_ar; $SQLArrays_x; *)
			
			SET BLOB SIZE:C606($LocalArrays_x; 0)
			VARIABLE TO BLOB:C532(ITMLB_ItemNos_as; $LocalArrays_x)
			VARIABLE TO BLOB:C532(ITMLB_ItemQEnt_ar; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemQOEst_ar; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemQCEst_ar; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemQ_ar; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemUnit_as; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemDesc_atxt; $LocalArrays_x; *)
			VARIABLE TO BLOB:C532(ITMLB_ItemPrice_ar; $LocalArrays_x; *)
			
			SET BLOB SIZE:C606([PRJ_ConstructionProject:116]CP_AEData_blb:21; 0)
			VARIABLE TO BLOB:C532($SQLArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21)
			VARIABLE TO BLOB:C532($LocalArrays_x; [PRJ_ConstructionProject:116]CP_AEData_blb:21; *)
			SAVE RECORD:C53([PRJ_ConstructionProject:116])
			SET BLOB SIZE:C606($SQLArrays_x; 0)
			SET BLOB SIZE:C606($LocalArrays_x; 0)
		Else 
			ALERT:C41("Could not save the Quantity Additions to the Bid Items! The needed Construction C"+"ontract record is locked!!!")
		End if 
		
	: ($Action_txt="CALCSUM")
		C_LONGINT:C283($loop_L)
		DCM_ItemUsedSum_r:=0
		DCM_ItemSum_r:=0
		DCM_CO_CEstSum_r:=0
		DCM_CO_OEstSum_r:=0
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemPrice_ar))
			DCM_ItemUsedSum_r:=DCM_ItemUsedSum_r+(ITMLB_ItemPrice_ar{$loop_L}*ITMLB_ItemQEnt_ar{$loop_L})
			DCM_ItemSum_r:=DCM_ItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*ITMLB_ItemQ_ar{$loop_L})
			DCM_CO_CEstSum_r:=DCM_CO_CEstSum_r+(ITMLB_ItemPrice_ar{$loop_L}*ITMLB_ItemQCEst_ar{$loop_L})
			DCM_CO_OEstSum_r:=DCM_CO_OEstSum_r+(ITMLB_ItemPrice_ar{$loop_L}*ITMLB_ItemQOEst_ar{$loop_L})
		End for 
		
	: ($Action_txt="SUMWOS")
		C_BOOLEAN:C305($WOROState_b)
		If (Read only state:C362([DCM_WorkOrders:137]))
			$WOROState_b:=True:C214
		Else 
			READ ONLY:C145([DCM_WorkOrders:137])
			$WOROState_b:=False:C215
		End if 
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemQEnt_ar))
			ITMLB_ItemQEnt_ar{$loop_L}:=0
			ITMLB_ItemQOEst_ar{$loop_L}:=0
			ITMLB_ItemQCEst_ar{$loop_L}:=0
		End for 
		COPY NAMED SELECTION:C331([DCM_WorkOrders:137]; "PRESUMWORKORDERS")
		QUERY:C277([DCM_WorkOrders:137]; [DCM_WorkOrders:137]ContractNo:1=[DCM_Contracts:136]ContractNo:1)
		FIRST RECORD:C50([DCM_WorkOrders:137])
		While (Not:C34(End selection:C36([DCM_WorkOrders:137])))
			DCM_ControlWOBlobs("INIT")
			QUERY:C277([DCM_Project:138]; [DCM_Project:138]AssignID:13=[DCM_WorkOrders:137]AssignID:3)
			DCM_PROJITEMS_CTRL("CALCALL")
			For ($loop_L; 1; Size of array:C274(DCM_WO_ItemQActual_ar))
				ITMLB_ItemQEnt_ar{$loop_L}:=ITMLB_ItemQEnt_ar{$loop_L}+DCM_WO_ItemQActual_ar{$loop_L}
				ITMLB_ItemQOEst_ar{$loop_L}:=ITMLB_ItemQOEst_ar{$loop_L}+DCM_WO_ItemQOEstimate_ar{$loop_L}
				ITMLB_ItemQCEst_ar{$loop_L}:=ITMLB_ItemQCEst_ar{$loop_L}+DCM_WO_ItemQCEstimate_ar{$loop_L}
			End for 
			NEXT RECORD:C51([DCM_WorkOrders:137])
		End while 
		
		USE NAMED SELECTION:C332("PRESUMWORKORDERS")
		CLEAR NAMED SELECTION:C333("PRESUMWORKORDERS")
		
		If (Not:C34($WOROState_b))
			READ WRITE:C146([DCM_WorkOrders:137])
		End if 
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemQ_ar))
			ITMLB_ItemQRem_ar{$loop_L}:=ITMLB_ItemQ_ar{$loop_L}-ITMLB_ItemQEnt_ar{$loop_L}
		End for 
		
		DCM_ContrBidItems("CALCSUM")
		[DCM_Contracts:136]ActualSpent:18:=[DCM_Contracts:136]ActualSpent:18  //modify Contracts record
		
	Else 
		ALERT:C41("Application error! Unknown argument to "+Current method name:C684+" :<"+$Action_txt+"> !!!!")
End case 