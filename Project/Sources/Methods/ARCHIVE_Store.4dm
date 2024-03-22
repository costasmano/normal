//%attributes = {"invisible":true}
// Method: ARCHIVE_Store
// Description
//  ` Copy data from source tables to the archive tables
// 
// Parameters
// $1 : $ArchiveReason_txt (Optional)
// $2 : $ArchiveDate_d (optional)
// $3 : $SourceTable_ptr (Optional)  - specified in pairs of tables
// $4 : $ArchTable_ptr (required if previous parameter is passed 
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/02/10, 22:29:58
	// ----------------------------------------------------
	
	Mods_2010_08
	// Modified by: costasmanousakis-(Designer)-(9/23/11 14:32:14)
	Mods_2011_09
	//  `When no parameters are passed Ask for reason and date of archive - for NBI tape ask for the year.
	// Modified by: Costas Manousakis-(Designer)-(3/30/12 09:13:48)
	Mods_2012_04
	//Added Message at the end about the completion after confirmation
	// Modified by: Costas Manousakis-(Designer)-(4/1/13 09:25:57)
	Mods_2013_04
	//  `Fixed the Show Alert logic and added progress bars
	// Modified by: Costas Manousakis-(Designer)-(4/7/14 12:27:13)
	Mods_2014_04
	//  `Use new method ARCHIVE_MatchFields to match the fields from the source to the archive table
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
	// Modified by: Costas Manousakis-(Designer)-(2022-11-14 09:38:40)
	Mods_2022_11_bug
	//  `execute the method if user is design access group or if running on server
End if 
TRACE:C157
C_BOOLEAN:C305($execute)
$execute:=User in group:C338(Current user:C182; "Design Access Group")  //execute if design user 
$execute:=$execute | (Application type:C494=4D Server:K5:6)  // or running on server
If ($execute)
	C_LONGINT:C283($numSourceFlds_L; $numTargFlds_L)
	C_POINTER:C301($SourceTable_ptr; $ArchTable_ptr)
	C_TEXT:C284($ArchiveReason_txt)
	C_DATE:C307($ArchiveDate_d)
	C_BOOLEAN:C305(ARCHIVE_SHOWALERT_b)
	Case of 
		: (Count parameters:C259=0)
			$ArchiveReason_txt:=""
			$ArchiveDate_d:=!00-00-00!
			C_TEXT:C284($nbiyear_txt; $Date_txt)
			$Date_txt:=String:C10(Current date:C33(*))
			
			CONFIRM:C162("Is this an NBI tape Archive or something Else?"; "NBI Tape"; "Something Else")
			If (OK=1)
				$nbiyear_txt:=Request:C163("Enter year of NBI Tape")
				If ((Num:C11($nbiyear_txt)>1900) & (Num:C11($nbiyear_txt)<=Year of:C25(Current date:C33(*))))
					$ArchiveReason_txt:="NBI TAPE "+String:C10(Num:C11($nbiyear_txt))
					$Date_txt:=String:C10(Date:C102("4/1/"+String:C10(Num:C11($nbiyear_txt))))
				Else 
					ALERT:C41("Year must be between 1900 and "+String:C10(Year of:C25(Current date:C33(*))))
				End if 
				
			Else 
				$ArchiveReason_txt:=Request:C163("Reason for Archive"; "MONTHLYARCHIVE")
			End if 
			$Date_txt:=Request:C163("Date ? "; $Date_txt)
			$ArchiveDate_d:=Date:C102($Date_txt)
			If (($ArchiveReason_txt#"") & ($ArchiveDate_d#!00-00-00!))
				CONFIRM:C162("Show Alert when Archive process is complete?"; "Show"; "No Alert")
				ARCHIVE_SHOWALERT_b:=(OK=1)
				ARCHIVE_Store($ArchiveReason_txt; $ArchiveDate_d; ->[Bridge MHD NBIS:1]; ->[BridgeMHDNBISArchive:139]; ->[NBIS Secondary:3]; ->[NBISSecondaryArchive:140])
			Else 
				ALERT:C41("Archiving Aborted!!!")
			End if 
			
		: (Count parameters:C259=1)
			C_TEXT:C284($1)
			$ArchiveReason_txt:=$1
			Case of 
				: ($ArchiveReason_txt="CHECKTABLES")
					C_TEXT:C284($Msg_txt)
					//Check if there are fields in source table not in archive table
					$SourceTable_ptr:=->[Bridge MHD NBIS:1]
					$ArchTable_ptr:=->[BridgeMHDNBISArchive:139]
					$numSourceFlds_L:=Get last field number:C255($SourceTable_ptr)
					$numTargFlds_L:=Get last field number:C255($ArchTable_ptr)
					ARRAY TEXT:C222($SourceFlds_atxt; $numSourceFlds_L)
					ARRAY TEXT:C222($targetFlds_atxt; $numTargFlds_L)
					C_LONGINT:C283($loop_L; $Index_L; $count_L)
					For ($loop_L; 1; Size of array:C274($targetFlds_atxt))
						$targetFlds_atxt{$loop_L}:=Field name:C257(Table:C252($ArchTable_ptr); $loop_L)
					End for 
					C_LONGINT:C283($FieldType_L; $FieldLen_L)
					$Msg_txt:=""
					For ($loop_L; 1; Size of array:C274($SourceFlds_atxt))
						GET FIELD PROPERTIES:C258(Field:C253(Table:C252($SourceTable_ptr); $loop_L); $FieldType_L; $FieldLen_L)
						If ($FieldType_L#Is subtable:K8:11)
							$SourceFlds_atxt{$loop_L}:=Field name:C257(Table:C252($SourceTable_ptr); $loop_L)
							$Index_L:=Find in array:C230($targetFlds_atxt; $SourceFlds_atxt{$loop_L})
							If ($Index_L>0)
								//$ArchFlds_aptr{$loop_L}:=Field(Table($ArchTable_ptr);$Index_L)
							Else 
								$Msg_txt:=$Msg_txt+"Missing field ["+Table name:C256($SourceTable_ptr)+"]"+$SourceFlds_atxt{$loop_L}+"(Type:"+fGetDataType($FieldType_L)+"-Len:"+String:C10($FieldLen_L)+") in table ["+Table name:C256($ArchTable_ptr)+"]"+Char:C90(13)
							End if 
							
						End if 
						
					End for 
					$SourceTable_ptr:=->[NBIS Secondary:3]
					$ArchTable_ptr:=->[NBISSecondaryArchive:140]
					$numSourceFlds_L:=Get last field number:C255($SourceTable_ptr)
					$numTargFlds_L:=Get last field number:C255($ArchTable_ptr)
					ARRAY TEXT:C222($SourceFlds_atxt; $numSourceFlds_L)
					ARRAY TEXT:C222($targetFlds_atxt; $numTargFlds_L)
					C_LONGINT:C283($loop_L; $Index_L; $count_L)
					For ($loop_L; 1; Size of array:C274($targetFlds_atxt))
						$targetFlds_atxt{$loop_L}:=Field name:C257(Table:C252($ArchTable_ptr); $loop_L)
					End for 
					C_LONGINT:C283($FieldType_L; $FieldLen_L)
					For ($loop_L; 1; Size of array:C274($SourceFlds_atxt))
						GET FIELD PROPERTIES:C258(Field:C253(Table:C252($SourceTable_ptr); $loop_L); $FieldType_L; $FieldLen_L)
						If ($FieldType_L#Is subtable:K8:11)
							$SourceFlds_atxt{$loop_L}:=Field name:C257(Table:C252($SourceTable_ptr); $loop_L)
							$Index_L:=Find in array:C230($targetFlds_atxt; $SourceFlds_atxt{$loop_L})
							If ($Index_L>0)
								//$ArchFlds_aptr{$loop_L}:=Field(Table($ArchTable_ptr);$Index_L)
							Else 
								$Msg_txt:=$Msg_txt+"Missing field ["+Table name:C256($SourceTable_ptr)+"]"+$SourceFlds_atxt{$loop_L}+"(Type:"+fGetDataType($FieldType_L)+"-Len:"+String:C10($FieldLen_L)+") in table ["+Table name:C256($ArchTable_ptr)+"]"+Char:C90(13)
							End if 
							
						End if 
						
					End for 
					If ($Msg_txt#"")
						ALERT:C41($Msg_txt)
					End if 
					
				Else 
					$ArchiveDate_d:=Current date:C33(*)
					ARCHIVE_SHOWALERT_b:=False:C215
					ARCHIVE_Store($ArchiveReason_txt; $ArchiveDate_d; ->[Bridge MHD NBIS:1]; ->[BridgeMHDNBISArchive:139]; ->[NBIS Secondary:3]; ->[NBISSecondaryArchive:140])
			End case 
			
		: (Count parameters:C259=2)
			C_TEXT:C284($1)
			C_DATE:C307($2)
			$ArchiveReason_txt:=$1
			$ArchiveDate_d:=$2
			ARCHIVE_SHOWALERT_b:=False:C215
			ARCHIVE_Store($ArchiveReason_txt; $ArchiveDate_d; ->[Bridge MHD NBIS:1]; ->[BridgeMHDNBISArchive:139]; ->[NBIS Secondary:3]; ->[NBISSecondaryArchive:140])
			
		: (Count parameters:C259>=4)
			C_POINTER:C301(${3})
			C_TEXT:C284($1)
			C_DATE:C307($2)
			$ArchiveReason_txt:=$1
			$ArchiveDate_d:=$2
			C_LONGINT:C283($TableLoop_L; $ParamCount_L)
			$ParamCount_L:=Count parameters:C259
			For ($TableLoop_L; 3; $ParamCount_L; 2)
				$SourceTable_ptr:=${$TableLoop_L}
				$ArchTable_ptr:=${$TableLoop_L+1}
				ARRAY POINTER:C280($SourceFlds_aptr; 0)
				ARRAY POINTER:C280($ArchFlds_aptr; 0)
				C_POINTER:C301($ReasonFld_ptr; $DateFld_ptr)
				
				If (False:C215)
					$numSourceFlds_L:=Get last field number:C255($SourceTable_ptr)
					$numTargFlds_L:=Get last field number:C255($ArchTable_ptr)
					ARRAY TEXT:C222($SourceFlds_atxt; $numSourceFlds_L)
					
					ARRAY TEXT:C222($targetFlds_atxt; $numTargFlds_L)
					
					C_LONGINT:C283($loop_L; $Index_L; $count_L)
					For ($loop_L; 1; Size of array:C274($targetFlds_atxt))
						$targetFlds_atxt{$loop_L}:=Field name:C257(Table:C252($ArchTable_ptr); $loop_L)
					End for 
					$Index_L:=Find in array:C230($targetFlds_atxt; "ArchiveReason_s")
					$ReasonFld_ptr:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)
					$Index_L:=Find in array:C230($targetFlds_atxt; "ArchiveDate_d")
					$DateFld_ptr:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)
					
					For ($loop_L; 1; Size of array:C274($SourceFlds_aptr))
						$SourceFlds_aptr{$loop_L}:=Field:C253(Table:C252($SourceTable_ptr); $loop_L)
						$SourceFlds_atxt{$loop_L}:=Field name:C257(Table:C252($SourceTable_ptr); $loop_L)
						$Index_L:=Find in array:C230($targetFlds_atxt; $SourceFlds_atxt{$loop_L})
						If ($Index_L>0)
							$ArchFlds_aptr{$loop_L}:=Field:C253(Table:C252($ArchTable_ptr); $Index_L)
						End if 
						
					End for 
					
					//clean up fields
					C_LONGINT:C283($fieldsCount_L; $tbl_L; $fld_L)
					C_TEXT:C284($varName_txt)
					
					For ($loop_L; Size of array:C274($SourceFlds_aptr); 1; -1)
						RESOLVE POINTER:C394($ArchFlds_aptr{$loop_L}; $varName_txt; $tbl_L; $fld_L)
						If ($tbl_L#Table:C252($ArchTable_ptr))
							DELETE FROM ARRAY:C228($SourceFlds_aptr; $loop_L; 1)
							DELETE FROM ARRAY:C228($ArchFlds_aptr; $loop_L; 1)
						End if 
						
					End for 
					
				End if 
				
				ARCHIVE_MatchFields($SourceTable_ptr; $ArchTable_ptr; ->$SourceFlds_aptr; ->$ArchFlds_aptr; ->$ReasonFld_ptr; ->$DateFld_ptr)
				
				ALL RECORDS:C47($SourceTable_ptr->)
				C_TEXT:C284($msg_txt)
				$msg_txt:=String:C10(Records in selection:C76($SourceTable_ptr->))+" records"
				$msg_txt:=$msg_txt+" to table "+Table name:C256($ArchTable_ptr)
				C_OBJECT:C1216($progressObj_o)
				
				If (ARCHIVE_SHOWALERT_b)
					//start the bar
					//C_LONGINT(<>ProgressPID)
					//<>ProgressPID:=StartProgress ("Archiving ["+Table name($SourceTable_ptr)+"]";"NONE";$msg_txt;"Records of "+String(Records in selection($SourceTable_ptr->)))
					//  //initialize the bar
					//UpdateProgress (1;Records in selection($SourceTable_ptr->))
					$progressObj_o:=ProgressNew("Archiving ["+Table name:C256($SourceTable_ptr)+"]"; Records in selection:C76($SourceTable_ptr->); False:C215; ""; 3)
				End if 
				
				FIRST RECORD:C50($SourceTable_ptr->)
				$count_L:=0
				While (Not:C34(End selection:C36($SourceTable_ptr->)))
					CREATE RECORD:C68($ArchTable_ptr->)
					For ($loop_L; 1; Size of array:C274($SourceFlds_aptr))
						$ArchFlds_aptr{$loop_L}->:=$SourceFlds_aptr{$loop_L}->
					End for 
					$ReasonFld_ptr->:=$ArchiveReason_txt
					$DateFld_ptr->:=$ArchiveDate_d
					SAVE RECORD:C53($ArchTable_ptr->)
					$count_L:=$count_L+1
					If (($count_L%20)=0)
						If (ARCHIVE_SHOWALERT_b)
							//UpdateProgress ($count_L;Records in selection($SourceTable_ptr->))
							//update progress
							UpdateProgressNew($progressObj_o; $count_L)
							
						End if 
						
					End if 
					NEXT RECORD:C51($SourceTable_ptr->)
				End while 
				UNLOAD RECORD:C212($ArchTable_ptr->)
				If (ARCHIVE_SHOWALERT_b)
					//CALL PROCESS(<>ProgressPID)
					//quit progress
					Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
				End if 
				
				
			End for 
			
			If (ARCHIVE_SHOWALERT_b)
				ALERT:C41("Finished Archiving!!!")
			End if 
			
	End case 
End if 