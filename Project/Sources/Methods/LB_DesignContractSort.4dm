//%attributes = {"invisible":true}
//Method: LB_DesignContractSort
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 11/10/20, 12:17:01
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11
	
	C_LONGINT:C283(LB_DesignContractSort; $0)
	
End if 
//
C_LONGINT:C283($0)
C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
C_LONGINT:C283($dumTbl_L; $dumFld_L)
C_POINTER:C301($SortVariable_ptr)

C_TEXT:C284($NameofObj_txt; $SortVariableName_txt)
C_LONGINT:C283($dumTbl_L; $dumFld_L)
C_POINTER:C301($SortVariable_ptr)

RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
//$SortVariableName_txt:=Replace string($NameofObj_txt;"Header";"SortDirection")
$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
Case of 
	: ($NameofObj_txt="LB_Header1_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3; <)
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
		
	: ($NameofObj_txt="LB_Header2_l")
		ARRAY LONGINT:C221($RecordNumbers_aL; 0)
		ARRAY LONGINT:C221($ConsultantIds_aL; 0)
		ARRAY TEXT:C222($Names_atxt; 0)
		ARRAY TEXT:C222($SortNames_atxt; 0)
		SELECTION TO ARRAY:C260([PRJ_DesignContracts:123]; $RecordNumbers_aL; [PRJ_DesignContracts:123]ConsultantNameID_l:2; $ConsultantIds_aL)
		QUERY WITH ARRAY:C644([Conslt_Name:127]ConsultantNameID_l:1; $ConsultantIds_aL)
		SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; $NameID_aL; [Conslt_Name:127]ConsultantName_s:2; $Names_atxt)
		ARRAY TEXT:C222($SortNames_atxt; Size of array:C274($RecordNumbers_aL))
		C_LONGINT:C283($loop_L; $Pos_L)
		For ($loop_L; 1; Size of array:C274($RecordNumbers_aL))
			$Pos_L:=Find in array:C230($NameID_aL; $ConsultantIds_aL{$loop_L})
			If ($Pos_L>0)
				$SortNames_atxt{$loop_L}:=$Names_atxt{$Pos_L}
			Else 
				$SortNames_atxt{$loop_L}:="Unknown"
			End if 
			
		End for 
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229($SortNames_atxt; $RecordNumbers_aL; >)
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229($SortNames_atxt; $RecordNumbers_aL; <)
			$SortVariable_ptr->:=2
		End if 
		CREATE SELECTION FROM ARRAY:C640([PRJ_DesignContracts:123]; $RecordNumbers_aL; "PRJDesSelection")
		USE NAMED SELECTION:C332("PRJDesSelection")
		CLEAR NAMED SELECTION:C333("PRJDesSelection")
		$0:=-1
		
	: ($NameofObj_txt="LB_Header3_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_ESTContractAmt_r:10; >)
			
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_ESTContractAmt_r:10; <)
			
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header4_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_ActualAmount_r:6; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_ActualAmount_r:6; <)
			
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header5_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_RemainingAmount_r:7; >)
			
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_RemainingAmount_r:7; <)
			
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header6_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_EstComplete_d:11; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_EstComplete_d:11; <)
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header7_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_Description_txt:4; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_Description_txt:4; <)
			
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header8_l")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_Completion_d:8; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_Completion_d:8; <)
			
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
End case 
//End LB_DesignContractSort