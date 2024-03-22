//%attributes = {"invisible":true}
//Method: LB_ProjectDetailSort
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/01/20, 13:13:05
	// ----------------------------------------------------
	//Created : 
	Mods_2020_11  //Work on new project detail list box
	//Modified by: CJ (10/6/20 13:35:45)
	C_LONGINT:C283(LB_ProjectDetailSort; $0)
	
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 17:59:22)
	Mods_2021_10
	//  `initialize $0 to 0 ; remove code that is a simple sort
	
End if 
//
C_LONGINT:C283($0)
$0:=0

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
			SORT ARRAY:C229(v_115_005_atxt; \
				PRJ_ConsName_atxt; \
				PRJ_StructProjMgr_atxt; \
				v_115_002_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(v_115_005_atxt; \
				PRJ_ConsName_atxt; \
				PRJ_StructProjMgr_atxt; \
				v_115_002_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		//: ($NameofObj_txt="LB_Header2_l")
		//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_CityOrTown_s;>)
		//$SortVariable_ptr->:=1
		//Else 
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_CityOrTown_s;<)
		//$SortVariable_ptr->:=2
		//End if 
		
		//$0:=$SortVariable_ptr->
	: ($NameofObj_txt="LB_Header3_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			
			SORT ARRAY:C229(PRJ_ConsName_atxt; \
				v_115_005_atxt; \
				PRJ_StructProjMgr_atxt; \
				v_115_002_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(PRJ_ConsName_atxt; \
				v_115_005_atxt; \
				PRJ_StructProjMgr_atxt; \
				v_115_002_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		
		//: ($NameofObj_txt="LB_Header4_l")
		//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_FileNumber_l;>)
		//$SortVariable_ptr->:=1
		//Else 
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_FileNumber_l;<)
		//$SortVariable_ptr->:=2
		//End if 
		
		//$0:=-1
	: ($NameofObj_txt="LB_Header5_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(PRJ_StructProjMgr_atxt; \
				v_115_005_atxt; \
				PRJ_ConsName_atxt; \
				v_115_002_aL; >)
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(PRJ_StructProjMgr_atxt; \
				v_115_005_atxt; \
				PRJ_ConsName_atxt; \
				v_115_002_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		
		//: ($NameofObj_txt="LB_Header6_l")
		//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_Advertised_d;>)
		//$SortVariable_ptr->:=1
		//Else 
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectFile]PF_Advertised_d;<)
		//$SortVariable_ptr->:=2
		//End if 
		
		//$0:=-1
		
		//: ($NameofObj_txt="LB_Header7_l")
		//If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_Status_s;>)
		//$SortVariable_ptr->:=1
		//Else 
		//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_Status_s;<)
		//$SortVariable_ptr->:=2
		//End if 
		//$0:=-1
End case 
//End LB_BridgeProgramSort