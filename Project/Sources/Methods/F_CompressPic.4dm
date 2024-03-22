//%attributes = {"invisible":true}
//F_CompressPic
//compresses a picture passed if needed according to pixel dimensions.
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(4/20/16 13:17:38)
	Mods_2016_04_bug
	//  `replaced call to compress picture with Convert Picture ( this does not use quality parameter)
	//  `compress picture used Quicktime
	// Modified by: Costas Manousakis-(Designer)-(10/14/16 12:57:23)
	Mods_2016_10
	//  `added comments for Compress picture in case of v13+ versions use $vPicQual parameter
	// Modified by: Costas Manousakis-(Designer)-(3/15/17 17:42:07)
	Mods_2017_03
	//  `added if statement for application version to cause compile error in v11 to alert for v13
	//  `in the v11 case use quicktime to compress the picture first then convert it to jpg ; 
	//  `in v13+ compression is done with the convert command
End if 

C_PICTURE:C286($0; $1; $vTempPict)
C_BOOLEAN:C305($vbCompress)

$vTempPict:=$1
$vbCompress:=True:C214
C_LONGINT:C283($vPicW; $vPicH; $vPicQual; $vPicHoff; $vPicVoff; $vPicmode)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($vlPicSize; $vlCompressSize)
PICTURE PROPERTIES:C457($vTempPict; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
If ($vPicH>$vPicW)
	$vPicW:=$vPicH  //get the largest dim
End if 
$vlPicSize:=Picture size:C356($vTempPict)
If ($vlPicSize>0)
	Case of 
		: ($vPicW>1500)
			$vPicQual:=500
		: ($vPicW>1200)
			$vPicQual:=600
			If ($vlPicSize>400000)
				$vPicQual:=500
			End if 
		: ($vPicW>1000)
			$vPicQual:=800
			Case of 
				: ($vlPicSize>400000)
					$vPicQual:=500
				: ($vlPicSize>300000)
					$vPicQual:=600
				: ($vlPicSize>250000)
					$vPicQual:=700
			End case 
		: ($vPicW>800)
			$vPicQual:=800
			Case of 
				: ($vlPicSize>400000)
					$vPicQual:=500
				: ($vlPicSize>300000)
					$vPicQual:=600
				: ($vlPicSize>200000)
					$vPicQual:=700
			End case 
			
		Else 
			$vPicQual:=900
			If ($vlPicSize>350000)
				$vPicQual:=500
			End if 
			If ($vlPicSize<10000)
				$vbCompress:=False:C215
			End if 
			
	End case 
	If ($vbCompress)
		//COMPRESS PICTURE($vTempPict;"jpeg";$vPicQual)
		//CONVERT PICTURE($vTempPict;"image/jpeg")
		$vPicQual:=$vPicQual*0.8  // to reduce photo size more compression is not as good as quicktime in v11
		// *********  READ THIS !!!!! ******
		//comment out the following  CONVERT PICTURE for syntax or compiling in v11 - uncomment after syntx check done or build app done
		// *********  READ THIS !!!!! ******
		CONVERT PICTURE:C1002($vTempPict; ".jpg"; ($vPicQual/1000))  // v13+ version has the quality param - must be commented out in v11
		
		//If (Application version="11@")
		//_ o_QT COMPRESS PICTURE($vTempPict;"jpeg";$vPicQual)  // compress w quicktime first
		//CONVERT PICTURE($vTempPict;".jpg")  // then convert to jpg v11 version - 
		//Else 
		//End if 
		
	End if 
	$vlCompressSize:=Picture size:C356($vTempPict)
	//Was found that Picsize of 6 indicates some error in the compression.
	//That occures when copying sketched with rotated text.
	If (($vlCompressSize>6) & ($vlCompressSize<$vlPicSize))
		$0:=$vTempPict
	Else 
		$0:=$1
	End if 
Else 
	$0:=$1
End if 
$vTempPict:=$vTempPict*0