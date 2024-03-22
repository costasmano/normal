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
	// Modified by: Costas Manousakis-(Designer)-(4/26/18 16:45:15)
	Mods_2018_04_bug
	//  `allow adding inspections only for Boat sections (BTS) up to NTI_DROPBINBTSINSPDATE
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "Add New TunnelInsp@"; False:C215)
		
		If ((User in group:C338(<>CurrentUser_Name; "MHDInspectionRWAccess") & BRG_RWAccess) | (<>CurrentUser_Name="Designer"))
			C_DATE:C307($NTI_DROPBINBTSINSPDATE)
			C_TEXT:C284($NTI_DROPBINBTSINSPDATE_txt)
			$NTI_DROPBINBTSINSPDATE_txt:=ut_GetSysParameter("NTI_DROPBINBTSINSPDA"; ""; "VALUE")
			$NTI_DROPBINBTSINSPDATE:=Date:C102($NTI_DROPBINBTSINSPDATE_txt)
			If (([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS") & (Current date:C33(*)<=$NTI_DROPBINBTSINSPDATE))
				OBJECT SET VISIBLE:C603(*; "Add New TunnelInsp@"; True:C214)
			End if 
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		TNL_AddInspection
		
End case 