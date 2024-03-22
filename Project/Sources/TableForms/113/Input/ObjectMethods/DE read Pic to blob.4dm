C_TIME:C306($vRef)
C_TEXT:C284($vsDocument)
C_LONGINT:C283($vlRes)
$vRef:=Open document:C264("")
C_BOOLEAN:C305(vbPictureChanged)
If (OK=1)
	$vsDocument:=Document  //store it - Read Pic File clears it if error
	CLOSE DOCUMENT:C267($vRef)
	SET CURSOR:C469(4)
	C_PICTURE:C286(DE_InvPhoto)
	C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode; $res)
	READ PICTURE FILE:C678($vsDocument; DE_InvPhoto)
	$vlRes:=1-OK
	
	If ($vlRes=0)
		vbPictureChanged:=True:C214
		REDRAW:C174(DE_InvPhoto)
		C_TEXT:C284(vPictStats)
		PICTURE PROPERTIES:C457(DE_InvPhoto; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356(DE_InvPhoto); "##,###,### Bytes")+")"
	Else 
		Case of 
			: ($vlRes=-108)
				ALERT:C41("Insufficient memory to read picture file <"+$vsDocument+">")
			: ($vlRes=-1)
				ALERT:C41("Cannot handle type of picture file <"+$vsDocument+">"+<>sCR+"Supported types are JPG, PICT, GIF")
			Else 
				ALERT:C41("Error ("+String:C10($vlRes)+") reading file <"+$vsDocument+">")
		End case 
	End if 
	SET CURSOR:C469(0)
End if 
