//%attributes = {"invisible":true}
//Method: DEV_Create4StateBtnFromLibPic
//Description
// Create a 4 State button from a picture in library
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jun 23, 2022, 17:10:56
	Mods_2022_06
	// ----------------------------------------------------
	
	// Modified by: ManousakisC (7/19/2022)
	
	Mods_2022_09_bug
	//use the pic name instead of pic ID to get the picture from the library
End if 
//
C_PICTURE:C286($libPic)
C_LONGINT:C283($picRef)
ARRAY LONGINT:C221($picRefs; 0)
ARRAY TEXT:C222($picNames; 0)
PICTURE LIBRARY LIST:C564($picRefs; $picNames)
SORT ARRAY:C229($picNames; $picRefs)

C_LONGINT:C283($pic_L)
C_TEXT:C284($btnFileName)
C_TIME:C306($btnFile)

Repeat 
	$pic_L:=G_PickFromList(->$picNames; "Choose a lib picture")
	
	If ($pic_L>0)
		$picRef:=$picRefs{$pic_L}
		GET PICTURE FROM LIBRARY:C565($picNames{$pic_L}; $libPic)
		
		If (OK=1)
			C_PICTURE:C286($btn)
			$btn:=Make4StateButton($libPic)
			$btnFileName:=Select document:C905($picNames{$pic_L}; "png"; "Choose file to save button image"; File name entry:K24:17)
			
			If (Ok=1)
				$btnFile:=Create document:C266(Document)
				CLOSE DOCUMENT:C267($btnFile)
				WRITE PICTURE FILE:C680(Document; $btn; "image/png")
				SHOW ON DISK:C922(Document)
			End if 
			
			
		End if 
		
	End if 
	
Until ($pic_L<=0)


//End DEV_Create4StateBtnFromLibPic   