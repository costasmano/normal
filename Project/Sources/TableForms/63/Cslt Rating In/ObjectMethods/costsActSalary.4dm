//added 01/20/04

If (CRTG_AutoCalc_L=0)
	If ((netFeeRate#0) & (overheadRate#0))
		[Conslt Rating Cost:74]Act IndirectCost:39:=[Conslt Rating Cost:74]Act Salary:21*overheadRate/100
		[Conslt Rating Cost:74]Act NetFee:22:=([Conslt Rating Cost:74]Act Salary:21+[Conslt Rating Cost:74]Act IndirectCost:39)*netFeeRate/100
	End if 
	
End if 

[Conslt Rating Cost:74]Act TotalLimitFee:23:=[Conslt Rating Cost:74]Act Salary:21+[Conslt Rating Cost:74]Act IndirectCost:39+[Conslt Rating Cost:74]Act NetFee:22
[Conslt Rating Cost:74]Act TotalCost:35:=[Conslt Rating Cost:74]Act TotalLimitFee:23+[Conslt Rating Cost:74]Act TotalDirectCost:34