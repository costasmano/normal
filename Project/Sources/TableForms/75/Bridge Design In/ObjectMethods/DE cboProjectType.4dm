If (False:C215)
	// Method: Object Method: cboProjectType
	
	// Modified by: costasmanousakis-(Designer)-(11/28/2005 16:37:16)
	Mods_2005_CM19
	Mods_2007_CM08
	// Modified by: costasmanousakis-(Designer)-(8/8/2007 12:41:44)
	Mods_2007_CM12_5301
End if 
POPUPMENUC(Self:C308; Self:C308; ->[Bridge Design:75]ProjectType:7)

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Self:C308->>0)
		Else 
			C_TEXT:C284(BRDES_ProjType_txt)
			BRDES_ProjType_txt:=Replace string:C233([Bridge Design:75]ProjectType:7; "-"; " - ")
			BRDES_ProjType_txt:=Replace string:C233(BRDES_ProjType_txt; "Pre - Eng"; "Pre-Eng")
			POPUPMENUC(Self:C308; Self:C308; ->BRDES_ProjType_txt)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		PushChange(1; ->[Bridge Design:75]ProjectType:7)
End case 
