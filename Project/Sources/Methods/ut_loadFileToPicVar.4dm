//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/09, 08:39:47
	// ----------------------------------------------------
	// Method: ut_loadFileToPicVar
	// Description
	// Load a document to a picture variable
	// 
	// Parameters
	// $0 : $PictChanged
	// $1 : $PicVarPtr
	// $2 : $PicStatsVarPtr (Optional)
	// ----------------------------------------------------
	
	Mods_2009_05
End if 
C_BOOLEAN:C305($0; $PictChanged)
C_POINTER:C301($1; $PicVarPtr)
$PicVarPtr:=$1

C_TIME:C306($vRef)
C_TEXT:C284($vsDocument)
C_LONGINT:C283($vlRes)
$vRef:=Open document:C264("")
C_BOOLEAN:C305($PictChanged)
$PictChanged:=False:C215
If (OK=1)
	$vsDocument:=Document  //store it - Read Pic File clears it if error
	CLOSE DOCUMENT:C267($vRef)
	SET CURSOR:C469(4)
	C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode; $res)
	READ PICTURE FILE:C678($vsDocument; $PicVarPtr->)
	$vlRes:=1-OK
	
	If ($vlRes=0)
		$PictChanged:=True:C214
		//REDRAW($PicVarPtr->)
		If (Count parameters:C259>1)
			C_POINTER:C301($2; $PicStatsVarPtr)
			$PicStatsVarPtr:=$2
			PICTURE PROPERTIES:C457($PicVarPtr->; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
			$PicStatsVarPtr->:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
			$PicStatsVarPtr->:=$PicStatsVarPtr->+"("+String:C10(Picture size:C356($PicVarPtr->); "##,###,### Bytes")+")"
			
		End if 
		
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

$0:=$PictChanged
