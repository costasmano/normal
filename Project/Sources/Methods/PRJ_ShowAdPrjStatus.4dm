//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): root
	// User name (4D): Designer
	// Date and time: 10/18/07, 11:55:36
	// ----------------------------------------------------
	// Method: PRJ_ShowAdPrjStatus
	// show the info regarding ad status
	// 
	// Parameters
	// $1 : Option
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//Added var PRJ_RatingDone_s
	Mods_2009_03  //CJM  r001   `03/06/09, 15:11:11`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(6/29/21 17:46:00)
	Mods_2021_v17
	//  `replacing 4D view constants with Write pro and string constants
End if 
C_TEXT:C284($1; $Option)
If (Count parameters:C259>0)
	$Option:=$1
Else 
	$Option:="SEARCH"
End if 

Case of 
	: ($Option="SEARCH")
		ALL RECORDS:C47([PRJ_ProjectDetails:115])
		If (Records in selection:C76([PRJ_ProjectDetails:115])>0)
			C_TEXT:C284($msg)
			C_LONGINT:C283($SearchOption)
			$Msg:="Search for Projects with BidOpen dates, or Ad Dates, or do a custom search?"
			$SearchOption:=ut_3Option_Confirm($Msg; "BidOpen"; "AdDates"; "Custom")
			SET QUERY DESTINATION:C396(Into set:K19:2; "PRJADSTATUSSET")
			Case of 
				: ($SearchOption=1)
					QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116]CP_BidOpening_d:3>!00-00-00!; *)
					QUERY SELECTION:C341([PRJ_ProjectDetails:115];  & ; [PRJ_ConstructionProject:116]CP_Awarded_d:4=!00-00-00!)
				: ($SearchOption=2)
					QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_Advertised_d:14>!00-00-00!; *)
					QUERY SELECTION:C341([PRJ_ProjectDetails:115];  & ; [PRJ_ConstructionProject:116]CP_Awarded_d:4=!00-00-00!)
				: ($SearchOption=3)
					QUERY SELECTION:C341([PRJ_ProjectDetails:115])
					
			End case 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If (OK=1)
				If (Records in set:C195("PRJADSTATUSSET")>0)
					USE SET:C118("PRJADSTATUSSET")
					CLEAR SET:C117("PRJADSTATUSSET")
					PRJ_ShowAdPrjStatus("SHOW")
				Else 
					ALERT:C41("No projects found!")
				End if 
				
			End if 
			
		Else 
		End if 
		
	: ($Option="SHOW")
		If (Not:C34(Is compiled mode:C492))
			Compiler_PRJ
			Compiler_LSTS
			Compiler_SQL
			C_TEXT:C284(PRJ_RoadwayUnder_txt; PRJ_WinTitle; PRJ_UnderConstr_txt)
			C_TEXT:C284(PRJ_DistrNo_txt)  // Command Replaced was o_C_STRING length was 2
			C_DATE:C307(PRJ_InitInsp_D)
			C_BOOLEAN:C305(PRJ_RatingDone_b)
			C_TEXT:C284(PRJ_RatingDone_s)  // Command Replaced was o_C_STRING length was 3
			PRJ_BPGM_InitDispArrays
			//Mods_2007_CJMv2   `04/30/07, 12:00:48`Fix compiler errors
		End if 
		Compiler_PRJArrays
		InitProcessVar
		UpdatWindArray(""; Current process:C322)
		READ ONLY:C145(*)
		PRJ_LoadDropDownLists
		ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
		ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
		ALL RECORDS:C47([Conslt_Name:127])
		SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)
		PRJ_ShowAdPrjStatus("INIT")
		PRJ_ShowAdPrjStatus("LOAD")
		
		C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
		C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
		C_TEXT:C284($Title_txt)
		FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; "AdStatusList"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
		$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt)
		//$win:=Open form window([PRJ_ProjectDetails];"AdStatusList";Plain window )
		DIALOG:C40([PRJ_ProjectDetails:115]; "AdStatusList")
		PRJ_ShowAdPrjStatus("INIT")
		CLOSE WINDOW:C154($Win_l)
		UpdatWindArray(""; Current process:C322)
		
	: ($Option="INIT")
		ARRAY TEXT:C222(PRJAD_BridgeNo_atxt; 0)
		ARRAY TEXT:C222(PRJAD_Town_atxt; 0)
		ARRAY TEXT:C222($PRJAD_ActBrNo_atxt; 0)
		ARRAY TEXT:C222($PRJAD_FakeBrNo_atxt; 0)
		ARRAY LONGINT:C221(PRJAD_FileNo_aL; 0)
		ARRAY DATE:C224(PRJAD_AdDate_ad; 0)
		ARRAY DATE:C224(PRJAD_BidOpen_ad; 0)
		ARRAY DATE:C224(PRJAD_PlanToPr_ad; 0)
		ARRAY DATE:C224(PRJAD_PlanFrPr_ad; 0)
		ARRAY DATE:C224(PRJAD_SpecToPr_ad; 0)
		ARRAY DATE:C224(PRJAD_SpecFrPr_ad; 0)
		ARRAY DATE:C224(PRJAD_ToCash_ad; 0)
		ARRAY TEXT:C222(PRJAD_ConsContrN_atxt; 0)
		ARRAY LONGINT:C221(PRJAD_RecNum_aL; 0)
		ARRAY LONGINT:C221(PRJAD_HelperSortArray_aL; 0)
		C_LONGINT:C283($NumArrays; $I; $NumCols)
		$NumArrays:=13
		ARRAY POINTER:C280(PRJAD_sortArrays_ap; $NumArrays)
		ARRAY LONGINT:C221(PRJAD_sortArrayOrder_aL; $NumArrays)
		$i:=1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_FileNo_aL
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_Town_atxt
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_AdDate_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_PlanToPr_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_PlanFrPr_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_SpecToPr_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_ToCash_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_SpecFrPr_ad
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_ConsContrN_atxt
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_RecNum_aL
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_HelperSortArray_aL
		PRJAD_sortArrayOrder_aL{$i}:=0
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_BidOpen_ad
		PRJAD_sortArrayOrder_aL{$i}:=1
		$i:=$i+1
		PRJAD_sortArrays_ap{$i}:=->PRJAD_BridgeNo_atxt
		PRJAD_sortArrayOrder_aL{$i}:=1
		
		$NumCols:=12
		ARRAY TEXT:C222(PRJAD_Cols_at; $NumCols)
		ARRAY TEXT:C222(PRJAD_ColNames_at; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColHorAlign_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColAlphaF_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColNumF_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColDateF_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColBoolF_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColPicF_aL; $NumCols)
		ARRAY LONGINT:C221(PRJAD_ColW_aL; $NumCols)
		
	: ($Option="LOAD")
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJAD_RecNum_aL; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PRJAD_ActBrNo_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $PRJAD_FakeBrNo_atxt; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; PRJAD_Town_atxt)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJAD_RecNum_aL; [PRJ_ProjectFile:117]PF_FileNumber_l:3; PRJAD_FileNo_aL; [PRJ_ProjectFile:117]PF_Advertised_d:14; PRJAD_AdDate_ad; [PRJ_ConstructionProject:116]CP_BidOpening_d:3; PRJAD_BidOpen_ad; [PRJ_ConstructionProject:116]CP_PlansToPrint_d:16; PRJAD_PlanToPr_ad)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJAD_RecNum_aL; [PRJ_ConstructionProject:116]CP_PlansFromPrint_d:17; PRJAD_PlanFrPr_ad; [PRJ_ConstructionProject:116]CP_SpecsToPrint_d:14; PRJAD_SpecToPr_ad; [PRJ_ConstructionProject:116]CP_SpecsFromPrint_d:15; PRJAD_SpecFrPr_ad; [PRJ_ConstructionProject:116]CP_ToCashier_d:18; PRJAD_ToCash_ad)
		SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; PRJAD_RecNum_aL; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; PRJAD_ConsContrN_atxt)
		ARRAY LONGINT:C221(PRJAD_HelperSortArray_aL; Size of array:C274(PRJAD_RecNum_aL))
		ARRAY TEXT:C222(PRJAD_BridgeNo_atxt; Size of array:C274(PRJAD_RecNum_aL))
		For ($i; 1; Size of array:C274(PRJAD_RecNum_aL))
			If ($PRJAD_ActBrNo_atxt{$i}#"")
				PRJAD_BridgeNo_atxt{$i}:=$PRJAD_ActBrNo_atxt{$i}
			Else 
				PRJAD_BridgeNo_atxt{$i}:=$PRJAD_FakeBrNo_atxt{$i}
			End if 
		End for 
		
	: ($Option="VIEWSETTINGS")
		
		C_LONGINT:C283(pv_BdeptF_L; pv_Item8F_L; pv_AASHTOF_L; pv_MoneyF_L)  //must be defined for the area
		
		$i:=1
		PRJAD_Cols_at{$i}:="PRJAD_BridgeNo_atxt"
		PRJAD_ColNames_at{$i}:="Bridge No."
		PRJAD_ColW_aL{$i}:=150
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk left  //  pv value hor alignment default
		PRJAD_ColAlphaF_aL{$i}:=0
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_RecNum_aL"
		PRJAD_ColNames_at{$i}:=""
		PRJAD_ColW_aL{$i}:=0
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk left  //pv value hor alignment default
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_Town_atxt"
		PRJAD_ColNames_at{$i}:="Town Name"
		PRJAD_ColW_aL{$i}:=130
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk left  //pv value hor alignment default
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_FileNo_aL"
		PRJAD_ColNames_at{$i}:="Prj FIle No"
		PRJAD_ColW_aL{$i}:=65
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_AdDate_ad"
		PRJAD_ColNames_at{$i}:="Ad Date"
		PRJAD_ColW_aL{$i}:=85
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_BidOpen_ad"
		PRJAD_ColNames_at{$i}:="Bid Open"
		PRJAD_ColW_aL{$i}:=85
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_PlanToPr_ad"
		PRJAD_ColNames_at{$i}:="Plans to Print"
		PRJAD_ColW_aL{$i}:=110
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_PlanFrPr_ad"
		PRJAD_ColNames_at{$i}:="Plans from Print"
		PRJAD_ColW_aL{$i}:=110
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_SpecToPr_ad"
		PRJAD_ColNames_at{$i}:="Specs to Print"
		PRJAD_ColW_aL{$i}:=110
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_SpecFrPr_ad"
		PRJAD_ColNames_at{$i}:="Specs from Print"
		PRJAD_ColW_aL{$i}:=110
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_ToCash_ad"
		PRJAD_ColNames_at{$i}:="To Cashier"
		PRJAD_ColW_aL{$i}:=85
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		PRJAD_ColDateF_aL{$i}:=System date short:K1:1  //pv Short2
		$i:=$i+1
		PRJAD_Cols_at{$i}:="PRJAD_ConsContrN_atxt"
		PRJAD_ColW_aL{$i}:=80
		PRJAD_ColNames_at{$i}:="Contract No."
		//PRJAD_ColHorAlign_aL{$i}:=wk text align+wk center  //pv value hor alignment center
		
End case 