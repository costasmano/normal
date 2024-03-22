//%attributes = {"invisible":true}
//Method: LSS_CloneSetUpSelectInto($TableNumber_l;->$SelectFields_txt;->$UpdateFields_txt;boolean to sue arrays or not)
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/02/17, 14:36:48
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11_bug
	//Same as clone_CloneSetUpSelectInto except we skip UUID fields
	//Added code to use new progress and to handle uuid fields
	//Modified by: Chuck Miller (11/2/17 15:07:33)
End if 
Compiler_clone


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

C_BOOLEAN:C305($Indexed_b; $Unique_b; $Included_b)

For ($Loop_l; 1; $ACTLastFieldNumber_l)
	If (Is field number valid:C1000($TableNumber_l; $Loop_l))
		
		GET FIELD PROPERTIES:C258($TableNumber_l; $Loop_l; $FieldType_l; $Length_l; $Indexed_b; $Unique_b)
		
		Case of 
				//: ($FieldType_l=Is BLOB)
			: ($FieldType_l=7)
			: ($FieldType_l=Is alpha field:K8:1) & ($Length_l=0)
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
				If ($FieldName_txt#"")
					
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
				End if 
		End case 
		
	End if 
	
	
End for 

$2->:=$SelectFields_txt
$3->:=$UpdateFields_txt


//End LSS_CloneSetUpSelectInto
