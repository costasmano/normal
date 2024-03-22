If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(4/1/13 13:35:23)
	Mods_2013_04
	//  `Adjusted display format of ammounts and  resized objects and form
End if 

If ([Contract Assignments:83]AcutalOrEstimate:20="Actual")
	vLimitFee:=[Contract Assignments:83]Actual_TotalLimitFee:7
	vDirectExp:=[Contract Assignments:83]Actual_DirectExpense:8
	vTotal:=[Contract Assignments:83]Actual_Total:9
Else 
	vLimitFee:=[Contract Assignments:83]Est_TotalLimitFee:13
	vDirectExp:=[Contract Assignments:83]Est_DirectExpense:14
	vTotal:=[Contract Assignments:83]Est_Total:15
End if 