// Modified by: ManousakisC (12/16/2008)
//Added Projectinfo number
If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Actual")
	vLimitFee:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
	vDirectExp:=[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
	vTotal:=[Contract_Assignment_Maintenance:101]Actual_Total:9
Else 
	CM_CalculateNegotiatedCosts
	//vLimitFee:=[Contract_Assignment_Maintenance]Est_TotalLimitFee+[Contract_Assignment_Maintenance]Est_ConstrTotalLimitFee
	vLimitFee:=vEstTotalLimitFee+vEstConstrTotalLimitFee
	//vDirectExp:=[Contract_Assignment_Maintenance]Est_DirectExpense
	vDirectExp:=vEstDirectExpense
	//vTotal:=[Contract_Assignment_Maintenance]Est_Total
	vTotal:=vEstTotal
End if 