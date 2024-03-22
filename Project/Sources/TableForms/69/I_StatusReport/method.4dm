If (False:C215)
	//LP: I_StatusReport
	
	// modified 2-nov-2000 : CM
	//    added check for DEM bridges to avoid case if number of DEM total = 0
	// modified 1-FEB-2001 : CM
	//    added check for DNR bridges to avoid case if number of DNR total = 0
	// modified FEB-2002 : CM
	//    Call Method PrepReportTotal instead of code in here.
	
	Mods_2005_CM03
	// Modified by: costasmanousakis-(Designer)-(3/1/2006 10:25:30)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(3/2/2007 16:12:39)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(11/1/09 08:46:21)
	Mods_2009_10("MASSDOT")
	//  `Made form changes to add District 6 and change the logo; also 
	//  `changed the delete button to invis when not allowed to delete
	// Modified by: costasmanousakis-(Designer)-(4/22/10 08:43:21)
	Mods_2010_04
	//  `added the MHD logo to indicate whether it is a legacy report or not
	//  `uses the STATREP_ReportType for that
	// Modified by: Costas Manousakis-(Designer)-(3/13/13 15:11:55)
	Mods_2013_03
	//  `Added 4 pages for the new metrics by bridge deck area
	// Modified by: Costas Manousakis-(Designer)-(5/15/18 17:33:12)
	Mods_2018_05
	//  `added on page 4 the new fields indicating the calculation methods - not enterable
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "ReadWrite"))
			If (Current user:C182="Designer")
				OBJECT SET ENABLED:C1123(bzDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENTERABLE:C238([Status Report:69]Comments:135; True:C214)
			Else 
				If (Current user:C182=[Status Report:69]Owner:2)
					OBJECT SET ENABLED:C1123(bzDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
					OBJECT SET ENTERABLE:C238([Status Report:69]Comments:135; True:C214)
				Else 
					OBJECT SET ENTERABLE:C238([Status Report:69]Comments:135; False:C215)
					OBJECT SET VISIBLE:C603(bzDelete; False:C215)
					OBJECT SET VISIBLE:C603(*; "Delete@"; False:C215)
				End if 
				
			End if 
			
		Else 
			OBJECT SET VISIBLE:C603(bzDelete; False:C215)
			OBJECT SET VISIBLE:C603(*; "Delete@"; False:C215)
			OBJECT SET ENTERABLE:C238([Status Report:69]Comments:135; False:C215)
		End if 
		C_BOOLEAN:C305($legacy_b)
		$legacy_b:=(STATREP_ReportType="@Legacy@")
		OBJECT SET VISIBLE:C603(*; "PictLogo_MHD"; $legacy_b)
		OBJECT SET VISIBLE:C603(*; "PictLogo_DOT"; Not:C34($legacy_b))
		OBJECT SET TITLE:C194(*; "CalcDescription"; STATREP_DistrictMethod([Status Report:69]DistrictMethod_L:267%100)+" "+STATREP_BridgesSelected([Status Report:69]DistrictMethod_L:267\100))
		PrepStatusRep
End case 