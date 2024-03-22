// ----------------------------------------------------
// Form Method: Match.i
// User name (OS): cjmiller
// Date and time: 02/15/07, 14:19:46
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
		
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantNameID_l:1=[Conslt Address:77]ConsultantNameID_l:22)
		If ([Conslt_Name:127]SQL_VendorID_l:3#0)
			OBJECT SET RGB COLORS:C628([Conslt Address:77]ConsultantNameID_l:22; Col_paletteToRGB(Abs:C99(-(9+(256*12)))%256); Col_paletteToRGB(Abs:C99(-(9+(256*12)))\256))  // **Replaced o OBJECT SET COLOR([Conslt Address]ConsultantNameID_l; -(9+(256*12)))
		Else 
			OBJECT SET RGB COLORS:C628([Conslt Address:77]ConsultantNameID_l:22; Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)%256); Col_paletteToRGB(Abs:C99(<>PRJ_Color_Not_editable)\256))  // **Replaced o OBJECT SET COLOR([Conslt Address]ConsultantNameID_l; <>PRJ_Color_Not_editable)
		End if 
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=Substring:C12([Conslt Address:77]ConsltName:2; 1; 1)+"@")
		vCompanyName:=""
		
		
	: (Form event code:C388=On Unload:K2:2)
		USE NAMED SELECTION:C332("AddressUserSel")
		CLEAR NAMED SELECTION:C333("AddressUserSel")
		COPY SET:C600("AddressUserSet"; "UserSet")
		CLEAR SET:C117("AddressUserSet")
		HIGHLIGHT RECORDS:C656
End case 
//End Form Method: Match.i