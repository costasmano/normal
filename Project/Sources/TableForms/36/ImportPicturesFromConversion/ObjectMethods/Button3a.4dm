
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 05/11/17, 13:10:22
//----------------------------------------------------
//Method: [Standard Photos].ImportPicturesFromConversion.Button2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_05  //
	
	
	//Modified by: Chuck Miller (5/11/17 13:10:23)
	
End if 


C_LONGINT:C283($Column_l; $Row_l)
LISTBOX GET CELL POSITION:C971(*; "PictureList"; $Column_l; $Row_l)
If ($Row_l>0) & ($Row_l<=Size of array:C274(PictureList_atxt))
	C_TEXT:C284($picturePath_txt)
	$picturePath_txt:=ConvertedPicturePath_txt+Substring:C12(PictureList_atxt{$Row_l}; 1; Position:C15(" "; PictureList_atxt{$Row_l})-1)
	If (Position:C15("PDF"; PictureList_atxt{$Row_l})>0)
		CONFIRM:C162("Open with "; "Preview"; "Adobe Reader")
		If (OK=1)
			OPEN URL:C673($picturePath_txt; "Preview")
		Else 
			OPEN URL:C673($picturePath_txt; "Adobe Reader")
		End if 
	Else 
		
		OPEN URL:C673($picturePath_txt; "Preview")
	End if 
End if 

//End [Standard Photos].ImportPicturesFromConversion.Button2

