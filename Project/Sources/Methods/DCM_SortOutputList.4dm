//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/01/09, 12:05:26
	// ----------------------------------------------------
	// Method: DCM_SortOutputList
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task ("INiT" ; "SORT")
	// ----------------------------------------------------
	
	Mods_2010_05
	// Modified by: costasmanousakis-(Designer)-(6/11/10 14:04:24)
	Mods_2010_06
	//  `Make default Task to "SORT"
End if 

C_TEXT:C284($1; $Task)
If (Count parameters:C259>0)
	$Task:=$1
Else 
	$Task:="SORT"
End if 

Case of 
	: ($Task="INIT")
		C_LONGINT:C283(vSortContract; vSortType; vSortStatus; vSortName; vSortADate; vSortCDate; vSortEDate; vSortTotal; vSortApprox; vSortActual; vSortProjInfo)
		ARRAY POINTER:C280(DCM_SortVariables_aptr; 11)
		
		DCM_SortVariables_aptr{1}:=->vSortContract
		DCM_SortVariables_aptr{2}:=->vSortType
		DCM_SortVariables_aptr{3}:=->vSortStatus
		DCM_SortVariables_aptr{4}:=->vSortName
		DCM_SortVariables_aptr{5}:=->vSortADate
		DCM_SortVariables_aptr{6}:=->vSortCDate
		DCM_SortVariables_aptr{7}:=->vSortEDate
		DCM_SortVariables_aptr{8}:=->vSortTotal
		DCM_SortVariables_aptr{9}:=->vSortApprox
		DCM_SortVariables_aptr{10}:=->vSortActual
		DCM_SortVariables_aptr{11}:=->vSortProjInfo
		
		
	: ($Task="SORT")
		If (Count parameters:C259>1)
			C_POINTER:C301($2)
			C_LONGINT:C283($loop)
			For ($loop; 1; Size of array:C274(DCM_SortVariables_aptr))
				If (DCM_SortVariables_aptr{$loop}#$2)
					DCM_SortVariables_aptr{$loop}->:=0
				End if 
				
			End for 
			
		End if 
		
		Case of 
				
			: (vSortContract=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; >)
			: (vSortType=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractType:8; >)
			: (vSortStatus=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractStatus:7; >)
			: (vSortName=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ConsultantName:3; >)
			: (vSortADate=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]AwardContractDate:4; >)
			: (vSortCDate=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]InitialCompleteDate:5; >)
			: (vSortEDate=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ExtendedCompleteDate:6; >)
			: (vSortTotal=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]TotalEncumbered:16; >)
			: (vSortApprox=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ApproxRemainingFund:19; >)
			: (vSortActual=1)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ActualRemainingFund:20; >)
			: (vSortProjInfo=1)
				DCM_SortOutputList("LOADPINFOS")
				
			: (vSortContract=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; <)
			: (vSortType=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractType:8; <)
			: (vSortStatus=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractStatus:7; <)
			: (vSortName=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ConsultantName:3; <)
			: (vSortADate=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]AwardContractDate:4; <)
			: (vSortCDate=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]InitialCompleteDate:5; <)
			: (vSortEDate=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ExtendedCompleteDate:6; <)
			: (vSortTotal=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]TotalEncumbered:16; <)
			: (vSortApprox=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ApproxRemainingFund:19; <)
			: (vSortActual=2)
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ActualRemainingFund:20; <)
			: (vSortProjInfo=2)
				DCM_SortOutputList("LOADPINFOS")
			Else 
				ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; >)
				vSortContract:=1
		End case 
		
		
	: ($Task="LOADPINFOS")
		ARRAY LONGINT:C221($contrRecs_aL; Records in selection:C76([DCM_Contracts:136]))
		ARRAY TEXT:C222($contrNums_atxt; Records in selection:C76([DCM_Contracts:136]))
		ARRAY LONGINT:C221($PinfoNos_aL; Records in selection:C76([DCM_Contracts:136]))
		SELECTION TO ARRAY:C260([DCM_Contracts:136]; $contrRecs_aL; [DCM_Contracts:136]ContractNo:1; $contrNums_atxt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($contrNums_atxt))
			QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=$contrNums_atxt{$loop_L})
			If (Records in selection:C76([PRJ_ConstructionProject:116])=1)
				QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
				$PinfoNos_aL{$loop_L}:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			Else 
				$PinfoNos_aL{$loop_L}:=0
			End if 
			
		End for 
		If (vSortProjInfo=1)
			SORT ARRAY:C229($PinfoNos_aL; $contrRecs_aL; >)
		Else 
			SORT ARRAY:C229($PinfoNos_aL; $contrRecs_aL; <)
		End if 
		CREATE SELECTION FROM ARRAY:C640([DCM_Contracts:136]; $contrRecs_aL)
		
End case 