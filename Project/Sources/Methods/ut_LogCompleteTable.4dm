//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/17/07, 08:19:05
	// ----------------------------------------------------
	// Method: ut_LogCompleteTable
	// Description
	// Create Activity Log entries for records in a table.
	// This will download to child dbs all entries for a table.
	// Will only work properly for a table where the local id is a fixed one,
	// i.e. same id throughout al dbs.
	// The log entries created will be a series of Delete, LogNew and Grp chgs 
	// for each record in the table.
	
	// Parameters
	// ----------------------------------------------------
	MODS_2007_CM04
End if 
C_LONGINT:C283($TableNum_L; $NumRecs_L; $KeyFieldNum_L; $i; $NumTblFlds_L; $FldCounter_L)
$TableNum_L:=ut_SelectTableNum
If ($TableNum_L>0)
	$KeyFieldNum_L:=ut_SelectFieldNum($TableNum_L)
	If ($KeyFieldNum_L>0)
		C_POINTER:C301($Table_ptr; $KeyFld_ptr)
		$Table_ptr:=Table:C252($TableNum_L)
		$KeyFld_ptr:=Field:C253($TableNum_L; $KeyFieldNum_L)
		$NumTblFlds_L:=Get last field number:C255($TableNum_L)
		READ ONLY:C145($Table_ptr->)
		QUERY:C277($Table_ptr->)  //Do a query
		$NumRecs_L:=Records in selection:C76($Table_ptr->)
		If ($NumRecs_L>0)
			FIRST RECORD:C50($Table_ptr->)
			For ($i; 1; $NumRecs_L)
				LogDeletion($KeyFld_ptr; $KeyFld_ptr; $KeyFld_ptr; 0)
				LogNewRecord($KeyFld_ptr; $KeyFld_ptr; $KeyFld_ptr; 0; "")
				InitChangeStack(1)
				For ($FldCounter_L; 1; $NumTblFlds_L)
					If ($FldCounter_L#$KeyFieldNum_L)
						PushChange(1; Field:C253($TableNum_L; $FldCounter_L))
					End if 
				End for 
				FlushGrpChgs(1; $KeyFld_ptr; $KeyFld_ptr; $KeyFld_ptr; 0)
				NEXT RECORD:C51($Table_ptr->)
			End for 
			
		Else 
			ALERT:C41("No Records selected for table ["+Table name:C256($TableNum_L)+"]!!")
		End if 
		
		READ WRITE:C146($Table_ptr->)
	End if 
	
End if 