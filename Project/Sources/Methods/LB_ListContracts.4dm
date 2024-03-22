//%attributes = {"invisible":true}
//Method: LB_ListContracts
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
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 11:29:15)
	Mods_2021_10
	//  `unload record after sorting / header click
	// Modified by: Costas Manousakis-(Designer)-(2023-06-16 12:17:39)
	Mods_2023_06_bug
	//  `when sorting by contract no , sort by formula Num(contract no)
	//  `when a record has been deleted, clear the selection and try to keep the place in the listbox
	//  `when closing a detail, release all other tables
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
		
	: (Form event code:C388=On Open Detail:K2:23)
		ut_SetWindowSize("create"; Current method name:C684)
	: (Form event code:C388=On Close Detail:K2:24)
		ut_SetWindowSize("Reset"; Current method name:C684)
		C_LONGINT:C283($recnum_L; $selected_L)
		$selected_L:=Selected record number:C246(Current form table:C627->)
		$recnum_L:=Record number:C243(Current form table:C627->)
		If ($recnum_L<0)
			//record has been deleted - need to remove it from selection
			ARRAY LONGINT:C221($recnums_aL; 0)
			SELECTION TO ARRAY:C260(Current form table:C627->; $recnums_aL)
			C_LONGINT:C283($loop_L)
			For ($loop_L; Size of array:C274($recnums_aL); 1; -1)
				If ($recnums_aL{$loop_L}<0)
					DELETE FROM ARRAY:C228($recnums_aL; $loop_L; 1)
				End if 
			End for 
			CREATE SELECTION FROM ARRAY:C640(Current form table:C627->; $recnums_aL)
			If ($selected_L>Records in selection:C76(Current form table:C627->))
				$selected_L:=Records in selection:C76(Current form table:C627->)
			End if 
			GOTO SELECTED RECORD:C245(Current form table:C627->; $selected_L)
		End if 
		UNLOAD RECORD:C212(Current form table:C627->)  // unload the record
		G_CloseAllTables(Current form table:C627)  // close all other tables except the current table
		
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
					ORDER BY FORMULA:C300([Contracts:79]; Num:C11([Contracts:79]ContractNo:1); >)
					$SortVariable_ptr->:=1
				Else 
					ORDER BY FORMULA:C300([Contracts:79]; Num:C11([Contracts:79]ContractNo:1); <)
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
		UNLOAD RECORD:C212(Current form table:C627->)
		
	: (Form event code:C388=On After Sort:K2:28)
		UNLOAD RECORD:C212(Current form table:C627->)
		
End case 

//End LB_ListContracts