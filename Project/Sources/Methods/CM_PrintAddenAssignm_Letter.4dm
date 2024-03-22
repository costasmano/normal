//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): designer
	// Date and time: 
	// ----------------------------------------------------
	// Method: CM_PrintaddenAssignm_Letter
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(8/30/2006 16:03:57)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(1/5/2007 10:34:30)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(3/1/2007 09:10:22)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/11/2007 15:35:38)
	Mods_2007_CM11
	// Modified by: costasmanousakis-(Designer)-(9/11/2007 12:52:54)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vContactName; vCompanyName; vAddress1; vAddress2)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vLastName)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vLocation)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBridgeNo)  // Command Replaced was o_C_STRING length was 50
C_DATE:C307(vToday; vDateCreated)
C_LONGINT:C283(vAssignNo; vAddendumNo)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vApprovedDesTLF; vApprovedConstrTLF; vApprovedDE; vApprovedTotal)
C_REAL:C285(vRevisedDesTLF; vRevisedConstrTLF; vRevisedDE; vRevisedTotal)

If (Is new record:C668([Contract_Assignment_Maintenance:101]))
	ALERT:C41("You have to create Addendum record and save it before generating the letter.")
Else 
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WRP_ContrMnt_AddenAssignm")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template does not exist!")
	Else 
		vContactName:="Contact_Name"
		vLastName:="Last_Name"
		vAddress1:="Address_Line_1"
		vAddress2:="Address_Line_2"
		vToday:=Current date:C33(*)
		vDateCreated:=[Addendum_Maintenance:102]DateCreated:6
		vAddendumNo:=[Addendum_Maintenance:102]AddendumNo:2
		vContractNo:=[Contract_Assignment_Maintenance:101]ContractNo:1
		vAssignNo:=[Contract_Assignment_Maintenance:101]AssignNo:2
		vCompanyName:=[Contract_Maintenance:97]ConsultantName:3
		GetBridgeEngineer
		GetConsltAddress(vCompanyName; "DESIGN")
		
		C_REAL:C285($vAssignDesTLF; $vAssignConstrTLF; $vAssignDE)
		If ([Contract_Assignment_Maintenance:101]AcutalOrEstimate:20="Actual")
			$vAssignDesTLF:=[Contract_Assignment_Maintenance:101]Actual_TotalLimitFee:25
			$vAssignConstrTLF:=[Contract_Assignment_Maintenance:101]Actual_ConstrTotalLimitFee:34
			$vAssignDE:=[Contract_Assignment_Maintenance:101]Actual_DirectExpense:26
		Else 
			$vAssignDesTLF:=[Contract_Assignment_Maintenance:101]Est_TotalLimitFee:13
			$vAssignConstrTLF:=[Contract_Assignment_Maintenance:101]Est_ConstrTotalLimitFee:30
			$vAssignDE:=[Contract_Assignment_Maintenance:101]Est_DirectExpense:14
		End if 
		
		CM_CalFor_AddenAssignm_Letter
		
		//all revised costs 
		vRevisedDesTLF:=Round:C94((vAddenDesTLF+$vAssignDesTLF); 5)
		vRevisedConstrTLF:=Round:C94((vAddenConstrTLF+$vAssignConstrTLF); 5)
		vRevisedDE:=Round:C94((vAddenDE+$vAssignDE); 5)
		vRevisedTotal:=vRevisedDesTLF+vRevisedConstrTLF+vRevisedDE
		
		//all original costs
		vApprovedDesTLF:=Round:C94((vRevisedDesTLF-[Addendum_Maintenance:102]Est_TotalLimitFee:16); 5)
		vApprovedConstrTLF:=Round:C94((vRevisedConstrTLF-[Addendum_Maintenance:102]Est_ConstrTotalLimitFee:10); 5)
		vApprovedDE:=Round:C94((vRevisedDE-[Addendum_Maintenance:102]Est_DirectExpense:11); 5)
		vApprovedTotal:=vApprovedDesTLF+vApprovedConstrTLF+vApprovedDE
		CM_GetPersonnelData
		G_WP_MakeDocument
		
	End if 
	
	REDRAW WINDOW:C456
End if 
