//%attributes = {"invisible":true}
If (False:C215)
	//copy from M_RPC_Report
	//Use the current selection and print a report
	//This version uses Print Layout to completely control printing.
	// ----------------------------------------------------
	// M_ContractRpt_Cost
	// User name (OS): cjmiller
	// Date and time: 03/29/05, 16:12:33
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM02  //03/29/05, 16:12:38 
	// Modified by: costasmanousakis-(Designer)-(9/19/2006 16:11:55)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(9/12/2007 11:23:22)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/31/09 10:37:50)
	Mods_2009_12
	//  `Changed header to Massschusetts DOT...
	Mods_2011_06  // CJ Miller`06/14/11, 10:21:04      ` Type all local variables for v11
End if 

C_LONGINT:C283($i; $countAssignNo; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH; $PixD; $PixF; $PixDCount)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vRptHeader; vRptDescr; vRateInfo)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_REAL:C285(vSalaryCost; vIndirectCost; vNetFee; vLimitFee; vDirectExpense; vTotal)
C_REAL:C285(vSumSC; vSumIC; vSumNF; vSumLF; vSumDE; vSumTotal)
C_REAL:C285($TotalFundsSC; $TotalFundsIC; $TotalFundsNF; $TotalFundsLF; $TotalFundsDE; $TotalFundsTotal)
C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($Recs)
$PixPage:=551
$PixH:=71  //header height
$PixD:=15  //detail height
$PixF:=18  //footer height
$PixDCount:=0  //counter for detail height

//```````````` ````````````` ````````````` ````````````` `````````````
//````Retrieve assignment numbers for the selected contract
//```````````` ````````````` ````````````` ````````````` `````````````
$Recs:=Records in set:C195("UserSet")

If (Not:C34($Recs=1))
	ALERT:C41("Please select one contract to generate this report!")
Else 
	G_PrintOptions(2)
	PRINT SETTINGS:C106
	If (Ok=1)  //check to see if canceled from Print Settings    
		
		COPY NAMED SELECTION:C331([Contracts:79]; "PrePrintContractList")
		USE SET:C118("UserSet")
		
		QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1)
		$countAssignNo:=Records in selection:C76([Contract Assignments:83])
		ARRAY INTEGER:C220($aiAssignNo; $countAssignNo)
		DISTINCT VALUES:C339([Contract Assignments:83]AssignNo:2; $aiAssignNo)
		SORT ARRAY:C229($aiAssignNo)
		
		//```` Report Header
		vRptHeader:=[Contracts:79]ConsltName:3+<>sCR+"Massachusetts DOT - Highway Department"+<>sCR+"Bridge "
		$type:=Substring:C12([Contracts:79]ContractType:2; Position:C15(" "; [Contracts:79]ContractType:2)+1; Length:C16([Contracts:79]ContractType:2))
		If ($type="Inspection")
			vRptHeader:=vRptHeader+"Inspection"
		Else 
			vRptHeader:=vRptHeader+"Rating"
		End if 
		vRptHeader:=vRptHeader+" Cost Summary"
		vRptDate:=Current date:C33(*)
		vRptTime:=Current time:C178(*)
		
		vCurrPage:=1
		vRptPages:=1
		
		vRateInfo:="Contract No: "+[Contracts:79]ContractNo:1
		vRateInfo:=vRateInfo+<>sCR+"Overhead Rate: "+String:C10([Contracts:79]OverheadRate:10)+"%"
		vRateInfo:=vRateInfo+<>sCR+"Net Fee Rate: "+String:C10([Contracts:79]NetFeeRate:11)+"%"
		$PixH:=Print form:C5([Contracts:79]; "Rpt Cost Summary Header")
		
		//``````` Detail 1
		vSumSC:=0
		vSumIC:=0
		vSumNF:=0
		vSumLF:=0
		vSumDE:=0
		vSumTotal:=0
		
		//following local variables store the Available Funds
		//= total funds to date - total spent to date
		$TotalFundsSC:=0
		$TotalFundsIC:=0
		$TotalFundsNF:=0
		$TotalFundsLF:=0
		$TotalFundsDE:=0
		$TotalFundsTotal:=0
		
		//``````` Max. Original Allowable Section
		vAssignDesc:="Max. Original Allowable"
		vLimitFee:=[Contracts:79]InitContractTotalLimitFee:14
		vSalaryCost:=[Contracts:79]InitContractSalary:13
		vIndirectCost:=vSalaryCost*([Contracts:79]OverheadRate:10/100)
		vNetFee:=(vSalaryCost+vIndirectCost)*([Contracts:79]NetFeeRate:11/100)
		vDirectExpense:=[Contracts:79]InitContractTotDirctExpense:15
		vTotal:=[Contracts:79]InitContractTotal:12
		
		$PixD:=Print form:C5([Contracts:79]; "Rpt Cost Summary Detail")
		$PixDCount:=$PixDCount+$PixD
		
		//````````````running sum of total spent to date    
		vSumSC:=vSumSC+vSalaryCost
		vSumIC:=vSumIC+vIndirectCost
		vSumNF:=vSumNF+vNetFee
		vSumLF:=vSumLF+vLimitFee
		vSumDE:=vSumDE+vDirectExpense
		vSumTotal:=vSumTotal+vTotal
		
		//```````` Additional Funds Section
		QUERY:C277([Contract AddFund:82]; [Contract AddFund:82]ContractNo:1=[Contracts:79]ContractNo:1)
		For ($i; 1; Records in selection:C76([Contract AddFund:82]))
			vAssignDesc:=""
			If ([Contract AddFund:82]DateApproval:5=!00-00-00!)
			Else 
				vAssignDesc:="Additional Fund ("+String:C10($i)+")"
				If ([Contract AddFund:82]TotalLimitFee:6=0)
					vLimitFee:=0
					vSalaryCost:=0
					vIndirectCost:=0
					vNetFee:=0
				Else 
					vLimitFee:=[Contract AddFund:82]TotalLimitFee:6
					//calculate the rest  
					vSalaryCost:=vLimitFee/(([Contracts:79]OverheadRate:10/100+1)*([Contracts:79]NetFeeRate:11/100+1))
					vIndirectCost:=vSalaryCost*([Contracts:79]OverheadRate:10/100)
					vNetFee:=(vSalaryCost+vIndirectCost)*([Contracts:79]NetFeeRate:11/100)
				End if 
				vDirectExpense:=[Contract AddFund:82]DirectExpense:7
				vTotal:=[Contract AddFund:82]Total:8
				
				//```````````` running sum of total spent to date    
				vSumSC:=vSumSC+vSalaryCost
				vSumIC:=vSumIC+vIndirectCost
				vSumNF:=vSumNF+vNetFee
				vSumLF:=vSumLF+vLimitFee
				vSumDE:=vSumDE+vDirectExpense
				vSumTotal:=vSumTotal+vTotal
				
				$PixD:=Print form:C5([Contracts:79]; "Rpt Cost Summary Detail")
				$PixDCount:=$PixDCount+$PixD
			End if 
			
			NEXT RECORD:C51([Contract AddFund:82])
		End for   //end of additional fund loop
		
		//`Fund transfers
		QUERY:C277([Contract FundTransfer:80]; [Contract FundTransfer:80]ContractNo:1=[Contracts:79]ContractNo:1)
		For ($i; 1; Records in selection:C76([Contract FundTransfer:80]))
			vAssignDesc:="Fund Transfer ("+String:C10($i)+")"
			Case of 
				: ([Contract FundTransfer:80]TransferDirection:6="From Limiting Fee to Direct Expense")
					vLimitFee:=-[Contract FundTransfer:80]TransferAmount:7
					vDirectExpense:=[Contract FundTransfer:80]TransferAmount:7
					
				: ([Contract FundTransfer:80]TransferDirection:6="From Direct Expense to Limiting Fee")
					vLimitFee:=[Contract FundTransfer:80]TransferAmount:7
					vDirectExpense:=-[Contract FundTransfer:80]TransferAmount:7
				Else 
			End case 
			
			vSalaryCost:=vLimitFee/(([Contracts:79]OverheadRate:10/100+1)*([Contracts:79]NetFeeRate:11/100+1))
			vIndirectCost:=vSalaryCost*([Contracts:79]OverheadRate:10/100)
			vNetFee:=(vSalaryCost+vIndirectCost)*([Contracts:79]NetFeeRate:11/100)
			vTotal:=0
			vSumSC:=vSumSC+vSalaryCost
			vSumIC:=vSumIC+vIndirectCost
			vSumNF:=vSumNF+vNetFee
			vSumLF:=vSumLF+vLimitFee
			vSumDE:=vSumDE+vDirectExpense
			$PixD:=Print form:C5([Contracts:79]; "Rpt Cost Summary Detail")
			$PixDCount:=$PixDCount+$PixD
			NEXT RECORD:C51([Contract FundTransfer:80])
		End for 
		
		//``````` Total Funds to Date
		vAssignDesc:="Total Funds to Date"
		$PixD:=Print form:C5([Contracts:79]; "Rpt Cost Summary Footer")
		$PixDCount:=$PixDCount+$PixD
		
		$TotalFundsSC:=vSumSC
		$TotalFundsIC:=vSumIC
		$TotalFundsNF:=vSumNF
		$TotalFundsLF:=vSumLF
		$TotalFundsDE:=vSumDE
		$TotalFundsTotal:=vSumTotal
		
		//``````` Detail 2: Assignments
		vSumSC:=0
		vSumIC:=0
		vSumNF:=0
		vSumLF:=0
		vSumDE:=0
		vSumTotal:=0
		
		For ($i; 1; $countAssignNo)
			
			If (($PixDCount+$PixH+$PixD)>$PixPage)
				//There is not enough room to print.              
				Print form:C5([Contracts:79]; "Rpt Cost Summary Footer Line")
				PAGE BREAK:C6(>)
				vCurrPage:=vCurrPage+1
				vRptPages:=vRptPages+1
				$PixDCount:=0
				$PixH:=Print form:C5([Contracts:79]; "Rpt Cost Summary Header")
			End if 
			
			QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=[Contracts:79]ContractNo:1; *)
			QUERY:C277([Contract Assignments:83];  & ; [Contract Assignments:83]AssignNo:2=$aiAssignNo{$i})
			vAssignDesc:=""
			If ([Contract Assignments:83]AcutalOrEstimate:20="Actual")
				vAssignDesc:="Actual "
				vSalaryCost:=[Contract Assignments:83]Actual_Salary:4
				vIndirectCost:=[Contract Assignments:83]Actual_IndirectCost:5
				vNetFee:=[Contract Assignments:83]Actual_NetFee:6
				vLimitFee:=[Contract Assignments:83]Actual_TotalLimitFee:7
				vDirectExpense:=[Contract Assignments:83]Actual_DirectExpense:8
				vTotal:=[Contract Assignments:83]Actual_Total:9
			Else 
				vAssignDesc:="Est. "
				vSalaryCost:=[Contract Assignments:83]Est_Salary:10
				vIndirectCost:=[Contract Assignments:83]Est_IndirectCost:11
				vNetFee:=[Contract Assignments:83]Est_NetFee:12
				vLimitFee:=[Contract Assignments:83]Est_TotalLimitFee:13
				vDirectExpense:=[Contract Assignments:83]Est_DirectExpense:14
				vTotal:=[Contract Assignments:83]Est_Total:15
			End if 
			vAssignDesc:=vAssignDesc+"Assignment "+String:C10($aiAssignNo{$i})
			//````````````running sum of total spent to date    
			vSumSC:=vSumSC+vSalaryCost
			vSumIC:=vSumIC+vIndirectCost
			vSumNF:=vSumNF+vNetFee
			vSumLF:=vSumLF+vLimitFee
			vSumDE:=vSumDE+vDirectExpense
			vSumTotal:=vSumTotal+vTotal
			
			$PixD:=Print form:C5([Contracts:79]; "Rpt Cost Summary Detail")
			$PixDCount:=$PixDCount+$PixD
		End for   //end of assingment # loop
		
		//``````` Total Spent to Date
		If (($PixDCount+$PixH+$PixD)>$PixPage)
			//There is not enough room to print.              
			Print form:C5([Contracts:79]; "Rpt Cost Summary Footer Line")
			PAGE BREAK:C6(>)
			vCurrPage:=vCurrPage+1
			vRptPages:=vRptPages+1
			$PixDCount:=0
			Print form:C5([Contracts:79]; "Rpt Cost Summary Header")
		End if 
		
		vAssignDesc:="Total Spent to Date"
		Print form:C5([Contracts:79]; "Rpt Cost Summary Footer")
		
		If (($PixDCount+$PixH+$PixD)>$PixPage)
			//There is not enough room to print.              
			Print form:C5([Contracts:79]; "Rpt Cost Summary Footer Line")
			PAGE BREAK:C6(>)
			vCurrPage:=vCurrPage+1
			vRptPages:=vRptPages+1
			$PixDCount:=0
			$PixH:=Print form:C5([Contracts:79]; "Rpt Cost Summary Header")
		End if 
		
		//``````` Available Funds = Total Funds - Total Spent
		vAssignDesc:="Available Funds"
		vSumSC:=$TotalFundsSC-vSumSC
		vSumIC:=$TotalFundsIC-vSumIC
		vSumNF:=$TotalFundsNF-vSumNF
		vSumLF:=$TotalFundsLF-vSumLF
		vSumDE:=$TotalFundsDE-vSumDE
		vSumTotal:=$TotalFundsTotal-vSumTotal
		Print form:C5([Contracts:79]; "Rpt Cost Summary Footer")
		PAGE BREAK:C6
		
		USE NAMED SELECTION:C332("PrePrintContractList")
		CLEAR NAMED SELECTION:C333("PrePrintContractList")
		HIGHLIGHT RECORDS:C656("UserSet")
		REDRAW WINDOW:C456
	End if 
End if 

//End M_ContractRpt_Cost
