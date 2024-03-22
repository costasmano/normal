If (False:C215)
	//[Bridge MHD NBIS];"SI & A Input"
	//Popupmenu for Item 65
	// Modified by: Costas Manousakis-(Designer)-(2022-03-30 12:18:10)
	Mods_2022_03
	//  `use method SIA_Item63_65_OM
End if 

SIA_Item63_65_OM(->aIRatMethD_; ->aIRatMeth_; ->[Bridge MHD NBIS:1]Item 65:200; ->[Bridge MHD NBIS:1]Item66:139; ->vsInvRtgUnit)
//If (False)
//POPUPMENUC (->aIRatMethD_;->aIRatMeth_;->[Bridge MHD NBIS]Item 65)
//Case of 
//: (Form event code=On Clicked)
//PushChange (1;->[Bridge MHD NBIS]Item 65)
//End case 
//C_TEXT(vsInvRtgUnit)  // Command Replaced was o_C_STRING length was 8
//G_FormatItm6466 (->[Bridge MHD NBIS]Item 65;->[Bridge MHD NBIS]Item66;->vsInvRtgUnit)
//End if 
