C_REAL:C285($additionalFund)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
$additionalFund:=0

RELATE MANY:C262([Contracts:79])
FIRST RECORD:C50([Contract AddFund:82])

For ($i; 1; Records in selection:C76([Contract AddFund:82]))
	$additionalFund:=$additionalFund+[Contract AddFund:82]Total:8
	NEXT RECORD:C51([Contract AddFund:82])
End for 

[Contracts:79]TotalEncumbered:16:=[Contracts:79]InitContractTotal:12+$additionalFund

[Contracts:79]ActualRemainingFund:20:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ActualSpent:18
[Contracts:79]ApproxRemainingFund:19:=[Contracts:79]TotalEncumbered:16-[Contracts:79]ApproxSpent:17