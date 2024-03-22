//%attributes = {"invisible":true}
If (False:C215)
	//fGRDBlob2Text 
	
	Mods_2005_CM04
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_BLOB:C604($1; $xBlob)
C_TEXT:C284($0; $vtResult)
$vtResult:=""
$xBlob:=$1
C_LONGINT:C283($vlBlobCompr)
BLOB PROPERTIES:C536($xBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xBlob)
End if 
ARRAY TEXT:C222($asLocalIDs; 0)  //Command Replaced was o_ARRAY string length was 80
BLOB TO VARIABLE:C533($xBlob; $asLocalIDs)
C_LONGINT:C283($vlNumIDs; $i)
$vlNumIDs:=Size of array:C274($asLocalIDs)
$vtResult:="<Count :"+String:C10($vlNumIDs)+">"
For ($i; 1; $vlNumIDs)
	$vtResult:=$vtResult+"<"+$asLocalIDs{$i}+">"
End for 
$0:=$vtResult
SET BLOB SIZE:C606($xBlob; 0)
$vtResult:=""