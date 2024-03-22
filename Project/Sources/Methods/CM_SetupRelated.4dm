//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/14/06, 14:44:00
	// ----------------------------------------------------
	// Method: CM_SetupRelated
	// Description
	// 
	// 
	// Parameters
	// $1 : PageNo : Current Form Page ( -1 for all pages)
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(11/14/08 14:03:46)
	Mods_2008_CM_5404
	//Clear the selection of [Contract_Project_Maintenance] if there are no [Contract_Assignment_Maintenance]
End if 
C_LONGINT:C283($1; $PageNo)  //Command Replaced was o_C_INTEGER
$PageNo:=$1
Case of 
	: ($PageNo=1)
	: ($PageNo=2)
		QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]ContractNo:1=[Contract_Maintenance:97]ContractNo:1)
		ORDER BY:C49([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]AssignNo:2; >)
	: ($PageNo=3)
		CM_SetupRelated(2)
		If (Records in selection:C76([Contract_Assignment_Maintenance:101])>0)
			RELATE MANY SELECTION:C340([Contract_Project_Maintenance:100]AssignID:13)
			ORDER BY:C49([Contract_Project_Maintenance:100]; [Contract_Project_Maintenance:100]AssignNo:9; >; [Contract_Project_Maintenance:100]BIN:5; >)
		Else 
			REDUCE SELECTION:C351([Contract_Project_Maintenance:100]; 0)
		End if 
	: ($PageNo=4)
		ORDER BY:C49([Invoice_Maintenance:95]; [Invoice_Maintenance:95]InvoiceNo:2; <)
	: ($PageNo=5)
		ORDER BY:C49([FundTransfer_Maintenance:96]; [FundTransfer_Maintenance:96]DateApproval:5; >)
		//ORDER BY([FundTransfer_Maintenance];[FundTransfer_Maintenance]TOF_ID;>)
		ORDER BY:C49([AddFund_Maintenance:99]; [AddFund_Maintenance:99]DateApproval:5; >)
	: ($PageNo=6)
		ORDER BY:C49([ExtendTime_Maintenance:98]; [ExtendTime_Maintenance:98]InitialDate:6; >)
	: ($PageNo=-1)
		CM_SetupRelated(3)  //3 does 2 and 3
		CM_SetupRelated(4)
		CM_SetupRelated(5)
		CM_SetupRelated(6)
		
End case 
