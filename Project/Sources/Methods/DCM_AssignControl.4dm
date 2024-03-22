//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/01/09, 09:37:43
	// ----------------------------------------------------
	// Method: DCM_AssignControl
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(12/13/10 10:46:27)
	Mods_2010_12
	//  `Coding Enhancement - also avoid resetting [DCM_Contracts]ApproxSpent if there is no change
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_TEXT:C284($1)
Case of 
	: ($1="INIT")
		C_LONGINT:C283($2)
		ARRAY LONGINT:C221(DCM_Assgn_No_aL; $2)
		ARRAY TEXT:C222(DCM_Assgn_Desc_atxt; $2)
		ARRAY REAL:C219(DCM_Assgn_Total_ar; $2)
		ARRAY TEXT:C222(DCM_Assgn_PFileNo_atxt; $2)
		C_POINTER:C301(DCM_AssgnNo_ptr; DCM_AssgnDesc_ptr; DCM_AssgnPFile_ptr; DCM_WOInitEst_ptr; DCM_WOContrEst_ptr; DCM_WOFinalEst_ptr)
		DCM_WOInitEst_ptr:=->[DCM_WorkOrders:137]Est_ConstrSalary:27
		DCM_WOContrEst_ptr:=->[DCM_WorkOrders:137]Actual_Salary:22
		DCM_WOFinalEst_ptr:=->[DCM_WorkOrders:137]Actual_ConstrSalary:31
		DCM_AssgnNo_ptr:=->[DCM_WorkOrders:137]AssignNo:2
		DCM_AssgnDesc_ptr:=->[DCM_WorkOrders:137]Description:35
		DCM_AssgnPFile_ptr:=->[DCM_WorkOrders:137]ProjectIS:4
	: ($1="LOAD")
		SELECTION TO ARRAY:C260(DCM_AssgnNo_ptr->; DCM_Assgn_No_aL; DCM_AssgnDesc_ptr->; DCM_Assgn_Desc_atxt; DCM_AssgnPFile_ptr->; DCM_Assgn_PFileNo_atxt)
		C_LONGINT:C283($NumWOs_L)
		$NumWOs_L:=Records in selection:C76([DCM_WorkOrders:137])
		ARRAY REAL:C219(DCM_WOInitEst_ar; $NumWOs_L)
		ARRAY REAL:C219(DCM_WOContrEst_ar; $NumWOs_L)
		ARRAY REAL:C219(DCM_WOFinalCost_ar; $NumWOs_L)
		ARRAY INTEGER:C220(DCM_WONo_al; $NumWOs_L)
		
		SELECTION TO ARRAY:C260(DCM_WOInitEst_ptr->; DCM_WOInitEst_ar; DCM_WOContrEst_ptr->; DCM_WOContrEst_ar; DCM_WOFinalEst_ptr->; DCM_WOFinalCost_ar)
		SELECTION TO ARRAY:C260(DCM_AssgnNo_ptr->; DCM_WONo_al)
		ARRAY TEXT:C222(DCM_WODesc_as; Size of array:C274(DCM_WONo_al))  //Command Replaced was o_ARRAY string length was 85
		C_REAL:C285($WO_total_Est_r; $WO_Tot_Act_r)
		$WO_total_Est_r:=0
		$WO_Tot_Act_r:=0
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274(DCM_WONo_al))
			DCM_WODesc_as{$i}:=String:C10(DCM_WONo_al{$i})+" : "+Substring:C12(DCM_Assgn_Desc_atxt{$i}; 1; 80)
			$WO_total_Est_r:=$WO_total_Est_r+DCM_WOInitEst_ar{$i}
			If (DCM_WOFinalCost_ar{$i}=0)
				$WO_Tot_Act_r:=$WO_Tot_Act_r+DCM_WOInitEst_ar{$i}
			Else 
				$WO_Tot_Act_r:=$WO_Tot_Act_r+DCM_WOFinalCost_ar{$i}
			End if 
			
		End for 
		If ([DCM_Contracts:136]ApproxSpent:17#$WO_Tot_Act_r)
			[DCM_Contracts:136]ApproxSpent:17:=$WO_Tot_Act_r
			[DCM_Contracts:136]ApproxRemainingFund:19:=[DCM_Contracts:136]InitContractTotal:12-[DCM_Contracts:136]ApproxSpent:17
		End if 
		
		LISTBOX SELECT ROW:C912(DCM_AssgnListBox; 0; lk remove from selection:K53:3)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_AssgnListBox))
			DCM_AssgnListBox{$loop_L}:=False:C215
		End for 
	: ($1="RELATE")
		DCM_SetupRelated(2)
	Else 
		ALERT:C41("Application error! Unknown argument to "+Current method name:C684+" :<"+$1+"> !!!!")
		
End case 