If (False:C215)
	Mods_2005_CM02
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		C_LONGINT:C283($viNewValue)  //Command Replaced was o_C_INTEGER
		If ((vSortAssign=0) | (vSortAssign=2))
			ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]AssignStatus:43; >)
			$viNewValue:=1
		Else 
			ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]AssignStatus:43; <)
			$viNewValue:=2
		End if 
		
		G_CSRTG_InitSortBtns
		vSortAssign:=$viNewValue
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 