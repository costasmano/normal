//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/24/14, 16:28:54
//----------------------------------------------------
//Method: clone_NewCreateSQLVariables
//Description
//This method is controlling method that creates and import
//Methods needed during processing. Compiler_clone
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	
End if 
C_TEXT:C284($TableName_txt; $VariablePrefix_txt; $VariableName_txt; $ArrayToSelect_txt; $UniqueSelectionDoc_txt; $UniqueClearDocument_txt; $UniqueCompilerDocument_txt; $UUID_txt; $BlobSelection_txt)
C_TEXT:C284($FinalName_txt; $ArraytoSelectionsDoc_txt; $CaseArrayLine_txt)
C_LONGINT:C283($FieldNumber_l; $NoUniquePairs_L; $NoPairs_L)
C_BOOLEAN:C305($CreateArrays_b)

C_LONGINT:C283($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l)
C_TEXT:C284($CompilerDocument_txt; $ClearDocument_txt)
C_BOOLEAN:C305($CaseMade_b; $Indexed_b; $Unique_b; $Invisible_b)
C_BOOLEAN:C305($FIRST_b)
$FIRST_b:=True:C214
ARRAY TEXT:C222($CompilerOuput_atxt; 0)
ARRAY TEXT:C222($ClearOuput_atxt; 0)
ARRAY TEXT:C222($ArrayToSelectOuput_atxt; 0)
C_TEXT:C284($QuoteMark_s)  // Command Replaced was o_C_STRING length was 2
$QuoteMark_s:=Char:C90(34)
$CompilerDocument_txt:=""
$ClearDocument_txt:=""
C_TEXT:C284($UniqueSelection_txt)
C_BOOLEAN:C305($IsPrimaryUUIDKey_B)


C_LONGINT:C283($Primary_key_field_id_L)
C_TEXT:C284($FirstArray_txt; $ConstraintID_txt)
For ($TableLoop_l; 1; Get last table number:C254)
	
	$ArrayToSelect_txt:="array to selection("
	$UniqueSelection_txt:="array to selection("
	If (Is table number valid:C999($TableLoop_l))
		Begin SQL
			
			SELECT CONSTRAINT_ID
			FROM _USER_CONSTRAINTS
			WHERE TABLE_ID = :$TableLoop_l AND CONSTRAINT_TYPE = 'P'
			INTO :$ConstraintID_txt;
			
			SELECT COLUMN_ID
			FROM _USER_CONS_COLUMNS
			WHERE CONSTRAINT_ID = :$ConstraintID_txt
			INTO :$Primary_key_field_id_L;
		End SQL
		$IsPrimaryUUIDKey_B:=False:C215
		$TableName_txt:=Table name:C256($TableLoop_l)
		
		ARRAY TEXT:C222($BooleanVariables_atxt; 0)
		ARRAY TEXT:C222($LongVariables_atxt; 0)
		ARRAY TEXT:C222($RealVariables_atxt; 0)
		ARRAY TEXT:C222($DateVariables_atxt; 0)
		ARRAY TEXT:C222($TextVariables_atxt; 0)
		ARRAY TEXT:C222($TimeVariables_atxt; 0)
		ARRAY TEXT:C222($BlobVariables_atxt; 0)
		ARRAY TEXT:C222($PictureVariables_atxt; 0)
		ARRAY TEXT:C222($IntegerVariables_atxt; 0)
		ARRAY TEXT:C222($Unique_atxt; 0)
		
		C_TEXT:C284($FirstArray_txt)
		
		$VariablePrefix_txt:="v_"+String:C10($TableLoop_l)+"_"
		$NoUniquePairs_L:=0
		$NoPairs_L:=0
		
		For ($FieldLoop_l; 1; Get last field number:C255($TableLoop_l))
			
			If (Is field number valid:C1000($TableLoop_l; $FieldLoop_l))  //Fill array for variables to match up with fields
				If ($FieldLoop_l=$Primary_key_field_id_L)
					$IsPrimaryUUIDKey_B:=True:C214
				End if 
				$VariableName_txt:=$VariablePrefix_txt+String:C10($FieldLoop_l; "000")
				GET FIELD PROPERTIES:C258($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
				If ($Unique_b)
					APPEND TO ARRAY:C911($Unique_atxt; $VariableName_txt)
				End if 
				Case of 
					: ($FieldLoop_l=$Primary_key_field_id_L)
						$FinalName_txt:=$VariableName_txt+"_txt"
						$UniqueClearDocument_txt:="CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+Char:C90(Carriage return:K15:38)
						
						$UniqueCompilerDocument_txt:="C_TEXT("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+Char:C90(Carriage return:K15:38)
						
						$FinalName_txt:=Replace string:C233($FinalName_txt; "_txt"; "_atxt")
						$UniqueClearDocument_txt:=$UniqueClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+Char:C90(Carriage return:K15:38)
						$UniqueCompilerDocument_txt:=$UniqueCompilerDocument_txt+"array text("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+Char:C90(Carriage return:K15:38)
						
						$UUID_txt:="if (clone_IncludeUUIDS_B)"+Char:C90(Carriage return:K15:38)+"array to selection("+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+";*)//"+Field name:C257($TableLoop_l; $Primary_key_field_id_L)+Char:C90(Carriage return:K15:38)+"end if"+Char:C90(Carriage return:K15:38)
						$IsPrimaryUUIDKey_B:=False:C215
						
					: ($Type_l=Is alpha field:K8:1) | ($Type_l=Is text:K8:3)
						
						APPEND TO ARRAY:C911($TextVariables_atxt; $VariableName_txt)
						
					: ($Type_l=Is real:K8:4)
						APPEND TO ARRAY:C911($RealVariables_atxt; $VariableName_txt)
					: ($Type_l=Is integer:K8:5)
						// APPEND TO ARRAY($LongVariables_atxt;$VariableName_txt)
						APPEND TO ARRAY:C911($IntegerVariables_atxt; $VariableName_txt)
					: ($Type_l=Is longint:K8:6)
						APPEND TO ARRAY:C911($LongVariables_atxt; $VariableName_txt)
					: ($Type_l=Is date:K8:7)
						APPEND TO ARRAY:C911($DateVariables_atxt; $VariableName_txt)
					: ($Type_l=Is time:K8:8)
						APPEND TO ARRAY:C911($TimeVariables_atxt; $VariableName_txt)
					: ($Type_l=Is boolean:K8:9)
						APPEND TO ARRAY:C911($BooleanVariables_atxt; $VariableName_txt)
					: ($Type_l=Is picture:K8:10)
						APPEND TO ARRAY:C911($PictureVariables_atxt; $VariableName_txt)
					: ($Type_l=Is BLOB:K8:12)
						APPEND TO ARRAY:C911($BlobVariables_atxt; $VariableName_txt)
					Else 
						
				End case 
				
			End if 
		End for 
		If ($FIRST_b)
			clone_SQL_FillMethodHeader(->$CompilerDocument_txt; ->$ArraytoSelectionsDoc_txt; ->$ClearDocument_txt; ->$CaseArrayLine_txt; $TableLoop_l)
			$FIRST_b:=False:C215
		Else 
			$CompilerDocument_txt:=$CompilerDocument_txt+": ($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)
			$ClearDocument_txt:=$ClearDocument_txt+":($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)
			$CaseArrayLine_txt:=":($1="+String:C10($TableLoop_l)+")//"+$TableName_txt+Char:C90(Carriage return:K15:38)
			
			
			
		End if 
		
		APPEND TO ARRAY:C911($ArrayToSelectOuput_atxt; $ArraytoSelectionsDoc_txt)
		$ArraytoSelectionsDoc_txt:=""
		$BlobSelection_txt:=""
		$CreateArrays_b:=True:C214
		If (Size of array:C274($BlobVariables_atxt)>0)
			
			$ArrayToSelect_txt:="If (clone_UseBlobArrays_B)"+Char:C90(Carriage return:K15:38)+$ArrayToSelect_txt
			For ($FieldLoop_l; 1; Size of array:C274($BlobVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$BlobVariables_atxt{$FieldLoop_l}+"_blb"
				$FieldNumber_l:=Num:C11(Replace string:C233($BlobVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_BLOB("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_blb"; "_ablb")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array BLOB("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $BlobVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$BlobSelection_txt:=$BlobSelection_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					
				End if 
				
				
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$BlobSelection_txt:=$BlobSelection_txt+$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)+"else "+Char:C90(Carriage return:K15:38)+"clone_GetBlobs($1)"+Char:C90(Carriage return:K15:38)+"end if"+Char:C90(Carriage return:K15:38)
			Else 
				$BlobSelection_txt:=$BlobSelection_txt+Char:C90(Carriage return:K15:38)+"else "+Char:C90(Carriage return:K15:38)+"clone_GetBlobs($1)"+Char:C90(Carriage return:K15:38)+"end if"+Char:C90(Carriage return:K15:38)
			End if 
		End if 
		$ArrayToSelect_txt:="array to selection("
		
		
		
		
		If (Size of array:C274($TextVariables_atxt)>0)
			
			For ($FieldLoop_l; 1; Size of array:C274($TextVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				If ($UniqueCompilerDocument_txt#"")
					$CompilerDocument_txt:=$CompilerDocument_txt+$UniqueCompilerDocument_txt
					$ClearDocument_txt:=$ClearDocument_txt+$UniqueClearDocument_txt
					$UniqueCompilerDocument_txt:=""
					$UniqueClearDocument_txt:=""
				End if 
				$FinalName_txt:=$TextVariables_atxt{$FieldLoop_l}+"_txt"
				$FieldNumber_l:=Num:C11(Replace string:C233($TextVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_TEXT("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_txt"; "_atxt")
					
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array text("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					
					If (Find in array:C230($Unique_atxt; $TextVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		Else 
			If ($UniqueCompilerDocument_txt#"")
				$CompilerDocument_txt:=$CompilerDocument_txt+$UniqueCompilerDocument_txt
				$ClearDocument_txt:=$ClearDocument_txt+$UniqueClearDocument_txt
				$UniqueCompilerDocument_txt:=""
				$UniqueClearDocument_txt:=""
			End if 
		End if 
		
		If (Size of array:C274($RealVariables_atxt)>0)
			
			For ($FieldLoop_l; 1; Size of array:C274($RealVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$RealVariables_atxt{$FieldLoop_l}+"_r"
				$FieldNumber_l:=Num:C11(Replace string:C233($RealVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_real("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_r"; "_ar")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array real("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $RealVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
				
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		If (Size of array:C274($IntegerVariables_atxt)>0)
			
			For ($FieldLoop_l; 1; Size of array:C274($IntegerVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$IntegerVariables_atxt{$FieldLoop_l}+"_L"
				$FieldNumber_l:=Num:C11(Replace string:C233($IntegerVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_Longint("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_L"; "_ai")
					
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array integer("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $IntegerVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		If (Size of array:C274($LongVariables_atxt)>0)
			For ($FieldLoop_l; 1; Size of array:C274($LongVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$LongVariables_atxt{$FieldLoop_l}+"_L"
				$FieldNumber_l:=Num:C11(Replace string:C233($LongVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_longint("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_L"; "_aL")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array longint("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $LongVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		If (Size of array:C274($DateVariables_atxt)>0)
			
			For ($FieldLoop_l; 1; Size of array:C274($DateVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$DateVariables_atxt{$FieldLoop_l}+"_d"
				$FieldNumber_l:=Num:C11(Replace string:C233($DateVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_date("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_d"; "_ad")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array date("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $DateVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
				End if 
				If ($NoPairs_L=3)
					$NoPairs_L:=0
					$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
					$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
					$ArrayToSelect_txt:="array to selection("
				End if 
				If ($FirstArray_txt="")
					$FirstArray_txt:=$FinalName_txt
				End if 
				
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		If (Size of array:C274($TimeVariables_atxt)>0)
			For ($FieldLoop_l; 1; Size of array:C274($TimeVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$TimeVariables_atxt{$FieldLoop_l}+"_tm"
				$FieldNumber_l:=Num:C11(Replace string:C233($TimeVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_time("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_tm"; "_atm")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array time("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $TimeVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		
		If (Size of array:C274($BooleanVariables_atxt)>0)
			For ($FieldLoop_l; 1; Size of array:C274($BooleanVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$BooleanVariables_atxt{$FieldLoop_l}+"_b"
				$FieldNumber_l:=Num:C11(Replace string:C233($BooleanVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_boolean("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_b"; "_ab")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array boolean("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $BooleanVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		
		If (Size of array:C274($PictureVariables_atxt)>0)
			For ($FieldLoop_l; 1; Size of array:C274($PictureVariables_atxt))
				If (Length:C16($CompilerDocument_txt)>20000)
					APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
					$CompilerDocument_txt:=""
				End if 
				If (Length:C16($ClearDocument_txt)>20000)
					APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
					$ClearDocument_txt:=""
				End if 
				$FinalName_txt:=$PictureVariables_atxt{$FieldLoop_l}+"_p"
				$FieldNumber_l:=Num:C11(Replace string:C233($PictureVariables_atxt{$FieldLoop_l}; $VariablePrefix_txt; ""))
				$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				$CompilerDocument_txt:=$CompilerDocument_txt+"C_PICTURE("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
				If ($CreateArrays_b)
					$FinalName_txt:=Replace string:C233($FinalName_txt; "_p"; "_ap")
					$ClearDocument_txt:=$ClearDocument_txt+"CLEAR VARIABLE ("+$FinalName_txt+")//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					$CompilerDocument_txt:=$CompilerDocument_txt+"array PICTURE("+$FinalName_txt+";0)//"+Field name:C257($TableLoop_l; $FieldNumber_l)+Char:C90(Carriage return:K15:38)
					If (Find in array:C230($Unique_atxt; $PictureVariables_atxt{$FieldLoop_l})>0)
						$NoUniquePairs_L:=$NoUniquePairs_L+1
						$UniqueSelection_txt:=$UniqueSelection_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
						
						If ($NoUniquePairs_L=3)
							$NoUniquePairs_L:=0
							$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+"*)"+Char:C90(Carriage return:K15:38)
							$UniqueSelection_txt:="array to selection("
						End if 
					Else 
						$NoPairs_L:=$NoPairs_L+1
						$ArrayToSelect_txt:=$ArrayToSelect_txt+$FinalName_txt+";["+$TableName_txt+"]"+Field name:C257($TableLoop_l; $FieldNumber_l)+";"
					End if 
					If ($NoPairs_L=3)
						$NoPairs_L:=0
						$ArrayToSelect_txt:=$ArrayToSelect_txt+"*)"+Char:C90(Carriage return:K15:38)
						$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
						$ArrayToSelect_txt:="array to selection("
					End if 
					If ($FirstArray_txt="")
						$FirstArray_txt:=$FinalName_txt
					End if 
				End if 
			End for 
			If ($ArrayToSelect_txt#"") & ($ArrayToSelect_txt#"array to selection(")
				$NoPairs_L:=0
				$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
				$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ";*)")
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+$ArrayToSelect_txt
				$ArrayToSelect_txt:="array to selection("
			End if 
		End if 
		
		
		
		
		
		
		C_TEXT:C284($ArrayStuff_txt)
		
		C_BOOLEAN:C305($ArraytoSelectionSet_b)
		$ArraytoSelectionSet_b:=False:C215
		If ($UniqueSelection_txt="array to selection(")
			$UniqueSelection_txt:=""
		End if 
		If ($UniqueSelection_txt#"")
			
			$UniqueSelection_txt:=$UniqueSelection_txt+")"+Char:C90(Carriage return:K15:38)
			$UniqueSelection_txt:=Replace string:C233($UniqueSelection_txt; ";)"; ";*)")
			If ($BlobSelection_txt#"")
				If (Position:C15("*"; $BlobSelection_txt)>0)
				Else 
					$BlobSelection_txt:=Replace string:C233($BlobSelection_txt; ")"; ";*)")
				End if 
				$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$BlobSelection_txt+$UniqueSelection_txt+Char:C90(Carriage return:K15:38)
			Else 
				$UniqueSelectionDoc_txt:=$UniqueSelectionDoc_txt+$UniqueSelection_txt+Char:C90(Carriage return:K15:38)
			End if 
			
			
			//$UniqueSelection_txt:=substring($UniqueSelection_txt;1;length($UniqueSelection_txt)-1)
			//$UniqueSelection_txt:="Array to selection("+$UniqueSelection_txt+"*)"+Char(Carriage return)  //Unique keys must come first"+Char(Carriage return)
			$ArraytoSelectionSet_b:=True:C214
		End if 
		If ($ArrayToSelect_txt="array to selection(")
			$ArrayToSelect_txt:=""
		End if 
		If ($ArrayToSelect_txt#"")
			Case of 
				: (Position:C15(";*)"; $ArrayToSelect_txt)>0)
					$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";*)"; ")")
					
				: (Position:C15(";)"; $ArrayToSelect_txt)>0)
					$ArrayToSelect_txt:=Replace string:C233($ArrayToSelect_txt; ";)"; ")")
				: (Position:C15(")"; $ArrayToSelect_txt)>0)
					
				Else 
					$ArrayToSelect_txt:=$ArrayToSelect_txt+")"+Char:C90(Carriage return:K15:38)
			End case 
		End if 
		
		$ArrayStuff_txt:="$Array_Ptr:=->"+$FirstArray_txt+Char:C90(Carriage return:K15:38)+"If (Size of array($Array_Ptr->)>0)"+Char:C90(Carriage return:K15:38)
		$Length_L:=Length:C16($ArraytoSelectionsDoc_txt)
		
		$ArraytoSelectionsDoc_txt:=Substring:C12($ArraytoSelectionsDoc_txt; 1; $Length_L-3)+")"
		If ($ArraytoSelectionsDoc_txt=")")
			$ArraytoSelectionsDoc_txt:=""
			C_LONGINT:C283($ReplacePos_L; $StartPos_L)
			$StartPos_L:=0
			
			Repeat 
				$StartPos_L:=Position:C15("*"; $UniqueSelectionDoc_txt; $StartPos_L+1)
				If ($StartPos_L>0)
					
					$ReplacePos_L:=$StartPos_L
				End if 
				
			Until ($StartPos_L<1)
			If ($ReplacePos_L>0)
				
				$ArraytoSelectionsDoc_txt:=Substring:C12($UniqueSelectionDoc_txt; 1; $ReplacePos_L-2)
				$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+Substring:C12($UniqueSelectionDoc_txt; $ReplacePos_L+1)
				
				$UniqueSelectionDoc_txt:=$ArraytoSelectionsDoc_txt
				$ArraytoSelectionsDoc_txt:=""
			Else 
				$UniqueSelectionDoc_txt:=Replace string:C233($UniqueSelectionDoc_txt; ";*)"; ")")
			End if 
			
		End if 
		$ArraytoSelectionsDoc_txt:=$CaseArrayLine_txt+$ArrayStuff_txt+$UUID_txt+$UniqueSelectionDoc_txt+$ArrayToSelect_txt+$ArraytoSelectionsDoc_txt+Char:C90(Carriage return:K15:38)+"end if"+Char:C90(Carriage return:K15:38)
		
		$ArraytoSelectionsDoc_txt:=Replace string:C233($ArraytoSelectionsDoc_txt; ";)"; ")")
		$FirstArray_txt:=""
		$UniqueSelection_txt:=""
		APPEND TO ARRAY:C911($ArrayToSelectOuput_atxt; $ArraytoSelectionsDoc_txt)
		$ArraytoSelectionsDoc_txt:=""
		$ArrayToSelect_txt:="array to selection("
		$UniqueSelectionDoc_txt:=""
		$UniqueSelection_txt:="array to selection("
		
		APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
		$CompilerDocument_txt:=""
		
		APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)
		$ClearDocument_txt:=""
	End if 
End for 
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+Char:C90(Carriage return:K15:38)+"End case"+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"if (size of array($Array_Ptr->)#SQL_Limit_L)"+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"Offset_l:=Count_l"+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"Else "+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"Offset_l:=Offset_l+SQL_Limit_L "+Char:C90(Carriage return:K15:38)
$ArraytoSelectionsDoc_txt:=$ArraytoSelectionsDoc_txt+"End if "+Char:C90(Carriage return:K15:38)

$CompilerDocument_txt:=$CompilerDocument_txt+Char:C90(Carriage return:K15:38)+"End case"+Char:C90(Carriage return:K15:38)
$CompilerDocument_txt:=$CompilerDocument_txt+Char:C90(Carriage return:K15:38)+"End if"
$ClearDocument_txt:=$ClearDocument_txt+Char:C90(Carriage return:K15:38)+"End case"+Char:C90(Carriage return:K15:38)
$ClearDocument_txt:=$ClearDocument_txt+Char:C90(Carriage return:K15:38)+"End if"

APPEND TO ARRAY:C911($CompilerOuput_atxt; $CompilerDocument_txt)
APPEND TO ARRAY:C911($ClearOuput_atxt; $ClearDocument_txt)

APPEND TO ARRAY:C911($ArrayToSelectOuput_atxt; $ArraytoSelectionsDoc_txt)


C_TIME:C306($Doc)
C_TEXT:C284($Folder_txt)
$Folder_txt:=Select folder:C670("Select folder where the content of the new methods will be stored")
$Doc:=Create document:C266($Folder_txt+"Compiler_FieldVariables.txt")
For ($FieldLoop_l; 1; Size of array:C274($CompilerOuput_atxt))
	SEND PACKET:C103($doc; $CompilerOuput_atxt{$FieldLoop_l})
End for 

CLOSE DOCUMENT:C267($doc)

C_LONGINT:C283($Error_l)
C_BLOB:C604($Method_blb)
CONFIRM:C162("Update method Compiler_FieldVariables?")
C_TEXT:C284($MethodPath_txt)

If (OK=1)
	
	$MethodPath_txt:=METHOD Get path:C1164(Path project method:K72:1; "Compiler_FieldVariables")
	
	DOCUMENT TO BLOB:C525($Folder_txt+"Compiler_FieldVariables.txt"; $Method_blb)
	C_TEXT:C284($Method_txt)
	$Method_txt:=BLOB to text:C555($Method_blb; UTF8 text without length:K22:17)
	METHOD SET CODE:C1194($MethodPath_txt; $Method_txt)
	
	//$Error_l:=@XX_AP Modify method ("Compiler_FieldVariables";$Method_blb)
End if 

$Doc:=Create document:C266($Folder_txt+"clone_ClearFieldVariables.txt")
For ($FieldLoop_l; 1; Size of array:C274($ClearOuput_atxt))
	SEND PACKET:C103($doc; $ClearOuput_atxt{$FieldLoop_l})
End for 

CLOSE DOCUMENT:C267($doc)
CONFIRM:C162("Update method clone_ClearFieldVariables?")

If (OK=1)
	
	$MethodPath_txt:=METHOD Get path:C1164(Path project method:K72:1; "clone_ClearFieldVariables")
	
	DOCUMENT TO BLOB:C525($Folder_txt+"clone_ClearFieldVariables.txt"; $Method_blb)
	C_TEXT:C284($Method_txt)
	$Method_txt:=BLOB to text:C555($Method_blb; UTF8 text without length:K22:17)
	METHOD SET CODE:C1194($MethodPath_txt; $Method_txt)
	//$Error_l:=@XX_AP Modify method ("clone_ClearFieldVariables";$Method_blb)
End if 




$Doc:=Create document:C266($Folder_txt+"Clone_ArrayToSelection.txt")
For ($FieldLoop_l; 1; Size of array:C274($ArrayToSelectOuput_atxt))
	SEND PACKET:C103($doc; $ArrayToSelectOuput_atxt{$FieldLoop_l})
End for 

CLOSE DOCUMENT:C267($doc)
CONFIRM:C162("Update method Clone_ArrayToSelection?")

If (OK=1)
	
	$MethodPath_txt:=METHOD Get path:C1164(Path project method:K72:1; "Clone_ArrayToSelection")
	
	DOCUMENT TO BLOB:C525($Folder_txt+"Clone_ArrayToSelection.txt"; $Method_blb)
	C_TEXT:C284($Method_txt)
	$Method_txt:=BLOB to text:C555($Method_blb; UTF8 text without length:K22:17)
	METHOD SET CODE:C1194($MethodPath_txt; $Method_txt)
	//$Error_l:=@XX_AP Modify method ("clone_ClearFieldVariables";$Method_blb)
End if 



//End ut_NewCreateSQLVariables

