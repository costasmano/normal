If (False:C215)
	//known variable = total limit fee
	C_REAL:C285($temp)
	$temp:=Round:C94([Contract Assignments:83]Est_TotalLimitFee:13/(([Contracts:79]OverheadRate:10/100+1)*([Contracts:79]NetFeeRate:11/100+1)); 2)
	If (Dec:C9($temp)=0.99)
		[Contract Assignments:83]Est_Salary:10:=Round:C94($temp; 0)
	Else 
		[Contract Assignments:83]Est_Salary:10:=$temp
	End if 
	
	$temp:=Round:C94([Contract Assignments:83]Est_Salary:10*([Contracts:79]OverheadRate:10/100); 2)
	If (Dec:C9($temp)=0.99)
		[Contract Assignments:83]Est_IndirectCost:11:=Round:C94($temp; 0)
	Else 
		[Contract Assignments:83]Est_IndirectCost:11:=$temp
	End if 
	
	[Contract Assignments:83]Est_NetFee:12:=[Contract Assignments:83]Est_TotalLimitFee:13-[Contract Assignments:83]Est_Salary:10-[Contract Assignments:83]Est_IndirectCost:11
	[Contract Assignments:83]Est_Total:15:=[Contract Assignments:83]Est_TotalLimitFee:13+[Contract Assignments:83]Est_DirectExpense:14
Else 
	CIR_AssgnValues_OM(Self:C308)
End if 