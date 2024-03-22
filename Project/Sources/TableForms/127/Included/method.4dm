// ----------------------------------------------------
// Form Method: Included
// User name (OS): cjmiller
// Date and time: 02/15/07, 13:57:20
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
Case of 
	: (Form event code:C388=On Display Detail:K2:22)
		QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=[Conslt_Name:127]CurrentStructureProjectMgr_l:4)
		If (Records in selection:C76([Personnel:42])=0)
			PRJ_CurrentPrjMgr_txt:=""
		Else 
			PRJ_CurrentPrjMgr_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		End if 
		
		If ([Conslt_Name:127]SQL_VendorID_l:3#0)
			OBJECT SET RGB COLORS:C628([Conslt_Name:127]ConsultantName_s:2; Col_paletteToRGB(Abs:C99(-(9))%256); Col_paletteToRGB(Abs:C99(-(9))\256))  // **Replaced o OBJECT SET COLOR([Conslt_Name]ConsultantName_s; -(9))
		Else 
			OBJECT SET RGB COLORS:C628([Conslt_Name:127]ConsultantName_s:2; Col_paletteToRGB(Abs:C99(-(15))%256); Col_paletteToRGB(Abs:C99(-(15))\256))  // **Replaced o OBJECT SET COLOR([Conslt_Name]ConsultantName_s; -(15))
		End if 
		If ([Conslt_Name:127]ConsultantNameID_l:1=[Conslt Address:77]ConsultantNameID_l:22)
			OBJECT SET RGB COLORS:C628([Conslt_Name:127]ConsultantNameID_l:1; Col_paletteToRGB(Abs:C99(-(9))%256); Col_paletteToRGB(Abs:C99(-(9))\256))  // **Replaced o OBJECT SET COLOR([Conslt_Name]ConsultantNameID_l; -(9))
		Else 
			OBJECT SET RGB COLORS:C628([Conslt_Name:127]ConsultantNameID_l:1; Col_paletteToRGB(Abs:C99(-(15))%256); Col_paletteToRGB(Abs:C99(-(15))\256))  // **Replaced o OBJECT SET COLOR([Conslt_Name]ConsultantNameID_l; -(15))
		End if 
End case 
//End Form Method: Included