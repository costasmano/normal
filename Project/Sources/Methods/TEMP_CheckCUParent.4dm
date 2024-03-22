//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/19/05, 11:45:10
	// ----------------------------------------------------
	// Method: TEMP_CheckCUParent
	// Description
	// Check for Cond Units that have been Orphaned
	//
	// Parameters
	// ----------------------------------------------------
	
End if 
If (Current user:C182#"Designer")
Else 
	ALL RECORDS:C47([BMS Inspections:44])
	RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
	CREATE SET:C116([Cond Units:45]; "$CUsWithParent")
	ALL RECORDS:C47([Cond Units:45])
	CREATE SET:C116([Cond Units:45]; "$AllCUs")
	DIFFERENCE:C122("$AllCUs"; "$CUsWithParent"; "$OrphanCUs")
	USE SET:C118("$OrphanCUs")
	CLEAR SET:C117("$OrphanCUs")
	CLEAR SET:C117("$CUsWithParent")
	CLEAR SET:C117("$AllCUs")
	ARRAY LONGINT:C221($arBMSIDs; 0)
	DISTINCT VALUES:C339([Cond Units:45]Inspection ID:2; $arBMSIDs)
	C_LONGINT:C283($BMSRecCheck)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BMSRecCheck)
	QUERY WITH ARRAY:C644([BMS Inspections:44]Inspection ID:1; $arBMSIDs)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
