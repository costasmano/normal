// Method: Form Method: ReLogRecords
// Description
//  ` Dialog to create activity log entries for records in tables.
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 06/15/12, 13:37:58
	// ----------------------------------------------------
	// First Release
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(11/18/13 10:27:34)
	Mods_2013_11
	//  `added forward variable
	// Modified by: Costas Manousakis-(Designer)-(7/19/21 12:00:43)
	Mods_2021_07
	//  `added a invisible variable to hold JSON of object with specific field data.
	//  `added selecting specific fields create act log GRP record - save the 
	//  `added selecting specific fields to create act log LNK record
	// Modified by: Costas Manousakis-(Designer)-(2021-12-30T00:00:00 19:35:36)
	Mods_2021_12_bug
	//  `added a button to clear Parent data - usefull for LSS tables who have parent but don't use it in act log.
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(RELOG_TBLNum_L; RELOG_Relation_L; RELOG_DELFIRST_L; RELOG_RecsFound_L; RELOG_KeyField_L; RELOG_ParentTbl_L; RELOG_FK_L; RELOG_PK_L; RelogTransfer_L)
		C_TEXT:C284(RELOG_SEQ_txt; RELOG_DEST_txt; RelogDestination_txt)
		ARRAY TEXT:C222(TableList_atxt; 0)
		ARRAY TEXT:C222(KeyFieldList_atxt; 0)
		ARRAY TEXT:C222(Sequence_atxt; 0)
		ARRAY TEXT:C222(ParentTableList_atxt; 0)
		ARRAY TEXT:C222(ForeignKeyList_atxt; 0)
		ARRAY TEXT:C222(ParentKeyList_atxt; 0)
		ARRAY LONGINT:C221(TableList_aL; 0)
		ARRAY LONGINT:C221(ParentTableList_aL; 0)
		If (False:C215)
			//for compilation purposes only
			ARRAY TEXT:C222(RelationsList_atxt; 0)
			ARRAY TEXT:C222(RelationsFlushList_atxt; 0)
		End if 
		
		C_LONGINT:C283($numTables_L)
		$numTables_L:=Get last table number:C254
		ARRAY TEXT:C222(TableList_atxt; $numTables_L)
		ARRAY LONGINT:C221(TableList_aL; $numTables_L)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(TableList_atxt))
			TableList_atxt{$loop_L}:=Table name:C256($loop_L)
			TableList_aL{$loop_L}:=$loop_L
		End for 
		TableList_atxt:=0
		SORT ARRAY:C229(TableList_atxt; TableList_aL)
		COPY ARRAY:C226(TableList_atxt; ParentTableList_atxt)
		COPY ARRAY:C226(TableList_aL; ParentTableList_aL)
		Begin SQL
			select Sequences.Name from Sequences order by Sequences.Name into :Sequence_atxt ;
		End SQL
		RELOG_KeyField_L:=0
		Sequence_atxt:=0
		ParentTableList_atxt:=0
		ForeignKeyList_atxt:=0
		ParentKeyList_atxt:=0
		RelationsList_atxt:=0
		RelationsFlushList_atxt:=0
		RELOG_DELFIRST_L:=0
		RELOG_ParentTbl_L:=0
		RELOG_FK_L:=0
		RELOG_PK_L:=0
		RELOG_SEQ_txt:=""
		RELOG_DEST_txt:=""
		RelogDestination_txt:=<>Destination
		C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80
		
		If (vsForward#"")
			RelogForward_txt:=vsForward
		Else 
			RelogForward_txt:=<>Forward
		End if 
		
		RelogTransfer_L:=<>Transfer
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 