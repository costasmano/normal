Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: ([Contract FundTransfer:80]TransferDirection:6="From Limiting Fee to Direct Expense")
				Self:C308->:=2
			: ([Contract FundTransfer:80]TransferDirection:6="From Direct Expense to Limiting Fee")
				Self:C308->:=3
				
			Else 
				Self:C308->:=0
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				[Contract FundTransfer:80]TransferDirection:6:=""
			: (Self:C308->=2)
				[Contract FundTransfer:80]TransferDirection:6:="From Limiting Fee to Direct Expense"
			: (Self:C308->=3)
				[Contract FundTransfer:80]TransferDirection:6:="From Direct Expense to Limiting Fee"
		End case 
End case 