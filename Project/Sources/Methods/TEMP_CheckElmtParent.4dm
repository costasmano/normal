//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/14/06, 12:48:18
	// ----------------------------------------------------
	// Method: TEMP_CheckElmtParent
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
If (Current user:C182="designer")
	ALL RECORDS:C47([Inspections:27])
	RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
	CREATE SET:C116([ElementsSafety:29]; "$CUsWithParent")
	ALL RECORDS:C47([ElementsSafety:29])
	CREATE SET:C116([ElementsSafety:29]; "$AllCUs")
	DIFFERENCE:C122("$AllCUs"; "$CUsWithParent"; "$OrphanCUs")
	USE SET:C118("$OrphanCUs")
	CLEAR SET:C117("$OrphanCUs")
	CLEAR SET:C117("$CUsWithParent")
	CLEAR SET:C117("$AllCUs")
	ARRAY LONGINT:C221($arBMSIDs; 0)
	DISTINCT VALUES:C339([ElementsSafety:29]InspID:4; $arBMSIDs)
	C_LONGINT:C283($BMSRecCheck)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $BMSRecCheck)
	QUERY WITH ARRAY:C644([Inspections:27]InspID:2; $arBMSIDs)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
