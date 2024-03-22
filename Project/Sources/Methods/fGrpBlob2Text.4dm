//%attributes = {"invisible":true}
If (False:C215)
	//fGrpBlob2Text
	
	Mods_2005_CM04
	Mods_2011_06  // CJ Miller`06/13/11, 16:54:07      ` Type all local variables for v11
End if 

C_BLOB:C604($1; $xBlob)
C_TEXT:C284($0; $vtResult)
$vtResult:=""
$xBlob:=$1
C_LONGINT:C283($i; $vlNumflds; $offset; $vlFldNum; $vlFldType; $vBlobType)
C_REAL:C285($vRBData)
C_LONGINT:C283($vIBData)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vLIBData; $vlBlobCompr)
C_DATE:C307($vDBData)
C_PICTURE:C286($vPBData)
C_BOOLEAN:C305($vbBData)
C_TIME:C306($vTBData)
C_TEXT:C284($vsFldName)  // Command Replaced was o_C_STRING length was 80
C_BLOB:C604($vxBBlob)
C_TEXT:C284($vtxtBData)
BLOB PROPERTIES:C536($xBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xBlob)
End if 
BLOB TO VARIABLE:C533($xBlob; $vlNumflds; $offset)
$vtResult:=String:C10($vlNumFlds)
ARRAY INTEGER:C220($aiFldChanged; $vlNumflds)
BLOB TO VARIABLE:C533($xBlob; $aiFldChanged; $offset)
For ($i; 1; $vlNumflds)
	BLOB TO VARIABLE:C533($xBlob; $vlFldNum; $offset)
	BLOB TO VARIABLE:C533($xBlob; $vsFldName; $offset)
	BLOB TO VARIABLE:C533($xBlob; $vBlobType; $offset)
	Case of 
		: ($vBlobType=Is BLOB:K8:12)
			BLOB TO VARIABLE:C533($xBlob; $vxBBlob; $offset)  //no old Value
			$vtxtBData:="<<BLOB>>"
		: ($vBlobType=Is boolean:K8:9)
			BLOB TO VARIABLE:C533($xBlob; $vbBData; $offset)
			$vtxtBData:=f_Boolean2String($vbBData; "YN")
		: ($vBlobType=Is alpha field:K8:1)
			BLOB TO VARIABLE:C533($xBlob; $vtxtBData; $offset)
			$vtxtBData:="'"+$vtxtBData+"'"
		: ($vBlobType=Is text:K8:3)
			BLOB TO VARIABLE:C533($xBlob; $vtxtBData; $offset)
		: ($vBlobType=Is real:K8:4)
			BLOB TO VARIABLE:C533($xBlob; $vRBData; $offset)
			$vtxtBData:=String:C10($vRBData)
		: ($vBlobType=Is integer:K8:5)
			BLOB TO VARIABLE:C533($xBlob; $vIBData; $offset)
			$vtxtBData:=String:C10($vIBData)
		: ($vBlobType=Is longint:K8:6)
			BLOB TO VARIABLE:C533($xBlob; $vLIBData; $offset)
			$vtxtBData:=String:C10($vLIBData)
		: ($vBlobType=Is picture:K8:10)
			BLOB TO VARIABLE:C533($xBlob; $vPBData; $offset)
			$vtxtBData:="<<Image>>"
		: ($vBlobType=Is date:K8:7)
			BLOB TO VARIABLE:C533($xBlob; $vDBData; $offset)
			$vtxtBData:=String:C10($vDBData)
		: ($vBlobType=Is time:K8:8)
			BLOB TO VARIABLE:C533($xBlob; $vTBData; $offset)
			$vtxtBData:=String:C10($vTBData)
	End case 
	$vtResult:=$vtResult+"<["+String:C10($vlFldNum)+"] : "+$vsFldName+"="+$vtxtBData+">"
End for 
$0:=$vtResult
SET BLOB SIZE:C606($xBlob; 0)
$vtResult:=""
$vtxtBData:=""
$vPBData:=$vPBData*0