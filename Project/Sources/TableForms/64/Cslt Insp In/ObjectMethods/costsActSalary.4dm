//added 01/20/04
If (CRTG_AutoCalc_L=0)
	
	If ((netFeeRate#0) & (overheadRate#0))
		[Cons Inspection Cost:76]Act IndirectCost:23:=[Cons Inspection Cost:76]Act Salary:22*overheadRate/100
		[Cons Inspection Cost:76]Act NetFee:24:=([Cons Inspection Cost:76]Act Salary:22+[Cons Inspection Cost:76]Act IndirectCost:23)*netFeeRate/100
	End if 
	
	
End if 
[Cons Inspection Cost:76]Act TotalLimitFee:25:=[Cons Inspection Cost:76]Act Salary:22+[Cons Inspection Cost:76]Act IndirectCost:23+[Cons Inspection Cost:76]Act NetFee:24
[Cons Inspection Cost:76]Act TotalCost:38:=[Cons Inspection Cost:76]Act TotalLimitFee:25+[Cons Inspection Cost:76]Act TotalDirectCost:37