//%attributes = {"invisible":true}
If (False:C215)
	//fGrpBlob2Text_2
	//Parse new blob and old blob
	
	Mods_2005_CM04
	Mods_2011_06  // CJ Miller`06/13/11, 17:02:23      ` Type all local variables for v11
	Mods_2018_12  //Add ability to view pictures/text/and 4d write areas form activity log input form
	//Modified by: Chuck Miller (12/11/18 13:53:23)
	// Modified by: Costas Manousakis-(Designer)-(2/26/21 12:13:15)
	Mods_2021_02
	//  `accumulate the data to view fields only when current form name = "input"
End if 
C_BLOB:C604($xBlob; $xOldBlob)
C_TEXT:C284($vtResult; $vtResultOld)
$xBlob:=[Activity Log:59]Data:10
$xOldBlob:=[Activity Log:59]Old Data:27
$vtResult:=""
$vtResultOld:=""
C_LONGINT:C283($i; $vlNumflds; $offset; $vlFldNum; $vlFldType; $vBlobType; $OldOffset; $vlBlobCompr)
C_REAL:C285($vRBData; $vRBOData)
C_LONGINT:C283($vIBData; $vIBOData)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vLIBData; $vLIBOData)
C_DATE:C307($vDBData; $vDBOData)
C_PICTURE:C286($vPBData; $vPBOData)
C_BOOLEAN:C305($vbBData; $vbBOData)
C_TIME:C306($vTBData; $vTBOData)
C_TEXT:C284($vsFldName)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($vstrData)  // Command Replaced was o_C_STRING length was 255
C_BLOB:C604($vxBBlob)
C_TEXT:C284($vtxtBData; $vtxtBOData)
BLOB PROPERTIES:C536($xBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xBlob)
End if 
BLOB PROPERTIES:C536($xOldBlob; $vlBlobCompr)
If ($vlBlobCompr#Is not compressed:K22:11)
	EXPAND BLOB:C535($xOldBlob)
End if 
BLOB TO VARIABLE:C533($xBlob; $vlNumflds; $offset)
$vtResult:=String:C10($vlNumFlds)
ARRAY INTEGER:C220($aiFldsChanged; $vlNumflds)
BLOB TO VARIABLE:C533($xBlob; $aiFldsChanged; $offset)

C_BLOB:C604(v_59_010_blb; v_59_027_blb)
SET BLOB SIZE:C606(v_59_010_blb; 0)
SET BLOB SIZE:C606(v_59_027_blb; 0)

For ($i; 1; $vlNumflds)
	BLOB TO VARIABLE:C533($xBlob; $vlFldNum; $offset)
	BLOB TO VARIABLE:C533($xBlob; $vsFldName; $offset)
	BLOB TO VARIABLE:C533($xBlob; $vBlobType; $offset)
	C_TEXT:C284($fieldType_txt)
	
	Case of 
		: ($vBlobType=Is BLOB:K8:12)
			BLOB TO VARIABLE:C533($xBlob; $vxBBlob; $offset)
			$vtxtBData:="<BLOB "+String:C10(BLOB size:C605($vxBBlob))+"b>"
			
			If (Current form name:C1298="Input")
				$fieldType_txt:="BLOB"
				VARIABLE TO BLOB:C532($fieldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532($vsFldName; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532($vlFldNum; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vxBBlob; v_59_027_blb; *)
			End if 
			
			BLOB TO VARIABLE:C533($xOldBlob; $vxBBlob; $OldOffset)
			$vtxtBOData:="<None BLOB>"
			
			
		: ($vBlobType=Is boolean:K8:9)
			BLOB TO VARIABLE:C533($xBlob; $vbBData; $offset)
			$vtxtBData:=f_Boolean2String($vbBData; "YN")
			BLOB TO VARIABLE:C533($xOldBlob; $vbBData; $OldOffset)
			$vtxtBOData:=f_Boolean2String($vbBData; "YN")
		: ($vBlobType=Is alpha field:K8:1)
			BLOB TO VARIABLE:C533($xBlob; $vstrData; $offset)
			$vtxtBData:="'"+$vstrData+"'"
			BLOB TO VARIABLE:C533($xOldBlob; $vstrData; $OldOffset)
			$vtxtBOData:="'"+$vstrData+"'"
		: ($vBlobType=Is text:K8:3)
			BLOB TO VARIABLE:C533($xBlob; $vtxtBData; $offset)
			BLOB TO VARIABLE:C533($xOldBlob; $vtxtBOData; $OldOffset)
			$vtxtBOData:="<None Txt>"
			
			If (Current form name:C1298="Input")
				$fieldType_txt:="TEXT"
				VARIABLE TO BLOB:C532($fieldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532($vsFldName; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532($vlFldNum; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vtxtBData; v_59_027_blb; *)
			End if 
			
		: ($vBlobType=Is real:K8:4)
			BLOB TO VARIABLE:C533($xBlob; $vRBData; $offset)
			$vtxtBData:=String:C10($vRBData)
			BLOB TO VARIABLE:C533($xOldBlob; $vRBData; $OldOffset)
			$vtxtBOData:=String:C10($vRBData)
		: ($vBlobType=Is integer:K8:5)
			BLOB TO VARIABLE:C533($xBlob; $vIBData; $offset)
			$vtxtBData:=String:C10($vIBData)
			BLOB TO VARIABLE:C533($xOldBlob; $vIBData; $OldOffset)
			$vtxtBOData:=String:C10($vIBData)
		: ($vBlobType=Is longint:K8:6)
			BLOB TO VARIABLE:C533($xBlob; $vLIBData; $offset)
			$vtxtBData:=String:C10($vLIBData)
			BLOB TO VARIABLE:C533($xOldBlob; $vLIBData; $OldOffset)
			$vtxtBOData:=String:C10($vLIBData)
		: ($vBlobType=Is picture:K8:10)
			BLOB TO VARIABLE:C533($xBlob; $vPBData; $offset)
			$vtxtBData:="<Image "+String:C10(Picture size:C356($vPBData))+"b>"
			BLOB TO VARIABLE:C533($xOldBlob; $vPBOData; $OldOffset)
			$vtxtBOData:="<None Image>"
			If (Current form name:C1298="Input")
				$fieldType_txt:="Picture"
				VARIABLE TO BLOB:C532($fieldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532($vsFldName; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532($vlFldNum; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vPBData; v_59_027_blb; *)
			End if 
			
		: ($vBlobType=Is date:K8:7)
			BLOB TO VARIABLE:C533($xBlob; $vDBData; $offset)
			$vtxtBData:=String:C10($vDBData)
			BLOB TO VARIABLE:C533($xOldBlob; $vDBData; $OldOffset)
			$vtxtBOData:=String:C10($vDBData)
		: ($vBlobType=Is time:K8:8)
			BLOB TO VARIABLE:C533($xBlob; $vTBData; $offset)
			$vtxtBData:=String:C10($vTBData)
			BLOB TO VARIABLE:C533($xOldBlob; $vTBData; $OldOffset)
			$vtxtBOData:=String:C10($vTBData)
	End case 
	$vtResult:=$vtResult+"<["+String:C10($vlFldNum)+"] : "+$vsFldName+"="+$vtxtBData+">"
	$vtResultOld:=$vtResultOld+"<"+$vtxtBOData+">"
	
End for 
vLogData:=$vtResult
vOldLogData:=$vtResultOld
$vtResult:=""
$vtResultOld:=""
SET BLOB SIZE:C606($xBlob; 0)
SET BLOB SIZE:C606($xOldBlob; 0)
$vPBData:=$vPBData*0
$vPBOData:=$vPBData