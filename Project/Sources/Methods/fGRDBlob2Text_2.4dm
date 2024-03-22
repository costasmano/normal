//%attributes = {"invisible":true}
If (False:C215)
	//fGRDBlob2Text 
	//Parse new blob and old blob
	
	Mods_2005_CM04
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:09      ` Type all local variables for v11
End if 
C_BLOB:C604($xBlob; $xOldBlob)
C_TEXT:C284($vtResult; $vtResultOld)
C_LONGINT:C283($vlBlobCompr)
$xBlob:=[Activity Log:59]Data:10
$xOldBlob:=[Activity Log:59]Old Data:27
$vtResult:=""
$vtResultOld:=""
BLOB PROPERTIES:C536($xBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xBlob)
End if 
BLOB PROPERTIES:C536($xOldBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xOldBlob)
End if 
ARRAY TEXT:C222($asLocalIDs; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY TEXT:C222($asRemoteIDs; 0)  //Command Replaced was o_ARRAY string length was 80
BLOB TO VARIABLE:C533($xBlob; $asLocalIDs)
BLOB TO VARIABLE:C533($xOldBlob; $asRemoteIDs)
C_LONGINT:C283($vlNumIDs; $i)
$vlNumIDs:=Size of array:C274($asLocalIDs)
$vtResult:="<Count :"+String:C10($vlNumIDs)+">"
For ($i; 1; $vlNumIDs)
	$vtResult:=$vtResult+"<"+$asLocalIDs{$i}+">"
End for 
$vlNumIDs:=Size of array:C274($asRemoteIDs)
For ($i; 1; $vlNumIDs)
	$vtResultOld:=$vtResultOld+"<"+$asRemoteIDs{$i}+">"
End for 

vLogData:=$vtResult
vOldLogData:=$vtResultOld
$vtResult:=""
$vtResultOld:=""
SET BLOB SIZE:C606($xBlob; 0)
SET BLOB SIZE:C606($xOldBlob; 0)
