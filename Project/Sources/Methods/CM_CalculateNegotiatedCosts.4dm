//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 03/23/05, 13:00:00
	// ----------------------------------------------------
	// Method: CM_CalculateNegotiatedCosts
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vEstSalary; vEstIndirectCost; vEstNetFee; vEstTotalLimitFee)
C_REAL:C285(vEstConstrSalary; vEstConstrIndirectCost; vEstConstrNetFee; vEstConstrTotalLimitFee)
C_REAL:C285(vEstDirectExpense; vEstTotal)

vEstSalary:=0
vEstIndirectCost:=0
vEstNetFee:=0
vEstTotalLimitFee:=0
vEstConstrSalary:=0
vEstConstrIndirectCost:=0
vEstConstrNetFee:=0
vEstConstrTotalLimitFee:=0
vEstDirectExpense:=0
vEstTotal:=0

QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2)

//Negotiated costs of design
C_REAL:C285($EstSalary; $EstIndirectCost; $EstNetFee; $EstTotalLimitFee)
$EstSalary:=0
$EstIndirectCost:=0
$EstNetFee:=0
$EstTotalLimitFee:=0

//Negotiated costs of construction
C_REAL:C285($EstConstrSalary; $EstConstrIndirectCost; $EstConstrNetFee; $EstConstrTotalLimitFee)
$EstConstrSalary:=0
$EstConstrIndirectCost:=0
$EstConstrNetFee:=0
$EstConstrTotalLimitFee:=0

C_REAL:C285($EstDirectExpense; $EstTotal)
$EstDirectExpense:=0
$EstTotal:=0

For ($i; 1; Records in selection:C76([Addendum_Maintenance:102]))
	GOTO SELECTED RECORD:C245([Addendum_Maintenance:102]; $i)
	//Design
	$EstSalary:=$EstSalary+[Addendum_Maintenance:102]Est_Salary:14
	$EstIndirectCost:=$EstIndirectCost+[Addendum_Maintenance:102]Est_IndirectCost:12
	$EstNetFee:=$EstNetFee+[Addendum_Maintenance:102]Est_NetFee:13
	$EstTotalLimitFee:=$EstTotalLimitFee+[Addendum_Maintenance:102]Est_TotalLimitFee:16
	
	//Construction
	$EstConstrSalary:=$EstConstrSalary+[Addendum_Maintenance:102]Est_ConstrSalary:9
	$EstConstrIndirectCost:=$EstConstrIndirectCost+[Addendum_Maintenance:102]Est_ConstrIndirectCost:7
	$EstConstrNetFee:=$EstConstrNetFee+[Addendum_Maintenance:102]Est_ConstrNetFee:8
	$EstConstrTotalLimitFee:=$EstConstrTotalLimitFee+[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
	
	$EstDirectExpense:=$EstDirectExpense+[Addendum_Maintenance:102]Est_DirectExpense:11
	$EstTotal:=$EstTotal+[Addendum_Maintenance:102]Est_Total:15
	
	//NEXT RECORD([Addendum_Maintenance])
End for 

//Calculate total negotiated costs
vEstSalary:=$EstSalary+[Contract_Assignment_Maintenance:101]Est_Salary:10
vEstIndirectCost:=$EstIndirectCost+[Contract_Assignment_Maintenance:101]Est_IndirectCost:11
vEstNetFee:=$EstNetFee+[Contract_Assignment_Maintenance:101]Est_NetFee:12

vEstConstrSalary:=$EstConstrSalary+[Contract_Assignment_Maintenance:101]Est_ConstrSalary:27
vEstConstrIndirectCost:=$EstConstrIndirectCost+[Contract_Assignment_Maintenance:101]Est_ConstrIndirectCost:28
vEstConstrNetFee:=$EstConstrNetFee+[Contract_Assignment_Maintenance:101]Est_ConstrNetFee:29

vEstTotalLimitFee:=$EstTotalLimitFee+[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
vEstConstrTotalLimitFee:=$EstConstrTotalLimitFee+[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
vEstDirectExpense:=$EstDirectExpense+[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
vEstTotal:=$EstTotal+[Contract_Assignment_Maintenance:101]Est_Total:15
