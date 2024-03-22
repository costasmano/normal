//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/08/10, 11:37:07
	// ----------------------------------------------------
	// Method: DCM_PROJITEMS_CTRL
	// Description
	//  ` Control method for Bridge project items in a work order input form
	// 
	// Parameters
	// $1 : $Task_txt ("CALCALL" | "SAVE" | "INIT")
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/13/10 11:02:24)
	Mods_2010_12
	//  `Fixes For Bid Item quantity calculations
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="CALCALL")
		
		DCM_WO_ItemSum_r:=0
		DCM_WO_CEstSum_r:=0
		DCM_WO_OEstSum_r:=0
		C_LONGINT:C283($loop_L)
		ARRAY REAL:C219($TempStorage_ar; Size of array:C274(DCM_WO_ItemQActual_ar))  //Pick one of the Work order arrays - they should all be same size
		ARRAY REAL:C219($TempStorage2_ar; Size of array:C274(DCM_WO_ItemQActual_ar))
		ARRAY REAL:C219($TempStorage3_ar; Size of array:C274(DCM_WO_ItemQActual_ar))
		For ($loop_L; 1; Size of array:C274(DCM_WO_ItemQActual_ar))
			$TempStorage_ar{$loop_L}:=DCM_WO_ItemQActual_ar{$loop_L}
			DCM_WO_ItemQActual_ar{$loop_L}:=0
			$TempStorage2_ar{$loop_L}:=DCM_WO_ItemQCEstimate_ar{$loop_L}
			DCM_WO_ItemQCEstimate_ar{$loop_L}:=0
			$TempStorage3_ar{$loop_L}:=DCM_WO_ItemQOEstimate_ar{$loop_L}
			DCM_WO_ItemQOEstimate_ar{$loop_L}:=0
		End for 
		
		C_BOOLEAN:C305($PROJROState_b)
		If (Read only state:C362([DCM_Project:138]))
			$PROJROState_b:=True:C214
		Else 
			READ ONLY:C145([DCM_Project:138])
			$PROJROState_b:=False:C215
		End if 
		
		FIRST RECORD:C50([DCM_Project:138])
		While (Not:C34(End selection:C36([DCM_Project:138])))
			DCM_PROJITEMS_CTRL("LOAD")
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(DCM_WO_ItemQActual_ar))
				
				DCM_WO_ItemQActual_ar{$loop_L}:=DCM_WO_ItemQActual_ar{$loop_L}+DCM_P_ITMLB_ItemQEnt_ar{$loop_L}
				DCM_WO_ItemSum_r:=DCM_WO_ItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQEnt_ar{$loop_L})
				DCM_WO_ItemQCEstimate_ar{$loop_L}:=DCM_WO_ItemQCEstimate_ar{$loop_L}+DCM_P_ITMLB_ItemQCEST_ar{$loop_L}
				DCM_WO_CEstSum_r:=DCM_WO_CEstSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQCEST_ar{$loop_L})
				DCM_WO_ItemQOEstimate_ar{$loop_L}:=DCM_WO_ItemQOEstimate_ar{$loop_L}+DCM_P_ITMLB_ItemQOEst_ar{$loop_L}
				DCM_WO_OEstSum_r:=DCM_WO_OEstSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQOEst_ar{$loop_L})
			End for 
			
			NEXT RECORD:C51([DCM_Project:138])
		End while 
		UNLOAD RECORD:C212([DCM_Project:138])
		//This part adjusts the overall bid item quantities used for the whole contract -
		//uses the change in the work order
		C_BOOLEAN:C305(DCM_WO_ITEMQChange_b)
		DCM_WO_ITEMQChange_b:=False:C215
		For ($loop_L; 1; Size of array:C274(DCM_WO_ItemQActual_ar))
			DCM_WO_ITEMQChange_b:=DCM_WO_ITEMQChange_b | (DCM_WO_ItemQActual_ar{$loop_L}#$TempStorage_ar{$loop_L})
			//$TempStorage_ar{$loop_L}:=DCM_WO_ItemQActual_ar{$loop_L}-$TempStorage_ar{$loop_L}
			//ITMLB_ItemQEnt_ar{$loop_L}:=ITMLB_ItemQEnt_ar{$loop_L}+$TempStorage_ar{$loop_L}
		End for 
		If (Not:C34($PROJROState_b))
			READ WRITE:C146([DCM_Project:138])
		End if 
		
	: ($Task_txt="LOAD")
		
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQEnt_ar; 0)
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQCEST_ar; 0)
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQOEst_ar; 0)
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQEnt_ar; Size of array:C274(ITMLB_ItemNos_as))
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQCEST_ar; Size of array:C274(ITMLB_ItemNos_as))
		ARRAY REAL:C219(DCM_P_ITMLB_ItemQOEst_ar; Size of array:C274(ITMLB_ItemNos_as))
		C_REAL:C285(DCM_P_ItemSum_r; DCM_P_CEstItemSum_r; DCM_P_OEstItemSum_r)
		DCM_P_ItemSum_r:=0
		DCM_P_CEstItemSum_r:=0
		DCM_P_OEstItemSum_r:=0
		If (BLOB size:C605([DCM_Project:138]ProjItems_x:16)>0)
			C_LONGINT:C283($offset_L)
			ARRAY TEXT:C222($EntqItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
			ARRAY REAL:C219($EntqItemNos_ar; 0)
			ARRAY REAL:C219($CEstqItemNos_ar; 0)
			ARRAY REAL:C219($OEstqItemNos_ar; 0)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjItems_x:16; $EntqItemNos_as; $offset_L)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjItems_x:16; $EntqItemNos_ar; $offset_L)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjItems_x:16; $CEstqItemNos_ar; $offset_L)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjItems_x:16; $OEstqItemNos_ar; $offset_L)
			C_LONGINT:C283($loop_L; $PosInArray_L)
			For ($loop_L; 1; Size of array:C274(ITMLB_ItemNos_as))
				$PosInArray_L:=Find in array:C230($EntqItemNos_as; ITMLB_ItemNos_as{$loop_L})
				If ($PosInArray_L>0)
					DCM_P_ITMLB_ItemQEnt_ar{$loop_L}:=$EntqItemNos_ar{$PosInArray_L}
					If ($PosInArray_L>Size of array:C274($CEstqItemNos_ar))
						DCM_P_ITMLB_ItemQCEST_ar{$loop_L}:=0
					Else 
						DCM_P_ITMLB_ItemQCEST_ar{$loop_L}:=$CEstqItemNos_ar{$PosInArray_L}
					End if 
					If ($PosInArray_L>Size of array:C274($OEstqItemNos_ar))
						DCM_P_ITMLB_ItemQOEst_ar{$loop_L}:=0
					Else 
						DCM_P_ITMLB_ItemQOEst_ar{$loop_L}:=$OEstqItemNos_ar{$PosInArray_L}
					End if 
					
				End if 
			End for 
		End if 
		ARRAY TEXT:C222($EntqItemNos_as; 0)  //Command Replaced was o_ARRAY string length was 7
		ARRAY REAL:C219($EntqItemNos_ar; 0)
		ARRAY REAL:C219($CEstqItemNos_ar; 0)
		ARRAY REAL:C219($OEstqItemNos_ar; 0)
		
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemNos_as))
			DCM_P_ItemSum_r:=DCM_P_ItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQEnt_ar{$loop_L})
			DCM_P_CEstItemSum_r:=DCM_P_CEstItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQCEST_ar{$loop_L})
			DCM_P_OEstItemSum_r:=DCM_P_OEstItemSum_r+(ITMLB_ItemPrice_ar{$loop_L}*DCM_P_ITMLB_ItemQOEst_ar{$loop_L})
		End for 
		LISTBOX SELECT ROW:C912(DCM_PRJ_LineItems_lb; 0; lk remove from selection:K53:3)
		
	: ($Task_txt="SAVE")
		
		VARIABLE TO BLOB:C532(ITMLB_ItemNos_as; [DCM_Project:138]ProjItems_x:16)
		VARIABLE TO BLOB:C532(DCM_P_ITMLB_ItemQEnt_ar; [DCM_Project:138]ProjItems_x:16; *)
		VARIABLE TO BLOB:C532(DCM_P_ITMLB_ItemQCEST_ar; [DCM_Project:138]ProjItems_x:16; *)
		VARIABLE TO BLOB:C532(DCM_P_ITMLB_ItemQOEst_ar; [DCM_Project:138]ProjItems_x:16; *)
	Else 
		ALERT:C41("Application error! Unknown argument to "+Current method name:C684+" :<"+$Task_txt+"> !!!!")
End case 