//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/19/16, 16:56:06
//----------------------------------------------------
//Method: clone_ProcessBlobs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_08  //r001 ` 
	//Modified by: Charles Miller (8/22/13 14:35:09)
	Mods_2013_09  //r001 `  Changes in cloning to use arrays whenever possible
	//Modified by: Charles Miller (9/10/13 13:15:45)
	// Modified by: Charles Miller (10/10/17 )
	Mods_2017_10
	//  `use local progress bar if param $2 is -10
End if 

ON ERR CALL:C155("4D_Errors")
C_LONGINT:C283($1; $TableNumber_L; $Position_L; $Loop_L; $2; $Progress_L)
$TableNumber_L:=$1
$Progress_L:=$2

C_POINTER:C301($Table_ptr; $Field_ptr)
$Table_ptr:=Table:C252($TableNumber_L)
C_TEXT:C284($TableName_txt)

$TableName_txt:=Table name:C256($TableNumber_L)

$Position_L:=Find in array:C230(clone_TablesWithUniqueKey_atxt; $TableName_txt)
$Field_ptr:=clone_UniqueKeys_aptr{$Position_L}

C_TEXT:C284($SQL_Retrieve_txt)
C_BOOLEAN:C305($IsANumber_b)

C_LONGINT:C283($Offset_l)
$Offset_l:=0
BLOB TO VARIABLE:C533(BlobHoldUpdates_blb; $IsANumber_b; $Offset_l)
BLOB TO VARIABLE:C533(BlobHoldUpdates_blb; $SQL_Retrieve_txt; $Offset_l)
C_LONGINT:C283($Progress_L)
If ($Progress_L=-10)
	$Progress_L:=Progress New
End if 
Progress SET TITLE($Progress_L; "Retrieving Blobs for "+$TableName_txt)

C_REAL:C285($Interval)
$Interval:=500
C_TEXT:C284(BlobPrimaryKey_txt; $VariablePrefix_txt; $VariableName_txt)
C_LONGINT:C283($Type_l; $Length_l; $InnerLoop_L)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
$VariablePrefix_txt:="v_"+String:C10($TableNumber_L)+"_"

C_POINTER:C301($Array_ptr; $Table_ptr; $Field_ptr)
$Position_L:=Find in array:C230(clone_TablesWithUniqueKey_atxt; $TableName_txt)
$Field_ptr:=clone_UniqueKeys_aptr{$Position_L}
$Loop_L:=Field:C253($Field_ptr)
C_LONGINT:C283($Size_L)
$Size_L:=0
GET FIELD PROPERTIES:C258($TableNumber_L; $Loop_L; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
$VariableName_txt:=$VariablePrefix_txt+String:C10($Loop_L; "000")
$IsANumber_b:=True:C214
Case of 
	: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
		$VariableName_txt:=$VariableName_txt+"_atxt"
		$IsANumber_b:=False:C215
	: ($Type_l=Is real:K8:4)
		$VariableName_txt:=$VariableName_txt+"_ar"
	: ($Type_l=Is integer:K8:5)
		$VariableName_txt:=$VariableName_txt+"_aL"
		
	: ($Type_l=Is longint:K8:6)
		$VariableName_txt:=$VariableName_txt+"_aL"
	Else 
End case 
$Array_ptr:=Get pointer:C304($VariableName_txt)
ARRAY POINTER:C280($PointertoVariables_aptr; 0)
ARRAY POINTER:C280($PointertoFields_aptr; 0)
For ($Loop_L; 1; Get last field number:C255($TableNumber_L))
	If (Is field number valid:C1000($TableNumber_L; $Loop_L))
		GET FIELD PROPERTIES:C258($TableNumber_L; $Loop_L; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		If ($Type_l=Is BLOB:K8:12)
			$Size_L:=$Size_L+1
			APPEND TO ARRAY:C911($PointertoVariables_aptr; Get pointer:C304($VariablePrefix_txt+String:C10($Loop_L; "000")+"_blb"))
			APPEND TO ARRAY:C911($PointertoFields_aptr; Field:C253($TableNumber_L; $Loop_L))
		End if 
	End if 
	
End for 
C_LONGINT:C283($LocalCount_L)
C_LONGINT:C283($BlobSize_L)
$BlobSize_L:=BLOB size:C605(BlobHoldUpdates_blb)

Repeat 
	
	BLOB TO VARIABLE:C533(BlobHoldUpdates_blb; $Array_ptr->; $Offset_l)
	C_BOOLEAN:C305($Update_b)
	$Interval:=1/Size of array:C274($Array_ptr->)
	Progress SET PROGRESS($Progress_L; $Interval)
	For ($Loop_L; 1; Size of array:C274($Array_ptr->))
		$Update_b:=False:C215
		$Interval:=$Loop_L/Size of array:C274($Array_ptr->)
		//$LocalCount_L:=$LocalCount_L+1
		//If (($LocalCount_L%$Interval)=0)
		
		//End if 
		If ($IsANumber_b)
			BlobPrimaryKey_L:=$Array_ptr->{$Loop_L}
		Else 
			BlobPrimaryKey_txt:=$Array_ptr->{$Loop_L}
		End if 
		ON ERR CALL:C155("SQL_Error")
		Begin SQL
			EXECUTE IMMEDIATE :$SQL_Retrieve_txt;
		End SQL
		ON ERR CALL:C155("4D_Errors")
		
		QUERY:C277($Table_ptr->; $Field_ptr->=$Array_ptr->{$Loop_L})
		ut_LoadRecordonServer($Table_ptr)
		
		For ($InnerLoop_L; 1; $Size_L)
			If (BLOB size:C605($PointertoVariables_aptr{$InnerLoop_L}->)>0)
				$Update_b:=True:C214
				$PointertoFields_aptr{$InnerLoop_L}->:=$PointertoVariables_aptr{$InnerLoop_L}->
			End if 
		End for 
		If ($Update_b)
			SAVE RECORD:C53($Table_ptr->)
		End if 
		UNLOAD RECORD:C212($Table_ptr->)
		
	End for 
	
Until ($Offset_l>=$BlobSize_L)



//End clone_ProcessBlobs

