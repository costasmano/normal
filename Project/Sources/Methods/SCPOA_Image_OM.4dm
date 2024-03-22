//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/09, 16:40:06
	// ----------------------------------------------------
	// Method: SCPOA_Image_OM
	// Description
	// 
	// 
	// Parameters
	// $1 
	// ----------------------------------------------------
	
	Mods_2009_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283($formevent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formevent:=$1
Else 
	$formevent:=Form event code:C388
	
End if 
C_BOOLEAN:C305(vbPictureChanged)
Case of 
	: ($formevent=On Load:K2:1)
		C_PICTURE:C286(SCPOA_Image)
		SCPOA_Image:=SCPOA_Image*0
		
		If (BLOB size:C605([ScourPOA_Images:134]Image_x:3)>0)
			BLOB TO PICTURE:C682([ScourPOA_Images:134]Image_x:3; SCPOA_Image)
		End if 
		C_TEXT:C284(vPictStats)
		C_LONGINT:C283($vPicHoff; $vPicVoff; $vPicmode; $vPicW; $vPicH)
		PICTURE PROPERTIES:C457(SCPOA_Image; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356(SCPOA_Image); "##,###,### Bytes")+")"
		vbPictureChanged:=False:C215
	: (($formevent=On Data Change:K2:15) | ($formevent=On After Edit:K2:43))
		//PICTURE TO BLOB(SCPOA_Image;[InventoryPhotos]InvPhoto;"jpeg")
		PICTURE PROPERTIES:C457(SCPOA_Image; $vPicW; $vPicH; $vPicHoff; $vPicVoff; $vPicmode)
		vbPictureChanged:=True:C214
		vPictStats:=String:C10($vPicW)+"x"+String:C10($vPicH)+<>sCR
		vPictStats:=vPictStats+"("+String:C10(Picture size:C356(SCPOA_Image); "##,###,### Bytes")+")"
		
End case 