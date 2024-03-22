//%attributes = {"invisible":true}
//Method: NTI_CombineBIN2TIN
//Description
//Combine complete NTE inspections for BINs to the inspection for the current TIN
// must be done on an already created TIN inspection.
// Will replace
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/16, 14:41:52
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/9/16 09:36:49)
	Mods_2016_08_bug
	//  `when ready to add / modify recrords in [NTI_ELEM_TIN_INSP] make sure table is in read write mode
	Mods_2021_Delete  // not used any more
End if 
//
//ALERT("Must SAVE current state and start new transaction when finally doing the summation!!!")
//ALERTTOTHIS:=0
C_BLOB:C604($RoState_x)
$RoState_x:=ut_db_SaveROState
READ ONLY:C145([TunnelInfo:151])
READ ONLY:C145([Inspections:27])
READ ONLY:C145([NTI_ELEM_BIN_INSP:183])

QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]NTI_i1_s:33=[NTI_TunnelInfo:181]NTI_i1_s:6)
ARRAY TEXT:C222($BINs_atxt; 0)
SELECTION TO ARRAY:C260([TunnelInfo:151]BIN:1; $BINs_atxt)
QUERY WITH ARRAY:C644([Inspections:27]BIN:1; $BINs_atxt)
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]InspComplete:168=True:C214; *)
QUERY SELECTION:C341([Inspections:27];  & ; [NTI_ELEM_BIN_INSP:183]INSPID:1>0)
ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; >)
ARRAY TEXT:C222($BINs_atxt; 0)
ARRAY DATE:C224($inspDates_ad; 0)
ARRAY LONGINT:C221($inspIDs_aL; 0)
SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $BINs_atxt; [Inspections:27]Insp Date:78; $inspDates_ad; [Inspections:27]InspID:2; $inspIDs_aL)
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($BINs_atxt))
	$BINs_atxt{$loop_L}:=$BINs_atxt{$loop_L}+" - "+String:C10($inspDates_ad{$loop_L})
End for 

//build HLs for the Twolist move dialog

C_LONGINT:C283(UseList_HL; OmitList_HL)
C_BOOLEAN:C305(TWOLIST_MOVEONLY_B)
TWOLIST_MOVEONLY_B:=False:C215
UseList_HL:=ut_ArrayToHL(->$BINs_atxt; ""; ->$inspIDs_aL)
OmitList_HL:=New list:C375

C_TEXT:C284(vCancelBtntxt; vOKBtnTxt; vUseListLbl_txt; vOmitLbl_txt)
vCancelBtntxt:="Cancel"
vOKBtnTxt:="Proceed"
vUseListLbl_txt:="Completed BIN Inspections"
vOmitLbl_txt:="Inspections to use"
C_BOOLEAN:C305($DoSum_b)
$DoSum_b:=False:C215
C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674("TwoListMove"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
C_BOOLEAN:C305($DoneSelecting_b)
Repeat 
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Select Inspections"; "ut_CloseCancel")
	//$winID:=Open form window([Dialogs];"TwoListMove")
	DIALOG:C40("TwoListMove")
	CLOSE WINDOW:C154($Win_l)
	If (OK=1)
		C_LONGINT:C283($num_selected_L)
		$num_selected_L:=Count list items:C380(OmitList_HL)
		If ($num_selected_L>0)
			$DoSum_b:=True:C214
			ARRAY LONGINT:C221($InspIDsToMerge_aL; $num_selected_L)
			C_LONGINT:C283($ref)
			C_TEXT:C284($Name)
			
			For ($loop_L; 1; $num_selected_L)
				GET LIST ITEM:C378(OmitList_HL; $loop_L; $Ref; $Name)
				$InspIDsToMerge_aL{$loop_L}:=$Ref
			End for 
			//***** verify no duplicate BINs
			QUERY WITH ARRAY:C644([Inspections:27]InspID:2; $InspIDsToMerge_aL)
			ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Date:78; >)
			SELECTION TO ARRAY:C260([Inspections:27]BIN:1; $BINs_atxt; [Inspections:27]Insp Date:78; $inspDates_ad)
			C_LONGINT:C283($loop_L)
			C_TEXT:C284($errMsg_txt)
			$errMsg_txt:=""
			ARRAY TEXT:C222($MultBins_atxt; 0)
			ARRAY TEXT:C222($MutlDates_atxt; 0)
			For ($loop_L; 2; Size of array:C274($BINs_atxt))
				If ($BINs_atxt{$loop_L}=$BINs_atxt{$loop_L-1})
					
					If (Find in array:C230($MultBins_atxt; $BINs_atxt{$loop_L})>0)
						$MutlDates_atxt{Find in array:C230($MultBins_atxt; $BINs_atxt{$loop_L})}:=$MutlDates_atxt{Find in array:C230($MultBins_atxt; $BINs_atxt{$loop_L})}+", "+String:C10($inspDates_ad{$loop_L})
					Else 
						APPEND TO ARRAY:C911($MultBins_atxt; $BINs_atxt{$loop_L})
						APPEND TO ARRAY:C911($MutlDates_atxt; (String:C10($inspDates_ad{$loop_L-1})+", "+String:C10($inspDates_ad{$loop_L})))
					End if 
					
				End if 
			End for 
			If (Size of array:C274($MultBins_atxt)>0)
				$DoSum_b:=False:C215
				C_TEXT:C284($errMsg_txt)
				$errMsg_txt:="Multiple Inspections Selected for same BINs"
				For ($loop_L; 1; Size of array:C274($MultBins_atxt))
					$errMsg_txt:=$errMsg_txt+$MultBins_atxt{$loop_L}+" : "+$MutlDates_atxt{$loop_L}+Char:C90(13)
				End for 
				$errMsg_txt:=$errMsg_txt+"Try Again?"
				ut_BigAlert($errMsg_txt)
				C_LONGINT:C283($Option_L)
				$Option_L:=ut_3Option_Confirm($errMsg_txt; "Try Again"; "Cancel"; "Cancel")
				Case of 
					: ($Option_L=1)
					: ($Option_L=2)
						$DoneSelecting_b:=True:C214
					: ($Option_L=3)
						$DoneSelecting_b:=True:C214
				End case 
			Else 
				$DoneSelecting_b:=True:C214
			End if 
		Else 
			CONFIRM:C162("There were no Inspections selected!"; "Try again?"; "Cancel")
			If (OK=1)
			Else 
				$DoneSelecting_b:=True:C214
			End if 
		End if 
		
	Else 
		$DoneSelecting_b:=True:C214
	End if 
Until ($DoneSelecting_b)


If (Is a list:C621(UseList_HL))
	CLEAR LIST:C377(UseList_HL; *)
End if 
If (Is a list:C621(OmitList_HL))
	CLEAR LIST:C377(OmitList_HL; *)
End if 

If ($DoSum_b)
	// get all NTEs from the BINs
	QUERY WITH ARRAY:C644([NTI_ELEM_BIN_INSP:183]INSPID:1; $InspIDsToMerge_aL)
	
	ORDER BY:C49([NTI_ELEM_BIN_INSP:183]; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; >; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; >)
	//Save the set 
	CREATE SET:C116([NTI_ELEM_BIN_INSP:183]; "NTE_FROM_BINS")
	ARRAY LONGINT:C221($BINElemKey_aL; 0)
	ARRAY LONGINT:C221($BinParkey_aL; 0)
	ARRAY REAL:C219($BINQ_ar; 0)
	ARRAY REAL:C219($BINQ1_ar; 0)
	ARRAY REAL:C219($BINQ2_ar; 0)
	ARRAY REAL:C219($BINQ3_ar; 0)
	ARRAY REAL:C219($BINQ4_ar; 0)
	ARRAY TEXT:C222($BINNotes_atxt; 0)
	ARRAY TEXT:C222($NTEBins_atxt; 0)  // these two needed for notes
	ARRAY DATE:C224($NTEDates_ad; 0)
	SELECTION TO ARRAY:C260([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; $BINElemKey_aL; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; $BinParkey_aL; [NTI_ELEM_BIN_INSP:183]ELEM_QUANTITY:21; $BINQ_ar; [Inspections:27]BIN:1; $NTEBins_atxt; [Inspections:27]Insp Date:78; $NTEDates_ad)
	SELECTION TO ARRAY:C260([NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE1:17; $BINQ1_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE2:18; $BINQ2_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE3:19; $BINQ3_ar; [NTI_ELEM_BIN_INSP:183]ELEM_QTYSTATE4:20; $BINQ4_ar)  //;[NTI_ELEM_BIN_INSP]ELEM_NOTES;$BINNotes_atxt)
	
	ARRAY LONGINT:C221($SUMBINElemKey_aL; 0)
	ARRAY LONGINT:C221($SUMBinParkey_aL; 0)
	ARRAY REAL:C219($SUMBINQ_ar; 0)
	ARRAY REAL:C219($SUMBINQ1_ar; 0)
	ARRAY REAL:C219($SUMBINQ2_ar; 0)
	ARRAY REAL:C219($SUMBINQ3_ar; 0)
	ARRAY REAL:C219($SUMBINQ4_ar; 0)
	//ARRAY TEXT($SUMBINNotes_atxt;0)
	//start with the 1st element
	$loop_L:=1
	C_TEXT:C284($Notes_txt)
	APPEND TO ARRAY:C911($SUMBINElemKey_aL; $BINElemKey_aL{$loop_L})
	APPEND TO ARRAY:C911($SUMBinParkey_aL; $BinParkey_aL{$loop_L})
	APPEND TO ARRAY:C911($SUMBINQ_ar; $BINQ_ar{$loop_L})
	APPEND TO ARRAY:C911($SUMBINQ1_ar; $BINQ1_ar{$loop_L})
	APPEND TO ARRAY:C911($SUMBINQ2_ar; $BINQ2_ar{$loop_L})
	APPEND TO ARRAY:C911($SUMBINQ3_ar; $BINQ3_ar{$loop_L})
	APPEND TO ARRAY:C911($SUMBINQ4_ar; $BINQ4_ar{$loop_L})
	//$Notes_txt:=f_TrimStr ($BINNotes_atxt{$loop_L};True;True)
	//If ($Notes_txt#"")
	//APPEND TO ARRAY($SUMBINNotes_atxt;($NTEBins_atxt{$loop_L}+" - "+String($NTEDates_ad{$loop_L})+" : "+$Notes_txt))
	//Else 
	//APPEND TO ARRAY($SUMBINNotes_atxt;"")
	//End if 
	
	C_LONGINT:C283($SumLoop_L)
	$SumLoop_L:=Size of array:C274($SUMBINElemKey_aL)
	
	//`add quantities and states by combinations parentkey+elemKey
	
	For ($loop_L; 2; Size of array:C274($BINElemKey_aL))
		
		If (($BINElemKey_aL{$loop_L}=$SUMBINElemKey_aL{$SumLoop_L}) & ($BinParkey_aL{$loop_L}=$SUMBinParkey_aL{$SumLoop_L}))
			//same combo - add values
			$SUMBINQ_ar{$SumLoop_L}:=$SUMBINQ_ar{$SumLoop_L}+$BINQ_ar{$loop_L}
			$SUMBINQ1_ar{$SumLoop_L}:=$SUMBINQ1_ar{$SumLoop_L}+$BINQ1_ar{$loop_L}
			$SUMBINQ2_ar{$SumLoop_L}:=$SUMBINQ2_ar{$SumLoop_L}+$BINQ2_ar{$loop_L}
			$SUMBINQ3_ar{$SumLoop_L}:=$SUMBINQ3_ar{$SumLoop_L}+$BINQ3_ar{$loop_L}
			$SUMBINQ4_ar{$SumLoop_L}:=$SUMBINQ4_ar{$SumLoop_L}+$BINQ4_ar{$loop_L}
			//$Notes_txt:=f_TrimStr ($BINNotes_atxt{$loop_L};True;True)
			//If ($Notes_txt#"")
			//$SUMBINNotes_atxt{$SumLoop_L}:=$SUMBINNotes_atxt{$SumLoop_L}+Char(13)+$NTEBins_atxt{$loop_L}+" - "+String($NTEDates_ad{$loop_L})+" : "+$Notes_txt
			//End if 
		Else 
			//new - append
			APPEND TO ARRAY:C911($SUMBINElemKey_aL; $BINElemKey_aL{$loop_L})
			APPEND TO ARRAY:C911($SUMBinParkey_aL; $BinParkey_aL{$loop_L})
			APPEND TO ARRAY:C911($SUMBINQ_ar; $BINQ_ar{$loop_L})
			APPEND TO ARRAY:C911($SUMBINQ1_ar; $BINQ1_ar{$loop_L})
			APPEND TO ARRAY:C911($SUMBINQ2_ar; $BINQ2_ar{$loop_L})
			APPEND TO ARRAY:C911($SUMBINQ3_ar; $BINQ3_ar{$loop_L})
			APPEND TO ARRAY:C911($SUMBINQ4_ar; $BINQ4_ar{$loop_L})
			//$Notes_txt:=f_TrimStr ($BINNotes_atxt{$loop_L};True;True)
			//If ($Notes_txt#"")
			//APPEND TO ARRAY($SUMBINNotes_atxt;($NTEBins_atxt{$loop_L}+" - "+String($NTEDates_ad{$loop_L})+" : "+$Notes_txt))
			//Else 
			//APPEND TO ARRAY($SUMBINNotes_atxt;"")
			//End if 
			$SumLoop_L:=Size of array:C274($SUMBINElemKey_aL)
		End if 
		
	End for 
	ARRAY TEXT:C222($SumKeyParentPair_atxt; Size of array:C274($SUMBINElemKey_aL))
	For ($loop_L; 1; Size of array:C274($SUMBINElemKey_aL))
		$SumKeyParentPair_atxt{$loop_L}:=String:C10($SUMBinParkey_aL{$loop_L}; "000000000")+String:C10($SUMBINElemKey_aL{$loop_L}; "000000000")
	End for 
	C_BOOLEAN:C305($Continue_b)
	$Continue_b:=True:C214
	For ($loop_L; 1; (Size of array:C274($SumKeyParentPair_atxt)-1))
		If (Find in array:C230($SumKeyParentPair_atxt; $SumKeyParentPair_atxt{$loop_L}; $loop_L+1)>0)
			//there's another one with the same Key + parentKey
			ALERT:C41("Duplicate Element + Parent Combination found! :"+$SumKeyParentPair_atxt{$loop_L})
			$Continue_b:=False:C215
			
		End if 
	End for 
	READ WRITE:C146([NTI_ELEM_TIN_INSP:185])
	If ($Continue_b)
		C_BOOLEAN:C305($AbortSummary_b)
		$AbortSummary_b:=False:C215
		//get TIN NTEs
		QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
		//get the BIN only NTEs
		//QUERY SELECTION([NTI_ELEM_TIN_INSP];[NTI_ELEM_DEFS]BIN_ONLY="Y")
		C_BOOLEAN:C305($InTransaction_b)
		$InTransaction_b:=In transaction:C397
		If (Not:C34(In transaction:C397))
			START TRANSACTION:C239
		End if 
		
		FIRST RECORD:C50([NTI_ELEM_TIN_INSP:185])
		C_LONGINT:C283($SumIndx_L)
		While (Not:C34(End selection:C36([NTI_ELEM_TIN_INSP:185])))
			$SumIndx_L:=Find in array:C230($SumKeyParentPair_atxt; String:C10([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; "000000000")+String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; "000000000"))
			If ($SumIndx_L>0)
				//update
				[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=$SUMBINQ_ar{$SumIndx_L}
				[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=$SUMBINQ1_ar{$SumIndx_L}
				[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=$SUMBINQ2_ar{$SumIndx_L}
				[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=$SUMBINQ3_ar{$SumIndx_L}
				[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=$SUMBINQ4_ar{$SumIndx_L}
				//[NTI_ELEM_TIN_INSP]ELEM_NOTES:=$SUMBINNotes_atxt{$SumIndx_L}
				//update percentages
				[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
				[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
				[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
				[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
				PushAllChanges(PON_ChangeStackLvl_L; ->[NTI_ELEM_TIN_INSP:185])
				FlushGrpChgs(PON_ChangeStackLvl_L; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2)
				
				SAVE RECORD:C53([NTI_ELEM_TIN_INSP:185])
				//delete the element from the Arrays
				DELETE FROM ARRAY:C228($SUMBINElemKey_aL; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBinParkey_aL; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBINQ_ar; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBINQ1_ar; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBINQ2_ar; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBINQ3_ar; $SumIndx_L)
				DELETE FROM ARRAY:C228($SUMBINQ4_ar; $SumIndx_L)
				//DELETE FROM ARRAY($SUMBINNotes_atxt;$SumIndx_L)
				DELETE FROM ARRAY:C228($SumKeyParentPair_atxt; $SumIndx_L)
				
			Else 
				//not found - delete - if it is a bin only
				C_BOOLEAN:C305($BinOnly_b)
				$BinOnly_b:=False:C215
				QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
				If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
					QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
					$BinOnly_b:=([NTI_ELEM_DEFS:182]ELEM_BINONLY:18="Y")
				Else 
					$BinOnly_b:=([NTI_ELEM_DEFS:182]ELEM_BINONLY:18="Y")
				End if 
				
				If ($BinOnly_b)
					LogDeletion(->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2)
					DELETE RECORD:C58([NTI_ELEM_TIN_INSP:185])
					
				End if 
			End if 
			
			NEXT RECORD:C51([NTI_ELEM_TIN_INSP:185])
		End while 
		
		//get all parent elements
		QUERY SELECTION:C341([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3>0; *)
		QUERY SELECTION:C341([NTI_ELEM_TIN_INSP:185];  & ; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7=0)
		ORDER BY:C49([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; >)
		ARRAY LONGINT:C221($ParentKeys_aL; 0)
		ARRAY LONGINT:C221($parentIDs_aL; 0)
		SELECTION TO ARRAY:C260([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $ParentKeys_aL; [NTI_ELEM_TIN_INSP:185]ELEMID:2; $parentIDs_aL)
		
		//now see if we need to add elements
		
		C_LONGINT:C283($ElemID_L; $ParentFound_L; $ParentID_L)
		SHORT_MESSAGE("Adding Elements..")
		For ($loop_L; 1; Size of array:C274($SumKeyParentPair_atxt))
			//first check that if we need a parent that it exists
			Inc_Sequence("NTI_ELEM_TIN_INSP"; ->$ElemID_L)
			$ParentID_L:=0
			
			If ($SUMBinParkey_aL{$loop_L}>0)
				$ParentFound_L:=Find in array:C230($ParentKeys_aL; $SUMBinParkey_aL{$loop_L})
				If ($ParentFound_L>0)
					$ParentID_L:=$parentIDs_aL{$ParentFound_L}
				Else 
					ALERT:C41("Error adding a Defect "+String:C10($SUMBINElemKey_aL{$loop_L})+" for Element "+String:C10($SUMBinParkey_aL{$loop_L})+" : Required Element not Found!")
					$AbortSummary_b:=True:C214
				End if 
				
			Else 
				//this is a parent element -add it to the list of parents with the ID
				APPEND TO ARRAY:C911($ParentKeys_aL; $SUMBINElemKey_aL{$loop_L})
				APPEND TO ARRAY:C911($parentIDs_aL; $ElemID_L)
			End if 
			MESSAGE:C88(String:C10($SUMBinParkey_aL{$loop_L})+"-"+String:C10($SUMBINElemKey_aL{$loop_L})+"..  ")
			CREATE RECORD:C68([NTI_ELEM_TIN_INSP:185])
			[NTI_ELEM_TIN_INSP:185]ELEMID:2:=$ElemID_L
			[NTI_ELEM_TIN_INSP:185]InspectionID:1:=[TIN_Inspections:184]InspectionID:2
			[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3:=$SUMBINElemKey_aL{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7:=$SUMBinParkey_aL{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8:=$ParentID_L
			[NTI_ELEM_TIN_INSP:185]ELEM_SCALE_FACTOR:22:=1
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEDATETIME:4:=ISODateTime(Current date:C33(*); Current time:C178(*))
			[NTI_ELEM_TIN_INSP:185]ELEM_CREATEUSER:5:=Current user:C182
			[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21:=$SUMBINQ_ar{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE1:17:=$SUMBINQ1_ar{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18:=$SUMBINQ2_ar{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19:=$SUMBINQ3_ar{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20:=$SUMBINQ4_ar{$loop_L}
			[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16:=True:C214  //default to true
			//[NTI_ELEM_TIN_INSP]ELEM_NOTES:=$SUMBINNotes_atxt{$SumIndx_L}
			//update percentages
			[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE2:18/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
			[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE3:19/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
			[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15:=Round:C94(100*[NTI_ELEM_TIN_INSP:185]ELEM_QTYSTATE4:20/[NTI_ELEM_TIN_INSP:185]ELEM_QUANTITY:21; PON_RoundP_L)
			[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE1:12:=100-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE2:13-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE3:14-[NTI_ELEM_TIN_INSP:185]ELEM_PCTSTATE4:15
			
			LogNewRecord(->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; "NTI_ELEM_TIN_INSP")
			PushAllChanges(PON_ChangeStackLvl_L; ->[NTI_ELEM_TIN_INSP:185]; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; ->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8)
			FlushGrpChgs(PON_ChangeStackLvl_L; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2)
			If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8>0)
				LogLink(->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8; ->[TIN_Inspections:184]InspectionID:2; ->[NTI_ELEM_TIN_INSP:185]InspectionID:1; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2; 2; ->[NTI_ELEM_TIN_INSP:185]ELEMID:2)
			End if 
			SAVE RECORD:C53([NTI_ELEM_TIN_INSP:185])
			
		End for 
		CLOSE WINDOW:C154
		//Now loop back thru TIN_INSP records and add the comments from matching Key/ParentKey combo
		QUERY:C277([NTI_ELEM_TIN_INSP:185]; [NTI_ELEM_TIN_INSP:185]InspectionID:1=[TIN_Inspections:184]InspectionID:2)
		//get the BIN only NTEs
		//QUERY SELECTION([NTI_ELEM_TIN_INSP];[NTI_ELEM_DEFS]BIN_ONLY="Y")
		FIRST RECORD:C50([NTI_ELEM_TIN_INSP:185])
		C_BLOB:C604($SummBlob_x)
		C_LONGINT:C283($TempWrArea_L; $charCount_L)
		C_TEXT:C284($Header_txt)
		//create blank area
		//$TempWrArea_L:=WR New offscreen area 
		//Set Doc Margins ($TempWrArea_L)
		//SHORT_MESSAGE ("Combiing Notes... ")
		//While (Not(End selection([NTI_ELEM_TIN_INSP])))
		
		//USE SET("NTE_FROM_BINS")
		//QUERY SELECTION([NTI_ELEM_BIN_INSP];[NTI_ELEM_BIN_INSP]ELEM_KEY=[NTI_ELEM_TIN_INSP]ELEM_KEY;*)
		//QUERY SELECTION([NTI_ELEM_BIN_INSP]; & ;[NTI_ELEM_BIN_INSP]ELEM_PARENT_KEY=[NTI_ELEM_TIN_INSP]ELEM_PARENT_KEY)
		//ORDER BY([NTI_ELEM_BIN_INSP];[Inspections]BIN;>)  // sort by BIN
		//  //clear all in temp area
		//WR EXECUTE COMMAND ($TempWrArea_L;wr cmd select all)
		//WR DELETE SELECTION ($TempWrArea_L)
		//If (Records in selection([NTI_ELEM_BIN_INSP])>0)
		//MESSAGE(String([NTI_ELEM_TIN_INSP]ELEM_PARENT_KEY)+"-"+String([NTI_ELEM_TIN_INSP]ELEM_KEY)+"..  ")
		
		//FIRST RECORD([NTI_ELEM_BIN_INSP])
		//While (Not(End selection([NTI_ELEM_BIN_INSP])))
		//If (BLOB size([NTI_ELEM_BIN_INSP]ELEM_NOTES)>0)
		//QUERY([Inspections];[Inspections]InspID=[NTI_ELEM_BIN_INSP]INSPID)
		//$Header_txt:="Comments from BIN "+[Inspections]BIN+" Insp. date : "+String([Inspections]Insp Date)+Char(13)
		//$charCount_L:=WR Count ($TempWrArea_L;wr nb characters)  //
		//WR SELECT ($TempWrArea_L;wr select characters;$charCount_L;$charCount_L)
		//If ($charCount_L>0)
		//$Header_txt:=Char(13)+Char(13)+$Header_txt
		//End if 
		//  //move to end
		//G_ApplySheet ($TempWrArea_L;1)
		//  //WR SET TEXT PROPERTY ($TempWrArea_L;wr bold ;1)
		//WR SET TEXT PROPERTY ($TempWrArea_L;wr underline;1)
		//WR INSERT TEXT ($TempWrArea_L;$Header_txt)
		//  //WR SET TEXT PROPERTY ($TempWrArea_L;wr bold ;0)
		//WR SET TEXT PROPERTY ($TempWrArea_L;wr underline;0)
		//$charCount_L:=WR Count ($TempWrArea_L;wr nb characters)  //
		//WR SELECT ($TempWrArea_L;wr select characters;$charCount_L;$charCount_L)
		//WR INSERT STYLED TEXT ($TempWrArea_L;[NTI_ELEM_BIN_INSP]ELEM_NOTES)
		//End if 
		//NEXT RECORD([NTI_ELEM_BIN_INSP])
		//End while 
		
		//End if 
		
		//$charCount_L:=WR Count ($TempWrArea_L;wr nb characters)
		//If ($charCount_L>0)
		//WR EXECUTE COMMAND ($TempWrArea_L;wr cmd select all)
		//$SummBlob_x:=WR Get styled text ($TempWrArea_L)
		//[NTI_ELEM_TIN_INSP]ELEM_NOTES:=$SummBlob_x
		//LogChanges (->[NTI_ELEM_TIN_INSP]ELEM_NOTES;->[TIN_Inspections]InspectionID;->[NTI_ELEM_TIN_INSP]InspectionID;->[NTI_ELEM_TIN_INSP]ELEMID;2)
		//SAVE RECORD([NTI_ELEM_TIN_INSP])
		//Else 
		//If (BLOB size([NTI_ELEM_TIN_INSP]ELEM_NOTES)>0)
		//SET BLOB SIZE([NTI_ELEM_TIN_INSP]ELEM_NOTES;0)
		//LogChanges (->[NTI_ELEM_TIN_INSP]ELEM_NOTES;->[TIN_Inspections]InspectionID;->[NTI_ELEM_TIN_INSP]InspectionID;->[NTI_ELEM_TIN_INSP]ELEMID;2)
		//SAVE RECORD([NTI_ELEM_TIN_INSP])
		//End if 
		
		//End if 
		
		//NEXT RECORD([NTI_ELEM_TIN_INSP])
		//End while 
		
		//WR DELETE OFFSCREEN AREA ($TempWrArea_L)
		CLOSE WINDOW:C154
		
		If (Not:C34($InTransaction_b))
			If (Not:C34($AbortSummary_b))
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
				
			End if 
		End if 
	End if 
	
	CLEAR SET:C117("NTE_FROM_BINS")
	
End if 

ut_db_RestoreROState($RoState_x)
//End NTI_CombineBIN2TIN