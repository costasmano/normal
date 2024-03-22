//added 01/20/04


If ((netFeeRate#0) & (overheadRate#0))
	[Conslt Rating Cost:74]Neg Salary:3:=[Conslt Rating Cost:74]Neg IndirectCost:4/(overheadRate/100)
	[Conslt Rating Cost:74]Neg NetFee:5:=([Conslt Rating Cost:74]Neg Salary:3+[Conslt Rating Cost:74]Neg IndirectCost:4)*netFeeRate/100
End if 

[Conslt Rating Cost:74]Neg TotalLimitFee:6:=[Conslt Rating Cost:74]Neg Salary:3+[Conslt Rating Cost:74]Neg IndirectCost:4+[Conslt Rating Cost:74]Neg NetFee:5
[Conslt Rating Cost:74]Neg TotalCost:18:=[Conslt Rating Cost:74]Neg TotalLimitFee:6+[Conslt Rating Cost:74]Neg TotalDirectCost:17