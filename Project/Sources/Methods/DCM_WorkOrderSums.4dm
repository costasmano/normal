//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/16/09, 21:39:44
	// ----------------------------------------------------
	// Method: DCM_WorkOrderSums
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($NumWOs_L; $i)
$NumWOs_L:=Records in selection:C76([DCM_WorkOrders:137])
ARRAY REAL:C219(DCM_WOInitEst_ar; $NumWOs_L)
ARRAY REAL:C219(DCM_WOContrEst_ar; $NumWOs_L)
ARRAY REAL:C219(DCM_WOFinalCost_ar; $NumWOs_L)
ARRAY INTEGER:C220(DCM_WONo_al; $NumWOs_L)

SELECTION TO ARRAY:C260([DCM_WorkOrders:137]Est_ConstrSalary:27; DCM_WOInitEst_ar)
SELECTION TO ARRAY:C260([DCM_WorkOrders:137]Actual_Salary:22; DCM_WOContrEst_ar)
SELECTION TO ARRAY:C260([DCM_WorkOrders:137]Actual_ConstrSalary:31; DCM_WOFinalCost_ar)
SELECTION TO ARRAY:C260([DCM_WorkOrders:137]AssignNo:2; DCM_WONo_al)
//ARRAY STRING(85;DCM_WODesc_as;Size of array(DCM_WONo_al))

For ($i; 1; Size of array:C274(DCM_WONo_al))
	
	GOTO SELECTED RECORD:C245([DCM_WorkOrders:137]; $i)
	//CM_CalculateNegotiatedCosts 
	//CM_AssgnEstTLF_D_aR{$i}:=vEstTotalLimitFee
	//CM_AssgnEstTLF_C_aR{$i}:=vEstConstrTotalLimitFee
	//CM_AssgnEstDE_aR{$i}:=vEstDirectExpense
	DCM_WODesc_as{$i}:=String:C10(DCM_WONo_al{$i})+" : "+Substring:C12([DCM_WorkOrders:137]Description:35; 1; 80)
	
End for 

SORT ARRAY:C229(DCM_WONo_al; DCM_WODesc_as; DCM_WOInitEst_ar; DCM_WOContrEst_ar; DCM_WOFinalCost_ar)
