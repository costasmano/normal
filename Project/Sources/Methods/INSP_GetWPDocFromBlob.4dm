//%attributes = {"invisible":true}
//Method: INSP_GetWPDocFromBlob
//Description
// Retrieve the blob containing the WP Doc from a blob
// Parameters
// $0 : $WPBlob
// $1 : $FieldBlob
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/26/21, 17:14:54
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_BLOB:C604(INSP_GetWPDocFromBlob; $0; $1)
	
End if 
//

C_BLOB:C604($0; $1)

C_BLOB:C604($Field; $WPBlob)

$Field:=$1

SET BLOB SIZE:C606($WPBlob; 0)
C_LONGINT:C283($compressed)
BLOB PROPERTIES:C536($Field; $compressed)
If ($compressed#0)
	EXPAND BLOB:C535($Field)
End if 
C_TEXT:C284($dataTag)
C_LONGINT:C283($offset)
$offset:=0
BLOB TO VARIABLE:C533($Field; $dataTag; $offset)

If ($dataTag="WPAREA")
	BLOB TO VARIABLE:C533($Field; $WPBlob; $offset)
End if 

$0:=$WPBlob

//End INSP_GetWPDocFromBlob