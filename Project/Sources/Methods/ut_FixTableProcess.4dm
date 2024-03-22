//%attributes = {"invisible":true}
// ----------------------------------------------------
// uT_FixTableProcess
// User name (OS): cjmiller
// Date and time: 10/30/03, 14:50:28
// ----------------------------------------------------
// Description
// This will fix one table
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03  //04/19/05, 13:38:27
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_LONGINT:C283($1; $iTableLoop)
$iTableLoop:=$1
C_BOOLEAN:C305($2; $DropIndices_b)
$DropIndices_b:=$2
C_POINTER:C301($filePtr; $FieldPtr)
$filePtr:=Table:C252($iTableLoop)
ARRAY POINTER:C280($IndexFieldPtrs_a; 0)
C_LONGINT:C283($Type_l; $Length_l; $OneTable_l; $OneField_l; $ChoiceField_l; $AutoOne_b; $Automany_b)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
READ WRITE:C146($fileptr->)
C_TIME:C306($begtime)
$begtime:=Current time:C178
If ($DropIndices_b=True:C214)
	C_TEXT:C284($FieldName_txt; $TableName_txt)
	$TableName_txt:=Table name:C256($iTableLoop)
	UNLOAD RECORD:C212($fileptr->)
	C_LONGINT:C283($Loop_l)
	For ($Loop_l; 1; Get last field number:C255($filePtr))
		GET FIELD PROPERTIES:C258($iTableLoop; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		If ($Indexed_b=True:C214)
			GET RELATION PROPERTIES:C686($iTableLoop; $Loop_l; $OneTable_l; $OneField_l; $ChoiceField_l; $AutoOne_b; $Automany_b)
			If ($OneTable_l=0)  //no relation line exists and we can drop index
				INSERT IN ARRAY:C227($IndexFieldPtrs_a; 1; 1)
				$IndexFieldPtrs_a{1}:=Field:C253($iTableLoop; $Loop_l)
				$FieldPtr:=$IndexFieldPtrs_a{1}
				SET INDEX:C344($FieldPtr->; False:C215)
			End if 
		End if 
	End for 
End if 

ALL RECORDS:C47($fileptr->)
C_TIME:C306($StartTime; $RemainingTime)
C_LONGINT:C283($iNoRecords; $iFieldLoop; $iRecordLoop; $win)
$StartTime:=Current time:C178(*)
$iNoRecords:=Records in selection:C76($fileptr->)
$win:=Open window:C153(50; 50; 500; 250; Plain window:K34:13; "Resetting fields for table number "+String:C10($iTableLoop))
For ($iRecordLoop; 1; $iNoRecords)
	GOTO SELECTED RECORD:C245($fileptr->; $iRecordLoop)
	
	If ((Mod:C98($iRecordLoop; 1000)=0))
		GOTO XY:C161(5; 5)
		$RemainingTime:=(($iNoRecords/$iRecordLoop)-1)*(Current time:C178(*)-$StartTime)
		MESSAGE:C88("Estimated time remaining for table "+Table name:C256($iTableLoop)+" is "+Time string:C180($RemainingTime))
	End if 
	
	For ($iFieldLoop; 1; Get last field number:C255($filePtr))
		$FieldPtr:=Field:C253($iTableLoop; $iFieldLoop)
		$FieldPtr->:=$FieldPtr->
	End for 
	SAVE RECORD:C53($fileptr->)
	
End for 
UNLOAD RECORD:C212($fileptr->)
If ($Indexed_b=True:C214)
	For ($Loop_l; 1; Size of array:C274($IndexFieldPtrs_a))
		$FieldPtr:=$IndexFieldPtrs_a{$Loop_l}
		
		SET INDEX:C344($FieldPtr->; True:C214)
	End for 
End if 
READ ONLY:C145($fileptr->)
//FLUSH CACHE
CLOSE WINDOW:C154
//$endtime:=Current time
//ALERT("Elapsed is "+String($endtime-$begtime))
//End ut_FixTableProcess