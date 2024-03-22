//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/28/06, 14:56:28
	// ----------------------------------------------------
	// Method: INV_PrintInvInsp
	// Description
	// Print Inventory Photo Inspection
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM02
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:42:01)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/3/09 11:30:31)
	Mods_2009_10("MASSDOT")
	//Added INSP_Item8_s var and adjust it according to inspection date
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(9/30/15 16:23:15)
	Mods_2015_09_bug
	//  `initialize vPicture1 to a blank picture also.
	// Modified by: Costas Manousakis-(Designer)-(9/2/20 13:55:21)
	Mods_2020_09_bug
	//  `initialization of vPicture1 was commented out? removed comment
End if 
C_BOOLEAN:C305($1; $ByPassSettings_b)
If (Count parameters:C259=1)
	$ByPassSettings_b:=$1
Else 
	$ByPassSettings_b:=False:C215
End if 

C_LONGINT:C283($vNumPhotos; $i; $Ht)
C_PICTURE:C286(vPicture1; vPicture2)
C_TEXT:C284(vTitle1; vTitle2)
C_TEXT:C284(vPhotoNum1; vPhotoNum2)  // Command Replaced was o_C_STRING length was 255
C_PICTURE:C286($MyEmptyPicture)
C_BOOLEAN:C305($bPortrait)
C_LONGINT:C283(viInspPreviewErr; vPageNo; vTotalPages)  //Command Replaced was o_C_INTEGER//Initialize our Print Error var and others
viInspPreviewErr:=0  //initialize Error
C_TEXT:C284(sBDEPT; sBDEPT_P; sTOWN; sInspDATE; INSP_Item8_s)  // Command Replaced was o_C_STRING length was 80
$vNumPhotos:=Records in selection:C76([InventoryPhotos:113])
G_SIA_BuildTownLine
sTOWN:=Uppercase:C13(sTOWN)
sInspDATE:=Uppercase:C13(String:C10([InventoryPhotoInsp:112]InvPhotoDate_D:3; Internal date abbreviated:K1:6))
sInspDATE:=Substring:C12(sInspDATE; 1; 3)+" "+Substring:C12(sInspDATE; (Length:C16(sInspDATE)-4))
If ([InventoryPhotoInsp:112]InvPhotoDate_D:3>=!2009-11-01!)
	INSP_Item8_s:=[Bridge MHD NBIS:1]Item8:206
Else 
	If ([Bridge MHD NBIS:1]LegacyOwner:226#"")
		INSP_Item8_s:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3+[Bridge MHD NBIS:1]LegacyOwner:226+[Bridge MHD NBIS:1]Item8 BridgeCat:207
	Else 
		INSP_Item8_s:=[Bridge MHD NBIS:1]Item8:206
	End if 
End if 

vPageNo:=0  //start from zero - increment in loop
If (Not:C34($ByPassSettings_b))
	
	G_PrintOptions
	
	If (<>ShowPrint)
		PRINT SETTINGS:C106
	End if 
	
End if 
If ((OK=1) | ($ByPassSettings_b))
	ON ERR CALL:C155("G_PrintError")  //Set error handler for quiting from Preview
	G_PrintOptions
	C_TEXT:C284($CurrPrinter)
	$CurrPrinter:=Get current printer:C788
	//SET PRINT OPTION(Spooler document name option ;"InvPhoto-"+[InventoryPhotoInsp]BIN+"-"+String([InventoryPhotoInsp]InvPhotoDate_D))
	// Print the photos
	vTotalPages:=($vNumPhotos\2)+($vNumPhotos%2)
	FIRST RECORD:C50([InventoryPhotos:113])
	vPage2Title:="INVENTORY PHOTOS"
	For ($i; 1; $vNumPhotos)
		vTitle2:=""
		vPhotoNum2:=""
		vPicture2:=$MyEmptyPicture*0
		vPicture1:=$MyEmptyPicture*0
		BLOB TO PICTURE:C682([InventoryPhotos:113]InvPhoto_X:4; vPicture1)
		vTitle1:=[InventoryPhotos:113]PhotoDescr_txt:3
		vPhotoNum1:=""
		If ($i<$vNumPhotos)
			NEXT RECORD:C51([InventoryPhotos:113])
			BLOB TO PICTURE:C682([InventoryPhotos:113]InvPhoto_X:4; vPicture2)
			vTitle2:=[InventoryPhotos:113]PhotoDescr_txt:3
			$i:=$i+1
			vPhotoNum2:=""
		End if 
		vPageNo:=vPageNo+1
		PAGE BREAK:C6(>)
		If (viInspPreviewErr=0)
			$Ht:=Print form:C5([InventoryPhotoInsp:112]; "PrintForm")
		Else 
			$i:=$vNumPhotos+1  //exit loop
		End if 
		If ($i<$vNumPhotos)
			NEXT RECORD:C51([InventoryPhotos:113])
		End if 
	End for 
	//chng.2007..
	If ($ByPassSettings_b)
		//PAGE BREAK(>)
	Else 
		PAGE BREAK:C6  //spool the print job
	End if 
	//End change  `chng.2007..
	
End if 
ON ERR CALL:C155("")  //reset the error handler
//Blank the picture variables  
vPicture2:=$MyEmptyPicture*0
vPicture1:=$MyEmptyPicture*0
vTitle1:=""
vTitle2:=""