If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Administrator
	// Date and time: 08/29/05, 11:14:21
	// ----------------------------------------------------
	// Method: Form Method: "Inspectors Out"
	// Description
	//  
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM16
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(6/5/2006 16:46:41)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(10/7/08 11:54:52)
	Mods_2008_CM_5404  // ("ACCESS")
	// Modified by: Costas Manousakis-(Designer)-(6/7/13 09:23:18)
	Mods_2013_06
	//  `changed object sizes ,fonts, form headers, ftr break for better viewing
	// Modified by: Costas Manousakis-(Designer)-(7/6/17 14:57:49)
	Mods_2017_07_bug
	//  `changed fields to be not-transparent, and made background same color as the rect behind.
	//  //(If transparent there was no row hilighting)
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "ReadOnly"))
			OBJECT SET VISIBLE:C603(bzAdd; False:C215)
		End if 
		
	: (Form event code:C388=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: (Form event code:C388=On Activate:K2:9)
		UpdatFilesPalet
	: (Form event code:C388=On Deactivate:K2:10)
		UpdatFilesPalet
		//REDRAW(◊asWindows)
End case 
