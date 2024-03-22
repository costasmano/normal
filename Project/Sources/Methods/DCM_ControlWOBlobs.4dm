//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/23/09, 08:43:14
	// ----------------------------------------------------
	// Method: DCM_ControlWOBlobs
	// Description
	// control the Blobs for a work order
	// 
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(9/13/10 16:17:29)
	Mods_2010_09
	//  `Changes additions for Bid items
	// Modified by: costasmanousakis-(Designer)-(12/13/10 09:43:11)
	Mods_2010_12
	//  `Fixes for Bid Item Recalculation
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_BLOB:C604(DCM_WO_SpecInst_x; DCM_WO_Traffic_x; DCM_WO_Sched_x; DCM_WO_Scope_x; DCM_WO_Deficiency_x; DCM_WO_Equipment_x; DCM_WO_Engrng_x; DCM_WO_Material_x)
		SET BLOB SIZE:C606(DCM_WO_SpecInst_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Traffic_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Sched_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Scope_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Deficiency_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Equipment_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Engrng_x; 0)
		SET BLOB SIZE:C606(DCM_WO_Material_x; 0)
		ARRAY TEXT:C222(DCM_AttachmentList_atxt; 0)
		ARRAY LONGINT:C221($OldDCM_WO_Items_aL; 0)
		ARRAY LONGINT:C221(DCM_WO_Items_aL; 0)
		ARRAY REAL:C219(DCM_WO_ItemQCEstimate_ar; 0)
		ARRAY REAL:C219(DCM_WO_ItemQOEstimate_ar; 0)
		ARRAY REAL:C219(DCM_WO_ItemQActual_ar; 0)
		ARRAY REAL:C219(DCM_WO_ItemQCEstimate_ar; Size of array:C274(ITMLB_ItemNos_as))
		ARRAY REAL:C219(DCM_WO_ItemQOEstimate_ar; Size of array:C274(ITMLB_ItemNos_as))
		ARRAY REAL:C219(DCM_WO_ItemQActual_ar; Size of array:C274(ITMLB_ItemNos_as))
		ARRAY REAL:C219($WO_ItemQCEstimate_0_ar; 0)
		ARRAY REAL:C219($WO_ItemQOEstimate_0_ar; 0)
		ARRAY REAL:C219($WO_ItemQActual_0_ar; 0)
		ARRAY TEXT:C222($TempDCM_WO_Items_as; 0)  //Command Replaced was o_ARRAY string length was 7
		
		C_LONGINT:C283($offset_L)
		$offset_L:=0
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_SpecInst_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Traffic_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Sched_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Scope_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Deficiency_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Equipment_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_AttachmentList_atxt; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Engrng_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; DCM_WO_Material_x; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; $OldDCM_WO_Items_aL; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; $WO_ItemQCEstimate_0_ar; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; $WO_ItemQActual_0_ar; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; $WO_ItemQOEstimate_0_ar; $offset_L)
		BLOB TO VARIABLE:C533([DCM_WorkOrders:137]WriteBlobs_x:39; $TempDCM_WO_Items_as; $offset_L)
		//If (Size of array($WO_ItemQCEstimate_0_ar)#Size of array(ITMLB_ItemNos_as))
		//ARRAY REAL($WO_ItemQCEstimate_0_ar;Size of array(ITMLB_ItemNos_as))
		//End if 
		//If (Size of array($WO_ItemQActual_0_ar)#Size of array(ITMLB_ItemNos_as))
		//ARRAY REAL($WO_ItemQActual_0_ar;Size of array(ITMLB_ItemNos_as))
		//End if 
		//If (Size of array($WO_ItemQOEstimate_0_ar)#Size of array(ITMLB_ItemNos_as))
		//ARRAY REAL($WO_ItemQOEstimate_0_ar;Size of array(ITMLB_ItemNos_as))
		//End if 
		C_LONGINT:C283($loop_L; $PosInArray_L)
		For ($loop_L; 1; Size of array:C274(ITMLB_ItemNos_as))
			$PosInArray_L:=Find in array:C230($TempDCM_WO_Items_as; ITMLB_ItemNos_as{$loop_L})
			If ($PosInArray_L>0)
				DCM_WO_ItemQActual_ar{$loop_L}:=$WO_ItemQActual_0_ar{$PosInArray_L}
				If ($PosInArray_L>Size of array:C274($WO_ItemQCEstimate_0_ar))
					DCM_WO_ItemQCEstimate_ar{$loop_L}:=0
				Else 
					DCM_WO_ItemQCEstimate_ar{$loop_L}:=$WO_ItemQCEstimate_0_ar{$PosInArray_L}
				End if 
				If ($PosInArray_L>Size of array:C274($WO_ItemQOEstimate_0_ar))
					DCM_WO_ItemQOEstimate_ar{$loop_L}:=0
				Else 
					DCM_WO_ItemQOEstimate_ar{$loop_L}:=$WO_ItemQOEstimate_0_ar{$PosInArray_L}
				End if 
			Else 
				DCM_WO_ItemQActual_ar{$loop_L}:=0
				DCM_WO_ItemQCEstimate_ar{$loop_L}:=0
				DCM_WO_ItemQOEstimate_ar{$loop_L}:=0
			End if 
		End for 
		
		//Clear temp arrays
		ARRAY REAL:C219($WO_ItemQCEstimate_0_ar; 0)
		ARRAY REAL:C219($WO_ItemQOEstimate_0_ar; 0)
		ARRAY REAL:C219($WO_ItemQActual_0_ar; 0)
		ARRAY TEXT:C222($TempDCM_WO_Items_as; 0)  //Command Replaced was o_ARRAY string length was 7
		
		C_TEXT:C284(DCM_WO_TextDataDesc_txt)
		DCM_WO_TextDataDesc_txt:=""
		ARRAY TEXT:C222(DCM_WO_ListofAreas_atxt; 6)
		DCM_WO_ListofAreas_atxt{1}:="Deficiency"
		DCM_WO_ListofAreas_atxt{2}:="Scope"
		DCM_WO_ListofAreas_atxt{3}:="Traffic"
		DCM_WO_ListofAreas_atxt{4}:="Equipment"
		DCM_WO_ListofAreas_atxt{5}:="Schedule"
		DCM_WO_ListofAreas_atxt{6}:="Special Instr."
		DCM_WO_ListofAreas_atxt:=0
		DCM_AttachmentCtlr("INIT")
		
	: ($Task_txt="EDIT")
		C_LONGINT:C283($tab_L)
		$tab_L:=DCM_WO_ListofAreas_atxt
		C_POINTER:C301(DCM_WO_Write_ptr)
		Case of 
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Special Instr.")
				DCM_WO_Write_ptr:=->DCM_WO_SpecInst_x
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Traffic")
				DCM_WO_Write_ptr:=->DCM_WO_Traffic_x
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Schedule")
				DCM_WO_Write_ptr:=->DCM_WO_Sched_x
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Scope")
				DCM_WO_Write_ptr:=->DCM_WO_Scope_x
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Deficiency")
				DCM_WO_Write_ptr:=->DCM_WO_Deficiency_x
			: (DCM_WO_ListofAreas_atxt{$tab_L}="Equipment")
				DCM_WO_Write_ptr:=->DCM_WO_Equipment_x
		End case 
		DCM_WO_TextDataDesc_txt:="Entry for "+DCM_WO_ListofAreas_atxt{$tab_L}
		C_LONGINT:C283(DCM_4DWriteArea_L)
		C_LONGINT:C283($W_L; $h_L)
		FORM GET PROPERTIES:C674([DCM_WorkOrders:137]; "DCM_4DWriteDlg"; $W_L; $h_L)
		NewWindow($W_L; $h_L; 0; Plain window:K34:13)
		DIALOG:C40([DCM_WorkOrders:137]; "DCM_4DWriteDlg")
		CLOSE WINDOW:C154
		
	: ($Task_txt="SAVE")
		SET BLOB SIZE:C606([DCM_WorkOrders:137]WriteBlobs_x:39; 0)
		VARIABLE TO BLOB:C532(DCM_WO_SpecInst_x; [DCM_WorkOrders:137]WriteBlobs_x:39)
		VARIABLE TO BLOB:C532(DCM_WO_Traffic_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Sched_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Scope_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Deficiency_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Equipment_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_AttachmentList_atxt; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Engrng_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Material_x; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_Items_aL; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_ItemQCEstimate_ar; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_ItemQActual_ar; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(DCM_WO_ItemQOEstimate_ar; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
		VARIABLE TO BLOB:C532(ITMLB_ItemNos_as; [DCM_WorkOrders:137]WriteBlobs_x:39; *)
	Else 
		ALERT:C41("Application error! Unknown argument to "+Current method name:C684+" :<"+$Task_txt+"> !!!!")
End case 