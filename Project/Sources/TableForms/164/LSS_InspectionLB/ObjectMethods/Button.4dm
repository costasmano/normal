
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 02/25/16, 13:06:03
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].LSS_InspectionLB.Button
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
ARRAY LONGINT:C221(SQL_Limits_AL; 0)
C_BOOLEAN:C305($HasPicture_b)
compiler_clone
COMPILER_forSQL
C_TEXT:C284($IPAddress_txt)

$IPAddress_txt:=SQL_TestConnection
If ($IPAddress_txt#"")
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	ARRAY TEXT:C222($RemoteInspectionIDs_atxt; 0)
	C_TEXT:C284($Match_txt)
	$Match_txt:="IMPORT%"
	Compiler_FieldVariables(Table:C252(->[LSS_Inventory:165]))
	
	Begin SQL
		select
		[LSS_Inspection].[LSS_InspectionId_s]
		from
		[LSS_Inspection]
		where
		[LSS_Inspection].[LSS_InspectionId_s] like :$Match_txt
		into
		:$RemoteInspectionIDs_atxt;
		
		
		select
		[LSS_Inventory].[LSS_InventoryId_s]
		from
		[LSS_Inventory]
		where
		[LSS_Inventory].[LSS_InventoryId_s] like :$Match_txt
		into :v_165_001_atxt;
		
		
	End SQL
	
	ut_SQLLogout
End if 
Compiler_LB


If (Size of array:C274($RemoteInspectionIDs_atxt)>0)
	ALL RECORDS:C47([LSS_Inspection:164])
	CREATE SET:C116([LSS_Inspection:164]; "LocalSet")
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "RemoteMatches")
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InspectionId_s:1; $RemoteInspectionIDs_atxt)
	DIFFERENCE:C122("LocalSet"; "RemoteMatches"; "LocalSet")
	USE SET:C118("LocalSet")
	SET WINDOW TITLE:C213("Displaying "+String:C10(Records in set:C195("LocalSet"))+" out of "+String:C10(Records in table:C83([LSS_Inspection:164]))+" records")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	CLEAR SET:C117("LocalSet")
	CLEAR SET:C117("RemoteMatches")
	
	
End if 