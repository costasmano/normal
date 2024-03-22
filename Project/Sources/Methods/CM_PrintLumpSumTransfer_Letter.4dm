//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintLumpSumTransfer_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:17)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/20/2007 16:05:27)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vConsultantName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vChiefEngineer; vSectionHead)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vFromAccount; vToAccount)  // Command Replaced was o_C_STRING length was 100
C_DATE:C307(vToday; vDateRequested)
C_REAL:C285(vOrigl_TLF; vOrigl_DE)
C_REAL:C285(vRev_TLF; vRev_DE)
C_REAL:C285(vMaxAmount; vTotalAmt)
C_REAL:C285(vAmtTransferred; vTransf_TLF; vTransf_DE)
C_BOOLEAN:C305($bIsPrinted)


If (Is new record:C668([Contract_Assignment_Maintenance:101]))
	ALERT:C41("You have to create Fund Transfer record and save it before generating the letter.")
Else 
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_LumpSumTransfer")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		vToday:=Current date:C33(*)
		vDateRequested:=[FundTransfer_Maintenance:96]DateCsltLetter:3
		vContractNo:=[Contract_Maintenance:97]ContractNo:1
		vConsultantName:=[Contract_Maintenance:97]ConsultantName:3
		vChiefEngineer:=CM_GetChiefEngineer
		vSectionHead:=CM_GetSectionHead
		CM_GetPersonnelData
		vAmtTransferred:=[FundTransfer_Maintenance:96]TransferAmount:7
		$bIsPrinted:=True:C214
		
		vOrigl_TLF:=0
		vOrigl_DE:=0
		vRev_TLF:=0
		vRev_DE:=0
		
		Case of 
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Limiting Fee to Direct Expense")
				vFromAccount:="total limiting fee"
				vToAccount:="direct expense"
				vTransf_TLF:=-[FundTransfer_Maintenance:96]TransferAmount:7
				vTransf_DE:=[FundTransfer_Maintenance:96]TransferAmount:7
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Direct Expense to Limiting Fee")
				vFromAccount:="direct expense"
				vToAccount:="total limiting fee"
				vTransf_TLF:=[FundTransfer_Maintenance:96]TransferAmount:7
				vTransf_DE:=-[FundTransfer_Maintenance:96]TransferAmount:7
			Else 
				$bIsPrinted:=False:C215
				ALERT:C41("Please Select Transfer Fund Direction")
				
		End case 
		
		CM_CalFor_SumAndCost_Letter
		
		vTotalAmt:=vTransf_TLF+vTransf_DE  //total should add up to 0
		
		//calculate all the revised costs
		vRev_TLF:=vFundTransfer_StartingTLF+vFundTransfer_Sum
		vRev_DE:=vFundTransfer_StartingDE-vFundTransfer_Sum
		
		//calculate all the original costs
		//If ([FundTransfer_Maintenance]TransferDirection="From Limiting Fee to Direct Expense")
		//vOrigl_TLF:=vRev_TLF+[FundTransfer_Maintenance]TransferAmount
		//vOrigl_DE:=vRev_DE-[FundTransfer_Maintenance]TransferAmount
		//Else 
		//vOrigl_TLF:=vRev_TLF-[FundTransfer_Maintenance]TransferAmount
		//vOrigl_DE:=vRev_DE+[FundTransfer_Maintenance]TransferAmount
		//End if 
		vOrigl_TLF:=vRev_TLF  //Mods_2007_CM12_5301
		vOrigl_DE:=vRev_DE
		vRev_TLF:=vRev_TLF+vTransf_TLF
		vRev_DE:=vRev_DE+vTransf_DE
		
		vMaxAmount:=vOrigl_TLF+vOrigl_DE
		
		If ($bIsPrinted)
			G_WP_MakeDocument
			
			REDRAW WINDOW:C456
		End if 
	End if 
End if 
