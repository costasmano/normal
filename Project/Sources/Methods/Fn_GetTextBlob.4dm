//%attributes = {"invisible":true,"publishedSql":true}
// Method: Fn_GetTextBlob
// Description
// Retrieve the text from a 4D Write blob
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/02/08, 10:02:47
	// ----------------------------------------------------
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(6/1/09 15:14:15)
	Mods_2009_06
	//Changed call to WR Get Text to start at 0;32000 instead of 1;32000 
	// Modified by: Costas Manousakis-(Designer)-(3/10/21 11:16:36)
	Mods_2021_WP
	//  ` 
End if 
C_TEXT:C284($0; $BlobText_txt; $WPtag)
C_BLOB:C604($1; $Blob_x; $WpData)
$Blob_x:=$1
$BlobText_txt:=""
If (BLOB size:C605($Blob_x)>0)
	C_LONGINT:C283($comprBlob_L; $offset)
	BLOB PROPERTIES:C536($Blob_x; $comprBlob_L)
	If ($comprBlob_L#0)
		EXPAND BLOB:C535($Blob_x)
	End if 
	$offset:=0
	BLOB TO VARIABLE:C533($Blob_x; $wptag; $offset)
	
	If ($WPtag="WPAREA")
		BLOB TO VARIABLE:C533($Blob_x; $WpData; $offset)
		C_OBJECT:C1216($wpArea; $range)
		$wpArea:=WP New:C1317($WpData)
		$range:=WP Text range:C1341($wpArea; wk start text:K81:165; wk end text:K81:164)
		$BlobText_txt:=WP Get text:C1575($range; wk expressions as value:K81:255)
		
	End if 
	
End if 
SET BLOB SIZE:C606($Blob_x; 0)
$0:=$BlobText_txt