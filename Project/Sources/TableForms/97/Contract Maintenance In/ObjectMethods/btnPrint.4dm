C_TEXT:C284($reportType)  // Command Replaced was o_C_STRING length was 12
If (False:C215)
	//get report type
	$reportType:=Mnt_GetReportType
	
	Case of 
		: ($reportType="Assignment")
			Mnt_ContractRpt_Assignment
			
		: ($reportType="Cost")
			Mnt_ContractRpt_Cost
			
		: ($reportType="Payment")
			Mnt_ContractRpt_Payment
	End case 
	
End if 
CM_PrintContractReport