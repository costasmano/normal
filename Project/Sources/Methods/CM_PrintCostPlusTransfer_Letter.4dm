//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintCostPlusTransfer_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:17)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/27/07 16:13:11)
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
C_REAL:C285(vOrigl_Sal; vOrigl_Indirect; vOrigl_NetFee; vOrigl_TLF; vOrigl_DE)
C_REAL:C285(vRev_Sal; vRev_Indirect; vRev_NetFee; vRev_TLF; vRev_DE)
C_REAL:C285(vMax_Amount; vTotalAmount)
C_REAL:C285(vTransf_Amount; vTransf_Sal; vTransf_Indirect; vTransf_NetFee; vTransf_TLF; vTransf_DE)

C_REAL:C285($overHeadRate; $netFeeRate)
C_BOOLEAN:C305($bIsPrinted)

If (Is new record:C668([Contract_Assignment_Maintenance:101]))
	ALERT:C41("You have to create Fund Transfer record and save it before generating the letter.")
Else 
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_CostPlusTransfer")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		vOrigl_Sal:=0
		vOrigl_Indirect:=0
		vOrigl_NetFee:=0
		vOrigl_TLF:=0
		vOrigl_DE:=0
		vRev_Sal:=0
		vRev_Indirect:=0
		vRev_NetFee:=0
		vRev_TLF:=0
		vRev_DE:=0
		vTransf_Sal:=0
		vTransf_Indirect:=0
		vTransf_NetFee:=0
		vTransf_TLF:=0
		vTransf_DE:=0
		vTransf_Amount:=0
		vMax_Amount:=0
		vTotalAmount:=0
		
		$bIsPrinted:=True:C214
		$overHeadRate:=[Contract_Maintenance:97]OverheadRate:10
		$netFeeRate:=[Contract_Maintenance:97]NetFeeRate:11
		
		vToday:=Current date:C33(*)
		vDateRequested:=[FundTransfer_Maintenance:96]DateCsltLetter:3
		vContractNo:=[Contract_Maintenance:97]ContractNo:1
		vConsultantName:=[Contract_Maintenance:97]ConsultantName:3
		vChiefEngineer:=CM_GetChiefEngineer
		vSectionHead:=CM_GetSectionHead
		CM_GetPersonnelData
		//```````Calculating salary, indirect cost and net fee from vTransf_Amount variable````````
		vTransf_Amount:=[FundTransfer_Maintenance:96]TransferAmount:7
		C_REAL:C285($temp1)
		$temp1:=Round:C94(vTransf_Amount/(($overHeadRate/100+1)*($netFeeRate/100+1)); 2)
		
		If (Dec:C9($temp1)=0.99)
			vTransf_Sal:=Round:C94($temp1; 0)
		Else 
			vTransf_Sal:=$temp1
		End if 
		
		$temp1:=Round:C94(vTransf_Sal*($overHeadRate/100); 2)
		If (Dec:C9($temp1)=0.99)
			vTransf_Indirect:=Round:C94($temp1; 0)
		Else 
			vTransf_Indirect:=$temp1
		End if 
		
		vTransf_NetFee:=vTransf_Amount-vTransf_Sal-vTransf_Indirect
		//```````Ending the calculation
		Case of 
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Limiting Fee to Direct Expense")
				vFromAccount:="direct salary, indirect costs, and net fee"
				vToAccount:="direct expense"
				vTransf_Sal:=-vTransf_Sal
				vTransf_Indirect:=-vTransf_Indirect
				vTransf_NetFee:=-vTransf_NetFee
				vTransf_TLF:=vTransf_Sal+vTransf_Indirect+vTransf_NetFee
				vTransf_DE:=-vTransf_TLF
			: ([FundTransfer_Maintenance:96]TransferDirection:6="From Direct Expense to Limiting Fee")
				vFromAccount:="direct expense"
				vToAccount:="direct salary, indirect costs, and net fee"
				vTransf_TLF:=vTransf_Sal+vTransf_Indirect+vTransf_NetFee
				vTransf_DE:=-vTransf_TLF
			Else 
				$bIsPrinted:=False:C215
				ALERT:C41("Please Select Transfer Fund Direction")
				
		End case 
		
		CM_CalFor_SumAndCost_Letter
		
		vTotalAmount:=vTransf_TLF+vTransf_DE  //always equals to 0
		
		//calculate all the revised costs
		vRev_TLF:=vFundTransfer_StartingTLF+vFundTransfer_Sum
		vRev_DE:=vFundTransfer_StartingDE-vFundTransfer_Sum
		
		vMax_Amount:=vRev_TLF+vRev_DE
		
		//```````Calculating salary, indirect cost and net fee from vRev_TLF variable````````
		C_REAL:C285($temp2)
		$temp2:=Round:C94(vRev_TLF/(($overHeadRate/100+1)*($netFeeRate/100+1)); 2)
		
		If (Dec:C9($temp2)=0.99)
			vRev_Sal:=Round:C94($temp2; 0)
		Else 
			vRev_Sal:=$temp2
		End if 
		
		$temp2:=Round:C94(vRev_Sal*($overHeadRate/100); 2)
		If (Dec:C9($temp2)=0.99)
			vRev_Indirect:=Round:C94($temp2; 0)
		Else 
			vRev_Indirect:=$temp2
		End if 
		
		vRev_NetFee:=vRev_TLF-vRev_Sal-vRev_Indirect
		//```````Ending the calculation
		//Calculate original values  
		vOrigl_Sal:=vRev_Sal  //Mods_2007_CM12_5301
		vOrigl_Indirect:=vRev_Indirect
		vOrigl_NetFee:=vRev_NetFee
		vOrigl_TLF:=vRev_TLF
		vOrigl_DE:=vRev_DE
		
		vRev_Sal:=vRev_Sal+vTransf_Sal
		vRev_Indirect:=vRev_Indirect+vTransf_Indirect
		vRev_NetFee:=vRev_NetFee+vTransf_NetFee
		vRev_TLF:=vRev_TLF+vTransf_TLF
		vRev_DE:=vRev_DE+vTransf_DE
		
		If ($bIsPrinted)
			G_WP_MakeDocument
			
			REDRAW WINDOW:C456
		End if 
	End if 
End if 