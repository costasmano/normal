//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 02/23/05, 15:00:00
	// ----------------------------------------------------
	// Method: G_MaintenanceCalculateTLFandDE
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(2/24/2006 12:44:49)
	Mods_2006_CM03
	Mods_2007_CJM_v5302  //r001 `10/02/07, 10:56:56
	
	// Modified by: costasmanousakis-(Designer)-(3/19/09 09:38:27)
	Mods_2009_CM_5404
	//Include cost recovery in calculations
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vTLFupdated; vDEupdated; vTLFAdditional_add; vDEAdditional_add; vTLFAdditional_transf; vDEAdditional_transf)
C_REAL:C285(vTLFPending; vTLFpending_Transf; vTLFPending_add; vDEpending; vDEpending_transf; vDEpending_add)
C_REAL:C285(vApprovConstrTLF; vMaximumAllow)
C_REAL:C285(vTLFapproxSpent; vTLFactualSpent; vTLFactualPaid; vDEapproxSpent; vDEactualSpent; vDEactualPaid)

//calculate spent amount
//same code copied from btnSave in Contract_Assignment_Maintenance
C_REAL:C285($approxSpent; $actualSpent; $retainageSpent; $CostRecovery)
$approxSpent:=0
$actualSpent:=0
$retainageSpent:=0
$CostRecovery:=0
C_REAL:C285($TLFapproxSpent; $TLFactualSpent)
$TLFapproxSpent:=0
$TLFactualSpent:=0
C_REAL:C285($DEapproxSpent; $DEactualSpent)
$DEapproxSpent:=0
$DEactualSpent:=0

vApprovConstrTLF:=0
vMaximumAllow:=0
C_LONGINT:C283($j; $k)
QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
FIRST RECORD:C50([Contract_Assignment_Maintenance:101])
For ($j; 1; Records in selection:C76([Contract_Assignment_Maintenance:101]))
	If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Actual")
		//$actualSpent:=$actualSpent+[Contract_Assignment_Maintenance]Actual_Total
		//this change reflects the construction spending
		//$TLFactualSpent:=$TLFactualSpent+[Contract_Assignment_Maintenance]Actual_TotalLimitFee+[Contract_Assignment_Maintenance]Actual_ConstrTotalLimitFee
		//$DEactualSpent:=$DEactualSpent+[Contract_Assignment_Maintenance]Actual_DirectExpense
		
		$approxSpent:=$approxSpent+[Contract_Assignment_Maintenance:101]Actual_Total:9
		//this change reflects the construction spending
		$TLFapproxSpent:=$TLFapproxSpent+[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
		$DEapproxSpent:=$DEapproxSpent+[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
		
		//calculate approved cosntruction TLF
		vApprovConstrTLF:=vApprovConstrTLF+[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
		
	Else 
		CM_CalculateNegotiatedCosts
		//$approxSpent:=$approxSpent+[Contract_Assignment_Maintenance]Est_Total
		$approxSpent:=$approxSpent+vEstTotal
		
		//this change reflects the construction spending
		//$TLFapproxSpent:=$TLFapproxSpent+[Contract_Assignment_Maintenance]Est_TotalLimitFee+[Contract_Assignment_Maintenance]Est_ConstrTotalLimitFee
		$TLFapproxSpent:=$TLFapproxSpent+vEstTotalLimitFee+vEstConstrTotalLimitFee
		
		//$DEapproxSpent:=$DEapproxSpent+[Contract_Assignment_Maintenance]Est_DirectExpense
		$DEapproxSpent:=$DEapproxSpent+vEstDirectExpense
		
		//calculate approved cosntruction TLF
		vApprovConstrTLF:=vApprovConstrTLF+vEstConstrTotalLimitFee
		
	End if 
	//$actualSpent:=$actualSpent+[Contract_Assignment_Maintenance]Actual_Total
	NEXT RECORD:C51([Contract_Assignment_Maintenance:101])
End for 

//invoices
QUERY:C277([Invoice_Maintenance:95]; [Invoice_Maintenance:95]ContractNo:3=[Contract_Maintenance:97]ContractNo:1)
For ($k; 1; Records in selection:C76([Invoice_Maintenance:95]))
	GOTO SELECTED RECORD:C245([Invoice_Maintenance:95]; $k)
	
	$TLFactualSpent:=$TLFactualSpent+[Invoice_Maintenance:95]TotalLimFeeDes:8+[Invoice_Maintenance:95]TotalLimFeeConstr:14
	$DEactualSpent:=$DEactualSpent+[Invoice_Maintenance:95]DirectExpenses:15
	$retainageSpent:=$retainageSpent+[Invoice_Maintenance:95]Retainage:16
	$actualSpent:=$actualSpent+[Invoice_Maintenance:95]TotalAmount:11
	$CostRecovery:=$CostRecovery+[Invoice_Maintenance:95]CostRecovery:17
	//NEXT RECORD([Invoice_Maintenance])
End for 

//Total Encumbered  
[Contract_Maintenance:97]ApproxSpent:17:=$approxSpent
[Contract_Maintenance:97]ApproxRemainingFund:19:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ApproxSpent:17
[Contract_Maintenance:97]ActualSpent:18:=$actualSpent
[Contract_Maintenance:97]ActualRemainingFund:20:=[Contract_Maintenance:97]TotalEncumbered:16-[Contract_Maintenance:97]ActualSpent:18

//Total Limiting Fee  
vTLFapproxSpent:=$TLFapproxSpent
vTLFactualSpent:=$TLFactualSpent  //this total amount is obtained from the invoices
vTLFactualPaid:=$TLFactualSpent-$retainageSpent-$CostRecovery

//Direct Expense
vDEactualPaid:=$DEactualSpent
vDEapproxSpent:=$DEapproxSpent
vDEactualSpent:=$DEactualSpent  //this total amount is obtained from the invoices

CM_RecalcAddFunds

CM_RecalcFundTransf

//calculate maximum allow based on approved cosntruction TLF
vMaximumAllow:=vTLFupdated-vApprovConstrTLF
//Total Paid
vTLFapproxRemaining:=vTLFupdated-vTLFapproxSpent
vTLFactualRemaining:=vTLFupdated-vTLFactualSpent
vDEapproxRemaining:=vDEupdated-vDEapproxSpent
vDEactualRemaining:=vDEupdated-vDEactualSpent
vActualPaid:=vTLFactualPaid+vDEactualPaid

C_LONGINT:C283($blackColor; $redColor)
$blackColor:=-(Black:K11:16+(256*White:K11:1))
$redColor:=-(Red:K11:4+(256*White:K11:1))

If (vTLFapproxRemaining<0)
	OBJECT SET RGB COLORS:C628(vTLFapproxRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFapproxRemaining; $redColor)
Else 
	OBJECT SET RGB COLORS:C628(vTLFapproxRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFapproxRemaining; $blackColor)
End if 

If (vTLFactualRemaining<0)
	OBJECT SET RGB COLORS:C628(vTLFactualRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFactualRemaining; $redColor)
Else 
	OBJECT SET RGB COLORS:C628(vTLFactualRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vTLFactualRemaining; $blackColor)
End if 


If (vDEapproxRemaining<0)
	OBJECT SET RGB COLORS:C628(vDEapproxRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vDEapproxRemaining; $redColor)
Else 
	OBJECT SET RGB COLORS:C628(vDEapproxRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vDEapproxRemaining; $blackColor)
End if 

If (vDEactualRemaining<0)
	OBJECT SET RGB COLORS:C628(vDEactualRemaining; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(vDEactualRemaining; $redColor)
Else 
	OBJECT SET RGB COLORS:C628(vDEactualRemaining; Col_paletteToRGB(Abs:C99($blackColor)%256); Col_paletteToRGB(Abs:C99($blackColor)\256))  // **Replaced o OBJECT SET COLOR(vDEactualRemaining; $blackColor)
End if 