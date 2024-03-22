//%attributes = {"invisible":true}
//Method: LB_ContractMaintenance
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/18/20, 15:26:10
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	
End if 

//
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "Contract_NO"; "Contract"+Char:C90(Carriage return:K15:38)+"No.")
		OBJECT SET TITLE:C194(*; "Contract_Type"; Char:C90(Carriage return:K15:38)+"Contract Type")
		OBJECT SET TITLE:C194(*; "Status"; Char:C90(Carriage return:K15:38)+"Status")
		OBJECT SET TITLE:C194(*; "Consultant_Name"; Char:C90(Carriage return:K15:38)+"Consultant Name")
		OBJECT SET TITLE:C194(*; "Award_Date"; "Award"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "Completion_Date"; "Completion"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "Extended_Date"; "Extended"+Char:C90(Carriage return:K15:38)+"Completion")
		OBJECT SET TITLE:C194(*; "Total_Encumbered"; "Total"+Char:C90(Carriage return:K15:38)+"Encumbered")
		OBJECT SET TITLE:C194(*; "Aprox_Remain"; "Aproximate"+Char:C90(Carriage return:K15:38)+"Remaining")
		OBJECT SET TITLE:C194(*; "Actual_Remain"; "Actual"+Char:C90(Carriage return:K15:38)+"Remaining")
		
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
	: (Form event code:C388=On Header Click:K2:40)
		
		C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
		C_LONGINT:C283($dumTbl_L; $dumFld_L)
		C_POINTER:C301($SortVariable_ptr)
		
		RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
		//$SortVariableName_txt:=Replace string($NameofObj_txt;"Header";"SortDirection")
		$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
		
		
		Case of 
			: ($NameofObj_txt="LB_Header1_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractNo:1; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header2_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractType:2; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractType:2; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header3_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractStatus:7; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ContractStatus:7; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header4_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ConsltName:3; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ConsltName:3; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header5_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]AwardContractDate:4; <)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]AwardContractDate:4; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]InitialCompleteDate:5; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]InitialCompleteDate:5; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header7_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ExtendedCompleteDate:6; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ExtendedCompleteDate:6; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header8_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]TotalEncumbered:16; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]TotalEncumbered:16; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header9_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]ApproxRemainingFund:19; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]ApproxRemainingFund:19; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header10_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([Contracts:79]; [Contracts:79]FederalFund:8; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([Contracts:79]; [Contracts:79]FederalFund:8; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
				
		End case 
		Self:C308->:=$SortVariable_ptr->
End case 

//End LB_ContractMaintenance