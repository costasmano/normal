If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/23/07, 14:29:47
	// ----------------------------------------------------
	// Method: Object Method: TemplateName
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 14:29:52)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/24/11 17:19:32)
	Mods_2011_06
	// Modified by: costasmanousakis-(Designer)-(10/5/11 11:39:38)
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(2023-12-15 12:08:36)
	Mods_2023_12
	//  `added case for WRP or WPT name (Write Pro) ; also alert if the name prefix is not correct
End if 
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	
	Case of 
		: (Self:C308->="WRT@")
			FORM GOTO PAGE:C247(1)
			OBJECT SET VISIBLE:C603(*; "WRT_Template"; True:C214)
		: (Self:C308->="QRT_@")
			FORM GOTO PAGE:C247(2)
			OBJECT SET VISIBLE:C603(*; "QRT_Template"; True:C214)
		: (Self:C308->="IMG_@")
			FORM GOTO PAGE:C247(3)
			OBJECT SET VISIBLE:C603(*; "IMG_Template"; True:C214)
		: (Self:C308->="CRT_@")
			FORM GOTO PAGE:C247(4)
			OBJECT SET VISIBLE:C603(*; "CHART_Template"; True:C214)
		: (Self:C308->="DOC_@")
			FORM GOTO PAGE:C247(5)
		: (Self:C308->="LST_@")
			FORM GOTO PAGE:C247(6)
			OBJECT SET VISIBLE:C603(*; "TMPL_HList_L"; True:C214)
			
			// start of Mods_2023_12
		: (Self:C308->="WRP@") | (Self:C308->="WPT@")
			FORM GOTO PAGE:C247(7)
		Else 
			ALERT:C41("Unknown template identifier! Template name must start with one of :\n"+\
				"QRT_ : Quick report\n"+\
				"IMG_ : Image\n"+\
				"LST_ : H List\n"+\
				"DOC_ : a document\n"+\
				"WRP or WPT : 4D Write Pro")
			
			// end of Mods_2023_12
			
	End case 
End if 