If (False:C215)
	Mods_2006_CMz1
	Mods_2011_06  // CJ Miller`06/20/11, 11:34:17      ` Type all local variables for v11
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($endFY; $prevFY)  //Command Replaced was o_C_INTEGER
		$endFY:=F_FiscalYear(Self:C308->)
		C_LONGINT:C283($NumCurrFYs)
		$NumCurrFYs:=Size of array:C274(arr_CM_FYAlloc_I)
		Case of 
			: ($NumCurrFYs=0)
				CM_AddExtTimeFYAlloc
				CM_DisplayFYFunds
				CM_FYFundRecalc
				vCM_ExtTimFYFundChg_b:=True:C214
			: ($NumCurrFYs>0)
				If (arr_CM_FYAlloc_I{$NumCurrFYs}#$endFY)
					CM_AddExtTimeFYAlloc
					CM_DisplayFYFunds
					CM_FYFundRecalc
					vCM_ExtTimFYFundChg_b:=True:C214
				End if 
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
