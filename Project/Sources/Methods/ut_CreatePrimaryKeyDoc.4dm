//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 09/01/15, 13:29:23
//----------------------------------------------------
//Method: ut_CreatePrimaryKeyDoc
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug  // 
	//Modified by: administrator (9/1/15 13:29:25)
	
End if 
C_LONGINT:C283($Primary_key_field_id_L)
C_TEXT:C284($TableName_txt; $KeyName_txt)
C_TEXT:C284($OUTPUT_txt; $Output1_txt)

C_TEXT:C284($ConstraintID_txt)
C_LONGINT:C283($TableNumber_L)
For ($TableNumber_L; 1; Get last table number:C254)
	If (Is table number valid:C999($TableNumber_L))
		$Primary_key_field_id_L:=clone_ReturnUUIDPrimaryKey($TableNumber_L)
		
		If ($Primary_key_field_id_L#0)
			ALERT:C41("Table named "+Table name:C256($TableNumber_L)+" has a primary key named "+Field name:C257($TableNumber_L; $Primary_key_field_id_L))
		Else 
			$TableName_txt:=Table name:C256($TableNumber_L)
			$KeyName_txt:=Substring:C12($TableName_txt; 1; 21)+"_UUIDKey_s"
			$KeyName_txt:=Replace string:C233($KeyName_txt; " "; "_"; 9999)
			$OUTPUT_txt:=$OUTPUT_txt+"Begin SQL"+Char:C90(Carriage return:K15:38)+"ALTER TABLE ["+$TableName_txt+"] ADD "+$KeyName_txt+" UUID AUTO_GENERATE PRIMARY KEY;"+Char:C90(Carriage return:K15:38)+"End SQL"+Char:C90(Carriage return:K15:38)
			$Output1_txt:=$Output1_txt+"EXECUTE FORMULA("+Char:C90(Double quote:K15:41)+"SET INDEX(["+$TableName_txt+"]"+$KeyName_txt+";true)"+Char:C90(Double quote:K15:41)+")"+Char:C90(Carriage return:K15:38)
			
		End if 
	End if 
End for 
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266("")
SEND PACKET:C103($Doc_tm; $OUTPUT_txt)
SEND PACKET:C103($Doc_tm; $Output1_txt)

CLOSE DOCUMENT:C267($Doc_tm)

//End ut_CreatePrimaryKeyDoc