//%attributes = {"invisible":true}
// ----------------------------------------------------
// utl_Findsubfields
// User name (OS): charlesmiller
// Date and time: 02/04/10, 09:58:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_02  //r001 CJ Miller`02/04/10, 09:58:09      `
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Size_l; $Loop_l)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
ARRAY TEXT:C222($Output_atxt; 1)
C_TEXT:C284($FieldName_txt; $FieldType_txt)
$Size_l:=1
For ($TableLoop_l; 1; Get last table number:C254)
	If ($TableLoop_l>1)
		$Output_atxt{1}:=$Output_atxt{1}+Char:C90(13)+Table name:C256($TableLoop_l)+Char:C90(13)
	Else 
		$Output_atxt{1}:=$Output_atxt{1}+Table name:C256($TableLoop_l)+Char:C90(13)
	End if 
	For ($FieldLoop_l; 1; Get last field number:C255($TableLoop_l))
		GET FIELD PROPERTIES:C258($TableLoop_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		If ($Type_l=Is subtable:K8:11)
			$FieldName_txt:=Field name:C257($TableLoop_l; $FieldLoop_l)
			$Output_atxt{$Size_l}:=$Output_atxt{$Size_l}+String:C10($FieldLoop_l)+Char:C90(Tab:K15:37)+$FieldName_txt+Char:C90(Tab:K15:37)+Char:C90(Carriage return:K15:38)
		End if 
		
		If (Length:C16($Output_atxt{$Size_l})>30000)
			APPEND TO ARRAY:C911($Output_atxt; "")
			$Size_l:=$Size_l+1
		End if 
		
	End for 
End for 
C_TIME:C306($Doc)
$Doc:=Create document:C266("")

For ($Loop_l; 1; $Size_l)
	SEND PACKET:C103($Doc; $Output_atxt{$Loop_l})
End for 

CLOSE DOCUMENT:C267($Doc)
//End utl_Findsubfields