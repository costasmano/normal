//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/16/07, 21:21:18
	// ----------------------------------------------------
	// Method: ut_CustomTableLoad
	// Description
	//  ` Load a table from an export file created by ut_CustomTableExport
	//  ` See method ut_CustomTableExport
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(5/21/2007 09:25:03)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(11/7/2007 10:14:53)
	Mods_2007_CM12_5302
End if 
C_BOOLEAN:C305($DoneImporting_b)
$DoneImporting_b:=False:C215
Repeat 
	
	SET CHANNEL:C77(10; "")
	If (OK=1)
		C_TEXT:C284($vTag_txt)
		RECEIVE VARIABLE:C81($vTag_txt)
		If ($vTag_txt="MHDBMSTABLEEXPORT")
			C_LONGINT:C283($KeyFieldNum_L; $NumTableRecs_L; $TableNum_L; $i; $FieldType_L)
			RECEIVE VARIABLE:C81($TableNum_L)
			RECEIVE VARIABLE:C81($KeyFieldNum_L)
			RECEIVE VARIABLE:C81($NumTableRecs_L)
			C_POINTER:C301($TablePtr_ptr; $KeyField_ptr)
			$TablePtr_ptr:=Table:C252($TableNum_L)
			$KeyField_ptr:=Field:C253($TableNum_L; $KeyFieldNum_L)
			GET FIELD PROPERTIES:C258($TableNum_L; $KeyFieldNum_L; $FieldType_L)
			C_BOOLEAN:C305($ContinueImport_B)
			$ContinueImport_B:=True:C214
			C_LONGINT:C283($KeyFieldVal_i)  //Command Replaced was o_C_INTEGER
			C_LONGINT:C283($KeyFieldVal_L)
			C_TEXT:C284($KeyFieldVal_s)  // Command Replaced was o_C_STRING length was 80
			Case of 
				: ($FieldType_L=Is integer:K8:5)
				: ($FieldType_L=Is longint:K8:6)
				: ($FieldType_L=Is alpha field:K8:1)
				Else 
					ALERT:C41("Cannot handle key fields of type "+String:C10($FieldType_L))
					$ContinueImport_B:=False:C215
			End case 
			If ($ContinueImport_B)
				C_LONGINT:C283(UTCUSTOMIMOPRTERR)
				UTCUSTOMIMOPRTERR:=0
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				<>ProgressPID:=StartProgress("CustomImport"; "None"; "Importing records for table "+Table name:C256($TableNum_L))
				UpdateProgress(0; $NumTableRecs_L)
				For ($i; 1; $NumTableRecs_L)
					
					RECEIVE RECORD:C79($TablePtr_ptr->)
					SET QUERY DESTINATION:C396(Into set:K19:2; "LOCALIMPORTRECORD")
					Case of 
						: ($FieldType_L=Is integer:K8:5)
							$KeyFieldVal_i:=$KeyField_ptr->
							QUERY:C277($TablePtr_ptr->; $KeyField_ptr->=$KeyFieldVal_i)
						: ($FieldType_L=Is longint:K8:6)
							$KeyFieldVal_L:=$KeyField_ptr->
							QUERY:C277($TablePtr_ptr->; $KeyField_ptr->=$KeyFieldVal_L)
						: ($FieldType_L=Is alpha field:K8:1)
							$KeyFieldVal_s:=$KeyField_ptr->
							QUERY:C277($TablePtr_ptr->; $KeyField_ptr->=$KeyFieldVal_s)
					End case 
					ON ERR CALL:C155("ut_CustomImportERR")
					If (Records in set:C195("LOCALIMPORTRECORD")=1)
						//update local
						PUSH RECORD:C176($TablePtr_ptr->)
						READ WRITE:C146($TablePtr_ptr->)
						USE SET:C118("LOCALIMPORTRECORD")
						FIRST RECORD:C50($TablePtr_ptr->)
						Case of 
							: (($FieldType_L=Is integer:K8:5) | ($FieldType_L=Is longint:K8:6))
								$KeyField_ptr->:=0  //there should not be a record with this..
							: ($FieldType_L=Is alpha field:K8:1)
								$KeyField_ptr->:=""  //there should not be a record with this..
						End case 
						SAVE RECORD:C53($TablePtr_ptr->)
						DELETE RECORD:C58($TablePtr_ptr->)
						If (UTCUSTOMIMOPRTERR=0)
							POP RECORD:C177($TablePtr_ptr->)
							SAVE RECORD:C53($TablePtr_ptr->)
							If (UTCUSTOMIMOPRTERR#0)
								Case of 
									: ($FieldType_L=Is integer:K8:5)
										ALERT:C41("Error Saving  replacement record ID="+String:C10($KeyFieldVal_i))
									: ($FieldType_L=Is longint:K8:6)
										ALERT:C41("Error Saving  replacement record  ID="+String:C10($KeyFieldVal_L))
									: ($FieldType_L=Is alpha field:K8:1)
										ALERT:C41("Error Saving  replacement record  ID="+$KeyFieldVal_s)
								End case 
								
							End if 
						Else 
							Case of 
								: ($FieldType_L=Is integer:K8:5)
									ALERT:C41("Error deleting existing record ID="+String:C10($KeyFieldVal_i))
								: ($FieldType_L=Is longint:K8:6)
									ALERT:C41("Error deleting existing record  ID="+String:C10($KeyFieldVal_L))
								: ($FieldType_L=Is alpha field:K8:1)
									ALERT:C41("Error deleting existing record  ID="+$KeyFieldVal_s)
							End case 
						End if 
						
					Else 
						If (Records in set:C195("LOCALIMPORTRECORD")>1)
							ALERT:C41("Multiple records found....")
						Else 
							//create new record
							SAVE RECORD:C53($TablePtr_ptr->)
							If (UTCUSTOMIMOPRTERR#0)
								Case of 
									: ($FieldType_L=Is integer:K8:5)
										ALERT:C41("Error Saving  new record ID="+String:C10($KeyFieldVal_i))
									: ($FieldType_L=Is longint:K8:6)
										ALERT:C41("Error Saving  new record  ID="+String:C10($KeyFieldVal_L))
									: ($FieldType_L=Is alpha field:K8:1)
										ALERT:C41("Error Saving  new record  ID="+$KeyFieldVal_s)
								End case 
								
							End if 
						End if 
					End if 
					ON ERR CALL:C155("")
					UTCUSTOMIMOPRTERR:=0
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($i%20)=0
						UpdateProgress($i; $NumTableRecs_L)
					End if 
				End for 
				POST OUTSIDE CALL:C329(<>ProgressPID)
				CLEAR SET:C117("LOCALIMPORTRECORD")
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			End if 
		Else 
			ALERT:C41("Not a vaiid export file!")
		End if 
		
	End if 
	SET CHANNEL:C77(11)
	CONFIRM:C162("Try again?"; "Again"; "Done")
	If (OK=1)
	Else 
		$DoneImporting_b:=True:C214
	End if 
	
Until ($DoneImporting_b)