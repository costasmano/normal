Case of 
	: (FORM Get current page:C276=1)
		C_LONGINT:C283($k; $i)  //Command Replaced was o_C_INTEGER
		$k:=Size of array:C274(apChkItemVars_1)
		For ($i; 1; $k)
			apChkItemVars_1{$i}->:=1
		End for 
		
	: (FORM Get current page:C276=2)
		C_LONGINT:C283($k; $i)  //Command Replaced was o_C_INTEGER
		$k:=Size of array:C274(apChkItemVars_2)
		For ($i; 1; $k)
			apChkItemVars_2{$i}->:=1
		End for 
End case 