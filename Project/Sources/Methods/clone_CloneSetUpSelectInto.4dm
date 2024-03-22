//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 07/22/13, 15:10:52
//----------------------------------------------------
//Method: clone_CloneSetUpSelectInto
//Description
//

// Parameters
// ----------------------------------------------------
If (False:C215)
	// Modified by: Charles Miller (10/10/17 )
	Mods_2017_10
	//  `handle case of UUID fields
	Mods_2018_06  //Modified by: Charles Miller (06/19/18 )
	//Uncomment out 
	//Line 71 81 122
End if 

C_LONGINT:C283($1; $TableNumber_l; $ACTLastFieldNumber_l; $Loop_l; $FieldType_l; $Length_l)
$TableNumber_l:=$1
C_TEXT:C284($TableName_txt)
$TableName_txt:=Table name:C256($TableNumber_l)
C_POINTER:C301($2; $3)
C_BOOLEAN:C305($ReturnArrays_b)

C_BOOLEAN:C305($4; $UseArrays_b)
$UseArrays_b:=$4

SQL_Limit_L:=1
$ACTLastFieldNumber_l:=Get last field number:C255(Table:C252($TableNumber_l))
If ($UseArrays_b)
	C_BOOLEAN:C305($IsTableName_b)
	C_LONGINT:C283($Loc_L)
	$Loc_L:=Find in array:C230(SQL_LimitNames_atxt; $TableName_txt)
	SQL_Limit_L:=0
	If ($Loc_L<1)
		$Loc_L:=1
		$ACTLastFieldNumber_l:=Get last field number:C255($TableNumber_l)
		Repeat 
			
			$IsTableName_b:=True:C214
			If (String:C10(Num:C11(SQL_LimitNames_atxt{$Loc_L}))=SQL_LimitNames_atxt{$Loc_L})
				$IsTableName_b:=False:C215
			End if 
			
			Case of 
				: ($IsTableName_b)
					
				: ($ACTLastFieldNumber_l>Num:C11(SQL_LimitNames_atxt{$Loc_L}))
					SQL_Limit_L:=SQL_Limits_AL{$Loc_L}
				Else 
					
					
			End case 
			$Loc_L:=$Loc_L+1
			
		Until (SQL_Limit_L>0) | ($Loc_L>Size of array:C274(SQL_Limits_AL))
		
	Else 
		SQL_Limit_L:=SQL_Limits_AL{$Loc_L}
	End if 
	
	
	If (SQL_Limit_L=0)
		SQL_Limit_L:=1
	End if 
	
End if 
C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; $BindToVariable_txt; $FieldName_txt)
$TableName_txt:="["+Table name:C256($TableNumber_l)+"]."
C_LONGINT:C283($FindInMissingArray_L)
ARRAY TEXT:C222(clone_MissingArrayNames_atxt; 0)
CLEAR VARIABLE:C89(Clone_FirstArray_ptr)
C_BOOLEAN:C305($setPointer_B)
$setPointer_B:=True:C214
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Included_b)
C_TEXT:C284($TableNameFieldCombo_txt)
For ($Loop_l; 1; $ACTLastFieldNumber_l)
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $FieldType_l; $Length_l; $Indexed_b; $Unique_b)
		$TableNameFieldCombo_txt:=Table name:C256($TableNumber_l)+"--"+Field name:C257($TableNumber_l; $Loop_l)
		$FindInMissingArray_L:=Find in array:C230(clone_MissRemoteTableFld_atxt; $TableNameFieldCombo_txt)
		Case of 
				
			: (($FieldType_l=Is alpha field:K8:1) & ($Length_l=0) & Not:C34(clone_IncludeUUIDS_B))
				//: ($FieldType_l=Is BLOB)
			: ($FieldType_l=7)
			Else 
				clone_SQLReturnFromFileForSQL($TableNumber_l; $Loop_l; ->$FieldName_txt; ->$BindToVariable_txt)
				If ($UseArrays_b)
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_txt"; "_atxt")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_L"; "_aL")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_i"; "_ai")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_r"; "_ar")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_tm"; "_atm")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_d"; "_ad")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_b"; "_ab")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_p"; "_ap")
					$BindToVariable_txt:=Replace string:C233($BindToVariable_txt; "_blb"; "_ablb")
					
					
				End if 
				If ($FieldName_txt#"") & ($FindInMissingArray_L<1)
					If ($setPointer_B)
						Clone_FirstArray_ptr:=Get pointer:C304($BindToVariable_txt)
						$setPointer_B:=False:C215
					End if 
					//If ($FieldType_l=Is time)// for when time must be returned as a long
					//$FieldName_txt:=" CAST ("+$FieldName_txt+" AS INT)"
					//End if 
					If ($SelectFields_txt="")
						$SelectFields_txt:=$FieldName_txt
						$UpdateFields_txt:=":"+$BindToVariable_txt
						
					Else 
						$SelectFields_txt:=$SelectFields_txt+", "+Char:C90(Carriage return:K15:38)+$FieldName_txt
						$UpdateFields_txt:=$UpdateFields_txt+", "+Char:C90(Carriage return:K15:38)+":"+$BindToVariable_txt
					End if 
				Else 
					
					
					APPEND TO ARRAY:C911(clone_MissingArrayNames_atxt; $BindToVariable_txt)
					
				End if 
				
		End case 
		
	End if 
	
	
End for 

$2->:=$SelectFields_txt
$3->:=$UpdateFields_txt
//End clone_CloneSetUpSelectInto