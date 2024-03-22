//%attributes = {"invisible":true}
// Method: ARCHIVE_MakeCopy
// Description
// copy all records from a source table to and Archive table

// Parameters
// $0 : $Result_b 
// $1 : $sourceTbl_ptr
// $2 : $TargetTbl_ptr
// $3 : $Reason_s `Reason for Archive
// $4 : $ArchDate_d `Date of archive
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/11/10, 16:52:23
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_BOOLEAN:C305($0; $Result_b)
C_POINTER:C301($1; $sourceTbl_ptr)
C_POINTER:C301($2; $TargetTbl_ptr)
C_TEXT:C284($3; $Reason_s)  // Command Replaced was o_C_STRING length was 80
C_DATE:C307($4; $ArchDate_d)
$sourceTbl_ptr:=$1
$TargetTbl_ptr:=$2
$Reason_s:=$3
$ArchDate_d:=$4

$Result_b:=False:C215

//$sourceTbl_ptr:=->[Bridge MHD NBIS]
//$TargetTbl_ptr:=->[BridgeMHDNBISArchive]
//match fieldsof source and target by name-and verify type is same
C_POINTER:C301($ReasonFld_ptr; $DateFld_ptr; $SourceFld_ptr; $TargetFld_ptr)
C_LONGINT:C283($SourceFlds_L; $TargetFields_L; $Loop_L; $SourceTable_L; $TargetTable_L)
$SourceFlds_L:=Get last field number:C255($sourceTbl_ptr)
$TargetFields_L:=Get last field number:C255($TargetTbl_ptr)
$SourceTable_L:=Table:C252($sourceTbl_ptr)
$TargetTable_L:=Table:C252($TargetTbl_ptr)
ARRAY TEXT:C222($TargetFieldNames_as; $TargetFields_L)  //Command Replaced was o_ARRAY string length was 32
ARRAY LONGINT:C221($TargetFieldTypes_aL; $TargetFields_L)

C_TEXT:C284($FldName_s)  // Command Replaced was o_C_STRING length was 32
C_LONGINT:C283($FldType_L; $fldLen_L; $FldNameMatch_L)

For ($Loop_L; 1; $TargetFields_L)
	$FldName_s:=Field name:C257($TargetTable_L; $Loop_L)
	GET FIELD PROPERTIES:C258($TargetTable_L; $Loop_L; $FldType_L; $fldLen_L)
	$TargetFieldNames_as{$Loop_L}:=$FldName_s
	$TargetFieldTypes_aL{$Loop_L}:=$FldType_L
	Case of 
		: ($FldName_s="@ArchiveReason_s")
			$ReasonFld_ptr:=Field:C253($TargetTable_L; $Loop_L)
		: ($FldName_s="@ArchiveDate_d")
			$DateFld_ptr:=Field:C253($TargetTable_L; $Loop_L)
	End case 
	
End for 

ARRAY LONGINT:C221($TargetFieldNos_aL; Get last field number:C255($sourceTbl_ptr))
C_BOOLEAN:C305($MatchedOK_b)
$MatchedOK_b:=True:C214
For ($Loop_L; 1; $SourceFlds_L)
	$FldName_s:=Field name:C257($SourceTable_L; $Loop_L)
	GET FIELD PROPERTIES:C258($SourceTable_L; $Loop_L; $FldType_L; $fldLen_L)
	$TargetFieldNos_aL{$Loop_L}:=0
	If ($FldType_L#Is subtable:K8:11)
		$FldNameMatch_L:=Find in array:C230($TargetFieldNames_as; $FldName_s)
		If ($FldNameMatch_L>0)
			//verify matching type
			If ($FldType_L=$TargetFieldTypes_aL{$FldNameMatch_L})
				$TargetFieldNos_aL{$Loop_L}:=$FldNameMatch_L
			Else 
				ALERT:C41("Non-matching Field types for source field "+$FldName_s+" Source type="+String:C10($FldType_L)+" Archivetype="+String:C10($TargetFieldTypes_aL{$FldNameMatch_L}))
				$MatchedOK_b:=False:C215
			End if 
		Else 
			ALERT:C41("Source field "+$FldName_s+" Source type="+String:C10($FldType_L)+" Not Found in the Archive table!")
			$MatchedOK_b:=False:C215
		End if 
		
	End if 
	
End for 
If ($MatchedOK_b)
	READ ONLY:C145($sourceTbl_ptr->)
	ALL RECORDS:C47($sourceTbl_ptr->)
	FIRST RECORD:C50($sourceTbl_ptr->)
	While (Not:C34(End selection:C36($sourceTbl_ptr->)))
		CREATE RECORD:C68($TargetTbl_ptr->)
		$ReasonFld_ptr->:=$Reason_s
		$DateFld_ptr->:=$ArchDate_d
		For ($Loop_L; 1; $SourceFlds_L)
			If ($TargetFieldNos_aL{$Loop_L}>0)
				$SourceFld_ptr:=Field:C253($SourceTable_L; $Loop_L)
				$TargetFld_ptr:=Field:C253($TargetTable_L; $TargetFieldNos_aL{$Loop_L})
				$TargetFld_ptr->:=$SourceFld_ptr->
			End if 
			
		End for 
		SAVE RECORD:C53($TargetTbl_ptr->)
		NEXT RECORD:C51($sourceTbl_ptr->)
	End while 
	$Result_b:=True:C214
End if 

$0:=$Result_b