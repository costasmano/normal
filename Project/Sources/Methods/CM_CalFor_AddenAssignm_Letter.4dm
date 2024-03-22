//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 03/20/05, 10:00:00
	// ----------------------------------------------------
	// Method: CM_CalFor_AddenAssignm_Letter
	// Description: calculation support WRT_ContrMnt_AddenAssignm
	//                    letter
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(4/25/2007 11:43:20)
	Mods_2007_CM08
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

ARRAY REAL:C219(CM_AddenTLF_D_aR; 0)
ARRAY REAL:C219(CM_AddenTLF_C_aR; 0)
ARRAY REAL:C219(CM_AddenDE_aR; 0)
ARRAY INTEGER:C220(CM_AddenNumber_aI; 0)

C_REAL:C285(vAddenDesTLF; vAddenConstrTLF; vAddenDE)
vAddenDesTLF:=0
vAddenConstrTLF:=0
vAddenDE:=0
COPY NAMED SELECTION:C331([Addendum_Maintenance:102]; "AddendMntSel")
//push the current addendum record to the stack
PUSH RECORD:C176([Addendum_Maintenance:102])

//get all addendums for this assignment
QUERY:C277([Addendum_Maintenance:102]; [Addendum_Maintenance:102]ContractNo:5=[Contract_Maintenance:97]ContractNo:1; *)
QUERY:C277([Addendum_Maintenance:102];  & ; [Addendum_Maintenance:102]AssignNo:4=[Contract_Assignment_Maintenance:101]AssignNo:2)
ORDER BY:C49([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2; >)

SELECTION TO ARRAY:C260([Addendum_Maintenance:102]Est_TotalLimitFee:16; CM_AddenTLF_D_aR)
SELECTION TO ARRAY:C260([Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10; CM_AddenTLF_C_aR)
SELECTION TO ARRAY:C260([Addendum_Maintenance:102]Est_DirectExpense:11; CM_AddenDE_aR)
SELECTION TO ARRAY:C260([Addendum_Maintenance:102]AddendumNo:2; CM_AddenNumber_aI)

SORT ARRAY:C229(CM_AddenNumber_aI; CM_AddenTLF_D_aR; CM_AddenTLF_C_aR; CM_AddenDE_aR)

//pop the current addendum record from the stack
USE NAMED SELECTION:C332("AddendMntSel")
CLEAR NAMED SELECTION:C333("AddendMntSel")
POP RECORD:C177([Addendum_Maintenance:102])

//finding the location of current AddendumNo in the CM_AddenNumber_aI array
C_LONGINT:C283($vICounter)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i; $j)

$vICounter:=1
For ($i; 1; Size of array:C274(CM_AddenNumber_aI))
	If ([Addendum_Maintenance:102]AddendumNo:2=CM_AddenNumber_aI{$i})
		$i:=Size of array:C274(CM_AddenNumber_aI)+1  //the value is found and get out of the loop
	Else 
		$vICounter:=$vICounter+1
	End if 
End for 
$vICounter:=Find in array:C230(CM_AddenNumber_aI; [Addendum_Maintenance:102]AddendumNo:2)
If ($vICounter<=0)
	$vICounter:=Size of array:C274(CM_AddenNumber_aI)
	INSERT IN ARRAY:C227(CM_AddenNumber_aI; ($vICounter+1))
	INSERT IN ARRAY:C227(CM_AddenTLF_D_aR; ($vICounter+1))
	INSERT IN ARRAY:C227(CM_AddenTLF_C_aR; ($vICounter+1))
	INSERT IN ARRAY:C227(CM_AddenDE_aR; ($vICounter+1))
	$vICounter:=$vICounter+1
	CM_AddenNumber_aI{$vICounter}:=[Addendum_Maintenance:102]AddendumNo:2
	CM_AddenTLF_D_aR{$vICounter}:=[Addendum_Maintenance:102]Est_TotalLimitFee:16
	CM_AddenTLF_C_aR{$vICounter}:=[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
	CM_AddenDE_aR{$vICounter}:=[Addendum_Maintenance:102]Est_DirectExpense:11
	
End if 

For ($j; 1; $vICounter)
	//GOTO SELECTED RECORD([Addendum_Maintenance];$j)
	vAddenDesTLF:=vAddenDesTLF+CM_AddenTLF_D_aR{$j}
	vAddenConstrTLF:=vAddenConstrTLF+CM_AddenTLF_C_aR{$j}
	vAddenDE:=vAddenDE+CM_AddenDE_aR{$j}
End for 