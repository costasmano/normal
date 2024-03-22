// Method: [TIN_Insp_Images].PrintPhoto_rotate
// Description
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 02/25/21, 12:46:25
	// ----------------------------------------------------
	// First Release
	Mods_2021_02
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	
	OBJECT SET VISIBLE:C603(*; "MAC_@"; (<>PL_LPlatfrm=Mac OS:K25:2))
	OBJECT SET VISIBLE:C603(*; "WIN_@"; (<>PL_LPlatfrm=Windows:K25:3))
	
	vPicture1:=ut_RotatePicture_New(vPicture1; 270)
	
End if 