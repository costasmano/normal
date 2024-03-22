//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/10, 20:38:15
	// ----------------------------------------------------
	// Method: ut_ExportCopyTable
	// Description
	//  ` Export a table definition into a Blob file usable by AP Pack, or Import that file and create a table.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
If (Current user:C182="Designer")
	C_LONGINT:C283($NewTableNum_L)
	C_TEXT:C284($Task_txt)
	$Task_txt:=""
	If (Count parameters:C259>0)
		C_TEXT:C284($1)
		$Task_txt:=$1
	End if 
	
	Case of 
		: ($Task_txt="")
			C_LONGINT:C283($Option_L)
			Repeat 
				$Option_L:=ut_3Option_Confirm("Do an Export to Copy, Import a Copy, or Cancel?"; "Export"; "Import"; "Cancel")
				Case of 
					: ($Option_L=1)
						ut_ExportCopyTable("EXPORTCOPY")
					: ($Option_L=2)
						ut_ExportCopyTable("MAKECOPY")
					: ($Option_L=3)
						
				End case 
				
			Until ($Option_L=3)
			
		: ($Task_txt="EXPORTCOPY")
			C_LONGINT:C283($TableNum_L)
			$TableNum_L:=ut_SelectTableNum
			If ($TableNum_L>0)
				C_BLOB:C604($TableData_blb)
				C_LONGINT:C283($NumFields_L; $Loop_L)
				$NumFields_L:=Get last field number:C255($TableNum_L)
				ARRAY TEXT:C222($FieldNames_atxt; $NumFields_L)
				ARRAY LONGINT:C221($FieldTypes_aL; $NumFields_L)
				ARRAY LONGINT:C221($FieldLengths_aL; $NumFields_L)
				C_TEXT:C284($FieldName_txt; $TableName_txt)
				C_LONGINT:C283($Fldtype_L; $FieldLen_L)
				For ($Loop_L; 1; $NumFields_L)
					$FieldName_txt:=Field name:C257($TableNum_L; $Loop_L)
					GET FIELD PROPERTIES:C258($TableNum_L; $Loop_L; $Fldtype_L; $FieldLen_L)
					$FieldNames_atxt{$Loop_L}:=$FieldName_txt
					$FieldTypes_aL{$Loop_L}:=$Fldtype_L
					$FieldLengths_aL{$Loop_L}:=$FieldLen_L
				End for 
				$TableName_txt:=Table name:C256($TableNum_L)
				VARIABLE TO BLOB:C532($TableName_txt; $TableData_blb; *)
				VARIABLE TO BLOB:C532($NumFields_L; $TableData_blb; *)
				VARIABLE TO BLOB:C532($FieldNames_atxt; $TableData_blb; *)
				VARIABLE TO BLOB:C532($FieldTypes_aL; $TableData_blb; *)
				VARIABLE TO BLOB:C532($FieldLengths_aL; $TableData_blb; *)
				
				C_TIME:C306($TableDataFile_t)
				SET TEXT TO PASTEBOARD:C523(String:C10($TableNum_L)+"_"+$TableName_txt+"_Structure.export")
				$TableDataFile_t:=Create document:C266("")
				If (OK=1)
					C_TEXT:C284($TableDataFile_txt)
					$TableDataFile_txt:=Document
					CLOSE DOCUMENT:C267($TableDataFile_t)
					BLOB TO DOCUMENT:C526($TableDataFile_txt; $TableData_blb)
				End if 
				SET BLOB SIZE:C606($TableData_blb; 0)
			End if 
			
		: ($Task_txt="MAKECOPY")
			C_TIME:C306($TableDataFile_t)
			$TableDataFile_t:=Open document:C264(""; ""; Read mode:K24:5)
			If (OK=1)
				C_BLOB:C604($TableData_blb)
				C_TEXT:C284($TableDataFile_txt)
				$TableDataFile_txt:=Document
				DOCUMENT TO BLOB:C525($TableDataFile_txt; $TableData_blb)
				CLOSE DOCUMENT:C267($TableDataFile_t)
				C_TEXT:C284($TableName_txt)
				C_LONGINT:C283($offset_L; $NumFields_L)
				$offset_L:=0
				BLOB TO VARIABLE:C533($TableData_blb; $TableName_txt; $offset_L)
				ARRAY TEXT:C222($myTables_atxt; 0)
				C_LONGINT:C283($MyTables_L)
				$MyTables_L:=Get last table number:C254
				ARRAY TEXT:C222($myTables_atxt; $MyTables_L)
				C_LONGINT:C283($loop_L; $FoundTable_L; $FoundBMS2ndArch_L)
				For ($loop_L; 1; Size of array:C274($myTables_atxt))
					$myTables_atxt{$loop_L}:=Table name:C256($loop_L)
				End for 
				$FoundTable_L:=Find in array:C230($myTables_atxt; $TableName_txt)
				If ($FoundTable_L>0)
					ALERT:C41("Table "+$TableName_txt+" already exists at number "+String:C10($FoundTable_L))
				Else 
					BLOB TO VARIABLE:C533($TableData_blb; $NumFields_L; $offset_L)
					ARRAY TEXT:C222($FieldNames_atxt; $NumFields_L)
					ARRAY LONGINT:C221($FieldTypes_aL; $NumFields_L)
					ARRAY LONGINT:C221($FieldLengths_aL; $NumFields_L)
					BLOB TO VARIABLE:C533($TableData_blb; $FieldNames_atxt; $offset_L)
					BLOB TO VARIABLE:C533($TableData_blb; $FieldTypes_aL; $offset_L)
					BLOB TO VARIABLE:C533($TableData_blb; $FieldLengths_aL; $offset_L)
					
					CONFIRM:C162("Ready to create a table "+$TableName_txt+" with "+String:C10($NumFields_L)+" Fields in structure "+Structure file:C489+"?")
					//$NewTableNum_L:=Ô11999;44Ô ($TableName_txt;$FieldNames_atxt;$FieldTypes_aL;$FieldLengths_aL)
					ALERT:C41("This is not working in v17!")
				End if 
				
			End if 
			
	End case 
End if 