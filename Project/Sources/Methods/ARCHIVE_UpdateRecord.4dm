//%attributes = {"invisible":true}
//Method: ARCHIVE_UpdateRecord
//Description
//  `Update a record in the Archive table from the corresponding record in the main Bridge table
//  `Used in cases where errors/corrections made in SIA data in main table and a resubmission was made
//  `to FHWA for the corrections only.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/02/14, 17:26:26
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
	// Modified by: Costas Manousakis-(Designer)-(5/14/18 14:37:24)
	Mods_2018_05
	//  `removed erroneous calls to the old progress bar.
End if 
//

//a) make sure the current selection is OK to update
C_LONGINT:C283($Recs_L)
C_POINTER:C301($ArchTbl_ptr; $MasterTbl_ptr; $ArchTblkey_ptr; $MasterTblKey_ptr; $MasterFld_ptr; $ArchField_ptr)
C_LONGINT:C283($numSourceFlds_L; $numTargFlds_L)

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
		
		//c) verify number of records to be modified
		CONFIRM:C162("All Fields in table ["+Table name:C256($ArchTbl_ptr)+"] will be updated from table ["+Table name:C256($MasterTbl_ptr)+"] for "+String:C10($Recs_L)+" records!"; "Proceed"; "Cancel")
		
		If (OK=1)
			C_DATE:C307($ArchiveDate_d)
			C_TEXT:C284($Date_txt)
			$Date_txt:=String:C10(Current date:C33(*))
			$Date_txt:=Request:C163("Date ? "; $Date_txt)
			$ArchiveDate_d:=Date:C102($Date_txt)
			
			C_LONGINT:C283($NumChanged_L; $RecCounter_L)
			$NumChanged_L:=0
			$RecCounter_L:=0
			// d) do the update only if different - show some progress
			ARRAY POINTER:C280($SourceFlds_aptr; 0)
			ARRAY POINTER:C280($ArchFlds_aptr; 0)
			C_POINTER:C301($ReasonFld_ptr; $DateFld_ptr)
			
			ARCHIVE_MatchFields($MasterTbl_ptr; $ArchTbl_ptr; ->$SourceFlds_aptr; ->$ArchFlds_aptr; ->$ReasonFld_ptr; ->$DateFld_ptr)
			
			C_LONGINT:C283($split_L)
			
			Case of 
				: ($Recs_L<=20)
					$split_L:=1
				: ($Recs_L<=50)
					$split_L:=2
				: ($Recs_L<=200)
					$split_L:=5
				Else 
					$split_L:=20
			End case 
			C_LONGINT:C283($count_L; $NumChanged_L; $fieldsCount_L; $loop_L)
			$count_L:=0
			$NumChanged_L:=0
			READ WRITE:C146($ArchTbl_ptr->)
			FIRST RECORD:C50($ArchTbl_ptr->)
			//start the bar
			C_OBJECT:C1216($progressObj_o)
			$progressObj_o:=ProgressNew("Updating Archive table Scanning "+String:C10($Recs_L)+" Archive Records"; $Recs_L; False:C215; ""; 3)
			$fieldsCount_L:=0
			While (Not:C34(End selection:C36($ArchTbl_ptr->)))
				$count_L:=$count_L+1
				If (ut_LoadRecordInteractive($ArchTbl_ptr))
					QUERY:C277($MasterTbl_ptr->; $MasterTblKey_ptr->=$ArchTblkey_ptr->)
					If (Records in selection:C76($MasterTbl_ptr->)=1)
						LOAD RECORD:C52($MasterTbl_ptr->)
						For ($loop_L; 1; Size of array:C274($SourceFlds_aptr))
							If ($ArchFlds_aptr{$loop_L}->#$SourceFlds_aptr{$loop_L}->)
								$ArchFlds_aptr{$loop_L}->:=$SourceFlds_aptr{$loop_L}->
								$fieldsCount_L:=$fieldsCount_L+1
							End if 
							
						End for 
						If (Modified record:C314($ArchTbl_ptr->))
							$DateFld_ptr->:=$ArchiveDate_d
							SAVE RECORD:C53($ArchTbl_ptr->)
							$NumChanged_L:=$NumChanged_L+1
						End if 
						UNLOAD RECORD:C212($ArchTbl_ptr->)
						If (($count_L%$split_L)=0)
							//UpdateProgress ($count_L;$Recs_L)
							//update progress
							UpdateProgressNew($progressObj_o; $count_L)
							
							
						End if 
						
					End if 
					
				End if 
				
				NEXT RECORD:C51($ArchTbl_ptr->)
			End while 
			//stop the progress bar
			//CALL PROCESS(<>ProgressPID)
			//quit progress
			Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
			//e) Show summary of what was done and exit
			ALERT:C41("Checked "+String:C10($Recs_L)+" archive records; updated "+String:C10($NumChanged_L)+" records, "+String:C10($fieldsCount_L)+" Fields")
			
		End if 
		
		
End case 

//End ARCHIVE_UpdateRecord