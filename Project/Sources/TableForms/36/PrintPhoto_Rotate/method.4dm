//Method: [Standard Photos].PrintPhotoPortrait_rotate
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/24/20, 13:11:19
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12
	// Modified by: Costas Manousakis-(Designer)-(2/18/21 18:52:02)
	Mods_2021_02
	//  `Had to create two sets of labels because on Windows the labels were shifted down the page.
End if 
//
If (Form event code:C388=On Printing Detail:K2:18)
	
	OBJECT SET VISIBLE:C603(*; "MAC_@"; (<>PL_LPlatfrm=Mac OS:K25:2))
	OBJECT SET VISIBLE:C603(*; "WIN_@"; (<>PL_LPlatfrm=Windows:K25:3))
	
	vPicture1:=ut_RotatePicture_New(vPicture1; 270)
	
End if 
//End [Standard Photos].PrintPhotoPortrait_rotate