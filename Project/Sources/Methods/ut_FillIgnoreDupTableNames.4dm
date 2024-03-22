//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/19/13, 14:11:45
//----------------------------------------------------
//Method: ut_FillIgnoreDupTableNames
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_12  // Add ability to skip add record errors for certain tables
	//Modified by: Charles Miller (12/19/13 14:11:47)
End if 

If (Size of array:C274(IgnoreDuplicateKeyTables_atxt)=0)
	C_TEXT:C284($Query_txt; $Results_txt)
	$Query_txt:="IgnoreDuplicateKey"
	Begin SQL
		
		SELECT [Parameters].[Description] 
		FROM 
		[Parameters] 
		WHERE [Parameters].[ParamCode] = :$Query_txt 
		INTO :$Results_txt;
		
	End SQL
	
	ut_NewTextToArray($Results_txt; ->IgnoreDuplicateKeyTables_atxt; ",")
End if 
//End ut_FillIgnoreDupTableNames

