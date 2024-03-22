Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		C_REAL:C285(vFundTransfTLF; vFundTransfDE)
		If ([FundTransfer_Maintenance:96]TransferDirection:6="")
			vFundTransfTLF:=[FundTransfer_Maintenance:96]TransferAmount:7
			vFundTransfDE:=-[FundTransfer_Maintenance:96]TransferAmount:7
		Else 
			vFundTransfTLF:=-[FundTransfer_Maintenance:96]TransferAmount:7
			vFundTransfDE:=[FundTransfer_Maintenance:96]TransferAmount:7
		End if 
End case 
