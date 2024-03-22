//%attributes = {"invisible":true}
If (False:C215)
	//fBLOB_2_Text
	//Function to convert contents of a BLOB to a text representation.
	//To use to display in lists etc.
	//Usage :
	//C_Text(mytext)
	//C_BLOB(myblob)
	//C_LONGINT(blobtype)
	//mytext:=fBLOB_2_Text (myblob;blobtype)
	
	Mods_2005_CM04
	
	// Modified by: Costas Manousakis-(Designer)-(2/26/21 12:09:47)
	Mods_2021_02
	//  `added code to view contents of text, picture , blob fields.  Run only when the current form = "Input"
End if 

C_BLOB:C604($1; $vBlob)
C_LONGINT:C283($2; $vBlobType)
C_TEXT:C284($0; $vResult)

C_REAL:C285($vRArchData)
C_LONGINT:C283($vIArchData)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vLIArchData)
C_DATE:C307($vDArchData)
C_PICTURE:C286($vPArchData)
C_BOOLEAN:C305($vbData)
C_TIME:C306($vTArchData)
$vBlob:=$1
$vBlobType:=$2

C_BLOB:C604(v_59_010_blb; v_59_027_blb)
SET BLOB SIZE:C606(v_59_010_blb; 0)
SET BLOB SIZE:C606(v_59_027_blb; 0)
C_TEXT:C284($fldType_txt)
If (BLOB size:C605($vBlob)=0)
	$vResult:=""
Else 
	Case of 
		: ($vBlobType=Is BLOB:K8:12)
			$vResult:="<<BLOB "+String:C10(BLOB size:C605($vBlob))+"b   "+Substring:C12(BLOB to text:C555($vBlob; Mac text without length:K22:10); 1; 4)+">>"
			If (Current form name:C1298="Input")
				$fldType_txt:="BLOB"
				VARIABLE TO BLOB:C532($fldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532([Activity Log:59]ActField Name:20; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532([Activity Log:59]Field Number:8; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vBlob; v_59_027_blb; *)
				
			End if 
			
		: ($vBlobType=Is boolean:K8:9)
			BLOB TO VARIABLE:C533($vBlob; $vbData)
			If ($vbData)
				$vResult:="True"
			Else 
				$vResult:="False"
			End if 
		: (($vBlobType=Is alpha field:K8:1) | ($vBlobType=Is text:K8:3))
			BLOB TO VARIABLE:C533($vBlob; $vResult)
			
			If (Current form name:C1298="Input")
				$fldType_txt:="TEXT"
				VARIABLE TO BLOB:C532($fldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532([Activity Log:59]ActField Name:20; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532([Activity Log:59]Field Number:8; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vBlob; v_59_027_blb; *)
				
			End if 
			
		: ($vBlobType=Is real:K8:4)
			BLOB TO VARIABLE:C533($vBlob; $vRArchData)
			$vResult:=String:C10($vRArchData)
		: ($vBlobType=Is integer:K8:5)
			BLOB TO VARIABLE:C533($vBlob; $vIArchData)
			$vResult:=String:C10($vIArchData)
		: ($vBlobType=Is longint:K8:6)
			BLOB TO VARIABLE:C533($vBlob; $vLIArchData)
			$vResult:=String:C10($vLIArchData)
		: ($vBlobType=Is picture:K8:10)
			BLOB TO VARIABLE:C533($vBlob; $vPArchData)
			$vResult:="<<Image>>"
			If (Current form name:C1298="Input")
				$fldType_txt:="Picture"
				VARIABLE TO BLOB:C532($fldType_txt; v_59_010_blb; *)
				VARIABLE TO BLOB:C532([Activity Log:59]ActField Name:20; v_59_010_blb; *)
				
				VARIABLE TO BLOB:C532([Activity Log:59]Field Number:8; v_59_027_blb; *)
				VARIABLE TO BLOB:C532($vBlob; v_59_027_blb; *)
				
			End if 
			
		: ($vBlobType=Is date:K8:7)
			BLOB TO VARIABLE:C533($vBlob; $vDArchData)
			$vResult:=String:C10($vDArchData)
		: ($vBlobType=Is time:K8:8)
			BLOB TO VARIABLE:C533($vBlob; $vTArchData)
			$vResult:=String:C10($vTArchData)
		Else 
			$vResult:=""
	End case 
End if 

$0:=$vResult
//clear vars
$vPArchData:=$vPArchData*0
SET BLOB SIZE:C606($vBlob; 0)
$vResult:=""