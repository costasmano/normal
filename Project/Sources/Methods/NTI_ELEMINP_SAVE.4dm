//%attributes = {"invisible":true}
//Method: NTI_ELEMINP_SAVE
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 10:58:56
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_BOOLEAN:C305(NTI_ELEMINP_SAVE; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-12-30 17:06:46)
	Mods_2021_12_bug
	//  `fix to save correctly element notes
End if 
//
C_BOOLEAN:C305($0)
C_POINTER:C301($tbl_ptr; $elemKey_ptr; $ElemID_ptr; $ElmInspID_ptr; $InspID_ptr; $parID_ptr; $ParKey_ptr; $notes_ptr)

$tbl_ptr:=Current form table:C627

Case of 
	: ($tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		$elemKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		$ElemID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$ElmInspID_ptr:=->[NTI_ELEM_BIN_INSP:183]INSPID:1
		$InspID_ptr:=->[Inspections:27]InspID:2
		$parID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
		$ParKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		$notes_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9
		
	: ($tbl_ptr=(->[NTI_ELEM_TIN_INSP:185]))
		$elemKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
		$ElemID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$ElmInspID_ptr:=->[NTI_ELEM_TIN_INSP:185]InspectionID:1
		$InspID_ptr:=->[TIN_Inspections:184]InspectionID:2
		$parID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8
		$ParKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
		$notes_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9
End case 

$0:=False:C215
If (NTI_ValidateElemInput($tbl_ptr))
	INSP_Comments_WP_OM(New object:C1471("WPAreaname"; "DE ElementComments_WP"; "fieldptr"; ->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9; "formEvent"; On Losing Focus:K2:8; "changeStack"; PON_ChangeStackLvl_L))
	
	// check if env changed
	NTI_RecordAllChanges($tbl_ptr)
	SAVE RECORD:C53($tbl_ptr->)
	// check if elem key and Enviroment of children is same - only needed if element is not a defect
	If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y")
		C_LONGINT:C283($ChildNotsaneEnv_L; $grandChildNotsaneEnv_L; $CurrEnvKey_L; $CurrElemKey_L; $currElemID_L)
		$CurrElemKey_L:=$elemKey_ptr->
		$currElemID_L:=$ElemID_ptr->
		COPY NAMED SELECTION:C331($tbl_ptr->; "$TempEleminspSel")
		
		QUERY:C277($tbl_ptr->; $ElmInspID_ptr->=$InspID_ptr->)
		
		SET QUERY DESTINATION:C396(Into set:K19:2; "PON_CHILD_BADKEY")
		QUERY SELECTION:C341($tbl_ptr->; $parID_ptr->=$currElemID_L; *)
		QUERY SELECTION:C341($tbl_ptr->;  & ; $ParKey_ptr->#$CurrElemKey_L)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If (Records in set:C195("PON_CHILD_BADKEY")>0)
			ALERT:C41("Adjusting Parent Children Elements!")
			USE SET:C118("PON_CHILD_BADKEY")
			FIRST RECORD:C50($tbl_ptr->)
			While (Not:C34(End selection:C36($tbl_ptr->)))
				InitChangeStack(PON_ChangeStackLvl_L)
				$ParKey_ptr->:=$CurrElemKey_L
				PushChange(PON_ChangeStackLvl_L; $ParKey_ptr)
				FlushGrpChgs(PON_ChangeStackLvl_L; $InspID_ptr; $ElmInspID_ptr; $ElemID_ptr; 2)
				SAVE RECORD:C53($tbl_ptr->)
				NEXT RECORD:C51($tbl_ptr->)
			End while 
			
		End if 
		
		CLEAR SET:C117("PON_CHILD_BADKEY")
		USE NAMED SELECTION:C332("$TempEleminspSel")
		CLEAR NAMED SELECTION:C333("$TempEleminspSel")
		
	End if 
	
	$0:=True:C214
	
End if 

//End NTI_ELEMINP_SAVE