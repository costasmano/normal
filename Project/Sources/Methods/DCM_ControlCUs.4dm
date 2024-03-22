//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/30/09, 08:58:12
	// ----------------------------------------------------
	// Method: DCM_ControlCUs
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt (text)
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(6/14/10 15:19:28)
	Mods_2010_06
	//  `Fixed error in the name of the InspArray dropdown
	// Modified by: costasmanousakis-(Designer)-(7/30/10 10:51:40)
	Mods_2010_09
	//  `Set the insp date array to 0 on start.
	// Modified by: costasmanousakis-(Designer)-(12/13/10 12:34:12)
	Mods_2010_12
	//  `Fix listbox selection start
	// Modified by: costasmanousakis-(Designer)-(5/16/11 10:00:01)
	Mods_2011_05
	//  `Fix ptr in INITLBOXES call for v11 transition and 
	//  `changed INSERT ELEMENT(DCM_INSPIDs_aL;-999) to APPEND TO ARRAY(DCM_INSPIDs_aL;-999)
End if 

C_TEXT:C284($1; $Task_txt)

$Task_txt:=$1

Case of 
	: ($Task_txt="LOADCUUsed")
		C_LONGINT:C283($offset)
		$offset:=0
		If (BLOB size:C605([DCM_Project:138]ProjData_X:14)>0)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedElNos_aL; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedEnv_ai; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedDesc_atxt; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedUnits_atxt; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedQ_ar; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedComments_atxt; $offset)
			BLOB TO VARIABLE:C533([DCM_Project:138]ProjData_X:14; DCM_CUUsedQ1_ar; $offset)
			If (Size of array:C274(DCM_CUUsedQ1_ar)#Size of array:C274(DCM_CUUsedElNos_aL))
				ARRAY REAL:C219(DCM_CUUsedQ1_ar; Size of array:C274(DCM_CUUsedElNos_aL))
			End if 
			
		End if 
		
	: ($Task_txt="SAVEUSEDCUS")
		VARIABLE TO BLOB:C532(DCM_CUUsedElNos_aL; [DCM_Project:138]ProjData_X:14)
		VARIABLE TO BLOB:C532(DCM_CUUsedEnv_ai; [DCM_Project:138]ProjData_X:14; *)
		VARIABLE TO BLOB:C532(DCM_CUUsedDesc_atxt; [DCM_Project:138]ProjData_X:14; *)
		VARIABLE TO BLOB:C532(DCM_CUUsedUnits_atxt; [DCM_Project:138]ProjData_X:14; *)
		VARIABLE TO BLOB:C532(DCM_CUUsedQ_ar; [DCM_Project:138]ProjData_X:14; *)
		VARIABLE TO BLOB:C532(DCM_CUUsedComments_atxt; [DCM_Project:138]ProjData_X:14; *)
		VARIABLE TO BLOB:C532(DCM_CUUsedQ1_ar; [DCM_Project:138]ProjData_X:14; *)
		
	: ($Task_txt="ADDTOUSED")
		C_LONGINT:C283($2; $sourceNumber)
		$sourceNumber:=$2
		APPEND TO ARRAY:C911(DCM_CUUsedElNos_aL; DCM_CUElNos_aL{$sourceNumber})
		APPEND TO ARRAY:C911(DCM_CUUsedDesc_atxt; DCM_CUDesc_atxt{$sourceNumber})
		APPEND TO ARRAY:C911(DCM_CUUsedEnv_ai; DCM_CUEnv_ai{$sourceNumber})
		APPEND TO ARRAY:C911(DCM_CUUsedUnits_atxt; DCM_CUUnits_atxt{$sourceNumber})
		APPEND TO ARRAY:C911(DCM_CUUsedQ_ar; DCM_CUQ_ar{$sourceNumber})
		APPEND TO ARRAY:C911(DCM_CUUsedQ1_ar; 0)
		APPEND TO ARRAY:C911(DCM_CUUsedComments_atxt; "")
		ARRAY POINTER:C280($SortArrays_aptr; 7)
		ARRAY LONGINT:C221($SortOrder_aL; 7)
		$SortArrays_aptr{1}:=->DCM_CUUsedElNos_aL
		$SortArrays_aptr{2}:=->DCM_CUUsedEnv_ai
		$SortArrays_aptr{3}:=->DCM_CUUsedDesc_atxt
		$SortArrays_aptr{4}:=->DCM_CUUsedUnits_atxt
		$SortArrays_aptr{5}:=->DCM_CUUsedQ_ar
		$SortArrays_aptr{6}:=->DCM_CUUsedQ1_ar
		$SortArrays_aptr{7}:=->DCM_CUUsedComments_atxt
		$SortOrder_aL{1}:=1
		$SortOrder_aL{2}:=1
		$SortOrder_aL{3}:=0
		$SortOrder_aL{4}:=0
		$SortOrder_aL{5}:=0
		$SortOrder_aL{6}:=0
		$SortOrder_aL{7}:=0
		MULTI SORT ARRAY:C718($SortArrays_aptr; $SortOrder_aL)
		//SORT ARRAY(DCM_CUUsedElNos_aL;DCM_CUUsedEnv_ai;DCM_CUUsedDesc_atxt;DCM_CUUsedUnits_atxt;DCM_CUUsedQ_ar;DCM_CUUsedComments_atxt)
		//APPEND TO ARRAY(DCM_CUUsedQ2_ar;DCM_CUQ2_ar{$sourceNumber})
		//APPEND TO ARRAY(DCM_CUUsedQ3_ar;DCM_CUQ3_ar{$sourceNumber})
		//APPEND TO ARRAY(DCM_CUUsedQ4_ar;DCM_CUQ4_ar{$sourceNumber})
		//APPEND TO ARRAY(DCM_CUUsedQ5_ar;DCM_CUQ5_ar{$sourceNumber})
		
	: ($Task_txt="DELETEROW")
		C_LONGINT:C283($2; $findRow_L)
		$findRow_L:=$2
		DELETE FROM ARRAY:C228(DCM_CUUsedElNos_aL; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedEnv_ai; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedDesc_atxt; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedUnits_atxt; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedQ_ar; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedQ1_ar; $findRow_L)
		DELETE FROM ARRAY:C228(DCM_CUUsedComments_atxt; $findRow_L)
		
	: ($Task_txt="INITCUUsed")
		C_LONGINT:C283($ArrSize_L)
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$ArrSize_L:=$2
		Else 
			$ArrSize_L:=0
		End if 
		
		ARRAY REAL:C219(DCM_CUUsedQ_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedQ1_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedQ2_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedQ3_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedQ4_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedQ5_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUUsedSc_ar; $ArrSize_L)
		ARRAY INTEGER:C220(DCM_CUUsedEnv_ai; $ArrSize_L)
		ARRAY INTEGER:C220(DCM_CUUsedElmID_ai; $ArrSize_L)
		ARRAY LONGINT:C221(DCM_CUUsedIDs_aL; $ArrSize_L)
		ARRAY LONGINT:C221(DCM_CUUsedElNos_aL; $ArrSize_L)
		
		ARRAY TEXT:C222(DCM_CUUsedDesc_atxt; $ArrSize_L)
		ARRAY TEXT:C222(DCM_CUUsedUnits_atxt; $ArrSize_L)
		ARRAY TEXT:C222(DCM_CUUsedComments_atxt; $ArrSize_L)
		
	: ($Task_txt="INITLBOXES")
		C_POINTER:C301($LB_ptr)
		C_LONGINT:C283($loop_L)
		$LB_ptr:=Get pointer:C304("DCM_CUListBox")
		If (Type:C295($LB_ptr->)=Boolean array:K8:21)
			For ($loop_L; 1; Size of array:C274(DCM_CUListBox))
				DCM_CUListBox{$loop_L}:=False:C215
			End for 
			DCM_CUListBox:=0  //
			LISTBOX SELECT ROW:C912(DCM_CUListBox; 0; 0)
		End if 
		
		$LB_ptr:=Get pointer:C304("DCM_CU_Used_ListBox")
		If (Type:C295($LB_ptr->)=Boolean array:K8:21)
			For ($loop_L; 1; Size of array:C274(DCM_CU_Used_ListBox))
				DCM_CU_Used_ListBox{$loop_L}:=False:C215
			End for 
			DCM_CU_Used_ListBox:=0
			LISTBOX SELECT ROW:C912(DCM_CU_Used_ListBox; 0; lk remove from selection:K53:3)
			
		End if 
		
	: ($Task_txt="INITINSP")
		C_LONGINT:C283($2; $ArrSize_L)
		$ArrSize_L:=$2
		ARRAY TEXT:C222(DCM_InspectionDates_as; $ArrSize_L)
		ARRAY LONGINT:C221(DCM_INSPIDs_aL; $ArrSize_L)
		
	: ($Task_txt="INITCUS")
		C_LONGINT:C283($ArrSize_L)
		If (Count parameters:C259>1)
			C_LONGINT:C283($2)
			$ArrSize_L:=$2
		Else 
			$ArrSize_L:=0
		End if 
		
		ARRAY REAL:C219(DCM_CUQ_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUQ1_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUQ2_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUQ3_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUQ4_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUQ5_ar; $ArrSize_L)
		ARRAY REAL:C219(DCM_CUSc_ar; $ArrSize_L)
		ARRAY INTEGER:C220(DCM_CUEnv_ai; $ArrSize_L)
		ARRAY INTEGER:C220(DCM_CUElmID_ai; $ArrSize_L)
		ARRAY LONGINT:C221(DCM_CUIDs_aL; $ArrSize_L)
		ARRAY LONGINT:C221(DCM_CUElNos_aL; $ArrSize_L)
		ARRAY BOOLEAN:C223(DCM_CUUsed_aB; $ArrSize_L)
		
		ARRAY TEXT:C222(DCM_CUDesc_atxt; $ArrSize_L)
		ARRAY TEXT:C222(DCM_CUUnits_atxt; $ArrSize_L)
		
	: ($Task_txt="LOADAPPRINSP")
		QUERY:C277([Inspections:27]; [Inspections:27]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspReviewed:12=BMS Approved)
		ARRAY LONGINT:C221($ApprInsp_aL; Records in selection:C76([Inspections:27]))
		SELECTION TO ARRAY:C260([Inspections:27]InspID:2; $ApprInsp_aL)
		QUERY WITH ARRAY:C644([Combined Inspections:90]NBISInspID:2; $ApprInsp_aL)
		SELECTION TO ARRAY:C260([Combined Inspections:90]BMSInspID:3; $ApprInsp_aL)
		QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; $ApprInsp_aL)
		
		DCM_ControlCUs("INITINSP"; Records in selection:C76([BMS Inspections:44]))
		ARRAY DATE:C224($Tempdates; Records in selection:C76([BMS Inspections:44]))
		ORDER BY:C49([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4; <)
		SELECTION TO ARRAY:C260([BMS Inspections:44]Insp Date:4; $Tempdates; [BMS Inspections:44]Inspection ID:1; DCM_INSPIDs_aL)
		If (Size of array:C274($Tempdates)>0)
			OBJECT SET ENABLED:C1123(*; "DE InspectionDates_@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($Tempdates))
				DCM_InspectionDates_as{$loop_L}:=String:C10($Tempdates{$loop_L}; Internal date short special:K1:4)
			End for 
			INSERT IN ARRAY:C227(DCM_InspectionDates_as; 1)
			INSERT IN ARRAY:C227(DCM_INSPIDs_aL; 1)
			DCM_InspectionDates_as:=0
		Else 
			APPEND TO ARRAY:C911(DCM_InspectionDates_as; "N/A")
			APPEND TO ARRAY:C911(DCM_INSPIDs_aL; -999)
			OBJECT SET ENABLED:C1123(*; "DE InspectionDates_@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		End if 
		ARRAY LONGINT:C221($ApprInsp_aL; 0)
		ARRAY DATE:C224($Tempdates; 0)
		
		
	: ($Task_txt="LOADCUS")
		
		If (DCM_INSPIDs_aL{DCM_InspectionDates_as}>0)
			QUERY:C277([Cond Units:45]; [Cond Units:45]Inspection ID:2=DCM_INSPIDs_aL{DCM_InspectionDates_as})
			C_LONGINT:C283($numCus_L; $loop_L; $loop2_L)
			$numCus_L:=Records in selection:C76([Cond Units:45])
			DCM_ControlCUs("INITCUS"; $numCus_L)
			READ ONLY:C145([BMS Elements:47])
			If ($numCus_L>0)
				ORDER BY:C49([Cond Units:45]; [BMS Elements:47]Element No:2; >; [Cond Units:45]Environment:4; >)
				SELECTION TO ARRAY:C260([Cond Units:45]Cond Unit ID:1; DCM_CUIDs_aL; [Cond Units:45]Environment:4; DCM_CUEnv_ai; [Cond Units:45]Element ID:3; DCM_CUElmID_ai)
				SELECTION TO ARRAY:C260([Cond Units:45]Total Quantity:5; DCM_CUQ_ar; [Cond Units:45]CondState1:10; DCM_CUQ1_ar; [Cond Units:45]CondState2:11; DCM_CUQ2_ar)
				SELECTION TO ARRAY:C260([Cond Units:45]CondState3:12; DCM_CUQ3_ar; [Cond Units:45]CondState4:13; DCM_CUQ4_ar; [Cond Units:45]CondState5:14; DCM_CUQ5_ar)
				SELECTION TO ARRAY:C260([Cond Units:45]ScaleFactor:16; DCM_CUSc_ar; [Cond Units:45]CondState4:13; DCM_CUQ4_ar; [Cond Units:45]CondState5:14; DCM_CUQ5_ar)
				For ($loop_L; 1; $numCus_L)
					QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element ID:1=DCM_CUElmID_ai{$loop_L})
					QUERY:C277([BMS Categories:49]; [BMS Categories:49]Category ID:1=[BMS Elements:47]Category ID:8)
					DCM_CUQ_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUQ1_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ1_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUQ2_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ2_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUQ3_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ3_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUQ4_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ4_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUQ5_ar{$Loop_L}:=Round:C94(AnglicizeQ(DCM_CUQ5_ar{$Loop_L}; [BMS Elements:47]Units:6); 1)
					DCM_CUUnits_atxt{$Loop_L}:=AnglicizeUnit([BMS Elements:47]Units:6)
					DCM_CUElNos_aL{$Loop_L}:=[BMS Elements:47]Element No:2
					DCM_CUDesc_atxt{$Loop_L}:=LongName
					DCM_CUUsed_aB{$Loop_L}:=False:C215
					
					For ($loop2_L; 1; Size of array:C274(DCM_CUUsedElNos_aL))
						If ((DCM_CUUsedElNos_aL{$loop2_L}=DCM_CUElNos_aL{$Loop_L}) & (DCM_CUEnv_ai{$Loop_L}=DCM_CUUsedEnv_ai{$loop2_L}))
							DCM_CUUsed_aB{$Loop_L}:=True:C214
						End if 
					End for 
				End for 
				
			Else 
				
			End if 
			READ WRITE:C146([BMS Elements:47])
			
		End if 
		
End case 