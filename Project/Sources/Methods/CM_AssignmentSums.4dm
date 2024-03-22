//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/05, 15:38:26
	// ----------------------------------------------------
	// Method: CM_AssignmentSums
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
ARRAY REAL:C219(CM_AssgnActTLF_D_aR; 0)
ARRAY REAL:C219(CM_AssgnActTLF_C_aR; 0)
ARRAY REAL:C219(CM_AssgnActDE_aR; 0)
ARRAY INTEGER:C220(CM_AssgnNo_aI; 0)

SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25; CM_AssgnActTLF_D_aR)
SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34; CM_AssgnActTLF_C_aR)
SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]Actual_DirectExpense:26; CM_AssgnActDE_aR)
SELECTION TO ARRAY:C260([Contract_Assignment_Maintenance:101]AssignNo:2; CM_AssgnNo_aI)
ARRAY REAL:C219(CM_AssgnEstTLF_D_aR; Size of array:C274(CM_AssgnNo_aI))
ARRAY REAL:C219(CM_AssgnEstTLF_C_aR; Size of array:C274(CM_AssgnNo_aI))
ARRAY REAL:C219(CM_AssgnEstDE_aR; Size of array:C274(CM_AssgnNo_aI))
ARRAY TEXT:C222(CM_AssgnDesc; Size of array:C274(CM_AssgnNo_aI))  //Command Replaced was o_ARRAY string length was 85
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274(CM_AssgnNo_aI))
	
	GOTO SELECTED RECORD:C245([Contract_Assignment_Maintenance:101]; $i)
	CM_CalculateNegotiatedCosts
	CM_AssgnEstTLF_D_aR{$i}:=vEstTotalLimitFee
	CM_AssgnEstTLF_C_aR{$i}:=vEstConstrTotalLimitFee
	CM_AssgnEstDE_aR{$i}:=vEstDirectExpense
	CM_AssgnDesc{$i}:=String:C10(CM_AssgnNo_aI{$i})+" : "+Substring:C12([Contract_Assignment_Maintenance:101]Description:35; 1; 80)
	
End for 

SORT ARRAY:C229(CM_AssgnNo_aI; CM_AssgnDesc; CM_AssgnEstTLF_D_aR; CM_AssgnEstTLF_C_aR; CM_AssgnEstDE_aR; CM_AssgnActTLF_D_aR; CM_AssgnActTLF_C_aR; CM_AssgnActDE_aR)
