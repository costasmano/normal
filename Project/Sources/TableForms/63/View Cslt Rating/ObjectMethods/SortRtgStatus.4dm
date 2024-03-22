If (False:C215)
	Mods_2007_CM07
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		C_LONGINT:C283($viNewValue)  //Command Replaced was o_C_INTEGER
		If ((vSortRtgStat=0) | (vSortRtgStat=2))
			ORDER BY FORMULA:C300([Conslt Rating:63]; CRTG_RatingStatus; >)
			$viNewValue:=1
		Else 
			ORDER BY FORMULA:C300([Conslt Rating:63]; CRTG_RatingStatus; <)
			$viNewValue:=2
		End if 
		
		G_CSRTG_InitSortBtns
		vSortRtgStat:=$viNewValue
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 