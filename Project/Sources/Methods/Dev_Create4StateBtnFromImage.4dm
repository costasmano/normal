//%attributes = {"invisible":true}
//Method: Dev_Create4StateBtnFromImage
//Description
// Create a 4 State button from image file. 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/21/20, 15:10:04
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
End if 
//
C_PICTURE:C286($source_pic; $Btn_pic)
C_TEXT:C284($SourceFile; $btnFile)
ARRAY TEXT:C222($Files_atxt; 0)
$SourceFile:=Select document:C905(""; ""; "Choose image to make a button from"; 0; $Files_atxt)

If (OK=1)
	$SourceFile:=$Files_atxt{1}
	READ PICTURE FILE:C678($SourceFile; $source_pic)
	$Btn_pic:=Make4StateButton($source_pic)
	$btnFile:=GetFileExtension($SourceFile)
	$btnFile:=Select document:C905(""; ""; "Choose file to save the button"; File name entry:K24:17; $Files_atxt)
	
	If (OK=1)
		C_TIME:C306($btn_f)
		$btn_f:=Create document:C266($Files_atxt{1})
		CLOSE DOCUMENT:C267($btn_f)
		WRITE PICTURE FILE:C680($Files_atxt{1}; $Btn_pic; "image/png")  // save as svg
	End if 
	
End if 

//End Dev_Create4StateBtnFromImage