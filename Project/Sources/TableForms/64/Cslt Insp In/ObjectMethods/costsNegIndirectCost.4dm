//added 01/20/04

If ((netFeeRate#0) & (overheadRate#0))
	[Cons Inspection Cost:76]Neg Salary:3:=[Cons Inspection Cost:76]Neg IndirectCost:4/(overheadRate/100)
	[Cons Inspection Cost:76]Neg NetFee:5:=([Cons Inspection Cost:76]Neg Salary:3+[Cons Inspection Cost:76]Neg IndirectCost:4)*netFeeRate/100
End if 

[Cons Inspection Cost:76]Neg TotalLimitFee:6:=[Cons Inspection Cost:76]Neg Salary:3+[Cons Inspection Cost:76]Neg IndirectCost:4+[Cons Inspection Cost:76]Neg NetFee:5
[Cons Inspection Cost:76]Neg TotalCost:19:=[Cons Inspection Cost:76]Neg TotalLimitFee:6+[Cons Inspection Cost:76]Neg TotalDirectCost:18