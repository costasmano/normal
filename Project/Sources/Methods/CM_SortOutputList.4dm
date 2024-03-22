//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/17/05, 08:40:02
	// ----------------------------------------------------
	// Method: CM_SortOutputList
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(1/7/08 12:00:41)
	Mods_2007_CM_5401
End if 

C_LONGINT:C283(vSortContract; vSortType; vSortStatus; vSortName; vSortADate; vSortCDate; vSortEDate; vSortTotal; vSortApprox; vSortActual)

Case of 
		
	: (vSortContract=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1; >)
	: (vSortType=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractType:8; >)
	: (vSortStatus=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractStatus:7; >)
	: (vSortName=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ConsultantName:3; >)
	: (vSortADate=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]AwardContractDate:4; >)
	: (vSortCDate=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]InitialCompleteDate:5; >)
	: (vSortEDate=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ExtendedCompleteDate:6; >)
	: (vSortTotal=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]TotalEncumbered:16; >)
	: (vSortApprox=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ApproxRemainingFund:19; >)
	: (vSortActual=1)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ActualRemainingFund:20; >)
		
	: (vSortContract=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1; <)
	: (vSortType=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractType:8; <)
	: (vSortStatus=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractStatus:7; <)
	: (vSortName=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ConsultantName:3; <)
	: (vSortADate=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]AwardContractDate:4; <)
	: (vSortCDate=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]InitialCompleteDate:5; <)
	: (vSortEDate=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ExtendedCompleteDate:6; <)
	: (vSortTotal=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]TotalEncumbered:16; <)
	: (vSortApprox=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ApproxRemainingFund:19; <)
	: (vSortActual=2)
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ActualRemainingFund:20; <)
	Else 
		ORDER BY:C49([Contract_Maintenance:97]; [Contract_Maintenance:97]ContractNo:1; >)
		vSortContract:=1
End case 