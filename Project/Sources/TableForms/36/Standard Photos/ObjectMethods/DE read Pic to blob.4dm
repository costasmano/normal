If (False:C215)
	//Object Method: [Standard Photos].Standard Photos.vRdPic2Blob 
	// Modified by: costasmanousakis-(Designer)-(9/15/08 11:52:56)
	Mods_2008_CM_5404  // ("IMAGESTORE")
	//Don't compress the image after it is loaded
	// Modified by: costasmanousakis-(Designer)-(5/4/11 11:54:09)
	Mods_2011_05
	//  `Changed the Open Document to Get Pathname only
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 16:47:28)
	Mods_2013_10
	//  `The Cannot handle file type is when OK=0 -> $vlRes=1 ; added message with the list of supported types from Picture Codec List
End if 

C_TIME:C306($vRef)
C_TEXT:C284($vsDocument)
C_LONGINT:C283($vlRes)
$vRef:=Open document:C264(""; ""; Get pathname:K24:6)
$vsDocument:=Document  //store it - Read Pic File clears it if error
If (OK=1)
	CLOSE DOCUMENT:C267($vRef)
	SET CURSOR:C469(4)
	C_PICTURE:C286($vTempPic)
	C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode; $res)
	
	READ PICTURE FILE:C678($vsDocument; $vTempPic)
	$vlRes:=1-OK
	
	If ($vlRes=0)
		[Standard Photos:36]Std Photo:3:=$vTempPic
		PushChange(2; ->[Standard Photos:36]Std Photo:3)
		vbPictureChanged:=True:C214
		REDRAW:C174([Standard Photos:36]Std Photo:3)
		C_TEXT:C284(vPictStats)
		PICTURE PROPERTIES:C457([Standard Photos:36]Std Photo:3; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356([Standard Photos:36]Std Photo:3); "##,###,### Bytes")+")"
	Else 
		Case of 
			: ($vlRes=-108)
				ALERT:C41("Insufficient memory to read picture file <"+$vsDocument+">")
			: ($vlRes=1)
				ARRAY TEXT:C222($picTypes_atxt; 0)
				ARRAY TEXT:C222($picTypeNames_atxt; 0)
				C_TEXT:C284($msg_txt)
				PICTURE CODEC LIST:C992($picTypes_atxt; $picTypeNames_atxt)
				C_LONGINT:C283($loop_L)
				$msg_txt:=$picTypes_atxt{1}
				For ($loop_L; 2; Size of array:C274($picTypes_atxt))
					$msg_txt:=$msg_txt+", "+$picTypes_atxt{$loop_L}
				End for 
				$msg_txt:="Not Supported Image type of file <"+$vsDocument+">!!!"+<>sCR+"Supported image types are "+$msg_txt
				ALERT:C41($msg_txt)
			Else 
				ALERT:C41("Error ("+String:C10($vlRes)+") reading file <"+$vsDocument+">")
		End case 
	End if 
	$vTempPic:=$vTempPic*0
	SET CURSOR:C469(0)
End if 