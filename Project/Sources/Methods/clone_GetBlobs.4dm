//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 07/25/16, 14:58:52
//----------------------------------------------------
//Method: clone_GetBlobs
//Description
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	Mods_2013_08  //r001 ` 
	//Modified by: Charles Miller (8/22/13 12:08:23)
	Mods_2013_09  //r001 `  Changes in cloning to use arrays whenever possible
	//Modified by: Charles Miller (9/10/13 13:15:00)
	
End if 

C_LONGINT:C283($1; $TableNumber_L; $UniqueFieldNumber_L; $UniqueFieldNumber_L; $Position_L; $Loop_L; $InnerLoop_L)
$TableNumber_L:=$1

ON ERR CALL:C155("4D_Errors")
C_TEXT:C284($TableName_txt)
$TableName_txt:=Table name:C256($TableNumber_L)

C_BOOLEAN:C305($IsANumber_b)
C_TEXT:C284(BlobPrimaryKey_txt; $VariablePrefix_txt; $VariableName_txt)
C_LONGINT:C283($Type_l; $Length_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
$VariablePrefix_txt:="v_"+String:C10($TableNumber_L)+"_"

C_POINTER:C301($Array_ptr; $Table_ptr; $Field_ptr)
$Position_L:=Find in array:C230(clone_TablesWithUniqueKey_atxt; $TableName_txt)
$Field_ptr:=clone_UniqueKeys_aptr{$Position_L}
$Loop_L:=Field:C253($Field_ptr)

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
		$VariableName_txt:=$VariableName_txt+"_ai"
		
	: ($Type_l=Is longint:K8:6)
		$VariableName_txt:=$VariableName_txt+"_aL"
	Else 
End case 
$Array_ptr:=Get pointer:C304($VariableName_txt)

If (BLOB size:C605(BlobHoldUpdates_blb)=0)
	C_TEXT:C284($SQL_Retrieve_txt)
	$Table_ptr:=Table:C252($TableNumber_L)
	
	
	ARRAY POINTER:C280($PointertoVariables_aptr; 0)
	ARRAY POINTER:C280($PointertoFields_aptr; 0)
	C_BOOLEAN:C305($First_b)
	$First_b:=True:C214
	C_TEXT:C284($SelectVariables_txt; $SelectFields_txt; $Where_txt)
	
	If ($IsANumber_b)
		$Where_txt:="WHERE ["+$TableName_txt+"].["+Field name:C257($Field_ptr)+"] = :BlobPrimaryKey_L "+Char:C90(Carriage return:K15:38)
		
	Else 
		$Where_txt:="WHERE ["+$TableName_txt+"].["+Field name:C257($Field_ptr)+"] = :BlobPrimaryKey_txt "+Char:C90(Carriage return:K15:38)
	End if 
	For ($Loop_L; 1; Get last field number:C255($TableNumber_L))
		If (Is field number valid:C1000($TableNumber_L; $Loop_L))
			GET FIELD PROPERTIES:C258($TableNumber_L; $Loop_L; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
			If ($Type_l=Is BLOB:K8:12)
				If ($First_b)
					$SelectFields_txt:="["+Field name:C257($TableNumber_L; $Loop_L)+"]"
					$SelectVariables_txt:=":"+$VariablePrefix_txt+String:C10($Loop_L; "000")+"_blb"
					$First_b:=False:C215
				Else 
					$SelectFields_txt:=$SelectFields_txt+", ["+Field name:C257($TableNumber_L; $Loop_L)+"]"
					$SelectVariables_txt:=$SelectVariables_txt+", :"+$VariablePrefix_txt+String:C10($Loop_L; "000")+"_blb"
				End if 
				APPEND TO ARRAY:C911($PointertoVariables_aptr; Get pointer:C304($VariablePrefix_txt+String:C10($Loop_L; "000")+"_blb"))
				APPEND TO ARRAY:C911($PointertoFields_aptr; Field:C253($TableNumber_L; $Loop_L))
			End if 
		End if 
		
	End for 
	
	$SQL_Retrieve_txt:="SELECT "+$SelectFields_txt+" from ["+$TableName_txt+"] "+Char:C90(Carriage return:K15:38)
	
	$SQL_Retrieve_txt:=$SQL_Retrieve_txt+$Where_txt
	$SQL_Retrieve_txt:=$SQL_Retrieve_txt+"INTO "+$SelectVariables_txt
	
	VARIABLE TO BLOB:C532($IsANumber_b; BlobHoldUpdates_blb; *)
	VARIABLE TO BLOB:C532($SQL_Retrieve_txt; BlobHoldUpdates_blb; *)
End if 
VARIABLE TO BLOB:C532($Array_ptr->; BlobHoldUpdates_blb; *)



//End clone_GetBlobs

