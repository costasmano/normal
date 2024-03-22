If (False:C215)
	//Object Method: [LSS_Inventory].CustomSearch.aTownName_ 
	// Modified by: Costas Manousakis-(Designer)-(1/28/16 21:03:04)
	Mods_2016_01_bug
	//  `replaced LSS_Townname_atxt , etc with global variables ◊aTownName, ◊aBDEPT, ◊aDistrict
End if 

If (aTownName_>0)
	C_LONGINT:C283($twnindx_L)
	$twnindx_L:=Find in array:C230(<>aTownName; aTownName_{aTownName_})
	LSS_SearchTwnCode_txt:=<>aBDEPT{$twnindx_L}
	LSS_SearchDistr_aL:=1+Num:C11(<>aDistrict{$twnindx_L})
End if 