If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 16:59:27      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($curr_recnum)
		$curr_recnum:=Selected record number:C246([CM_ExtTimeFYAlloc:111])
		arr_CM_FYFundAlloc_r{$curr_recnum}:=Self:C308->
		CM_FYFundRecalc
		If (CurrentFYFunds_R<0)
			ALERT:C41("No funds remaining for current FY! Try again!")
			Self:C308->:=Old:C35(Self:C308->)
			arr_CM_FYFundAlloc_r{$curr_recnum}:=Self:C308->
			CM_FYFundRecalc
			REJECT:C38(Self:C308->)
		Else 
			vCM_ExtTimFYFundChg_b:=True:C214
			If (<>CM_LogChanges_b)
				LogChanges(->[CM_ExtTimeFYAlloc:111]FYAmmount_R:3; ->[ExtendTime_Maintenance:98]EOT_ID:2; ->[CM_ExtTimeFYAlloc:111]EOT_ID_L:2; ->[CM_ExtTimeFYAlloc:111]ExtTimeFYAllocID_L:1; 2)
			End if 
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
