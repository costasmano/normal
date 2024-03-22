//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/18/06, 10:27:29
	// ----------------------------------------------------
	// Method: Method: fLNKBlob2Text_2
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CMy1
End if 

C_BLOB:C604($xBlob; $xOldBlob)
C_LONGINT:C283($vlBlobCompr)
C_TEXT:C284($vtResult; $vtResultOld)
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
C_LONGINT:C283($TableNum_L; $vlOffset)
C_LONGINT:C283($vIBData; $vIBOData)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vLIBData; $vLIBOData)
C_TEXT:C284($vstrData)  // Command Replaced was o_C_STRING length was 255
Case of 
	: ([Activity Log:59]Data Type:11=Is alpha field:K8:1)  //Alpha
		BLOB TO VARIABLE:C533($xBlob; $vstrData; $vlOffset)
		$vtResult:=$vstrData
		BLOB TO VARIABLE:C533($xOldBlob; $vstrData)
		$vtResultOld:=$vstrData
	: ([Activity Log:59]Data Type:11=Is integer:K8:5)  //Integer
		BLOB TO VARIABLE:C533($xBlob; $vIBData; $vlOffset)
		$vtResult:=String:C10($vIBData)
		BLOB TO VARIABLE:C533($xOldBlob; $vIBOData)
		$vtResultOld:=String:C10($vIBOData)
	: ([Activity Log:59]Data Type:11=Is longint:K8:6)  //longint
		BLOB TO VARIABLE:C533($xBlob; $vLIBData; $vlOffset)
		$vtResult:=String:C10($vLIBData)
		BLOB TO VARIABLE:C533($xOldBlob; $vLIBOData)
		$vtResultOld:=String:C10($vLIBOData)
End case 
BLOB TO VARIABLE:C533($xBlob; $TableNum_L; $vlOffset)
If ((OK=1) & ($TableNum_L>0))
	$vtResult:=$vtResult+" - ["+String:C10($TableNum_L)+"]"
	If (($TableNum_L<=Get last table number:C254))
		$vtResult:=$vtResult+" : ["+Table name:C256($TableNum_L)+"]"
	Else 
		$vtResult:=$vtResult+" : [Unknown Table!!!]"
	End if 
End if 

vLogData:=$vtResult
vOldLogData:=$vtResultOld
$vtResult:=""
$vtResultOld:=""
SET BLOB SIZE:C606($xBlob; 0)
SET BLOB SIZE:C606($xOldBlob; 0)