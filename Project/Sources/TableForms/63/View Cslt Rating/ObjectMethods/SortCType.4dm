If (False:C215)
	Mods_2010_09
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SET CURSOR:C469(4)
		C_LONGINT:C283($viNewValue)  //Command Replaced was o_C_INTEGER
		
		If ((vSortCType=0) | (vSortCType=2))
			ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]ContractType:48; >)
			$viNewValue:=1
		Else 
			ORDER BY:C49([Conslt Rating:63]; [Conslt Rating:63]ContractType:48; <)
			$viNewValue:=2
		End if 
		
		G_CSRTG_InitSortBtns
		vSortCType:=$viNewValue
		SET CURSOR:C469(0)
		REDRAW WINDOW:C456
End case 