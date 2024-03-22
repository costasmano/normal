If (False:C215)
	//known variable = salary
	
	C_REAL:C285($temp)
	$temp:=Round:C94([Contract Assignments:83]Actual_Salary:4*([Contracts:79]OverheadRate:10/100); 2)
	If (Dec:C9($temp)=0.99)
		[Contract Assignments:83]Actual_IndirectCost:5:=Round:C94($temp; 0)
	Else 
		[Contract Assignments:83]Actual_IndirectCost:5:=$temp
	End if 
	
	$temp:=Round:C94([Contract Assignments:83]Actual_Salary:4*([Contracts:79]OverheadRate:10/100+1)*([Contracts:79]NetFeeRate:11/100); 2)
	If (Dec:C9($temp)=0.99)
		[Contract Assignments:83]Actual_NetFee:6:=Round:C94($temp; 0)
	Else 
		[Contract Assignments:83]Actual_NetFee:6:=$temp
	End if 
	
	[Contract Assignments:83]Actual_TotalLimitFee:7:=[Contract Assignments:83]Actual_Salary:4+[Contract Assignments:83]Actual_IndirectCost:5+[Contract Assignments:83]Actual_NetFee:6
	[Contract Assignments:83]Actual_Total:9:=[Contract Assignments:83]Actual_TotalLimitFee:7+[Contract Assignments:83]Actual_DirectExpense:8
Else 
	CIR_AssgnValues_OM(Self:C308)
End if 