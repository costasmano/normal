Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Col_L; $Row_L)
		LISTBOX GET CELL POSITION:C971(DCM_CompTBLDates_ab; $Col_L; $Row_L)
		C_POINTER:C301($Reg_ptr)
		$Reg_ptr:=Get pointer:C304("DCM_CompTblREG_"+String:C10($Col_L)+"_ar")
		$Col_L:=($Col_L-1)*2+3
		
		LISTBOX SELECT ROW:C912(DCM_CompTBLDates_ab; 0; lk remove from selection:K53:3)
		
		EDIT ITEM:C870($Reg_ptr->; 1)
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
