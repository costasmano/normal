//%attributes = {"invisible":true}
//Method: ut_FixBINSequence
//Description
// Fix the "BIN" sequence in the [Sequences] table
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-03-16, 13:14:25
	// ----------------------------------------------------
	//Created : 
	Mods_2022_03
	// Modified by: Costas Manousakis-(Designer)-(2023-06-07 10:53:44)
	Mods_2023_06_bug
	//  `removed spurious call to ut_FixSequence
End if 
//
C_TEXT:C284($SeqName_s)  // Command Replaced was o_C_STRING length was 20
C_POINTER:C301($KeyField_Ptr)
$SeqName_s:="BIN"
$KeyField_Ptr:=->[Bridge MHD NBIS:1]BIN:3

C_LONGINT:C283($CurrSeqNo_L; $MaxFieldValue_L; $FieldType_L; $SecondMaxFldValue_L; $i; $Selected_L)
C_POINTER:C301($Table_ptr)
C_BOOLEAN:C305($Loaded_b)
C_TEXT:C284($msg_txt; $FullFieldName_txt)

$Table_ptr:=Table:C252(Table:C252($KeyField_Ptr))
$FullFieldName_txt:="["+Table name:C256($Table_ptr)+"]"+Field name:C257($KeyField_Ptr)
READ ONLY:C145($Table_ptr->)
If (Records in table:C83($Table_ptr->)>0)
	ALL RECORDS:C47($Table_ptr->)
	ORDER BY:C49($Table_ptr->; $KeyField_Ptr->; <)
	FIRST RECORD:C50($Table_ptr->)
	$MaxFieldValue_L:=ConvertBINtoNumber($KeyField_Ptr->)
	NEXT RECORD:C51($Table_ptr->)
	$SecondMaxFldValue_L:=ConvertBINtoNumber($KeyField_Ptr->)
	QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName_s)
	If (Records in selection:C76([Sequences:28])=1)
		$Loaded_b:=ut_LoadRecordInteractive(->[Sequences:28])
		If ($Loaded_b)
			$CurrSeqNo_L:=[Sequences:28]Value:2
			If ($CurrSeqNo_L<$MaxFieldValue_L)
				$msg_txt:="Sequence "+$SeqName_s+" is out of step with Field "+$FullFieldName_txt+". "+\
					"Stored "+String:C10($CurrSeqNo_L)+" ("+ConvertBIN($CurrSeqNo_L)+") "+\
					" -vs- in max 2 in field  : "+String:C10($MaxFieldValue_L)+" ("+ConvertBIN($MaxFieldValue_L)+") "+\
					", "+String:C10($SecondMaxFldValue_L)+" ("+ConvertBIN($SecondMaxFldValue_L)+") "+\
					".  Fix it?"
				CONFIRM:C162($msg_txt)
				If (OK=1)
					[Sequences:28]Value:2:=$MaxFieldValue_L
					SAVE RECORD:C53([Sequences:28])
					UNLOAD RECORD:C212([Sequences:28])
				End if 
				
			End if 
		Else 
			ALERT:C41("Could not load Sequence "+$SeqName_s+" record!")
		End if 
		UNLOAD RECORD:C212([Sequences:28])
	Else 
		If (Records in selection:C76([Sequences:28])>1)
			$msg_txt:="Found multiple records for sequence "+$SeqName_s+". Current max field value for field "+$FullFieldName_txt+\
				" is "+String:C10($MaxFieldValue_L)+" ("+ConvertBIN($MaxFieldValue_L)+\
				"); Next max value is "+String:C10($SecondMaxFldValue_L)+" ("+ConvertBIN($SecondMaxFldValue_L)+") ."+\
				" The next window will come up until there is only one left to allow to select all except one of them for deletion!!!!"
			ARRAY LONGINT:C221($Records_aL; 0)
			ARRAY LONGINT:C221($SeqVal_aL; 0)
			ARRAY TEXT:C222($SeqNum_as; 0)  //Command Replaced was o_ARRAY string length was 20
			C_BOOLEAN:C305($Done_B)
			$Done_B:=False:C215
			Repeat 
				SELECTION TO ARRAY:C260([Sequences:28]; $Records_aL; [Sequences:28]Name:1; $SeqNum_as; [Sequences:28]Value:2; $SeqVal_aL)
				ARRAY TEXT:C222(sequenceData_atxt; Size of array:C274($Records_aL))
				For ($i; 1; Size of array:C274(sequenceData_atxt))
					sequenceData_atxt{$i}:=$SeqNum_as{$i}+" - "+String:C10($SeqVal_aL{$i})
				End for 
				$Selected_L:=G_PickFromList(->sequenceData_atxt)
				If ($Selected_L>0)
					GOTO RECORD:C242([Sequences:28]; $Records_aL{$Selected_L})
					If (ut_LoadRecordInteractive(->[Sequences:28]))
						DELETE RECORD:C58([Sequences:28])
					Else 
						ALERT:C41("Could not load Sequence record <"+sequenceData_atxt{$Selected_L}+"> !!!")
					End if 
				End if 
				QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName_s)
				If (Records in selection:C76([Sequences:28])=1)
					$Done_B:=True:C214  //down to one Sequence record ..
					$Loaded_b:=ut_LoadRecordInteractive(->[Sequences:28])
					If ($Loaded_b)
						$CurrSeqNo_L:=[Sequences:28]Value:2
						If ($CurrSeqNo_L<$MaxFieldValue_L)
							$msg_txt:="Sequence "+$SeqName_s+" is out of step with Field "+$FullFieldName_txt+". "+\
								"Stored "+String:C10($CurrSeqNo_L)+" ("+ConvertBIN($CurrSeqNo_L)+") "+\
								" -vs- in max 2 in field  : "+String:C10($MaxFieldValue_L)+" ("+ConvertBIN($MaxFieldValue_L)+") "+\
								", "+String:C10($SecondMaxFldValue_L)+" ("+ConvertBIN($SecondMaxFldValue_L)+") "+\
								".  Fix it?"
							CONFIRM:C162($msg_txt)
							If (OK=1)
								[Sequences:28]Value:2:=$MaxFieldValue_L
								SAVE RECORD:C53([Sequences:28])
								UNLOAD RECORD:C212([Sequences:28])
							End if 
							
						End if 
					Else 
						ALERT:C41("Could not load Sequence "+$SeqName_s+" record!")
					End if 
					UNLOAD RECORD:C212([Sequences:28])
					
				End if 
				ARRAY TEXT:C222(sequenceData_atxt; 0)
				
			Until ($Done_B)
			
		Else 
			$msg_txt:="No record found for sequence "+$SeqName_s+". Current max field value for field "+$FullFieldName_txt
			$msg_txt:=$msg_txt+" is "+String:C10($MaxFieldValue_L)+"; Next max value is "+String:C10($SecondMaxFldValue_L)+"."
			$msg_txt:=$msg_txt+" Create sequence record?"
			CONFIRM:C162($msg_txt)
			If (OK=1)
				CREATE RECORD:C68([Sequences:28])
				[Sequences:28]Name:1:=$SeqName_s
				[Sequences:28]Value:2:=$MaxFieldValue_L
				SAVE RECORD:C53([Sequences:28])
				UNLOAD RECORD:C212([Sequences:28])
			End if 
		End if 
		
	End if 
	
End if 
//End ut_FixBINSequence