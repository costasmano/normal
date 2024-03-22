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