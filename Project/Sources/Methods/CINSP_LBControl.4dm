//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/17/10, 08:58:36
	// ----------------------------------------------------
	// Method: CINSP_LBControl
	// Description
	//   `  `Control method for the List box in the Consultant Inspections
	// 
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(5/2/11 14:16:28)
	Mods_2011_05
	//  `Change for v11 Conversion : add  declare the LB array
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/17/17 13:40:53)
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="LOADARRAYS")
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]InspMonth:34; <)
		C_LONGINT:C283($ArrSize_L; $loop_L)
		$ArrSize_L:=Records in selection:C76([Cons Inspection:64])
		ARRAY DATE:C224(CINSP_InspMo_atxt; $ArrSize_L)
		ARRAY DATE:C224(CINSP_ReqFee_ad; $ArrSize_L)
		ARRAY DATE:C224(CINSP_NPD_ad; $ArrSize_L)
		ARRAY TEXT:C222(CINSP_Cons_atxt; $ArrSize_L)
		ARRAY DATE:C224(CINSP_InspRecd_ad; $ArrSize_L)  //
		ARRAY DATE:C224(CINSP_InsptoDBIE_ad; $ArrSize_L)  //
		ARRAY TEXT:C222(CINSP_Status_atxt; $ArrSize_L)  //
		ARRAY LONGINT:C221(CINSP_IDS_aL; $ArrSize_L)
		SELECTION TO ARRAY:C260([Cons Inspection:64]AssignStatus:24; CINSP_Status_atxt; [Cons Inspection:64]InspectionRecvd:29; CINSP_InspRecd_ad; [Cons Inspection:64]ReportToDBIE:31; CINSP_InsptoDBIE_ad; [Cons Inspection:64]InspMonth:34; CINSP_InspMo_atxt)
		SELECTION TO ARRAY:C260([Cons Inspection:64]ConsInspectionID:32; CINSP_IDS_aL; [Cons Inspection:64]AssignConName:5; CINSP_Cons_atxt; [Cons Inspection:64]AssignConDate:4; CINSP_NPD_ad)
		SELECTION TO ARRAY:C260([Cons Inspection:64]ReqFeeProposal:25; CINSP_ReqFee_ad; [Cons Inspection:64]InspectionRecvd:29; CINSP_InspRecd_ad; [Cons Inspection:64]ReportToDBIE:31; CINSP_InsptoDBIE_ad; [Cons Inspection:64]AssignStatus:24; CINSP_Status_atxt)
		ARRAY BOOLEAN:C223(CINSP_LB_a; $ArrSize_L)
		For ($loop_L; 1; Size of array:C274(CINSP_LB_a))
			CINSP_LB_a{$loop_L}:=False:C215
		End for 
		
	: ($Task_txt="MODRECORD")
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			
			C_LONGINT:C283($RowSelected_L; $LastID_L; $Loop_L)
			$RowSelected_L:=CINSP_LB_a
			FORM SET INPUT:C55([Cons Inspection:64]; "Cslt Insp In")
			If ($RowSelected_L>0)
				GOTO SELECTED RECORD:C245([Cons Inspection:64]; $RowSelected_L)
				LOAD RECORD:C52([Cons Inspection:64])
				If (Read only state:C362([Cons Inspection:64]))
					DIALOG:C40([Cons Inspection:64]; "Cslt Insp In")
				Else 
					MODIFY RECORD:C57([Cons Inspection:64])
				End if 
				
				$LastID_L:=[Cons Inspection:64]ConsInspectionID:32
				CINSP_LBControl("LOADARRAYS")
				$RowSelected_L:=Find in array:C230(CINSP_IDS_aL; $LastID_L)
				LISTBOX SELECT ROW:C912(CINSP_LB_a; $RowSelected_L; 0)
				//For ($Loop_L;1;Size of array(CINSP_LB_a))
				//If ($Loop_L=$RowSelected_L)
				//CINSP_LB_a{$Loop_L}:=True
				//Else 
				//CINSP_LB_a{$Loop_L}:=False
				//End if 
				//End for 
				//If (ut_LoadRecordInteractive (->[Cons Inspection]))
				//
				//End if 
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
		
End case 