If (False:C215)
	Mods_2005_CM02
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		C_LONGINT:C283($viNewValue)  //Command Replaced was o_C_INTEGER
		If ((vSortItem6=0) | (vSortItem6=2))
			ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]Item6A:63; >)
			$viNewValue:=1
		Else 
			ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]Item6A:63; <)
			$viNewValue:=2
		End if 
		
		G_CSRTG_InitSortBtns
		vSortItem6:=$viNewValue
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 