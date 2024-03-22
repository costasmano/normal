//Method: Object Method: ReLogRecords.RelogSearch
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/12, 13:48:15
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//

If (RELOG_TBLNum_L>0)
	C_BOOLEAN:C305($onetomany_b; $manytoone_b)
	GET AUTOMATIC RELATIONS:C899($onetomany_b; $manytoone_b)
	C_BLOB:C604($ROState_x)
	$ROState_x:=ut_db_SaveROState
	READ ONLY:C145(*)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	QUERY:C277(Table:C252(RELOG_TBLNum_L)->)
	RELOG_RecsFound_L:=Records in selection:C76(Table:C252(RELOG_TBLNum_L)->)
	
	SET AUTOMATIC RELATIONS:C310($onetomany_b; $manytoone_b)
	ut_db_RestoreROState($ROState_x)
End if 

//End Object Method: ReLogRecords.RelogSearch