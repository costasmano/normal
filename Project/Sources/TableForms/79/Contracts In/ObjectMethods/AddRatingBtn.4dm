If (False:C215)
	Mods_2004_CJM02
End if 

C_BOOLEAN:C305(vbNewRec)

FORM SET INPUT:C55([Contract FundTransfer:80]; "TransferFund In")
ADD RECORD:C56([Contract FundTransfer:80])
vbNewRec:=False:C215
RELATE MANY:C262([Contracts:79])

ORDER BY:C49([Contract FundTransfer:80]; [Contract FundTransfer:80]DateApproval:5; >)
ORDER BY:C49([Contract AddFund:82]; [Contract AddFund:82]DateApproval:5; >)