//known variable = salary
C_REAL:C285($temp)
If (False:C215)
	$temp:=Round:C94([Contract_Maintenance:97]InitContractSalary:13*([Contract_Maintenance:97]OverheadRate:10/100+1)*([Contract_Maintenance:97]NetFeeRate:11/100+1); 2)
	If (Dec:C9($temp)=0.99)
		[Contract_Maintenance:97]InitContractTotalLimitFee:14:=Round:C94($temp; 0)
	Else 
		[Contract_Maintenance:97]InitContractTotalLimitFee:14:=$temp
	End if 
End if 

[Contract_Maintenance:97]InitContractTotal:12:=[Contract_Maintenance:97]InitContractTotalLimitFee:14+[Contract_Maintenance:97]InitContractTotDirctExpense:15

C_REAL:C285($additionalFund)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$additionalFund:=0

RELATE MANY:C262([Contract_Maintenance:97])
FIRST RECORD:C50([AddFund_Maintenance:99])

For ($i; 1; Records in selection:C76([AddFund_Maintenance:99]))
	$additionalFund:=$additionalFund+[AddFund_Maintenance:99]Total:8
	NEXT RECORD:C51([AddFund_Maintenance:99])
End for 

[Contract_Maintenance:97]TotalEncumbered:16:=[Contract_Maintenance:97]InitContractTotal:12+$additionalFund
[Contract_Maintenance:97]ActualRemainingFund:20:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ActualSpent:18
[Contract_Maintenance:97]ApproxRemainingFund:19:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ApproxSpent:17

G_MaintenanceCheckNegative
G_MaintenanceCalculateTLFandDE
