//known variable = salary
C_REAL:C285($temp)
$temp:=Round:C94([Contracts:79]InitContractSalary:13*([Contracts:79]OverheadRate:10/100+1)*([Contracts:79]NetFeeRate:11/100+1); 2)
If (Dec:C9($temp)=0.99)
	[Contracts:79]InitContractTotalLimitFee:14:=Round:C94($temp; 0)
Else 
	[Contracts:79]InitContractTotalLimitFee:14:=$temp
End if 
[Contracts:79]InitContractTotal:12:=[Contracts:79]InitContractTotalLimitFee:14+[Contracts:79]InitContractTotDirctExpense:15

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

G_ContractsCheckNegative
G_CalculateTLFandDE