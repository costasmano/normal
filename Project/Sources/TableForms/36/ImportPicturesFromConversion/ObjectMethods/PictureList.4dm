
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 05/09/17, 12:38:01
//----------------------------------------------------
//Method: [Standard Photos].ImportPicturesFromConversion.List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_05  //Add code to allow for re-import of converted pictures
	//Modified by: Chuck Miller (5/9/17 12:38:04)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		CLEAR VARIABLE:C89(vPicture1)
		CLEAR VARIABLE:C89(vPicture2)
		OBJECT SET VISIBLE:C603(*; "Button"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Button3@"; False:C215)
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Column_l; $Row_l)
		LISTBOX GET CELL POSITION:C971(*; "PictureList"; $Column_l; $Row_l)
		If ($Row_l>0) & ($Row_l<=Size of array:C274(PictureList_atxt))
			C_LONGINT:C283($vPicW; $vPicH; $vPicHoff; $vPicVoff)
			C_PICTURE:C286(vPicture1)
			C_TEXT:C284($picturePath_txt)
			$picturePath_txt:=ConvertedPicturePath_txt+Substring:C12(PictureList_atxt{$Row_l}; 1; Position:C15(" "; PictureList_atxt{$Row_l})-1)
			READ PICTURE FILE:C678($picturePath_txt; vPicture1)
			PICTURE PROPERTIES:C457(vPicture1; $vPicW; $vPicH; $vPicHoff; $vPicVoff)
			OBJECT SET VISIBLE:C603(*; "Button"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Button3@"; True:C214)
			
			
			C_TEXT:C284($Picturesareequal_txt)
			
			If (Equal pictures:C1196(vPicture1; [Standard Photos:36]Std Photo:3; vPicture2))
				$Picturesareequal_txt:="Pictures are the same!"
			Else 
				$Picturesareequal_txt:=""
			End if 
			OBJECT SET TITLE:C194(*; "PictureStats"; String:C10($vPicW)+"x"+String:C10($vPicH)+Char:C90(Carriage return:K15:38)+"("+String:C10(Picture size:C356(vPicture1); "##,###,### Bytes")+")"+Char:C90(Carriage return:K15:38)+$Picturesareequal_txt)
		Else 
			OBJECT SET VISIBLE:C603(*; "Button3@"; False:C215)
			
			CLEAR VARIABLE:C89(vPicture1)
			CLEAR VARIABLE:C89(vPicture2)
			
			OBJECT SET VISIBLE:C603(*; "Button"; False:C215)
			OBJECT SET TITLE:C194(*; "PictureStats"; "")
		End if 
End case 
//End [Standard Photos].ImportPicturesFromConversion.List Box

