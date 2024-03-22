If (False:C215)
	//[Bridge MHD NBIS];"CombinedInspections".bAddInsp
	//Add button to included layout
	// Modified by: costasmanousakis-(Designer)-(12/12/07 16:40:08)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(4/16/08 08:43:07)
	Mods_2008_CM_5403  // add call to BRG_RWAccess
	// Modified by: costasmanousakis-(Designer)-(11/1/11 14:52:24)
	Mods_2011_11
	//  `USe global var ◊CurrentUser_Name
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If ((User in group:C338(<>CurrentUser_Name; "MHDInspectionRWAccess") & BRG_RWAccess) | (<>CurrentUser_Name="Designer"))
			OBJECT SET VISIBLE:C603(*; "Add New Insp Button@"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "Add New Insp Button@"; False:C215)
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		ADD_COMBINED_INSPECT
End case 