//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 63
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
	// Modified by: Costas Manousakis-(Designer)-(2022-03-30 12:16:42)
	Mods_2022_03
	//  `use method SIA_Item63_65_OM
End if 
C_TEXT:C284(vsOperRtgUnit)  // Command Replaced was o_C_STRING length was 8
SIA_Item63_65_OM(->aORatMethD_; ->aORatMeth_; ->[Bridge MHD NBIS:1]Item 63:199; ->[Bridge MHD NBIS:1]Item64:137; ->vsOperRtgUnit)
//If (False)
//POPUPMENUC (->aORatMethD_;->aORatMeth_;->[Bridge MHD NBIS]Item 63)
//C_REAL($maxValue_r)
//OBJECT GET MAXIMUM VALUE([Bridge MHD NBIS]Item64;$maxValue_r)
//If (Form event code=On Clicked)
//If (Old([Bridge MHD NBIS]Item 63)#[Bridge MHD NBIS]Item 63)
//PushChange (1;->[Bridge MHD NBIS]Item 63)
//End if 
//If (Position($vpItm65fld->;<>SIA_LoadRtg_63_RF_txt)>0)
//  //selected rating factor- check if rating field is more than 3.
//If ([Bridge MHD NBIS]Item64>3)
//ALERT("Current value of Item 64 is greater than 3.0! Value is changed to 3.0!")
//[Bridge MHD NBIS]Item64:=3
//PushChange (1;->[Bridge MHD NBIS]Item64)
//End if 
//End if 
//End if 
//G_FormatItm6466 (->[Bridge MHD NBIS]Item 63;->[Bridge MHD NBIS]Item64;->vsOperRtgUnit)

//End if 
