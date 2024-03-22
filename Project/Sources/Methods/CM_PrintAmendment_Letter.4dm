//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintAmendment_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:17)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(10/5/2007 16:54:20)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/4/08 10:02:45)
	Mods_2008_CM_5402
	//  `Modified to allow saving of record in order to continue with the printing of the letter.
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vConsultantName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vChiefEngineer; vSectionHead)  // Command Replaced was o_C_STRING length was 100
C_DATE:C307(vToday)
C_REAL:C285(vTotal; vTotalLimitFee; vDirectExpense; v_CMT_FiscalYear_L)
C_BOOLEAN:C305($DoLetter_b)
$DoLetter_b:=True:C214
If (Is new record:C668([AddFund_Maintenance:99]))
	$DoLetter_b:=False:C215
	C_TEXT:C284($msg)
	$msg:="You must first save this Additional Funds record "+"before generating the letter."
	$msg:="Do you want to Save?"
	CONFIRM:C162($msg; "Save"; "Cancel Letter")
	If (OK=1)
		If (False:C215)
			If (Is new record:C668([AddFund_Maintenance:99]))
				LogNewRecord(->[Contract_Maintenance:97]ContractNo:1; ->[AddFund_Maintenance:99]ContractNo:1; ->[AddFund_Maintenance:99]AddFund_ID:2; 1; "AddFundMaint")
			End if 
		End if 
		SAVE RECORD:C53([AddFund_Maintenance:99])
		C_LONGINT:C283($CurrentRec_L)
		$CurrentRec_L:=[AddFund_Maintenance:99]AddFund_ID:2  //Need to do this 'cause the recalc could change the record
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		CM_RecalcAddFunds
		QUERY:C277([AddFund_Maintenance:99]; [AddFund_Maintenance:99]AddFund_ID:2=$CurrentRec_L)
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		$DoLetter_b:=True:C214
	End if 
End if 
If ($DoLetter_b)
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_Amendment")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		If ([AddFund_Maintenance:99]FiscalYear:9=0)
			C_TEXT:C284($FYrequest)
			$FYrequest:=Request:C163("Please specify Fiscal Year in which funds are to be added!")
			If (OK=1)
				v_CMT_FiscalYear_L:=Num:C11($FYrequest)
				[AddFund_Maintenance:99]FiscalYear:9:=Num:C11($FYrequest)
			End if 
		Else 
			v_CMT_FiscalYear_L:=[AddFund_Maintenance:99]FiscalYear:9
		End if 
		
		vToday:=Current date:C33(*)
		vContractNo:=[Contract_Maintenance:97]ContractNo:1
		vConsultantName:=[Contract_Maintenance:97]ConsultantName:3
		vChiefEngineer:=CM_GetChiefEngineer
		vSectionHead:=CM_GetSectionHead
		vTotal:=[AddFund_Maintenance:99]Total:8
		vTotalLimitFee:=[AddFund_Maintenance:99]TotalLimitFee:6
		vDirectExpense:=[AddFund_Maintenance:99]DirectExpense:7
		CM_GetPersonnelData
		G_WP_MakeDocument
	End if 
	
	REDRAW WINDOW:C456
End if 