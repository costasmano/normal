//%attributes = {"invisible":true}
// Method: wrp_GetTextProperties
// Description
// Retrieve Text properties from a Write Pro area in a blob
// Parameters
// $0 : $TextProps_obj .count  .text
// $1 : $WpBlob
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 01/25/21, 18:12:08
	// ----------------------------------------------------
	// First Release
	Mods_2021_WP
	
	C_OBJECT:C1216(wrp_GetTextProperties; $0)
	C_BLOB:C604(wrp_GetTextProperties; $1)
End if 

C_OBJECT:C1216($0; $TextProps_o)
C_BLOB:C604($1)

If (BLOB size:C605($1)>0)
	C_BLOB:C604($datablob)
	$datablob:=$1
	C_LONGINT:C283($compressed)
	BLOB PROPERTIES:C536($datablob; $compressed)
	If ($compressed#0)
		EXPAND BLOB:C535($datablob)
	End if 
	
	C_OBJECT:C1216($wparea; $body)
	C_BLOB:C604($WPBlob)
	C_TEXT:C284($dataTag)
	C_LONGINT:C283($offset)
	$offset:=0
	BLOB TO VARIABLE:C533($datablob; $dataTag; $offset)
	If ($dataTag="WPAREA")
		BLOB TO VARIABLE:C533($datablob; $WPBlob; $offset)
		$wparea:=WP New:C1317($WPBlob)
		$body:=WP Text range:C1341($wparea; wk start text:K81:165; wk end text:K81:164)
		
		OB SET:C1220($TextProps_o; "count"; $body.end)
		OB SET:C1220($TextProps_o; "text"; WP Get text:C1575($body; wk expressions as value:K81:255))
		
	End if 
End if 

$0:=$TextProps_o

//End wrp_GetTextProperties