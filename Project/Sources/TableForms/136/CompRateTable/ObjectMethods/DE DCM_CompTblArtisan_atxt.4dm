Case of 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Row_L)
		$Row_L:=DCM_CompTblArtisan_atxt
		C_TEXT:C284($newVal_txt)
		$newVal_txt:=DCM_CompTblArtisan_atxt{$Row_L}
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_CompTblArtisan_atxt))
			If ($loop_L#$Row_L)
				If ($newVal_txt=DCM_CompTblArtisan_atxt{$loop_L})
					DCM_CompTblArtisan_atxt{$Row_L}:=DCM_CompTblArtisan_atxt{$Row_L}+"-1"
					EDIT ITEM:C870(DCM_CompTblArtisan_atxt; $Row_L)
					$loop_L:=Size of array:C274(DCM_CompTblArtisan_atxt)+1
					ALERT:C41("Artisan : "+$newVal_txt+" already Exists!")
				End if 
				
			End if 
		End for 
		
End case 
