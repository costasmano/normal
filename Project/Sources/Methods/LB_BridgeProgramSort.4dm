//%attributes = {"invisible":true}
//Method: LB_BridgeProgramSort
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
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	
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
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; <)
			$SortVariable_ptr->:=2
		End if 
		$0:=-1
	: ($NameofObj_txt="LB_Header2_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=$SortVariable_ptr->
	: ($NameofObj_txt="LB_Header3_l")
		
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		
	: ($NameofObj_txt="LB_Header4_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
	: ($NameofObj_txt="LB_Header5_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(PRJ_ConsName_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(PRJ_ConsName_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		
	: ($NameofObj_txt="LB_Header6_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_Program_s:23; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_Program_s:23; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header7_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NTP_d:24; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_NTP_d:24; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header8_l")
		
		C_LONGINT:C283($loop_L)
		ARRAY DATE:C224($SortBy_ad; 0)
		ARRAY DATE:C224($SortBy_ad; Size of array:C274(PRJ_RWYOver_atxt))
		For ($Loop_l; 1; Size of array:C274($SortBy_ad))
			If (v_117_014_ad{$Loop_l}=!00-00-00!)
				$SortBy_ad{$loop_L}:=v_117_005_ad{$Loop_l}
			Else 
				If (v_117_014_ad{$Loop_l}<v_117_005_ad{$Loop_l})
					$SortBy_ad{$loop_L}:=v_117_005_ad{$Loop_l}
				Else 
					$SortBy_ad{$loop_L}:=v_117_014_ad{$Loop_l}
				End if 
			End if 
			
			
		End for 
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229($SortBy_ad; \
				PRJ_ConsName_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229($SortBy_ad; \
				PRJ_ConsName_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_RWYOver_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header9_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_BidOpened_d:12; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_BidOpened_d:12; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
	: ($NameofObj_txt="LB_Header10_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(v_127_005_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(v_127_005_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_117_014_ad; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header11_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			
			SORT ARRAY:C229(v_139_059_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(v_139_059_atxt; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_117_014_ad; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		$0:=-1
		
	: ($NameofObj_txt="LB_Header12_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_Contractor:114]CTR_CompanyName_s:2; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_Contractor:114]CTR_CompanyName_s:2; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header13_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_Awarded_d:4; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_Awarded_d:4; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header14_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header15_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_Completion_d:8; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_Completion_d:8; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header16_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22; >)
			$SortVariable_ptr->:=1
		Else 
			ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_LumpSumBreakDown_d:22; <)
			$SortVariable_ptr->:=2
		End if 
		
		$0:=-1
		
	: ($NameofObj_txt="LB_Header17_l")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			SORT ARRAY:C229(v_117_014_ad; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; >)
			
			$SortVariable_ptr->:=1
		Else 
			SORT ARRAY:C229(v_117_014_ad; \
				PRJ_RWYOver_atxt; \
				PRJ_RWYUnder_atxt; \
				PRJ_ConsName_atxt; \
				v_127_005_atxt; \
				v_139_059_atxt; \
				v_115_002_aL; \
				v_117_005_ad; \
				v_115_034_atxt; \
				v_115_005_atxt; \
				v_116_004_ad; \
				v_115_006_ab; \
				v_115_001_aL; <)
			
			$SortVariable_ptr->:=2
		End if 
		LB_BridgePrgrmSetNamedSelection
		
		$0:=-1
	: ($NameofObj_txt="LB_Header18_l")
		ALERT:C41("Sorting by rating is not supported")
		$0:=-1
End case 
//End LB_BridgeProgramSort