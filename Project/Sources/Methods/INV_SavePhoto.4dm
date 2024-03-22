//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/29/06, 16:42:35
	// ----------------------------------------------------
	// Method: INV_SavePhoto
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM02
	// Modified by: Costas Manousakis-(Designer)-(5/6/16 15:20:34)
	Mods_2016_05_bug
	//  `changed picture to blob to use Mime  format instead of Quicktime  4 letter code
	// Modified by: Costas Manousakis-(Designer)-(3/20/17 13:06:07)
	Mods_2017_03
	//  `make sure photos are compressed
End if 
C_BOOLEAN:C305($1; $Prompt_b; $SavePhoto_b; $Modified_b)
If (Count parameters:C259=1)
	$Prompt_b:=$1
Else 
	$Prompt_b:=False:C215
End if 
$Modified_b:=(Modified record:C314([InventoryPhotos:113]) | vbPictureChanged)
If (($Prompt_b) & ($Modified_b))
	CONFIRM:C162("Save any changes made to this Photo?"; "Save"; "Don't Save")
	$SavePhoto_b:=(OK=1)
Else 
	$SavePhoto_b:=True:C214
End if 
If ($SavePhoto_b)
	
	If (Is new record:C668([InventoryPhotos:113]))
		LogNewRecord(->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2; "InventoryPhoto")
	End if 
	C_BOOLEAN:C305(vbPictureChanged)
	If (vbPictureChanged)
		C_PICTURE:C286($vPic1)
		C_LONGINT:C283($vlWidth; $vlHt; $vlThumbNlW)
		PICTURE PROPERTIES:C457(DE_InvPhoto; $vlWidth; $vlHt)
		$vlThumbNlW:=1024
		SHORT_MESSAGE("Adjusting Image size...")
		
		If ($vlWidth>$vlThumbNlW)
			C_LONGINT:C283($colordepth)  //Command Replaced was o_C_INTEGER
			$colordepth:=32  //full color for pictures
			CREATE THUMBNAIL:C679(DE_InvPhoto; $vPic1; $vlThumbNlW; Int:C8($vlHt*($vlThumbNlW/$vlWidth)); Scaled to fit:K6:2; $colordepth)
			PICTURE PROPERTIES:C457($vPic1; $vlWidth; $vlHt)
		Else 
			$vPic1:=DE_InvPhoto
		End if 
		
		$vPic1:=F_CompressPic($vPic1)
		If ((Picture size:C356($vPic1)<Picture size:C356(DE_InvPhoto)) & ($vlWidth>0))
			DE_InvPhoto:=$vPic1
		End if 
		CLOSE WINDOW:C154
		
		$vPic1:=$vPic1*0
		
		PICTURE TO BLOB:C692(DE_InvPhoto; [InventoryPhotos:113]InvPhoto_X:4; "image/jpeg")
		PushChange(2; ->[InventoryPhotos:113]InvPhoto_X:4)
	End if 
	FlushGrpChgs(2; ->[InventoryPhotoInsp:112]InvPhotoInspID_L:1; ->[InventoryPhotos:113]InvPhotoInsp_ID:2; ->[InventoryPhotos:113]InvPhoto_ID:1; 2)
	SAVE RECORD:C53([InventoryPhotos:113])
	//do this to make inv insp rec modified also
	[InventoryPhotoInsp:112]InvPhotoDate_D:3:=[InventoryPhotoInsp:112]InvPhotoDate_D:3
Else 
	UNLOAD RECORD:C212([InventoryPhotos:113])
End if 