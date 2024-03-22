//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/09/09, 21:15:19
	// ----------------------------------------------------
	// Method: WKHR_CalcFunctions
	// Description
	// Perform various functions for the design rates
	// 
	// Parameters
	// $1 : $Task : Text
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  // ("WKHRMODS")
End if 
C_TEXT:C284($1)
Case of 
	: ($1="DESTOCONSTR")
		[Work_Estimate:103]ConstCat1Rate:40:=[Work_Estimate:103]Cat1Rate:7
		[Work_Estimate:103]ConstCat2Rate:41:=[Work_Estimate:103]Cat2Rate:8
		[Work_Estimate:103]ConstCat3Rate:42:=[Work_Estimate:103]Cat3Rate:9
		[Work_Estimate:103]ConstCat4Rate:43:=[Work_Estimate:103]Cate4Rate:10
		[Work_Estimate:103]ConstCat5Rate:44:=[Work_Estimate:103]Cat5Rate:11
		[Work_Estimate:103]ConstCat6Rate:46:=[Work_Estimate:103]Cat6Rate:45
		PushChange(1; ->[Work_Estimate:103]ConstCat1Rate:40)
		PushChange(1; ->[Work_Estimate:103]ConstCat2Rate:41)
		PushChange(1; ->[Work_Estimate:103]ConstCat3Rate:42)
		PushChange(1; ->[Work_Estimate:103]ConstCat4Rate:43)
		PushChange(1; ->[Work_Estimate:103]ConstCat5Rate:44)
		PushChange(1; ->[Work_Estimate:103]ConstCat6Rate:46)
		WKHR_CalcRates
	: ($1="PERCENTAGES")
		//Calculate percentages 
		Assgn_Tot_1_pct:=Round:C94((100*(Assgn_Tot_1/Assgn_Tot_6)); 0)
		Assgn_Tot_2_pct:=Round:C94((100*(Assgn_Tot_2/Assgn_Tot_6)); 0)
		Assgn_Tot_3_pct:=Round:C94((100*(Assgn_Tot_3/Assgn_Tot_6)); 0)
		Assgn_Tot_4_pct:=Round:C94((100*(Assgn_Tot_4/Assgn_Tot_6)); 0)
		Assgn_Tot_7_pct:=Round:C94((100*(Assgn_Tot_7/Assgn_Tot_6)); 0)
		Assgn_Tot_5_pct:=100-(Assgn_Tot_1_pct+Assgn_Tot_2_pct+Assgn_Tot_3_pct+Assgn_Tot_4_pct+Assgn_Tot_7_pct)
		If (Assgn_Tot_5_pct<0)  //just in case there is rounding issues
			Assgn_Tot_5_pct:=0
		End if 
		
	: ($1="ASSIGNTOTALS")
		Assgn_Des_Salary:=[Work_Estimate:103]Cat1Rate:7*(Assgn_Tot_1-item_900_tot_1)
		Assgn_Des_Salary:=Assgn_Des_Salary+([Work_Estimate:103]Cat2Rate:8*(Assgn_Tot_2-item_900_tot_2))
		Assgn_Des_Salary:=Assgn_Des_Salary+([Work_Estimate:103]Cat3Rate:9*(Assgn_Tot_3-item_900_tot_3))
		Assgn_Des_Salary:=Assgn_Des_Salary+([Work_Estimate:103]Cate4Rate:10*(Assgn_Tot_4-item_900_tot_4))
		Assgn_Des_Salary:=Assgn_Des_Salary+([Work_Estimate:103]Cat5Rate:11*(Assgn_Tot_5-item_900_tot_5))
		Assgn_Des_Salary:=Assgn_Des_Salary+([Work_Estimate:103]Cat6Rate:45*(Assgn_Tot_7-item_900_tot_7))
		Assgn_Des_Indir:=(Assgn_Des_Salary*[Work_Estimate:103]IndirectCostPct:12)/100
		Assgn_Des_Net:=((Assgn_Des_Salary+Assgn_Des_Indir)*[Work_Estimate:103]NetFeePct:13)/100
		Assgn_Des_TLF:=Assgn_Des_Salary+Assgn_Des_Indir+Assgn_Des_Net
		Assgn_Des_MaxPay:=Assgn_Des_TLF+[Work_Estimate:103]DirectExpenseD:14
		Assgn_Des_MaxObl:=Assgn_Des_MaxPay+[Work_Estimate:103]SpecEngineeringD:15
		
		If ([Work_Estimate:103]Version_L:47>0)
			Assgn_Cons_Salary:=[Work_Estimate:103]ConstCat1Rate:40*(item_900_tot_1)
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]ConstCat2Rate:41*(item_900_tot_2))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]ConstCat3Rate:42*(item_900_tot_3))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]ConstCat4Rate:43*(item_900_tot_4))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]ConstCat5Rate:44*(item_900_tot_5))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]ConstCat6Rate:46*(item_900_tot_7))
		Else 
			Assgn_Cons_Salary:=[Work_Estimate:103]Cat1Rate:7*(item_900_tot_1)
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]Cat2Rate:8*(item_900_tot_2))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]Cat3Rate:9*(item_900_tot_3))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]Cate4Rate:10*(item_900_tot_4))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]Cat5Rate:11*(item_900_tot_5))
			Assgn_Cons_Salary:=Assgn_Cons_Salary+([Work_Estimate:103]Cat6Rate:45*(item_900_tot_7))
		End if 
		Assgn_Cons_Indir:=(Assgn_Cons_Salary*[Work_Estimate:103]IndirectCostPct:12)/100
		Assgn_Cons_Net:=((Assgn_Cons_Salary+Assgn_Cons_Indir)*[Work_Estimate:103]NetFeePct:13)/100
		Assgn_Cons_TLF:=Assgn_Cons_Salary+Assgn_Cons_Indir+Assgn_Cons_Net
		Assgn_Cons_MaxPay:=Assgn_Cons_TLF+[Work_Estimate:103]DirectExpenseC:27
		Assgn_Cons_MaxObl:=Assgn_Cons_MaxPay+[Work_Estimate:103]SpecEngineeringC:28
		
		Assgn_Tot_Direct:=[Work_Estimate:103]DirectExpenseD:14+[Work_Estimate:103]DirectExpenseC:27
		Assgn_Tot_SpecEng:=[Work_Estimate:103]SpecEngineeringD:15+[Work_Estimate:103]SpecEngineeringC:28
		Assgn_Tot_Salary:=Assgn_Des_Salary+Assgn_Cons_Salary
		Assgn_Tot_Indir:=Assgn_Des_Indir+Assgn_Cons_Indir
		Assgn_Tot_Net:=Assgn_Des_Net+Assgn_Cons_Net
		Assgn_Tot_TLF:=Assgn_Tot_Salary+Assgn_Tot_Indir+Assgn_Tot_Net
		Assgn_Tot_MaxPay:=Assgn_Tot_TLF+Assgn_Tot_Direct
		Assgn_Tot_MaxObl:=Assgn_Tot_MaxPay+Assgn_Tot_SpecEng
		Assgn_Tot_SAY:=Trunc:C95(Assgn_Tot_MaxObl; -2)
End case 