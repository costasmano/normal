//%attributes = {"invisible":true}
//Method: LB_DCMContractMaintenance
//Description
// Objecy method for DCM Contract maintenance LB
// Parameters
// $0 : LongReturnCode
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 06/30/20, 14:43:24
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_LONGINT:C283(LB_DCMContractMaintenance; $0)
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	
End if 
//
C_LONGINT:C283($0)
$0:=0
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET TITLE:C194(*; "Contract_NO"; "Contract"+Char:C90(Carriage return:K15:38)+"No.")
		OBJECT SET TITLE:C194(*; "Proj_Info"; "Proj Info"+Char:C90(Carriage return:K15:38)+"No")
		OBJECT SET TITLE:C194(*; "Status"; Char:C90(Carriage return:K15:38)+"Status")
		OBJECT SET TITLE:C194(*; "Consultant_Name"; Char:C90(Carriage return:K15:38)+"Consultant Name")
		OBJECT SET TITLE:C194(*; "Award_Date"; "Award"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "Completion_Date"; "Completion"+Char:C90(Carriage return:K15:38)+"Date")
		OBJECT SET TITLE:C194(*; "Extended_Date"; "Extended"+Char:C90(Carriage return:K15:38)+"Completion")
		OBJECT SET TITLE:C194(*; "Total_Encumbered"; "Total"+Char:C90(Carriage return:K15:38)+"Encumbered")
		OBJECT SET TITLE:C194(*; "Aprox_Remain"; "Aproximate"+Char:C90(Carriage return:K15:38)+"Remaining")
		OBJECT SET TITLE:C194(*; "Actual_Remain"; "Actual"+Char:C90(Carriage return:K15:38)+"Remaining")
		
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
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractNo:1; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header2_l")
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
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					SORT ARRAY:C229($PinfoNos_aL; $contrRecs_aL; >)
					$SortVariable_ptr->:=1
				Else 
					SORT ARRAY:C229($PinfoNos_aL; $contrRecs_aL; <)
					$SortVariable_ptr->:=2
				End if 
				CREATE SELECTION FROM ARRAY:C640([DCM_Contracts:136]; $contrRecs_aL)
				
				$0:=-1
			: ($NameofObj_txt="LB_Header3_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractStatus:7; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ContractStatus:7; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header4_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ConsultantName:3; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ConsultantName:3; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header5_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]AwardContractDate:4; <)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]AwardContractDate:4; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header6_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]InitialCompleteDate:5; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]InitialCompleteDate:5; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header7_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ExtendedCompleteDate:6; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ExtendedCompleteDate:6; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header8_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]TotalEncumbered:16; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]TotalEncumbered:16; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
			: ($NameofObj_txt="LB_Header9_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ApproxRemainingFund:19; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ApproxRemainingFund:19; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
			: ($NameofObj_txt="LB_Header10_l")
				If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ActualRemainingFund:20; >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY:C49([DCM_Contracts:136]; [DCM_Contracts:136]ActualRemainingFund:20; <)
					$SortVariable_ptr->:=2
				End if 
				$0:=-1
				
				
		End case 
		Self:C308->:=$SortVariable_ptr->
End case 

//End LB_DCMContractMaintenance