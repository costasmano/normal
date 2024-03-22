//%attributes = {"invisible":true}

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/26/07, 12:35:20
	// ----------------------------------------------------
	// Method: WKHR_PAREMOTE_UpdateValues
	// Description
	// 
	// 
	// Parameters
	// $0 : $Error_L
	// $1 : $ConnID_L : connection ID (long)
	// $2 : $BindID_L : connection ID (long)
	// $3 : $Option_txt : transfer option (Update , Clear)
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:54:16)
	Mods_2007_CM12_5301
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (9/3/10 15:36:30)
	//Ugrade to v11
	//Modified by: Charles Miller (5/10/11 11:15:07)
End if 
If (RecordLocked_b)
	C_LONGINT:C283($Error_L)
	C_BOOLEAN:C305($0)
	
	C_TEXT:C284($1; $Option_txt)
	$Option_txt:=$1
	$Error_L:=0
	C_TEXT:C284($Msg; $FM)
	$FM:="$###,###,###,##0.00"
	C_BOOLEAN:C305($DoUpdate_b)
	C_TEXT:C284($SQLUpdate_txt)
	If ([Work_Estimate:103]AddendumNo:29=0)
		
		$SQLUpdate_txt:="Update Contract_Assignment_Maintenance SET "
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_Salary = :WKHR_PA_Des_Salary,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_IndirectCost = :WKHR_PA_Des_Indir,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_NetFee = :WKHR_PA_Des_Net,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_TotalLimitFee = :WKHR_PA_Des_TLF,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrSalary = :WKHR_PA_Cons_Salary,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrIndirectCost = :WKHR_PA_Cons_Indir,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrNetFee = :WKHR_PA_Cons_Net,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrTotalLimitFee = :WKHR_PA_Cons_TLF,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_DirectExpense = :WKHR_PAREM_DirExptotal_r,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_Total = :WKHR_PA_Tot_MaxPay "
		$SQLUpdate_txt:=$SQLUpdate_txt+"WHERE ContractNo = :WKHR_SRCH_ContractNo_s "
		$SQLUpdate_txt:=$SQLUpdate_txt+" AND AssignNo = :WKHR_SRCH_AssgnNo_L;"
		
	Else 
		$SQLUpdate_txt:="Update Addendum_Maintenance SET "
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_Salary = :WKHR_PA_Des_Salary,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_IndirectCost = :WKHR_PA_Des_Indir,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_NetFee = :WKHR_PA_Des_Net,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_TotalLimitFee = :WKHR_PA_Des_TLF,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrSalary = :WKHR_PA_Cons_Salary,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrIndirectCost = :WKHR_PA_Cons_Indir,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrNetFee = :WKHR_PA_Cons_Net,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_ConstrTotalLimitFee = :WKHR_PA_Cons_TLF,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_DirectExpense = :WKHR_PAREM_DirExptotal_r,"
		$SQLUpdate_txt:=$SQLUpdate_txt+"Est_Total = :WKHR_PA_Tot_MaxPay "
		
		$SQLUpdate_txt:=$SQLUpdate_txt+"WHERE ContractNo = :WKHR_SRCH_ContractNo_s"
		$SQLUpdate_txt:=$SQLUpdate_txt+" AND AssignNo = :WKHR_SRCH_AssgnNo_L "
		$SQLUpdate_txt:=$SQLUpdate_txt+"AND AddendumNo =:WKHR_SRCH_AddendNo_L;"
		
	End if 
	
	Case of 
		: ($Option_txt="Update")
			
			If (WKHR_PA_Tot_MaxPay=0)
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
				$Msg:=$Msg+"Salary  from: "+String:C10(WKHR_PA_Des_Salary; $FM)+"    to: "+String:C10(Assgn_Des_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  from: "+String:C10(WKHR_PA_Des_Indir; $FM)+"    to: "+String:C10(Assgn_Des_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  from: "+String:C10(WKHR_PA_Des_Net; $FM)+"    to: "+String:C10(Assgn_Des_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  from: "+String:C10(WKHR_PA_Des_TLF; $FM)+"    to: "+String:C10(Assgn_Des_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Construction >>>>"+<>sCR
				$Msg:=$Msg+"Salary  from: "+String:C10(WKHR_PA_Cons_Salary; $FM)+"    to: "+String:C10(Assgn_Cons_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  from: "+String:C10(WKHR_PA_Cons_Indir; $FM)+"    to: "+String:C10(Assgn_Cons_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  from: "+String:C10(WKHR_PA_Cons_Net; $FM)+"    to: "+String:C10(Assgn_Cons_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  from: "+String:C10(WKHR_PA_Cons_TLF; $FM)+"    to: "+String:C10(Assgn_Cons_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Totals >>>>"+<>sCR
				$Msg:=$Msg+"DirectExpenses  from: "+String:C10(WKHR_PAREM_DirExptotal_r; $FM)+"    to: "+String:C10([Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27; $FM)+<>sCR
				$Msg:=$Msg+"Total  from: "+String:C10(WKHR_PA_Tot_MaxPay; $FM)+"    to: "+String:C10(Assgn_Tot_MaxPay; $FM)
				$Msg:="Change Current values to the Proposed ones as shown below?"+<>sCR+$Msg
				
			End if 
			G_MyConfirm($Msg)
			$DoUpdate_b:=(OK=1)
			If ($DoUpdate_b)
				WKHR_PA_Des_Salary:=Assgn_Des_Salary
				WKHR_PA_Des_Indir:=Assgn_Des_Indir
				WKHR_PA_Des_Net:=Assgn_Des_Net
				WKHR_PA_Des_TLF:=Assgn_Des_TLF
				WKHR_PA_Cons_Salary:=Assgn_Cons_Salary
				WKHR_PA_Cons_Indir:=Assgn_Cons_Indir
				WKHR_PA_Cons_Net:=Assgn_Cons_Net
				WKHR_PA_Cons_TLF:=Assgn_Cons_TLF
				WKHR_PAREM_DirExptotal_r:=[Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27
				WKHR_PA_Tot_MaxPay:=Assgn_Tot_MaxPay
				
				ut_SQLExecuteNoReturn($SQLUpdate_txt)
			Else 
				$Error_L:=-4  //User cancel of update
			End if 
		: ($Option_txt="Clear")
			If (WKHR_PA_Tot_MaxPay=0)
				$DoUpdate_b:=False:C215
				ALERT:C41("There are no Negotiated Costs for the Assignment on the Boston Server!")
				$Error_L:=0
			Else 
				$Msg:="<<<< Design >>>>"+<>sCR
				$Msg:=$Msg+"Salary  : "+String:C10(WKHR_PA_Des_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  : "+String:C10(WKHR_PA_Des_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  : "+String:C10(WKHR_PA_Des_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  : "+String:C10(WKHR_PA_Des_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Construction >>>>"+<>sCR
				$Msg:=$Msg+"Salary  : "+String:C10(WKHR_PA_Cons_Salary; $FM)+<>sCR
				$Msg:=$Msg+"IndirectCost  : "+String:C10(WKHR_PA_Cons_Indir; $FM)+<>sCR
				$Msg:=$Msg+"NetFee  : "+String:C10(WKHR_PA_Cons_Net; $FM)+<>sCR
				$Msg:=$Msg+"TotalLimitFee  : "+String:C10(WKHR_PA_Cons_TLF; $FM)+<>sCR
				$Msg:=$Msg+"<<<< Totals >>>>"+<>sCR
				$Msg:=$Msg+"DirectExpenses  : "+String:C10(WKHR_PAREM_DirExptotal_r; $FM)+<>sCR
				$Msg:=$Msg+"Total  : "+String:C10(WKHR_PA_Tot_MaxPay; $FM)
				$Msg:="Clear the Current Negotiated values shown below?"+<>sCR+$Msg
				G_MyConfirm($Msg)
				$DoUpdate_b:=(OK=1)
				If ($DoUpdate_b)
					WKHR_PA_Des_Salary:=0
					WKHR_PA_Des_Indir:=0
					WKHR_PA_Des_Net:=0
					WKHR_PA_Des_TLF:=0
					WKHR_PA_Cons_Salary:=0
					WKHR_PA_Cons_Indir:=0
					WKHR_PA_Cons_Net:=0
					WKHR_PA_Cons_TLF:=0
					WKHR_PAREM_DirExptotal_r:=0
					WKHR_PA_Tot_MaxPay:=0
					ut_SQLExecuteNoReturn($SQLUpdate_txt)
					
				Else 
					$Error_L:=-4  //User cancel of update
				End if 
			End if 
			
	End case 
	
	Case of 
		: (Not:C34($DoUpdate_b))  //we cancelled
			$0:=False:C215
		: (SQLError_b) | (4DError_b)
			$0:=False:C215
		Else 
			
			$0:=True:C214
	End case 
Else 
	$0:=False:C215
End if 