If (False:C215)
	//LO: [Inspections];"Culvert Pr Pg 2"
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	
	// Modified by: costasmanousakis-(Designer)-(11/10/2006 20:51:49)
	Mods_2007_CM04
	// Modified by: Costas Manousakis-(Designer)-(9/25/18 12:56:16)
	Mods_2018_09_bug
	//  `added code to scale the preview picture so that width fits object.
	// Modified by: Costas Manousakis-(Designer)-(1/23/19 10:18:21)
	Mods_2019_01_bug
	//  `use method INSP_FitPictToFormObj - created due to CallReference #600
End if 
Case of 
		
	: (Form event code:C388=On Header:K2:17)
		
	: (Form event code:C388=On Printing Detail:K2:18)
		FORM_FixHairLine
		vPageNo:=vPageNo+1  //need to calculate this even though it is not used.
		//Set Doc Margins (vCMtsAreaCul;4.1)
		//  //WR INSERT STYLED TEXT (vCmtsAreaCul;vCmtsAreaCul_)
		//  //adjust width of picture to fit
		INSP_FitPictToFormObj("CommentsPreview"; ->CommentsPrevw_P)
		
End case 
