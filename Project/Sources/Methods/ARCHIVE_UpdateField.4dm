//%attributes = {"invisible":true}
//Method: ARCHIVE_UpdateField
//Description
//  `Update a field in the Archive table from the corresponding field in the main Bridge table
//  `Used in cases where errors/corrections made in SIA data in main table and a resubmission was made
//  `to FHWA for the corrections only.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/18/13, 09:59:03
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 
//
//a) make sure the current selection is OK to update
C_LONGINT:C283($Recs_L)
C_POINTER:C301($ArchTbl_ptr; $MasterTbl_ptr; $ArchTblkey_ptr; $MasterTblKey_ptr; $MasterFld_ptr; $ArchField_ptr)
$MasterTbl_ptr:=->[Bridge MHD NBIS:1]
$ArchTbl_ptr:=->[BridgeMHDNBISArchive:139]
$ArchTblkey_ptr:=->[BridgeMHDNBISArchive:139]BIN:3
$MasterTblKey_ptr:=->[Bridge MHD NBIS:1]BIN:3

READ ONLY:C145($MasterTbl_ptr->)

C_BOOLEAN:C305($GoOn_b; $Abort_b)
$GoOn_b:=False:C215
$Abort_b:=False:C215
Repeat 
	$Recs_L:=Records in selection:C76($ArchTbl_ptr->)
	C_LONGINT:C283($Option_L)
	$Option_L:=ut_3Option_Confirm("Ready to update "+String:C10($Recs_L)+" of table "+Table name:C256($ArchTbl_ptr)+" ?"; "Proceed"; "Search again"; "Cancel ALL")
	Case of 
		: ($Option_L=1)
			$GoOn_b:=True:C214
		: ($Option_L=2)
			QUERY:C277($ArchTbl_ptr->)
		: ($Option_L=3)
			$Abort_b:=True:C214
			
	End case 
	
Until ($GoOn_b | $Abort_b)

Case of 
	: ($Abort_b)
		ALERT:C41("Operation Cancelled!!!")
	: ($Recs_L=0)
		ALERT:C41("No records in table "+Table name:C256($ArchTbl_ptr)+" were selected!!!")
	: ($GoOn_b)
		
		//b) get field to be updated - pick just the field from main bridge table
		C_LONGINT:C283($sourceField_L; $Type_L; $fieldLen_L; $archfields_L; $matchFldNum_L; $ArchType_L; $archfieldLen_L; $fldLoop_L)
		$sourceField_L:=ut_SelectFieldNum(Table:C252($MasterTbl_ptr))
		$MasterFld_ptr:=Field:C253(Table:C252($MasterTbl_ptr); $sourceField_L)
		C_TEXT:C284($fieldName_txt)
		$fieldName_txt:=Field name:C257(Table:C252($MasterTbl_ptr); $sourceField_L)
		GET FIELD PROPERTIES:C258(Table:C252($MasterTbl_ptr); $sourceField_L; $Type_L; $fieldLen_L)
		$archfields_L:=Get last field number:C255($ArchTbl_ptr)
		$matchFldNum_L:=0
		//then find corresponding field in archive table
		For ($fldLoop_L; 1; $archfields_L)
			
			If (Field name:C257(Table:C252($ArchTbl_ptr); $fldLoop_L)=$fieldName_txt)
				//verify same type
				GET FIELD PROPERTIES:C258(Table:C252($ArchTbl_ptr); $fldLoop_L; $ArchType_L; $archfieldLen_L)
				Case of 
					: ($ArchType_L#$Type_L)
						ALERT:C41("field Types do not match - master type :"+fGetDataType($Type_L)+" # archive type "+fGetDataType($ArchType_L))
					: ($archfieldLen_L<$fieldLen_L)
						ALERT:C41("field lengths do not match - master length :"+String:C10($fieldLen_L)+" > archive length "+String:C10($archfieldLen_L))
					Else 
						$matchFldNum_L:=$fldLoop_L
				End case 
				//Found it - end field loop
				$fldLoop_L:=$archfields_L+1
				
			End if 
			
		End for 
		
		//if not found - abort!!!!
		If ($matchFldNum_L>0)
			$ArchField_ptr:=Field:C253(Table:C252($ArchTbl_ptr); $matchFldNum_L)
			//c) verify number of records to be modified
			CONFIRM:C162("Field "+Field name:C257(Table:C252($ArchTbl_ptr); $matchFldNum_L)+" in table ["+Table name:C256($ArchTbl_ptr)+"] will be updated from table ["+Table name:C256($MasterTbl_ptr)+"] for "+String:C10($Recs_L)+" records!"; "Proceed"; "Cancel")
			
			If (OK=1)
				C_LONGINT:C283($NumChanged_L; $RecCounter_L)
				$NumChanged_L:=0
				$RecCounter_L:=0
				// d) do the update only if different - show some progress
				READ WRITE:C146($ArchTbl_ptr->)
				FIRST RECORD:C50($ArchTbl_ptr->)
				//start the bar
				//C_LONGINT(<>ProgressPID)
				//<>ProgressPID:=StartProgress ("Updating Archive table";"Button";"Archive Records ";"Archive Records")
				C_OBJECT:C1216($progressObj_o)
				$progressObj_o:=ProgressNew("Updating Archive table"; $Recs_L; False:C215; ""; 3)
				
				While (Not:C34(End selection:C36($ArchTbl_ptr->)))
					$RecCounter_L:=$RecCounter_L+1
					If (ut_LoadRecordInteractive($ArchTbl_ptr))
						QUERY:C277($MasterTbl_ptr->; $MasterTblKey_ptr->=$ArchTblkey_ptr->)
						If (Records in selection:C76($MasterTbl_ptr->)=1)
							LOAD RECORD:C52($MasterTbl_ptr->)
							
							If ($ArchField_ptr->#$MasterFld_ptr->)
								//  `Count number of changed records
								$ArchField_ptr->:=$MasterFld_ptr->
								SAVE RECORD:C53($ArchTbl_ptr->)
								$NumChanged_L:=$NumChanged_L+1
							End if 
							
						End if 
						
					End if 
					
					//update the bar
					If ($RecCounter_L%5=0)
						//UpdateProgress ($RecCounter_L;$Recs_L)
						//update progress
						UpdateProgressNew($progressObj_o; $RecCounter_L)
						
					End if 
					
					NEXT RECORD:C51($ArchTbl_ptr->)
				End while 
				//stop the progress bar
				//CALL PROCESS(<>ProgressPID)
				//quit progress
				Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
				//e) Show summary of what was done and exit
				ALERT:C41("Checked "+String:C10($Recs_L)+" archive records; updated "+String:C10($NumChanged_L))
				
			End if 
			
		End if 
		
End case 

//End ARCHIVE_UpdateField