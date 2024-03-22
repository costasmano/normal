Case of 
	: (Self:C308->=2)
		//Funds Tab
		ORDER BY:C49([Contract FundTransfer:80]; [Contract FundTransfer:80]DateApproval:5; >)
		ORDER BY:C49([Contract AddFund:82]; [Contract AddFund:82]DateApproval:5; >)
		
	: (Self:C308->=3)
		//Extention of Time Tab
		ORDER BY:C49([Contract ExtendTime:81]; [Contract ExtendTime:81]InitialDate:6; >)
		
	: (Self:C308->=5)
		//Assignment Summary Tab
		ORDER BY:C49([Contract Assignments:83]; [Contract Assignments:83]AssignNo:2; >)
		
	: (Self:C308->=6)
		//Payment/Invoices Tab
		ORDER BY:C49([Contract Invoice:84]; [Contract Invoice:84]InvoiceNo:2; >)
End case 