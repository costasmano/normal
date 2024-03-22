//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_DropIndices
// User name (OS): charlesmiller
// Date and time: 11/09/10, 15:10:02
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_11  //r002 CJ Miller`11/09/10, 16:40:38      `
	Mods_2011_06  // CJ Miller`06/20/11, 10:16:06      ` Type all local variables for v11
End if 

C_TEXT:C284($FieldName_txt; $TableName_txt)
C_POINTER:C301($filePtr; $FieldPtr)
C_LONGINT:C283($Loop_l; $iTableLoop; $Length_l; $OneTable_l; $OneField_l; $ChoiceField_l; $Type_l)
ARRAY TEXT:C222($Relations_atxt; 0)
C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b; $AutoOne_b; $Automany_b)
For ($iTableLoop; 1; Get last table number:C254)
	$TableName_txt:=Table name:C256($iTableLoop)
	
	$filePtr:=Table:C252($iTableLoop)
	UNLOAD RECORD:C212($fileptr->)
	For ($Loop_l; 1; Get last field number:C255($filePtr))
		GET FIELD PROPERTIES:C258($iTableLoop; $Loop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
		If ($Indexed_b=True:C214)
			GET RELATION PROPERTIES:C686($iTableLoop; $Loop_l; $OneTable_l; $OneField_l; $ChoiceField_l; $AutoOne_b; $Automany_b)
			If ($OneTable_l=0)  //no relation line exists and we can drop index
				$FieldPtr:=Field:C253($iTableLoop; $Loop_l)
				SET INDEX:C344($FieldPtr->; False:C215)
			Else 
				APPEND TO ARRAY:C911($Relations_atxt; $TableName_txt+", "+Field name:C257($iTableLoop; $Loop_l))
			End if 
		End if 
	End for 
End for 

If (Size of array:C274($Relations_atxt)>0)
	C_TIME:C306($Doc)
	$Doc:=Create document:C266("")
	For ($iTableLoop; 1; Size of array:C274($Relations_atxt))
		SEND PACKET:C103($Doc; $Relations_atxt{$iTableLoop})
	End for 
	
	CLOSE DOCUMENT:C267($Doc)
Else 
	ALERT:C41("All Indices and relations have been removed")
	
End if 


//End ut_DropIndices
