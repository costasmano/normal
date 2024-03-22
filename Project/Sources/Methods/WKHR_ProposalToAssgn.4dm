//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/28/05, 17:39:16
	// ----------------------------------------------------
	// Method: WKHR_ProposalToAssgn
	// Description
	// 
	//
	// Parameters
	// $1 : $UpdOption_S : data transfer option (Update, Clear)
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 09:57:38)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 09:38:09)
	Mods_2007_CM06
	// Modified by: costasmanousakis-(Designer)-(2/27/2007 11:49:49)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:48:19)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5302  //r001 `10/02/07, 11:34:13
End if 
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 10
C_TEXT:C284($UpdOption_S)  // Command Replaced was o_C_STRING length was 10
$UpdOption_S:=$1
C_BOOLEAN:C305($LoadedRec_b)
C_TEXT:C284($Msg; $FM; $AssignAddend_txt)
C_POINTER:C301($Tbl_ptr)
C_POINTER:C301($Salary_ptr; $IndirectCost_ptr; $NetFee_ptr; $ConstrSalary_ptr; $ConstrIndirectCost_ptr)
C_POINTER:C301($ConstrNetFee_ptr; $TotalLimitFee_ptr; $ConstrTotalLimitFee_ptr; $DirectExpense_ptr; $Total_ptr)

$FM:="$###,###,###,##0.00"
If ([Work_Estimate:103]AddendumNo:29=0)
	$Tbl_ptr:=->[Contract_Assignment_Maintenance:101]
	$Salary_ptr:=->[Contract_Assignment_Maintenance:101]Est_Salary:10
	$IndirectCost_ptr:=->[Contract_Assignment_Maintenance:101]Est_IndirectCost:11
	$NetFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_NetFee:12
	$ConstrSalary_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrSalary:27
	$ConstrIndirectCost_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrIndirectCost:28
	$ConstrNetFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrNetFee:29
	$TotalLimitFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
	$ConstrTotalLimitFee_ptr:=->[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
	$DirectExpense_ptr:=->[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
	$Total_ptr:=->[Contract_Assignment_Maintenance:101]Est_Total:15
	$AssignAddend_txt:="Contract Assignment"
Else 
	$Tbl_ptr:=->[Addendum_Maintenance:102]
	$Salary_ptr:=->[Addendum_Maintenance:102]Est_Salary:14
	$IndirectCost_ptr:=->[Addendum_Maintenance:102]Est_IndirectCost:12
	$NetFee_ptr:=->[Addendum_Maintenance:102]Est_NetFee:13
	$ConstrSalary_ptr:=->[Addendum_Maintenance:102]Est_ConstrSalary:9
	$ConstrIndirectCost_ptr:=->[Addendum_Maintenance:102]Est_ConstrIndirectCost:7
	$ConstrNetFee_ptr:=->[Addendum_Maintenance:102]Est_ConstrNetFee:8
	$TotalLimitFee_ptr:=->[Addendum_Maintenance:102]Est_TotalLimitFee:16
	$ConstrTotalLimitFee_ptr:=->[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10
	$DirectExpense_ptr:=->[Addendum_Maintenance:102]Est_DirectExpense:11
	$Total_ptr:=->[Addendum_Maintenance:102]Est_Total:15
	$AssignAddend_txt:="Contract Assignment Addendum"
	
	If (WKHR_InputStatus=1)
		//coming from the Addendum record input screen
	Else 
		//coming from the Work hour review screen - need to find the right addendum
		QUERY SELECTION:C341([Addendum_Maintenance:102]; [Addendum_Maintenance:102]AddendumNo:2=[Work_Estimate:103]AddendumNo:29)
	End if 
End if 

If (Modified record:C314($Tbl_ptr->))
	$LoadedRec_b:=True:C214
Else 
	UNLOAD RECORD:C212($Tbl_ptr->)
	READ WRITE:C146($Tbl_ptr->)
	LOAD RECORD:C52($Tbl_ptr->)
	$LoadedRec_b:=ut_LoadRecordInteractive($Tbl_ptr)
End if 
If ($LoadedRec_b)
	Case of 
		: ($UpdOption_S="Update")
			C_BOOLEAN:C305($DoUpdate_b)
			If ($Total_ptr->=0)
				$Msg:="<<<< Design >>>>"+<>sCR
				$Msg:=$Msg+"Salary  to: "+String:C10(Assgn_Des_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  to: "+String:C10(Assgn_Des_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  to: "+String:C10(Assgn_Des_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  to: "+String:C10(Assgn_Des_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Construction >>>>"+<>sCR
				$Msg:=$Msg+"Salary  to: "+String:C10(Assgn_Cons_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  to: "+String:C10(Assgn_Cons_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  to: "+String:C10(Assgn_Cons_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  to: "+String:C10(Assgn_Cons_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Totals >>>>"+<>sCR
				$Msg:=$Msg+"DirectExpenses  to: "+String:C10([Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27; $FM)+<>sCR
				$Msg:=$Msg+"Total  to: "+String:C10(Assgn_Tot_MaxPay; $FM)
				$Msg:="Change the Negotiated values to the Proposed ones as shown below?"+<>sCR+$Msg
			Else 
				$Msg:="<<<< Design >>>>"+<>sCR
				$Msg:=$Msg+"Salary  from: "+String:C10($Salary_ptr->; $FM)+"    to: "+String:C10(Assgn_Des_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  from: "+String:C10($IndirectCost_ptr->; $FM)+"    to: "+String:C10(Assgn_Des_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  from: "+String:C10($NetFee_ptr->; $FM)+"    to: "+String:C10(Assgn_Des_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  from: "+String:C10($TotalLimitFee_ptr->; $FM)+"    to: "+String:C10(Assgn_Des_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Construction >>>>"+<>sCR
				$Msg:=$Msg+"Salary  from: "+String:C10($ConstrSalary_ptr->; $FM)+"    to: "+String:C10(Assgn_Cons_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  from: "+String:C10($ConstrIndirectCost_ptr->; $FM)+"    to: "+String:C10(Assgn_Cons_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  from: "+String:C10($ConstrNetFee_ptr->; $FM)+"    to: "+String:C10(Assgn_Cons_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  from: "+String:C10($ConstrTotalLimitFee_ptr->; $FM)+"    to: "+String:C10(Assgn_Cons_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Totals >>>>"+<>sCR
				$Msg:=$Msg+"DirectExpenses  from: "+String:C10($DirectExpense_ptr->; $FM)+"    to: "+String:C10([Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27; $FM)+<>sCR
				$Msg:=$Msg+"Total  from: "+String:C10($Total_ptr->; $FM)+"    to: "+String:C10(Assgn_Tot_MaxPay; $FM)
				$Msg:="Change Current values to the Proposed ones as shown below?"+<>sCR+$Msg
			End if 
			
			G_MyConfirm($Msg)
			$DoUpdate_b:=(OK=1)
			If ($DoUpdate_b)
				$Salary_ptr->:=Assgn_Des_Salary
				$IndirectCost_ptr->:=Assgn_Des_Indir
				$NetFee_ptr->:=Assgn_Des_Net
				$ConstrSalary_ptr->:=Assgn_Cons_Salary
				$ConstrIndirectCost_ptr->:=Assgn_Cons_Indir
				$ConstrNetFee_ptr->:=Assgn_Cons_Net
				$TotalLimitFee_ptr->:=Assgn_Des_TLF
				$ConstrTotalLimitFee_ptr->:=Assgn_Cons_TLF
				$DirectExpense_ptr->:=[Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27
				$Total_ptr->:=Assgn_Tot_MaxPay
				WKHR_SaveRelated_B:=True:C214
			End if 
			
		: ($UpdOption_S="Clear")
			
			If ($Total_ptr->#0)
				$Msg:="<<<< Design >>>>"+<>sCR
				$Msg:=$Msg+"Salary  : "+String:C10($Salary_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  : "+String:C10($IndirectCost_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  : "+String:C10($NetFee_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  : "+String:C10($TotalLimitFee_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Construction >>>>"+<>sCR
				$Msg:=$Msg+"Salary  : "+String:C10($ConstrSalary_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  : "+String:C10($ConstrIndirectCost_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  : "+String:C10($ConstrNetFee_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  : "+String:C10($ConstrTotalLimitFee_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Totals >>>>"+<>sCR
				$Msg:=$Msg+"DirectExpenses  : "+String:C10($DirectExpense_ptr->; $FM)+<>sCR
				$Msg:=$Msg+"Total  : "+String:C10($Total_ptr->; $FM)
				$Msg:="Clear the Current Negotiated values shown below?"+<>sCR+$Msg
				G_MyConfirm($Msg)
				If (OK=1)
					$Salary_ptr->:=0
					$IndirectCost_ptr->:=0
					$NetFee_ptr->:=0
					$ConstrSalary_ptr->:=0
					$ConstrIndirectCost_ptr->:=0
					$ConstrNetFee_ptr->:=0
					$TotalLimitFee_ptr->:=0
					$ConstrTotalLimitFee_ptr->:=0
					$DirectExpense_ptr->:=0
					$Total_ptr->:=0
					WKHR_SaveRelated_B:=True:C214
				End if 
				
			End if 
			
	End case 
	If ((WKHR_InputStatus=1) & ([Work_Estimate:103]AddendumNo:29=0))
		//coming from the Addendum record input screen
		CM_CalculateNegotiatedCosts
	End if 
	
Else 
	ALERT:C41("Could not load "+$AssignAddend_txt+" record!")
End if 